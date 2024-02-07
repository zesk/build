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

  # May allow local override later so this is here
  if ! deployHome="$(usageArgumentDirectory "_${BASH_SOURCE[0]}" deployHome "$1")"; then
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

  if ! deployHome=$(usageArgumentDirectory "_${BASH_SOURCE[0]}" deployHome "${1-}"); then
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
_deployVersionLink() {
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
  _deployVersionLink "_${FUNCNAME[0]}" previous "$@"
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
  _deployVersionLink "_${FUNCNAME[0]}" next "$@"
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
# Usage: {fn} deployHome deployVersion applicationPath [ targetPackage ]
#
# Argument: --first - Optional. Flag. The first one does not require a backup version to exist.
# Argument: --undo - Optional. Flag. Means this is part of the undo process of a deployment.
# Argument: deployHome - Required. Directory. The deployment repository database home.
# Argument: deployVersion - The version to deploy (string)
# Argument: applicationPath - Required. Directory. The application deployed path.
# Argument: targetPackage - Optional. Filename. Package name, defaults to `app.tar.gz`
#
# Example: deployApplication /var/www/DEPLOY 10c2fab1 /var/www/apps/cool-app
#
deployApplication() {
  local deployHome deployVersion applicationPath deployedApplicationPath firstDeployment undoDeployment name
  local previousApplicationPath previousApplicationChecksum targetPackageFullPath exitCode=0

  # Arguments

  # --first
  firstDeployment=
  # --undo
  undoDeployment=

  # Arguments in order
  deployHome=
  deployVersion=
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
      --undo)
        undoDeployment=1
        ;;
      *)
        if [ -z "$deployHome" ]; then
          if ! deployHome=$(usageArgumentDirectory "_${FUNCNAME[0]}" deployHome "$1"); then
            return "$errorArgument"
          fi
        elif [ -z "$deployVersion" ]; then
          deployVersion="$1"
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
  for name in deployHome deployVersion applicationPath; do
    if [ -z "${!name}" ]; then
      _deployApplication "$errorArgument" "$name is required" || return $?
    fi
  done

  # If we are doing and undo then there's no previous - this is the previous
  if ! test $undoDeployment; then
    deployedApplicationPath="$deployHome/$deployVersion/app"
    if ! previousApplicationChecksum=$(deployApplicationVersion "$applicationPath") || [ -z "$previousApplicationChecksum" ]; then
      previousApplicationChecksum=
      if ! test "$firstDeployment"; then
        _deployApplication "$errorEnvironment" "deployApplication: No previous version, failing without --first" || return $?
      fi
    fi
  fi

  targetPackageFullPath="$deployHome/$deployVersion/$targetPackage"
  if [ ! -f "$targetPackageFullPath" ]; then
    _deployApplication "$errorEnvironment" "deployApplication: Missing target file $targetPackageFullPath" || return $?
  fi

  # _unwindDeploy after this
  if [ ! -d "$deployedApplicationPath" ]; then
    if ! mkdir "$deployedApplicationPath"; then
      _unwindDeploy "$deployedApplicationPath" "mkdir $deployedApplicationPath failed" || return $?
    fi
    if ! cd "$deployedApplicationPath"; then
      _unwindDeploy "$deployedApplicationPath" "cd $deployedApplicationPath failed" || return $?
    fi
    if ! tar xzf "$targetPackageFullPath"; then
      _unwindDeploy "$deployedApplicationPath" "tar xvf $targetPackageFullPath failed" || return $?
    fi
  fi

  if ! deployVersion=$(deployApplicationVersion "$deployedApplicationPath"); then
    _unwindDeploy "$deployedApplicationPath" "deployApplicationVersion $deployedApplicationPath failed" || return $?
  fi

  if [ "$deployVersion" != "$deployVersion" ]; then
    _unwindDeploy "$deployedApplicationPath" "Arg $deployVersion != Computed $deployVersion" || return $?
  fi

  if [ -d "$applicationPath/bin/build" ] && [ -d "$applicationPath/bin/hooks" ]; then
    if cd "$applicationPath"; then
      if ! runOptionalHook maintenance on; then
        _unwindDeploy "$deployedApplicationPath" "Turning maintenance on in $applicationPath failed"
        return $?
      fi
      if ! cd "$deployedApplicationPath"; then
        _unwindDeploy "$deployedApplicationPath" "cd $deployedApplicationPath failed"
        return $?
      fi
    else
      _unwindDeploy "$deployedApplicationPath" "cd $applicationPath failed"
      return $?
    fi
  fi

  if [ -n "$previousApplicationChecksum" ]; then
    if [ ! -f "$deployHome/$deployVersion.previous" ] && [ ! -f "$deployHome/$previousApplicationChecksum.next" ]; then
      # Linked list forward only
      if ! printf "%s" "$previousApplicationChecksum" >"$deployHome/$deployVersion.previous" ||
        ! printf "%s" "$deployVersion" >"$deployHome/$previousApplicationChecksum.next"; then
        rm -rf "$deployHome/$deployVersion.previous" "$deployHome/$deployVersion.next" || :
        _unwindDeploy "$deployedApplicationPath" "Linking $deployHome failed" || return $?
      fi
    fi
  fi

  consoleInfo -n "Setting to version $deployVersion ... "
  if ! cd "$deployedApplicationPath"; then
    _unwindDeploy "$deployedApplicationPath" "cd $deployedApplicationPath failed"
    return $?
  fi
  if ! runOptionalHook deploy-start "$applicationPath"; then
    _unwindDeploy "$deployedApplicationPath" "runOptionalHook deploy-start failed"
    return $?
  fi
  if hasHook deploy-move; then
    runHook deploy-move "$applicationPath"
  else
    if [ ! -d "$deployHome/$previousApplicationChecksum" ]; then
      if ! mkdir -p "$deployHome/$previousApplicationChecksum"; then
        _unwindDeploy "$deployedApplicationPath" "Unable to create deploy home/previous checksum \"$deployHome/$previousApplicationChecksum\""
        return $?
      fi
    fi
    previousApplicationPath="$deployHome/$previousApplicationChecksum/app/"
    if [ -d "$previousApplicationPath" ]; then
      if ! rm -rf "$previousApplicationPath"; then
        _unwindDeploy "$deployedApplicationPath" "Unable to delete \"$previousApplicationPath\""
        return $?
      fi
    fi
    if ! cd "$deployHome"; then
      _unwindDeploy "$deployedApplicationPath" "Unable to cd to \"$deployHome\""
      return $?
    fi
    # COPY is safest
    if ! cp -R "${applicationPath%%/}" "$previousApplicationPath"; then
      _unwindDeploy "$deployedApplicationPath" "Unable to copy \"$applicationPath\" \"$previousApplicationPath\"" || return $?
    fi
    if ! mv "$applicationPath" "$applicationPath.$$"; then
      _unwindDeploy "$deployedApplicationPath" "Unable to move $applicationPath to $applicationPath.$$" || return $?
    fi
    if mv "$deployedApplicationPath" "$applicationPath"; then
      if ! rm -rf "$applicationPath.$$"; then
        consoleError "ERROR: Deleting $applicationPath.$$ resulted in exit code $?" 1>&2
      fi
    else
      consoleError "Unable to do FINAL mv \"$deployedApplicationPath\" \"$applicationPath\" attempting UNDO" 1>&2
      if ! mv "$applicationPath.$$" "$applicationPath"; then
        _unwindDeploy "$deployedApplicationPath" "Unable to UNDO FINAL mv \"$applicationPath.$$\" \"$applicationPath\", system is BROKEN"
      fi
      return "$errorEnvironment"
    fi
  fi
  if ! cd "$applicationPath"; then
    _deployApplication "$errorEnvironment" "Unable to do cd \"$applicationPath\" can not run optional hooks - UNSTABLE" || exitCode=$?
  fi
  if ! runOptionalHook deploy-finish; then
    _deployApplication "$errorEnvironment" "Deploy finish failed" || exitCode=$?
  fi
  if ! runOptionalHook maintenance off; then
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
  local deployedApplicationPath="${1-}"

  shift || :
  if [ -d "$deployedApplicationPath" ]; then
    printf "%s %s\n" "$(consoleError "Deleting")" "$(console "$deployedApplicationPath")"
    rm -rf "$deployedApplicationPath" || consoleError "Delete failed" 1>&2
  else
    consoleError "Delete failed" 1>&2
  fi
  _deployApplication "$errorEnvironment" "$@"
}

