# prompt Tools

Tools to work with the shell prompt `PS1`

- `bashPromptModule_binBuild` is a module for `bashPrompt` which sets the Zesk Build home depending on your current directory
- `consoleDefaultTitle` can be used as a module to set the current title

Examples:

    bashPrompt bashPromptModule_binBuild consoleDefaultTitle
    bashPrompt --colors "$(bashPromptColorScheme forest)"

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Functions

### `bashPrompt` - Bash prompt creates a prompt and adds return code status

Bash prompt creates a prompt and adds return code status display and modules
Modules are any binary or executable to run each prompt, and can be added or removed here
- `consoleDefaultTitle`

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
### `bashPromptColorScheme` - Color schemes for prompts

Color schemes for prompts
Options are:
- forest
- default

- Location: `bin/build/tools/prompt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `bashPromptModule_binBuild` - Check which bin/build we are running and keep local to

Check which bin/build we are running and keep local to current project
When changing projects, runs the `project-selected` hook in the new project
Also shows the change in Zesk Build version numbers

- Location: `bin/build/tools/prompt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
