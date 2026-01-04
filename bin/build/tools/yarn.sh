#!/usr/bin/env bash
#
# npm functions
#
# Copyright &copy; 2026 Market Acumen, Inc.
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
# Return Code: 1 - If installation of yarn fails
# Return Code: 0 - If yarn is already installed or installed without error
# Binary: npm.sh
# Test: testYarnInstallation
yarnInstall() {
  local handler="_${FUNCNAME[0]}"

  local version quietLog

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --version)
      shift
      version=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  if whichExists yarn; then
    return 0
  fi
  local home start

  start=$(timingStart) || return $?
  home=$(catchReturn "$handler" buildHome) || return $?
  catchReturn "$handler" buildEnvironmentLoad BUILD_YARN_VERSION || return $?

  version="${1-${BUILD_YARN_VERSION:-stable}}"
  quietLog=$(buildQuietLog "$handler") || throwEnvironment "buildQuietLog $handler"
  catchReturn "$handler" fileDirectoryRequire "$quietLog" || return $?
  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  statusMessage --first decorate info "Installing node ... " || return $?
  catchReturn "$handler" nodeInstall || return $?
  catchEnvironment "$handler" muzzle pushd "$home" || return $?
  catchEnvironment "$handler" yarn set version "$version" || returnUndo $? muzzle popd || return $?
  statusMessage decorate info "Installing yarn ... " || return $?
  catchEnvironment "$handler" yarn install || returnUndo $? muzzle popd || return $?
  catchEnvironment "$handler" muzzle popd || return $?
  statusMessage --last timingReport "$start" "Installed yarn in" || return $?
}
_yarnInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__nodePackageManagerArguments_yarn() {
  local handler="$1" action

  action=$(usageArgumentString "$handler" "action" "${2-}") || return $?
  shift 2

  local globalFlag=false
  while [ $# -gt 0 ]; do
    local argument
    argument="$(usageArgumentString "$handler" "argument" "$1")" || return $?
    case "$argument" in
    --global)
      globalFlag=true
      ;;
    esac
    shift
  done

  case "$action" in
  run)
    ! $globalFlag || throwArgument "$handler" "--global makes no sense with run" || return $?
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
    catchArgument "$handler" "Unknown action: $action" || return $?
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
