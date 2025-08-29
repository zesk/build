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
# handler: aptKeyAddHashicorp
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
# handler: aptKeyAddHashicorp
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
# handler: {fn} [ package ... ]
# Argument: package - Additional packages to install using `packageInstall`
#
terraformInstall() {
  local handler="_${FUNCNAME[0]}" binary="terraform"

  __help "$handler" "$@" || return 0
  ! whichExists "$binary" || return 0
  if aptIsInstalled; then
    __catch "$handler" packageInstall gnupg software-properties-common curl figlet || return $?
    __catch "$handler" aptKeyAddHashicorp || return $?
  fi
  __catch "$handler" packageInstall "$binary" "$@" || return $?
  whichExists "$binary" || __throwEnvironment "$handler" "No $binary binary found - installation failed" || return $?
}
_terraformInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Remove terraform binary
#
# handler: {fn} [ package ... ]
# Argument: package - Additional packages to uninstall using `packageUninstall`
#
terraformUninstall() {
  local handler="_${FUNCNAME[0]}"

  __help "$handler" "$@" || return 0
  whichExists terraform || return 0
  __catch "$handler" packageWhichUninstall terraform terraform "$@" || return $?
  __catch "$handler" aptKeyRemoveHashicorp || return $?
  __catch "$handler" packageUpdate --force || return $?
}
_terraformUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
