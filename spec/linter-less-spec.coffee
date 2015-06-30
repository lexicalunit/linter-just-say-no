LinterJustSayNoProvider = require '../lib/linter-just-say-no-provider'

describe 'Lint Just Say No', ->
  beforeEach ->
    waitsForPromise -> atom.packages.activatePackage 'linter-just-say-no'

  describe 'finds all hedge words', ->
    it 'in "hedgy.md"', ->
      waitsForPromise ->
        atom.workspace.open('./files/hedgy.md')
          .then (editor) -> LinterJustSayNoProvider.lint editor
          .then (messages) ->
            expect(messages.length).toEqual 15
            expect(messages[0].text).toEqual("Possible hedge word: Sorry")
            expect(messages[0].range).toEqual([[0, 0], [0, 5]])

  describe 'finds no hedge words', ->
    it 'in "empty.md"', ->
      waitsForPromise ->
        atom.workspace.open('./files/empty.md')
          .then (editor) -> LinterJustSayNoProvider.lint editor
          .then (messages) ->
            expect(messages.length).toEqual 0
