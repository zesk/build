#!/usr/bin/env bash
#
# tofu.sh
#
# OpenTOFU tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# https://opentofu.org/docs/
#

#
# Add keys to enable apt to download tofu directly from hashicorp.com
#
# Usage: aptKeyAddHashicorp
# Exit Code: 1 - if environment is awry
# Exit Code: 0 - All good to install terraform
#
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
  __catch "$handler" aptKeyAdd "${args[@]}" || return $?
}
_aptKeyAddOpenTofu() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Add keys to enable apt to download tofu directly from hashicorp.com
#
# Usage: aptKeyAddHashicorp
# Exit Code: 1 - Environment problems
# Exit Code: 0 - All good to install tofu
#
aptKeyRemoveOpenTofu() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  __catch "$handler" aptKeyRemove opentofu "$@" || return $?
}
_aptKeyRemoveOpenTofu() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Install tofu binary
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install using `packageInstall`
#
tofuInstall() {
  local handler="_${FUNCNAME[0]}" binary="tofu"

  __help "$handler" "$@" || return 0
  ! whichExists "$binary" || return 0
  __catch "$handler" packageInstall apt-transport-https ca-certificates curl gnupg || return $?
  __catch "$handler" aptKeyAddOpenTofu || return $?
  __catch "$handler" packageInstall "$binary" "$@" || return $?
  whichExists "$binary" || __throwEnvironment "$handler" "No $binary binary found - installation failed" || return $?
}
_tofuInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Uninstall tofu binary and apt sources keys
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to uninstall using `packageUninstall`
#
tofuUninstall() {
  local handler="_${FUNCNAME[0]}"

  __help "$handler" "$@" || return 0
  __catch "$handler" packageWhichUninstall tofu tofu "$@" || return $?
  __catch "$handler" aptKeyRemoveOpenTofu || return $?
  __catch "$handler" packageUpdate --force || return $?
}
_tofuUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
