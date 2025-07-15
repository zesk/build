#!/usr/bin/env bash
#
# node functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Install nodejs
nodeInstall() {
  local usage="_${FUNCNAME[0]}"

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if packageIsInstalled nodejs; then
    __nodeInstall_corepackEnable "$usage" || return $?
    return 0
  fi

  local quietLog

  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  statusMessage --first decorate info "Installing nodejs ... " || return $?
  __catchEnvironmentQuiet "$usage" "$quietLog" packageInstall nodejs || return $?
  __nodeInstall_corepackEnable "$usage" || return $?
}
_nodeInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__nodeInstall_corepackEnable() {
  local usage="$1"
  if ! whichExists corepack; then
    statusMessage decorate warning "No corepack - installing using npm" || return $?
    __catchEnvironment "$usage" npmInstall || return $?
    __catchEnvironment "$usage" npm install -g corepack || return $?
    whichExists corepack || __throwEnvironment "$usage" "corepack not found after global installation - failing: PATH=$PATH" || return $?
  fi
  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?
  __catchEnvironment "$usage" muzzle pushd "$home" || return $?
  __catchEnvironment "$usage" corepack enable || returnUndo $? muzzle popd || return $?
  __catchEnvironment "$usage" muzzle popd || return $?
}

# Uninstall nodejs
nodeUninstall() {
  local usage="_${FUNCNAME[0]}"

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if ! packageIsInstalled nodejs; then
    return 0
  fi
  local start name quietLog
  name=$(decorate code node)
  start=$(timingStart) || return $?
  quietLog=$(__catchEnvironment "$usage" buildQuietLog "$usage") || return $?
  statusMessage --first decorate info "Uninstalling $name ... " || return $?
  __catchEnvironmentQuiet "$usage" "$quietLog" packageUninstall nodejs || return $?
  statusMessage timingReport "$start" "Uninstalled $name in" || return $?
}
_nodeUninstall() {
  # __IDENTICAL__ usageDocument 1
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

  manager=$(__catchEnvironment "$usage" buildEnvironmentGet NODE_PACKAGE_MANAGER) || return $?
  [ -n "$manager" ] || __throwEnvironment "$usage" "NODE_PACKAGE_MANAGER is blank" || return $?
  nodePackageManagerValid "$manager" || __throwEnvironment "$usage" "NODE_PACKAGE_MANAGER is not valid: $manager not in $(nodePackageManagerValid)" || return $?

  if [ $# -eq 0 ]; then
    printf "%s\n" "$manager"
  else
    isExecutable "$manager" || __throwEnvironment "$usage" "$(decorate code "$manager") is not an executable" || return $?
    local managerArgumentFormatter="__nodePackageManagerArguments_$manager"
    isFunction "$managerArgumentFormatter" || __throwEnvironment "$usage" "$managerArgumentFormatter is not defined, failing" || return $?

    local arguments=() flags=() action="" debugFlag=false

    # _IDENTICAL_ argument-case-header 5
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
      case "$argument" in
      # _IDENTICAL_ --help 4
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
        [ -z "$action" ] || __throwArgument "$usage" "Only a single action allowed: $argument (already: $action)"
        action="$argument"
        ;;
      -*)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
      *)
        [ -n "$action" ] || __throwArgument "$usage" "Requires an action" || return $?
        packages+=("$argument")
        ;;
      esac
      # _IDENTICAL_ argument-esac-shift 1
      shift
    done
    local managerArgumentFormatter="__nodePackageManagerArguments_$manager"
    isFunction "$managerArgumentFormatter" || __throwEnvironment "$usage" "$managerArgumentFormatter is not defined, failing" || return $?
    IFS=$'\n' read -r -d "" -a arguments < <("$managerArgumentFormatter" "$usage" "$action" "${flags[@]+"${flags[@]}"}") || :
    ! $debugFlag || decorate each code "$manager" "${arguments[@]+"${arguments[@]}"}" "${packages[@]+"${packages[@]}"}" || :
    __catchEnvironment "$usage" "$manager" "${arguments[@]+"${arguments[@]}"}" "${packages[@]+"${packages[@]}"}" || return $?
  fi
}
_nodePackageManager() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs the selected package manager for node
nodePackageManagerInstall() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return 0

  local manager

  manager=$(__catchEnvironment "$usage" nodePackageManager) || return $?
  if whichExists "$manager"; then
    return 0
  fi
  local method="${manager}Install"
  isFunction "$method" || __throwEnvironment "$usage" "No installer for $manager exists ($method)" || return $?
  __catchEnvironment "$usage" "$method" "$@" || return $?
}
_nodePackageManagerInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs the selected package manager for node
nodePackageManagerUninstall() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return 0
  local manager

  manager=$(__catchEnvironment "$usage" nodePackageManager) || return $?
  if ! whichExists "$manager"; then
    return 0
  fi
  local method="${manager}Uninstall"
  isFunction "$method" || __throwEnvironment "$usage" "No uninstaller method for $manager exists ($method)" || return $?
  __catchEnvironment "$usage" "$method" "$@" || return $?
}
_nodePackageManagerUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is the passed node package manager name valid?
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: managerName - Required. String. The node package manager name to check.
# Without arguments, shows the valid package manager names.
# Exit Code: 0 - Yes, it's a valid package manager name.
# Exit Code: 1 - No, it's not a valid package manager name.
# Valid names are: npm yarn
nodePackageManagerValid() {
  local usage="_${FUNCNAME[0]}"

  local valid=("npm" "yarn")

  if [ $# -eq 0 ]; then
    printf -- "%s\n" "${valid[@]}"
    return 0
  fi

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    *)
      isFunction "${1}Install" || return 1
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_nodePackageManagerValid() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
