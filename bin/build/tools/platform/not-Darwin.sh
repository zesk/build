#!/usr/bin/env bash
#
# non-Darwin functionality
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Requires: find stat
__fileModificationTimes() {
  local directory="$1" && shift
  find "$directory" -type f "$@" -exec stat --format='%Y %n' {} \;
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

# Requires: mv
__linkRename() {
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

# Requires: date
__dateFromTimestamp() {
  date -u -d "@$1" "+$2"
}

__groupID() {
  getent group "$1" | cut -d: -f3
}
