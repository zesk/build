#!/bin/bash
#
# Identical template
#
# Original of __installCheck
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __installCheck EOF

# Check the directory after installation and output the version
# Argument: name - String. Requires. Installed name.
# Argument: versionFile - RelativeFile. Required. Relative path to version file, containing `.id` and `.version` jq selectors.
# Argument: usageFunction - Function. Required. Call this on failure.
# Argument: installPath - Directory. Required. Path to check for installation.
# Requires: dirname
# Requires: decorate printf __throwEnvironment read jq
__installCheck() {
  local name="$1" version="$2" usage="$3" installPath="$4"
  local versionFile="$installPath/$version"
  if [ ! -f "$versionFile" ]; then
    __throwEnvironment "$usage" "$(printf "%s: %s\n\n  %s\n  %s\n" "$(decorate error "$name")" "Incorrect version or broken install (can't find $version):" "rm -rf $(dirname "$installPath/$version")" "${BASH_SOURCE[0]}")" || return $?
  fi
  read -r version id < <(jq -r '(.version + " " + .id)' <"$versionFile" || :) || :
  [ -n "$version" ] && [ -n "$id" ] || __throwEnvironment "$usage" "$versionFile missing version: \"$version\" or id: \"$id\"" || return $?
  printf "%s %s (%s)\n" "$(decorate bold-blue "$name")" "$(decorate code "$version")" "$(decorate orange "$id")"
}
