#!/bin/bash
#
# Copy of _user
#
# Copyright &copy; 2024 Market Acumen, Inc.

# IDENTICAL _return 8
# Usage: {fn} _return [ exitCode [ message ... ] ]
# Exit Code: exitCode or 1 if nothing passed
_return() {
  local code="${1-1}"
  shift
  printf "%s ❌ (%d)\n" "${*-§}" "$code" 1>&2
  return "$code"
}

# IDENTICAL _user 11
# Usage: {fn} user
# Summary: Quick user database look up
# Look user up, set environment HOME and APPLICATION_USER and output user if valid
_user() {
  local userDatabase=/etc/passwd
  export APPLICATION_USER HOME
  APPLICATION_USER="$1"
  HOME=$(grep "^$APPLICATION_USER:" "$userDatabase" | cut -d : -f 6) || _return $? "No such user $APPLICATION_USER in $userDatabase" || return $?
  [ -d "$HOME" ] || _return 1 "User $APPLICATION_USER HOME=$HOME is not a directory" || return $?
  printf "%s\n" "$APPLICATION_USER"
}