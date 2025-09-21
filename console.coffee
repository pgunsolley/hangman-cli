{ createInterface } = require "node:readline/promises"

print = (text = "") =>
    console.log "#{text}\n"

input = (question = "") =>
    rl = createInterface
        input: process.stdin
        output: process.stdout
    rl.on "SIGINT", => 
        rl.close()
    response = await rl.question ("#{question}\n>> ")
    rl.close()
    response

inputNum = (question = "") =>
    res = await input question
    if isNaN res
        print "#{res} is not a valid number"
        return inputNum question
    Number res

module.exports = { print, input, inputNum }
