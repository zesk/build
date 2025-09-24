#!/usr/bin/env bash
#
# node functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Install nodejs
nodeInstall() {
  local handler="_${FUNCNAME[0]}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  if packageIsInstalled nodejs; then
    __nodeInstall_corepackEnable "$handler" || return $?
    return 0
  fi

  local quietLog

  quietLog=$(__catch "$handler" buildQuietLog "$handler") || return $?
  statusMessage --first decorate info "Installing nodejs ... " || return $?
  __catchEnvironmentQuiet "$handler" "$quietLog" packageInstall nodejs || return $?
  __nodeInstall_corepackEnable "$handler" || return $?
}
_nodeInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__nodeInstall_corepackEnable() {
  local handler="$1"
  if ! whichExists corepack; then
    statusMessage decorate warning "No corepack - installing using npm" || return $?
    __catchEnvironment "$handler" npmInstall || return $?
    __catchEnvironment "$handler" npm install -g corepack || return $?
    whichExists corepack || __throwEnvironment "$handler" "corepack not found after global installation - failing: PATH=$PATH" || return $?
  fi
  local home
  home=$(__catch "$handler" buildHome) || return $?
  __catchEnvironment "$handler" muzzle pushd "$home" || return $?
  __catchEnvironment "$handler" corepack enable || returnUndo $? muzzle popd || return $?
  __catchEnvironment "$handler" muzzle popd || return $?
}

# Uninstall nodejs
nodeUninstall() {
  local handler="_${FUNCNAME[0]}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  if ! packageIsInstalled nodejs; then
    return 0
  fi
  local start name quietLog
  name=$(decorate code node)
  start=$(timingStart) || return $?
  quietLog=$(__catch "$handler" buildQuietLog "$handler") || return $?
  statusMessage --first decorate info "Uninstalling $name ... " || return $?
  __catchEnvironmentQuiet "$handler" "$quietLog" packageUninstall nodejs || return $?
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
# Argument: ... - Required. Arguments. Passed to the node package manager. Required when action is provided.
# No-Argument: Outputs the current node package manager code name
nodePackageManager() {
  local handler="_${FUNCNAME[0]}"

  local arguments=() flags=() action="" debugFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug)
      debugFlag=true
      ;;
    --global)
      flags+=("$argument")
      ;;
    install | run | update | uninstall)
      [ -z "$action" ] || __throwArgument "$handler" "Only a single action allowed: $argument (already: $action)"
      action="$argument"
      ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      [ -n "$action" ] || __throwArgument "$handler" "Requires an action" || return $?
      packages+=("$argument")
      ;;
    esac
    shift
  done

  local manager

  manager=$(__catch "$handler" buildEnvironmentGet NODE_PACKAGE_MANAGER) || return $?
  [ -n "$manager" ] || __throwEnvironment "$handler" "NODE_PACKAGE_MANAGER is blank" || return $?
  nodePackageManagerValid "$manager" || __throwEnvironment "$handler" "NODE_PACKAGE_MANAGER is not valid: $manager not in $(nodePackageManagerValid)" || return $?
  isExecutable "$manager" || __throwEnvironment "$handler" "$(decorate code "$manager") is not an executable" || return $?
  if [ -z "$action" ]; then
    printf "%s\n" "$manager"
    return 0
  fi

  local managerArgumentFormatter="__nodePackageManagerArguments_$manager"

  isFunction "$managerArgumentFormatter" || __throwEnvironment "$handler" "$managerArgumentFormatter is not defined, failing" || return $?
  IFS=$'\n' read -r -d "" -a arguments < <("$managerArgumentFormatter" "$handler" "$action" "${flags[@]+"${flags[@]}"}") || :

  ! $debugFlag || decorate each code "$manager" "${arguments[@]+"${arguments[@]}"}" "${packages[@]+"${packages[@]}"}" || :
  __catchEnvironment "$handler" "$manager" "${arguments[@]+"${arguments[@]}"}" "${packages[@]+"${packages[@]}"}" || return $?
}
_nodePackageManager() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs the selected package manager for node
nodePackageManagerInstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  local manager

  manager=$(__catchEnvironment "$handler" nodePackageManager) || return $?
  if whichExists "$manager"; then
    return 0
  fi
  local method="${manager}Install"
  isFunction "$method" || __throwEnvironment "$handler" "No installer for $manager exists ($method)" || return $?
  __catchEnvironment "$handler" "$method" "$@" || return $?
}
_nodePackageManagerInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Installs the selected package manager for node
nodePackageManagerUninstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local manager

  manager=$(__catchEnvironment "$handler" nodePackageManager) || return $?
  if ! whichExists "$manager"; then
    return 0
  fi
  local method="${manager}Uninstall"
  isFunction "$method" || __throwEnvironment "$handler" "No uninstaller method for $manager exists ($method)" || return $?
  __catchEnvironment "$handler" "$method" "$@" || return $?
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
# Return Code: 0 - Yes, it's a valid package manager name.
# Return Code: 1 - No, it's not a valid package manager name.
# Valid names are: npm yarn
nodePackageManagerValid() {
  local handler="_${FUNCNAME[0]}"

  local valid=("npm" "yarn")

  if [ $# -eq 0 ]; then
    printf -- "%s\n" "${valid[@]}"
    return 0
  fi

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      isFunction "${1}Install" || return 1
      ;;
    esac
    shift
  done
}
_nodePackageManagerValid() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
