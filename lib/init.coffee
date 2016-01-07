LinterJustSayNoProvider = require './linter-just-say-no-provider'

module.exports =
  config:
    additionalHedgeWords:
      type: 'array'
      default: []
      description: 'A comma separated list of additional hedge words or phrases to lookout for'
      items:
        type: 'string'
    excludeHedgeWords:
      type: 'array'
      default: []
      description: 'A comma separated list of words or phrases to ignore'
      items:
        type: 'string'

  activate: ->
    console.log 'activate linter-just-say-no' if atom.inDevMode()
    require('atom-package-deps').install 'linter-just-say-no'

  provideLinter: -> LinterJustSayNoProvider
