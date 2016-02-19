robotParser = require('../lib/parse-robot')
libdocParser = require('../lib/parse-libdoc')
fs = require 'fs'

# Credits - https://raw.githubusercontent.com/atom/autocomplete-atom-api/master/spec/provider-spec.coffee
getCompletions = (editor, provider)->
  cursor = editor.getLastCursor()
  start = cursor.getBeginningOfCurrentWordBufferPosition()
  end = cursor.getBufferPosition()
  prefix = editor.getTextInRange([start, end])
  request =
    editor: editor
    bufferPosition: end
    scopeDescriptor: cursor.getScopeDescriptor()
    prefix: prefix
  provider.getSuggestions(request)


describe "Robot Framework keywords autocompletions", ->
  [editor, provider] = []
  beforeEach ->
    waitsForPromise -> atom.packages.activatePackage('language-robot-framework')
    runs ->
      provider = atom.packages.getActivePackage('language-robot-framework').mainModule.getProvider()
    waitsForPromise -> atom.workspace.open('autocomplete/test_autocomplete_keywords.robot')
    waitsFor ->
      return !provider.loading
    , 'Provider should finish loading', 500
    runs ->
      editor = atom.workspace.getActiveTextEditor()

  it 'suggest standard keywords', ->
    editor.setCursorBufferPosition([Infinity, Infinity])
    editor.insertText(' callm')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toEqual(1)
        expect(suggestions[0].displayText).toEqual('Call Method - object, method_name, *args, **kwargs')
  it 'suggest keywords in current editor', ->
    editor.setCursorBufferPosition([Infinity, Infinity])
    editor.insertText(' runprog')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toEqual(1)
        expect(suggestions[0]?.displayText).toEqual('Run Program - args')
  it 'suggest all keywords from that file when prefix is identical with file name', ->
    editor.setCursorBufferPosition([Infinity, Infinity])
    editor.insertText(' fileprefix')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toEqual(2)
        expect(suggestions[0]?.displayText).toEqual('File keyword 1')
        expect(suggestions[1]?.displayText).toEqual('File keyword 2')
  it 'show documentation in suggestions', ->
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' withdoc')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toEqual(2)
        expect(suggestions[0]?.displayText).toEqual('With documentation')
        expect(suggestions[0]?.description).toEqual('documentation')
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' withoutdoc')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toBeGreaterThan(0)
        expect(suggestions[0]?.displayText).toEqual('Without documentation')
        expect(suggestions[0]?.description).toEqual('')
  it 'show arguments in suggestions', ->
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' witharg')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toBeGreaterThan(0)
        expect(suggestions[0]?.displayText).toEqual('With arguments - arg1, arg2, arg3')
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' withoutarg')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toBeGreaterThan(0)
        expect(suggestions[0]?.displayText).toEqual('Without arguments')
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' withdefarg')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toBeGreaterThan(0)
        expect(suggestions[0]?.displayText).toEqual('With default value arguments - arg1, arg2, arg3, arg4, arg5, arg6')
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' withembed')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toBeGreaterThan(0)
        expect(suggestions[0]?.displayText).toEqual('With ${embedded} arguments')

describe 'Autocomplete suggestion order', ->
  [editor, provider] = []
  beforeEach ->
    waitsForPromise -> atom.packages.activatePackage('language-robot-framework')
    runs ->
      provider = atom.packages.getActivePackage('language-robot-framework').mainModule.getProvider()
    waitsForPromise -> atom.workspace.open('autocomplete/test_autocomplete_keywords.robot')
    waitsFor ->
      return !provider.loading
    , 'Provider should finish loading', 500
    runs ->
      editor = atom.workspace.getActiveTextEditor()

  it 'show suggestions from current editor first', ->
    editor.setCursorBufferPosition([Infinity, Infinity])
    editor.insertText(' run')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toBeGreaterThan(2)
        expect(suggestions[0]?.displayText).toEqual('Run Program - args')

