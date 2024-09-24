#!/bin/bash
#
# Identical template
#
# Original of __installCheck
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL __installCheck EOF
# Check the directory after installation and output the version
# Usage: {fn} name versionFile usageFunction installPath
__installCheck() {
  local name="$1" version="$2" usage="$3" installPath="$4"
  local versionFile="$installPath/$version"
  if [ ! -f "$versionFile" ]; then
    __failEnvironment "$usage" "$(printf "%s\n\n  %s\n  %s\n" "Incorrect version or broken install (can't find $version):" "rm -rf bin/build" "${BASH_SOURCE[0]}")" || return $?
  fi
  read -r version id < <(jq -r '(.version + " " + .id)' <"$versionFile") || :
  printf "%s %s (%s)\n" "$(consoleBoldBlue "$name")" "$(consoleCode "$version")" "$(consoleOrange "$id")"
}
