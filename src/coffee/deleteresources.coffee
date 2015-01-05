{SphereClient} = require 'sphere-node-sdk'
Promise = require 'bluebird'

class DeleteResources

  constructor: (logger, options = {}, object) ->
    @client = new SphereClient options
    @resource = object

  run: (result) ->
    console.log "Start deletion of " + result.length() + "items."
    for item in result
      @deleteItem item

  deleteItem: (item) ->
    @client[@resource].byId(item.id).delete(item.version)
    .then (answer) =>
      console.log "The resource " + @resource " with the id " + answer.id + " was deleted."
    .catch (err) ->
      logger.error err, "Problems on deleting on specific item."
      process.exit(1)
    .done()

module.exports = DeleteResources