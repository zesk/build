#!/usr/bin/env bash
#
# Bash Prompt Tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: ./docs/_templates/tools/prompt.md
# Test: ./test/tools/prompt-tests.sh

# shellcheck disable=SC2120
__consoleBlackWhiteBackground() {
  __consoleEscape '\033[107;30m' '\033[0m' "$@"
}

__bashPromptList() {
  local promptCommand

  for promptCommand in "${__BASH_PROMPT_MODULES[@]}"; do
    if isFunction "$promptCommand"; then
      printf -- "- %s (%s)\n" "$(consoleCode "$promptCommand")" "$(consoleOrange "function")"
    else
      printf -- "- %s (%s)\n" "$(consoleValue "$promptCommand")" "$(consoleBlue "file")"
    fi
  done
}

# Usage: {fn} [ --first | --last | module ]
# Argument: --first - Flag. Optional. All subsequent modules are added first to the list.
# Argument: --last - Flag. Optional. ALl subsequent modules are added to the end of the list.
# Argument: module - Callable. Required. The module to add
__bashPromptAdd() {
  local usage="$1" && shift
  local argument nArguments argumentIndex saved
  local first=false debug=false verbose=false found

  export __BASH_PROMPT_MODULES
  if ! isArray "__BASH_PROMPT_MODULES"; then
    __BASH_PROMPT_MODULES=()
  fi

  ! $debug || consoleInfo "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      --verbose)
        verbose=true
        ;;
      --debug)
        debug=true
        ;;
      --first)
        first=true
        ;;
      --last)
        first=false
        ;;
      *)
        isCallable "$argument" || __failArgument "$usage" "$argument must be executable or a function" || return $?
        found=false
        ! inArray "$argument" "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}" || found=true
        if $first; then
          ! $debug || consoleInfo "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
          if $found; then
            if [ "${__BASH_PROMPT_MODULES[0]-}" != "$argument" ]; then
              return 0
            fi
            __bashPromptRemove "$usage" "$argument" || return $?
            ! $debug || consoleInfo "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
            ! $verbose || consoleInfo "Moving bash module to first: $(consoleCode "$argument")"
          else
            ! $verbose || consoleInfo "Added bash module: $(consoleCode "$argument")"
          fi
          __BASH_PROMPT_MODULES=("$argument" "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}")
        else
          ! $debug || consoleInfo "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
          if $found; then
            if [ "${__BASH_PROMPT_MODULES[${#__BASH_PROMPT_MODULES[@]} - 1]}" != "$argument" ]; then
              return 0
            fi
            __bashPromptRemove "$usage" "$argument" || return $?
            ! $debug || consoleInfo "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
            ! $verbose || consoleInfo "Moving bash module to last: $(consoleCode "$argument")"
          else
            ! $verbose || consoleInfo "Added bash module: $(consoleCode "$argument")"
          fi
          __BASH_PROMPT_MODULES=("${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}" "$argument")
        fi
        ! $debug || consoleInfo "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  ! $debug || consoleInfo "$LINENO: $(_command MODULES: "${__BASH_PROMPT_MODULES[@]}")"
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
  $found || __failEnvironment "$usage" "$module was not found in $(_list modules: "${__BASH_PROMPT_MODULES[@]+"${__BASH_PROMPT_MODULES[@]}"}")" || return $?
  __BASH_PROMPT_MODULES=("${modules[@]}")
}

#
# Check which bin/build we are running and keep local to current project
# When changing projects, runs the `project-selected` hook in the new project
# Also shows the change in Zesk Build version numbers
#
# Run-Hook: project-selected
bashPromptModule_binBuild() {
  local home gitHome tools="bin/build/tools.sh" version="bin/build/build.json" oldColor=consoleRed newColor=consoleRed oldVersion newVersion message
  home=$(__environment buildHome) || return $?
  gitHome=$(gitFindHome "$(pwd)" 2>/dev/null) || return 0
  [ "$home" != "$gitHome" ] || return 0
  [ -x "$gitHome/$tools" ] || return 0
  oldVersion="$(jq .version "$home/$version")"
  newVersion="$(jq .version "$gitHome/$version")"
  newestVersion="$(printf -- "%s\n" "$oldVersion" "$newVersion" | versionSort | tail -n 1)"
  [ "$oldVersion" != "$newestVersion" ] || oldColor=consoleBlue
  [ "$newVersion" != "$newestVersion" ] || newColor=consoleGreen
  # shellcheck source=/dev/null
  source "$gitHome/$tools" || __environment "Failed ot load $gitHome/$tools" || return $?
  # buildHome will be changed here
  message="$(runOptionalHook project-selected "$gitHome")"
  printf -- "%s %s -> %s @ %s\n" "$message" "$("$oldColor" "$oldVersion")" "$("$newColor" "$newVersion")" "$(consoleCode "$(buildHome)")"
}

