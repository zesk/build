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
# Depends: colors.sh text.sh pipeline.sh
#
# Docs: o ./docs/_templates/tools/deploy.md
# Test: o ./test/tools/deploy-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

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
  local p=$1 value
  local tryVariables=(APPLICATION_ID APPLICATION_TAG)
  local appChecksumFile=.deploy/APPLICATION_ID

  if [ ! -d "$p" ]; then
    consoleError "$p is not a directory" 1>&2
    return "$errorEnvironment"
  fi
  for f in "${tryVariables[@]}"; do
    appChecksumFile="$p/.deploy/$f"
    if [ -f "$appChecksumFile" ]; then
      printf "%s\n" "$(cat "$appChecksumFile")"
      return 0
    fi
  done
  if [ ! -f "$p/.env" ]; then
    return "$errorEnvironment"
  fi
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
  return "$errorEnvironment"
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
  export BUILD_TARGET
  if ! buildEnvironmentLoad BUILD_TARGET; then
    _deployPackageName "$errorEnvironment" "Unable to load BUILD_TARGET" || return $?
  fi
  if [ -z "${BUILD_TARGET-}" ]; then
    _deployPackageName "$errorEnvironment" "BUILD_TARGET is blank" || return $?
  fi
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
  local deployHome versionName targetPackage

  if ! deployHome=$(usageArgumentDirectory "_${FUNCNAME[0]}" deployHome "${1-}"); then
    return "$errorArgument"
  fi
  shift || :
  versionName="${1-}"
  if [ -z "$versionName" ]; then
    _deployHasVersion "$errorArgument" "Version name is blank" || return $?
  fi
  shift || :

  targetPackage="${1-$(deployPackageName)}"
  shift || :

  if [ ! -d "$deployHome/$versionName" ]; then
    _deployHasVersion "$errorEnvironment" "No deployment version found: $deployHome/$versionName" || return $?
  fi
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
  usageFunction="$1"
  shift || return "$errorArgument"
  fileSuffix="$1"
  if [ -z "$fileSuffix" ]; then
    "$usageFunction" "$errorArgument" "Internal fileSuffix is blank" || return $?
  fi
  shift || return "$errorArgument"
  if ! deployHome="$(usageArgumentDirectory "$usageFunction" deployHome "${1-}")"; then
    return $errorArgument
  fi
  shift || :
  versionName="${1-}"
  if [ -z "$versionName" ]; then
    "$usageFunction" "$errorArgument" "Version name is required to be non-blank" || return $?
  fi
  if [ -f "$deployHome/$versionName.$fileSuffix" ]; then
    cat "$deployHome/$versionName.$fileSuffix"
  else
    return "$errorEnvironment"
  fi
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
# Usage: {fn} deployHome applicationId applicationPath [ targetPackage ]
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
  local firstFlag revertFlag
  local name
  local deployHome applicationPath deployedApplicationPath targetPackageFullPath
  local newApplicationId applicationId currentApplicationId exitCode
  local unwindArgs requiredArgs

  exitCode=0
  # Arguments

  # --first
  firstFlag=
  # --revert
  revertFlag=

  # Arguments in order
  deployHome=
  applicationId=
  applicationPath=
  targetPackage=
  requiredArgs=()
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _deployApplication "$errorArgument" "Blank argument" || return $?
    fi
    case "$1" in
      --help)
        "_${FUNCNAME[0]}" 0
        return $?
        ;;
      --message)
        shift || "_${FUNCNAME[0]}" "$errorArgument" "Missing --message argument" || return $?
        message="$1"
        ;;
      --first)
        firstFlag=1
        ;;
      --revert)
        revertFlag=1
        ;;
      --home)
        shift || :
        if ! deployHome=$(usageArgumentDirectory "_${FUNCNAME[0]}" deployHome "${1-}"); then
          return "$errorArgument"
        fi
        ;;
      --id)
        shift || :
        if [ -z "$1" ]; then
          "_${FUNCNAME[0]}" "$errorArgument" "Blank --id"
        fi
        applicationId="$1"
        ;;
      --application)
        shift || :
        if ! applicationPath=$(usageArgumentDirectory "_${FUNCNAME[0]}" applicationPath "$1"); then
          return "$errorArgument"
        fi
        ;;
      --package)
        shift || :
        targetPackage="${1-}"
        ;;
      *)
        "_${FUNCNAME[0]}" "$errorArgument" "Unknown argument $1" || return $?
        ;;
    esac
    shift || :
  done
  if [ -z "$targetPackage" ] && ! targetPackage="$(deployPackageName)"; then
    return $errorArgument
  fi
  if ! test "$revertFlag"; then
    requiredArgs+=(applicationId)
  fi

  # Check arguments are non-blank and actually supplied
  requiredArgs+=(deployHome applicationPath)
  for name in "${requiredArgs[@]}"; do
    if [ -z "${!name}" ]; then
      "_${FUNCNAME[0]}" "$errorArgument" "$name is required" || return $?
    fi
  done

  if ! currentApplicationId="$(deployApplicationVersion "$applicationPath")" || [ -z "$currentApplicationId" ]; then
    if ! test $firstFlag; then
      _deployApplication "$errorEnvironment" "Can not fetch version from $applicationPath, need --first" || return $?
    fi
    currentApplicationId=
  fi

  if test "$revertFlag"; then
    #
    # If reverting, check the application ID (if supplied) is correct otherwise fail
    #
    if ! newApplicationId=$(deployPreviousVersion "$deployHome" "$currentApplicationId"); then
      _deployApplication "$errorEnvironment" "--revert can not find previous version of $currentApplicationId ($deployHome)" || return $?
    fi

    if [ -n "$applicationId" ] && [ "$applicationId" != "$currentApplicationId" ]; then
      _deployApplication "$errorArgument" "--id $applicationId does not match ID \"$currentApplicationId\" of $applicationPath" || return $?
    fi
    applicationId="$newApplicationId"
    printf "%s %s %s %s\n" "$(consoleInfo "Reverting from")" "$(consoleOrange "$currentApplicationId")" "$(consoleInfo "->")" "$(consoleGreen "$applicationId")"
  fi

  #
  # Arguments are all parsed by here
  #
  targetPackageFullPath="$deployHome/$applicationId/$targetPackage"
  if [ ! -f "$targetPackageFullPath" ]; then
    _deployApplication "$errorEnvironment" "deployApplication: Missing target file $targetPackageFullPath" || return $?
  fi

  #
  # Generates deployHome/{newVersion}/app and deletes on failure
  #
  # START _unwindDeploy
  #
  # `_unwindDeploy` after this guarantees this and always exits non-zero
  #
  deployedApplicationPath="$deployHome/$applicationId/app"
  unwindArgs=("$applicationPath" "$deployedApplicationPath")

  if [ -d "$deployedApplicationPath" ]; then
    if ! rm -rf "$deployedApplicationPath"; then
      _unwindDeploy "${unwindArgs[@]}" "rm $deployedApplicationPath failed" || return $?
    fi
  fi
  if ! mkdir "$deployedApplicationPath"; then
    _unwindDeploy "${unwindArgs[@]}" "mkdir $deployedApplicationPath failed" || return $?
  fi

  if ! tar -C "$deployedApplicationPath" -xzf "$targetPackageFullPath"; then
    _unwindDeploy "${unwindArgs[@]}" "tar -C \"$deployedApplicationPath\" -xzf \"$targetPackageFullPath\" failed" || return $?
  fi

  if ! newApplicationId=$(deployApplicationVersion "$deployedApplicationPath"); then
    _unwindDeploy "${unwindArgs[@]}" "deployApplicationVersion $deployedApplicationPath failed" || return $?
  fi

  if [ "$newApplicationId" != "$applicationId" ]; then
    _unwindDeploy "${unwindArgs[@]}" "Deployed version $newApplicationId != Requested $applicationId, tar file is likely incorrect" || return $?
  fi

  #
  # Old Application
  #
  if hasHook --application "$applicationPath" maintenance; then
    printf "%s %s\n" "$(consoleWarning "Turning maintenance")" "$(consoleGreen "$(consoleCode " ON ")")"
    if [ -z "$message" ]; then
      message="Upgrading to $newApplicationId"
    fi
    if ! runHook --application "$applicationPath" maintenance --message "$message" on; then
      _unwindDeploy "${unwindArgs[@]}" "Turning maintenance on in $applicationPath failed"
      return $?
    fi
  else
    printf "%s\n" "$(consoleInfo "No maintenance hook")"
  fi
  if hasHook --application "$applicationPath" deploy-shutdown; then
    printf "%s %s\n" "$(consoleWarning "Running hook")" "$(consoleGreen "$(consoleCode " deploy-shutdown ")")"
    if ! runHook --application "$applicationPath" deploy-shutdown; then
      _unwindDeploy "${unwindArgs[@]}" "Running hook deploy-shutdown failed" || return $?
    fi
  else
    printf "%s\n" "$(consoleInfo "No deploy-shutdown hook")"
  fi

  #
  # Link
  #
  if [ -n "$currentApplicationId" ]; then
    if [ ! -f "$deployHome/$applicationId.previous" ] && [ ! -f "$deployHome/$currentApplicationId.next" ]; then
      printf "%s %s -> %s\n" "$(consoleInfo "Linking versions:")" "$(consoleOrange "$currentApplicationId")" "$(consoleGreen "$applicationId")"
      # Linked list forward only
      if ! printf "%s" "$currentApplicationId" >"$deployHome/$applicationId.previous" ||
        ! printf "%s" "$applicationId" >"$deployHome/$currentApplicationId.next"; then
        rm -rf "$deployHome/$applicationId.previous" "$deployHome/$applicationId.next" || :
        _unwindDeploy "${unwindArgs[@]}" "Linking $deployHome/$applicationId failed" || return $?
      fi
    fi
  fi

  #
  # Link
  #
  # deployedApplicationPath is the new version of the application source code root
  consoleInfo -n "Setting to version $applicationId ... "
  if hasHook --application "$deployedApplicationPath" deploy-start; then
    printf "%s %s\n" "$(consoleWarning "Running hook")" "$(consoleGreen "$(consoleCode " deploy-start ")")"
    if ! runHook --application "$deployedApplicationPath" deploy-start; then
      _unwindDeploy "${unwindArgs[@]}" "Running hook deploy-start failed" || return $?
    fi
  else
    printf "%s\n" "$(consoleInfo "No deploy-start hook")"
  fi

  if hasHook --application "$deployedApplicationPath" deploy-activate; then
    printf "%s %s\n" "$(consoleWarning "Running hook")" "$(consoleGreen "$(consoleCode " deploy-activate ")")" || :
    if ! runHook --application "$deployedApplicationPath" deploy-activate "$applicationPath"; then
      _unwindDeploy "${unwindArgs[@]}" "runHook deploy-activate failed" || return $?
    fi
  else
    printf "%s %s -> %s\n" "$(consoleSuccess "Activating application")" "$(consoleCode " $applicationPath ")" "$(consoleGreen "$applicationId")" || :
    if ! deployLink "$applicationPath" "$deployedApplicationPath"; then
      _unwindDeploy "${unwindArgs[@]}" "deployLink $applicationPath $deployedApplicationPath failed" || return $?
    fi
  fi
  # STOP _unwindDeploy

  if ! runOptionalHook --application "$applicationPath" deploy-finish; then
    _deployApplication "$errorEnvironment" "Deploy finish failed" || exitCode=$?
  fi
  if ! runOptionalHook --application "$applicationPath" maintenance off; then
    _deployApplication "$errorEnvironment" "maintenance off failed" || exitCode=$?
  fi
  if [ $exitCode -eq 0 ]; then
    consoleSuccess "Completed"
  else
    printf "%s %s\n" "$(consoleError "Exiting with code")" "$(consoleCode "$exitCode")"
  fi
  return "$exitCode"
}
_deployApplication() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_unwindDeploy() {
  local applicationPath="$1"
  local deployedApplicationPath="${2-}"

  shift || :
  shift || :
  if ! runOptionalHook --application "$applicationPath" maintenance off; then
    consoleError "Unable to enable maintenance - system is unstable" 1>&2
  else
    consoleSuccess "Maintenance was enabled again"
  fi
  if [ -d "$deployedApplicationPath" ]; then
    printf "%s %s\n" "$(consoleError "Deleting")" "$(consoleCode "$deployedApplicationPath")"
    rm -rf "$deployedApplicationPath" || consoleError "Delete $deployedApplicationPath failed" 1>&2
  else
    printf "%s %s %s\n" "$(consoleError "Unwind")" "$(consoleCode "$deployedApplicationPath")" "$(consoleError "does not exist")"
  fi
  _deployApplication "$errorEnvironment" "$@"
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

  if ! applicationPath=$(usageArgumentDirectory "_${FUNCNAME[0]}" applicationPath "$1"); then
    return "$errorArgument"
  fi
  shift || :
  if ! newApplicationSource=$(pwd); then
    _deployMove "$errorEnvironment" "Unable to get pwd" || return $?
  fi
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
  local applicationLinkPath currentApplicationHome newApplicationLinkPath

  applicationLinkPath=
  currentApplicationHome=
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _deployLink "$errorArgument" "Blank argument" || return $?
    fi
    if [ -z "$applicationLinkPath" ]; then
      applicationLinkPath="$1"
      if [ -e "$applicationLinkPath" ]; then
        if [ ! -L "$applicationLinkPath" ]; then
          if [ -d "$applicationLinkPath" ]; then
            _deployLink "$errorArgument" "$applicationLinkPath is directory (should be a link)" || return $?
          fi
          # Not a link or directory
          _deployLink "$errorArgument" "Unknown file type $(betterType "$applicationLinkPath")" || return $?
        fi
      fi
    elif [ -z "$currentApplicationHome" ]; then
      # No checking - allows pre-linking
      currentApplicationHome="$1"
      if [ ! -d "$currentApplicationHome" ]; then
        consoleWarning "currentApplicationHome $currentApplicationHome points to a non-existent directory"
      fi
    else
      _deployLink "$errorArgument" "Unknown argument $1" || return $?
    fi
    shift || :
  done
  if [ -z "$currentApplicationHome" ]; then
    if ! currentApplicationHome="$(pwd -P 2>/dev/null)"; then
      _deployLink "$errorEnvironment" "pwd failed" || return $?
    fi
  fi
  newApplicationLinkPath="$applicationLinkPath.READY.$$"
  if ! ln -sf "$currentApplicationHome" "$newApplicationLinkPath" || ! renameLink "$newApplicationLinkPath" "$applicationLinkPath"; then
    rm -rf "$newApplicationLinkPath" 2>/dev/null
    _deployLink $errorEnvironment "Unable to link and rename" || return $?
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
  local start deployHome applicationPath tempAppLink appVersion

  start=$(beginTiming) || :
  deployHome=
  applicationPath=
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _deployMigrateDirectoryToLink "$errorArgument" "Blank argument" || return $?
    fi
    if [ -z "$deployHome" ]; then
      if ! deployHome="$(usageArgumentDirectory "_${FUNCNAME[0]}" "deployHome" "$1")"; then
        return "$errorArgument"
      fi
    elif [ -z "$applicationPath" ]; then
      if ! applicationPath="$(usageArgumentDirectory "_${FUNCNAME[0]}" "applicationPath" "$1")"; then
        return "$errorArgument"
      fi
    else
      _deployMigrateDirectoryToLink "$errorArgument" "Unknown argument $1" || return $?
    fi
    # TODO
    shift || :
  done
  if ! appVersion=$(deployApplicationVersion "$applicationPath"); then
    _deployMigrateDirectoryToLink "$errorEnvironment" "No application deployment version" || return $?
  fi
  if [ -L "$applicationPath" ]; then
    printf "%s %s %s\n" "$(consoleCode "$applicationPath")" "$(consoleSuccess "is already a link to")" "$(consoleRed "$appVersion")"
    return 0
  fi
  if ! deployHasVersion "$deployHome" "$appVersion"; then
    _deployMigrateDirectoryToLink "$errorEnvironment" "Application version $appVersion not found in $deployHome" || return $?
  fi
  if [ -d "$deployHome/$appVersion/app" ]; then
    _deployMigrateDirectoryToLink "$errorEnvironment" "Old app directory $deployHome/$appVersion/app exists, stopping" || return $?
  fi
  if ! runOptionalHook --application "$applicationPath" maintenance on; then
    _deployMigrateDirectoryToLink "$errorEnvironment" "Unable to enable maintenance" || return $?
  fi
  tempAppLink="$applicationPath.$$.${FUNCNAME[0]}"
  # Create a temporary link to ensure it works
  if ! deployLink "$tempAppLink" "$deployHome/$appVersion/app"; then
    if ! runOptionalHook maintenance off; then
      consoleError "Maintenance off FAILED, system may be unstable" 1>&2
    fi
    return $errorEnvironment
  fi
  # Now move our folder and the link to where the folder was in one fell swoop
  # or mv -hf
  if ! mv -f "$applicationPath" "$deployHome/$appVersion/app"; then
    _deployMigrateDirectoryToLink "$errorEnvironment" "Unable to move live application from $applicationPath to $deployHome/$appVersion/app" || return $?
  fi

  if ! mv -f "$tempAppLink" "$applicationPath"; then
    # Like really? Like really? Something is likely F U B A R
    if ! mv -f "$deployHome/$appVersion/app" "$applicationPath"; then
      consoleError "Unable to move BACK $deployHome/$appVersion/app $applicationPath - system is UNSTABLE" 1>&2
    else
      consoleSuccess "Successfully recovered application to $applicationPath - stable"
    fi
    _deployMigrateDirectoryToLink "$errorEnvironment" "Unable to move live link $tempAppLink -> $applicationPath" || return $?
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
