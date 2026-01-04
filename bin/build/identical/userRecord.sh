#!/bin/bash
#
# Original of userRecord (FKA _home)
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Require: IDENTICAL returnMessage

# IDENTICAL userRecord EOF

# Argument: index - PositiveInteger. Required. Index (1-based) of field to select.
# Argument: user - String. Optional. User name to look up. Uses `whoami` if not supplied.
# Argument: database - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.
# Summary: Quick user database look up
# Look user up, output a single user database record.
# stdout: String. Associated record with `index` and `user`.
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

# Summary: Quick user database query of the user name
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

# Summary: Quick user database query of the user home directory
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
