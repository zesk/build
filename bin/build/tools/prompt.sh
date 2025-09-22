#!/usr/bin/env bash
#
# Bash Prompt Tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/prompt.md
# Test: ./test/tools/prompt-tests.sh

__promptLoader() {
  __functionLoader __bashPrompt prompt "$@"
}

# Argument: module - Executable. Optional. Module to enable or disable.
# Argument: --remove module - Optional. Remove the module specified (should match exactly)
# Argument: --reset - Flag. Optional. Remove all prompt modules.
# Argument: --list - Flag. Optional. List the current modules. Modules are also added or removed, otherwise no changes are made.
# Argument: --first - Flag. Optional. Add all subsequent modules first to the list.
# Argument: --last - Flag. Optional. Add all subsequent modules last to the list.
# Argument: --order order - UnsignedInteger. Optional. Set the order index for this prompt. 0 is first, higher numbers are later.
# Argument: --format promptFormat - String. Optional. Display this label on each prompt.
# Argument: --success successText - EmptyString. Optional. Text to display in the prompt when the previous command succeeded.
# Argument: --failure failureText - EmptyString. Optional. Text to display in the prompt when the previous command failed.
# Argument: --label promptLabel - String. Optional. The prompt format string. See PROMPT FORMATTING below
# Argument: --colors colorsText - String. Optional. Set the prompt colors. See COLORS below.
# Argument: --skip-prompt - Flag. Optional. Do not modify the prompt.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
#
# Bash prompt creates the `PS1` prompt with the following extra features:
#
# - Easy colorization
# - Easy customization
# - Return code of prior command dynamically displayed in following prompt
# - Easily extend your bash prompt with modules
#
#
# ## PROMPT MODULES
#
# Modules are any binary or executable to run each prompt, and can be added, removed or managed here.
#
# ## COLORS
#
# The `--colors` are currently a `:`-separated list of color **names** (not escape codes), in order:
#
# 1. Success color (Array index 0)
# 2. Failure color (Array index 1)
# 3. User color (Array index 2)
# 4. Host color (Array index 3)
# 5. Directory color (Array index 4)
#
# ## PROMPT FORMATTING
#
# Prompts respond to the prior command by changing the status text and color based on the exit code. The **prompt color** for success and failure can be
# set using the `--colors` option.
#
# Prompts can be formatted with a string which can use standard PS1 formatting codes, or the following tokens (surrounded by braces):
#
# - `$` - The dollar character or `#` when the user is root, with color (`\$` equivalent)
# - `label` - The value of `--label` used in the most recent `bashPrompt` call (with color)
# - `user` - The user with color (`\u` equivalent)
# - `code` - Plain text, the non-zero exit code
# - `host` - Host name with color (`\h` equivalent)
# - `directory` - Host name with color (`\h` equivalent)
# - `status` - `successText` or `failureText` with appropriate colors
# - `reset` - A color reset escape sequence to cancel any color mode currently set
#
# Example: bashPrompt --colors "bold-cyan:bold-magenta:green:orange:code" --format "{label} {user}@{host} {status}"
# Environment: PROMPT_COMMAND
bashPrompt() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashPrompt() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Prompt the user properly honoring any attached console
# Arguments are the same as `read`, except:
# `-r` is implied and does not need to be specified
bashUserInput() {
  local handler="_${FUNCNAME[0]}"
  local word="" exitCode=0

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if ! isTTYAvailable; then
    __throwEnvironment "$handler" "No TTY available for user input" || return $?
  fi
  export __BASH_PROMPT_MARKERS
  stty echo
  # Technically the reading program will not receive these bytes as they will be sent to the tty
  # printf "%s" "${__BASH_PROMPT_MARKERS[0]-}" >>/dev/tty
  read -r "$@" word </dev/tty 2>>/dev/tty || exitCode=$?
  # printf "%s" "${__BASH_PROMPT_MARKERS[1]-}" >>/dev/tty
  printf "%s" "$word"
  return $exitCode
}
_bashUserInput() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set markers for terminal integration
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: prefix - Optional. EmptyString. Prefix for all prompts.
# Argument: suffix - Optional. EmptyString. Suffix for all prompts.
# Outputs the current marker settings, one per line (0, 1, or 2 lines will be output).
bashPromptMarkers() {
  local handler="_${FUNCNAME[0]}"

  local markers=()

  export __BASH_PROMPT_MARKERS
  __catch "$handler" buildEnvironmentLoad __BASH_PROMPT_MARKERS || return $?

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      markers+=("$1")
      ;;
    esac
    shift
  done
  [ "${#markers[@]}" -le 2 ] || __throwArgument "$handler" "Maximum two markers supported (prefix suffix)"
  [ "${#markers[@]}" -eq 0 ] || __BASH_PROMPT_MARKERS=("${markers[@]}")
  printf "%s\n" "${__BASH_PROMPT_MARKERS[@]}"
}
_bashPromptMarkers() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Color schemes for prompts
# Options are:
# - forest
# - light (default)
# - dark
bashPromptColorScheme() {
  local colors exitColor
  exitColor="bold-green:bold-red"
  case "${1-}" in
  --help)
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0
    return $?
    ;;
  forest) colors="bold-cyan:bold-magenta:green:orange:code" ;;
  light) colors="$exitColor:magenta:blue:bold-black" ;;
  dark) colors="$exitColor:magenta:blue:bold-white" ;;
  *) colors="$exitColor:magenta:blue:bold-black" ;;
  esac
  printf -- "%s" "$colors"
}

#
# Given a list of color names, generate the color codes in a :-separated list
# Requires: decorations read inArray decorate listJoin
bashPromptColorsFormat() {
  local index color colors=()
  local all=()
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while read -r color; do all+=("$color"); done < <(decorations)
  IFS=":" read -r -a colors <<<"$1:::::" || :
  for index in "${!colors[@]}"; do
    color="${colors[index]}"
    if inArray "$color" "${all[@]}"; then
      colors[index]="$(decorate "$color" --)"
    else
      colors[index]=""
    fi
    [ "$index" -le 4 ] || unset "colors[$index]"
  done
  colors+=("$(decorate reset --)")
  printf "%s\n" "$(listJoin ":" "${colors[@]}")"
}
_bashPromptColorsFormat() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
