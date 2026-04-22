#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Depends on no other .sh files
# Shell Dependencies: date
#
# Docs: ./documentation/source/tools/date.md
# Test: ./test/tools/date-tests.sh
#

# Converts a date (`YYYY-MM-DD`) to another format.
# Summary: Platform agnostic date conversion
#
# Compatible with BSD and GNU date.
# Argument: date - String. Required. String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
# Argument: format - String. Optional. Format string for the `date` command (e.g. `%s`)
# Example:     dateToFormat 2023-04-20 %s 1681948800
# Example:     timestamp=$(dateToFormat '2023-10-15' %s)
# Return Code: 1 - if parsing fails
# Return Code: 0 - if parsing succeeds
dateToFormat() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local format="${2-"%F %T"}"
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} requires 1 or 2 arguments: date [ format ] –- Passed $#:" "$@" || return $?
  fi
  __dateToFormat "$1" "$format"
  #  if date --version 2>/dev/null 1>&2; then
  #    date -u --date="$1 00:00:00" "+$format" 2>/dev/null
  #  else
  #    date -u -jf '%F %T' "$1 00:00:00" "+$format" 2>/dev/null
  #  fi
}
_dateToFormat() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Converts a date to an integer timestamp
#
# Argument: date - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Environment: Compatible with BSD and GNU date.
# Return Code: 1 - if parsing fails
# Return Code: 0 - if parsing succeeds
# Example:     timestamp=$(dateToTimestamp '2023-10-15')
dateToTimestamp() {
  [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
  dateToFormat "$1" %s
}
_dateToTimestamp() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Converts an integer date to a date formatted timestamp (e.g. `%Y-%m-%d %H:%M:%S`)
#
# Example:     dateFromTimestamp 1681966800 %F
#
# Argument: integerTimestamp - Integer. Required. Integer. Required. Integer timestamp offset (Seconds since 1/1/1970 UTC, same as `$(date +%s)`)
# Argument: format - String. Optional. How to output the date (e.g. `%F` - no `+` is required)
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --local - Flag. Optional. Show the local time, not UTC.
# Environment: Compatible with BSD and GNU date.
# Return Code: 0 - If parsing is successful
# Return Code: 1 - If parsing fails
# Example:     dateField=$(dateFromTimestamp $init %Y)
# Requires: throwArgument decorate validate __dateFromTimestamp bashDocumentation
dateFromTimestamp() {
  local handler="_${FUNCNAME[0]}"
  local isUTC=true value="" format=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --local) isUTC=false ;;
    *)
      if [ -z "$value" ]; then
        value=$(validate "$handler" UnsignedInteger "timestamp" "$argument") || return $?
      elif [ -z "$format" ]; then
        format=$(validate "$handler" String "format" "$argument") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$value" ] || throwArgument "$handler" "No value supplied" || return $?
  [ -n "$format" ] || format="%F %T"
  __dateFromTimestamp "$value" "$format" "$isUTC"
}
_dateFromTimestamp() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Returns yesterday's date, in `YYYY-MM-DD` format. (same as `%F`)
#
# Summary: Yesterday's date (UTC time)
# Argument: --local - Flag. Optional. Local yesterday
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     rotated="$log.$({fn} --local)"
# Requires: throwArgument date convertValue dateFromTimestamp bashDocumentation
dateYesterday() {
  local handler="_${FUNCNAME[0]}"
  if [ $# -eq 0 ]; then
    ts=$(catchReturn "$handler" date -u +%s) || return $?
  else
    case "$1" in
    --help) "$handler" 0 && return $? || return "$(convertValue $? 1 0)" ;;
    --local) ts=$(catchReturn "$handler" date +%s) || return $? ;;
    *) throwArgument "$handler" "Unknown argument: $1" || return $? ;;
    esac
  fi
  dateFromTimestamp "$((ts - 86400))" %F
}
_dateYesterday() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Tomorrow's date in UTC
# Returns tomorrow's date (UTC time), in `YYYY-MM-DD` format. (same as `%F`)
#
# Argument: --local - Flag. Optional. Local tomorrow
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     rotated="$log.$({fn})"
# Requires: throwArgument date convertValue dateFromTimestamp bashDocumentation
dateTomorrow() {
  local handler="_${FUNCNAME[0]}" ts
  if [ $# -eq 0 ]; then
    ts=$(catchReturn "$handler" date -u +%s) || return $?
  else
    case "$1" in
    --help) "$handler" 0 && return $? || return "$(convertValue $? 1 0)" ;;
    --local) ts=$(catchReturn "$handler" date +%s) || return $? ;;
    *) throwArgument "$handler" "Unknown argument: $1" || return $? ;;
    esac
  fi
  dateFromTimestamp "$((ts + 86400))" %F
}
_dateTomorrow() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Today's date in UTC
# Returns the current date, in YYYY-MM-DD format. (same as `%F`)
# Argument: --local - Flag. Optional. Local today.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Environment: Compatible with BSD and GNU date.
# Example:     date="$({fn})"
dateToday() {
  local handler="_${FUNCNAME[0]}"
  local uu=(-u)
  [ $# -eq 0 ] || case "$1" in
  --help) "$handler" 0 && return $? || return "$(convertValue $? 1 0)" ;;
  --local) uu=() ;;
  *) throwArgument "$handler" "Unknown argument: $1" || return $? ;;
  esac
  date "${uu[@]+"${uu[@]}"}" +%F
}
_dateToday() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Is a date valid?
# Checks a date syntax and ensures it's a valid calendar date.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# DOC TEMPLATE: dashDashAllowsHelpParameters 1
# Argument: -- - Flag. Optional. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
# Argument: text - String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations.
dateValid() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  [ "${1-}" != "--" ] || shift
  local date="${1-}"
  catchEnvironment "$handler" [ "${date:4:1}${date:7:1}" = "--" ] || return 1
  local year="${date:0:4}" month="${date:5:2}" day="${date:8:2}"
  catchEnvironment "$handler" isUnsignedInteger "$year" || return $?
  catchEnvironment "$handler" isUnsignedInteger "${month#0}" || return $?
  catchEnvironment "$handler" isUnsignedInteger "${day#0}" || return $?
  catchEnvironment "$handler" [ "$year" -gt 1600 ] || return $?
  catchEnvironment "$handler" [ "${month#0}" -ge 1 ] || return $?
  catchEnvironment "$handler" [ "${month#0}" -le 12 ] || return $?
  catchEnvironment "$handler" [ "${day#0}" -ge 1 ] || return $?
  catchEnvironment "$handler" [ "${day#0}" -le 31 ] || return $?
}
_dateValid() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Add or subtract days from a text date
# Argument: --days delta - SignedInteger. Number of days to add (or subtract - use a negative number). Affects all timestamps *after* it.
# Argument: timestamp ... - Date. Timestamp to update.
# stdout: Date with days added to it
#
# Example:     newYearsEve=$(dateAdd --days -1 "2025-01-01")
dateAdd() {
  local handler="_${FUNCNAME[0]}" days=1

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --days) shift && days=$(validate "$handler" Integer "$argument" "${1-}") || return $? ;;
    *)
      timestamp=$(catchArgument "$handler" dateToTimestamp "$argument") || return $?
      catchArgument "$handler" dateFromTimestamp "$((timestamp + (86400 * days)))" "%F" || return $?
      ;;
    esac
    shift
  done
}
_dateAdd() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Is a date in the past beyond its expiration date?
# stdout: Two tokens on a single line:
# stdout: - UnsignedInteger. Days until expiration.
# stdout: - UnsignedInteger. Expiration timestamp.
#
# This tool checks the `keyDate` and checks if it is within `days` of today; if not this fails.
#
# It will also fail if:
#
# - `keyDate` is empty or has an invalid value
# - `upToDateDays` is less than zero
#
# Return code: 0 - The date has not expired.
# Return code: 1 - The date has expired.
# Return code: 2 - The date is incorrectly formatted.
# Return code: 2 - Argument error.
#
# Argument: keyDate - Date. Required. Formatted like `YYYY-MM-DD`. Truncated at 10 characters as well.
# Argument: upToDateDays - Integer. Optional. Days that key expires after `keyDate`. Default is 90.
# Argument: --name name - String. Optional. Name of the expiring item for error messages.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Example:     if ! dateWithinDays "$AWS_ACCESS_KEY_DATE" 90; then
# Example:       decorate big Failed, update key and reset date
# Example:       exit 99
# Example:     fi
dateWithinDays() {
  local handler="_${FUNCNAME[0]}"

  local keyDate="" upToDateDays=""
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --local) ll=(--local) ;;
    *)
      if [ -z "$keyDate" ]; then
        keyDate=$(validate "$handler" Date "keyDate" "$argument") || return $?
      elif [ -z "$upToDateDays" ]; then
        upToDateDays=$(validate "$handler" UnsignedInteger "upToDateDays" "$argument") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$keyDate" ] || throwArgument "$handler" "missing keyDate" || return $?
  [ -n "$upToDateDays" ] || upToDateDays=90

  local keyTimestamp && keyTimestamp=$(catchArgument "$handler" dateToTimestamp "${keyDate:0:10}") || return $?
  local todayTimestamp && todayTimestamp=$(dateToTimestamp "$(dateToday "${ll[@]+"${ll[@]}"}")") || throwEnvironment "$handler" "Unable to generate dateToday" || return $?
  local accessKeyTimestamp=$((keyTimestamp + ((23 * 60) + 59) * 60))
  local expireTimestamp=$((accessKeyTimestamp + 86400 * upToDateDays))
  local deltaDays=$(((todayTimestamp - accessKeyTimestamp) / 86400))
  local expireDays=$((deltaDays - upToDateDays))
  expireDays=$((-expireDays))
  catchReturn "$handler" printf -- "%d %s\n" "$expireDays" "$expireTimestamp" || return $?
  if [ "$todayTimestamp" -gt "$expireTimestamp" ]; then
    return 1
  fi
  return 0
}
_dateWithinDays() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
