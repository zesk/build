#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# cursor.sh
#
# Docs: ./documentation/source/tools/cursor.md
# Test: ./test/tools/cursor-tests.sh

# Get the current cursor position
# Output is <x> <newline> <y> <newline>
# stdout: UnsignedInteger
# Escape: ESC `[6n`
# Example:     IFS=$'\n' read -r -d '' saveX saveY < <(cursorGet)
# shellcheck disable=SC2120
cursorGet() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  isTTYAvailable || throwEnvironment "$handler" "no tty" || return $?

  # Read the response from the terminal
  # Again - terminal does this: row/col (Y X), we like (X Y)
  local x y && IFS=';' read -d '' -t 2 -r -sdR -p $'\033[6n' y x </dev/tty >/dev/tty
  # Extract row and column numbers
  y=${y#*[}
  if ! isUnsignedInteger "$x" || ! isUnsignedInteger "$y"; then
    throwEnvironment "$handler" "Invalid response from tty: \"$(printf "%s" "$y;$x" | dumpBinary)\"" || return $?
  fi
  printf "%d\n" "$x" "$y"
}
_cursorGet() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Move the cursor to x y
# Argument: x - UnsignedInteger. Required. Column to place the cursor.
# Argument: y - UnsignedInteger. Required. Row to place the cursor.
cursorSet() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  isTTYAvailable || throwEnvironment "$handler" "no tty" || return $?

  local x y

  x=$(validate "$handler" UnsignedInteger "x" "${1-}") && shift || return $?
  y=$(validate "$handler" UnsignedInteger "y" "${1-}") && shift || return $?

  # Set cursor position
  # Escape: ESC `[` <row> `;` <col> `H`
  # Terminal does this: row/col (Y X), we like (X Y)
  printf "\e%s%d;%dH" "[" "$y" "$x" >/dev/tty
}
_cursorSet() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
