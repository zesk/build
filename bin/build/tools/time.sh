#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/time.md
# Test: ./test/tools/time-tests.sh

# Time command, similar to `time` but uses internal functions
# Argument: command - Required. Executable. Command to run.
# Outputs time as `timingReport`
timing() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local start exitCode=0
  start=$(timingStart)
  isCallable "${1-}" || throwArgument "$handler" "${1-} must be callable" || return $?
  catchReturn "$handler" "$@" || exitCode="$?"
  timingReport "$start" "$@"
  [ $exitCode = 0 ] || returnMessage "$exitCode" "$@" || return $?
}
_timing() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Start a timer
#
# Outputs the offset in milliseconds from January 1, 1970.
#
# Usage: timingStart
# Example:     init=$(timingStart)
# Example:     ...
# Example:     timingReport "$init" "Completed in"
# Requires: __timestamp, returnEnvironment date
# Should never fail, unless date is not installed
timingStart() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  __timestamp
}
_timingStart() {
  ! false || timingStart --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Format a timing output (milliseconds) as seconds using a decimal
timingFormat() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  while [ $# -gt 0 ]; do
    local delta="$1" seconds remainder text
    if isUnsignedInteger "$delta"; then
      seconds=$((delta / 1000))
      remainder=$((delta % 1000))
      text=$(printf -- "%d.%03d\n" "$seconds" "$remainder")
      # Lazy but works
      text=${text%0} && text=${text%0} && text=${text%0} && text=${text%.}
      printf "%s\n" "$text"
    else
      printf "(**%s**)\n" "$delta"
    fi
    shift
  done
}
_timingFormat() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Outputs the timing optionally prefixed by a message.
#
# Summary: Output the time elapsed
# Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.
# Argument: --color color - Make text this color (default is `green`)
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: start - Unix timestamp milliseconds. See `timingStart`.
# Argument: message - Any additional arguments are output before the elapsed value computed
# Return Code: 0 - Exits with exit code zero
# See: timingStart
# Example:    init=$(timingStart)
# Example:    ...
# Example:    timingReport "$init" "Deploy completed in"
timingReport() {
  local handler="_${FUNCNAME[0]}"

  local color="green" start=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --color)
      shift
      color=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      start="$argument"
      shift
      break
      ;;
    esac
    shift
  done

  if isUnsignedInteger "$start"; then
    local prefix=""
    if [ $# -gt 0 ]; then
      prefix="$(decorate "$color" "$@") "
    fi
    local value end delta
    end=$(timingStart)
    delta=$((end - start))
    if [ "$delta" -lt 0 ]; then
      printf "%s%s\n" "$prefix" "$(decorate bold-red "$end - $start => $delta NEGATIVE")"
    else
      value=$(timingFormat "$delta") || :
      printf "%s%s\n" "$prefix" "$(decorate bold-magenta "$value $(plural "$value" second seconds)")"
    fi
  else
    printf "%s %s %s\n" "$*" "$(decorate bold-red "$start")" "$(decorate warning "(not integer)")"
  fi
}
_timingReport() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
