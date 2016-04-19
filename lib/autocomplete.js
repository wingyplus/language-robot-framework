var robotParser = require('./parse-robot');
var libdocParser = require('./parse-libdoc');
var fs = require('fs');
var util = require('util');
var pathUtils = require('path')

// Holds suggestions indexed by file
var allSuggestions = {};

var reset = function(path) {
  if(path){
    for(var key in allSuggestions){
      if(key.indexOf(path)===0){
        delete allSuggestions[key]
      }
    }
  } else{
    allSuggestions = {};
  }
}

var processRobotBuffer = function(bufferContent, path, settings) {
  settings = settings || {};
  ext = pathUtils.extname(path)
  parseData = robotParser.parse(bufferContent);
  var suggestions = [];

  path = pathUtils.normalize(path);
  fileName = pathUtils.basename(path, ext);
  parseData.keywords.forEach(function(keyword) {
    suggestions.push({
      snippet : buildText(keyword),
      displayText : buildDisplayText(keyword, settings),
      type : 'keyword',
      leftLabel : buildLeftLabel(keyword),
      rightLabel : buildRightLabel(keyword, path, fileName),
      description : buildDescription(keyword),
      keyword : keyword,
    })
  });

  allSuggestions[path] = {
    hasTestCases : parseData.hasTestCases,
    suggestions : suggestions,
    fileName : fileName
  }
}


var processLibdocBuffer = function(fileContent, path, settings) {
  settings = settings || {};
  var parsedData = libdocParser.parse(fileContent);
  var suggestions = [];
  path = pathUtils.normalize(path);
  fileName = pathUtils.basename(path, pathUtils.extname(path));
  parsedData.keywords.forEach(function(keyword) {
    suggestions.push({
      snippet : buildText(keyword),
      displayText : buildDisplayText(keyword, settings),
      type : 'keyword',
      leftLabel : buildLeftLabel(keyword),
      rightLabel : buildRightLabel(keyword, path, fileName),
      description : buildDescription(keyword),
      keyword : keyword,
    })
  });

  allSuggestions[path] = {
    hasTestCases : parsedData.hasTestCases,
    suggestions : suggestions,
    fileName : fileName
  }
};

var buildText = function(keyword) {
  var i;
  var argumentsStr = '';
  for (i = 0; i < keyword.arguments.length; i++) {
    var argument = keyword.arguments[i];
    argumentsStr += util.format('    ${%d:%s}', i + 1, argument);
  }

  return keyword.name + argumentsStr;
};

var buildDisplayText = function(keyword, settings) {
  if (settings.showArguments) {
    var i;
    var argumentsStr = '';
    for (i = 0; i < keyword.arguments.length; i++) {
      var argument = keyword.arguments[i];
      argumentsStr += util.format('%s%s', i == 0 ? '' : ', ', argument);
    }

    if (argumentsStr){
      return util.format('%s - %s', keyword.name, argumentsStr);
    } else{
      return keyword.name;
    }
  } else {
    return keyword.name;
  }
};

var buildLeftLabel = function(keyword) {
  return '';
};
var buildRightLabel = function(keyword, path, fileName) {
  return fileName;
};
var buildDescription = function(keyword) {
  return keyword.documentation;
};

var getSuggestions = function(prefix, currentlyEditedPath, settings) {
  prefix = prefix.trim().toLowerCase();
  if (!prefix) {
    return [];
  }
  currentlyEditedPath = pathUtils.normalize(currentlyEditedPath);
  settings = settings || {};
  var suggestions = [];
  var prefixRegexp = createPrefixRegexp(prefix, settings);
  for ( var path in allSuggestions) {
    var currentSuggestions = allSuggestions[path];
    if (currentSuggestions) {
      if (currentlyEditedPath === path || !currentSuggestions.hasTestCases) {
        var fileNameMatch = false;
        if (settings.matchFileName) {
          fileNameMatch = (prefix.indexOf(currentSuggestions.fileName
              .toLowerCase()) === 0);
          var fileNameMatchPrefixRegexp;
          if (fileNameMatch) {
            var newPrefix = prefix.substring(
                currentSuggestions.fileName.length, prefix.length);
            fileNameMatchPrefixRegexp = createPrefixRegexp(newPrefix, settings);
          }
        }
        for (var i = 0; i < currentSuggestions.suggestions.length; i++) {
          var currentSuggestion = currentSuggestions.suggestions[i];

          var match;
          if (fileNameMatch) {
            match = fileNameMatchPrefixRegexp
                .exec(currentSuggestion.keyword.name);
          } else {
            match = prefixRegexp.exec(currentSuggestion.keyword.name)
          }
          if (match) {
            suggestions.push({
              suggestion : currentSuggestion,
              index : match.index,
              matched : match[0].toLowerCase() === prefix,
              currentFile : currentlyEditedPath === path,
              fileNameMatch : fileNameMatch
            });
          }
        }
      }
    }
  }

  suggestions.sort(function(a, b) {
    var scorea = a.index + (a.matched ? 0 : 1) + (a.currentFile ? 0 : 1)
        + (a.fileNameMatch ? 0 : 1);
    var scoreb = b.index + (b.matched ? 0 : 1) + (b.currentFile ? 0 : 1)
        + (b.fileNameMatch ? 0 : 1);
    return scorea - scoreb;
  });

  var result = [];
  suggestions.forEach(function(currentSuggestion) {
    var suggestion = currentSuggestion.suggestion;
    result.push({
      snippet : suggestion.snippet,
      displayText : suggestion.displayText,
      type : suggestion.type,
      leftLabel : suggestion.leftLabel,
      rightLabel : suggestion.rightLabel,
      description : suggestion.description
    });
  });
  return result;
};

var createPrefixRegexp = function(prefix, settings) {
  var prefixRegexpArr = [];
  if (settings.matchPrefixStartOnly) {
    prefixRegexpArr.push('^');
  }
  for (var i = 0; i < prefix.length; i++) {
    prefixRegexpArr.push(escapeRegExp(prefix.charAt(i)))
    prefixRegexpArr.push('(.*?)')
  }
  prefixRegexpArr.push('');
  return new RegExp(prefixRegexpArr.join(''), 'i');

};

// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
function escapeRegExp(string) {
  return string.replace(/[.*+?^${}()|[\]\\]/g, "\\$&"); // $& means the whole
                                                        // matched string
};

function printDebugInfo() {
  var robotFiles = [], libdocFiles = [];
  var ext;
  for(key in allSuggestions){
    ext = pathUtils.extname(key);
    if(ext==='.xml' || ext==='.html'){
      libdocFiles.push(pathUtils.basename(key));
    } else{
      robotFiles.push(pathUtils.basename(key));
    }
  }
  console.log('Autocomplete robot files:' + robotFiles);
  console.log('Autocomplete libdoc files:' + libdocFiles);
  // console.log(JSON.stringify(allSuggestions, null, 2));
}

module.exports = {
  reset : reset,
  processRobotBuffer : processRobotBuffer,
  processLibdocBuffer : processLibdocBuffer,
  getSuggestions : getSuggestions,
  printDebugInfo : printDebugInfo
}
