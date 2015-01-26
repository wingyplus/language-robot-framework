RobotSyntaxValidator = require './lib/validator'

module.exports =
  activate: (state) ->
    validator = new RobotSyntaxValidator()
    atom.workspace.getTextEditors()
      .filter((editor) -> return /\.txt$/.test editor.getPath())
      .filter((editor) -> return validator.isRobotSyntax(editor.getBuffer().getText()))
      .forEach (editor) ->
        editor.setGrammar atom.grammars.grammarsByScopeName['text.robot']
