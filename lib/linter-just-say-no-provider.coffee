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
