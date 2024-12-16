#!/usr/bin/env bash
#
# npm functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh os.sh apt.sh
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
  local argument nArguments
  local version quietLog

  nArguments=$#
  while [ $# -gt 0 ]; do
    argument="$(usageArgumentString "$usage" "argument #$((nArguments - $# + 1))" "${1-}")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --version)
        shift
        version=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
        ;;
      *)
        usageArgumentUnknown "$usage" "$argument" || return $?
        ;;
    esac
    shift || usageArgumentMissing "$usage" "$argument" || return $?
  done

  if whichExists yarn; then
    return 0
  fi
  local home start

  start=$(__usageEnvironment "$usage" beginTiming) || return $?
  home=$(__usageEnvironment "$usage" buildHome) || return $?
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_YARN_VERSION || return $?

  version="${1-${BUILD_YARN_VERSION:-stable}}"
  quietLog=$(buildQuietLog "${usage#_}") || __failEnvironment "buildQuietLog $usage"
  __usageEnvironment "$usage" requireFileDirectory "$quietLog" || return $?
  quietLog=$(__usageEnvironment "$usage" buildQuietLog "$usage") || return $?
  statusMessage --first decorate info "Installing node ... " || return $?
  __usageEnvironment "$usage" nodeInstall || return $?
  __usageEnvironment "$usage" muzzle pushd "$home" || return $?
  __usageEnvironment "$usage" yarn set version "$version" || _undo $? muzzle popd || return $?
  statusMessage decorate info "Installing yarn ... " || return $?
  __usageEnvironment "$usage" yarn install || _undo $? muzzle popd || return $?
  __usageEnvironment "$usage" muzzle popd || return $?
  statusMessage --last reportTiming "$start" "Installed yarn in" || return $?
}
_yarnInstall() {
  # IDENTICAL usageDocument 1
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
      ! $globalFlag || __failArgument "$usage" "--global makes no sense with run" || return $?
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
      __usageArgument "$usage" "Unknown action: $action" || return $?
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
