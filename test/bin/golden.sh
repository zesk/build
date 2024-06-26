#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# shellcheck source=/dev/null

# IDENTICAL _return 8
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}"
  shift
  printf "%s ❌ (%d)\n" "${*-§}" "$code" 1>&2
  return "$code"
}

# IDENTICAL __tools 12
# Load tools.sh and run command
__tools() {
  local relative="$1"
  local source="${BASH_SOURCE[0]}"
  local here="${source%/*}"
  shift && set -eou pipefail
  local tools="$here/$relative/bin/build/tools.sh"
  [ -x "$tools" ] || _return 97 "$tools not executable" "$@" || return $?
  # shellcheck source=/dev/null
  source "$tools" || _return 42 source "$tools" "$@" || return $?
  "$@" || return $?
}

# Lay an egg
layAnEgg() {
  local hay=""

  if [ -z "$hay" ]; then
    _layAnEgg 1 "No hay" || return $?
  fi
}
_layAnEgg() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. layAnEgg "$@" || :


# fn: makeCryptoThing
# Lay an egg.
#
# You can use `markdown` in *here*. **Cool**.
#
# The end.
#
# Argument: name - Required. String. What to name the egg.
# Argument: --debug - Optional. Flag. Turn on debugging.`
# Exit Code: 0 - Success
# Exit Code: 1 - Environment error
# Exit Code: 2 - Argument error
# Example: {fn} newEgg
# Output: Eggs laid: 2000git
layAnEgg2() {
  _layAnEgg2 0 "All is great"
}
_layAnEgg2() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools ../.. layAnEgg2
