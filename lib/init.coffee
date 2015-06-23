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
    gjslintStrictMode:
      type: 'boolean'
      default: false
    gjslintClosurizedNamespaces:
      type: 'array'
      default: ['goog']
      items:
        type: 'string'

  activate: ->
    console.log 'activate linter-gjslint'
