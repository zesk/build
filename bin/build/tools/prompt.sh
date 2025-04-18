#!/usr/bin/env bash
#
# Bash Prompt Tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/prompt.md
# Test: ./test/tools/prompt-tests.sh

# Argument: module - Executable. Optional. Module to enable or disable.
# Argument: --remove module - Optional. Remove the module specified (should match exactly)
# Argument: --reset - Flag. Optional. Remove all prompt modules.
# Argument: --list - Flag. Optional. List the current modules.
# Argument: --first - Flag. Optional. Add all subsequent modules first to the list.
# Argument: --last - Flag. Optional. Add all subsequent modules last to the list.
# Argument: --format promptFormat - String. Optional. Display this label on each prompt.
# Argument: --success successText - EmptyString. Optional. Text to display in the prompt when the previous command succeeded.
# Argument: --failure failureText - EmptyString. Optional. Text to display in the prompt when the previous command failed.
# Argument: --label promptLabel - String. Optional. The prompt format string. See PROMPT FORMATTING below
# Argument: --colors colorsText - String. Optional. Set the prompt colors. See COLORS below.
# Argument: --skip-terminal - Flag. Optional. Skip the check for a terminal attached to `stdin`.
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
  local usage="_${FUNCNAME[0]}"

  local addArguments=() colorsText="" resetFlag=false verbose=false skipTerminal=false listFlag=false

  export __BASH_PROMPT_PREVIOUS
  isArray __BASH_PROMPT_PREVIOUS || __BASH_PROMPT_PREVIOUS=()

  local promptFormat="" successPrompt="${__BASH_PROMPT_PREVIOUS[0]-}" failurePrompt="${__BASH_PROMPT_PREVIOUS[1]-}" label="${__BASH_PROMPT_PREVIOUS[2]-}"

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --success)
        shift
        successPrompt=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --failure)
        shift
        failurePrompt=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --label)
        shift
        label="$(usageArgumentEmptyString "$usage" "$argument" "${1-}")" || return $?
        [ -z "$label" ] || label="$label "
        ;;
      --list)
        listFlag=true
        ;;
      --format)
        shift
        promptFormat=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      --remove)
        shift
        local module
        module=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        __bashPromptRemove "$usage" "$module" || return $?
        ;;
      --skip-terminal)
        skipTerminal=true
        ;;
      --reset)
        resetFlag=true
        ;;
      --colors)
        shift
        colorsText="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        local colors
        IFS=":" read -r -a colors <<<"$colorsText" || :
        [ "${#colors[@]}" -ge 2 ] || __throwArgument "$usage" "$argument should be min 2 colors separated by a colon: $(decorate code "$colorsText")" || return $?
        [ "${#colors[@]}" -le 5 ] || __throwArgument "$usage" "$argument should be max 5 colors separated by a colon: $(decorate code "$colorsText")" || return $?
        ;;
      --first | --last | --debug)
        addArguments+=("$argument")
        ;;
      --verbose)
        verbose=true
        addArguments+=("$argument")
        ;;
      *)
        addArguments+=("$argument")
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if [ -z "$successPrompt" ] || $resetFlag; then
    successPrompt=">"
  fi
  if [ -z "$failurePrompt" ] || $resetFlag; then
    failurePrompt=" §" # Space for code
  fi
  if [ -z "$promptFormat" ] || $resetFlag; then
    promptFormat="{label}{user}@{host} {directory} {return}{status} "
  fi

  $skipTerminal || [ -t 0 ] || __throwEnvironment "$usage" "Requires a terminal" || return $?

  export PROMPT_COMMAND PS1 __BASH_PROMPT_PREVIOUS __BASH_PROMPT_MODULES BUILD_PROMPT_COLORS

  if $resetFlag; then
    __BASH_PROMPT_MODULES=()
    addArguments=()
    ! $verbose || decorate info "Prompt modules reset to empty list."
  fi
  # IDENTICAL bashPromptAddArguments 3
  if [ ${#addArguments[@]} -gt 0 ]; then
    __bashPromptAdd "$usage" "${addArguments[@]+"${addArguments[@]}"}" || return $?
  fi

  if $listFlag; then
    # IDENTICAL bashPromptAddArguments 3
    if [ ${#addArguments[@]} -gt 0 ]; then
      __bashPromptAdd "$usage" "${addArguments[@]+"${addArguments[@]}"}" || return $?
    fi
    addArguments=()
    __bashPromptList
  fi

  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_PROMPT_COLORS || return $?

  if [ -z "${BUILD_PROMPT_COLORS-}" ] || [ -n "$colorsText" ] || $resetFlag; then
    [ -n "$colorsText" ] || colorsText=$(bashPromptColorScheme default)
    BUILD_PROMPT_COLORS=$(bashPromptColorsFormat "${colorsText}")
  fi

  local theCommand="__bashPromptCommand"
  if [ -n "${PROMPT_COMMAND-}" ]; then
    local commands=() command updated=()
    IFS=";" read -r -a commands <<<"${PROMPT_COMMAND-}"
    updated=("$theCommand")
    for command in "${commands[@]}"; do
      command=$(trimSpace "$command")
      if [ "$command" = "$theCommand" ]; then
        continue
      fi
      updated+=("$command")
    done
    PROMPT_COMMAND="$(listJoin ";" "${updated[@]}")"
  else
    PROMPT_COMMAND="$theCommand"
  fi
  isArray __BASH_PROMPT_PREVIOUS || __BASH_PROMPT_PREVIOUS=()
  __BASH_PROMPT_PREVIOUS=("$successPrompt" "$failurePrompt" "$label" 0)
  PS1="$(__bashPromptGeneratePS1 "$promptFormat")"
}
_bashPrompt() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Prompt the user properly honoring any attached console
# Arguments are the same as read, except:
# `-r` is implied and does not need to be specified
bashUserInput() {
  local usage="_${FUNCNAME[0]}"
  local word="" exitCode=0

  if ! isTTYAvailable; then
    __throwEnvironment "$usage" "No TTY available for user input" || return $?
  fi
  export __BASH_PROMPT_MARKERS
  # Technically the reading program will not receive these bytes as they will be sent to the tty
  printf "%s" "${__BASH_PROMPT_MARKERS[0]-}" >>/dev/tty
  read -r "$@" word </dev/tty || exitCode=$?
  printf "%s" "${__BASH_PROMPT_MARKERS[1]-}" >>/dev/tty
  printf "%s\n" "$word"
  return $exitCode
}
_bashUserInput() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Set markers for terminal integration
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: prefix - Optional. EmptyString. Prefix for all prompts.
# Argument: suffix - Optional. EmptyString. Suffix for all prompts.
# Outputs the current marker settings, one per line (0, 1, or 2 lines will be output).
bashPromptMarkers() {
  local usage="_${FUNCNAME[0]}"

  local markers=()

  export __BASH_PROMPT_MARKERS
  __catchEnvironment "$usage" buildEnvironmentLoad __BASH_PROMPT_MARKERS || return $?

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        markers+=("$1")
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ "${#markers[@]}" -le 2 ] || __throwArgument "$usage" "Maximum two markers supported (prefix suffix)"
  [ "${#markers[@]}" -eq 0 ] || __BASH_PROMPT_MARKERS=("${markers[@]}")
  printf "%s\n" "${__BASH_PROMPT_MARKERS[@]}"
}
_bashPromptMarkers() {
  # _IDENTICAL_ usageDocument 1
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
  __help "$usage" "$@" || return 0
  exitColor="bold-green:bold-red"
  case "${1-}" in
    forest) colors="bold-cyan:bold-magenta:green:orange:code" ;;
    light) colors="$exitColor:magenta:blue:bold-black" ;;
    dark) colors="$exitColor:magenta:blue:bold-white" ;;
    *) colors="$exitColor:magenta:blue:bold-black" ;;
  esac
  printf -- "%s" "$colors"
}

