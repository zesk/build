#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/time.md
# Test: ./test/tools/time-tests.sh

# Time command, similar to `time` but uses internal functions
# Argument: command - Executable. Required. Command to run.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --name - String. Optional. Display this help.
# Argument: --slow slowMilliseconds - UnsignedInteger. Optional. Display output if the underlying commend takes is slower (longer) than this threshold.
# Argument: --fast fastMilliseconds - UnsignedInteger. Optional. Display output if the underlying commend runs is faster (shorter) than this threshold.
# Outputs time as `timingReport`
timing() {
  local handler="_${FUNCNAME[0]}"

  local name="" aa=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --name) shift && name="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --fast | --slow) shift && aa+=("$argument" "${1-}") ;;
    *) break ;;
    esac
    shift
  done

  [ -n "$name" ] || name="$*"
  local start && start=$(timingStart)
  isCallable "${1-}" || throwArgument "$handler" "${1-} must be callable" || return $?
  local exitCode=0 && "$@" || exitCode="$?"
  catchReturn "$handler" timingReport "${aa[@]+"${aa[@]}"}" "$start" "$name" || return $?
  return $exitCode
}
_timing() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Outputs the timing optionally prefixed by a message.
#
# Summary: Output the time elapsed
# Outputs a nice colorful message showing the number of seconds elapsed as well as your custom message.
# Condition additions `--slow` and `--fast` allow display conditional on the time output.
# Argument: --slow slowMilliseconds - UnsignedInteger. Optional. Display output if the displayed time is slower (longer) than this threshold.
# Argument: --fast fastMilliseconds - UnsignedInteger. Optional. Display output if the displayed time is faster (shorter) than this threshold.
# Argument: --style style - String. Optional. Display the message using this style. Default style is `success`
# Argument: --color style - String. Optional. Display the message using this style. Default style is `success`. Deprecated 2026-04.
# Argument: --end endTimestamp - UnsignedInteger. Optional. Use this as the end time to display. Otherwise uses the current time. Unit is milliseconds.
# Argument: start - UnsignedInteger|EmptyString. Required. Unix timestamp in milliseconds. See `timingStart`. Unit is `milliseconds`. Invalid values do NOT produce an error.
# Argument: message - Any additional arguments are output before the elapsed value computed
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# Return Code: 0 - Exits with exit code zero
# See: timingStart
# Example:     init=$(timingStart)
# Example:     ...
# Example:     timingReport "$init" "Deploy completed in"
# Example:     timingReport "$start" --slow 5000 "Reporting should be completed in less than 5 seconds."
# Example:     timingReport "$start" --fast 1000 --style error "Deployment completed too quickly; please check systems."
timingReport() {
  local handler="_${FUNCNAME[0]}"

  local style="success" start="" end="" slow="" fast=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --end) shift && end=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $? ;;
    --slow) shift && slow="$(validate "$handler" UnsignedInteger "$argument" "${1-}")" || return $? ;;
    --fast) shift && fast="$(validate "$handler" UnsignedInteger "$argument" "${1-}")" || return $? ;;
    --color | --style) shift && style=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    *) start="$argument" && shift && break ;;
    esac
    shift
  done

  if ! isUnsignedInteger "$start"; then catchReturn "$handler" printf "%s %s %s\n" "$*" "$(decorate BOLD red "$start")" "$(decorate warning "(not integer)")" && return $? || return $?; fi
  local prefix=""
  [ $# -eq 0 ] || prefix="$(decorate "$style" "$@") "
  [ -n "$end" ] || end=$(timingStart)
  local elapsed=$((end - start))
  [ "$slow" = "" ] || [ "$elapsed" -gt "$slow" ] || return 0
  [ "$fast" = "" ] || [ "$elapsed" -lt "$fast" ] || return 0
  [ "$elapsed" -lt 0 ] && printf "%s%s\n" "$prefix" "$(decorate BOLD red "$end - $start => $elapsed NEGATIVE")" || printf "%s%s\n" "$prefix" "$(decorate BOLD magenta "$(timingDuration "$elapsed")") $(decorate subtle "[$elapsed]")"
}
_timingReport() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Show elapsed time from a start time
#
# Argument: timingOffset - UnsignedInteger. Required. Offset in milliseconds from January 1, 1970.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     init=$(timingStart)
# Example:     ...
# Example:     timingElapsed "$init"
# Requires: __timestamp returnEnvironment validate date
# stdout: UnsignedInteger
# Output: 4232
timingElapsed() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local start && start=$(validate "$handler" UnsignedInteger timingOffset "${1-}") && shift || return $?
  printf "%d\n" "$(($(__timestamp) - start))"
}
_timingElapsed() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Start a timer
#
# Outputs the offset in milliseconds from midnight UTC January 1, 1970.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     init=$(timingStart)
# Example:     ...
# Example:     timingReport "$init" "Completed in"
# Requires: __timestamp, returnEnvironment date
# Example:     start=$(timingStart) && printf "%d\n" "$start"
# Example:     1777501474602
# stdout: UnsignedInteger
# Output: 1777501474602
# Only fails if `date` is not installed
timingStart() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  __timestamp
}
_timingStart() {
  ! false || timingStart --help
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Format a timing output (milliseconds) as seconds using a decimal
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: delta - Integer. Milliseconds
timingFormat() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  while [ $# -gt 0 ]; do
    local delta="$1"
    if isUnsignedInteger "$delta"; then
      local seconds=$((delta / 1000)) remainder=$((delta % 1000)) text && text=$(printf -- "%d.%03d\n" "$seconds" "$remainder")
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
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Output timing like "1 day, 2 hours, 3 minutes, 4 seconds, 5 ms"
# Argument: duration - UnsignedInteger. Optional. Timing to output
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# Argument: --stop stopUnit - String. Optional. Stop displaying fractional output after this unit is displayed.
timingDuration() {
  local handler="_${FUNCNAME[0]}"

  local durations=() stopUnit=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --stop) shift && stopUnit=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    *) durations+=("$(validate "$handler" Number duration "$argument")") ;;
    esac
    shift
  done

  local unitNames=("second" "minute" "hour" "day" "week" "year")
  local unitTotals=(60 60 24 7 52 1000)
  local duration && for duration in "${durations[@]}"; do
    if [ "$duration" -lt 1000 ]; then
      printf "%sms\n" "$duration"
    else
      local found=() fraction=$((duration % 1000))
      duration=$((duration / 1000))
      local index unitName unitTotal && for index in "${!unitNames[@]}"; do
        unitName=${unitNames[index]} unitTotal=${unitTotals[index]}
        if [ "$duration" -ge "$unitTotal" ]; then
          unitCount=$((duration % unitTotal))
          duration=$((duration / unitTotal))
          if [ $unitCount -gt 0 ] && [ -z "$stopUnit" ]; then
            found=("$(localePluralWord "$unitCount" "$unitName")" "${found[@]+"${found[@]}"}")
          fi
          [ "$unitName" != "$stopUnit" ] || stopUnit=""
        else
          unitCount=$duration
          found=("$(localePluralWord "$unitCount" "$unitName")" "${found[@]+"${found[@]}"}")
          break
        fi
      done
      [ "$fraction" -eq 0 ] || found=("${found[@]+"${found[@]}"}" "${fraction}ms")
      local output && output=$(printf "%s, " "${found[@]}") || return $?
      printf "%s\n" "${output%, }"
    fi
  done
}
_timingDuration() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
