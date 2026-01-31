#!/usr/bin/env bash
#
# apt functions
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/apt.md
# Test: o ./test/tools/apt-tests.sh

#               _
#    __ _ _ __ | |_
#   / _` | '_ \| __|
#  | (_| | |_) | |_
#   \__,_| .__/ \__|
#        |_|

__aptLoader() {
  __buildFunctionLoader ___aptUpdate apt "$@"
}

#
# Is apt-get installed?
#
# shellcheck disable=SC2120
aptIsInstalled() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  executableExists apt apt-get dpkg 2>/dev/null && [ -f /etc/debian_version ]
}
_aptIsInstalled() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run apt-get non-interactively
# Argument: ... - Arguments. Pass through arguments to `apt-get`
aptNonInteractive() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  __aptLoader "$handler" "_$handler" "$@"
}
_aptNonInteractive() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get key ring directory path
aptKeyRingDirectory() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  printf "%s\n" "/etc/apt/keyrings"
}
_aptKeyRingDirectory() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get APT source list path
aptSourcesDirectory() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  printf "%s\n" "/etc/apt/sources.list.d"
}
_aptSourcesDirectory() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Add keys to enable apt to download terraform directly from hashicorp.com
#
# Argument: --title keyTitle - String. Optional. Title of the key.
# Argument: --name keyName - String. Required. Name of the key used to generate file names.
# Argument: --url remoteUrl - URL. Required. Remote URL of gpg key.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 1 - if environment is awry
# Return Code: 0 - Apt key is installed AOK
#
aptKeyAdd() {
  __aptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_aptKeyAdd() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Remove apt keys
#
# Argument: keyName - String. Required. One or more key names to remove.
# Argument: --skip - Flag. Optional. a Do not do `apt-get update` afterwards to update the database.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 1 - if environment is awry
# Return Code: 0 - Apt key was removed AOK
#
aptKeyRemove() {
  __aptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_aptKeyRemove() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Update the global database
# See: packageUpdate
# package.sh: true
__aptUninstall() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptDefault() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptUpdate() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptUpgrade() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptInstall() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptInstalledList() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptPackageMapping() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptStandardPackages() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptAvailableList() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
