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
# Argument: --list - Flag. Optional. List the current modules. Modules are also added or removed, otherwise no changes are made.
# Argument: --first - Flag. Optional. Add all subsequent modules first to the list.
# Argument: --last - Flag. Optional. Add all subsequent modules last to the list.
# Argument: --order order - UnsignedInteger. Optional. Set the order index for this prompt. 0 is first, higher numbers are later.
# Argument: --format promptFormat - String. Optional. Display this label on each prompt.
# Argument: --success successText - EmptyString. Optional. Text to display in the prompt when the previous command succeeded.
# Argument: --failure failureText - EmptyString. Optional. Text to display in the prompt when the previous command failed.
# Argument: --label promptLabel - String. Optional. The prompt format string. See PROMPT FORMATTING below
# Argument: --colors colorsText - String. Optional. Set the prompt colors. See COLORS below.
# Argument: --skip-terminal - Flag. Optional. Skip the check for a terminal attached to `stdin`.
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
  local usage="_${FUNCNAME[0]}"

  local addArguments=() resetFlag=false verbose=false skipTerminal=false listFlag=false skipPrompt=false

  export __BASH_PROMPT_PREVIOUS

  isArray __BASH_PROMPT_PREVIOUS || __BASH_PROMPT_PREVIOUS=()

  local colorsText=""
  local promptFormat="" successPrompt="${__BASH_PROMPT_PREVIOUS[0]-}" failurePrompt="${__BASH_PROMPT_PREVIOUS[1]-}" colorsTextFormatted="${__BASH_PROMPT_PREVIOUS[2]-}" label="${__BASH_PROMPT_PREVIOUS[3]-}"

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
    --skip-prompt)
      skipPrompt=true
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
      colorsTextFormatted=$(bashPromptColorsFormat "${colorsText}")
      ;;
    --first | --last | --debug)
      addArguments+=("$argument")
      ;;
    --order)
      shift
      order=$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}") || return $?
      addArguments+=("$argument" "$order")
      ;;
    --verbose)
      verbose=true
      ;;
    -*)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    *)
      addArguments+=("$(usageArgumentCallable "$usage" "module" "$argument")") || return $?
      ;;
    esac
    shift
  done

  if [ ${#addArguments[@]} -gt 0 ]; then
    __bashPromptAdd "$usage" "${addArguments[@]+"${addArguments[@]}"}" || return $?
  fi

  if $listFlag; then
    __bashPromptList
    return 0
  fi

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

  if [ -z "$colorsTextFormatted" ] || $resetFlag; then
    if ! $resetFlag; then
      __catchEnvironment "$usage" buildEnvironmentLoad BUILD_PROMPT_COLORS || return $?
      [ -z "${BUILD_PROMPT_COLORS-}" ] || colorsText="$BUILD_PROMPT_COLORS"
    fi
    if $resetFlag || [ -z "$colorsText" ]; then
      colorsText=$(bashPromptColorScheme default)
    fi
    colorsTextFormatted=$(bashPromptColorsFormat "${colorsText}")
  fi

  local colors=()
  IFS=":" read -r -a colors <<<"$colorsTextFormatted"

  isArray __BASH_PROMPT_PREVIOUS || __BASH_PROMPT_PREVIOUS=()
  __BASH_PROMPT_PREVIOUS=("$successPrompt" "$failurePrompt" "$colorsTextFormatted" "$label" 0 "${colors[0]}" "$successPrompt" "")

  # Skip prompt on time
  ! $skipPrompt || return 0

  local theCommand="__bashPromptCommand"
  if [ -n "${PROMPT_COMMAND-}" ] && [ "${PROMPT_COMMAND#*"$theCommand"}" = "$PROMPT_COMMAND" ]; then
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
  export PS1
  PS1="$(__bashPromptFormat "$promptFormat" "$colorsTextFormatted")"
}
_bashPrompt() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Prompt the user properly honoring any attached console
# Arguments are the same as read, except:
# `-r` is implied and does not need to be specified
bashUserInput() {
  local usage="_${FUNCNAME[0]}"
  local word="" exitCode=0

  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  if ! isTTYAvailable; then
    __throwEnvironment "$usage" "No TTY available for user input" || return $?
  fi
  export __BASH_PROMPT_MARKERS
  # Technically the reading program will not receive these bytes as they will be sent to the tty
  printf "%s" "${__BASH_PROMPT_MARKERS[0]-}" >>/dev/tty
  read -r "$@" word </dev/tty || exitCode=$?
  printf "%s" "${__BASH_PROMPT_MARKERS[1]-}" >>/dev/tty
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
    shift
  done
  [ "${#markers[@]}" -le 2 ] || __throwArgument "$usage" "Maximum two markers supported (prefix suffix)"
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
    local order=${promptCommand%%:*}
    promptCommand=${promptCommand#[0-9]*:}
    if isFunction "$promptCommand"; then
      printf -- "- %s (%s) %s\n" "$(decorate code "$promptCommand")" "$(decorate orange "function")" "$(decorate subtle "[$order]")"
    else
      printf -- "- %s (%s) %s\n" "$(decorate value "$promptCommand")" "$(decorate blue "file")" "$(decorate subtle "[$order]")"
    fi
  done
}

# Usage: {fn} [ --first | --last | module ]
# Argument: --first - Flag. Optional. All subsequent modules are added first to the list.
# Argument: --last - Flag. Optional. ALl subsequent modules are added to the end of the list.
# Argument: --order ordering - UnsignedInteger. Ordering of the prompt call. 0 is first, higher numbers are last. Capped at 99.
# Argument: module - Callable. Required. The module to add
__bashPromptAdd() {
  local usage="$1" && shift

  local order=50

  __bashPromptSanity

  export __BASH_PROMPT_MODULES
  local modules=("${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}")

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    --order)
      shift
      order=$(usageArgumentUnsignedInteger "$usage" "$argument" "${1-}") || return $?
      [ "$order" -gt 0 ] || order=0
      [ "$order" -lt 99 ] || order=99
      ;;
    --first)
      order=0
      ;;
    --last)
      order=99
      ;;
    *)
      local module mm=()
      for module in "${modules[@]+"${modules[@]}"}"; do
        [ "${argument}" = "${module#[0-9]*:}" ] || mm+=("$module")
      done
      modules=("${mm[@]+"${mm[@]}"}" "$order:$argument")
      ;;
    esac
    shift
  done

  __catchEnvironment "$usage" __bashPromptModulesSave "${modules[@]}" || return $?
  return 0
}

