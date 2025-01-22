#!/usr/bin/env bash
#
# node functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
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

  quietLog=$(__usageEnvironment "$usage" buildQuietLog "$usage") || return $?
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
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "$usage") || return $?
  __usageEnvironment "$usage" requireFileDirectory "$quietLog" || return $?
  statusMessage --first decorate info "Uninstalling $name ... " || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" packageUninstall nodejs || return $?
  statusMessage reportTiming "$start" "Uninstalled $name in" || return $?
}
_nodeUninstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Run an action using the current node package manager
# Provides an abstraction to libraries to support any node package manager.
# Optionally will output the current node package manager when no arguments are passed.
# Argument: action - Optional. Action to perform: install run update uninstall
# Argument: * - Required. Argument. Passed to the node package manager. Required when action is provided.
# No-Argument: Outputs the current node package manager code name
nodePackageManager() {
  local usage="_${FUNCNAME[0]}"

  manager=$(__usageEnvironment "$usage" buildEnvironmentGet NODE_PACKAGE_MANAGER) || return $?
  [ -n "$manager" ] || __failEnvironment "$usage" "NODE_PACKAGE_MANAGER is blank" || return $?
  nodePackageManagerValid "$manager" || __failEnvironment "$usage" "NODE_PACKAGE_MANAGER is not valid: $manager not in $(_list nodePackageManagerValid)" || return $?

  if [ $# -eq 0 ]; then
    printf "%s\n" "$manager"
  else
    isExecutable "$manager" || __failEnvironment "$usage" "$(decorate code "$manager") is not an executable" || return $?
    local managerArgumentFormatter="__nodePackageManagerArguments_$manager"
    isFunction "$managerArgumentFormatter" || __failEnvironment "$usage" "$managerArgumentFormatter is not defined, failing" || return $?

    local arguments=() flags=() action="" debugFlag=false
    local saved=("$@") nArguments=$#
    while [ $# -gt 0 ]; do
      local argument argumentIndex=$((nArguments - $# + 1))
      argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
      case "$argument" in
        # IDENTICAL --help 4
        --help)
          "$usage" 0
          return $?
          ;;
        --debug)
          debugFlag=true
          ;;
        --global)
          flags+=("$argument")
          ;;
        install | run | update | uninstall)
          [ -z "$action" ] || __failArgument "$usage" "Only a single action allowed: $argument (already: $action)"
          action="$argument"
          ;;
        -*)
          __failArgument "$usage" "unknown flag #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
          ;;
        *)
          [ -n "$action" ] || __failArgument "$usage" "Requires an action" || return $?
          packages+=("$argument")
          ;;
      esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing #$argumentIndex/$nArguments: $argument $(decorate each code "${saved[@]}")" || return $?
    done
    local managerArgumentFormatter="__nodePackageManagerArguments_$manager"
    isFunction "$managerArgumentFormatter" || __failEnvironment "$usage" "$managerArgumentFormatter is not defined, failing" || return $?
    IFS=$'\n' read -r -d "" -a arguments < <("$managerArgumentFormatter" "$usage" "$action" "${flags[@]+"${flags[@]}"}") || :
    ! $debugFlag || _command "$manager" "${arguments[@]+"${arguments[@]}"}" "${packages[@]+"${packages[@]}"}" || :
    __usageEnvironment "$usage" "$manager" "${arguments[@]+"${arguments[@]}"}" "${packages[@]+"${packages[@]}"}" || return $?
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

# Is the passed node package manager name valid?
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