# Requires: isArray
# Environment: __BASH_PROMPT_MODULES
# Environment: __BASH_PROMPT_PREVIOUS
__bashPromptSanity() {
  export __BASH_PROMPT_MODULES __BASH_PROMPT_PREVIOUS
  if ! isArray "__BASH_PROMPT_MODULES"; then
    __BASH_PROMPT_MODULES=()
  fi
  if ! isArray "__BASH_PROMPT_PREVIOUS"; then
    __BASH_PROMPT_PREVIOUS=()
  fi
}

# Requires: isFunction printf decorate
__bashPromptList() {
  local promptCommand

  __bashPromptSanity

  for promptCommand in "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}"; do
    if isFunction "$promptCommand"; then
      printf -- "- %s (%s)\n" "$(decorate code "$promptCommand")" "$(decorate orange "function")"
    else
      printf -- "- %s (%s)\n" "$(decorate value "$promptCommand")" "$(decorate blue "file")"
    fi
  done
}

# Usage: {fn} [ --first | --last | module ]
# Argument: --first - Flag. Optional. All subsequent modules are added first to the list.
# Argument: --last - Flag. Optional. ALl subsequent modules are added to the end of the list.
# Argument: module - Callable. Required. The module to add
__bashPromptAdd() {
  local usage="$1" && shift

  local first=false last=false verbose=false found

  __bashPromptSanity

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      --verbose)
        verbose=true
        ;;
      --first)
        first=true
        last=false
        ;;
      --last)
        first=false
        last=true
        ;;
      *)
        local found=""
        isCallable "$argument" || __throwArgument "$usage" "$argument must be executable or a function" || return $?
        ! inArray "$argument" "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}" || found="$argument"
        if $first; then
          if [ -n "$found" ]; then
            if [ "${__BASH_PROMPT_MODULES[0]-}" = "$found" ]; then
              return 0
            fi
            __bashPromptRemove "$usage" "$found" || return $?
            ! $verbose || decorate info "Moving bash module to first: $(decorate code "$argument")"
          else
            ! $verbose || decorate info "Added bash module: $(decorate code "$argument")"
          fi
          __BASH_PROMPT_MODULES=("$argument" "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}")
        else
          if [ -n "$found" ]; then
            if ! $last || [ "${__BASH_PROMPT_MODULES[${#__BASH_PROMPT_MODULES[@]} - 1]}" = "$argument" ]; then
              return 0
            fi
            __bashPromptRemove "$usage" "$found" || return $?
            ! $verbose || decorate info "Moving bash module to last: $(decorate code "$argument")"
          else
            ! $verbose || decorate info "Added bash module: $(decorate code "$argument")"
          fi
          __BASH_PROMPT_MODULES=("${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}" "$argument")
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  return 0
}