# Usage: {fn} [ --first | --last | module ] [ --colors colorsText ]
# Argument: --reset - Flag. Optional. Remove all prompt modules.
# Argument: --list - Flag. Optional. List the current modules.
# Argument: --first - Flag. Optional. Add all subsequent modules first to the list.
# Argument: --last - Flag. Optional. Add all subsequent modules last to the list.
# Argument: module - String. Optional. Module to enable or disable. To disable, specify `-module`
# Argument: --colors colorsText - String. Optional. Set the prompt colors
# Argument: --skip-terminal - Flag. Optional. Skip the check for a terminal attached to standard in.
# Bash prompt creates a prompt and adds return code status display and modules
# Modules are any binary or executable to run each prompt, and can be added or removed here
# - `defaultTitle`
# Example: bashPrompt --colors "$(consoleBoldCyan):$(consoleBoldMagenta):$(consoleGreen):$(consoleOrange):$(consoleCode)"
bashPrompt() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local skipTerminal=false addArguments=() colorsText="" colors resetFlag=false verbose=false

  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
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
        IFS=":" read -r -a colors <<<"$colorsText" || :
        [ "${#colors[@]}" -ge 2 ] || __failArgument "$usage" "$argument should be min 2 colors separated by a colon: $(consoleCode "$colorsText")" || return $?
        [ "${#colors[@]}" -le 5 ] || __failArgument "$usage" "$argument should be max 5 colors separated by a colon: $(consoleCode "$colorsText")" || return $?
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
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  $skipTerminal || [ -t 0 ] || __failEnvironment "$usage" "Requires a terminal" || return $?

  export PROMPT_COMMAND PS1 __PREVIOUS_RESULT __PREVIOUS_PREFIX __PREVIOUS_SYMBOL __BASH_PROMPT_MODULES BUILD_PROMPT_COLORS

  if $resetFlag; then
    __BASH_PROMPT_MODULES=()
    ! $verbose || consoleInfo "Prompt modules reset to empty list."
  fi
  # IDENTICAL bashPromptAddArguments 3
  if [ ${#addArguments[@]} -gt 0 ]; then
    __bashPromptAdd "$usage" "${addArguments[@]+"${addArguments[@]}"}" || return $?
  fi

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_PROMPT_COLORS || return $?

  [ -z "$colorsText" ] || BUILD_PROMPT_COLORS="${colorsText}"
  [ -n "${BUILD_PROMPT_COLORS-}" ] || BUILD_PROMPT_COLORS="$(bashPromptColorScheme default)"

  PROMPT_COMMAND=__bashPromptCommand
  PS1="$(__bashPromptGeneratePS1)"
}
_bashPrompt() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Color schemes for prompts
# Options are:
# - forest
# - default
bashPromptColorScheme() {
  local colors
  case "$1" in
    forest) colors="$(consoleBoldCyan):$(consoleBoldMagenta):$(consoleGreen):$(consoleOrange):$(consoleCode)" ;;
    *) colors="$(consoleGreen):$(consoleRed):$(consoleMagenta):$(consoleBlue):$(consoleBold)$(__consoleBlackWhiteBackground)" ;;
  esac
  printf "%s" "$colors"
}

# Prompt is the following literal tokens concatenated:
# - user
# - "@"
# - host
# - " "
# - CWD
# - " "
# - exit status ">" or "X"
# - " "
__bashPromptGeneratePS1() {
  local colors reset
  export BUILD_PROMPT_COLORS
  reset="$(consoleReset)"
  IFS=":" read -r -a colors <<<"${BUILD_PROMPT_COLORS-}"
  printf "%s@%s %s %s " \
    "\[${colors[2]-}\]\u\[${reset}\]" \
    "\[${colors[3]-}\]\h" \
    "\[${colors[4]-}\]\w\[${reset}\]" \
    "\[\$__PREVIOUS_PREFIX\]\$__PREVIOUS_SYMBOL\[${reset}\]"
}
__bashPromptCommand() {
  __PREVIOUS_RESULT=$?
  local colors promptCommand
  export BUILD_PROMPT_COLORS
  IFS=":" read -r -a colors <<<"${BUILD_PROMPT_COLORS-}"
  if [ "$__PREVIOUS_RESULT" -eq 0 ]; then
    __PREVIOUS_PREFIX="${colors[0]-}"
    __PREVIOUS_SYMBOL=">"
  else
    # Space here is required here for the X only for some reason
    __PREVIOUS_PREFIX="${colors[1]-}"
    __PREVIOUS_SYMBOL="§"
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
