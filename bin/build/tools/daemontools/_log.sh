#!/bin/bash
#
# Generic log service
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL _return 28

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  if [ "$code" -gt 0 ]; then icon="❌ [$code]" && to=2; fi
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

# _IDENTICAL_ __execute 7

# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Run binary and output failed command upon error
# Requires: _return
__execute() {
  "$@" || _return "$?" "$@" || return $?
}

# IDENTICAL _home 15

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

# Usage: {fn} user logHome
# Make `user` owner of all files in `logHome`
_ownFiles() {
  local user="$1" logHome="$2"
  if [ -n "$(find "$logHome" -type f -print -quit)" ]; then
    if ! find "$logHome" -type f -or -type d -print0 | xargs -0 chown "$user:"; then
      printf "%s: %s (%s)\n" "No files found in" "$logHome" "$user"
    else
      printf "%s: %s -> %s\n" "Owner of files in" "$logHome" "$user"
    fi
  fi
}

# Usage: {fn} user logHome
# Argument: user - User to run as
# Argument: logHome - Directory to log to
_logger() {
  local user="${1-}" name logHome="${2-}" user && shift 2
  export HOME APPLICATION_USER

  name="$(basename "$(dirname "$(pwd)")")" || _return $? determining name || return $?
  printf "Logging for %s\n" "$name"
  HOME=$(_home "$user") || _return $?
  APPLICATION_USER=$user

  [ -d "$logHome" ] || _return 4 "$logHome is not a directory" || return $?
  __execute _ownFiles "$user" "$logHome" || return $?
  logHome="$logHome/$name"
  [ -d "$logHome" ] || __execute mkdir -p "$logHome" || return $?
  __execute chown -R "$user:" "$logHome" || return $?
  __execute chmod 775 "$logHome" || return $?
  __execute cd "$logHome" || return $?

  exec setuidgid "$user" multilog t "$@" "$logHome"
}

# shellcheck disable=SC1083
_logger "{APPLICATION_USER}" "{LOG_HOME}"{ARGUMENTS} "$@"
