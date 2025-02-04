#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/_isExecutable.sh"

# Requires: find stat
__listFileModificationTimes() {
  local directory="$1" && shift
  find "$directory" -type f "$@" -exec stat -f '%m %N' {} \;
}

# Requires: printf
__packageManagerDefault() {
  printf "%s\n" "brew"
}

# Requires: xargs sed
__xargsSedInPlaceReplace() {
  xargs sed -i '' "$@"
}

# Requires: printf
__urlBinary() {
  printf "%s\n" "open"
}

# Usage: {fn} date format
# Requires: date
__dateToFormat() {
  date -u -jf '%F %T' "$1 00:00:00" "+$2" 2>/dev/null
}

# Requires: date
__timestampToDate() {
  date -u -r "$1" "+$2"
}

# Requires: mv
__renameLink() {
  mv -fh "$@"
}

# Requires: readlink
__realPath() {
  readlink -f -n "$@"
}

# Requires: hostname
__hostname() {
  hostname -f
}
