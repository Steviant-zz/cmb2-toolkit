Cmb2ToolkitView = require './cmb2-toolkit-view'
{CompositeDisposable} = require 'atom'

module.exports = Cmb2Toolkit =
  cmb2ToolkitView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @cmb2ToolkitView = new Cmb2ToolkitView(state.cmb2ToolkitViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @cmb2ToolkitView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'cmb2-toolkit:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @cmb2ToolkitView.destroy()

  serialize: ->
    cmb2ToolkitViewState: @cmb2ToolkitView.serialize()

  toggle: ->
    console.log 'Cmb2Toolkit was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
