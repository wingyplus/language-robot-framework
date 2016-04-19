var namedRegexp = require("named-js-regexp");
var fs = require('fs');

var multilineRegExp = function(regs, options) {
    return new RegExp(regs.map(function(reg) {
        return reg.source;
    }).join(''), options);
}


//Used to determine if this is a text robot file
var textRobotFileRegexp = namedRegexp(/^((:<leadingWhiteSpaces>[\s\r\n])|(:<leadingComments>#+[^\r\n]*[\r\n]))*[*]+[ \t]*((Test cases)|(Keywords)|(Variables)|(Settings))[ \t]*[*]*/i);


// Matches whole *** ... *** sections
var middleSectionRegexp1 = namedRegexp(/[\r\n]+?\s?([*]+\s*(:<sectionName>(Test cases)|(Keywords)|(Variables)|(Settings))\s[*]*)/ig); // middle of the file
var firstSectionRegexp = namedRegexp(/^\s?([*]+\s*(:<sectionName>(Test cases)|(Keywords)|(Variables)|(Settings))\s*[*]*)/i); // first section in file


// Given a whole *** Keywords *** or *** Test case *** section, matches the name and content and returns them as groups groups.
var individualKeywordOrTestCaseRegexp = namedRegexp(multilineRegExp([/[\r\n](:<name>([\w\d\\\[\]\/\^\$\*\(\)-_;=~`!@#%&'"{}]+[ ]?)+)/,
                                                           	/(:<content>([\r\n]+[ ]{2,}[^\r\n]*)*)/], 'gi'));

// Matches [Documentation] section
var documentationRegexp = namedRegexp(multilineRegExp([/[ ]{2,}\[Documentation\][ ]{2,}(:<documentation>.*(:<multilineDoc>([\r\n]+[ ]{2,}\.\.\.[ ]{2,}.*)*))/], 'i'));

// Matches '...    ' line-joining so it can be cleaned out.
var cleanMultilineReplaceRegexp = /[\r\n]+[ ]{2,}\.\.\.[ ]{2,}/g;

// Matches [Arguments] section
var argumentsRegexp = namedRegexp(multilineRegExp([/[ ]{2,}\[Arguments\](:<arguments>.*(:<multilineArgs>([\r\n]+[ ]{2,}\.\.\..*)*))/], 'i'));

// Matches ${arguments} globally
var argumentRegexp = namedRegexp(/[$@&]{(:<argument>[\w\d\\\[\]\/\^\$\*\(\)-_;=~`!@#%&'" ]+)}(:<defaultValue>\s*=.*?((  )|$))?/gi);

// Matches tabs
var tabRegexp = /\t/g;

// Matches single line comments
var singleLineCommentRegexp = /#[^\r\n]*/g;

// Matches empty lines
var emptyLineRegexp = /([\r\n])([\s]+[\r\n])/g;

/**
 * Returns sections in form of map - ie: {
 *  "keywords": "content",
 *  "test cases": "content"
 *  "variables": "content"
 *  ...
 *  }
 */
var getSections = function(fileContent){
    var sectionArray = [];
    var firstSection = firstSectionRegexp.exec(fileContent);
    if(firstSection){
        sectionArray.push({
            name: firstSection.group('sectionName'),
            start: firstSection.index,
            end: firstSection.index + firstSection[0].length
        });
    }

    while(match = middleSectionRegexp1.exec(fileContent)){
        sectionArray.push({
            name: match.group('sectionName'),
            start: match.index,
            end: match.index + match[0].length
        });
    }

    var sections = {};
    for (var i = 0; i < sectionArray.length; i++) {
        var currentSection = sectionArray[i];
        var nextSection;
        if(i<sectionArray.length-1){
            nextSection = sectionArray[i+1];
        } else{
            nextSection = {
                    name: undefined,
                    start: fileContent.length,
                    end: fileContent.length
            }
        }

        sections[currentSection.name.toLowerCase()] = fileContent.substring(currentSection.end, nextSection.start);
    }
    return sections;
}

/**
 * True/false if file is recognized as robot or not.
 *
 */
var isRobot = function(fileContent){
  return textRobotFileRegexp.test(fileContent);
}

/**
 * Parses robot text files.
 * Returns result in this form:
 *  {
 *      "testCases": [
 *          {name: '', documentation: ''},
 *          ...
 *      ],
 *      "keywords": [
 *          {name: '', documentation: '', arguments: ['', '', ...]},
 *          ...
 *      ],
 *      "hasTestCases": true/false
 *      "hasKeywords": true/false
 *  }
 */
var parse = function(fileContent) {
    var keywords = [];
    var testCases = [];
    var keywordsMatch;

    // Clean file (remove comments, remove empty lines, replace tabs with spaces, ...)
    fileContent = fileContent.replace(tabRegexp, '  ');
    fileContent = fileContent.replace(singleLineCommentRegexp, '');
    fileContent = fileContent.replace(emptyLineRegexp, '$1');

    var sections = getSections(fileContent);

    var keywordsSection = sections['keywords'];

    if (keywordsSection) {
        keywords = parseKeywordOrTestCase(keywordsSection, true)
    }
    var testCasesSection = sections['test cases'];

    if (testCasesSection) {
        testCases = parseKeywordOrTestCase(testCasesSection, false)
    }
    return {
        keywords: keywords,
        testCases: testCases,
        hasTestCases: testCases.length>0?true:false,
        hasKeywords: keywords.length>0?true:false
    };

}

var parseKeywordOrTestCase = function(section, processArguments){
    var documentation, arguments;
    var name, content;
    var result = [];
    var match;
    while(match = individualKeywordOrTestCaseRegexp.exec(section)){
        name = match.group('name');
        content = match.group('content');
        nameStart = match.index;
        nameEnd = nameStart + name.length;
        contentStart = nameEnd;
        contentEnd = contentStart + content.length;
        documentationMatch = documentationRegexp.execGroups(content);
        documentation = "";
        if(documentationMatch){
            documentation = documentationMatch['documentation'];
            documentation = documentation.replace(cleanMultilineReplaceRegexp, ' ');
        }
        if(processArguments){
            arguments = [];
            argumentsMatch = argumentsRegexp.execGroups(content);
            if(argumentsMatch){
                keywordArgsStr = argumentsMatch['arguments']

                while(argMatch = argumentRegexp.execGroups(keywordArgsStr)){
                    arguments.push(argMatch['argument']);
                }
            }
        } else{
            arguments = undefined
        }

        result.push({
            name: name,
            documentation: documentation,
            arguments: arguments
        });
    }
    return result;
}


module.exports = {
  parse: parse,
  isRobot: isRobot
}
