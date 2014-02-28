StatusTabSpacing = require '../lib/status-tab-spacing'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "StatusTabSpacing", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('statusTabSpacing')

  describe "when the status-tab-spacing:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.status-tab-spacing')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'status-tab-spacing:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.status-tab-spacing')).toExist()
        atom.workspaceView.trigger 'status-tab-spacing:toggle'
        expect(atom.workspaceView.find('.status-tab-spacing')).not.toExist()
