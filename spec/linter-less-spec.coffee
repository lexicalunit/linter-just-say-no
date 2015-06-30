LinterJustSayNoProvider = require '../lib/linter-just-say-no-provider'

describe 'Lint Markdown', ->
  beforeEach ->
    waitsForPromise -> atom.packages.activatePackage 'linter-just-say-no'

  describe 'Hedge Words', ->
    it 'finds 16 hedge words in "hedgy.md"', ->
      waitsForPromise ->
        atom.workspace.open('./files/hedgy.md')
          .then (editor) -> LinterJustSayNoProvider.lint editor
          .then (messages) ->
            expect(messages.length).toEqual 16
            expect(messages[0].text).toEqual("Possible hedge word: Sorry")
            expect(messages[0].range).toEqual([[0, 0], [0, 5]])
