RobotSyntaxValidator = require './lib/validator'
{exec} = require 'child_process'

module.exports =
  lint: ->
    file = atom.workspace.getActiveEditor().getPath()
    exec "rflint #{file}" , (err, stdout, stderr) ->
      console.log(err)
      console.log(stdout)
      console.log(stderr)

  activate: (state) ->
    atom.commands.add 'atom-workspace', 'robot-framework:lint', => @lint()

    validator = new RobotSyntaxValidator()
    atom.workspace.getTextEditors()
      .filter((editor) -> return /\.txt$/.test editor.getPath())
      .filter((editor) -> return validator.isRobotSyntax(editor.getBuffer().getText()))
      .forEach (editor) ->
        editor.setGrammar atom.grammars.grammarsByScopeName['text.robot']
