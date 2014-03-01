{$$, SelectListView} = require 'atom'

module.exports =
class TabSpacingSelector extends SelectListView
  initialize: ->
    super
    @addClass 'overlay from-top'
    @list.addClass 'mark-active'

    @currentSpacing = atom.config.get 'editor.tabLength'
    @subscribe atom.config.observe 'editor.tabLength', => @currentSpacing = atom.config.get 'editor.tabLength'

    @setItems ['2 spaces', '4 spaces']
    atom.workspaceView.append this
    @focusFilterEditor()

  viewForItem: (item) ->
    element = document.createElement 'li'
    element.classList.add 'active' if parseInt(item) is @currentSpacing
    element.textContent = item
    element

  confirmed: (item) ->
    @cancel()
    return unless item
    atom.config.set 'editor.tabLength', parseInt item
