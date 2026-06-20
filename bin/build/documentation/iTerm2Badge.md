### `iTerm2Badge`

> Set Badge Message

#### Usage

    iTerm2Badge [ --ignore | -i ] [ message ... ]

Set the badge for the iTerm2 console

> Location: `bin/build/tools/iterm2.sh`

#### Arguments

--ignore |- ` -i` - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
- `message ...` - String. Optional. Any message to display as the badge

#### Reads standard input

message - String. Optional. Message to display if not supplied as an argument.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- {SEE:LC_TERMINAL}

