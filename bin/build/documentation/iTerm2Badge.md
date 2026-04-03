## `iTerm2Badge`

> Set the badge for the iTerm2 console

### Usage

    iTerm2Badge [ --ignore | -i ] message ...

Set the badge for the iTerm2 console

### Arguments

--ignore |- ` -i` - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
- `message ...` - String. Required. Any message to display as the badge

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:LC_TERMINAL.sh}

