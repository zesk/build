#!/usr/bin/env bash
#
# terraform.sh
#
# Terraform tools
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Add keys to enable apt to download terraform directly from hashicorp.com
#
# Return Code: 1 - if environment is awry
# Return Code: 0 - All good to install terraform
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
aptKeyAddHashicorp() {
  local handler="_${FUNCNAME[0]}"
  helpArgument "$handler" "$@" || return 0
  catchReturn "$handler" aptKeyAdd --title Hashicorp --name hashicorp --url https://apt.releases.hashicorp.com/gpg || return $?
}
_aptKeyAddHashicorp() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Add keys to enable apt to download terraform directly from hashicorp.com
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 1 - if environment is awry
# Return Code: 0 - All good to install terraform
aptKeyRemoveHashicorp() {
  local handler="_${FUNCNAME[0]}"
  helpArgument "$handler" "$@" || return 0
  catchReturn "$handler" aptKeyRemove hashicorp "$@" || return $?
}
_aptKeyRemoveHashicorp() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Install terraform binary
#
# Argument: package ... - String. Optional. Additional packages to install using `packageInstall`
terraformInstall() {
  local handler="_${FUNCNAME[0]}" binary="terraform"

  helpArgument "$handler" "$@" || return 0
  ! executableExists "$binary" || return 0
  if aptIsInstalled; then
    catchReturn "$handler" packageInstall gnupg software-properties-common curl figlet || return $?
    catchReturn "$handler" aptKeyAddHashicorp || return $?
  fi
  catchReturn "$handler" packageInstall "$binary" "$@" || return $?
  executableExists "$binary" || throwEnvironment "$handler" "No $binary binary found - installation failed" || return $?
}
_terraformInstall() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove terraform binary
#
# Argument: package ... - String. Optional. Additional packages to uninstall using `packageUninstall`
terraformUninstall() {
  local handler="_${FUNCNAME[0]}"

  helpArgument "$handler" "$@" || return 0
  executableExists terraform || return 0
  catchReturn "$handler" packageWhichUninstall terraform terraform "$@" || return $?
  catchReturn "$handler" aptKeyRemoveHashicorp || return $?
  catchReturn "$handler" packageUpdate --force || return $?
}
_terraformUninstall() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
