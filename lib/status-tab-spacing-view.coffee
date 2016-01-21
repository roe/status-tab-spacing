{View} = require 'atom-space-pen-views'
{Emitter} = require 'atom'

module.exports =
class StatusTabSpacingView extends View
  @content: ->
    @a class: 'status-tab-spacing inline-block'

  initialize: ->
    @emitter = new Emitter
    
    @click (event) =>
      @emitter.emit 'request-selector'
  
  onDidRequestSelector: (callback)->
    @emitter.on 'request-selector', callback

  destroy: ->
    @emitter.clear()
    @detach()
  
  display: (spacing) ->
    @html("Spaces: #{spacing}")
