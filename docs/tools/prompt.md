# prompt Tools

Tools to work with the shell prompt `PS1`

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `bashPrompt` - Bash prompt creates a prompt and adds return code status

Bash prompt creates a prompt and adds return code status display and modules
Modules are any binary or executable to run each prompt, and can be added or removed here
- `defaultTitle`

- Location: `bin/build/tools/prompt.sh`

#### Arguments

- `--reset` - Flag. Optional. Remove all prompt modules.
- `--list` - Flag. Optional. List the current modules.
- `--first` - Flag. Optional. Add all subsequent modules first to the list.
- `--last` - Flag. Optional. Add all subsequent modules last to the list.
- `module` - String. Optional. Module to enable or disable. To disable, specify `-module`
- `--colors colorsText` - String. Optional. Set the prompt colors
- `--skip-terminal` - Flag. Optional. Skip the check for a terminal attached to standard in.

#### Examples

bashPrompt --colors "$(consoleBoldCyan):$(consoleBoldMagenta):$(consoleGreen):$(consoleOrange):$(consoleCode)"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
