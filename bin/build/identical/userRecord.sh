#!/bin/bash
#
# Original of userRecord (FKA _home)
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Require: IDENTICAL returnMessage

# IDENTICAL userRecord 23

# Argument: index - PositiveInteger. Required. Index (1-based) of field to select.
# Argument: user - String. Required. User name to look up.
# Summary: Quick user database look up
# Look user up, output user home
# Environment: APPLICATION_USER
# Environment: HOME
# stdout: the home directory
# File: /etc/passwd
# Requires: grep cut _return printf /etc/passwd
userRecord() {
  local index="${1-}" user="${2-}" userDatabase=${3-"/etc/passwd"} value
  set -o pipefail && value=$(grep "^$user:" "$userDatabase" | cut -d : -f "$index") || _return $? "No such user $user in $userDatabase" || return $?
  printf -- "%s\n" "$value"
}

userRecordName() {
  userRecord 4 "$@"
}

userRecordHome() {
  userRecord 6 "$@"
}
