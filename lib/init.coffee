path = require 'path'

module.exports =
  configDefaults:
    gjslintExecutablePath: ''

  activate: ->
    console.log 'activate linter-gjslint'
