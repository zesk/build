#!/usr/bin/env bash
#
# user.sh
#
# A user is the person or entity using the computer currently, usually. It dictates permissions and what they can do.
#
# Copyright &copy; 2025 Market Acumen, Inc.

# IDENTICAL userRecord 23

# Argument: index - PositiveInteger. Required. Index (1-based) of field to select.
# Argument: user - String. Required. User name to look up.
# Summary: Quick user database look up
# Look user up, output user home
# Environment: APPLICATION_USER
# Environment: HOME
# stdout: the home directory
# File: /etc/passwd
# Requires: grep cut returnMessage printf /etc/passwd
userRecord() {
  local index="${1-}" user="${2-}" userDatabase=${3-"/etc/passwd"} value
  set -o pipefail && value=$(grep "^$user:" "$userDatabase" | cut -d : -f "$index") || returnMessage $? "No such user $user in $userDatabase" || return $?
  printf -- "%s\n" "$value"
}

userRecordName() {
  userRecord 4 "$@"
}

userRecordHome() {
  userRecord 6 "$@"
}
