### `isiTerm2`

> Is the current console iTerm2?

#### Usage

    isiTerm2 [ --help ]

Is the current console iTerm2?
Succeeds when LC_TERMINAL is `iTerm2` AND TERM is NOT `screen`

> Location: `bin/build/tools/iterm2.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`LC_TERMINAL` Terminal Application]({rel}env/#bash) – **String**. LC_TERMINAL typically identifies the terminal application
- [`TERM` Terminal Type]({rel}env/#bash) – **String**. The current terminal type.

