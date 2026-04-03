#!/usr/bin/env bash
#
# tofu.sh
#
# OpenTOFU tools
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# https://opentofu.org/docs/
#

# Add keys to enable apt to download tofu directly from opentofu.org
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 1 - if environment is awry
# Return Code: 0 - All good to install terraform
# See: aptKeyRemoveOpenTofu
aptKeyAddOpenTofu() {
  local handler="_${FUNCNAME[0]}"
  local args=(
    --title OpenTOFU
    --name opentofu --url https://get.opentofu.org/opentofu.gpg
    --name opentofu-repo --url https://packages.opentofu.org/opentofu/tofu/gpgkey
    --repository-url https://packages.opentofu.org/opentofu/tofu/any/
    --release any
    --source deb-src
  )
  __help "$handler" "$@" || return 0
  catchReturn "$handler" aptKeyAdd "${args[@]}" || return $?
}
_aptKeyAddOpenTofu() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove keys to disable apt to download tofu from opentofu.org
# See: aptKeyAddOpenTofu
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 1 - Environment problems
# Return Code: 0 - All good to install tofu
aptKeyRemoveOpenTofu() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  catchReturn "$handler" aptKeyRemove opentofu "$@" || return $?
}
_aptKeyRemoveOpenTofu() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Install tofu binary
#
# Argument: package - String. Optional. Additional packages to install using `packageInstall`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# See: tofuUninstall packageInstall
tofuInstall() {
  local handler="_${FUNCNAME[0]}" binary="tofu"

  __help "$handler" "$@" || return 0
  ! executableExists "$binary" || return 0
  catchReturn "$handler" packageInstall apt-transport-https ca-certificates curl gnupg || return $?
  catchReturn "$handler" aptKeyAddOpenTofu || return $?
  catchReturn "$handler" packageInstall "$binary" "$@" || return $?
  executableExists "$binary" || throwEnvironment "$handler" "No $binary binary found - installation failed" || return $?
}
_tofuInstall() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Uninstall tofu binary and apt sources keys
#
# Argument: package - String. Optional. Additional packages to uninstall using `packageUninstall`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# See: tofuInstall packageUninstall
tofuUninstall() {
  local handler="_${FUNCNAME[0]}"

  __help "$handler" "$@" || return 0
  catchReturn "$handler" packageWhichUninstall tofu tofu "$@" || return $?
  catchReturn "$handler" aptKeyRemoveOpenTofu || return $?
  catchReturn "$handler" packageUpdate --force || return $?
}
_tofuUninstall() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