__bashPromptModulesSave() {
  export __BASH_PROMPT_MODULES
  IFS=$'\n' read -d '' -r -a __BASH_PROMPT_MODULES < <(printf "%s\n" "$@" | sort -n | sort -u) || :
}

# Usage: {fn} usageFunction removeModule
# Fails if not found
# Requires: isArray read inArray decorate listJoin
__bashPromptRemove() {
  local usage="$1" module="$2" current modules=() found=false

  __bashPromptSanity

  for current in "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}"; do
    if [ "$module" = "${current#[0-9]*:}" ]; then
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

__bashPromptFormat() {
  local formatString="${1-}" && shift || _argument "${FUNCNAME[0]}:$LINENO" || return $?
  local colorsTextFormatted="${1-}" && shift || _argument "${FUNCNAME[0]}:$LINENO" || return $?

  if [ -n "$formatString" ]; then
    while read -r token replacement && [ "${formatString#*{}" != "$formatString" ]; do
      formatString=$(stringReplace "{${token}}" "$replacement" "$formatString")
    done < <(__bashPromptCode "$colorsTextFormatted")
  fi
  printf -- "%s%s%s" "\[\${__BASH_PROMPT_MARKERS[0]-}\]" "$formatString" "\[\${__BASH_PROMPT_MARKERS[1]-}\]"
}

# Internal documentation - do not depend on this external of this file:
#
# __BASH_PROMPT_PREVIOUS[0] - successText
# __BASH_PROMPT_PREVIOUS[1] - failureText
# __BASH_PROMPT_PREVIOUS[2] - colors
# __BASH_PROMPT_PREVIOUS[3] - label
# __BASH_PROMPT_PREVIOUS[4] - return code
# __BASH_PROMPT_PREVIOUS[5] - return color
# __BASH_PROMPT_PREVIOUS[6] - return text
# __BASH_PROMPT_PREVIOUS[7] - return string

__bashPromptHideEscapes() {
  printf -- "\[%s\]%s\[%s\]" "$1" "$2" "$3"
}

# Environment: __BASH_PROMPT_PREVIOUS
__bashPromptCode() {
  local colors=() reset colorFormat="${1-}" && shift || return $?
  reset="$(decorate reset --)"
  IFS=":" read -r -a colors <<<"$colorFormat" || :
  printf "%s %s\n" \
    "$" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[5]-}" "\$" "$reset")" \
    "code" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[5]-}" "\${__BASH_PROMPT_PREVIOUS[4]#0}" "$reset")" \
    "return" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[5]-}" "\${__BASH_PROMPT_PREVIOUS[7]}" "$reset")" \
    "status" "$(__bashPromptHideEscapes "\${__BASH_PROMPT_PREVIOUS[5]-}" "\${__BASH_PROMPT_PREVIOUS[6]-}" "$reset")" \
    "label" "\${__BASH_PROMPT_PREVIOUS[3]-}" \
    "user" "$(__bashPromptHideEscapes "${colors[2]-}" "\u" "$reset")" \
    "host" "$(__bashPromptHideEscapes "${colors[3]-}" "\h" "$reset")" \
    "directory" "$(__bashPromptHideEscapes "${colors[4]-}" "\w" "$reset")" \
    "reset" "\[$reset\]"
}

