#!/usr/bin/env bash
#
# Not Alpine
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Date support for %3N helps with milliseconds
__timestamp() {
  date '+%s%3N'
}

__testPlatformName() {
  printf -- "%s\n" "linux"
}

# Requires: apkIsInstalled printf returnEnvironment _packageDebugging
__packageManagerDefault() {
  if aptIsInstalled; then
    printf "%s\n" "apt"
  elif yumIsInstalled; then
    printf "%s\n" "yum"
  else
    returnEnvironment "Not able to detect package manager $(_packageDebugging)" || return $?
  fi
}

__bigTextBinary() {
  printf -- "%s\n" "toilet"
}
