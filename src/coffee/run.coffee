package_json = require '../package.json'
{ExtendedLogger, ProjectCredentialsConfig} = require 'sphere-node-utils'
FetchResources = require './fetchresources'
DeleteResources = require './deleteresources'

argv = require('optimist')
  .usage('Usage: $0 --projectKey key --clientId id --clientSecret secret')
  .describe('projectKey', 'your SPHERE.IO project-key')
  .describe('clientId', 'your OAuth client id for the SPHERE.IO API')
  .describe('clientSecret', 'your OAuth client secret for the SPHERE.IO API')
  .describe('sphereHost', 'SPHERE.IO API host to connect to')
  .describe('resource', 'Resource which needs to be deleted')
  .describe('deleteHours', 'Number of hours used to select deletable resources (createdAt)')
  .describe('logLevel', 'log level for file logging')
  .describe('logDir', 'directory to store logs')
  .describe('logSilent', 'use console to print messages')
  .default('deleteHours', 1)
  .default('logLevel', 'info')
  .default('logDir', '.')
  .default('logSilent', false)
  .demand(['projectKey'])
  .argv

logOptions =
  name: "#{package_json.name}-#{package_json.version}"
  streams: [
    { level: 'error', stream: process.stderr }
    { level: argv.logLevel, path: "#{argv.logDir}/#{package_json.name}.log" }
  ]
logOptions.silent = argv.logSilent if argv.logSilent
logger = new ExtendedLogger
  additionalFields:
    project_key: argv.projectKey
  logConfig: logOptions
if argv.logSilent
  logger.bunyanLogger.trace = -> # noop
  logger.bunyanLogger.debug = -> # noop

ProjectCredentialsConfig.create()
.then (credentials) =>
  options =
    config: credentials.enrichCredentials
      project_key: argv.projectKey
      client_id: argv.clientId
      client_secret: argv.clientSecret
    user_agent: "#{package_json.name} - #{package_json.version}"
  options.host = argv.sphereHost if argv.sphereHost

  if !argv.resource
    logger.error "Please give a resource to delete."
    process.exit(1)

  fetchResources = new FetchResources logger, options
  deleteResources = new DeleteResources logger, options, argv.resource

  fetchResources.run(argv.resource, argv.deleteHours)
  .then (result) ->
    deleteResources.run(result)
  .catch (err) ->
    logger.error err, "Problems on deleting the whole list."
    process.exit(1)
  .done()
.catch (err) ->
  logger.error err, "Problems on getting client credentials from config files."
  process.exit(1)
.done()