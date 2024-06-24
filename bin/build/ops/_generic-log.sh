#!/bin/bash
#
# Generic log service
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail
_return() {
  local code
  code="${1-0}" && exec 1>&2 && shift && printf "%s -> %d\n" "$(printf "%s " "$@")" "$code" && return "$code"
}
__return() {
  "$@" || _return $? "$@" || return $?
}
# IDENTICAL _user 8
_user() {
  local userDatabase=/etc/passwd
  export APPLICATION_USER HOME
  APPLICATION_USER="$1"
  HOME=$(grep "^$APPLICATION_USER:" "$userDatabase" | cut -d : -f 6) || _return $? "No such user $APPLICATION_USER in $userDatabase" || return $?
  [ -d "$HOME" ] || _return $? "User $APPLICATION_USER HOME=$HOME is not a directory" || return $?
  printf "%s\n" "$APPLICATION_USER"
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
  [ -d "$logPath" ] || _return $? "$logPath is not a directory" || return $?

  __return _ownFiles "$user" "$logPath" || return $?
  logPath="$logPath/$name"
  [ -d "$logPath" ] || __return mkdir -p "$logPath" || return $?
  __return chown -R "$user:" "$logPath" || return $?
  __return chmod 775 "$logPath" || return $?
  __return cd "$logPath" || return $?

  exec setuidgid "$user" multilog t "$logPath"
}

_ownFiles() {
  local user="$1" logPath="$2"
  if [ -n "$(find "$logPath" -type f -print -quit)" ]; then
    if ! find "$logPath" -type f -print0 | xargs -0 chown "$user:"; then
      printf "%s: %s (%s)\n" "No files found in" "$logPath" "$user"
    else
      printf "%s: %s -> %s\n" "Owner of files in" "$logPath" "$user"
    fi
  fi
}

_logger "{APPLICATION_USER}" "{LOG_PATH}"

_setApplicationUserOwner
