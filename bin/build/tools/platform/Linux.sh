#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

if ! insideDocker; then
  # shellcheck source=/dev/null
  source "${BASH_SOURCE[0]%/*}/_isExecutable.sh"
fi

__listFileModificationTimes() {
  local directory="$1" && shift
  find "$directory" -type f "$@" -exec stat --format='%Y %n' {} \;
}

__packageManagerDefault() {
  if apkIsInstalled; then
    printf "%s\n" "apk"
  elif aptIsInstalled; then
    printf "%s\n" "apt"
  else
    _environment "Not able to detect package manager $(_packageDebugging)" || return $?
  fi
}

__xargsSedInPlaceReplace() {
  xargs sed --in-place "$@"
}
