fs = require 'fs'
pathUtils = require 'path'
autocomplete = require './autocomplete'
robotParser = require './parse-robot'
libdocParser = require './parse-libdoc'

MAX_FILE_SIZE = 1024 * 1024
CFG_KEY = 'language-robot-framework.autocomplete'

# Used to avoid multiple concurrent reloadings
scheduleReload = false

isRobotFile = (fileContent, filePath, settings) ->
  ext = pathUtils.extname(filePath)
  if ext == '.robot'
    return true
  if ext in settings.robotExtensions and robotParser.isRobot(fileContent)
    return true
  return false

isLibdocXmlFile = (fileContent, filePath, settings) ->
  ext = pathUtils.extname(filePath)
  return ext is '.xml' and libdocParser.isLibdoc(fileContent)

readdir = (path) ->
  new Promise (resolve, reject) ->
    callback = (err, files) ->
      if err
        reject(err)
      else
        resolve(files)
    fs.readdir(path, callback)


scanDirectory = (path, settings) ->
  return readdir(path).then (result) ->
    promise = Promise.resolve()
    # Chain promises to avoid freezing atom ui
    for name in result
      do (name) ->
        promise = promise.then ->
          stat = fs.lstatSync("#{path}/#{name}")
          return processFile(path, name, stat, settings)
    return promise

processFile = (path, name, stat, settings) ->
  fullPath = "#{path}/#{name}"
  ext = pathUtils.extname(fullPath)
  if stat.isDirectory() and name not in settings.excludeDirectories
    return scanDirectory(fullPath, settings)
  if stat.isFile() and stat.size < settings.maxFileSize
    fileContent = fs.readFileSync(fullPath).toString()
    if isRobotFile(fileContent, fullPath, settings)
      autocomplete.processRobotBuffer(fileContent, fullPath, settings)
      return Promise.resolve()
    if (settings.processLibdocFiles and
    isLibdocXmlFile(fileContent, fullPath, settings))
      autocomplete.processLibdocBuffer(fileContent, fullPath, settings)
      return Promise.resolve()
  return Promise.resolve()

processStandardDefinitionsFile = (standardDefinitionsDir, fileName, settings) ->
  path = pathUtils.join standardDefinitionsDir, fileName
  fileContent = fs.readFileSync(path).toString()
  if isLibdocXmlFile(fileContent, path, settings)
    autocomplete.processLibdocBuffer(fileContent, path, settings)

processStandardDefinitions = (settings) ->
  standardDefinitionsDir = pathUtils.join(__dirname, '../standard-definitions')
  autocomplete.reset(standardDefinitionsDir)
  if settings.suggestBuiltIn
    processStandardDefinitionsFile(standardDefinitionsDir,
    'BuiltIn.xml', settings)
  if settings.suggestCollections
    processStandardDefinitionsFile(standardDefinitionsDir,
    'Collections.xml', settings)
  if settings.suggestDateTime
    processStandardDefinitionsFile(standardDefinitionsDir,
    'DateTime.xml', settings)
  if settings.suggestDialogs
    processStandardDefinitionsFile(standardDefinitionsDir,
    'Dialogs.xml', settings)
  if settings.suggestOperatingSystem
    processStandardDefinitionsFile(standardDefinitionsDir,
    'OperatingSystem.xml', settings)
  if settings.suggestProcess
    processStandardDefinitionsFile(standardDefinitionsDir,
    'Process.xml', settings)
  if settings.suggestScreenshot
    processStandardDefinitionsFile(standardDefinitionsDir,
    'Screenshot.xml', settings)
  if settings.suggestString
    processStandardDefinitionsFile(standardDefinitionsDir,
    'String.xml', settings)
  if settings.suggestTelnet
    processStandardDefinitionsFile(standardDefinitionsDir,
    'Telnet.xml', settings)
  if settings.suggestXML
    processStandardDefinitionsFile(standardDefinitionsDir,
    'XML.xml', settings)

readConfig = ()->
  settings =
    # If true, suggests only if prefix matches start of keyword
    matchPrefixStartOnly: false
    # If true will show only results from the file name specified by prefix
    # (Ie. 'builtinshould' will return all suggestions from BuiltIn library
    # that contain 'should')
    matchFileName: true
    robotExtensions: ['.robot', '.txt']
    # True/false for verbose console output
    debug: undefined
    # Files bigger than this will not be loaded in memory
    maxFileSize: undefined
    # Directories not to be scanned
    excludeDirectories: undefined
    # Shows keyword arguments in suggestions
    showArguments: undefined
    # Process '.xml' files representing libdoc definitions
    processLibdocFiles: undefined
    suggestBuiltIn                 : undefined
    suggestCollections             : undefined
    suggestDateTime                : undefined
    suggestDialogs                 : undefined
    suggestOperatingSystem         : undefined
    suggestProcess                 : undefined
    suggestScreenshot              : undefined
    suggestString                  : undefined
    suggestTelnet                  : undefined
    suggestXML                     : undefined
  provider.settings = settings

  settings.debug =
    atom.config.get("#{CFG_KEY}.debug") || false
  settings.maxFileSize =
    atom.config.get("#{CFG_KEY}.maxFileSize") || MAX_FILE_SIZE
  settings.excludeDirectories =
    atom.config.get("#{CFG_KEY}.excludeDirectories")
  settings.showArguments =
    atom.config.get("#{CFG_KEY}.showArguments")
  settings.processLibdocFiles =
    atom.config.get("#{CFG_KEY}.processLibdocFiles")
  settings.suggestBuiltIn =
    atom.config.get("#{CFG_KEY}.standardLibrary.suggestBuiltIn")
  settings.suggestCollections =
    atom.config.get("#{CFG_KEY}.standardLibrary.suggestCollections")
  settings.suggestDateTime =
    atom.config.get("#{CFG_KEY}.standardLibrary.suggestDateTime")
  settings.suggestDialogs =
    atom.config.get("#{CFG_KEY}.standardLibrary.suggestDialogs")
  settings.suggestOperatingSystem =
    atom.config.get("#{CFG_KEY}.standardLibrary.suggestOperatingSystem")
  settings.suggestProcess =
    atom.config.get("#{CFG_KEY}.standardLibrary.suggestProcess")
  settings.suggestScreenshot =
    atom.config.get("#{CFG_KEY}.standardLibrary.suggestScreenshot")
  settings.suggestString =
    atom.config.get("#{CFG_KEY}.standardLibrary.suggestString")
  settings.suggestTelnet =
    atom.config.get("#{CFG_KEY}.standardLibrary.suggestTelnet")
  settings.suggestXML =
    atom.config.get("#{CFG_KEY}.standardLibrary.suggestXML")


