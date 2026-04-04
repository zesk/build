## `iTerm2PromptSupport`

> Add support for iTerm2 to bashPrompt

### Usage

    iTerm2PromptSupport [ --help ]

Add support for iTerm2 to bashPrompt
If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you
select it.
It also reports the host, user and current directory back to iTerm2 on every prompt command.

### Arguments

- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- __ITERM2_HOST
- __ITERM2_HOST_TIME

