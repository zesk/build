#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
#    ▌      ▜                 ▐
#  ▞▀▌▞▀▖▛▀▖▐ ▞▀▖▌ ▌▛▚▀▖▞▀▖▛▀▖▜▀
#  ▌ ▌▛▀ ▙▄▘▐ ▌ ▌▚▄▌▌▐ ▌▛▀ ▌ ▌▐ ▖
#  ▝▀▘▝▀▘▌   ▘▝▀ ▗▄▘▘▝ ▘▝▀▘▘ ▘ ▀
#
# Depends: colors.sh text.sh pipeline.sh
#
# Docs: o ./docs/_templates/tools/deployment.md
# Test: o ./test/tools/deployment-tests.sh

deployedHostArtifact="./.deployed-hosts"

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

# Deploy to a host
#
# Loads .build.env
#
# Environment: - DEPLOY_REMOTE_PATH - path on remote host for deployment data
# Environment: - APPLICATION_REMOTE_PATH - path on remote host for application
# Environment: - DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)
# Environment: - APPLICATION_ID - Version to be deployed
#
# Not possible to deploy to different paths on different hosts
# Test: testDeployBuildEnvironment - INCOMPLETE
deployBuildEnvironment() {
  local deployArgs

  if [ ! -f .build.env ]; then
    consoleWarning "No .build.env found - environment must be already configured" 1>&2
  else
    # shellcheck source=/dev/null
    if ! set -a || ! source .build.env || ! set +a; then
      _deployBuildEnvironment "$errorEnvironment" "Unable to load .build.env" || return $?
    fi
  fi

  if ! usageRequireEnvironment _deployBuildEnvironment APPLICATION_ID DEPLOY_REMOTE_PATH APPLICATION_REMOTE_PATH DEPLOY_USER_HOSTS; then
    return "$errorEnvironment"
  fi

  deployArgs=(--id "$APPLICATION_ID" --home "${DEPLOY_REMOTE_PATH%/}" --application "${APPLICATION_REMOTE_PATH%/}" "$DEPLOY_USER_HOSTS")
  if ! deployToRemote --deploy "${deployArgs[@]}"; then
    consoleError "Deployment failed, reverting ..." || :
    deployToRemote --revert "${deployArgs[@]}" || :
    return "$errorEnvironment"
  fi
  if hasHook deploy-confirm && ! runHook deploy-confirm; then
    consoleWarning "Deployment confirmation failed, reverting" || :
    if ! deployToRemote --revert "${deployArgs[@]}"; then
      consoleError "Deployment REVERT failed, system is unstable, intervention required." || :
      return 99
    fi
    return "$errorEnvironment"
  fi
  if ! deployToRemote --cleanup "${deployArgs[@]}"; then
    consoleError "Deployment cleanup failed, reverting"
    if ! deployToRemote --revert "${deployArgs[@]}"; then
      consoleError "Deployment REVERT failed, system is unstable, intervention required." || :
      return 99
    fi
    return "$errorEnvironment"
  fi
  bigText Success | wrapLines "$(consoleSuccess)" "$(consoleReset)"
}
_deployBuildEnvironment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCMAME[0]#_}" "$@"
}

