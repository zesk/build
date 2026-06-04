### `iTerm2Init`

> Add iTerm2 support to console

#### Usage

    iTerm2Init [ --ignore | -i ]

Add iTerm2 support to console

> Location: `bin/build/tools/iterm2.sh`

#### Arguments

--ignore |- ` -i` - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- {SEE:LC_TERMINAL}
- {SEE:TERM}

#### See Also

- [iTerm2Aliases]({rel}tools/iterm2.md#iterm2aliases)- `` - Installs iTerm2 aliases which are: ([source](https://github.com/zesk/build/blob/main/bin/build/tools/iterm2.sh#L163)){SEE:iTerm2PromptSupport}

