#!/usr/bin/env bash
#
# npm functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh os.sh apt.sh
# bin: npm
#

#
# Usage: {fn} version
# Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses `latest`.
# Install NPM in the build environment
# If this fails it will output the installation log.
# When this tool succeeds the `npm` binary is available in the local operating system.
# Environment: - `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
# Exit Code: 1 - If installation of npm fails
# Exit Code: 0 - If npm is already installed or installed without error
# Binary: npm.sh
#
npmInstall() {
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

  if whichExists npm; then
    return 0
  fi
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_NPM_VERSION || return $?

  version="${1-${BUILD_NPM_VERSION:-latest}}"
  quietLog=$(buildQuietLog "$usage") || __failEnvironment "buildQuietLog $usage"
  __usageEnvironment "$usage" requireFileDirectory "$quietLog" || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" packageInstall npm || return $?
  __usageEnvironmentQuiet "$usage" "$quietLog" npm install -g "npm@$version" --force 2>&1
}
_npmInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn}
# Core as part of some systems - so this succeeds and it still exists
#
npmUninstall() {
  packageWhichUninstall npm npm "$@"
}

__nodePackageManagerArguments_npm() {
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
    install | update | uninstall)
      if $globalFlag; then
        printf "%s\n" "$action" "-g"
      else
        printf "%s\n" "$action"
      fi
      ;;
    *)
      __usageArgument "$usage" "Unknown action: $action" || return $?
      ;;
  esac
}

#- access
#- adduser
#- audit
#- bugs
#- cache
#- ci
#- completion
#- config
#- dedupe
#- deprecate
#- diff
#- dist-tag
#- docs
#- doctor
#- edit
#- exec
#- explain
#- explore
#- find-dupes
#- fund
#- get
#- help
#- help-search
#- hook
#- init
#- install
#- install-ci-test
#- install-test
#- link
#- ll
#- login
#- logout
#- ls
#- org
#- outdated
#- owner
#- pack
#- ping
#- pkg
#- prefix
#- profile
#- prune
#- publish
#- query
#- rebuild
#- repo
#- restart
#- root
#- run-script
#- search
#- set
#- shrinkwrap
#- star
#- stars
#- start
#- stop
#- team
#- test,
#- token
#- uninstall
#- unpublish
#- unstar
#- update
#- version
#- view
#- whoami