#
# This is **run on the remote system** after deployment; environment files are correct.
# It is run inside the deployment home directory in the new application folder.
#
# Current working directory on deploy is `deployHome/applicationId/app`.
# Current working directory on cleanup is `applicationHome/`
# Current working directory on undo is `applicationHome/`
# Note that these MAY be the same or different directories depending on how the application is linked to the deployment
#
# Usage: {fn} [ --revert | --cleanup ] [ --debug ] deployPath applicationId applicationPath
# Argument: --home deployPath - Required. Directory. Path where the deployments database is on remote system.
# Argument: --id applicationId - Required. String. Should match `APPLICATION_ID` in `.env`
# Argument: --application applicationPath - Required. String. Path on the remote system where the application is live
# Argument: --target targetPackage - Optional. Filename. Package name, defaults to `app.tar.gz`
# Argument: --revert - Revert changes just made
# Argument: --cleanup - Cleanup after success
# Argument: --debug - Enable debugging. Defaults to `BUILD_DEBUG`
# Test: testDeployRemoteFinish - INCOMPLETE
deployRemoteFinish() {
  local targetPackage revertFlag cleanupFlag applicationId applicationPath debuggingFlag start width

  if ! dotEnvConfigure; then
    consoleError "deployRemoteFinish: Unable to dotEnvConfigure" 1>&2
    return $?
  fi

  targetPackage=
  revertFlag=
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
          _deployRemoteFinish $errorArgument "Blank --id"
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
    shift || "_${FUNCNAME[0]}" "$errorArgument" "shift failed" || return $?
  done
  if [ -z "$targetPackage" ] && ! targetPackage="$(deployPackageName "$deployHome")"; then
    return $errorArgument
  fi
  # Check arguments are non-blank and actually supplied
  for name in deployHome applicationId applicationPath; do
    if [ -z "${!name}" ]; then
      "_${FUNCNAME[0]}" "$errorArgument" "$name is required" || return $?
    fi
  done

  if test "${BUILD_DEBUG-}"; then
    debuggingFlag=1
  fi
  if test "$debuggingFlag"; then
    consoleWarning "Debugging is enabled"
    set -x
  fi

  if test $revertFlag && test $cleanupFlag; then
    _deployRemoteFinish "$errorArgument" "--cleanup and --revert are mutually exclusive"
  fi

  start=$(beginTiming)
  width=50
  consoleNameValue $width "Host:" "$(uname -n)"
  consoleNameValue $width "Deployment path:" "$deployHome"
  consoleNameValue $width "Application path:" "$applicationPath"
  consoleNameValue $width "Application ID:" "$applicationId"

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
  elif test $revertFlag; then
    _deployRevertApplication "$deployHome" "$applicationId" "$targetPackage" "$applicationPath"
  else
    if [ -z "$applicationId" ]; then
      _deployRemoteFinish "$errorArgument" "No argument applicationId passed"
    fi
    deployApplication "$deployHome" "$applicationId" "$targetPackage" "$applicationPath"
  fi
  reportTiming "$start" "Remote deployment finished in"
}
_deployRemoteFinish() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Revert a deployed application from a deployment repository
#
# Usage: {fn} [ --first ] deployHome applicationId applicationPath [ targetPackage ]
# Argument: --first - Optional. Flag. Undo the first deployment.
# Argument: deployHome - Required. Directory. The deployment repository database home.
# Argument: applicationId - Required. The version to deploy (string)
# Argument: applicationPath - Required. Directory. The application deployed path.
# Argument: targetPackage - Optional. Filename. Package name, defaults to `BUILD_TARGET`
# See: BUILD_TARGET.sh
_deployRevertApplication() {
  local firstDeployment name deployHome versionName previousChecksum targetPackage

  # --first
  firstDeployment=

  # Arguments in order
  deployHome=
  applicationId=
  applicationPath=
  targetPackage=
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      __deployRevertApplication "$errorArgument" "Blank argument" || return $?
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

  for name in deployHome applicationId applicationPath; do
    if [ -z "${!name}" ]; then
      __deployRevertApplication "$errorArgument" "$name is required" || return $?
    fi
  done
  if ! previousChecksum=$(deployPreviousVersion "$deployHome" "$applicationId") || [ -z "$previousChecksum" ]; then
    if ! test "$firstDeployment"; then
      __deployRevertApplication "$errorEnvironment" "Unable to get previous checksum for $versionName" || return $?
    fi
  else
    printf "%s %s -> %s\n" "$(consoleInfo "Reverting installation")" "$(consoleOrange "$applicationId")" "$(consoleGreen "$previousChecksum")"
    if ! deployApplication --revert --home "$deployHome" --id "$previousChecksum" --application "$applicationPath" --target "$targetPackage"; then
      __deployRevertApplication "$errorEnvironment" "Undo deployment to $previousChecksum failed $applicationPath - system is unstable" || return $?
    fi
  fi
  if ! runOptionalHook deploy-revert "$deployHome" "$applicationId"; then
    printf "%s %s\n" "$(consoleCode "deploy-revert")" "$(consoleError "hook failed, continuing anyway")"
  fi
  return 0
}
__deployRevertApplication() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_deploySuccessful() {
  bigText Deployed AOK | wrapLines "$(consoleGreen)" "$(consoleReset)"
  echo
  consoleWarning "No $deployedHostArtifact file found ..."
  consoleSuccess "Nothing deployed or clean exit."
}