describe 'Autocomplete configuration', ->
  [editor, provider] = []
  beforeEach ->
    waitsForPromise -> atom.packages.activatePackage('language-robot-framework')
    runs ->
      provider = atom.packages.getActivePackage('language-robot-framework').mainModule.getProvider()
    waitsForPromise -> atom.workspace.open('autocomplete/test_autocomplete_keywords.robot')
    waitsFor ->
      return !provider.loading
    , 'Provider should finish loading', 500
    runs ->
      editor = atom.workspace.getActiveTextEditor()

  it 'react on showArguments configuration changes', ->
    runs ->
      atom.config.set('language-robot-framework.autocomplete.showArguments', true)
    waitsFor ->
      return !provider.loading
    , 'Provider should finish loading', 500
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' runprog')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toEqual(1)
        expect(suggestions[0]?.displayText).toEqual('Run Program - args')
    runs ->
      atom.config.set('language-robot-framework.autocomplete.showArguments', false)
    waitsFor ->
      return !provider.loading
    , 'Provider should finish loading', 500
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' runprog')
    waitsForPromise ->
      getCompletions(editor, provider).then (suggestions) ->
        expect(suggestions.length).toEqual(1)
        expect(suggestions[0]?.displayText).toEqual('Run Program')
  it 'react on excludeDirectories configuration changes', ->
    runs ->
      atom.config.set('language-robot-framework.autocomplete.excludeDirectories', [])
    waitsFor ->
      return !provider.loading
    , 'Provider should finish loading', 500
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' runprog')
      waitsForPromise ->
        getCompletions(editor, provider).then (suggestions) ->
          expect(suggestions.length).toEqual(1)
          expect(suggestions[0]?.displayText).toEqual('Run Program - args')
    runs ->
      atom.config.set('language-robot-framework.autocomplete.excludeDirectories', ['autocomplete'])
    waitsFor ->
      return !provider.loading
    , 'Provider should finish loading', 500
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' runprog')
      waitsForPromise ->
        getCompletions(editor, provider).then (suggestions) ->
          expect(suggestions.length).toEqual(0)
  it 'react on standardLibrary configuration changes', ->
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' callm')
      waitsForPromise ->
        getCompletions(editor, provider).then (suggestions) ->
          expect(suggestions.length).toEqual(1)
          expect(suggestions[0].displayText).toEqual('Call Method - object, method_name, *args, **kwargs')
    runs ->
      atom.config.set('language-robot-framework.autocomplete.standardLibrary.suggestBuiltIn', false)
    waitsFor ->
      return !provider.loading
    , 'Provider should finish loading', 500
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' callm')
      waitsForPromise ->
        getCompletions(editor, provider).then (suggestions) ->
          expect(suggestions.length).toEqual(0)
  it 'react on processLibdocFiles configuration changes', ->
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' autocompletelibdoc')
      waitsForPromise ->
        getCompletions(editor, provider).then (suggestions) ->
          expect(suggestions.length).toEqual(1)
          expect(suggestions[0].displayText).toEqual('Autocomplete libdoc test - arg1, arg2')
    runs ->
      atom.config.set('language-robot-framework.autocomplete.processLibdocFiles', false)
    waitsFor ->
      return !provider.loading
    , 'Provider should finish loading', 500
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' autocompletelibdoc')
      waitsForPromise ->
        getCompletions(editor, provider).then (suggestions) ->
          expect(suggestions.length).toEqual(0)
  it 'react on maxFileSize configuration changes', ->
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' filesizelimit')
      waitsForPromise ->
        getCompletions(editor, provider).then (suggestions) ->
          expect(suggestions.length).toEqual(1)
          expect(suggestions[0].displayText).toEqual('File Size Limit')
    runs ->
      atom.config.set('language-robot-framework.autocomplete.maxFileSize', 39)
    waitsFor ->
      return !provider.loading
    , 'Provider should finish loading', 500
    runs ->
      editor.setCursorBufferPosition([Infinity, Infinity])
      editor.insertText(' filesizelimit')
      waitsForPromise ->
        getCompletions(editor, provider).then (suggestions) ->
          expect(suggestions.length).toEqual(0)

describe "Robot file detection", ->
  it 'should detect correct robot files', ->
    fixturePath = "#{__dirname}/../fixtures/autocomplete/detectRobot"

    content = fs.readFileSync("#{fixturePath}/detect-ok1.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(true);

    content = fs.readFileSync("#{fixturePath}/detect-ok2.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(true);

    content = fs.readFileSync("#{fixturePath}/detect-ok3.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(true);

    content = fs.readFileSync("#{fixturePath}/detect-ok4.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(true);

    content = fs.readFileSync("#{fixturePath}/detect-ok5.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(true);

    content = fs.readFileSync("#{fixturePath}/detect-ok6.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(true);

    content = fs.readFileSync("#{fixturePath}/detect-ok7.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(true);

  it 'should detect incorrect robot files', ->
    fixturePath = "#{__dirname}/../fixtures/autocomplete/detectRobot"

    content = fs.readFileSync("#{fixturePath}/detect-wrong1.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(false);

    content = fs.readFileSync("#{fixturePath}/detect-wrong2.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(false);

    content = fs.readFileSync("#{fixturePath}/detect-wrong3.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(false);

    content = fs.readFileSync("#{fixturePath}/detect-wrong4.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(false);

    content = fs.readFileSync("#{fixturePath}/detect-wrong5.robot").toString()
    isRobot = robotParser.isRobot(content)
    expect(isRobot).toBe(false);

describe "Libdoc xml file detection", ->
  it 'should detect correct libdoc xml files', ->
    fixturePath = "#{__dirname}/../fixtures/autocomplete/detectLibdocXml"

    content = fs.readFileSync("#{fixturePath}/libdoc-ok.xml").toString()
    isLibdoc = libdocParser.isLibdoc(content)
    expect(isLibdoc).toBe(true);
  it 'should detect incorrect libdoc xml files', ->
    fixturePath = "#{__dirname}/../fixtures/autocomplete/detectLibdocXml"

    content = fs.readFileSync("#{fixturePath}/libdoc-wrong.xml").toString()
    isLibdoc = libdocParser.isLibdoc(content)
    expect(isLibdoc).toBe(false);
