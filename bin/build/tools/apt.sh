#!/usr/bin/env bash
#
# apt functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/apt.md
# Test: o ./test/tools/apt-tests.sh

__aptLoader() {
  __functionLoader ___aptUpdate apt "$@"
}

#
# Is apt-get installed?
#
aptIsInstalled() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  whichExists apt apt-get dpkg && [ -f /etc/debian_version ]
}
_aptIsInstalled() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run apt-get non-interactively
# Argument: ... - Pass through arguments to `apt-get`
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
# Usage: {fn} --name keyName [ --title title ] remoteUrl
# Argument: --title title - Optional. String. Title of the key.
# Argument: --name name - Required. String. Name of the key used to generate file names.
# Argument: --url remoteUrl - Required. URL. Remote URL of gpg key.
# Exit Code: 1 - if environment is awry
# Exit Code: 0 - Apt key is installed AOK
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
# Usage: {fn} keyName [ ... ]
# Argument: keyName - Required. String. One or more key names to remove.
# Argument: --skip - Flag. Optional.a Do not do `apt-get update` afterwards to update the database.
# Exit Code: 1 - if environment is awry
# Exit Code: 0 - Apt key is installed AOK
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
  __aptLoader "_return" "_${FUNCNAME[0]}" "$@"
}
__aptUpdate() {
  __aptLoader "_return" "_${FUNCNAME[0]}" "$@"
}
__aptInstall() {
  __aptLoader "_return" "_${FUNCNAME[0]}" "$@"
}
__aptInstalledList() {
  __aptLoader "_return" "_${FUNCNAME[0]}" "$@"
}
__aptPackageMapping() {
  __aptLoader "_return" "_${FUNCNAME[0]}" "$@"
}
__aptStandardPackages() {
  __aptLoader "_return" "_${FUNCNAME[0]}" "$@"
}
__aptAvailableList() {
  __aptLoader "_return" "_${FUNCNAME[0]}" "$@"
}
