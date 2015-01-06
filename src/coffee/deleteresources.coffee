{SphereClient} = require 'sphere-node-sdk'
Promise = require 'bluebird'

class DeleteResources

  constructor: (@logger, options = {}, object) ->
    @client = new SphereClient options
    @resource = object

  run: (result) ->
    if result.length
      console.log "Start deletion of " + result.length + " item(s)."
      for item in result
        @deleteItem item
    else @deleteItem result

  deleteItem: (item) ->
    @client[@resource].byId(item.id).delete(item.version)
    .then (answer) =>
      console.log "One of the " + @resource + " with the id %j", answer.body.id, "was deleted."
    .catch (err) =>
      @logger.error err, "Problems on deleting on specific item."
      process.exit(1)
    .done()

module.exports = DeleteResources