#
# This is run on the remote system after deployment; environment files are correct.
# It is run inside the deployment home directory in the new application folder.
#
# Current working directory on deploy is `deployHome/applicationId/app`.
# Current working directory on cleanup is `applicationHome/`
# Current working directory on undo is `applicationHome/`
#
# Argument: deployPath - Required. Directory. Path where the deployments database is on remote system.
# Argument: applicationId - Required. String. Should match `APPLICATION_ID` in `.env`
# Argument: applicationPath - Required. String. Path on the remote system where the application is live.
# Argument: targetPackage - Optional. Filename. Package name, defaults to `app.tar.gz`
# Argument: --undo - Revert changes just made
# Argument: --cleanup - Cleanup after success
# Argument: --debug - Enable debugging. Defaults to `BUILD_DEBUG`
#
remoteDeployFinish() {
  local targetPackage undoFlag cleanupFlag applicationId applicationPath debuggingFlag start width

  if ! usageRequireBinary _remoteDeployFinish git; then
    return $?
  fi

  if ! dotEnvConfigure; then
    consoleError "remoteDeployFinish: Unable to dotEnvConfigure" 1>&2
    return $?
  fi

  targetPackage=
  undoFlag=
  cleanupFlag=
  applicationId=
  applicationPath=
  debuggingFlag=
  while [ $# -gt 0 ]; do
    case $1 in
      --debug)
        debuggingFlag=1
        ;;
      --cleanup)
        cleanupFlag=1
        ;;
      --undo)
        undoFlag=1
        ;;
      *)
        if [ -z "$deployHome" ]; then
          if ! deployHome=$(usageArgumentDirectory "_${FUNCNAME[0]}" deployHome "$1"); then
            return "$errorArgument"
          fi
        elif [ -z "$deployVersion" ]; then
          deployVersion="$1"
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
    shift || "_${FUNCNAME[0]}" "$errorArgument" "shift failed" || return $?
  done
  if [ -z "$targetPackage" ] && ! targetPackage="$(deployPackageName "$deployHome")"; then
    return $errorArgument
  fi

  if test "${BUILD_DEBUG-}"; then
    debuggingFlag=1
  fi
  if test "$debuggingFlag"; then
    consoleWarning "Debugging is enabled"
    set -x
  fi

  if test $undoFlag && test $cleanupFlag; then
    _remoteDeployFinish "$errorArgument" "--cleanup and --undo are mutually exclusive"
  fi

  start=$(beginTiming)
  width=50
  consoleNameValue $width "Host:" "$(uname -n)"
  consoleNameValue $width "Deployment Path:" "$deployHome"
  consoleNameValue $width "Application path:" "$applicationPath"
  consoleNameValue $width "Application checksum:" "$applicationId"

  if test $cleanupFlag; then
    if ! cd "$applicationPath"; then
      consoleError "Unable to change directory to $applicationPath, exiting" 1>&2
      return "$errorEnvironment"
    fi
    consoleInfo -n "Cleaning up ..."
    if hasHook deploy-cleanup; then
      if ! runHook deploy-cleanup; then
        consoleError "Cleanup failed"
        return "$errorEnvironment"
      fi
    else
      printf "No %s hook in %s\n" "$(consoleInfo "deploy-cleanup")" "$(consoleCode "$applicationPath")"
    fi
  elif test $undoFlag; then
    undoDeployApplication "$deployHome" "$applicationId" "$targetPackage" "$applicationPath"
  else
    if [ -z "$applicationId" ]; then
      _remoteDeployFinish "$errorArgument" "No argument applicationId passed"
    fi
    deployApplication "$deployHome" "$applicationId" "$targetPackage" "$applicationPath"
  fi
  reportTiming "$start" "Remote deployment finished in"
}
_remoteDeployFinish() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#      _   _           _
#     | | | |_ __   __| | ___
#     | | | |  _ \ / _  |/ _ \
#     | |_| | | | | (_| | (_) |
#      \___/|_| |_|\__,_|\___/
#
# Undo deploying an application from a deployment repository
#
# Usage: {fn} [ --first ] deployHome deployVersion applicationPath [ targetPackage ]
# Argument: --first - Optional. Flag. Undo the first deployment.
# Argument: deployHome - Required. Directory. The deployment repository database home.
# Argument: deployVersion - Required. The version to deploy (string)
# Argument: applicationPath - Required. Directory. The application deployed path.
# Argument: targetPackage - Optional. Filename. Package name, defaults to `BUILD_TARGET`
# See: BUILD_TARGET.sh
undoDeployApplication() {
  local firstDeployment name deployHome versionName previousChecksum targetPackage

  # --first
  firstDeployment=

  # Arguments in order
  deployHome=
  deployVersion=
  applicationPath=
  targetPackage=
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _undoDeployApplication "$errorArgument" "Blank argument" || return $?
    fi
    case "$1" in
      --first)
        firstDeployment=1
        ;;
      *)
        if [ -z "$deployHome" ]; then
          if ! deployHome=$(usageArgumentDirectory "_${FUNCNAME[0]}" deployHome "$1"); then
            return "$errorArgument"
          fi
        elif [ -z "$deployVersion" ]; then
          deployVersion="$1"
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

  for name in deployHome deployVersion applicationPath; do
    if [ -z "${!name}" ]; then
      _undoDeployApplication "$errorArgument" "$name is required" || return $?
    fi
  done
  if ! previousChecksum=$(deployPreviousVersion "$deployHome" "$deployVersion") || [ -z "$previousChecksum" ]; then
    if ! test "$firstDeployment"; then
      _undoDeployApplication "$errorEnvironment" "Unable to get previous checksum for $versionName" || return $?
    fi
  else
    printf "%s %s -> %s\n" "$(consoleInfo "Reverting installation")" "$(consoleOrange "$deployVersion")" "$(consoleGreen "$previousChecksum")"
    if ! deployApplication --undo "$deployHome" "$previousChecksum" "$applicationPath" "$targetPackage"; then
      _undoDeployApplication "$errorEnvironment" "Undo deployment to $previousChecksum failed $applicationPath - system is unstable" || return $?
    fi
  fi
  if ! runOptionalHook deploy-undo "$deployHome" "$deployVersion"; then
    printf "%s %s\n" "$(consoleCode "deploy-undo")" "$(consoleError "hook failed, continuing anyway")"
  fi
  return 0
}
_undoDeployApplication() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
