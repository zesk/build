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
# Argument: deployHome - Required. Directory. Deployment database home.
#
# Outputs the build target name which is based on the global `BUILD_TARGET` or
# optionally may be added in the future to the `deployHome` structure instead.
#
deployPackageName() {
  local deployHome

  if [ $# -eq 0 ]; then
    _deployPackageName "$errorArgument" "deployHome required" || return $?
  fi
  # May allow local override later so this is here
  if ! deployHome="$(usageArgumentDirectory "_${FUNCNAME[0]}" deployHome "$1")"; then
    return "$errorArgument"
  fi
  shift || return "$errorArgument"

  export BUILD_TARGET
  # shellcheck source=/dev/null
  if ! source ./bin/build/env/BUILD_TARGET.sh; then
    _deployPackageName "$errorEnvironment" "Unable to load BUILD_TARGET" || return $?
  fi

  printf "%s\n" "$BUILD_TARGET"
}
_deployPackageName() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} deployHome versionName [ targetPackage ]
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

  targetPackage="${1-$(deployPackageName "$deployHome")}"
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

#      ____             _
#     |  _ \  ___ _ __ | | ___  _   _
#     | | | |/ _ \ '_ \| |/ _ \| | | |
#     | |_| |  __/ |_) | | (_) | |_| |
#     |____/ \___| .__/|_|\___/ \__, |
#                |_|            |___/
#
#
# Deploy an application from a deployment repository
#
# Usage: {fn} deployHome applicationId applicationPath [ targetPackage ]
#
# Argument: --first - Optional. Flag. The first one does not require a backup version to exist.
# Argument: --revert - Optional. Flag. Means this is part of the undo process of a deployment.
# Argument: deployHome - Required. Directory. The deployment repository database home.
# Argument: applicationId - The version to deploy (string)
# Argument: applicationPath - Required. Directory. The application deployed path.
# Argument: targetPackage - Optional. Filename. Package name, defaults to `app.tar.gz`
#
# Example: deployApplication /var/www/DEPLOY 10c2fab1 /var/www/apps/cool-app
# Use-Hook: maintenance
# Use-Hook: deploy-shutdown
# Use-Hook: deploy-activate deploy-start deploy-finish
deployApplication() {
  local deployHome currentlyDeployedVersion applicationId applicationPath deployedApplicationPath firstDeployment undoDeployment name
  local previousApplicationChecksum targetPackageFullPath exitCode=0

  # Arguments

  # --first
  firstDeployment=
  # --revert
  undoDeployment=

  # Arguments in order
  deployHome=
  applicationId=
  applicationPath=
  targetPackage=
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _deployApplication "$errorArgument" "Blank argument" || return $?
    fi
    case "$1" in
      --first)
        firstDeployment=1
        ;;
      --revert)
        undoDeployment=1
        ;;
      *)
        if [ -z "$deployHome" ]; then
          if ! deployHome=$(usageArgumentDirectory "_${FUNCNAME[0]}" deployHome "$1"); then
            return "$errorArgument"
          fi
        elif [ -z "$applicationId" ]; then
          applicationId="$1"
        elif [ -z "$applicationPath" ]; then
          if ! applicationPath=$(usageArgumentDirectory "_${FUNCNAME[0]}" applicationPath "$1"); then
            return "$errorArgument"
          fi
        elif [ -z "$targetPackage" ]; then
          targetPackage="$1"
        else
          "_${FUNCNAME[0]}" "$errorArgument" "Unknown argument $1" || return $?
        fi
        ;;
    esac
    shift || :
  done
  if [ -z "$targetPackage" ] && ! targetPackage="$(deployPackageName "$deployHome")"; then
    return $errorArgument
  fi

  # Check arguments are non-blank and actually supplied
  for name in deployHome applicationId applicationPath; do
    if [ -z "${!name}" ]; then
      _deployApplication "$errorArgument" "$name is required" || return $?
    fi
  done

  #
  # Arguments are all parsed by here
  #

  targetPackageFullPath="$deployHome/$applicationId/$targetPackage"
  if [ ! -f "$targetPackageFullPath" ]; then
    _deployApplication "$errorEnvironment" "deployApplication: Missing target file $targetPackageFullPath" || return $?
  fi

  # If we are doing and undo then there's no previous - this is the previous
  previousApplicationChecksum=
  if ! test $undoDeployment; then
    if ! previousApplicationChecksum=$(deployApplicationVersion "$applicationPath") || [ -z "$previousApplicationChecksum" ]; then
      if ! test "$firstDeployment"; then
        _deployApplication "$errorEnvironment" "deployApplication: No previous version, failing without --first" || return $?
      fi
      previousApplicationChecksum=
    fi
  fi

  #
  # Generates deployHome/{newVersion}/app and deletes on failure
  #
  # START _unwindDeploy
  #
  # `_unwindDeploy` after this guarantees this and always exits non-zero
  #
  deployedApplicationPath="$deployHome/$applicationId/app"
  if [ -d "$deployedApplicationPath" ]; then
    if ! rm -rf "$deployedApplicationPath"; then
      _unwindDeploy "$deployedApplicationPath" "rm $deployedApplicationPath failed" || return $?
    fi
  fi
  if ! mkdir "$deployedApplicationPath"; then
    _unwindDeploy "$deployedApplicationPath" "mkdir $deployedApplicationPath failed" || return $?
  fi
  if ! cd "$deployedApplicationPath"; then
    _unwindDeploy "$deployedApplicationPath" "cd $deployedApplicationPath failed" || return $?
  fi

  # CWD "$deployedApplicationPath"

  if ! tar xzf "$targetPackageFullPath"; then
    _unwindDeploy "$deployedApplicationPath" "tar xvf $targetPackageFullPath failed" || return $?
  fi

  if ! currentlyDeployedVersion=$(deployApplicationVersion "$deployedApplicationPath"); then
    _unwindDeploy "$deployedApplicationPath" "deployApplicationVersion $deployedApplicationPath failed" || return $?
  fi

  if [ "$currentlyDeployedVersion" != "$applicationId" ]; then
    _unwindDeploy "$deployedApplicationPath" "Deployed version $currentlyDeployedVersion != Requested $applicationId" || return $?
  fi

  #
  # Old Application
  #
  if ! cd "$applicationPath"; then
    _unwindDeploy "$deployedApplicationPath" "cd $applicationPath failed" || return $?
  fi

  if hasHook maintenance; then
    printf "%s %s\n" "$(consoleWarning "Turning maintenance")" "$(consoleGreen "$(consoleCode " ON ")")"
    if ! runHook maintenance on; then
      _unwindDeploy "$deployedApplicationPath" "Turning maintenance on in $applicationPath failed"
      return $?
    fi
  else
    printf "%s\n" "$(consoleInfo "No maintenance hook")"
  fi
  if hasHook deploy-shutdown; then
    printf "%s %s\n" "$(consoleWarning "Running hook")" "$(consoleGreen "$(consoleCode " deploy-shutdown ")")"
    if ! runHook deploy-shutdown; then
      _unwindDeploy "$deployedApplicationPath" "Running hook deploy-shutdown failed" || return $?
    fi
  else
    printf "%s\n" "$(consoleInfo "No deploy-shutdown hook")"
  fi

  #
  # Link
  #
  if [ -n "$previousApplicationChecksum" ]; then
    if [ ! -f "$deployHome/$applicationId.previous" ] && [ ! -f "$deployHome/$previousApplicationChecksum.next" ]; then
      printf "%s %s -> %s\n" "$(consoleInfo "Linking versions:")" "$(consoleOrange "$previousApplicationChecksum")" "$(consoleGreen "$applicationId")"
      # Linked list forward only
      if ! printf "%s" "$previousApplicationChecksum" >"$deployHome/$applicationId.previous" ||
        ! printf "%s" "$applicationId" >"$deployHome/$previousApplicationChecksum.next"; then
        rm -rf "$deployHome/$applicationId.previous" "$deployHome/$applicationId.next" || :
        _unwindDeploy "$deployedApplicationPath" "Linking $deployHome/$applicationId failed" || return $?
      fi
    fi
  fi

  #
  # Link
  #
  # deployedApplicationPath is the new version of the application source code root
  consoleInfo -n "Setting to version $applicationId ... "
  if ! cd "$deployedApplicationPath"; then
    _unwindDeploy "$deployedApplicationPath" "cd $deployedApplicationPath failed" || return $?
  fi

  # CWD "$deployedApplicationPath"
  if hasHook deploy-start; then
    printf "%s %s\n" "$(consoleWarning "Running hook")" "$(consoleGreen "$(consoleCode " deploy-start ")")"
    if ! runHook deploy-start; then
      _unwindDeploy "$deployedApplicationPath" "Running hook deploy-start failed" || return $?
    fi
  else
    printf "%s\n" "$(consoleInfo "No deploy-start hook")"
  fi

  if hasHook deploy-activate; then
    printf "%s %s\n" "$(consoleWarning "Running hook")" "$(consoleGreen "$(consoleCode " deploy-activate ")")" || :
    if ! runHook deploy-activate "$applicationPath"; then
      _unwindDeploy "$deployedApplicationPath" "runHook deploy-activate failed" || return $?
    fi
  else
    printf "%s %s\n" "$(consoleSuccess "Activating application ")" "$(consoleGreen "$(consoleCode " $applicationPath ")")" || :
    if ! deployLink "$applicationPath"; then
      _unwindDeploy "$deployedApplicationPath" "deployLink $applicationPath failed" || return $?
    fi
  fi
  # STOP _unwindDeploy

  if ! cd "$applicationPath"; then
    _deployApplication "$errorEnvironment" "Unable to do cd \"$applicationPath\" can not run optional hooks - UNSTABLE" || exitCode=$?
  else
    if ! runOptionalHook deploy-finish; then
      _deployApplication "$errorEnvironment" "Deploy finish failed" || exitCode=$?
    fi
    if ! runOptionalHook maintenance off; then
      _deployApplication "$errorEnvironment" "maintenance off failed" || exitCode=$?
    fi
  fi
  if [ -d "$deployedApplicationPath" ]; then
    consoleWarning "$deployedApplicationPath still exists after deploy, removing" || return $?
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
  local deployedApplicationPath="${1-}"

  if ! runHook maintenance off; then
    consoleError "Unable to enable maintenance - system is unstable" 1>&2
  else
    consoleSuccess "Maintenance was enabled again"
  fi
  shift || :
  if [ -d "$deployedApplicationPath" ]; then
    printf "%s %s\n" "$(consoleError "Deleting")" "$(consoleCode "$deployedApplicationPath")"
    rm -rf "$deployedApplicationPath" || consoleError "Delete failed" 1>&2
  else
    consoleError "Delete failed" 1>&2
  fi
  _deployApplication "$errorEnvironment" "$@"
}

