#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/_isExecutable.sh"

__listFileModificationTimes() {
  local directory="$1" && shift
  find "$directory" -type f "$@" -exec stat -f '%m %N' {} \;
}

__packageManagerDefault() {
  printf "%s\n" "brew"
}

__xargsSedInPlaceReplace() {
  xargs sed -i '' "$@"
}
