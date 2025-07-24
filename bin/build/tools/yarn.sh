#!/usr/bin/env bash
#
# npm functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Test: bin-tests.sh
#

#
# Usage: {fn} version
# Environment: BUILD_YARN_VERSION - Read-only. Default version. If not specified, uses `latest`.
# Install yarn in the build environment
# If this fails it will output the installation log.
# Notes: `yarn` is part of node, I think, so no clean uninstall.
# When this tool succeeds the `yarn` binary is available in the local operating system.
# Environment: - `BUILD_YARN_VERSION` - String. Default to `latest`.
# Exit Code: 1 - If installation of yarn fails
# Exit Code: 0 - If yarn is already installed or installed without error
# Binary: npm.sh
# Test: testYarnInstallation
yarnInstall() {
  local usage="_${FUNCNAME[0]}"

  local version quietLog

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
    --version)
      shift
      version=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  if whichExists yarn; then
    return 0
  fi
  local home start

  start=$(timingStart) || return $?
  home=$(__catch "$usage" buildHome) || return $?
  __catch "$usage" buildEnvironmentLoad BUILD_YARN_VERSION || return $?

  version="${1-${BUILD_YARN_VERSION:-stable}}"
  quietLog=$(buildQuietLog "$usage") || __throwEnvironment "buildQuietLog $usage"
  __catch "$usage" fileDirectoryRequire "$quietLog" || return $?
  quietLog=$(__catch "$usage" buildQuietLog "$usage") || return $?
  statusMessage --first decorate info "Installing node ... " || return $?
  __catch "$usage" nodeInstall || return $?
  __catchEnvironment "$usage" muzzle pushd "$home" || return $?
  __catchEnvironment "$usage" yarn set version "$version" || returnUndo $? muzzle popd || return $?
  statusMessage decorate info "Installing yarn ... " || return $?
  __catchEnvironment "$usage" yarn install || returnUndo $? muzzle popd || return $?
  __catchEnvironment "$usage" muzzle popd || return $?
  statusMessage --last timingReport "$start" "Installed yarn in" || return $?
}
_yarnInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__nodePackageManagerArguments_yarn() {
  local usage="$1" action

  action=$(usageArgumentString "$usage" "action" "${2-}") || return $?
  shift 2

  local globalFlag=false
  while [ $# -gt 0 ]; do
    local argument
    argument="$(usageArgumentString "$usage" "argument" "$1")" || return $?
    case "$argument" in
    --global)
      globalFlag=true
      ;;
    esac
    shift
  done

  case "$action" in
  run)
    ! $globalFlag || __throwArgument "$usage" "--global makes no sense with run" || return $?
    printf "%s\n" "run"
    ;;
  update)
    printf "%s\n" "install"
    ;;
  uninstall)
    if $globalFlag; then
      printf "%s\n" "global" "remove"
    else
      printf "%s\n" "remove"
    fi
    ;;
  install)
    if $globalFlag; then
      printf "%s\n" "global" "add"
    else
      printf "%s\n" "add"
    fi
    ;;
  *)
    __catchArgument "$usage" "Unknown action: $action" || return $?
    ;;
  esac
}

#    - access
#    - add
#    - audit
#    - autoclean
#    - bin
#    - cache
#    - check
#    - config
#    - create
#    - exec
#    - generate-lock-entry / generateLockEntry
#    - global
#    - help
#    - import
#    - info
#    - init
#    - install
#    - licenses
#    - link
#    - list
#    - login
#    - logout
#    - node
#    - outdated
#    - owner
#    - pack
#    - policies
#    - publish
#    - remove
#    - run
#    - tag
#    - team
#    - unlink
#    - unplug
#    - upgrade
#    - upgrade-interactive / upgradeInteractive
#    - version
#    - versions
#    - why
#    - workspace
#    - workspaces
