var namedRegexp = require("named-js-regexp");
var fs = require('fs');

var multilineRegExp = function(regs, options) {
    return new RegExp(regs.map(function(reg) {
        return reg.source;
    }).join(''), options);
}

// Used to determine if this is a libdoc xml file
var libdocFileRegexp = /^(.|\r|\n)*?<keywordspec/;

// Matches whole keywords and returns the name and content as groups
var keywordRegexp = namedRegexp(/<kw name="(:<keywordName>[^"]+)">(:<keywordContent>(.|\s)*?)<\/kw>/ig);

// Matches documentation within keyword content
var keywordDocumentationRegexp = namedRegexp(/<doc>(:<documentation>(.|\r|\n)*)<\/doc>/i);

// Matches arguments within keyword content
var keywordArgumentsRegexp = namedRegexp(/<arg>(:<argument>.+?)<\/arg>/g);

/**
 * True/false if file is recognized as xml libdoc or not.
 *
 */
var isLibdoc = function(fileContent){
  return libdocFileRegexp.test(fileContent);
}

/**
 * Parses libdoc xml files.
 * Returns result in this form:
 *  {
 *      "keywords": [
 *          {name: '', documentation: '', arguments: ['', '', ...]},
 *          ...
 *      ],
 *      "hasTestCases": false
 *      "hasKeywords": true/false
 *  }
 */
var parse = function(fileContent) {
    if(!libdocFileRegexp.exec(fileContent)){
        return undefined;
    }
    var keywords = [];
    while(keywordsMatch = keywordRegexp.exec(fileContent)){
        var keywordName = keywordsMatch.group('keywordName');
        var keywordContent = keywordsMatch.group('keywordContent');
        if(documentationMatch = keywordDocumentationRegexp.execGroups(keywordContent)){
            keywordDoc = documentationMatch['documentation'];
        }
        var keywordArgs = [];
        while(argsMatch = keywordArgumentsRegexp.exec(keywordContent)){
            keywordArgs.push(argsMatch.group('argument'));
        }
        keywords.push({
            name: keywordName,
            documentation: keywordDoc,
            arguments: keywordArgs
        });
    }
    return {
        keywords: keywords,
        hasKeywords: keywords.length>0?true:false,
        hasTestCases: false
    };

}


module.exports = {
  parse: parse,
  isLibdoc: isLibdoc
}
