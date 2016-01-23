LinterJustSayNo =
  grammarScopes: [
    'source.gfm'
    'text.md'
    'text.git-commit'
    'text.html.basic'
    'text.html.erb'
    'text.html.mustache'
    'text.plain.null-grammar'
    'text.plain'
    'text.tex.latex'
    'text.tex'
    'text.todo'
  ]
  lintOnFly: true
  matchExpression: null
  scope: 'file'
  name: 'just-say-no'

  unique: (array) ->
    output = {}
    output[@[key]] = @[key] for key in [0...@length]
    value for key, value of output

  buildMatchExpression: ->
    unless @matchExpression
      if not @hedgeWords
        @loadHedgeWords()
      @matchExpression = new RegExp "\\b#{@hedgeWords.join '\\b|\\b'}\\b", 'gi'

  loadHedgeWords: ->
    # lazy load requirements
    CSON = require 'season'
    path = require 'path'

    o = CSON.readFileSync(path.join __dirname, '..', 'resources', 'hedges.cson')
    @hedgeWords = o['hedges']
    additionalHedgeWords = atom.config.get 'linter-just-say-no.additionalHedgeWords'
    if additionalHedgeWords.length > 0
      @hedgeWords = unique [@hedgeWords..., additionalHedgeWords...]
    excludeHedgeWords = atom.config.get 'linter-just-say-no.excludeHedgeWords'
    if excludeHedgeWords.length > 0
      @hedgeWords = @hedgeWords.filter (word) -> word not in excludeHedgeWords

  lint: (textEditor) ->
    return new Promise (resolve, reject) =>
      @buildMatchExpression()
      matches = []
      textEditor.scan @matchExpression, (match) -> matches.push match
      resolve({
        filePath: textEditor.getPath()
        range: match.range
        text: "Possible hedge word: #{match.matchText}"
        type: 'Info'
      } for match in matches)

module.exports = LinterJustSayNo
