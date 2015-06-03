from robot.libdocpkg.robotbuilder import LibraryDocBuilder

builder = LibraryDocBuilder()
keywords = builder.build('Selenium2Library').keywords


def snippet_argument(arg):
    return "${%d:%s}" % (arg[0], arg[1])


print('module.exports = [')

for keyword in keywords:
    args = map(snippet_argument,
        [(i+1, arg) for i, arg in enumerate(keyword.args)])
    snippet = '  '.join([keyword.name] + args)

    print("""  {
    text: '%s'
    snippet: '%s'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }""" % (keyword.name, snippet))

print(']')
