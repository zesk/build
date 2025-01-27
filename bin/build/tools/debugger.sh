#!/usr/bin/env bash
#
# bashDebug and related
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# bin: set test
# Docs: o ./docs/_templates/tools/debug.md
# Test: o ./test/tools/debug-tests.sh

# Simple debugger to walk through a program
#
# Usage: {fn} commandToDebug ...
# Argument: commandToDebug - Callable. Required. Command to debug.
#
# Debugger accepts the following keystrokes:
#
# ### Flow control
#
# - `.` or ` ` or Return - Repeat last flow command
#
# - `j`         - Skip next command (jump over)
# - `s` or `n`  - Step to next command (step)
# - `i` or `d`  - Step into next command (follow)
# - `q`         - Quit debugger (and continue execution)
# - `!`         - Enter a command to execute
#
# ### Watching
#
# - `w`         - Enter a watch expression
# - `u`         - Remove a watch expression
#
# ### Utilities
#
# `k`         - Display call stack
# `*`         - Add an interrupt handler to capture the stack upon interrupt (SIGINT, or Ctrl-C from a console)
# `h` or `?`  - This help
#
bashDebug() {
  __help "$@" || return 0
  bashDebuggerEnable
  "$@"
  bashDebuggerDisable
}
_bashDebug() {
  # _IDENTICAL_ usageDocument 1
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Enables the debugger immediately
# See: bashDebug
# See: bashDebuggerDisable
# Saves file descriptors 0 1 and 2 as 20, 21 and 22 respectively
bashDebuggerEnable() {
  export __BUILD_BASH_DEBUG_WATCH __BUILD_BASH_STEP_CONTROL __BUILD_BASH_DEBUG_LAST

  __BUILD_BASH_DEBUG_WATCH=()
  __BUILD_BASH_STEP_CONTROL=()
  __BUILD_BASH_DEBUG_LAST="step"

  # Save ORIGINAL FDs for later
  exec 20<&0 21>&1 22>&2
  # <& is input copy := so
  # >& is output copy := so
  # 20 := 0, 21 := 1, 22 := 2
  # 20 is a copy of 0, etc.

  set -o functrace
  shopt -s extdebug
  trap _bashDebugTrap DEBUG
}

# Disables the debugger immediately
# See: bashDebug
# See: bashDebuggerEnable
# Restores file descriptors 0 1 and 2 from 20, 21 and 22 respectively
bashDebuggerDisable() {
  trap - DEBUG
  unset __BUILD_BASH_DEBUG_WATCH __BUILD_BASH_STEP_CONTROL __BUILD_BASH_DEBUG_LAST
  shopt -u extdebug
  set +o functrace

  # Restore ORIGINAL FDs
  exec 0<&20 1>&21 2>&22

  # Close ORIGINAL FDs
  exec 20<&- 21>&- 22>&-
}

# Display the watch variables, if any
_bashDebugWatch() {
  export __BUILD_BASH_DEBUG_WATCH
  # isArray __BUILD_BASH_DEBUG_WATCH || __BUILD_BASH_DEBUG_WATCH=()
  [ "${#__BUILD_BASH_DEBUG_WATCH[@]}" -gt 0 ] || return 0
  local __item __index=0
  for __item in "${__BUILD_BASH_DEBUG_WATCH[@]}"; do
    if ! __value="$(eval "printf \"%s\n\" \"$__item\"" 2>/dev/null)"; then
      __value="$(decorate red "unbound")"
    else
      __value="\"$(decorate code "$__value")\""
    fi
    printf -- "%2d: WATCH %s: %s\n" "$__index" "$__item" "$__value"
    __index=$((__index + 1))
  done
}

