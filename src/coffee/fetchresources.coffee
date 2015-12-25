{SphereClient} = require 'sphere-node-sdk'
Promise = require 'bluebird'

class FetchResources

  constructor: (@logger, options = {}) ->
    @client = new SphereClient options

  run: (resource, hours, id, alltime) ->
    if !id and !alltime
      new Promise (resolve, reject) =>
        @client[resource].all().last("#{hours}h").sort("createdAt", false).fetch()
        .then (resources) ->
          console.log "Fetched Resources: %j", resources.body.results
          resolve resources.body.results
        .catch (err) =>
          @logger.error err, "Problems on fetching the resources."
          reject err
        .done()
    else if alltime
      new Promise (resolve, reject) =>
        @client[resource].all().sort("createdAt", false).fetch()
        .then (resources) ->
          console.log "Fetched Resources: %j", resources.body.results
          resolve resources.body.results
        .catch (err) =>
          @logger.error err, "Problems on fetching the resources."
          reject err
        .done()
    else
      new Promise (resolve, reject) =>
        @client[resource].byId(id).fetch()
        .then (resources) ->
          console.log "Fetched single Resource: %j", resources.body
          resolve resources.body
        .catch (err) =>
          @logger.error err, "Problems on fetching the resources."
          reject err
        .done()

module.exports = FetchResources