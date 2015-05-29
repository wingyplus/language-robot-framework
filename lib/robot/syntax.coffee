class SyntaxValidator
  isRobotSyntax: (content) ->
    /^\*{3}\ (Settings|Variables|Test Cases|Keywords)\ \*{3}/i.test content

  isTextFile: (path) ->
    /\.txt$/.test path

module.exports =
  validator: new SyntaxValidator()
