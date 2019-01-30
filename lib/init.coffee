{CompositeDisposable} = require 'atom'
{findFile, exec, tempFile} = helpers = require 'atom-linter'
path = require 'path'
XRegExp = require 'xregexp'

module.exports =
  config:
    executablePath:
      type: 'string'
      title: 'gjslint executable path'
      default: 'gjslint'
    gjslintIgnoreList:
      title: 'Google closure-linter error code to ignore'
      description: 'Codes from https://goo.gl/VAdwHE separated by commas.'
      type: 'array'
      default: []
      items:
        type: 'string'
    gjslintCustomJsDocTagsList:
      title: 'Google closure-linter custom JsDoc tags'
      description: 'Add a list of custom JsDoc tags to be accepted by gjslinter, separated by commas.'
      type: 'array'
      default: []
      items:
        type: 'string'
    flags:
      type: 'array'
      default: []
      items:
        type: 'string'
  activate: ->
    require('atom-package-deps').install('linter-gjslint')
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.config.observe 'linter-gjslint.executablePath',
      (executablePath) =>
        @executablePath = executablePath
    @subscriptions.add atom.config.observe 'linter-gjslint.gjslintIgnoreList',
      (gjslintIgnoreList) =>
        @gjslintIgnoreList = gjslintIgnoreList
    @subscriptions.add atom.config.observe 'linter-gjslint.gjslintCustomJsDocTagsList',
      (gjslintCustomJsDocTagsList) =>
        @gjslintCustomJsDocTagsList = gjslintCustomJsDocTagsList
    @subscriptions.add atom.config.observe 'linter-gjslint.flags',
      (flags) =>
        @flags = flags
  deactivate: ->
    @subscriptions.dispose()
  buildMsg: (match, filePath, range) ->
    excerpt = 'E:' + match.code + ' - ' + match.message
    return {
      severity: 'error'
      excerpt: excerpt
      location:
        file: filePath
        position: range
    }

  provideLinter: ->
    helpers = require('atom-linter')
    provider =
      name: 'gjslint'
      grammarScopes: ['source.js', 'source.js.jquery', 'text.html.basic']
      scope: 'file'
      lintsOnChange: true
      lint: (editor) =>
        filePath = editor.getPath()
        cwd = path.dirname(filePath)
        tempFile path.basename(filePath), editor.getText(), (tmpFilePath) =>
          params = @flags || []
          if @gjslintIgnoreList.length != 0
            errorsToDisable = @gjslintIgnoreList.join ','
            params = params.concat ('--disable=' + errorsToDisable)
          if @gjslintCustomJsDocTagsList.length != 0
            jsDocTagsToAllow = @gjslintCustomJsDocTagsList.join ','
            params = params.concat ('--custom_jsdoc_tags=' + jsDocTagsToAllow)
          params = params.concat [
            '--nobeep',
            '--quiet',
            tmpFilePath
          ]
          return helpers.exec(@executablePath, params, {cwd, ignoreExitCode: true}).then (stdout) =>
            regex = XRegExp '^(?<line>\\d+), E:(?<code>[^:]+): (?<message>.+)$',
              's'

            lines = stdout.split(/\nLine\s/)

            return [] unless lines.length

            messages = []

            lines.forEach (msg) =>
              XRegExp.forEach msg, regex, (match, i) =>
                range = helpers.generateRange(editor, match.line - 1)
                messages.push @buildMsg(match, filePath, range)

            return messages
