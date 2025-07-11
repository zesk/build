#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
#
#    ▌      ▜
#  ▞▀▌▞▀▖▛▀▖▐ ▞▀▖▌ ▌
#  ▌ ▌▛▀ ▙▄▘▐ ▌ ▌▚▄▌
#  ▝▀▘▝▀▘▌   ▘▝▀ ▗▄▘
#
# deploy tools - see `deploy/application.sh'
# Related: o ./deploy/application.sh
# Docs: o ./documentation/source/tools/deploy.md
# Test: o ./test/tools/deploy-tests.sh

#
# Usage: {fn} applicationHome
# Argument: applicationHome - Required. Directory. Application home to get the version from.
#
# Extracts version from an application either from `.deploy` files or from the the `.env` if
# that does not exist.
#
# Checks `APPLICATION_ID` and `APPLICATION_TAG` and uses first non-blank value.
#
deployApplicationVersion() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  local p="${1-}" value
  local tryVariables=(APPLICATION_ID APPLICATION_TAG)
  local deployFile

  [ -d "$p" ] || __throwEnvironment "$usage" "$p is not a directory" || return $?
  for f in "${tryVariables[@]}"; do
    deployFile="$p/.deploy/$f"
    if [ -f "$deployFile" ]; then
      printf "%s\n" "$(head -n 1 "$deployFile")"
      return 0
    fi
  done
  [ -f "$p/.env" ] || __throwEnvironment "$usage" "$p/.env does not exist" || return $?
  for f in "${tryVariables[@]}"; do
    # shellcheck source=/dev/null
    value=$(
      source "$p/.env"
      printf "%s" "${!f-}"
    )
    if [ -n "$value" ]; then
      printf "%s\n" "$value"
      return 0
    fi
  done
  __throwEnvironment "$usage" "No application version found" || return $?
}
_deployApplicationVersion() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} deployHome
#
# Outputs the build target name which is based on the environment `BUILD_TARGET`.
#
# If this is called on a non-deployment system, use the application root instead of
# `deployHome` for compatibility.
# Leak: BUILD_TARGET
# Environment: BUILD_TARGET
deployPackageName() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0

  export BUILD_TARGET
  __catchEnvironment "$usage" buildEnvironmentLoad BUILD_TARGET || return $?
  [ -n "${BUILD_TARGET-}" ] || __throwEnvironment "$usage" "BUILD_TARGET is blank" || return $?
  printf "%s\n" "${BUILD_TARGET-}"
}
_deployPackageName() {
  true || deployPackageName --help
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} deployHome versionName [ targetPackage ]
# Argument: deployHome - Required. Directory. Deployment database home.
# Argument: versionName - Required. String. Application ID to look for
#
# Does a deploy version exist? versionName is the version identifier for deployments
#
deployHasVersion() {
  local usage="_${FUNCNAME[0]}"
  local deployHome versionName targetPackage

  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  deployHome=$(usageArgumentDirectory "$usage" deployHome "${1-}") || return $?
  versionName="${2-}"
  [ -n "$versionName" ] || __throwArgument "$usage" "blank versionName" || return $?
  targetPackage="${3-$(deployPackageName)}"
  [ -d "$deployHome/$versionName" ] || __throwEnvironment "$usage" "No deployment version found: $deployHome/$versionName" || return $?
  [ -f "$deployHome/$versionName/$targetPackage" ]
}
_deployHasVersion() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Utility for deployPreviousVersion deployNextVersion
#
# See: deployPreviousVersion deployNextVersion
#
_applicationIdLink() {
  local usageFunction fileSuffix deployHome versionName targetPackage
  usageFunction="${1-}"
  fileSuffix="${2-}"
  shift 2
  [ -n "$fileSuffix" ] || __throwArgument "$usageFunction" "Internal fileSuffix is blank" || return $?
  [ "${1-}" != "--help" ] || __help "$usageFunction" "$@" || return 0
  deployHome="$(usageArgumentDirectory "$usageFunction" deployHome "${1-}")" && shift || return $?
  versionName=$(usageArgumentString "$usageFunction" "versionName" "${1-}") && shift || return $?
  [ -f "$deployHome/$versionName.$fileSuffix" ] && cat "$deployHome/$versionName.$fileSuffix"
}