projectDirectoryExists = (filePath) ->
  try
    return fs.statSync(filePath).isDirectory()
  catch err
    return false
fileExists = (filePath) ->
  try
    return fs.statSync(filePath).isFile()
  catch err
    return false

reloadAutocompleteData = ->
  if provider.loading
    console.log  'Schedule loading autocomplete data' if provider.settings.debug
    scheduleReload = true
  else
    console.log  'Loading autocomplete data' if provider.settings.debug
    provider.loading = true
    processStandardDefinitions(provider.settings)
    promise = Promise.resolve()
    # Chain promises to avoid freezing atom ui
    for path of provider.robotProjectPaths when (projectDirectoryExists(path) &&
    provider.robotProjectPaths[path].status == 'project-initial')
      do (path) ->
        projectName = pathUtils.basename(path)
        console.log  "Loading project #{projectName}" if provider.settings.debug
        provider.robotProjectPaths[path].status = 'project-loading'
        autocomplete.reset(path)
        promise = promise.then ->
          return scanDirectory(path, provider.settings).then ->
            if provider.settings.debug
              console.log  "Project #{projectName} loaded"
            provider.robotProjectPaths[path].status = 'project-loaded'
    promise.then ->
      console.log 'Autocomplete data loaded' if provider.settings.debug
      provider.printDebugInfo()  if provider.settings.debug
      provider.loading = false
      if scheduleReload
        scheduleReload = false
        reloadAutocompleteData()
    .catch (error) ->
      console.error
      "Error occurred while reloading robot autocomplete data: #{error}"

      provider.loading = false
      if scheduleReload
        scheduleReload = false
        reloadAutocompleteData()


reloadAutocompleteDataForEditor = (editor, useBuffer, settings) ->
  path = editor.getPath()
  if path and fileExists(path)
    if useBuffer
      fileContent = editor.getBuffer().getText()
    else
      fileContent = fs.readFileSync(path).toString()

    if isRobotFile(fileContent, path, settings)
      autocomplete.processRobotBuffer(fileContent, path, settings)
    else
      autocomplete.reset(path)

updateRobotProjectPathsWhenEditorOpens = (editor, settings) ->
  editorPath = editor.getPath()
  if editorPath
    text = editor.getBuffer().getText()
    ext = pathUtils.extname(editorPath)
    isRobot = isRobotFile(text, editorPath, settings)
    for projectPath in getAtomProjectPathsForEditor(editor)
      if !provider.robotProjectPaths[projectPath] and isRobot
        # New robot project detected
        provider.robotProjectPaths[projectPath] = {status: 'project-initial'}

        reloadAutocompleteData()

getAtomProjectPathsForEditor = (editor) ->
  res = []
  editorPath = editor.getPath()
  for projectDirectory in atom.project.getDirectories()
    if projectDirectory.contains(editorPath)
      res.push(projectDirectory.getPath())
  return res

provider =
  settings : {}
  selector: '.text.robot'
  disableForSelector: '.comment, .variable, .punctuation,'+
  ' .string, .storage, .keyword'
  loading: undefined    # Set to 'true' during autocomplete data async loading
  # List of projects that contain robot files. Initially empty, will be
  # completed once user starts editing files.
  robotProjectPaths: undefined
  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    new Promise (resolve) ->
      path = editor?.buffer.file?.path
      suggestions = autocomplete.getSuggestions(prefix, path, provider.settings)
      resolve(suggestions)
  unload: ->
  load: ->
    @robotProjectPaths = {}
    # Configuration
    readConfig()
    atom.config.onDidChange CFG_KEY,
    ({newValue, oldValue})->
      readConfig()
      for path of provider.robotProjectPaths
        provider.robotProjectPaths[path].status = 'project-initial'
      reloadAutocompleteData()

    # React on editor changes
    atom.workspace.observeTextEditors (editor) ->
      updateRobotProjectPathsWhenEditorOpens(editor, provider.settings)

      editorSaveSubscription = editor.onDidSave (event) ->
        reloadAutocompleteDataForEditor(editor, true, provider.settings)
      editorStopChangingSubscription = editor.onDidStopChanging (event) ->
        reloadAutocompleteDataForEditor(editor, true, provider.settings)
      editorDestroySubscription = editor.onDidDestroy ->
        reloadAutocompleteDataForEditor(editor, false, provider.settings)
        editorSaveSubscription.dispose()
        editorStopChangingSubscription.dispose()
        editorDestroySubscription.dispose()

  printDebugInfo: ->
    autocomplete.printDebugInfo()

module.exports = provider
