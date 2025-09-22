{ print, input, inputNum } = require "./console"
{ hangman } = require "./hangman"
{ words } = require "./words"
{ getDefinitions } = require "./dictionary"
{ initialize } = require "./progress"

MAX_WORDS = 20
WITH_DEFINITIONS_BONUS = 5
NO_DEFINITIONS_BONUS = 25

wordCount = await do =>
    res = await inputNum "How many words do you want to attempt? Enter 0 to play indefinitely (use ctrl+c to exit)"
    if res > MAX_WORDS
        print "The maximum is #{MAX_WORDS}.. using #{MAX_WORDS}"
        return MAX_WORDS
    if res == 0
        print "Playing until exit (ctrl+c)"
    Infinity

score = 0

for await word from words wordCount
    definitions = await getDefinitions word
    isNoDefinitionBonus = definitions.includes "No definitions found"
    wordPoints = word.length + if isNoDefinitionBonus then NO_DEFINITIONS_BONUS else WITH_DEFINITIONS_BONUS
    progress = initialize word
    print "New word for #{wordPoints} points"
    print progress()
    guesses = 0
    while guesses < hangman.length
        print definitions
        guess = (await input "Guess the word").trim().toLowerCase()
        if guess isnt word
            print hangman[guesses]
            print progress guess
            print "You have #{hangman.length - 1 - guesses} guesses remaining"
            guesses = guesses + 1
            continue
        print "Correct!"
        score += wordPoints
        break
    print "Score: #{score}"
    print "The word is #{word}"
print "Game over!"
