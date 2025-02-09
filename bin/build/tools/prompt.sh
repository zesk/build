#!/usr/bin/env bash
#
# Bash Prompt Tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/prompt.md
# Test: ./test/tools/prompt-tests.sh

__bashPromptList() {
  local promptCommand

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

  export __BASH_PROMPT_MODULES
  if ! isArray "__BASH_PROMPT_MODULES"; then
    __BASH_PROMPT_MODULES=()
  fi

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

# Usage: {fn} usageFunction removeModule
# Fails if not found
__bashPromptRemove() {
  local usage="$1" module="$2" current modules=() found=false

  export __BASH_PROMPT_MODULES
  if ! isArray "__BASH_PROMPT_MODULES"; then
    __BASH_PROMPT_MODULES=()
  fi
  for current in "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}"; do
    if [ "$module" = "$current" ]; then
      found=true
    else
      modules+=("$current")
    fi
  done
  $found || __throwEnvironment "$usage" "$module was not found in modules: $(decorate each code "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}")" || return $?
  __BASH_PROMPT_MODULES=("${modules[@]+"${modules[@]}"}")
}

# Usage: {fn} [ --first | --last | module ] [ --colors colorsText ]
# Argument: --reset - Flag. Optional. Remove all prompt modules.
# Argument: --list - Flag. Optional. List the current modules.
# Argument: --first - Flag. Optional. Add all subsequent modules first to the list.
# Argument: --last - Flag. Optional. Add all subsequent modules last to the list.
# Argument: --label promptLabel - String. Optional. Display this label on each prompt.
# Argument: module - String. Optional. Module to enable or disable. To disable, specify `-module`
# Argument: --colors colorsText - String. Optional. Set the prompt colors
# Argument: --skip-terminal - Flag. Optional. Skip the check for a terminal attached to standard in.
# Bash prompt creates a prompt and adds return code status display and modules
# Modules are any binary or executable to run each prompt, and can be added or removed here
# - `consoleDefaultTitle`
# Example: bashPrompt --colors "$(decorate bold-cyan):$(decorate bold-magenta):$(decorate green):$(decorate orange):$(decorate code)"
# Environment: PROMPT_COMMAND
bashPrompt() {
  local usage="_${FUNCNAME[0]}"

  local label=$'\0' addArguments=() colorsText="" resetFlag=false verbose=false skipTerminal=false

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
      --label)
        shift
        label="$(usageArgumentEmptyString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --list)
        # IDENTICAL bashPromptAddArguments 3
        if [ ${#addArguments[@]} -gt 0 ]; then
          __bashPromptAdd "$usage" "${addArguments[@]+"${addArguments[@]}"}" || return $?
        fi
        addArguments=()
        __bashPromptList
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
        if [ "${argument#-}" != "$argument" ]; then
          __bashPromptRemove "$usage" "${argument#-}" || return $?
        else
          addArguments+=("$argument")
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  $skipTerminal || [ -t 0 ] || __throwEnvironment "$usage" "Requires a terminal" || return $?

  export PROMPT_COMMAND PS1 __BASH_PROMPT_PREVIOUS __BASH_PROMPT_MODULES BUILD_PROMPT_COLORS

  if $resetFlag; then
    __BASH_PROMPT_MODULES=()
    ! $verbose || decorate info "Prompt modules reset to empty list."
  fi
  # IDENTICAL bashPromptAddArguments 3
  if [ ${#addArguments[@]} -gt 0 ]; then
    __bashPromptAdd "$usage" "${addArguments[@]+"${addArguments[@]}"}" || return $?
  fi

  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_PROMPT_COLORS || return $?

  [ -z "$colorsText" ] || BUILD_PROMPT_COLORS="${colorsText}"
  [ -n "${BUILD_PROMPT_COLORS-}" ] || BUILD_PROMPT_COLORS="$(bashPromptColorScheme default)"

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
  if [ "$label" != $'\0' ]; then
    label="$label "
    __BASH_PROMPT_PREVIOUS=("${__BASH_PROMPT_PREVIOUS[0]-}" "$label")
  fi
  PS1="$(__bashPromptGeneratePS1)"
}
_bashPrompt() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Prompt the user properly honoring any attached console
# Arguments are the same as read, except:
# `-r` is implied and does not need to be specified
bashPromptUser() {
  local word

  export __BASH_PROMPT_MARKERS
  # Technically the reading program will not receive these bytes as they will be sent to the tty
  printf "%s" "${__BASH_PROMPT_MARKERS[0]-}" >>/dev/tty
  read -r "$@" word </dev/tty
  printf "%s" "${__BASH_PROMPT_MARKERS[1]-}" >>/dev/tty
  printf "%s\n" "$word"
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
  exitColor="$(decorate bold-green):$(decorate bold-red)"
  case "${1-}" in
    forest) colors="$(decorate bold-cyan):$(decorate bold-magenta):$(decorate green):$(decorate orange):$(decorate code)" ;;
    light) colors="$exitColor:$(decorate magenta):$(decorate blue):$(decorate bold-black)" ;;
    dark) colors="$exitColor:$(decorate magenta):$(decorate blue):$(decorate bold-white)" ;;
    *) colors="$exitColor:$(decorate magenta):$(decorate blue):$(decorate bold-black)" ;;
  esac
  printf -- "%s" "$colors"
}

# Prompt is the following literal tokens concatenated:
# - user
# - "@"
# - host
# - " "
# - CWD
# - " "
# - exit status ">" or "@"
# - " "
__bashPromptGeneratePS1() {
  local colors reset
  export BUILD_PROMPT_COLORS __BASH_PROMPT_PREVIOUS
  reset="$(decorate reset)"
  IFS=":" read -r -a colors <<<"${BUILD_PROMPT_COLORS-}" || :
  printf -- "%s%s%s@%s %s %s %s" \
    "\${__BASH_PROMPT_MARKERS[0]-}" \
    "\${__BASH_PROMPT_PREVIOUS[1]-}" \
    "\[${colors[2]-}\]\u\[${reset}\]" \
    "\[${colors[3]-}\]\h" \
    "\[${colors[4]-}\]\w\[${reset}\]" \
    "\[\${__BASH_PROMPT_PREVIOUS[2]-}\]\${__BASH_PROMPT_PREVIOUS[3]-}\[${reset}\]" \
    "\${__BASH_PROMPT_MARKERS[1]-}"
}

# This is the main command running each command prompt
__bashPromptCommand() {
  __BASH_PROMPT_PREVIOUS=("$?" "${__BASH_PROMPT_PREVIOUS[1]-}")
  local colors promptCommand
  export BUILD_PROMPT_COLORS
  IFS=":" read -r -a colors <<<"${BUILD_PROMPT_COLORS-}" || :
  if [ "${__BASH_PROMPT_PREVIOUS[0]}" -eq 0 ]; then
    __BASH_PROMPT_PREVIOUS+=("${colors[0]-}")
    __BASH_PROMPT_PREVIOUS+=(">")
  else
    __BASH_PROMPT_PREVIOUS+=("${colors[1]-}")
    __BASH_PROMPT_PREVIOUS+=("§")
  fi
  for promptCommand in "${__BASH_PROMPT_MODULES[@]}"; do
    if isFunction "$promptCommand"; then
      "$promptCommand"
    else
      # shellcheck source=/dev/null
      . "$promptCommand"
    fi
  done
}
