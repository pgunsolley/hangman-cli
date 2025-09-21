{ createClient } = require "./https"
client = createClient "api.dictionaryapi.dev"

getDefinitions = (word) =>
    definition = (((await client.get "/api/v2/entries/en/#{word}") || {})
        .meanings || [])
        .map (({ partOfSpeech, definitions }) => 
            {
                partOfSpeech,
                definitions: definitions.map (({ definition }) => "- #{definition}"),
            })
        .map (({ partOfSpeech, definitions}) => "Type: #{partOfSpeech}\n#{definitions.join "\n"}")
        .join "\n"
    "Definitions:\n#{definition || "No definitions found"}"

module.exports = { getDefinitions }
