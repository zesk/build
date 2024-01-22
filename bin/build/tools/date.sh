#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends on no other .sh files
# Shell Dependencies: date
# o ./docs/_templates/tools/date.md
#

# IDENTICAL errorArgument 1
errorArgument=2

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
  if [ $# -eq 0 ]; then
    return $errorArgument
  fi
  if date --version 2>/dev/null 1>&2; then
    date -u --date="$1 00:00:00" "+$2" 2>/dev/null
  else
    date -u -jf '%F %T' "$1 00:00:00" "+$2" 2>/dev/null
  fi
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
# timestampToDate 1681948800 %F
#
# Usage: timestampToDate integerTimestamp format

# Argument: - `integerTimestamp` - Integer timestamp offset (unix timestamp, same as `$(date +%s)`)
# Argument: - `format` - How to output the date (e.g. `%F` - no `+` is required)

# Environment: Compatible with BSD and GNU date.

# Exit codes: If parsing fails, non-zero exit code.

# Example:     dateField=$(timestampToDate $init %Y)

timestampToDate() {
  if date --version 2>/dev/null 1>&2; then
    date -d "@$1" "+$2"
  else
    date -r "$1" "+$2"
  fi
}

# `yesterdayDate`
#
# Returns yesterday's date, in YYYY-MM-DD format. (same as `%F`)
#
# Usage: yesterdayDate
#
# Argument: None.
#
# Summary: Yesterday's date
# Environment: Compatible with BSD and GNU date.
# Example:     rotated="$log.$(yesterdayDate)"

yesterdayDate() {
  timestampToDate "$(($(date +%s) - 86400))" %F
}

# Summary: Today's date
# Returns the current date, in YYYY-MM-DD format. (same as `%F`)
# Usage: todayDate
# Argument: None.
# Environment: Compatible with BSD and GNU date.
# Example:     date="$(todayDate)"
#
todayDate() {
  date +%F
}
