## `isiTerm2`

> Is the current console iTerm2?

### Usage

    isiTerm2 [ --help ]

Is the current console iTerm2?
Succeeds when LC_TERMINAL is `iTerm2` AND TERM is NOT `screen`

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:LC_TERMINAL.sh}
- {SEE:TERM.sh}

