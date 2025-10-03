#!/usr/bin/env bash
#
# Alpine-specific
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Options here are:
# - Bash 5 (no) `EPOCHREALTIME`
# - gnu date (no) via coreutils "%s%N"
# uptime hack here (yes)
__timestamp() {
  local sec ms
  sec=$(date '+%s')
  IFS="." read -d ' ' -r upsec ms </proc/uptime || :
  : "$upsec"
  printf "%s%s0\n" "$sec" "$ms"
}

__testPlatformName() {
  printf -- "%s\n" "alpine"
}

# Requires: apkIsInstalled printf returnEnvironment _packageDebugging
__packageManagerDefault() {
  if apkIsInstalled; then
    printf "%s\n" "apk"
  else
    returnEnvironment "Not able to detect package manager $(_packageDebugging)" || return $?
  fi
}

__bigTextBinary() {
  printf -- "%s\n" "figlet"
}

__pcregrepBinary() {
  printf "%s\n" pcre2grep
}

__pcregrepInstall() {
  packageWhich pcre2grep pcre2-tools || return $?
}
