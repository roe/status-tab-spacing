{View} = require 'atom'
TabSpacingSelector = require './tab-spacing-selector'

module.exports =
class StatusTabSpacingView extends View
  @content: ->
    @div class: 'status-tab-spacing inline-block'

  initialize: ->
    atom.workspaceView.command "status-tab-spacing:toggle", => @toggle()
    atom.workspaceView.command "editor:set-tab-spacing", => @setTabSpacing()

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

  getTabSpacing: ->
    spaces = atom.config.get('editor.tabLength')
    @text("Spaces: #{spaces}").show().on 'click', @setTabSpacing

  setTabSpacing: ->
    new TabSpacingSelector()
