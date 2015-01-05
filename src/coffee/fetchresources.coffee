{SphereClient} = require 'sphere-node-sdk'
Promise = require 'bluebird'

class FetchResources

  constructor: (@logger, options = {}) ->
    @client = new SphereClient options

  run: (resource, hours) ->
    new Promise (resolve, reject) =>
      @client[resource].all().last("#{hours}h").fetch()
      .then (resources) ->
        console.log "Fetched Resources: %j", resources.body.results
        resolve resources.body.results
      .catch (err) =>
        @logger.error err, "Problems on fetching the resources."
        reject err
      .done()

module.exports = FetchResources