#
# Given a list of color names, generate the color codes in a :-separated list
# Requires: decorations read inArray decorate listJoin
bashPromptColorsFormat() {
  local index color colors=()
  local all=()

  while read -r color; do all+=("$color"); done < <(decorations)
  IFS=":" read -r -a colors <<<"$1:::::" || :
  for index in "${!colors[@]}"; do
    color="${colors[index]}"
    if inArray "$color" "${all[@]}"; then
      colors[index]="$(decorate "$color")"
    else
      colors[index]=""
    fi
    [ "$index" -le 4 ] || unset "colors[$index]"
  done
  colors+=("$(decorate reset)")
  printf "%s\n" "$(listJoin ":" "${colors[@]}")"
}

# Usage: {fn} usageFunction removeModule
# Fails if not found
# Requires: isArray read inArray decorate listJoin
__bashPromptRemove() {
  local usage="$1" module="$2" current modules=() found=false

  __bashPromptSanity

  for current in "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}"; do

    if [ "$module" = "$current" ]; then
      found=true
    else
      modules+=("$current")
    fi
  done

  if ! $found; then
    local moduleList
    [ "${#__BASH_PROMPT_MODULES[@]}" -eq 0 ] && moduleList="$(decorate warning none)" || moduleList=$(decorate each code "${__BASH_PROMPT_MODULES[@]}")
    __throwEnvironment "$usage" "$module was not found in modules: $moduleList" || return $?
  fi
  __BASH_PROMPT_MODULES=("${modules[@]+"${modules[@]}"}")
}

