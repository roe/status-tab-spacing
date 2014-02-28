StatusTabSpacingView = require './status-tab-spacing-view'

module.exports =
  statusTabSpacingView: null

  activate: (state) ->
    @statusTabSpacingView = new StatusTabSpacingView(state.statusTabSpacingViewState)

  deactivate: ->
    @statusTabSpacingView.destroy()

  serialize: ->
    statusTabSpacingViewState: @statusTabSpacingView.serialize()
