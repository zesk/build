#!/usr/bin/env bash
#
# Not Alpine
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Date support for %3N helps with milliseconds
__timestamp() {
  date '+%s%3N'
}

__testPlatformName() {
  printf -- "%s\n" "linux"
}

# Requires: apkIsInstalled printf _environment _packageDebugging
__packageManagerDefault() {
  if aptIsInstalled; then
    printf "%s\n" "apt"
  else
    _environment "Not able to detect package manager $(_packageDebugging)" || return $?
  fi
}

__bigTextBinary() {
  printf -- "%s\n" "toilet"
}
