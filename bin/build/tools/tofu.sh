#!/usr/bin/env bash
#
# tofu.sh
#
# OpenTOFU tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
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
  local usage="_${FUNCNAME[0]}"
  local args=(
    --title OpenTOFU
    --name opentofu --url https://get.opentofu.org/opentofu.gpg
    --name opentofu-repo --url https://packages.opentofu.org/opentofu/tofu/gpgkey
    --repository-url https://packages.opentofu.org/opentofu/tofu/any/
    --release any
    --source deb-src
  )
  __usageEnvironment "$usage" aptKeyAdd "${args[@]}" || return $?
}
_aptKeyAddOpenTofu() {
  # IDENTICAL usageDocument 1
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
  local usage="_${FUNCNAME[0]}"
  __usageEnvironment "$usage" aptKeyRemove opentofu "$@" || return $?
}
_aptKeyRemoveOpenTofu() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Install tofu binary
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install using `aptInstall`
#
tofuInstall() {
  local usage="_${FUNCNAME[0]}" binary="tofu"

  ! whichExists "$binary" || return 0
  __usageEnvironment "$usage" aptInstall apt-transport-https ca-certificates curl gnupg
  __usageEnvironment "$usage" aptKeyAddOpenTofu || return $?
  __usageEnvironment "$usage" aptInstall "$binary" "$@" || return $?
  whichExists "$binary" || __failEnvironment "$usage" "No $binary binary found - installation failed" || return $?
}
_tofuInstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Uninstall tofu binary and apt sources keys
#
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to uninstall using `aptUninstall`
#
tofuUninstall() {
  local usage="_${FUNCNAME[0]}"

  __usageEnvironment "$usage" whichAptUninstall tofu tofu "$@" || return $?
  __usageEnvironment "$usage" aptKeyRemoveOpenTofu || return $?
  __usageEnvironment "$usage" aptUpdateOnce --force || return $?
}
_tofuUninstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
