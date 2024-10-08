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

# IDENTICAL _return 19
# Usage: {fn} [ exitCode [ message ... ] ]
# Argument: exitCode - Optional. Integer. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output to stderr.
# Exit Code: exitCode
_return() {
  local r="${1-:1}" && shift
  _integer "$r" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer $r" "$@" || return $?
  printf "[%d] ❌ %s\n" "$r" "${*-§}" 1>&2 || : && return "$r"
}

# Is this an unsigned integer?
# Usage: {fn} value
# Exit Code: 0 - if value is an unsigned integer
# Exit Code: 1 - if value is not an unsigned integer
_integer() {
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

# IDENTICAL _home 12
# Usage: {fn} user
# Summary: Quick user database look up
# Look user up, output user home
# Environment: APPLICATION_USER
# Environment: HOME
# stdout: the home directory
_home() {
  local user="${1-}" home userDatabase=/etc/passwd
  set -o pipefail && home=$(grep "^$user:" "$userDatabase" | cut -d : -f 6) || _return $? "No such user $user in $userDatabase" || return $?
  [ -d "$home" ] || _return 1 "User $user home \"$home\" is not a directory" || return $?
  printf -- "%s\n" "$home"
}

# Usage: {fn}
# Run a service as a user
__daemontoolsService() {
  local user="${1-}" && shift
  export HOME APPLICATION_USER
  HOME=$(_home "$user") || _return $? "No home for {APPLICATION_USER}" || return $?
  APPLICATION_USER="$user"
  exec setuidgid "$user" "{BINARY}" "$@" || _return $? "Unable to load {BINARY} $*" || return $?
}

__daemontoolsService "{APPLICATION_USER}" "$@"
