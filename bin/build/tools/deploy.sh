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

__deployLoader() {
  __functionLoader __deployApplication deploy "$@"
}

# Deploy an application from a deployment repository
#
#      ____             _
#     |  _ \  ___ _ __ | | ___  _   _
#     | | | |/ _ \ '_ \| |/ _ \| | | |
#     | |_| |  __/ |_) | | (_) | |_| |
#     |____/ \___| .__/|_|\___/ \__, |
#                |_|            |___/
#
# This acts on the local file system only but used in tandem with `deployment.sh` functions.
#
# handler: {fn} deployHome applicationId applicationPath [ targetPackage ]
#
# Argument: --help - Optional. Flag. This help.
# Argument: --first - Optional. Flag. The first deployment has no prior version and can not be reverted.
# Argument: --revert - Optional. Flag. Means this is part of the undo process of a deployment.
# Argument: --home deployHome - Required. Directory. Path where the deployments database is on remote system.
# Argument: --id applicationId - Required. String. Should match `APPLICATION_ID` or `APPLICATION_TAG` in `.env` or `.deploy/`
# Argument: --application applicationPath - Required. String. Path on the remote system where the application is live
# Argument: --target targetPackage - Optional. Filename. Package name, defaults to `BUILD_TARGET`
# Argument: --message message - Optional. String. Message to display in the maintenance message on systems while upgrade is occurring.
# Environment: BUILD_TARGET APPLICATION_ID APPLICATION_TAG
# Example: {fn} --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app
# Use-Hook: maintenance
# Use-Hook: deploy-shutdown
# Use-Hook: deploy-activate deploy-start deploy-finish
# See: deployToRemote
#
deployApplication() {
  __deployLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_deployApplication() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local p="${1-}" value
  local tryVariables=(APPLICATION_ID APPLICATION_TAG)
  local deployFile

  [ -d "$p" ] || throwEnvironment "$handler" "$p is not a directory" || return $?
  for f in "${tryVariables[@]}"; do
    deployFile="$p/.deploy/$f"
    if [ -f "$deployFile" ]; then
      printf "%s\n" "$(head -n 1 "$deployFile")"
      return 0
    fi
  done
  [ -f "$p/.env" ] || throwEnvironment "$handler" "$p/.env does not exist" || return $?
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
  throwEnvironment "$handler" "No application version found" || return $?
}
_deployApplicationVersion() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"

  export BUILD_TARGET
  returnCatch "$handler" buildEnvironmentLoad BUILD_TARGET || return $?
  [ -n "${BUILD_TARGET-}" ] || throwEnvironment "$handler" "BUILD_TARGET is blank" || return $?
  printf "%s\n" "${BUILD_TARGET-}"
}
_deployPackageName() {
  true || deployPackageName --help
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"
  local deployHome versionName targetPackage

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  deployHome=$(usageArgumentDirectory "$handler" deployHome "${1-}") || return $?
  versionName="${2-}"
  [ -n "$versionName" ] || throwArgument "$handler" "blank versionName" || return $?
  targetPackage="${3-$(deployPackageName)}"
  [ -d "$deployHome/$versionName" ] || throwEnvironment "$handler" "No deployment version found: $deployHome/$versionName" || return $?
  [ -f "$deployHome/$versionName/$targetPackage" ]
}
_deployHasVersion() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Utility for deployPreviousVersion deployNextVersion
#
# See: deployPreviousVersion deployNextVersion
#
_applicationIdLink() {
  local handler="${1-}" fileSuffix="${2-}" && shift 2 || return $?
  [ -n "$fileSuffix" ] || throwArgument "$handler" "Internal fileSuffix is blank" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local deployHome versionName
  deployHome="$(usageArgumentDirectory "$handler" deployHome "${1-}")" && shift || return $?
  versionName=$(usageArgumentString "$handler" "versionName" "${1-}") && shift || return $?
  [ -f "$deployHome/$versionName.$fileSuffix" ] && cat "$deployHome/$versionName.$fileSuffix"
}

#
# Usage: {fn} deployHome versionName
#
# Get the previous version of the supplied version
# Return Code: 1 - No version exists
# Return Code: 2 - Argument error
#
deployPreviousVersion() {
  _applicationIdLink "_${FUNCNAME[0]}" previous "$@"
}
_deployPreviousVersion() {
  # __IDENTICAL__ usageDocument 1
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
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local applicationPath newApplicationSource
  applicationPath=$(usageArgumentDirectory "$handler" applicationPath "${1-}") || return $?
  shift || throwArgument "$handler" "missing argument" || return $?
  newApplicationSource=$(pwd) || throwEnvironment "$handler" "Unable to get pwd" || return $?
  directoryClobber "$newApplicationSource" "$applicationPath"
}
_deployMove() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

deployLink() {
  __deployLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_deployLink() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} deployHome applicationPath
#
# Automatically convert application deployments using non-links to links.
#
deployMigrateDirectoryToLink() {
  __deployLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}

_deployMigrateDirectoryToLink() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
