#!/usr/bin/env bash
#
# Identical support functions
#
# Ensuring a directory of files has sections which match identically
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# Usage: {fn} file prefix identicalLine
# May return non-integer count and should be tested by calling function
#
__identicalLineParse() {
  local file="${1-}"
  local prefix="${2-}"
  local identicalLine="${3-}"

  lineNumber=${identicalLine%%:*}
  if ! isUnsignedInteger "$lineNumber"; then
    _environment "__identicalLineParse: \"$identicalLine\" no line number" || return $?
  fi
  identicalLine=${identicalLine#*:}
  identicalLine="$(trimSpace "${identicalLine##*"$prefix"}")"
  token=${identicalLine%% *}
  count=${identicalLine#* }
  line0=${count%% *}
  line1=${count#[0-9]* }
  line1=${line1%% *}
  if [ "$line0" = "EOF" ]; then
    count="EOF"
  elif isInteger "$line0"; then
    # Allow non-numeric token after numeric (markup)
    if ! isInteger "$line1"; then
      count="$line0"
    elif [ "$line0" != "$count" ] || [ "$line1" != "$count" ]; then
      if [ "$line0" -ge "$line1" ]; then
        _environment "$(decorate code "$file:$lineNumber") - line numbers out of order: $(consoelValue "$line0 $line1")" || return $?
      fi
      count=$((line1 - line0))
    fi
  fi
  printf "%d %s %s\n" "$lineNumber" "$token" "$count"
}

# Usage: {fn} count remainingLines
# Handles converting EOF to remainingLines
__identicalLineCount() {
  if [ "$1" != "EOF" ]; then
    if isUnsignedInteger "$1"; then
      printf "%d\n" "$1"
    else
      printf "%s\n" "$1"
      return 1
    fi
  else
    printf "%d\n" "$2"
  fi
}
