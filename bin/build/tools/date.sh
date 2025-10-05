#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends on no other .sh files
# Shell Dependencies: date
#
# Docs: ./documentation/source/tools/date.md
# Test: ./test/tools/date-tests.sh
#

# Converts a date (`YYYY-MM-DD`) to another format.
# Summary: Platform agnostic date conversion
# Usage: dateToFormat date format
# Argument: date - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
# Argument: format - Format string for the `date` command (e.g. `%s`)
# Example:     dateToFormat 2023-04-20 %s 1681948800
# Example:     timestamp=$(dateToFormat '2023-10-15' %s)
# Environment: Compatible with BSD and GNU date.
# Return Code: 1 - if parsing fails
# Return Code: 0 - if parsing succeeds
dateToFormat() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
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
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Converts a date to an integer timestamp
#
# Usage: dateToTimestamp date
#
# Argument: date - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
# Environment: Compatible with BSD and GNU date.
# Return Code: 1 - if parsing fails
# Return Code: 0 - if parsing succeeds
# Example:     timestamp=$(dateToTimestamp '2023-10-15')
#
dateToTimestamp() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  dateToFormat "$1" %s
}
_dateToTimestamp() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)
#
# dateFromTimestamp 1681966800 %F
#
# Usage: dateFromTimestamp integerTimestamp format
# Argument: integerTimestamp - Integer timestamp offset (unix timestamp, same as `$(date +%s)`)
# Argument: format - How to output the date (e.g. `%F` - no `+` is required)
# Environment: Compatible with BSD and GNU date.
# Exit codes: If parsing fails, non-zero exit code.
# Example:     dateField=$(dateFromTimestamp $init %Y)
dateFromTimestamp() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} requires 1 or 2 arguments: integerTimestamp [ format ] –- Passed $#:" "$@" || return $?
  fi
  local format="${2-"%F %T"}"
  __dateFromTimestamp "$1" "$format"
}
_dateFromTimestamp() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Returns yesterday's date, in YYYY-MM-DD format. (same as `%F`)
#
# Usage: {fn}#
# Summary: Yesterday's date
# Example:     rotated="$log.$({fn})"
yesterdayDate() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  dateFromTimestamp "$(($(date -u +%s) - 86400))" %F
}
_yesterdayDate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Returns tomorrow's date, in YYYY-MM-DD format. (same as `%F`)
#
# Usage: {fn}
#
# Summary: Tomorrow's date
# Example:     rotated="$log.$({fn})"
tomorrowDate() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  dateFromTimestamp "$(($(date -u +%s) + 86400))" %F
}
_tomorrowDate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Today's date
# Returns the current date, in YYYY-MM-DD format. (same as `%F`)
# Usage: {fn}
# Argument: None.
# Environment: Compatible with BSD and GNU date.
# Example:     date="$({fn})"
#
todayDate() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  date -u +%F
}
_todayDate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is a date valid?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: dashDashAllowsHelpParameters 1
# Argument: -- - Optional. Flag. Stops command processing to enable arbitrary text to be passed as additional arguments without special meaning.
# Argument: text - String. Required. Text to validate as a date after the year 1600. Does not validate month and day combinations.
dateValid() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
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
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
    --days)
      shift
      days=$(usageArgumentInteger "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      timestamp=$(catchArgument "$handler" dateToTimestamp "$argument") || return $?
      catchArgument "$handler" dateFromTimestamp "$((timestamp + (86400 * days)))" "%F" || return $?
      ;;
    esac
    shift
  done
}
_dateAdd() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
