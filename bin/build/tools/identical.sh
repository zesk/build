#!/usr/bin/env bash
#
# Identical support functions
#
# Ensuring a directory of files has sections which match identically
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Usage: {fn} file prefix identicalLine
# May return non-integer count and should be tested by calling function
#
__identicalLineParse() {
  local file="${1-}"
  local prefix="${2-}"
  local identicalLine="${3-}"
  local lineNumber=${identicalLine%%:*}

  if ! isUnsignedInteger "$lineNumber"; then
    _environment "${FUNCNAME[0]}: \"$identicalLine\" no line number: \"$lineNumber\"" || return $?
  fi
  # Trim line number from beginning of line
  identicalLine=${identicalLine#*:}

  # Remove token identifier
  identicalLine="${identicalLine/"$prefix"/}"
  # And whitespace
  identicalLine="$(trimSpace "$identicalLine")"

  local token line0 line1
  read -r token line0 line1 <<<"$identicalLine" || echo "EOF"
  local count
  if [ "$line0" = "EOF" ]; then
    count="EOF"
  elif isInteger "$line0"; then
    # Allow non-numeric token after numeric (markup)
    if isInteger "$line1"; then
      if [ "$line0" -ge "$line1" ]; then
        _environment "$(decorate code "$file:$lineNumber") - line numbers out of order: $(decorate each value "$line0 $line1")" || return $?
      fi
      count=$((line1 - line0))
    else
      count="$line0"
    fi
  else
    _environment "$(decorate code "$file:$lineNumber") prefix=\"$prefix\" \"$identicalLine\" Invalid token count: $line0 $line1" || return $?
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
