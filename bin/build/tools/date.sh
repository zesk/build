#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Depends on no other .sh files
# Shell Dependencies: date
# o ./docs/_templates/tools/date.md
#

# Converts a date (`YYYY-MM-DD`) to another format.
# Summary: Platform agnostic date conversion
# Usage: dateToFormat date format
# Argument: date - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
# Argument: format - Format string for the `date` command (e.g. `%s`)
# Example:     dateToFormat 2023-04-20 %s 1681948800
# Example:     timestamp=$(dateToFormat '2023-10-15' %s)
# Environment: Compatible with BSD and GNU date.
# Exit Code: 1 - if parsing fails
# Exit Code: 0 - if parsing succeeds
dateToFormat() {
  local usage="_${FUNCNAME[0]}"
  local format="${2-"%Y-%m-%d"}"
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} requires 1 or 2 arguments: date [ format ] –- Passed $#:" "$@" || return $?
  fi
  __dateToFormat "$1" "$format"
  #  if date --version 2>/dev/null 1>&2; then
  #    date -u --date="$1 00:00:00" "+$format" 2>/dev/null
  #  else
  #    date -u -jf '%F %T' "$1 00:00:00" "+$format" 2>/dev/null
  #  fi
}

#
# Converts a date to an integer timestamp
#
# Usage: dateToTimestamp date
#
# Argument: date - String in the form `YYYY-MM-DD` (e.g. `2023-10-15`)
# Environment: Compatible with BSD and GNU date.
# Exit Code: 1 - if parsing fails
# Exit Code: 0 - if parsing succeeds
# Example:     timestamp=$(dateToTimestamp '2023-10-15')
#
dateToTimestamp() {
  dateToFormat "$1" %s
}

#
# Converts an integer date to a date formatted timestamp (e.g. %Y-%m-%d %H:%M:%S)
#
# timestampToDate 1681966800 %F
#
# Usage: timestampToDate integerTimestamp format
# Argument: integerTimestamp - Integer timestamp offset (unix timestamp, same as `$(date +%s)`)
# Argument: format - How to output the date (e.g. `%F` - no `+` is required)
# Environment: Compatible with BSD and GNU date.
# Exit codes: If parsing fails, non-zero exit code.
# Example:     dateField=$(timestampToDate $init %Y)
timestampToDate() {
  local usage="_${FUNCNAME[0]}"
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    __throwArgument "$usage" "${FUNCNAME[0]} requires 1 or 2 arguments: integerTimestamp [ format ] –- Passed $#:" "$@" || return $?
  fi
  __timestampToDate "$@"
}
_timestampToDate() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Returns yesterday's date, in YYYY-MM-DD format. (same as `%F`)
#
# Usage: {fn}#
# Summary: Yesterday's date
# Example:     rotated="$log.$({fn})"
yesterdayDate() {
  timestampToDate "$(($(date -u +%s) - 86400))" %F
}

# Returns tomorrow's date, in YYYY-MM-DD format. (same as `%F`)
#
# Usage: {fn}
#
# Summary: Tomorrow's date
# Example:     rotated="$log.$({fn})"
tomorrowDate() {
  timestampToDate "$(($(date -u +%s) + 86400))" %F
}

# Summary: Today's date
# Returns the current date, in YYYY-MM-DD format. (same as `%F`)
# Usage: {fn}
# Argument: None.
# Environment: Compatible with BSD and GNU date.
# Example:     date="$({fn})"
#
todayDate() {
  date -u +%F
}
