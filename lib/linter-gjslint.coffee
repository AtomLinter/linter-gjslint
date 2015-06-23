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

    @gjslintIgnoreListListener = atom.config.observe 'linter-gjslint.gjslintIgnoreList', =>
      ignoreList = atom.config.get 'linter-gjslint.gjslintIgnoreList'
      if Array.isArray(ignoreList) and ignoreList.length > 0
        @cmd += " --disable " + ignoreList.join()

    @gjslintExecutablePathListener = atom.config.observe 'linter-gjslint.gjslintExecutablePath', =>
      @executablePath = atom.config.get 'linter-gjslint.gjslintExecutablePath'

    @gjslintStrictModeListener = atom.config.observe 'linter-gjslint.gjslintStrictMode', =>
      strictMode = atom.config.get 'linter-gjslint.gjslintStrictMode'
      if strictMode
        @cmd += " --strict "

    @gjslintClosurizedNamespacesListener = atom.config.observe 'linter-gjslint.gjslintClosurizedNamespaces', =>
      closurizedNamespaces = atom.config.get 'linter-gjslint.gjslintClosurizedNamespaces'
      if Array.isArray(closurizedNamespaces) and closurizedNamespaces.length > 0
        @cmd += " --closurized_namespaces " + closurizedNamespaces.join(',')

  destroy: ->
    super
    @gjslintIgnoreListListener.dispose()
    @gjslintExecutablePathListener.dispose()
    @gjslintStrictModeListener.dispose()
    @gjslintClosurizedNamespacesListener.dispose()

module.exports = LinterGjslint
