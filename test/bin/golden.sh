#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# shellcheck source=/dev/null
. "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh"

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

layAnEgg "$@"

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
# Output: Eggs laid: 2000
layAnEgg2() {
  _layAnEgg2 0 "All is great"
}
_layAnEgg2() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

layAnEgg2
