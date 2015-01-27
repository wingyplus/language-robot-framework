RobotSyntaxValidator = require '../lib/validator'

describe 'RobotSyntaxValidator', ->
  beforeEach ->
    @validator = new RobotSyntaxValidator()


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
    expect(@validator.isRobotSyntax block).toBe(true) for block in blocks

  it 'false when empty string', ->
    expect(@validator.isRobotSyntax '').toBe(false)

  it 'false when first line is robot framework header block', ->
    expect(@validator.isRobotSyntax 'class RobotSyntax').toBe false
