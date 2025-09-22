{ print, input, inputNum } = require "./console"
{ hangman } = require "./hangman"
{ words } = require "./words"
{ getDefinitions } = require "./dictionary"
{ initialize } = require "./progress"
{ score } = require "./score"

wordCount = await do =>
    res = await inputNum "How many words do you want to attempt? Press enter or enter 0 to play until exit (use ctrl+c to exit)"
    if res > 0
        print "Playing #{res} words"
        return res
    if res == 0
        print "Playing until exit"
    Infinity

totalScore = 0

for await word from words wordCount
    definitions = await getDefinitions word
    progress = initialize word
    scoreWord = score totalScore
    scoreGuess = scoreWord word, definitions
    print progress()
    guesses = 0
    while guesses < hangman.length
        print definitions
        guess = (await input "Guess the word").trim().toLowerCase()
        totalScore = scoreGuess guess
        if guess isnt word
            print hangman[guesses]
            print progress guess
            print "You have #{hangman.length - 1 - guesses} guesses remaining"
            guesses = guesses + 1
            continue
        print "Correct!"
        break
    print "Score: #{totalScore}"
    print "The word is #{word}"
print "Game over!"
