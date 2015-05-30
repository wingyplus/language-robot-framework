{validator} = require('../lib/syntax')

describe 'validator', ->

  describe 'validator::isRobotSyntax', ->
    it 'true when has robot framework header block in first line', ->
      blocks = [
        '*** Settings ***',
        '*** settings ***',
        '*** Variables ***',
        '*** variables ***',
        '*** Test Cases ***',
        '*** test cases ***',
        '*** Keywords ***',
        '*** keywords ***',
      ]
      expect(validator.isRobotSyntax block).toBe(true) for block in blocks

    it 'false when empty string', ->
      expect(validator.isRobotSyntax '').toBe(false)

    it 'false when first line is robot framework header block', ->
      expect(validator.isRobotSyntax 'class RobotSyntax').toBe false

  describe 'validator::isTextFile', ->
    it 'true when extension is .txt', ->
      expect(validator.isTextFile 'robot.txt').toBe(true)

    it 'false when extension is not .txt', ->
      expect(validator.isTextFile 'robot.rst').toBe(false)
