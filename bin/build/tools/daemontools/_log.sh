#!/bin/bash
#
# Generic log service
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL returnMessage 39

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Return Code: exitCode
# Requires: isUnsignedInteger printf returnMessage
returnMessage() {
  local handler="_${FUNCNAME[0]}"
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  if [ "$code" = "--help" ]; then "$handler" 0 && return; fi
  isUnsignedInteger "$code" || returnMessage 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${handler#_} non-integer \"$code\"" "$@" || return $?
  if [ "$code" -gt 0 ]; then icon="❌ [$code]" && to=2; fi
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
}
_returnMessage() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Argument: value - EmptyString. Value to test if it is an unsigned integer.
# Usage: {fn} argument ...
# Return Code: 0 - if it is an unsigned integer
# Return Code: 1 - if it is not an unsigned integer
# Requires: returnMessage
isUnsignedInteger() {
  [ $# -eq 1 ] || returnMessage 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}
_isUnsignedInteger() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL returnMessage

# _IDENTICAL_ execute 7

# Argument: binary ... - Required. Executable. Any arguments are passed to `binary`.
# Run binary and output failed command upon error
# Requires: returnMessage
execute() {
  "$@" || returnMessage "$?" "$@" || return $?
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

# Make `user` owner of all files in `logHome`
__ownLogHome() {
  local user="$1" logHome="$2"
  if [ -n "$(find "$logHome" -type f -print -quit)" ]; then
    if ! find "$logHome" -type f -or -type d -print0 | xargs -0 chown "$user:"; then
      printf "%s: %s (%s)\n" "Unable to change file ownership" "$logHome" "$user" 1>&2
    else
      printf "%s: %s -> %s\n" "Owner of files in" "$logHome" "$user"
    fi
  else
    printf "%s: %s (%s)\n" "No files found in" "$logHome" "$user" 1>&2
  fi
}

# Usage: {fn} user logHome
# Argument: user - User to run as
# Argument: logHome - Directory to log to
__serviceLogger() {
  local user="${1-}" name logHome="${2-}" userName && shift 2
  export HOME APPLICATION_USER

  name="$(basename "$(dirname "$(pwd)")")" || returnMessage $? determining name || return $?
  userName=$(userRecordName "$user") || returnMessage $?
  HOME=$(userRecordHome "$user") || returnMessage $?
  printf "Logging for service '%s' as user %s (%s) (Home is %s)\n" "$name" "$userName" "$user" "$HOME"
  APPLICATION_USER=$user

  [ -d "$logHome" ] || returnMessage 4 "$logHome is not a directory" || return $?
  execute __ownLogHome "$user" "$logHome" || return $?
  logHome="$logHome/$name"
  [ -d "$logHome" ] || execute mkdir -p "$logHome" || return $?
  execute chown -R "$user:" "$logHome" || return $?
  execute chmod 775 "$logHome" || return $?
  execute cd "$logHome" || return $?

  exec setuidgid "$user" multilog t "$@" "$logHome"
}

# shellcheck disable=SC1083
__serviceLogger "{APPLICATION_USER}" "{LOG_HOME}"{ARGUMENTS} "$@"
