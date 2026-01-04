#!/usr/bin/env bash
#
# npm functions
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# bin: npm
#

#
# Usage: {fn} version
# Environment: BUILD_NPM_VERSION - Read-only. Default version. If not specified, uses `latest`.
# Install NPM in the build environment
# If this fails it will output the installation log.
# When this tool succeeds the `npm` binary is available in the local operating system.
# Environment: - `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
# Return Code: 1 - If installation of npm fails
# Return Code: 0 - If npm is already installed or installed without error
# Binary: npm.sh
#
npmInstall() {
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

  if whichExists npm; then
    return 0
  fi
  catchReturn "$handler" buildEnvironmentLoad BUILD_NPM_VERSION || return $?

  local clean=() quietLog

  version="${1-${BUILD_NPM_VERSION:-latest}}"

  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  clean+=("$quietLog")
  catchEnvironmentQuiet "$handler" "$quietLog" packageInstall npm || returnClean $? "${clean[@]}" || return $?
  catchEnvironmentQuiet "$handler" "$quietLog" npm install -g "npm@$version" --force 2>&1 || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
}
_npmInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn}
# Core as part of some systems - so this succeeds and it still exists
#
npmUninstall() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  packageWhichUninstall npm npm "$@"
}
_npmUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__nodePackageManagerArguments_npm() {
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
  install | update | uninstall)
    if $globalFlag; then
      printf "%s\n" "$action" "-g"
    else
      printf "%s\n" "$action"
    fi
    ;;
  *)
    catchArgument "$handler" "Unknown action: $action" || return $?
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
