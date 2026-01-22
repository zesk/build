#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
### PROMPT MODULES
## COLORS
### PROMPT FORMATTING
applicationFile="bin/build/tools/prompt.sh"
argument="module - Callable. Optional. Module to enable or disable."$'\n'"--remove module - Callable. Optional. Remove the module specified (should match exactly)"$'\n'"--reset - Flag. Optional. Remove all prompt modules."$'\n'"--list - Flag. Optional. List the current modules. Modules are also added or removed, otherwise no changes are made."$'\n'"--first - Flag. Optional. Add all subsequent modules first to the list."$'\n'"--last - Flag. Optional. Add all subsequent modules last to the list."$'\n'"--order order - UnsignedInteger. Optional. Set the order index for this prompt. 0 is first, higher numbers are later."$'\n'"--format promptFormat - String. Optional. Display this label on each prompt."$'\n'"--success successText - EmptyString. Optional. Text to display in the prompt when the previous command succeeded."$'\n'"--failure failureText - EmptyString. Optional. Text to display in the prompt when the previous command failed."$'\n'"--label promptLabel - String. Optional. The prompt format string. See PROMPT FORMATTING below"$'\n'"--colors colorsText - String. Optional. Set the prompt colors. See COLORS below."$'\n'"--skip-prompt - Flag. Optional. Do not modify the prompt."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="prompt.sh"
build_debug="bashPrompt - Debug prompt command execution"$'\n'""
description="Bash prompt creates the \`PS1\` prompt with the following extra features:"$'\n'""$'\n'"- Easy colorization"$'\n'"- Easy customization"$'\n'"- Return code of prior command dynamically displayed in following prompt"$'\n'"- Easily extend your bash prompt with modules"$'\n'""$'\n'""$'\n'"### PROMPT MODULES"$'\n'""$'\n'"Modules are any binary or executable to run each prompt, and can be added, removed or managed here."$'\n'""$'\n'"## COLORS"$'\n'""$'\n'"The \`--colors\` are currently a \`:\`-separated list of color **names** (not escape codes), in order:"$'\n'""$'\n'"1. Success color (Array index 0)"$'\n'"2. Failure color (Array index 1)"$'\n'"3. User color (Array index 2)"$'\n'"4. Host color (Array index 3)"$'\n'"5. Directory color (Array index 4)"$'\n'""$'\n'"### PROMPT FORMATTING"$'\n'""$'\n'"Prompts respond to the prior command by changing the status text and color based on the exit code. The **prompt color** for success and failure can be"$'\n'"set using the \`--colors\` option."$'\n'""$'\n'"Prompts can be formatted with a string which can use standard PS1 formatting codes, or the following tokens (surrounded by braces):"$'\n'""$'\n'"- \`\$\` - The dollar character or \`#\` when the user is root, with color (\`\\\$\` equivalent)"$'\n'"- \`label\` - The value of \`--label\` used in the most recent \`bashPrompt\` call (with color)"$'\n'"- \`user\` - The user with color (\`\\u\` equivalent)"$'\n'"- \`code\` - Plain text, the non-zero exit code"$'\n'"- \`host\` - Host name with color (\`\\h\` equivalent)"$'\n'"- \`directory\` - Host name with color (\`\\h\` equivalent)"$'\n'"- \`status\` - \`successText\` or \`failureText\` with appropriate colors"$'\n'"- \`reset\` - A color reset escape sequence to cancel any color mode currently set"$'\n'""$'\n'"An example would be \`bashPrompt --format \"{label} {user}@{host} {status} {\$}\"\`"$'\n'""$'\n'""
environment="PROMPT_COMMAND"$'\n'""
example="bashPrompt --colors \"cyan:magenta:green:orange:code\" --format \"{label} {user}@{host} {status}\""$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPrompt"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt.sh"
sourceModified="1768775409"
summary="Bash prompt creates the \`PS1\` prompt with the following extra"
usage="bashPrompt [ module ] [ --remove module ] [ --reset ] [ --list ] [ --first ] [ --last ] [ --order order ] [ --format promptFormat ] [ --success successText ] [ --failure failureText ] [ --label promptLabel ] [ --colors colorsText ] [ --skip-prompt ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashPrompt[0m [94m[ module ][0m [94m[ --remove module ][0m [94m[ --reset ][0m [94m[ --list ][0m [94m[ --first ][0m [94m[ --last ][0m [94m[ --order order ][0m [94m[ --format promptFormat ][0m [94m[ --success successText ][0m [94m[ --failure failureText ][0m [94m[ --label promptLabel ][0m [94m[ --colors colorsText ][0m [94m[ --skip-prompt ][0m [94m[ --help ][0m

    [94mmodule                 [1;97mCallable. Optional. Module to enable or disable.[0m
    [94m--remove module        [1;97mCallable. Optional. Remove the module specified (should match exactly)[0m
    [94m--reset                [1;97mFlag. Optional. Remove all prompt modules.[0m
    [94m--list                 [1;97mFlag. Optional. List the current modules. Modules are also added or removed, otherwise no changes are made.[0m
    [94m--first                [1;97mFlag. Optional. Add all subsequent modules first to the list.[0m
    [94m--last                 [1;97mFlag. Optional. Add all subsequent modules last to the list.[0m
    [94m--order order          [1;97mUnsignedInteger. Optional. Set the order index for this prompt. 0 is first, higher numbers are later.[0m
    [94m--format promptFormat  [1;97mString. Optional. Display this label on each prompt.[0m
    [94m--success successText  [1;97mEmptyString. Optional. Text to display in the prompt when the previous command succeeded.[0m
    [94m--failure failureText  [1;97mEmptyString. Optional. Text to display in the prompt when the previous command failed.[0m
    [94m--label promptLabel    [1;97mString. Optional. The prompt format string. See PROMPT FORMATTING below[0m
    [94m--colors colorsText    [1;97mString. Optional. Set the prompt colors. See COLORS below.[0m
    [94m--skip-prompt          [1;97mFlag. Optional. Do not modify the prompt.[0m
    [94m--help                 [1;97mFlag. Optional. Display this help.[0m

Bash prompt creates the [38;2;0;255;0;48;2;0;0;0mPS1[0m prompt with the following extra features:

- Easy colorization
- Easy customization
- Return code of prior command dynamically displayed in following prompt
- Easily extend your bash prompt with modules


### PROMPT MODULES

Modules are any binary or executable to run each prompt, and can be added, removed or managed here.

## COLORS

The [38;2;0;255;0;48;2;0;0;0m--colors[0m are currently a [38;2;0;255;0;48;2;0;0;0m:[0m-separated list of color [31mnames[0m (not escape codes), in order:

1. Success color (Array index 0)
2. Failure color (Array index 1)
3. User color (Array index 2)
4. Host color (Array index 3)
5. Directory color (Array index 4)

### PROMPT FORMATTING

Prompts respond to the prior command by changing the status text and color based on the exit code. The [31mprompt color[0m for success and failure can be
set using the [38;2;0;255;0;48;2;0;0;0m--colors[0m option.

Prompts can be formatted with a string which can use standard PS1 formatting codes, or the following tokens (surrounded by braces):

- [38;2;0;255;0;48;2;0;0;0m$[0m - The dollar character or [38;2;0;255;0;48;2;0;0;0m#[0m when the user is root, with color ([38;2;0;255;0;48;2;0;0;0m\$[0m equivalent)
- [38;2;0;255;0;48;2;0;0;0mlabel[0m - The value of [38;2;0;255;0;48;2;0;0;0m--label[0m used in the most recent [38;2;0;255;0;48;2;0;0;0mbashPrompt[0m call (with color)
- [38;2;0;255;0;48;2;0;0;0muser[0m - The user with color ([38;2;0;255;0;48;2;0;0;0m\u[0m equivalent)
- [38;2;0;255;0;48;2;0;0;0mcode[0m - Plain text, the non-zero exit code
- [38;2;0;255;0;48;2;0;0;0mhost[0m - Host name with color ([38;2;0;255;0;48;2;0;0;0m\h[0m equivalent)
- [38;2;0;255;0;48;2;0;0;0mdirectory[0m - Host name with color ([38;2;0;255;0;48;2;0;0;0m\h[0m equivalent)
- [38;2;0;255;0;48;2;0;0;0mstatus[0m - [38;2;0;255;0;48;2;0;0;0msuccessText[0m or [38;2;0;255;0;48;2;0;0;0mfailureText[0m with appropriate colors
- [38;2;0;255;0;48;2;0;0;0mreset[0m - A color reset escape sequence to cancel any color mode currently set

An example would be [38;2;0;255;0;48;2;0;0;0mbashPrompt --format "{label} {user}@{host} {status} {$}"[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- PROMPT_COMMAND
- 

Example:
bashPrompt --colors "cyan:magenta:green:orange:code" --format "{label} {user}@{host} {status}"

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- bashPrompt - Debug prompt command execution
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: bashPrompt [ module ] [ --remove module ] [ --reset ] [ --list ] [ --first ] [ --last ] [ --order order ] [ --format promptFormat ] [ --success successText ] [ --failure failureText ] [ --label promptLabel ] [ --colors colorsText ] [ --skip-prompt ] [ --help ]

    module                 Callable. Optional. Module to enable or disable.
    --remove module        Callable. Optional. Remove the module specified (should match exactly)
    --reset                Flag. Optional. Remove all prompt modules.
    --list                 Flag. Optional. List the current modules. Modules are also added or removed, otherwise no changes are made.
    --first                Flag. Optional. Add all subsequent modules first to the list.
    --last                 Flag. Optional. Add all subsequent modules last to the list.
    --order order          UnsignedInteger. Optional. Set the order index for this prompt. 0 is first, higher numbers are later.
    --format promptFormat  String. Optional. Display this label on each prompt.
    --success successText  EmptyString. Optional. Text to display in the prompt when the previous command succeeded.
    --failure failureText  EmptyString. Optional. Text to display in the prompt when the previous command failed.
    --label promptLabel    String. Optional. The prompt format string. See PROMPT FORMATTING below
    --colors colorsText    String. Optional. Set the prompt colors. See COLORS below.
    --skip-prompt          Flag. Optional. Do not modify the prompt.
    --help                 Flag. Optional. Display this help.

Bash prompt creates the PS1 prompt with the following extra features:

- Easy colorization
- Easy customization
- Return code of prior command dynamically displayed in following prompt
- Easily extend your bash prompt with modules


### PROMPT MODULES

Modules are any binary or executable to run each prompt, and can be added, removed or managed here.

## COLORS

The --colors are currently a :-separated list of color names (not escape codes), in order:

1. Success color (Array index 0)
2. Failure color (Array index 1)
3. User color (Array index 2)
4. Host color (Array index 3)
5. Directory color (Array index 4)

### PROMPT FORMATTING

Prompts respond to the prior command by changing the status text and color based on the exit code. The prompt color for success and failure can be
set using the --colors option.

Prompts can be formatted with a string which can use standard PS1 formatting codes, or the following tokens (surrounded by braces):

- $ - The dollar character or # when the user is root, with color (\$ equivalent)
- label - The value of --label used in the most recent bashPrompt call (with color)
- user - The user with color (\u equivalent)
- code - Plain text, the non-zero exit code
- host - Host name with color (\h equivalent)
- directory - Host name with color (\h equivalent)
- status - successText or failureText with appropriate colors
- reset - A color reset escape sequence to cancel any color mode currently set

An example would be bashPrompt --format "{label} {user}@{host} {status} {$}"

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- PROMPT_COMMAND
- 

Example:
bashPrompt --colors "cyan:magenta:green:orange:code" --format "{label} {user}@{host} {status}"

BUILD_DEBUG settings:
- bashPrompt - Debug prompt command execution
- 
'
