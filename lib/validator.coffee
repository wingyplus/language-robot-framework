class RobotSyntaxValidator
  isRobotSyntax: (content) ->
    /^\*{3}\ (Settings|Variables|Test Cases|Keywords)\ \*{3}/i.test content

module.exports = RobotSyntaxValidator