# Usage: {fn} currentSource currentFunction currentLine source0 function0 line0 [ source1 function1 line1 ... ]
# Argument count is always a multiple of 3
__bashDebugStep() {
  local source="$1" functionName="$2" line="$3" && shift 3

  [ $(($# % 3)) -eq 0 ] || _argument "__bashDebugStep $1 $2 $3: $# % 3 != 0" || return 1
  while [ $# -gt 0 ]; do
    checkSource="$1" checkFunctionName="$2" checkLine="$3"
    if [ "$checkSource" = "$source" ] && [ "$checkFunctionName" = "$functionName" ] && [ "$line" -gt "$checkLine" ]; then
      return 1
    fi
    shift 3
  done
}

__bashDebugWhere() {
  local index="${1-0}" __where
  export BUILD_HOME
  __where="$(realPath "${BASH_SOURCE[index + 2]}")"
  __where="${__where#"$BUILD_HOME"}"
  printf -- "%s:%s\n" "$(decorate value "$__where")" "$(decorate bold-blue "${BASH_LINENO[index + 1]}")"
}

# Internal trap to capture DEBUG events and allow control
# See: bashDebug
_bashDebugTrap() {
  export __BUILD_BASH_STEP_CONTROL
  if [ "${#__BUILD_BASH_STEP_CONTROL[@]}" -gt 0 ]; then
    [ "${BASH_SOURCE[1]}" != "${BASH_SOURCE[0]}" ] || return 0
    if __bashDebugStep "${BASH_SOURCE[1]}" "${FUNCNAME[1]}" $((BASH_LINENO[0] + 1)) "${__BUILD_BASH_STEP_CONTROL[@]}"; then
      return 0
    fi
    __BUILD_BASH_STEP_CONTROL=()
  fi
  case "$BASH_COMMAND" in
    bashDebuggerDisable | "trap - DEBUG" | '"$@"') return 0 ;;
    *) ;;
  esac

  local __where __command __item __value __rightArrow="➡️"

  export BUILD_HOME __BUILD_BASH_DEBUG_WATCH __BUILD_BASH_DEBUG_LAST

  # Save Application FDs
  exec 30<&0 31>&1 32>&2
  # <& is input copy := so
  # >& is output copy := so
  # 30 := 0, 31 := 1, 32 := 2
  # 30 is a copy of 0, etc.

  # Restore ORIGINAL FDs
  exec 0<&20 1>&21 2>&22

  local __topIndex=1
  printf "%s %s %s %s %s %s @ %s %s %s\n" "$(decorate code "${FUNCNAME[__topIndex + 2]-}")" "$__rightArrow" "$(decorate code "${FUNCNAME[__topIndex + 1]}")" "$__rightArrow" "$(decorate code "${FUNCNAME[__topIndex]}")" "$(decorate subtle "[${#FUNCNAME[@]}]")" "$(__bashDebugWhere 1)" ">" "$(__bashDebugWhere)"

  _bashDebugWatch
  printf -- "%s %s\n" "$(decorate green ">")" "$(decorate code "$BASH_COMMAND")"
  local __error="" __return=0
  while read -n 1 -s -r -p "${__error}bashDebug $(decorate code "[$__BUILD_BASH_DEBUG_LAST]")> " __command; do
    local __aa=("$__command")
    __return=0
    case "$__command" in
      "." | " " | "" | $'\r')
        __command="${__BUILD_BASH_DEBUG_LAST:0:1}"
        if [ -z "$__command" ]; then
          __error="$(decorate error "No last command")"
          __return=1
          __aa=()
        else
          # Repeat last command
          __aa=("${__BUILD_BASH_DEBUG_LAST:0:1}")
          [ ${#__BUILD_BASH_DEBUG_LAST} -eq 1 ] || __aa+=("${__BUILD_BASH_DEBUG_LAST:1}")
        fi
        ;;
    esac
    statusMessage printf -- "Execute: $(decorate code "$__command")"
    [ "${#__aa[@]}" -eq 0 ] || __bashDebugExecuteCommand "${__aa[@]}" || __return=$?
    case $__return in
      0)
        # Continue code execution
        __error=""
        __return=0
        break
        ;;
      1)
        # Read another debugger command
        ;;
      2)
        # Skip next command
        __error=""
        __return=1
        break
        ;;
      3)
        # Debugger was terminated
        # Restore Application FDs
        exec 0<&30 1>&31 2>&32
        return 0
        ;;
    esac
    if [ -n "$__error" ]; then
      __error="${__error% } "
    fi
    statusMessage printf -- ""
  done
  # Save debugger FDs for later
  exec 20<&0 21>&1 22>&2

  # Restore Application FDs
  exec 0<&30 1>&31 2>&32

  return $__return
}

__bashDebugExecuteCommand() {
  local __command="$1" __arg="${2-}"

  export __BUILD_BASH_DEBUG_LAST

  # statusMessage printf -- "%s [%s] %s" __bashDebugExecuteCommand "$__command" "$__arg"
  # Uses calling scope
  __error=""
  case "$__command" in
    "*")
      statusMessage printf -- ""
      if bashDebugInterruptFile 2>/dev/null; then
        statusMessage --last decorate info "$(decorate file "$HOME/.interrupt") will be created on interrupt"
      else
        statusMessage --last decorate notice "Interrupt handler already installed."
      fi
      return 1
      ;;
    "j")
      decorate warning "Skipping $BASH_COMMAND"
      __BUILD_BASH_DEBUG_LAST="jump"
      return 2
      ;;
    "d" | "i")
      statusMessage printf -- ""
      __BUILD_BASH_DEBUG_LAST="into"
      return 0
      ;;
    "k")
      statusMessage --last decorate info "Call stack:"
      debuggingStack
      return 1
      ;;
    "s" | "n")
      __bashDebugCommandStep
      statusMessage printf -- ""
      __BUILD_BASH_DEBUG_LAST="step"
      return 0
      ;;
    "?" | "h")
      _bashDebug 0
      return 1
      ;;
    "u")
      statusMessage printf -- ""
      __bashDebugCommandUnwatch
      return 1
      ;;
    "w")
      statusMessage printf -- ""
      __bashDebugCommandWatch
      return 1
      ;;
    "q")
      statusMessage --last decorate notice "Debugger control ended."
      bashDebuggerDisable
      return 3
      ;;
    "!")
      statusMessage printf -- ""
      if [ -n "$__arg" ]; then
        __bashDebugCommandEvaluate "$__arg"
      else
        __bashDebugCommandEvaluateLoop
      fi
      return 1
      ;;
    *)
      __error="[$(decorate error " $__command ")]($(decorate value "$(characterToInteger "$__command")")) No such command"
      return 1
      ;;
  esac
}

