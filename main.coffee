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
score = 0

for await word from words wordCount
    definitions = await getDefinitions word
    wordPoints = word.length + if definitions.length == 0 then 20 else 5
    progress = initialize word
    print "\n\n\n\n\n\n"
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
