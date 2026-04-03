## `bashPrompt`

> Bash prompt creates the `PS1` prompt with the following extra

### Usage

    bashPrompt [ module ] [ --remove module ] [ --reset ] [ --list ] [ --first ] [ --last ] [ --order order ] [ --format promptFormat ] [ --success successText ] [ --failure failureText ] [ --label promptLabel ] [ --colors colorsText ] [ --skip-prompt ] [ --help ]

Bash prompt creates the `PS1` prompt with the following extra features:
- Easy colorization
- Easy customization
- Return code of prior command dynamically displayed in following prompt
- Easily extend your bash prompt with modules
### PROMPT MODULES
Modules are any binary or executable to run each prompt, and can be added, removed or managed here.
## COLORS
The `--colors` are currently a `:`-separated list of color **names** (not escape codes), in order:
1. Success color (Array index 0)
2. Failure color (Array index 1)
3. User color (Array index 2)
4. Host color (Array index 3)
5. Directory color (Array index 4)
### Arguments

- `module` - Callable. Optional. Module to enable or disable.
- `--remove module` - Callable. Optional. Remove the module specified (should match exactly)
- `--reset` - Flag. Optional. Remove all prompt modules.
- `--list` - Flag. Optional. List the current modules. Modules are also added or removed, otherwise no changes are made.
- `--first` - Flag. Optional. Add all subsequent modules first to the list.
- `--last` - Flag. Optional. Add all subsequent modules last to the list.
- `--order order` - UnsignedInteger. Optional. Set the order index for this prompt. 0 is first, higher numbers are later.
- `--format promptFormat` - String. Optional. Display this label on each prompt.
- `--success successText` - EmptyString. Optional. Text to display in the prompt when the previous command succeeded.
- `--failure failureText` - EmptyString. Optional. Text to display in the prompt when the previous command failed.
- `--label promptLabel` - String. Optional. The prompt format string. See PROMPT FORMATTING below
- `--colors colorsText` - String. Optional. Set the prompt colors. See COLORS below.
- `--skip-prompt` - Flag. Optional. Do not modify the prompt.
- `--help` - Flag. Optional. Display this help.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `bashPrompt` - Debug prompt command execution

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:PROMPT_COMMAND.sh}

