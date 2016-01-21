{$$, SelectListView} = require 'atom-space-pen-views'
{Emitter} = require 'atom'

module.exports =
class TabSpacingSelector extends SelectListView
  initialize: (spacing) ->
    super
    @addClass 'overlay from-top'
    @list.addClass 'mark-active'
    
    @emitter = new Emitter
    
    @currentSpacing = spacing
    
    @setItems ['2 spaces', '4 spaces']
    
    @panel ?= atom.workspace.addModalPanel(item: this)
    @panel.show()
    
    @focusFilterEditor()

  viewForItem: (item) ->
    # change this to proper $$ generation
    element = document.createElement 'li'
    element.classList.add 'active' if parseInt(item) is @currentSpacing
    element.textContent = item
    return element
  
  onConfirmItem: (callback) ->
    @emitter.on 'confirmed-item', callback

  confirmed: (item) ->
    return unless item
    @emitter.emit 'confirmed-item', parseInt(item)
  
  cancelled: ->
    @emitter.emit 'cancelled-selection'
    @destroy()
  
  destroy: ->
    @panel?.destroy()
    @emitter.clear()