# This is the main command running each command prompt
__bashPromptCommand() {
  local exitCode=$?

  export __BASH_PROMPT_PREVIOUS

  # Index 0 1 2 3 4
  __BASH_PROMPT_PREVIOUS=("${__BASH_PROMPT_PREVIOUS[0]-}" "${__BASH_PROMPT_PREVIOUS[1]-}" "${__BASH_PROMPT_PREVIOUS[2]-}" "${__BASH_PROMPT_PREVIOUS[3]-}" "$exitCode")
  local colors
  IFS=":" read -r -a colors <<<"${__BASH_PROMPT_PREVIOUS[2]-}" || :
  if [ "$exitCode" -eq 0 ]; then
    # Index 5 - color
    __BASH_PROMPT_PREVIOUS+=("${colors[0]-}")
    # Index 6 - text
    __BASH_PROMPT_PREVIOUS+=("${__BASH_PROMPT_PREVIOUS[0]-}")
    # Index 7 - code text
    __BASH_PROMPT_PREVIOUS+=("")
  else
    # Index 5 - color
    __BASH_PROMPT_PREVIOUS+=("${colors[1]-}")
    # Index 6 - text
    __BASH_PROMPT_PREVIOUS+=("${__BASH_PROMPT_PREVIOUS[1]-}")
    # Index 7 - code text
    __BASH_PROMPT_PREVIOUS+=("$(exitString "$exitCode")")
  fi

  local debug=false
  ! buildDebugEnabled bashPrompt || debug=true
  ! $debug || statusMessage decorate warning "Running $(decorate each --count code "${__BASH_PROMPT_MODULES[@]}") "

  local promptCommand start
  for promptCommand in "${__BASH_PROMPT_MODULES[@]}"; do
    promptCommand="${promptCommand#[0-9]*:}"
    if isFunction "$promptCommand"; then
      ! $debug || statusMessage decorate warning "Running $(decorate code "$promptCommand") "
      start=$(timingStart)
      "$promptCommand"
      ! $debug || timingReport "$start"
    else
      ! $debug || statusMessage decorate warning "Sourcing $(decorate code "$promptCommand")"
      start=$(timingStart)
      # shellcheck source=/dev/null
      . "$promptCommand"
      ! $debug || timingReport "$start"
    fi
  done
  return $exitCode
}
