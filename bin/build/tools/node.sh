#!/usr/bin/env bash
#
# node functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# Install nodejs
nodeInstall() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments
  local quietLog

  nArguments=$#
  while [ $# -gt 0 ]; do
    argument="$(usageArgumentString "$usage" "argument #$((nArguments - $# + 1))" "${1-}")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        usageArgumentUnknown "$usage" "$argument" || return $?
        ;;
    esac
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done

  if packageIsInstalled nodejs; then
    __nodeInstall_corepackEnable "$usage" || return $?
    return 0
  fi

  quietLog=$(__usageEnvironment "$usage" buildQuietLog "${usage#_}") || return $?
  __usageEnvironment "$usage" requireFileDirectory "$quietLog" || return $?
  statusMessage --first decorate info "Installing nodejs ... " || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" packageInstall nodejs || return $?
  __nodeInstall_corepackEnable "$usage" || return $?
}
_nodeInstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__nodeInstall_corepackEnable() {
  local usage="$1"
  if ! whichExists corepack; then
    statusMessage decorate warning "No corepack - installing using npm" || return $?
    __usageEnvironment "$usage" npmInstall || return $?
    __usageEnvironment "$usage" npm install -g corepack || return $?
    whichExists corepack || __failEnvironment "$usage" "corepack not found after global installation - failing: PATH=$PATH" || return $?
  fi
  local home
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  __usageEnvironment "$usage" muzzle pushd "$home" || return $?
  __usageEnvironment "$usage" corepack enable || _undo $? muzzle popd || return $?
  __usageEnvironment "$usage" muzzle popd || return $?
}

# Uninstall nodejs
nodeUninstall() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments

  nArguments=$#
  while [ $# -gt 0 ]; do
    argument="$(usageArgumentString "$usage" "argument #$((nArguments - $# + 1))" "${1-}")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        usageArgumentUnknown "$usage" "$argument" || return $?
        ;;
    esac
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done

  if ! packageIsInstalled nodejs; then
    return 0
  fi
  local start name quietLog
  name=$(decorate code node)
  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "${usage#_}") || return $?
  __usageEnvironment "$usage" requireFileDirectory "$quietLog" || return $?
  statusMessage --first decorate info "Uninstalling $name ... " || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" packageUninstall nodejs || return $?
  statusMessage reportTiming "$start" "Uninstalled $name in" || return $?
}
_nodeUninstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# No-Arguments: Output the node package manager
# Argument: * - Required. Argument. Passed to the node package manager
nodePackageManager() {
  local usage="_${FUNCNAME[0]}"

  manager=$(__usageEnvironment "$usage" buildEnvironmentGet NODE_PACKAGE_MANAGER) || return $?
  [ -n "$manager" ] || __failEnvironment "$usage" "NODE_PACKAGE_MANAGER is blank" || return $?
  nodePackageManagerValid "$manager" || __failEnvironment "$usage" "NODE_PACKAGE_MANAGER is not valid: $manager not in $(_list nodePackageManagerValid)" || return $?

  if [ $# -eq 0 ]; then
    printf "%s\n" "$manager"
  else
    isExecutable "$manager" || __failEnvironment "$usage" "$(decorate code "$manager") is not an executable" || return $?
    __usageEnvironment "$usage" "$manager" "$@" || return $?
  fi
}
_nodePackageManager() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs the selected package manager for node
nodePackageManagerInstall() {
  local usage="_${FUNCNAME[0]}"
  local manager

  manager=$(__usageEnvironment "$usage" nodePackageManager) || return $?
  if whichExists "$manager"; then
    return 0
  fi
  local method="${manager}Install"
  isFunction "$method" || __failEnvironment "$usage" "No installer for $manager exists ($method)" || return $?
  __usageEnvironment "$usage" "$method" "$@" || return $?
}
_nodePackageManagerInstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs the selected package manager for node
nodePackageManagerUninstall() {
  local usage="_${FUNCNAME[0]}"
  local manager

  manager=$(__usageEnvironment "$usage" nodePackageManager) || return $?
  if ! whichExists "$manager"; then
    return 0
  fi
  local method="${manager}Uninstall"
  isFunction "$method" || __failEnvironment "$usage" "No uninstaller method for $manager exists ($method)" || return $?
  __usageEnvironment "$usage" "$method" "$@" || return $?
}
_nodePackageManagerUninstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

nodePackageManagerValid() {
  local valid=("npm" "yarn")
  if [ $# -eq 0 ]; then
    printf -- "%s\n" "${valid[@]}"
    return 0
  fi
  while [ $# -gt 0 ]; do
    isFunction "${1}Install" || return 1
    shift
  done
}
