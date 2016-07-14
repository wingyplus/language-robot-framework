xdescribe 'Robot Framework on .txt', ->

  it 'should change grammar to text.robot when first line has robot header', ->
    waitsForPromise ->
      atom.packages.activatePackage 'language-robot-framework'

    workspace = atom.workspace
    [
      '../fixtures/first_line_match/1.txt'
      '../fixtures/first_line_match/2.txt'
      '../fixtures/first_line_match/3.txt'
      '../fixtures/first_line_match/4.txt'
      '../fixtures/first_line_match/5.txt'
      '../fixtures/first_line_match/6.txt'
      '../fixtures/first_line_match/7.txt'
      '../fixtures/first_line_match/8.txt'
    ].forEach (file) ->
      waitsForPromise ->
        workspace.open(file).then (editor) ->
          expect(editor.getGrammar().scopeName).toEqual 'text.robot'
