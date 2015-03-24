linterPath = atom.packages.getLoadedPackage('linter').path
Linter = require "#{linterPath}/lib/linter"
findFile = require "#{linterPath}/lib/util"

class LinterGjslint extends Linter
  # The syntax that the linter handles. May be a string or
  # list/tuple of strings. Names should be all lowercase.
  @syntax: ['source.js', 'source.js.jquery', 'text.html.basic']

  # A string, list, tuple or callable that returns a string, list or tuple,
  # containing the command line (with arguments) used to lint.
  cmd: 'gjslint --nobeep --nosummary'

  linterName: 'gjslint'


  # A regex pattern used to extract information from the executable's output.
  regex:
    'Line (?<line>\\d+), ' +
    '((?<error>E)|(?<warning>W)):\\d+: (?<message>.+?)\n'

  regexFlags: 's'

  constructor: (editor) ->
    super(editor)

    config = findFile(@cwd, ['.gjslintrc'])
    if config
      @cmd += " --flagfile #{config} ~"

    atom.config.observe 'linter-gjslint.gjslintIgnoreList', =>
      ignoreList = atom.config.get 'linter-gjslint.gjslintIgnoreList'
      @cmd += " --disable " + ignoreList.join()

    atom.config.observe 'linter-gjslint.gjslintExecutablePath', =>
      @executablePath = atom.config.get 'linter-gjslint.gjslintExecutablePath'

  destroy: ->
    atom.config.unobserve 'linter-gjslint.gjslintExecutablePath'
    atom.config.unobserve 'linter-gjslint.gjslintIgnoreList'

module.exports = LinterGjslint
