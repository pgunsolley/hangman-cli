{ print } = require "./console"

WITH_DEFINITIONS_BONUS = 100
NO_DEFINITIONS_BONUS = 200
WITH_DEFINITIONS_PENALTY = -2
NO_DEFINITIONS_PENALTY = -1

score = (score = 0) =>
    print "Current score: #{score}"
    (word, definitions) =>
        hasNoDefinitions = definitions.includes "No definitions found"
        wordPoints = word.length + if hasNoDefinitions then NO_DEFINITIONS_BONUS else WITH_DEFINITIONS_BONUS
        wordPenalty = if hasNoDefinitions then NO_DEFINITIONS_PENALTY else WITH_DEFINITIONS_PENALTY
        print "New word for #{wordPoints} points"
        (guess) =>
            score += if guess == word
                print "+#{wordPoints} points"
                wordPoints 
            else
                print "#{wordPenalty} points"
                wordPenalty

module.exports = { score }