#
# Usage: {fn} deployHome versionName
#
# Get the previous version of the supplied version
# Exit Code: 1 - No version exists
# Exit Code: 2 - Argument error
#
deployPreviousVersion() {
  _applicationIdLink "_${FUNCNAME[0]}" previous "$@"
}
_deployPreviousVersion() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} deployHome versionName
#
# Get the next version of the supplied version
#
deployNextVersion() {
  _applicationIdLink "_${FUNCNAME[0]}" next "$@"
}
_deployNextVersion() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Safe application deployment by moving
#
# Usage: {fn} applicationPath
#
# Deploy current application to target path
#
deployMove() {
  local usage="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0
  local applicationPath newApplicationSource
  applicationPath=$(usageArgumentDirectory "$usage" applicationPath "${1-}") || return $?
  shift || __throwArgument "$usage" "missing argument" || return $?
  newApplicationSource=$(pwd) || __throwEnvironment "$usage" "Unable to get pwd" || return $?
  directoryClobber "$newApplicationSource" "$applicationPath"
}
_deployMove() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} applicationLinkPath
# Environment: PWD
# Argument: applicationLinkPath - Path. Required. Path where the link is created.
# Argument: applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory.
#
# Link new version of application.
#
# When called, current directory is the **new** application and the `applicationLinkPath` which is
# passed as an argument is the place where the **new** application should be linked to
# in order to activate it.
#
# Summary: Link deployment to new version of the application
# Argument: applicationLinkPath - This is the target for the current application
# Exit code: 0 - Success
# Exit code: 1 - Environment error
# Exit code: 2 - Argument error
#
deployLink() {
  local usage

  local usage="_${FUNCNAME[0]}"

  local applicationLinkPath="" currentApplicationHome=""
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
      if [ -z "$applicationLinkPath" ]; then
        applicationLinkPath="$argument"
        if [ -e "$applicationLinkPath" ]; then
          if [ ! -L "$applicationLinkPath" ]; then
            [ ! -d "$applicationLinkPath" ] || __throwArgument "$usage" "$applicationLinkPath is directory (should be a link)" || return $?
            # Not a link or directory
            __throwArgument "$usage" "Unknown file type $(fileType "$applicationLinkPath")" || return $?
          fi
        else
          applicationLinkPath=$(usageArgumentFileDirectory "$usage" applicationLinkPath "$applicationLinkPath") || return $?
        fi
      elif [ -z "$currentApplicationHome" ]; then
        # No checking - allows pre-linking
        currentApplicationHome="$argument"
        if [ ! -d "$currentApplicationHome" ]; then
          decorate warning "currentApplicationHome $currentApplicationHome points to a non-existent directory"
        fi
      else
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  if [ -z "$applicationLinkPath" ]; then
    __catchArgument "$usage" "Missing applicationLinkPath" || return $?
  fi
  if [ -z "$currentApplicationHome" ]; then
    currentApplicationHome="$(pwd -P 2>/dev/null)" || __throwEnvironment "$usage" "pwd failed" || return $?
  fi
  local newApplicationLinkPath
  newApplicationLinkPath="$applicationLinkPath.READY.$$"
  if ! ln -sf "$currentApplicationHome" "$newApplicationLinkPath" || ! linkRename "$newApplicationLinkPath" "$applicationLinkPath"; then
    rm -rf "$newApplicationLinkPath" 2>/dev/null
    __throwEnvironment "$usage" "Unable to link and rename" || return $?
  fi
}
_deployLink() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} deployHome applicationPath
#
# Automatically convert application deployments using non-links to links.
#
deployMigrateDirectoryToLink() {
  local start
  local usage="_${FUNCNAME[0]}"

  start=$(timingStart) || :
  local deployHome="" applicationPath=""
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
      if [ -z "$deployHome" ]; then
        deployHome="$(usageArgumentDirectory "$usage" "deployHome" "$1")" || return $?
      elif [ -z "$applicationPath" ]; then
        applicationPath="$(usageArgumentDirectory "$usage" "applicationPath" "$1")" || return $?
      else
        __throwArgument "$usage" "unknown argument $(decorate value "$argument")" || return $?
      fi
      shift || __throwArgument "$usage" "shift after $argument failed" || return $?
      ;;
    esac
  done

  local tempAppLink appVersion
  appVersion=$(deployApplicationVersion "$applicationPath") || __throwEnvironment "$usage" "No application deployment version" || return $?
  if [ -L "$applicationPath" ]; then
    printf "%s %s %s\n" "$(decorate code "$applicationPath")" "$(decorate success "is already a link to")" "$(decorate red "$appVersion")"
    return 0
  fi
  deployHasVersion "$deployHome" "$appVersion" || __throwEnvironment "$usage" "Application version $appVersion not found in $deployHome" || return $?

  [ ! -d "$deployHome/$appVersion/app" ] || __throwEnvironment "$usage" "Old app directory $deployHome/$appVersion/app exists, stopping" || return $?
  hookRunOptional --application "$applicationPath" maintenance on || __throwEnvironment "$usage" "Unable to enable maintenance" || return $?
  tempAppLink="$applicationPath.$$.${FUNCNAME[0]}"
  # Create a temporary link to ensure it works
  if ! deployLink "$tempAppLink" "$deployHome/$appVersion/app"; then
    if ! hookRunOptional maintenance off; then
      decorate error "Maintenance off FAILED, system may be unstable" 1>&2
    fi
    __throwEnvironment "$usage" "deployLink failed" || return $?
  fi
  # Now move our folder and the link to where the folder was in one fell swoop
  # or mv -hf
  __environment mv -f "$applicationPath" "$deployHome/$appVersion/app" || __throwEnvironment "$usage" "Unable to move live application from $applicationPath to $deployHome/$appVersion/app" || return $?

  if ! __environment mv -f "$tempAppLink" "$applicationPath"; then
    # Like really? Like really? Something is likely F U B A R
    if ! __environment mv -f "$deployHome/$appVersion/app" "$applicationPath"; then
      decorate error "Unable to move BACK $deployHome/$appVersion/app $applicationPath - system is UNSTABLE" 1>&2
    else
      decorate success "Successfully recovered application to $applicationPath - stable"
    fi
    __throwEnvironment "$usage" "Unable to move live link $tempAppLink -> $applicationPath" || return $?
  fi
  if ! hookRunOptional --application "$applicationPath" maintenance off; then
    decorate error "Maintenance ON FAILED, system may be unstable" 1>&2
  fi
  {
    decorate success "Successfully migrated:"
    decorate pair 20 "Link:" "$applicationPath"
    decorate pair 20 "Installed:" "$deployHome/$appVersion/app"
    # Move directory, then re-link
  }
  timingReport "$start" "Completed in"
}
_deployMigrateDirectoryToLink() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
