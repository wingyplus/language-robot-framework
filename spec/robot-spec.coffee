{WorkspaceView} = require 'atom'
{activate} = require '../lib/robot'

describe 'RobotFramework', ->

  beforeEach ->
    atom.workspaceView = new WorkspaceView

  it 'should be set syntax "Robot Framework" on .txt file extension', ->
    activate()

    waitsForPromise ->
      atom.workspace.open('tests/test_enable_syntax_robot.txt').then (editor) ->
        expect(editor.getGrammar().name).toEqual 'Robot Framework'
