provider = require './provider'
module.exports =
  activate: -> provider.load()
  deactivate: -> provider.unload()
  getProvider: -> provider
  config:
    autocomplete:
      type: 'object'
      properties:
        excludeDirectories:
          title: 'Names of directories or files to be excluded from showing '+
          'suggestions (comma sepparated)'
          type: 'array'
          default: []
          items:
            type: 'string'
        showArguments:
          title: 'Show keyword arguments'
          type: 'boolean'
          default: true
        processLibdocFiles:
          title: 'Show suggestions from libdoc definition files'
          type: 'boolean'
          default: true
        standardLibrary:
          title: 'Standard library autocomplete'
          type: 'object'
          properties:
            suggestBuiltIn:
              title: 'Show BuiltIn suggestions'
              type: 'boolean'
              default: true
            suggestCollections:
              title: 'Show Collections suggestions'
              type: 'boolean'
              default: true
            suggestDateTime:
              title: 'Show DateTime suggestions'
              type: 'boolean'
              default: true
            suggestDialogs:
              title: 'Show Dialogs suggestions'
              type: 'boolean'
              default: true
            suggestOperatingSystem:
              title: 'Show OperatingSystem suggestions'
              type: 'boolean'
              default: true
            suggestProcess:
              title: 'Show Process suggestions'
              type: 'boolean'
              default: true
            suggestScreenshot:
              title: 'Show Screenshot suggestions'
              type: 'boolean'
              default: true
            suggestString:
              title: 'Show String suggestions'
              type: 'boolean'
              default: true
            suggestTelnet:
              title: 'Show Telnet suggestions'
              type: 'boolean'
              default: true
            suggestXML:
              title: 'Show XML suggestions'
              type: 'boolean'
              default: true
