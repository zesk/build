# (iTerm2 Tools)[https://iterm2.com/]

### `isiTerm2` - Is the current console iTerm2?

Is the current console iTerm2?

- Location: `bin/build/tools/iterm2.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `iTerm2Init` - Load $HOME/.iterm2_shell_integration.bash if it exists

Load $HOME/.iterm2_shell_integration.bash if it exists

- Location: `bin/build/tools/iterm2.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

LC_TERMINAL
TERM
### `iTerm2Badge` - Set the badge for the iTerm2 console

Set the badge for the iTerm2 console

- Location: `bin/build/tools/iterm2.sh`

#### Arguments

--ignore |- ` -i` - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
- `message ...` - Any message to display as the badge

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

LC_TERMINAL
