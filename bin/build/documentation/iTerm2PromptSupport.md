### `iTerm2PromptSupport`

> Add support for iTerm2 to bashPrompt

#### Usage

    iTerm2PromptSupport [ --help ]

Add support for iTerm2 to bashPrompt
If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you
select it.
It also reports the host, user and current directory back to iTerm2 on every prompt command.

> Location: `bin/build/tools/iterm2.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- __ITERM2_HOST
- __ITERM2_HOST_TIME

#### Requires

- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- {SEE:muzzle}
- [bashPrompt]({rel}tools/prompt.md#bashprompt) - Bash prompt toolkit ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L82))
- [bashPromptMarkers]({rel}tools/prompt.md#bashpromptmarkers) - Set markers for terminal integration ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L129))
- iTerm2UpdateState

#### See Also

- [bashPrompt]({rel}tools/prompt.md#bashprompt) - Bash prompt toolkit ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L82))

