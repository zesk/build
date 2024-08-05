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

# END of IDENTICAL _return

# IDENTICAL __return 8
# Usage: {fn} __return binary [ ... ]
# Argument: binary - Required. Executable.
# Argument: ... - Any arguments are passed to binary
# Run binary and output failed command upon error
__return() {
  [ $# -gt 0 ] || _argument "${FUNCNAME[0]} no arguments $(debuggingStack -s)" || return $?
  "$@" || _return "$?" "$@" || return $?
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
  local user name logPath user

  name="$(basename "$(dirname "$(pwd)")")" || _return $? determining name || return $?
  printf "Logging for %s\n" "$name"

  user=$(_user "${1-}") || _return $? _user "{APPLICATION_USER}" || return $?
  logPath="${2-}"
  [ -d "$logPath" ] || _return 4 "$logPath is not a directory" || return $?

  __return _ownFiles "$user" "$logPath" || return $?
  logPath="$logPath/$name"
  [ -d "$logPath" ] || __return mkdir -p "$logPath" || return $?
  __return chown -R "$user:" "$logPath" || return $?
  __return chmod 775 "$logPath" || return $?
  __return cd "$logPath" || return $?

  exec setuidgid "$user" multilog t "$logPath"
}

_logger "{APPLICATION_USER}" "{LOG_PATH}"
