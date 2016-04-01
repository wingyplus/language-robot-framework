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

      expect(tokens[0].value).toEqual '#'
      expect(tokens[0].scopes).toEqual ['text.robot', 'comment.robot']
      expect(tokens[1].value).toEqual ' Test Case'
      expect(tokens[1].scopes).toEqual ['text.robot', 'comment.robot']

    it 'tokenizes when have spaces before comment keyword', ->
      {tokens} = grammar.tokenizeLine '    # Step'

      expect(tokens[0].value).toEqual '    #'
      expect(tokens[0].scopes).toEqual ['text.robot', 'comment.robot']
      expect(tokens[1].value).toEqual ' Step'
      expect(tokens[1].scopes).toEqual ['text.robot', 'comment.robot']

    it 'tokenizes oneline of comment', ->
      {tokens} = grammar.tokenizeLine '# Test Case\n    Step'

      expect(tokens[1].value).toEqual ' Test Case'
      expect(tokens[1].scopes).toEqual ['text.robot', 'comment.robot']
      expect(tokens[2].value).toEqual '\n    Step'
      expect(tokens[2].scopes).toEqual ['text.robot']

    it 'does not tokenizes comment', ->
      {tokens} = grammar.tokenizeLine '    This is step    #id'

      expect(tokens[0].value).toEqual '    This is step    #id'
      expect(tokens[0].scopes).toEqual ['text.robot']

  describe 'variable', ->

    describe 'scalar', ->

      it 'tokenizes variable', ->
        {tokens} = grammar.tokenizeLine '${var}'

        expect(tokens[0].scopes).toEqual [
          'text.robot',
          'variable.language.robot'
        ]

      it 'tokenizes variable in step keyword', ->
        {tokens} = grammar.tokenizeLine '   Do Some ${var} Keyword'

        expect(tokens[1].value).toEqual '${var}'

    describe 'list', ->

      it 'tokenizes variable', ->
        {tokens} = grammar.tokenizeLine '@{list_var}'

        expect(tokens[0].scopes).toEqual [
          'text.robot',
          'variable.language.robot'
        ]

      it 'tokenizes variable in step keyword', ->
        {tokens} = grammar.tokenizeLine '   Do Some @{list_var} Keyword'

        expect(tokens[1].value).toEqual '@{list_var}'

    describe 'dictionary', ->

      it 'tokenizes variable', ->
        {tokens} = grammar.tokenizeLine '&{dict_var}'

        expect(tokens[0].scopes).toEqual [
          'text.robot',
          'variable.language.robot'
        ]

      it 'tokenizes variable in step keyword', ->
        {tokens} = grammar.tokenizeLine '   Do Some &{dict_var} Keyword'

        expect(tokens[1].value).toEqual '&{dict_var}'

  describe 'bdd style', ->

    expectedScopes = ['text.robot', 'keyword.control.robot']

    it 'tokenizes Given', ->
      {tokens} = grammar.tokenizeLine '    Given Do Something'

      expect(tokens[0].scopes).toEqual expectedScopes
      expect(tokens[0].value).toEqual '    Given'

    it 'tokenizes When', ->
      {tokens} = grammar.tokenizeLine '    When Do Something'

      expect(tokens[0].scopes).toEqual expectedScopes
      expect(tokens[0].value).toEqual '    When'

    it 'tokenizes Then', ->
      {tokens} = grammar.tokenizeLine '    Then Do Something'

      expect(tokens[0].scopes).toEqual expectedScopes
      expect(tokens[0].value).toEqual '    Then'

    it 'tokenizes And', ->
      {tokens} = grammar.tokenizeLine '    And Do Something'

      expect(tokens[0].scopes).toEqual expectedScopes
      expect(tokens[0].value).toEqual '    And'

    it 'tokenizes But', ->
      {tokens} = grammar.tokenizeLine '    But Do Something'

      expect(tokens[0].scopes).toEqual expectedScopes
      expect(tokens[0].value).toEqual '    But'

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

  describe 'tag', ->
    it 'tokenizes [<TagName>]', ->
      {tokens} = grammar.tokenizeLine '  [Documentation]'
      expect(tokens.length).toEqual(2)
      expect(tokens[1].value).toEqual '[Documentation]'
      expect(tokens[1].scopes).toEqual ['text.robot', 'entity.tag.name.robot']
