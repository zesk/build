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
# Return Code: 1 - Issue with `buildEnvironmentGet HOME` or $HOME is not a directory (say, it's a file)
# Return Code: 0 - Home directory exists.
userHome() {
  local handler="_${FUNCNAME[0]}"
  __help "_${FUNCNAME[0]}" "$@" || return 0
  local home
  home=$(catchReturn "$handler" buildEnvironmentGet HOME) || return $?
  [ -d "$home" ] || throwEnvironment "$handler" "HOME is not a directory: $HOME" || return $?
  home="$(printf "%s%s" "$home" "$(printf "/%s" "$@")")"
  printf "%s\n" "${home%/}"

}
_userHome() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL userRecord 52

# Argument: index - PositiveInteger. Required. Index (1-based) of field to select.
# Argument: user - String. Optional. User name to look up. Uses `whoami` if not supplied.
# Argument: database - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.
# Summary: Quick user database look up
# Look user up, output user home
# stdout: the home directory
# File: /etc/passwd
# Requires: grep cut returnMessage printf /etc/passwd whoami
userRecord() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local index="${1-}" user="${2-}" userDatabase=${3-"/etc/passwd"} value
  [ -n "$user" ] || user=$(catchReturn "$handler" whoami) || return $?
  [ -f "$userDatabase" ] || throwEnvironment "$handler" "No $userDatabase" || return $?
  set -o pipefail && value=$(grep "^$user:" "$userDatabase" | cut -d : -f "$index") || returnMessage $? "No such user $user in $userDatabase" || return $?
  printf -- "%s\n" "$value"
}
_userRecord() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Quick user database look up of the user name
# Look user up, output user name
# stdout: the user name
# File: /etc/passwd
# Argument: user - String. Optional. User name to look up. Uses `whoami` if not supplied.
# Argument: database - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.
userRecordName() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  userRecord 5 "$@"
}
_userRecordName() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Quick user database look up of the user home directory
# Look user up, output user home directory
# stdout: `Directory`. The user home directory.
# File: /etc/passwd - Used for the default user database.
# Argument: user - String. Optional. User name to look up. Uses `whoami` if not supplied.
# Argument: database - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.
userRecordHome() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  userRecord 6 "$@"
}
_userRecordHome() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
