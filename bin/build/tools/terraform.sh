#!/usr/bin/env bash
#
# terraform.sh
#
# Terraform tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

#
# Add keys to enable apt to download terraform directly from hashicorp.com
#
# Usage: aptKeyAddHashicorp
# Exit Code: 1 - if environment is awry
# Exit Code: 0 - All good to install terraform
#
aptKeyAddHashicorp() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  __environment aptKeyAdd --title Hashicorp --name hashicorp --url https://apt.releases.hashicorp.com/gpg || return $?
}
_aptKeyAddHashicorp() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Add keys to enable apt to download terraform directly from hashicorp.com
#
# Usage: aptKeyAddHashicorp
# Exit Code: 1 - if environment is awry
# Exit Code: 0 - All good to install terraform
#
aptKeyRemoveHashicorp() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  __environment aptKeyRemove hashicorp "$@" || return $?
}
_aptKeyRemoveHashicorp() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Install terraform binary
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install using `packageInstall`
#
terraformInstall() {
  local usage="_${FUNCNAME[0]}" binary="terraform"

  __help "$usage" "$@" || return 0
  ! whichExists "$binary" || return 0
  if aptIsInstalled; then
    __catchEnvironment "$usage" packageInstall gnupg software-properties-common curl figlet || return $?
    __catchEnvironment "$usage" aptKeyAddHashicorp || return $?
  fi
  __catchEnvironment "$usage" packageInstall "$binary" "$@" || return $?
  whichExists "$binary" || __throwEnvironment "$usage" "No $binary binary found - installation failed" || return $?
}
_terraformInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Remove terraform binary
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to uninstall using `packageUninstall`
#
terraformUninstall() {
  local usage="_${FUNCNAME[0]}"

  __help "$usage" "$@" || return 0
  whichExists terraform || return 0
  __catchEnvironment "$usage" packageWhichUninstall terraform terraform "$@" || return $?
  __catchEnvironment "$usage" aptKeyRemoveHashicorp || return $?
  __catchEnvironment "$usage" packageUpdate --force || return $?
}
_terraformUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
