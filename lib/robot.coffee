{validator} = require './syntax'
provider = require './autocomplete-provider'

isTextFile = (editor) -> validator.isTextFile editor.getPath()

isRobotSyntax = (editor) -> validator.isRobotSyntax editor.getBuffer().getText()

robotSyntax = -> atom.grammars.grammarForScopeName('text.robot')

setRobotSyntax = (editor) -> editor.setGrammar robotSyntax()

pass = -> # do nothing

registerListener = ->
  rules = [isTextFile, isRobotSyntax]

  atom.workspace.observeTextEditors (editor) ->
    promise = new Promise (resolve, reject) ->
      match = rules.every (ruleFn) -> ruleFn(editor)
      if match then resolve(editor) else reject(editor)

    promise.then setRobotSyntax, pass

module.exports =

  provider: -> provider

  activate: (state) ->
    atom.packages.activatePackage('language-robot-framework')
      .then registerListener
