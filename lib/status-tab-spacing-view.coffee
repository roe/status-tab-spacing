{View} = require 'atom'

module.exports =
class StatusTabSpacingView extends View
  @content: ->
    @div class: 'status-tab-spacing inline-block'

  initialize: (serializeState) ->
    atom.workspaceView.command "status-tab-spacing:toggle", => @toggle()

  destroy: ->
    @detach()

  toggle: ->
    if @hasParent() then @detach() else @attach()

  attach: ->
    statusbar = atom.workspaceView.statusBar
    statusbar.appendLeft this

    @getTabSpacing()

  getTabSpacing: =>
    spaces = atom.config.get('editor.tabLength')
    @text("Spaces: #{spaces}").show()
