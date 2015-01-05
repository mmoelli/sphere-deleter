{SphereClient} = require 'sphere-node-sdk'
Promise = require 'bluebird'

class FetchResources

  constructor: (logger, options = {}) ->
    @client = new SphereClient options

  run: (resource, hours) ->
    console.log resource + " " + hours
    new Promise (reject, resolve) =>
      @client[resource].all().last("#{hours}h").fetch()
      .then (resources) ->
        console.log "Fetched Resources: " + resources
        resolve resources.body.results
      .catch (err) ->
        logger.error err, "Problems on fetching the resources."
        reject err
      .done()

module.exports = FetchResources