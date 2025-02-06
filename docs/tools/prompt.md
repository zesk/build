# prompt Tools

The prompt supports a few things:

- `user@host ~/path` prefix
- Exit status of previous command is displayed
- Manage a queue of functions to run on each shell command

Tools to work with the shell prompt `PS1`

- `bashPromptModule_binBuild` is a module for `bashPrompt` which sets the Zesk Build home depending on your current directory
- `bashPromptModule_ApplicationPath` is a module for `bashPrompt` which displays the current application/path as a badge in iTerm
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
- `--label promptLabel` - String. Optional. Display this label on each prompt.
- `module` - String. Optional. Module to enable or disable. To disable, specify `-module`
- `--colors colorsText` - String. Optional. Set the prompt colors
- `--skip-terminal` - Flag. Optional. Skip the check for a terminal attached to standard in.

#### Examples

bashPrompt --colors "$(decorate bold-cyan):$(decorate bold-magenta):$(decorate green):$(decorate orange):$(decorate code)"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

PROMPT_COMMAND ### `bashPromptColorScheme` - Color schemes for prompts

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
### `bashPromptMarkers` - Set markers for terminal integration

Set markers for terminal integration
Outputs the current marker settings, one per line (0, 1, or 2 lines will be output).

- Location: `bin/build/tools/prompt.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `prefix` - Optional. EmptyString. Prefix for all prompts.
- `suffix` - Optional. EmptyString. Suffix for all prompts.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `bashPromptUser` - Prompt the user properly honoring any attached console

Prompt the user properly honoring any attached console
Arguments are the same as read, except:
`-r` is implied and does not need to be specified

- Location: `bin/build/tools/prompt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Bash Prompt Modules

- [`bashPromptModule_binBuild`](#bashPromptModule_binBuild)
- [`bashPromptModule_ApplicationPath`](#bashPromptModule_ApplicationPath)
- [`bashPromptModule_dotFilesWatcher`](#bashPromptModule_dotFilesWatcher)

To enable:

    bashPrompt bashPromptModule_binBuild bashPromptModule_ApplicationPath

### `bashPromptModule_binBuild` - Check which bin/build we are running and keep local to

Check which bin/build we are running and keep local to current project. Activates when we switch between projects.
- Re-sources `bin/build` so versions do not conflict.
- Runs hook `project-deactivate` in the old project (using that `bin/build` library)
- Runs the `project-activate` hook in the new project
- Adds the current project's `bin` directory to the `PATH`
- Removes the old project's `bin` directory from the `PATH`
- Displays the change in Zesk Build version

- Location: `bin/build/tools/prompt/bin-build.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error ### `bashPromptModule_ApplicationPath` - Show current application and path as a badge

Show current application and path as a badge

- Location: `bin/build/tools/prompt/application-path.sh`

#### Arguments

- No arguments.

#### Examples

    bashPrompt bashPromptModule_ApplicationPath

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error ### `bashPromptModule_dotFilesWatcher` - Watches your HOME directory for `.` files which are added

Watches your HOME directory for `.` files which are added and unknown to you.

- Location: `bin/build/tools/prompt/dot-files-watcher.sh`

#### Arguments

- No arguments.

#### Examples

    bashPrompt bashPromptModule_dotFilesWatcher

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## dotFilesWatcher Tools

Example during setup:

   dotFilesApproved bash > "$(dotFilesApprovedFile)"

And then in your bash prompt:

   bashPrompt bashPromptModule_dotFilesWatcher

Any new dot files which appear will then show a warning in your console.

### `dotFilesApprovedFile` - The dot files approved file. Add files to this to

The dot files approved file. Add files to this to approve.

- Location: `bin/build/tools/prompt/dot-files-watcher.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

XDG_DATA_HOME
### `dotFilesApproved` - The lists

The lists

- Location: `bin/build/tools/prompt/dot-files-watcher.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
