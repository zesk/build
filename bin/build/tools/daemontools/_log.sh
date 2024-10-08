#!/bin/bash
#
# Generic log service
#
# Copyright &copy; 2024 Market Acumen, Inc.
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

# IDENTICAL __execute 9
# Usage: {fn} __execute binary [ ... ]
# Argument: binary - Required. Executable.
# Argument: ... - Any arguments are passed to binary
# Run binary and output failed command upon error
# Unlike `_sugar.sh`'s `__execute`, this does not depend on `_command`.
# Requires-IDENTICAL: _return
__execute() {
  "$@" || _return "$?" "$@" || return $?
}

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

# Usage: {fn} user logPath
# Make `user` owner of all files in `logPath`
_ownFiles() {
  local user="$1" logPath="$2"
  if [ -n "$(find "$logPath" -type f -print -quit)" ]; then
    if ! find "$logPath" -type f -or -type d -print0 | xargs -0 chown "$user:"; then
      printf "%s: %s (%s)\n" "No files found in" "$logPath" "$user"
    else
      printf "%s: %s -> %s\n" "Owner of files in" "$logPath" "$user"
    fi
  fi
}

# Usage: {fn} user logPath
# Argument: user - User to run as
# Argument: logPath - Directory to log to
_logger() {
  local user="${1-}" name logPath="${2-}" user
  export HOME APPLICATION_USER

  name="$(basename "$(dirname "$(pwd)")")" || _return $? determining name || return $?
  printf "Logging for %s\n" "$name"
  HOME=$(_home "$user") || _return $?
  APPLICATION_USER=$user

  [ -d "$logPath" ] || _return 4 "$logPath is not a directory" || return $?
  __execute _ownFiles "$user" "$logPath" || return $?
  logPath="$logPath/$name"
  [ -d "$logPath" ] || __execute mkdir -p "$logPath" || return $?
  __execute chown -R "$user:" "$logPath" || return $?
  __execute chmod 775 "$logPath" || return $?
  __execute cd "$logPath" || return $?

  exec setuidgid "$user" multilog t "$logPath"
}

_logger "{APPLICATION_USER}" "{LOG_PATH}"
