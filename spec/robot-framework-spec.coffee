describe 'Robot Framework grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-robot-framework')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.robot')

  it 'parse the grammar', ->
    expect(grammar).toBeTruthy()

  it 'tokenizes comments', ->
    {tokens} = grammar.tokenizeLine '# Test Case'

    expect(tokens[0].value).toEqual '#'
    expect(tokens[0].scopes).toEqual ['text.robot', 'comment.robot']
    expect(tokens[1].value).toEqual ' Test Case'
    expect(tokens[1].scopes).toEqual ['text.robot', 'comment.robot']

    {tokens} = grammar.tokenizeLine '# Test Case\n    Step'

    expect(tokens[1].value).toEqual ' Test Case'
    expect(tokens[1].scopes).toEqual ['text.robot', 'comment.robot']
    expect(tokens[2].value).toEqual '\n    Step'
    expect(tokens[2].scopes).toEqual ['text.robot']

    {tokens} = grammar.tokenizeLine '    # Step'

    expect(tokens[0].value).toEqual '    #'
    expect(tokens[0].scopes).toEqual ['text.robot', 'comment.robot']
    expect(tokens[1].value).toEqual ' Step'
    expect(tokens[1].scopes).toEqual ['text.robot', 'comment.robot']

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
