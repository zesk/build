#!/usr/bin/env bash
#
# terraform.sh
#
# Terraform tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

#
# Add keys to enable apt to download terraform directly from hashicorp.com
#
# Usage: aptKeyAddHashicorp
# Exit Code: 1 - if environment is awry
# Exit Code: 0 - All good to install terraform
#
aptKeyAddHashicorp() {
  __environment aptKeyAdd --title Hashicorp --name hashicorp --url https://apt.releases.hashicorp.com/gpg || return $?
}

#
# Add keys to enable apt to download terraform directly from hashicorp.com
#
# Usage: aptKeyAddHashicorp
# Exit Code: 1 - if environment is awry
# Exit Code: 0 - All good to install terraform
#
aptKeyRemoveHashicorp() {
  __environment aptKeyRemove hashicorp "$@" || return $?
}

#
# Install terraform binary
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install using `aptInstall`
#
terraformInstall() {
  local usage="_${FUNCNAME[0]}" binary="terraform"

  ! whichExists "$binary" || return 0
  __usageEnvironment "$usage" aptInstall gnupg software-properties-common curl figlet
  __usageEnvironment "$usage" aptKeyAddHashicorp || return $?
  __usageEnvironment "$usage" aptInstall "$binary" "$@" || return $?
  whichExists "$binary" || __failEnvironment "$usage" "No $binary binary found - installation failed" || return $?
}
_terraformInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Remove terraform binary
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to uninstall using `aptUninstall`
#
terraformUninstall() {
  local usage="_${FUNCNAME[0]}"

  __usageEnvironment "$usage" whichAptUninstall terraform terraform "$@" || return $?
  __usageEnvironment "$usage" aptKeyRemoveHashicorp || return $?
  __usageEnvironment "$usage" aptUpdateOnce --force || return $?
}
_terraformUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
