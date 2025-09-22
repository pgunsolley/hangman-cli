initialize = (word) =>
    state = word.replace /[a-zA-Z]/g, "_"
    (guess = "") =>
        _state = ""
        for char, i in word
            _state += if char == guess[i] then char else state[i]
        (state = _state)
            .split ""
            .join " "

module.exports = { initialize }
