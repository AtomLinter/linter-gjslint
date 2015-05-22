module.exports =
  config:
    gjslintExecutablePath:
      type: 'string'
      default: ''
    gjslintIgnoreList:
      type: 'array'
      default: []
      items:
        type: 'string'

  activate: ->
    console.log 'activate linter-gjslint'
