path = require 'path'

module.exports =
  activate: (state) ->
    robotGrammar = atom.syntax.getGrammars().filter((grammar) -> grammar.name is 'Robot Framework')[0]

    atom.workspaceView.eachEditorView (editorView) ->
      editor = editorView.getEditor()

      if path.extname(editor.getPath()) is '.txt'
        editor.setGrammar(robotGrammar)
