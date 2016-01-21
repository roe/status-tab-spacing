StatusTabSpacingView = require './status-tab-spacing-view'
TabSpacingSelector = require './tab-spacing-selector'

module.exports =
  tabSpacing: 2 # this will get updated to reflect the currently active editor
  
  activate: (state) ->
    # create and update the view element
    @statusTabSpacingView = new StatusTabSpacingView()
    @update atom.workspace.getActivePaneItem()
    
    # Add event listeners
    atom.workspace.onDidStopChangingActivePaneItem () => @update()
    @statusTabSpacingView.onDidRequestSelector () => @select()
    
    # Register commands
    atom.commands.add 'atom-workspace',
      'editor:set-tab-spacing': (event) => @select()

  # Update the status based on the current pane item
  update: (item) ->
    @tabSpacing = atom.workspace.getActiveTextEditor().getTabLength()
    
    # pass the info down to the view to be displayed
    @statusTabSpacingView?.display(@tabSpacing)

  # Write the current status to the editor
  setTabSpacing: (item, spacing) ->
    @tabSpacing = spacing
    return unless atom.workspace.isTextEditor(item)
    
    atom.workspace.getActiveTextEditor().setTabLength(@tabSpacing)
    @statusTabSpacingView?.display(@tabSpacing)

  select: ->
    # Instantiate the selector
    @selectorDialog = new TabSpacingSelector @tabSpacing
    
    # subscribing to its event
    @selectorDialog.onConfirmItem (spacing) =>
      @selectorDialog.destroy()
      @setTabSpacing atom.workspace.getActivePaneItem(), spacing
      atom.workspace.activatePreviousPane()

  consumeStatusBar: (statusBar) ->
    # Add the element to the status bar
    @statusBarTile = statusBar.addRightTile(item: @statusTabSpacingView, priority: 100)

  deactivate: ->
    # clean up
    @statusTabSpacingView?.destroy()
    @statusTabSpacingView = null
    @selectorDialog?.destroy()
    @selectorDialog = null
