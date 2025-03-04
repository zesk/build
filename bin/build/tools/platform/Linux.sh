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
__listFileModificationTimes() {
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

# Date support for %3N helps with milliseconds
__timestamp() {
  local sec ms
  sec=$(date '+%s:%3N')
  local ms="${sec#*:}"
  ms=${ms#0}
  printf "%d\n" $((${sec%:*} * 1000 + ${ms#0}))
}

if isAlpine; then
  __testPlatformName() {
    printf -- "%s\n" "alpine"
  }
else
  __testPlatformName() {
    printf -- "%s\n" "linux"
  }
fi
