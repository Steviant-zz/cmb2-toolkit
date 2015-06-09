Cmb2Toolkit = require '../lib/cmb2-toolkit'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Cmb2Toolkit", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('cmb2-toolkit')

  describe "when the cmb2-toolkit:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.cmb2-toolkit')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'cmb2-toolkit:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.cmb2-toolkit')).toExist()

        cmb2ToolkitElement = workspaceElement.querySelector('.cmb2-toolkit')
        expect(cmb2ToolkitElement).toExist()

        cmb2ToolkitPanel = atom.workspace.panelForItem(cmb2ToolkitElement)
        expect(cmb2ToolkitPanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'cmb2-toolkit:toggle'
        expect(cmb2ToolkitPanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.cmb2-toolkit')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'cmb2-toolkit:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        cmb2ToolkitElement = workspaceElement.querySelector('.cmb2-toolkit')
        expect(cmb2ToolkitElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'cmb2-toolkit:toggle'
        expect(cmb2ToolkitElement).not.toBeVisible()
