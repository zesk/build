#!/bin/bash
#
# Original of _home
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Require: IDENTICAL _return

# IDENTICAL _home EOF

# Argument: user - String. Required. User name to look up.
# Summary: Quick user database look up
# Look user up, output user home
# Environment: APPLICATION_USER
# Environment: HOME
# stdout: the home directory
# File: /etc/passwd
# Requires: grep cut _return printf /etc/passwd
_home() {
  local user="${1-}" userDatabase="/etc/passwd" home
  set -o pipefail && home=$(grep "^$user:" "$userDatabase" | cut -d : -f 6) || _return $? "No such user $user in $userDatabase" || return $?
  [ -d "$home" ] || _return 1 "User $user home \"$home\" is not a directory" || return $?
  printf -- "%s\n" "$home"
}
