{CompositeDisposable} = require 'atom'
{findFile, exec, tempFile} = helpers = require 'atom-linter'

module.exports =
  config:
    executablePath:
      type: 'string'
      title: 'gjslint executable path'
      default: '/usr/local/bin/gjslint'
    gjslintIgnoreList:
      type: 'array'
      default: []
      items:
        type: 'string'

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.config.observe 'linter-gjslint.executablePath',
      (executablePath) =>
        @executablePath = executablePath
    console.log 'activate linter-gjslint'
  deactivate: ->
    @subscriptions.dispose()
  provideLinter: ->
    helpers = require('atom-linter')
    provider =
      name: 'gjslint'
      grammarScopes: ['source.js', 'source.js.jquery', 'text.html.basic']
      scope: 'file'
      lintOnFly: true
      lint: (editor) =>
        filePath = editor.getPath()
        cwd = path.dirname(filePath)
        tempFile path.basename(filePath), editor.getText(), (tmpFilePath) =>
          params = [
            '--nobeep',
            '--quiet',
            tmpFilePath
          ]
          return helpers.exec(@executablePath, params, {cwd}).then (stdout) ->
            regex = /^Line\s(\d*)\, E\:(\d*):\s(.*)$/
            lines = stdout.split('\n').filter (line) ->
              line.indexOf('Line') == 0

            return [] unless lines.length
            return lines.map (msg) ->
              res = regex.exec(msg)
              console.log(msg, res)
              [all, line, code, text] = res
              line = parseInt(line, 10)
              return {
                text: text,
                type: 'error',
                filePath: filePath,
                range: [
                  [line - 1, 0],
                  [line - 1, 1]
                ]
              }
