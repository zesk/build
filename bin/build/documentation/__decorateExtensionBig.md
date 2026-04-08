## `decorate big`

> Display large text in the console for banners and important

### Usage

    decorate big text [ --bigger ]

Display large text in the console for banners and important messages
`BUILD_TEXT_BINARY` can be `figlet` or `toilet`
standard (figlet)
     _     _      _____         _
    | |__ (_) __ |_   _|____  _| |_
    | '_ \| |/ _` || |/ _ \ \/ / __|
    | |_) | | (_| || |  __/>  <| |_
    |_.__/|_|\__, ||_|\___/_/\_\\__|
             |___/
--bigger (figlet)
     _     _    _______        _
    | |   (_)  |__   __|      | |
    | |__  _  __ _| | _____  _| |_
    | '_ \| |/ _` | |/ _ \ \/ / __|
    | |_) | | (_| | |  __/>  <| |_
    |_.__/|_|\__, |_|\___/_/\_\\__|
              __/ |
             |___/
smblock (regular) toilet
    ▌  ▗   ▀▛▘     ▐
    ▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀
    ▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖
    ▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀
smmono12 (--bigger) toilet
    ▗▖     █       ▗▄▄▄▖
    ▐▌     ▀       ▝▀█▀▘           ▐▌
    ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
    ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
    ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
    ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
    ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
               ▜█▛▘

### Arguments

- `text` - String. Required. Text to output
- `--bigger` - Flag. Optional. Text font size is bigger.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_TEXT_BINARY.sh}