__bashPromptFormat() {
  local formatString="$1"

  while read -r token replacement; do
    formatString=$(stringReplace "{${token}}" "$replacement" "$formatString")
  done < <(__bashPromptCode)
  printf -- "%s%s%s" "\[\${__BASH_PROMPT_MARKERS[0]-}\]" "$formatString" "\[\${__BASH_PROMPT_MARKERS[1]-}\]"
}

__bashPromptGeneratePS1() {
  __bashPromptFormat "$@"
}

# Internal documentation - do not depend on this external of this file:
#
# __BASH_PROMPT_PREVIOUS[0] - successText
# __BASH_PROMPT_PREVIOUS[1] - failureText
# __BASH_PROMPT_PREVIOUS[2] - label
# __BASH_PROMPT_PREVIOUS[3] - return code
# __BASH_PROMPT_PREVIOUS[4] - return color
# __BASH_PROMPT_PREVIOUS[5] - return text
# __BASH_PROMPT_PREVIOUS[6] - return string

__bashPromptHideEscapes() {
  printf -- "\[%s\]%s\[%s\]" "$1" "$2" "$3"
}

__bashPromptCode() {
  local colors=() reset
  reset="$(decorate reset)"
  export BUILD_PROMPT_COLORS __BASH_PROMPT_PREVIOUS
  IFS=":" read -r -a colors <<<"${BUILD_PROMPT_COLORS-}" || :
  printf "%s %s\n" \
    "$" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[4]-}" "\$" "$reset")" \
    "code" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[4]-}" "\${__BASH_PROMPT_PREVIOUS[3]#0}" "$reset")" \
    "return" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[4]-}" "\${__BASH_PROMPT_PREVIOUS[6]}" "$reset")" \
    "status" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[4]-}" "\${__BASH_PROMPT_PREVIOUS[5]-}" "$reset")" \
    "label" "\${__BASH_PROMPT_PREVIOUS[2]-}" \
    "user" "$(__bashPromptHideEscapes "${colors[2]-}" "\u" "$reset")" \
    "host" "$(__bashPromptHideEscapes "${colors[3]-}" "\h" "$reset")" \
    "directory" "$(__bashPromptHideEscapes "${colors[4]-}" "\w" "$reset")" \
    "reset" "\[$reset\]"
}

# This is the main command running each command prompt
__bashPromptCommand() {
  local exitCode=$?

  __bashPromptSanity

  # Index 0 1 2 3
  __BASH_PROMPT_PREVIOUS=("${__BASH_PROMPT_PREVIOUS[0]-}" "${__BASH_PROMPT_PREVIOUS[1]-}" "${__BASH_PROMPT_PREVIOUS[2]-}" "$exitCode")
  local colors
  export BUILD_PROMPT_COLORS
  IFS=":" read -r -a colors <<<"${BUILD_PROMPT_COLORS-}" || :
  if [ "$exitCode" -eq 0 ]; then
    # Index 4 - color
    __BASH_PROMPT_PREVIOUS+=("${colors[0]-}")
    # Index 5 - text
    __BASH_PROMPT_PREVIOUS+=("${__BASH_PROMPT_PREVIOUS[0]-}")
    # Index 6 - code text
    __BASH_PROMPT_PREVIOUS+=("")
  else
    # Index 4 - color
    __BASH_PROMPT_PREVIOUS+=("${colors[1]-}")
    # Index 5 - text
    __BASH_PROMPT_PREVIOUS+=("${__BASH_PROMPT_PREVIOUS[1]-}")
    # Index 6 - code text
    __BASH_PROMPT_PREVIOUS+=("$(exitString "$exitCode")")
  fi

  local debug=false
  ! buildDebugEnabled bashPrompt || debug=true

  local promptCommand
  for promptCommand in "${__BASH_PROMPT_MODULES[@]}"; do
    if isFunction "$promptCommand"; then
      ! $debug || decorate warning "Running $(decorate code "$promptCommand")"
      "$promptCommand"
    else
      ! $debug || decorate warning "Sourcing $(decorate code "$promptCommand")"
      # shellcheck source=/dev/null
      . "$promptCommand"
    fi
  done
  return $exitCode
}
