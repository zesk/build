#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
cursorGet() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  isTTYAvailable || __throwEnvironment "$handler" "no tty" || return $?

  local x y

  # Read the response from the terminal
  # Again - terminal does this: row/col (Y X), we like (X Y)
  IFS=';' read -r -sdR -p $'\033[6n' y x </dev/tty >/dev/tty || :¬

  # Extract row and column numbers
  y=${y#*[}
  printf "%d\n" "$x" "$y"
}
_cursorGet() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Move the cursor to x y
# Argument: x - Required. UnsignedInteger. Column to place the cursor.
# Argument: y - Required. UnsignedInteger. Row to place the cursor.
cursorSet() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  isTTYAvailable || __throwEnvironment "$handler" "no tty" || return $?

  local x y

  x=$(usageArgumentUnsignedInteger "$handler" "x" "${1-}") && shift || return $?
  y=$(usageArgumentUnsignedInteger "$handler" "y" "${1-}") && shift || return $?

  # Set cursor position
  # Escape: ESC `[` <row> `;` <col> `H`
  # Terminal does this: row/col (Y X), we like (X Y)
  printf "\e%s%d;%dH" "[" "$y" "$x" >/dev/tty
}
_cursorSet() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
