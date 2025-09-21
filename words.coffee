{ createClient } = require "./https"
client = createClient "random-word-api.herokuapp.com"

word = => client.get "/word"

words = (count) ->
    fetched = 0
    while fetched < count
        fetched += 1
        yield word()

module.exports = { word, words }
