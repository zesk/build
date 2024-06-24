#!/bin/bash
#
# Simple service to run a binary as a user
#
# Install to /etc/service/nameOfService/run
#
# Environment: APPLICATION_USER - Set and then map this file
# Environment: BINARY - Set and then map this file
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# See: daemontools
#

set -eou pipefail
_return() {
  local code
  code="${1-0}" && exec 1>&2 && shift && printf "%s -> %d\n" "$(printf "%s " "$@")" "$code" && return "$code"
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
  [ -d "$HOME" ] || _return $? "User $APPLICATION_USER HOME=$HOME is not a directory" || return $?
  printf "%s\n" "$APPLICATION_USER"
}

exec setuidgid "$(_user "{APPLICATION_USER}")" "$@" || _return $? "Unable to load $*" || return $?
