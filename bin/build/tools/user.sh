#!/usr/bin/env bash
#
# user.sh
#
# A user is the person or entity using the computer currently, usually. It dictates permissions and what they can do.
#
# Copyright &copy; 2025 Market Acumen, Inc.

# IDENTICAL userRecord 31

# Argument: index - PositiveInteger. Required. Index (1-based) of field to select.
# Argument: user - String. Optional. User name to look up. Uses `whoami` if not supplied.
# Argument: database - File. Optional. User name database file to examine. Uses `/etc/passwd` if not supplied.
# Summary: Quick user database look up
# Look user up, output user home
# Environment: APPLICATION_USER
# Environment: HOME
# stdout: the home directory
# File: /etc/passwd
# Requires: grep cut returnMessage printf /etc/passwd
userRecord() {
  local handler="_${FUNCNAME[0]}"
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

userRecordName() {
  userRecord 4 "$@"
}

userRecordHome() {
  userRecord 6 "$@"
}