__bashDebugCommandStep() {
  # statusMessage decorate notice "Stepping over ..."
  local i=0 total=$((${#FUNCNAME[@]} - 1))
  while [ "$i" -lt "$total" ]; do
    # Skip this file
    if [ "$${BASH_SOURCE[i + 1]}" != "${BASH_SOURCE[0]}" ]; then
      __BUILD_BASH_STEP_CONTROL+=("${BASH_SOURCE[i + 1]}" "${FUNCNAME[i + 1]}" "$((BASH_LINENO[i] + 1))")
    fi
    i=$((i + 1))
  done
  return 0
}

__bashDebugCommandWatch() {
  local __item
  export __BUILD_BASH_DEBUG_WATCH
  while read -r -p "$(decorate info "Watch"): " __item; do
    if [ -z "$__item" ]; then
      statusMessage printf -- ""
      break
    fi
    decorate bold-orange "Watching $(decorate code "$__item")"
    __BUILD_BASH_DEBUG_WATCH+=("$__item")
    _bashDebugWatch
  done
}

__bashDebugCommandUnwatch() {
  export __BUILD_BASH_DEBUG_WATCH
  while read -r -p "$(decorate warning "Unwatch"): " __item; do
    [ -n "$__item" ] || statusMessage printf -- "" && break
    local __index=0 __list=() __show=() __found
    __list=()
    __found=false
    for __value in "${__BUILD_BASH_DEBUG_WATCH[@]+"${__BUILD_BASH_DEBUG_WATCH[@]}"}"; do
      if [ "$__value" = "$__item" ] || [ "$__index" = "$__item" ]; then
        decorate bold-orange "Removed $__item from watch list"
        __found=true
      else
        __show+=("[$(decorate value "$__index")] $(decorate code "$__value")")
        __list+=("$__value")
      fi
      __index=$((__index + 1))
    done
    if ! $__found; then
      # shellcheck disable=SC2059
      printf -- "%s\n%s" "$(decorate error "No $__item found in watch list:")" "$(printf -- "- $(decorate code %s)\n" "${__show[@]+"${__show[@]}"}")"
    fi
    __BUILD_BASH_DEBUG_WATCH=("${__list[@]+"${__list[@]}"}")
    _bashDebugWatch
  done
}

__bashDebugCommandEvaluate() {
  local __command="$1"

  printf "%s \"%s\"\n" "$(decorate warning "Evaluating")" "$(decorate code "$__command")" >/dev/stdout

  # Save debugger FDs for later
  exec 20<&0 21>&1 22>&2

  # Restore Application FDs
  exec 0<&30 1>&31 2>&32

  set +eu
  set +o pipefail

  eval "$__command" || printf -- "%s\n" "EXIT $(decorate error "[$?]")" 1>&2

  set -eou pipefail

  # Save Application FDs
  exec 30<&0 31>&1 32>&2
  # <& is input copy := so
  # >& is output copy := so
  # 30 := 0, 31 := 1, 32 := 2
  # 30 is a copy of 0, etc.

  # Restore ORIGINAL FDs
  exec 0<&20 1>&21 2>&22

  export __BUILD_BASH_DEBUG_LAST
  __BUILD_BASH_DEBUG_LAST="!$__command"
}

__bashDebugCommandEvaluateLoop() {
  while read -r -p "$(decorate info "Shell"): " __command; do
    [ -n "$__command" ] || break
    __bashDebugCommandEvaluate "$__command"
  done
}
