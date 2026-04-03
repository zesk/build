## `iTerm2Attention`

> Attract the operator

### Usage

    iTerm2Attention [ --ignore | -i ] [ --verbose | -v ] [ action. String. Action to attract attention: `true`, `false` or `!` ]

Attract the operator
Actions:
- `true` - start making dock icon bounce
- `false` - stop making dock icon bounce
- `!` - Show fireworks at cursor
- `fireworks` - Show fireworks at cursor

### Arguments

--ignore |- ` -i` - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
--verbose |- ` -v` - Flag. Optional. Verbose mode. Show what you are doing.
- action. String. Action to attract attention: `true`, `false` or `!`

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

