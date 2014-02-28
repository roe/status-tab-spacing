{View} = require 'atom'

module.exports =
class StatusTabSpacingView extends View
  @content: ->
    @div class: 'status-tab-spacing inline-block'

  initialize: ->
    atom.workspaceView.command "status-tab-spacing:toggle", => @toggle()

  destroy: ->
    @detach()

  toggle: ->
    console.log("toggle")
    if @hasParent() then @detach() else @attach()

  attach: ->
    statusbar = atom.workspaceView.statusBar
    statusbar.appendLeft this

    @subscribe atom.config.observe 'editor.tabLength', => @getTabSpacing()

    @getTabSpacing()

  getTabSpacing: =>
    spaces = atom.config.get('editor.tabLength')
    @text("Spaces: #{spaces}").show()
