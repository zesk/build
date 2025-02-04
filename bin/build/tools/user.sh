#!/usr/bin/env bash
#
# user.sh
#
# A user is the person or entity using the computer currently, usually. It dictates permissions and what they can do.
#
# Copyright &copy; 2025 Market Acumen, Inc.

# The current user HOME (must exist)
# Argument: pathSegment - String. Optional. Add these path segments to the HOME directory returned. Does not create them.
# No directories *should* be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory.
# Exit code: 1 - Issue with `buildEnvironmentGet HOME` or $HOME is not a directory (say, it's a file)
# Exit code: 0 - Home directory exists.
userHome() {
  local usage="_${FUNCNAME[0]}"
  __help "_${FUNCNAME[0]}" "$@" || return 0
  home=$(__catchEnvironment "$usage" buildEnvironmentGet HOME) || return $?
  [ -d "$home" ] || __throwEnvironment "$usage" "HOME is not a directory: $HOME" || return $?
  printf "%s%s\n" "$home" "$(printf "/%s" "$@")"

}
_userHome() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
