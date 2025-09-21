{ print, input, inputNum } = require "./console"
{ hangman } = require "./hangman"
{ words } = require "./words"
{ getDefinitions } = require "./dictionary"
{ initialize } = require "./progress"

MAX_WORDS = 10

takeWordCount = =>
    res = await inputNum "How many words do you want to attempt?"
    if res > MAX_WORDS
        print "The maximum is #{MAX_WORDS}.. using #{MAX_WORDS}"
        return MAX_WORDS
    if res == 0
        print "Defaulting to 1 word"
        return 1
    res

wordCount = await takeWordCount()

for await word from words wordCount
    print "\n\n\n\n\n\n\n"
    definitions = await getDefinitions word
    progress = initialize word
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
        break
    print "The word is #{word}"
print "Game over!"