#
# Safe application deployment
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
  if ! ln -sf "$currentApplicationHome" "$newApplicationLinkPath" && mv -Tf "$newApplicationLinkPath" "$applicationLinkPath"; then
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
      if ! deployHome="$(usageArgumentDiretory "_${FUNCNAME[0]}" "deployHome" "$1")"; then
        return "$errorArgument"
      fi
    elif [ -z "$applicationPath" ]; then
      if ! applicationPath="$(usageArgumentDiretory "_${FUNCNAME[0]}" "applicationPath" "$1")"; then
        return "$errorArgument"
      fi
    else
      _deployMigrateDirectoryToLink "$errorArgument" "Unknown argument $1" || return $?
    fi
    # TODO
    shift || :
  done
  if ! appVersion=$(deployApplicationVersion "$applicationPath"); then
    return "$errorEnvironment"
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
  if ! cd "$applicationPath"; then
    _deployMigrateDirectoryToLink "$errorEnvironment" "Can not cd to $applicationPath" || return $?
  fi
  if ! runOptionalHook maintenance on; then
    _deployMigrateDirectoryToLink "$errorEnvironment" "Unable to enable maintenance" || return $?
  fi
  # Create a temporary link to ensure it works
  if ! deployLink "$applicationPath.$$.LINK" "$deployHome/$appVersion/app"; then
    if ! runOptionalHook maintenance off; then
      consoleError "Maintenance off FAILED, system may be unstable" 1>&2
    fi
    return $errorEnvironment
  fi
  # Now move our folder and the link to where the folder was in one fell swoop
  if ! mv -Tf "$applicationPath" "$deployHome/$appVersion/app"; then
    _deployMigrateDirectoryToLink "$errorEnvironment" "Unable to move live application from $applicationPath to $deployHome/$appVersion/app" || return $?
  fi
  tempAppLink="$applicationPath.$$.${FUNCNAME[0]}"
  if ! mv -Tf "$tempAppLink" "$applicationPath"; then
    # Like really? Like really? Something is likely F U B A R
    if ! mv -tF "$deployHome/$appVersion/app" "$applicationPath"; then
      consoleError "Unable to move BACK $deployHome/$appVersion/app $applicationPath - system is UNSTABLE" 1>&2
    else
      consoleSuccess "Successfully recovered application to $applicationPath - stable"
    fi
    _deployMigrateDirectoryToLink "$errorEnvironment" "Unable to move live link $tempAppLink" || return $?
  fi
  if ! cd "$applicationPath"; then
    _deployMigrateDirectoryToLink "$errorEnvironment" "Can not cd to NEW $applicationPath - maintenance still ON" || return $?
  fi
  if ! runOptionalHook maintenance off; then
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
