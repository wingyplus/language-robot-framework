selenium2libraryKeywords = require './autocomplete/selenium-2-library'

module.exports =
  selector: '.text.robot'
  disableForSelector: '.comment.robot'

  getSuggestions: ({editor, bufferPosition, scopeDescriptor, prefix}) ->
    new Promise (resolve) ->
      begin = [bufferPosition.row, 0]
      end = bufferPosition
      word = editor.getTextInBufferRange([begin, end]).trim()

      kw = selenium2libraryKeywords.filter (keyword) ->
        keyword.text.indexOf(word) isnt -1

      resolve(kw)