#
# Usage: {fn} [ --revert | --cleanup ] [ --debug ] deployPath applicationId applicationPath [ targetPackage ]
#

#
# Summary: Deploy current application to one or more hosts
# Usage: {fn} [ --revert | --cleanup | --deploy ] [ --debug ] [ --help ] applicationId deployHome applicationPath [ userAtHost ... ]
# Argument: --target target - Optional. String. Build target file base name, defaults to `app.tar.gz`
# Argument: --deploy - Default. Flag. deploy an application to a remote host
# Argument: --revert - Optional. Flag. Reverses a deployment
# Argument: --cleanup - Optional. Flag. After all hosts have been `--deploy`ed successfully the `--cleanup` step is run on all hosts to finish up (or clean up) the deployment.
# Argument: --help - Optional. Flag. Show help
# Argument: --debug - Optional. Flag. Turn on debugging (defaults to `BUILD_DEBUG` environment variable)
# Argument: --versions - deployHome - Required. Path. Remote path where we can store deployment state files.
# Argument: --id applicationId - Required. String. The application package will contain a `.env` with `APPLICATION_ID` set to this Value
# Argument: --application applicationPath - Required. Path. Path where the application will be deployed
# Argument: userAtHost - Required. Strings. A list of space-separated values or arguments which match users at remote hosts. Due to shell quoting peculiarities you can pass in space-delimited arguments as single arguments.
#
# Deploy current application to host at applicationPath.
#
# If this fails it will output the installation log.
#
# When this tool succeeds the application:
#
# - `--deploy` - has been deployed in the remote systems successfully but temporary files may still exist
# - `--revert` - No changes should have occurred on the remote host (not guaranteed)
# - `--cleanup` - has been installed in the remote systems successfully
#
# Operation:
#
# ## Deploy `--deploy` Operation
#
# - On each host, `app.tar.gz` is uploaded to the `applicationPath` first
# - On each host, via the shell, change to the `applicationPath` directory
# - Decompress the application package, and run the `deploy-remote-finish.sh` script
#
# ## Cleanup `--cleanup` Operation
#
# - On each host, via the shell, change to the `applicationPath` directory
# - Run the `deploy-remote-finish.sh` script which ...
# - Deletes the application package if it still exists, and runs the `deploy-cleanup` hook
#
# ## Undo `--revert` Operation
#
# - On each host, via the shell, change to the `applicationPath` directory
# - Run the `deploy-remote-finish.sh` script which ...
# - Deploys the prior version in the same manner, and ... <!-- needs expansion TODO -->
# - Runs the `deploy-revert` hook afterwards
#
# The `userAtHost` can be passed as follows:
#
#     deployDeployAction --deploy 5125ab12 /var/www/DEPLOY/coolApp/ /var/www/apps/coolApp/ "www-data@host0 www-data@host1 stageuser@host3" "www-data@host4"
#
# Local cache: `deployHome` is considered a state directory so removing entries in this should be managed separately.
#
# TODO: add ability to prune past n versions safely on all hosts.
#
# Test: testDeployToRemote - INCOMPLETE
deployToRemote() {
  local initTime start deployArgs exitCode
  local makeDirectory
  local commandSuffix

  local deployFlag revertFlag debuggingFlag cleanupFlag

  local userHosts applicationId deployHome applicationPath buildTarget remoteArgs
  local verb temporaryCommandsFile

  local nameWidth=50

  if ! buildEnvironmentLoad HOME BUILD_DEBUG; then
    _deployToRemote "$errorEnvironment" "HOME BUILD_DEBUG environment failed" || return $?
  fi

  initTime=$(beginTiming)

  if [ ! -d "$HOME" ]; then
    _deployToRemote "$errorEnvironment" "No HOME defined or not a directory: $HOME" || return $?
  fi

  # dotEnvConfigure

  # DEBUGGING # consoleWarning "ARGS: $*"
  exitCode=0
  deployFlag=
  revertFlag=
  debuggingFlag=
  cleanupFlag=
  userHosts=()
  applicationId=
  deployHome=
  applicationPath=
  buildTarget=
  remoteArgs=()
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _deployToRemote "$errorArgument" "Blank argument" || return $?
    fi
    case $1 in
      --target)
        shift || :
        if [ -n "$buildTarget" ]; then
          _deployToRemote "$errorArgument" "--target supplied twice" || return $?
        fi
        buildTarget="$1"
        ;;
      --home)
        shift || :
        if [ -n "$deployHome" ]; then
          _deployToRemote "$errorArgument" "--home supplied twice" || return $?
        fi
        deployHome="$1"
        ;;
      --application)
        shift || :
        if [ -n "$applicationPath" ]; then
          _deployToRemote "$errorArgument" "--application supplied twice" || return $?
        fi
        applicationPath="$1"
        ;;
      --id)
        shift || :
        if [ -n "$applicationId" ]; then
          _deployToRemote "$errorArgument" "--id supplied twice" || return $?
        fi
        applicationId="$1"
        ;;
      --help)
        _deployToRemote 0
        return 0
        ;;
      --deploy)
        if test "$deployFlag"; then
          _deployToRemote "$errorArgument" "--deploy arg passed twice" || return $?
        fi
        deployFlag=1
        remoteArgs+=("$1")
        ;;
      --revert)
        if test "$revertFlag"; then
          _deployToRemote "$errorArgument" "--revert specified twice" || return $?
        fi
        revertFlag=1
        remoteArgs+=("$1")
        ;;
      --cleanup)
        if test "$cleanupFlag"; then
          _deployToRemote "$errorArgument" "--cleanup specified twice" || return $?
        fi
        cleanupFlag=1
        remoteArgs+=("$1")
        ;;
      --debug)
        debuggingFlag=1
        ;;
      *)
        # Breaks a single argument "A B C" into three arguments "A" "B" "C" by space
        IFS=' ' read -ra tokens <<<"$1"
        for token in "${tokens[@]}"; do
          userHosts+=("$token")
        done
        ;;
    esac
    shift || :
  done

  # Debugging
  if test "${BUILD_DEBUG-}"; then
    debuggingFlag=1
  fi
  if test $debuggingFlag; then
    consoleWarning "Debugging is enabled"
    set -x
  fi

  # Flag semantics
  if test "$revertFlag" && test "$cleanupFlag"; then
    _deployToRemote "$errorArgument" "--revert and --cleanup are mutually exclusive" || return $?
  fi
  if test "$revertFlag" && test "$deployFlag"; then
    _deployToRemote "$errorArgument" "--revert and --deploy are mutually exclusive" || return $?
  fi
  if test "$deployFlag" && test "$cleanupFlag"; then
    _deployToRemote "$errorArgument" "--deploy and --cleanup are mutually exclusive" || return $?
  fi
  # Values are supplied (required)
  if [ -z "$applicationId" ]; then
    _deployToRemote "$errorArgument" "Missing applicationId" || return $?
  fi
  if [ -z "$deployHome" ]; then
    _deployToRemote "$errorArgument" "Missing deployHome" || return $?
  fi
  if [ -z "$applicationPath" ]; then
    _deployToRemote "$errorArgument" "Missing applicationPath" || return $?
  fi
  if [ -z "$buildTarget" ]; then
    if ! buildTarget=$(deployPackageName "$deployHome"); then
      _deployToRemote "$errorEnvironment" "Missing applicationPath" || return $?
    fi
  fi
  #
  # Current IP
  #
  if ! currentIP=$(ipLookup) || [ -z "$currentIP" ]; then
    _deployToRemote "$errorEnvironment" "Unable to determine IP address: $currentIP" || return $?
  fi

  if [ 0 -eq ${#userHosts[@]} ]; then
    _deployToRemote "$errorEnvironment" "No user hosts provided?" || return $?
  fi

  # sshAddKnownHost
  for userHost in "${userHosts[@]}"; do
    host="${userHost##*@}"
    if ! sshAddKnownHost "$host"; then
      return "$errorEnvironment"
    fi
  done

  if test $revertFlag; then
    verb=Revert
    deployArg=--revert
    if [ ! -f "$deployedHostArtifact" ]; then
      _deploySuccessful
      return 0
    fi
    bigText "$verb" | wrapLines "$(consoleOrange)" "$(consoleReset)"
  elif test $cleanupFlag; then
    # Clean up deployed target
    applicationPath="$deployHome/$applicationId/app"
    verb="Clean up"
    deployArgs=--cleanup
    if [ ! -f "$deployedHostArtifact" ]; then
      consoleError "$deployedHostArtifact file NOT found ... no remotes changed"
      exit 99
    fi
    bigText "$verb" | wrapLines "$(consoleBoldBlue)" "$(consoleReset)"
  else

    #
    #  ▛▀▖▛▀▘▛▀▖▌  ▞▀▖▌ ▌
    #  ▌ ▌▙▄ ▙▄▘▌  ▌ ▌▝▞
    #  ▌ ▌▌  ▌  ▌  ▌ ▌ ▌
    #  ▀▀ ▀▀▘▘  ▀▀▘▝▀  ▘
    #
    verb="Deploy"
    bigText "$verb" | wrapLines "$(consoleGreen)" "$(consoleReset)"

    {
      consoleNameValue $nameWidth "Current IP:" "$currentIP"
      consoleNameValue $nameWidth "deployHome:" "$deployHome"
      consoleNameValue $nameWidth "applicationPath:" "$applicationPath"
      consoleNameValue $nameWidth "applicationId:" "$applicationId"
      for userHost in "${userHosts[@]}"; do
        consoleNameValue $nameWidth "Host:" "${userHost}"
      done
    } || :

    # reset artifact file
    if ! temporaryCommandsFile=$(mktemp); then
      _deployToRemote "$errorEnvironment" "mktemp failed" || return $?
    fi
    printf "" >"$deployedHostArtifact"
    #
    # Create directories and upload the app.tar.gz
    #
    for userHost in "${userHosts[@]}"; do
      start=$(beginTiming) || :
      printf "%s: %s\n" "$(consoleGreen "$userHost")" "$(consoleInfo "Setting up")"
      if ! for makeDirectory in "$applicationPath" "$deployHome" "$deployHome/$applicationId"; do
        printf 'if [ ! -d "%s" ]; then mkdir -p "%s" && echo "Created %s"; fi\n' "$makeDirectory" "$makeDirectory" "$makeDirectory"
      done | ssh "$(__deploySSHOptions)" -T "$userHost" bash --noprofile -s -e; then
        _deployToRemote "$errorEnvironment" "No permission to create directories" || return $?
      fi
      printf "%s: %s %s\n" "$(consoleGreen "$userHost")" "$(consoleInfo "Uploading to")" "$(consoleRed -n "$deployHome/$applicationId/$buildTarget")"
      if ! printf '@put %s %s' "$buildTarget" "$deployHome/$applicationId/$buildTarget" | sftp "$(__deploySSHOptions)" "$userHost" 2>/dev/null; then
        _deployToRemote "$errorEnvironment" "$userHost failed" || return $?
      fi
      reportTiming "$start" "Deployment setup completed on $(consoleGreen "$userHost") in " || :
    done
    commandSuffix=''
    if ! __deployCommandsFile "$deployHome/$applicationId/app" \
      "printf '%s' \"Sweeping stage for $applicationId\" && rm -rf \"$deployHome/$applicationId/app.$$\"$commandSuffix" \
      "printf '%s\n' \"Setting stage for $applicationId\" && mkdir \"$deployHome/$applicationId/app.$$\"$commandSuffix" \
      "printf '%s\n' \"Opening package for $applicationId\" && tar -C \"$deployHome/$applicationId/app.$$\" -zxf \"$deployHome/$applicationId/$buildTarget\" --no-xattrs$commandSuffix" \
      "printf '%s\n' \"Hiding old $applicationId package\" && [ ! -d \"$deployHome/$applicationId/app\" ] || mv -f \"$deployHome/$applicationId/app\" \"$deployHome/$applicationId/app.$$.REPLACING\"$commandSuffix" \
      "printf '%s\n' \"Moving new $applicationId package\" && mv -f \"$deployHome/$applicationId/app.$$\" \"$deployHome/$applicationId/app\"$commandSuffix" \
      "printf '%s\n' \"Cleaning old $applicationId package\" && rm -rf \"$deployHome/$applicationId/app.$$.REPLACING\"$commandSuffix" \
      "--deploy" >"$temporaryCommandsFile"; then
      _deployToRemote "$errorEnvironment" "Generating commands file for $buildTarget expansion" || return $?
    fi
    # wrapLines "COMMANDS: $(consoleCode)" "$(consoleReset)" <"$temporaryCommandsFile"
    for userHost in "${userHosts[@]}"; do
      start=$(beginTiming) || :

      host="${userHost##*@}"
      printf "%s %s: %s\n%s\n" "$(consoleInfo "Deploying the code to")" "$(consoleGreen "$userHost")" "$(consoleRed "$applicationPath")" "$(consoleInfo "$host output BEGIN :::")"
      if buildDebugEnabled; then
        consoleInfo "DEBUG: Commands file is:"
        wrapLines "$(consoleCode)" "$(consoleReset)" <"$temporaryCommandsFile"
      fi
      if ! ssh "$(__deploySSHOptions)" -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile" | wrapLines "$(consoleBoldBlue)" "$(consoleReset)"; then
        _deployToRemote "$errorEnvironment" "Unable to deploy to $host" || return $?
      fi
      consoleInfo "::: END $host output"
      if ! printf "%s\n" "$host" >>"$deployedHostArtifact"; then
        _deployToRemote "$errorEnvironment" "Unable to write $host to $deployedHostArtifact" || return $?
      fi
      reportTiming "$start" "Deployed to $(consoleGreen "$userHost")" || :
    done

    reportTiming "$initTime" "Deploy completed in" || :
    return 0
  fi

  for userHost in "${userHosts[@]}"; do
    start=$(beginTiming)
    host="${userHost##*@}"
    if grep -q "$host" "$deployedHostArtifact"; then
      printf "%s %s (%s) " "$(consoleSuccess "$verb")" "$(consoleCode "$userHost")" "$(consoleBoldRed "$applicationPath")"
      if ! __deployRemoteAction "$userHost" "$applicationPath" "$deployArgs" "$@"; then
        printf "%s %s %s\n" "$(consoleError "$verb failed on")" "$(consoleCode "$userHost")" "$(consoleError "- continuing")"
        exitCode=1
      fi
    else
      printf "%s %s\n" "$(consoleCode "$host")" "$(consoleSuccess "no artifact, so no $verb")"
    fi
    reportTiming "$start"
  done
  reportTiming "$initTime" "All ${#userHosts[@]} $(plural ${#userHosts[@]} host hosts) completed" || :
  return "$exitCode"
}
_deployToRemote() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Generate our commands file
#
# Argument commands must cd such that current directory is a project directory
# Usage: {fn} remoteDirectory  [ --deploy | --revert | --finish ] applicationId deployHome applicationPath
#
__deployCommandsFile() {
  local appHome
  if buildDebugEnabled; then
    # Debugging remote shell
    printf "%s\n%s\n" "export BUILD_DEBUG=1" "set -x"
  fi
  appHome="$1"
  shift || :
  while [ $# -gt 0 ]; do
    case "$1" in
      -*)
        break
        ;;
      *)
        printf "%s || exit \$?\n" "$1"
        ;;
    esac
    shift || :
  done
  # shellcheck disable=SC2016
  printf "%s/%s\n" "$appHome" "bin/build/tools.sh deployRemoteFinish $(printf '"%s" ' "$@") || exit \$?"
}

#
# Usage: {fn} userHost remoteContext deployArg [ ... ]
#
#
__deployRemoteAction() {
  local userHost remoteContext deployArg

  userHost="${1-}"
  shift || :
  remoteContext="${1-}"
  shift || :
  deployArg="${1-}"
  shift || :

  if ! __deployCommandsFile "$remoteContext" "$deployArg" "$@" | ssh -T "$userHost" bash --noprofile -s -e; then
    consoleError "Failed to __deployCommandsFile $remoteContext $deployArg $* - $userHost" 1>&2
    return "$errorEnvironment"
  fi
}

__deploySSHOptions() {
  if buildDebugEnabled; then
    if [ "$BUILD_DEBUG" -ge 3 ]; then
      # Triple verbosity
      printf %s "-vvv"
    else
      printf %s "-v"
    fi
  else
    # Quiet mode. Causes most warning and diagnostic messages to be suppressed.
    printf %s "-q"
  fi
}
