LinterJustSayNo =
  grammarScopes: ['source.gfm']
  lintOnFly: true
  matchExpression: null
  scope: 'file'

  buildMatchExpression: ->
    unless @matchExpression
      hedgeWords = atom.config.get 'linter-just-say-no.hedgeWords'
      @matchExpression = new RegExp "\\b#{hedgeWords.join '\\b|\\b'}\\b", 'gi'

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
