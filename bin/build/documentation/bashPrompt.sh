#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
### PROMPT MODULES
## COLORS
### PROMPT FORMATTING
applicationFile="bin/build/tools/prompt.sh"
argument="module - Executable. Optional. Module to enable or disable."$'\n'"--remove module - Optional. Remove the module specified (should match exactly)"$'\n'"--reset - Flag. Optional. Remove all prompt modules."$'\n'"--list - Flag. Optional. List the current modules. Modules are also added or removed, otherwise no changes are made."$'\n'"--first - Flag. Optional. Add all subsequent modules first to the list."$'\n'"--last - Flag. Optional. Add all subsequent modules last to the list."$'\n'"--order order - UnsignedInteger. Optional. Set the order index for this prompt. 0 is first, higher numbers are later."$'\n'"--format promptFormat - String. Optional. Display this label on each prompt."$'\n'"--success successText - EmptyString. Optional. Text to display in the prompt when the previous command succeeded."$'\n'"--failure failureText - EmptyString. Optional. Text to display in the prompt when the previous command failed."$'\n'"--label promptLabel - String. Optional. The prompt format string. See PROMPT FORMATTING below"$'\n'"--colors colorsText - String. Optional. Set the prompt colors. See COLORS below."$'\n'"--skip-prompt - Flag. Optional. Do not modify the prompt."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="prompt.sh"
build_debug="bashPrompt - Debug prompt command execution"$'\n'""
description="Bash prompt creates the \`PS1\` prompt with the following extra features:"$'\n'""$'\n'"- Easy colorization"$'\n'"- Easy customization"$'\n'"- Return code of prior command dynamically displayed in following prompt"$'\n'"- Easily extend your bash prompt with modules"$'\n'""$'\n'""$'\n'"### PROMPT MODULES"$'\n'""$'\n'"Modules are any binary or executable to run each prompt, and can be added, removed or managed here."$'\n'""$'\n'"## COLORS"$'\n'""$'\n'"The \`--colors\` are currently a \`:\`-separated list of color **names** (not escape codes), in order:"$'\n'""$'\n'"1. Success color (Array index 0)"$'\n'"2. Failure color (Array index 1)"$'\n'"3. User color (Array index 2)"$'\n'"4. Host color (Array index 3)"$'\n'"5. Directory color (Array index 4)"$'\n'""$'\n'"### PROMPT FORMATTING"$'\n'""$'\n'"Prompts respond to the prior command by changing the status text and color based on the exit code. The **prompt color** for success and failure can be"$'\n'"set using the \`--colors\` option."$'\n'""$'\n'"Prompts can be formatted with a string which can use standard PS1 formatting codes, or the following tokens (surrounded by braces):"$'\n'""$'\n'"- \`\$\` - The dollar character or \`#\` when the user is root, with color (\`\\\$\` equivalent)"$'\n'"- \`label\` - The value of \`--label\` used in the most recent \`bashPrompt\` call (with color)"$'\n'"- \`user\` - The user with color (\`\\u\` equivalent)"$'\n'"- \`code\` - Plain text, the non-zero exit code"$'\n'"- \`host\` - Host name with color (\`\\h\` equivalent)"$'\n'"- \`directory\` - Host name with color (\`\\h\` equivalent)"$'\n'"- \`status\` - \`successText\` or \`failureText\` with appropriate colors"$'\n'"- \`reset\` - A color reset escape sequence to cancel any color mode currently set"$'\n'""$'\n'"An example would be \`bashPrompt --format \"{label} {user}@{host} {status} {\$}\"\`"$'\n'""$'\n'""
environment="PROMPT_COMMAND"$'\n'""
example="bashPrompt --colors \"cyan:magenta:green:orange:code\" --format \"{label} {user}@{host} {status}\""$'\n'""
file="bin/build/tools/prompt.sh"
fn="bashPrompt"
foundNames=([0]="argument" [1]="example" [2]="environment" [3]="build_debug")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/prompt.sh"
sourceModified="1768721469"
summary="Bash prompt creates the \`PS1\` prompt with the following extra"
usage="bashPrompt [ module ] [ --remove module ] [ --reset ] [ --list ] [ --first ] [ --last ] [ --order order ] [ --format promptFormat ] [ --success successText ] [ --failure failureText ] [ --label promptLabel ] [ --colors colorsText ] [ --skip-prompt ] [ --help ]"
