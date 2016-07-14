path = require 'path'
grammarTest = require 'atom-grammar-test'

describe 'Robot Framework grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-robot-framework')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.robot')

  it 'parse the grammar', ->
    expect(grammar).toBeTruthy()

  describe 'comment', ->
    it "tokenizes when comment keyword is at the start of line", ->
      {tokens} = grammar.tokenizeLine '# Test Case'

      expect(tokens[0].value).toEqual '# Test Case'
      expect(tokens[0].scopes).toEqual ['text.robot', 'comment.line.robot']

    it 'tokenizes when have spaces before comment keyword', ->
      {tokens} = grammar.tokenizeLine '    # Step'

      expect(tokens[0].value).toEqual '    '
      expect(tokens[1].value).toEqual '# Step'
      expect(tokens[1].scopes).toEqual ['text.robot', 'comment.line.robot']

    it 'tokenizes oneline of comment', ->
      {tokens} = grammar.tokenizeLine '# Test Case\n    Step'

      expect(tokens[0].value).toEqual '# Test Case'
      expect(tokens[0].scopes).toEqual ['text.robot', 'comment.line.robot']
      expect(tokens[1].value).toEqual '\n    Step'
      expect(tokens[1].scopes).toEqual ['text.robot']

    it 'does not tokenizes comment', ->
      {tokens} = grammar.tokenizeLine '    This is step    #id'

      expect(tokens[0].value).toEqual '    This is step    #id'
      expect(tokens[0].scopes).toEqual ['text.robot']

  describe 'variable', ->

    describe 'captures', ->
      tokens = null

      beforeEach -> {tokens} = grammar.tokenizeLine '${var}'

      afterEach -> tokens = null

      it 'tokenizes ${ as a begin punctuation', ->
        expect(tokens[0].value).toEqual '${'
        expect(tokens[0].scopes).toEqual [
          'text.robot',
          'punctuation.section.embedded.begin.robot',
          'text.robot'
        ]

      it 'tokenizes var as a robot variable', ->
        expect(tokens[1].value).toEqual 'var'
        expect(tokens[1].scopes).toEqual [
          'text.robot',
          'variable.control.robot'
        ]

      it 'tokenizes } as a end punctuation', ->
        expect(tokens[2].value).toEqual '}'
        expect(tokens[2].scopes).toEqual [
          'text.robot',
          'punctuation.section.embedded.end.robot',
          'text.robot'
        ]

    describe 'list', ->

      it 'tokenizes @{ as a begin punctuation', ->
        {tokens} = grammar.tokenizeLine '@{var}'
        expect(tokens[0].value).toEqual '@{'
        expect(tokens[0].scopes).toEqual [
          'text.robot',
          'punctuation.section.embedded.begin.robot',
          'text.robot'
        ]

    describe 'dict', ->

      it 'tokenizes &{ as a begin punctuation', ->
        {tokens} = grammar.tokenizeLine '&{var}'
        expect(tokens[0].value).toEqual '&{'
        expect(tokens[0].scopes).toEqual [
          'text.robot',
          'punctuation.section.embedded.begin.robot',
          'text.robot'
        ]

  describe 'bdd style', ->

    expectedScopes = ['text.robot', 'keyword.control.robot']

    it 'tokenizes Given', ->
      {tokens} = grammar.tokenizeLine '    Given Do Something'

      expect(tokens[1].scopes).toEqual expectedScopes
      expect(tokens[1].value).toEqual 'Given'

    it 'tokenizes When', ->
      {tokens} = grammar.tokenizeLine '    When Do Something'

      expect(tokens[1].scopes).toEqual expectedScopes
      expect(tokens[1].value).toEqual 'When'

    it 'tokenizes Then', ->
      {tokens} = grammar.tokenizeLine '    Then Do Something'

      expect(tokens[1].scopes).toEqual expectedScopes
      expect(tokens[1].value).toEqual 'Then'

    it 'tokenizes And', ->
      {tokens} = grammar.tokenizeLine '    And Do Something'

      expect(tokens[1].scopes).toEqual expectedScopes
      expect(tokens[1].value).toEqual 'And'

    it 'tokenizes But', ->
      {tokens} = grammar.tokenizeLine '    But Do Something'

      expect(tokens[1].scopes).toEqual expectedScopes
      expect(tokens[1].value).toEqual 'But'

    describe 'issue 12', ->

      it "should tokenizes 'And' when it isn't at the start of a keyword", ->
        {tokens} = grammar.tokenizeLine '    Press And Hold The Button'

        expect(tokens.length).toEqual 1
        expect(tokens[0].value).toEqual '    Press And Hold The Button'

  describe 'testcase', ->

    it 'tokenizes as a keyword.control.robot', ->
      samples = [
        'Do',
        'Do Something',
        'Do 9',
        'Do "something"'
      ].forEach (line) ->
        {tokens} = grammar.tokenizeLine line

        expect(tokens.length).toEqual 1
        expect(tokens[0].value).toEqual line
        expect(tokens[0].scopes).toEqual ['text.robot', 'keyword.control.robot']

    it 'tokenizes variable in keyword', ->
      {tokens} = grammar.tokenizeLine 'Test Keyword ${myvar}'

      expect(tokens.length).toEqual 4
      expect(tokens[0].value).toEqual 'Test Keyword '
      expect(tokens[0].scopes).toEqual ['text.robot', 'keyword.control.robot']

      expect(tokens[1].value).toEqual '${'
      expect(tokens[1].scopes).toEqual [
        'text.robot',
        'keyword.control.robot',
        'punctuation.section.embedded.begin.robot',
        'text.robot'
      ]

      expect(tokens[2].value).toEqual 'myvar'
      expect(tokens[2].scopes).toEqual [
        'text.robot',
        'keyword.control.robot',
        'variable.control.robot'
      ]

      expect(tokens[3].value).toEqual '}'
      expect(tokens[3].scopes).toEqual [
        'text.robot',
        'keyword.control.robot',
        'punctuation.section.embedded.end.robot',
        'text.robot'
      ]

      {tokens} = grammar.tokenizeLine 'Test Keyword ${myvar} Awesome'

      expect(tokens[0].value).toEqual 'Test Keyword '
      expect(tokens[1].value).toEqual '${'
      expect(tokens[2].value).toEqual 'myvar'
      expect(tokens[3].value).toEqual '}'
      expect(tokens[4].value).toEqual ' Awesome'
      expect(tokens[4].scopes).toEqual ['text.robot', 'keyword.control.robot']


  describe 'tag', ->
    it 'tokenizes [<TagName>]', ->
      {tokens} = grammar.tokenizeLine '  [Documentation]'
      expect(tokens.length).toEqual(2)
      expect(tokens[1].value).toEqual '[Documentation]'
      expect(tokens[1].scopes).toEqual [
        'text.robot', 'entity.tag.name.robot', 'text.robot']

    it 'does not tokenizes css selector', ->
      {tokens} = grammar.tokenizeLine '  Somebody  css=input[name=value]'
      expect(tokens.length).toEqual(1)
      expect(tokens[0].value).toEqual '  Somebody  css=input[name=value]'
      expect(tokens[0].scopes).toEqual ['text.robot']

  grammarTest(
    path.join(__dirname, "fixtures", "test_separate_keyword_and_value.robot"))
