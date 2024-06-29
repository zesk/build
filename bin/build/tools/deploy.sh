#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
#
#    ▌      ▜
#  ▞▀▌▞▀▖▛▀▖▐ ▞▀▖▌ ▌
#  ▌ ▌▛▀ ▙▄▘▐ ▌ ▌▚▄▌
#  ▝▀▘▝▀▘▌   ▘▝▀ ▗▄▘
#
# deploy tools - see `deploy/application.sh'
# Related: o ./deploy/application.sh
# Docs: o ./docs/_templates/tools/deploy.md
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
  local p=$1 value
  local tryVariables=(APPLICATION_ID APPLICATION_TAG)
  local deployFile

  [ -d "$p" ] || __failEnvironment "$usage" "$p is not a directory" || return $?
  for f in "${tryVariables[@]}"; do
    deployFile="$p/.deploy/$f"
    if [ -f "$deployFile" ]; then
      printf "%s\n" "$(head -n 1 "$deployFile")"
      return 0
    fi
  done
  [ -f "$p/.env" ] || __failEnvironment "$usage" "$p/.env does not exist" || return $?
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
  __failEnvironment "$usage" "No application version found" || return $?
}
_deployApplicationVersion() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} deployHome
#
# Outputs the build target name which is based on the environment `BUILD_TARGET`.
#
# If this is called on a non-deployment system, use the application root instead of
# `deployHome` for compatibility.
#
deployPackageName() {
  local usage="_${FUNCNAME[0]}"

  export BUILD_TARGET
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_TARGET || return $?
  [ -n "${BUILD_TARGET-}" ] || __failEnvironment "$usage" "BUILD_TARGET is blank" || return $?
  printf "%s\n" "${BUILD_TARGET-}"
}
_deployPackageName() {
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

  deployHome=$(usageArgumentDirectory "$usage" deployHome "${1-}") || return $?
  versionName="${2-}"
  [ -n "$versionName" ] || __failArgument "$usage" "blank versionName" || return $?
  targetPackage="${3-$(deployPackageName)}"
  [ -d "$deployHome/$versionName" ] || __failEnvironment "$usage" "No deployment version found: $deployHome/$versionName" || return $?
  [ -f "$deployHome/$versionName/$targetPackage" ]
}
_deployHasVersion() {
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
  [ -n "$fileSuffix" ] || __failArgument "$usageFunction" "Internal fileSuffix is blank" || return $?
  deployHome="$(usageArgumentDirectory "$usageFunction" deployHome "${3-}")" || return $?
  versionName="${4-}"
  [ -n "$versionName" ] || __failArgument "$usageFunction" "Version name is required to be non-blank" || return $?
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
  local applicationPath newApplicationSource
  local usage

  usage="_${FUNCNAME[0]}"

  applicationPath=$(usageArgumentDirectory "$usage" applicationPath "${1-}") || return $?
  shift || __failArgument "$usage" "missing argument" || return $?
  newApplicationSource=$(pwd) || __failEnvironment "$usage" "Unable to get pwd" || return $?
  directoryClobber "$newApplicationSource" "$applicationPath"
}
_deployMove() {
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
  local applicationLinkPath currentApplicationHome newApplicationLinkPath argument
  local usage

  usage="_${FUNCNAME[0]}"

  applicationLinkPath=
  currentApplicationHome=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --help)
        $usage 0
        return $?
        ;;
      *)
        if [ -z "$applicationLinkPath" ]; then
          applicationLinkPath="$argument"
          if [ -e "$applicationLinkPath" ]; then
            if [ ! -L "$applicationLinkPath" ]; then
              [ ! -d "$applicationLinkPath" ] || __failArgument "$usage" "$applicationLinkPath is directory (should be a link)" || return $?
              # Not a link or directory
              __failArgument "$usage" "Unknown file type $(betterType "$applicationLinkPath")" || return $?
            fi
          else
            usageArgumentFileDirectory "$usage" applicationLinkPath "$applicationLinkPath" >/dev/null || return $?
          fi
        elif [ -z "$currentApplicationHome" ]; then
          # No checking - allows pre-linking
          currentApplicationHome="$argument"
          if [ ! -d "$currentApplicationHome" ]; then
            consoleWarning "currentApplicationHome $currentApplicationHome points to a non-existent directory"
          fi
        else
          __failArgument "$usage" "unknown argument $(consoleValue "$argument")" || return $?
        fi
        ;;
    esac
    shift || :
  done
  if [ -z "$currentApplicationHome" ]; then
    currentApplicationHome="$(pwd -P 2>/dev/null)" || __failEnvironment "$usage" "pwd failed" || return $?
  fi
  newApplicationLinkPath="$applicationLinkPath.READY.$$"
  if ! ln -sf "$currentApplicationHome" "$newApplicationLinkPath" || ! renameLink "$newApplicationLinkPath" "$applicationLinkPath"; then
    rm -rf "$newApplicationLinkPath" 2>/dev/null
    __failEnvironment "$usage" "Unable to link and rename" || return $?
  fi
}
_deployLink() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} deployHome applicationPath
#
# Automatically convert application deployments using non-links to links.
#
deployMigrateDirectoryToLink() {
  local start deployHome applicationPath tempAppLink appVersion argument
  local usage

  usage="_${FUNCNAME[0]}"

  start=$(beginTiming) || :
  deployHome=
  applicationPath=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return 0
        ;;
      *)
        if [ -z "$deployHome" ]; then
          deployHome="$(usageArgumentDirectory "$usage" "deployHome" "$1")" || return $?
        elif [ -z "$applicationPath" ]; then
          applicationPath="$(usageArgumentDirectory "$usage" "applicationPath" "$1")" || return $?
        else
          __failArgument "$usage" "unknown argument $(consoleValue "$argument")" || return $?
        fi
        shift || __failArgument "$usage" "shift after $argument failed" || return $?
        ;;
    esac
  done
  appVersion=$(deployApplicationVersion "$applicationPath") || __failEnvironment "$usage" "No application deployment version" || return $?
  if [ -L "$applicationPath" ]; then
    printf "%s %s %s\n" "$(consoleCode "$applicationPath")" "$(consoleSuccess "is already a link to")" "$(consoleRed "$appVersion")"
    return 0
  fi
  deployHasVersion "$deployHome" "$appVersion" || __failEnvironment "$usage" "Application version $appVersion not found in $deployHome" || return $?

  [ ! -d "$deployHome/$appVersion/app" ] || __failEnvironment "$usage" "Old app directory $deployHome/$appVersion/app exists, stopping" || return $?
  runOptionalHook --application "$applicationPath" maintenance on || __failEnvironment "$usage" "Unable to enable maintenance" || return $?
  tempAppLink="$applicationPath.$$.${FUNCNAME[0]}"
  # Create a temporary link to ensure it works
  if ! deployLink "$tempAppLink" "$deployHome/$appVersion/app"; then
    if ! runOptionalHook maintenance off; then
      consoleError "Maintenance off FAILED, system may be unstable" 1>&2
    fi
    __failEnvironment "$usage" "deployLink failed" || return $?
  fi
  # Now move our folder and the link to where the folder was in one fell swoop
  # or mv -hf
  __environment mv -f "$applicationPath" "$deployHome/$appVersion/app" || __failEnvironment "$usage" "Unable to move live application from $applicationPath to $deployHome/$appVersion/app" || return $?

  if ! __environment mv -f "$tempAppLink" "$applicationPath"; then
    # Like really? Like really? Something is likely F U B A R
    if ! __environment mv -f "$deployHome/$appVersion/app" "$applicationPath"; then
      consoleError "Unable to move BACK $deployHome/$appVersion/app $applicationPath - system is UNSTABLE" 1>&2
    else
      consoleSuccess "Successfully recovered application to $applicationPath - stable"
    fi
    __failEnvironment "$usage" "Unable to move live link $tempAppLink -> $applicationPath" || return $?
  fi
  if ! runOptionalHook --application "$applicationPath" maintenance off; then
    consoleError "Maintenance ON FAILED, system may be unstable" 1>&2
  fi
  {
    consoleSuccess "Successfully migrated:"
    consoleNameValue 20 "Link:" "$applicationPath"
    consoleNameValue 20 "Installed:" "$deployHome/$appVersion/app"
    # Move directory, then re-link
  }
  reportTiming "$start" "Completed in"
}
_deployMigrateDirectoryToLink() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
