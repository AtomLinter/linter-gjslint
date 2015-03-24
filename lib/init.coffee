path = require 'path'

module.exports =
  configDefaults:
    gjslintExecutablePath: ''
    gjslintIgnoreList: []

  activate: ->
    console.log 'activate linter-gjslint'
