#!/usr/bin/env bash
#
# Most Linux fall here: Alpine Ubuntu Debian FreeBSD
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

if ! insideDocker; then
  # shellcheck source=/dev/null
  source "${BASH_SOURCE[0]%/*}/_isExecutable.sh"
else
  # shellcheck source=/dev/null
  source "${BASH_SOURCE[0]%/*}/_isExecutable.docker.sh"
fi

# Requires: find stat
__fileModificationTimes() {
  local directory="$1" && shift
  find "$directory" -type f "$@" -exec stat --format='%Y %n' {} \;
}

# Requires: apkIsInstalled printf _environment _packageDebugging
__packageManagerDefault() {
  if apkIsInstalled; then
    printf "%s\n" "apk"
  elif aptIsInstalled; then
    printf "%s\n" "apt"
  else
    _environment "Not able to detect package manager $(_packageDebugging)" || return $?
  fi
}

# Requires: xargs sed
__xargsSedInPlaceReplace() {
  xargs sed --in-place "$@"
}

# Requires: printf
__urlBinary() {
  printf "%s\n" "open" "xdg-open" "kde-open"
}

# Usage: {fn} date format
# Requires: date
__dateToFormat() {
  date -u --date="$1 00:00:00" "+$2" 2>/dev/null
}

# Requires: date
__timestampToDate() {
  date -u -d "@$1" "+$2"
}

# Requires: mv
__renameLink() {
  # gnu version supports -T
  mv -fT "$@"
}

# Requires: realpath
__realPath() {
  realpath "$@"
}

# some flavors of BSD (i.e. NetBSD and OpenBSD) don't have the -f option
# Put these in __platform when you discover it
# Requires: hostname
__hostname() {
  hostname -f
}

if isAlpine; then
  # Options here are:
  # - Bash 5 (no) `EPOCHREALTIME`
  # - gnu date (no) via coreutils "%s%N"
  # uptime hack here (yes)
  __timestamp() {
    local sec ms
    IFS="." read -d ' ' -r upsec ms </proc/uptime || :
    : "$upsec"
    sec=$(date '+%s')
    printf "%d%s0\n" "$ms" "$sec"
  }

  __testPlatformName() {
    printf -- "%s\n" "alpine"
  }
else
  # Date support for %3N helps with milliseconds
  __timestamp() {
    local sec ms
    date '+%s%3N'
  }

  __testPlatformName() {
    printf -- "%s\n" "linux"
  }
fi

__bigTextBinary() {
  if apkIsInstalled; then
    printf "%s\n" "toilet"
  else
    printf "%s\n" "figlet"
  fi
}

# Support arguments and stdin as arguments to an executor
__executeInputSupport() {
  local usage="$1" executor=() && shift

  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      shift
      break
    fi
    executor+=("$1")
    shift
  done
  [ ${#executor[@]} -gt 0 ] || return 0

  # On Darwin `read -t 0` DOES NOT WORK as a select on stdin
  if [ $# -eq 0 ] && read -r -t 0; then
    local line
    while read -r line; do
      __catchEnvironment "$usage" "${executor[@]}" "$line" || return $?
    done
  else
    if [ "${1-}" = "--" ]; then
      shift
    fi
    __catchEnvironment "$usage" "${executor[@]}" "$@" || return $?
  fi
}
