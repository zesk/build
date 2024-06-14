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

# Deploy to a host
#
# Argument: --debug - Optional. Flag. Enable debugging.
# Argument: --first - Optional. Flag. When it is the first deployment, use this flag.
# Argument: --home deployPath - Required. Directory. Path where the deployments database is on remote system. Uses
# Argument: --id applicationId - Required. String. If not specified, uses environment variable loaded from `.build.env`, or `APPLICATION_ID` environment.
# Argument: --application applicationPath - Required. String. Path on the remote system where the application is live. If not specified, uses environment variable loaded from `.build.env`, or `APPLICATION_REMOTE_PATH` environment.
# Argument: --target targetPackage - Optional. Filename. Package name usually an archive format.  If not specified, uses environment variable loaded from `.build.env`, or `BUILD_TARGET` environment. Defaults to `app.tar.gz`.
# Loads `./.build.env` if it exists.
# File: `./.build.env`
# Environment: DEPLOY_REMOTE_PATH - path on remote host for deployment data
# Environment: APPLICATION_REMOTE_PATH - path on remote host for application
# Environment: DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)
# Environment: APPLICATION_ID - Version to be deployed
# Environment: BUILD_TARGET - The application package name
# Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar.
#
# Test: testDeployBuildEnvironment - INCOMPLETE
deployBuildEnvironment() {
  local argument deployArgs deployHome applicationId applicationPath
  local buildEnv="./.build.env"
  local envFile envFiles envFilesLoaded
  local usage

  usage="_${FUNCNAME[0]}"

  if [ ! -f "$buildEnv" ]; then
    envFiles=()
    consoleWarning "No .build.env found - environment must be already configured" 1>&2
  else
    envFiles=("$buildEnv")
  fi
  envFilesLoaded=()

  deployHome=
  applicationPath=
  applicationId=
  userHosts=
  targetPackage=
  deployArgs=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --env)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        envFiles+=("$1")
        ;;
      --debug)
        debuggingFlag=true
        ;;
      --first)
        deployArgs+=("$argument")
        ;;
      --home)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        deployHome="$1"
        ;;
      --host)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        [ -n "$1" ] || __failArgument "$usage" "Blank $argument argument" || return $?
        userHosts+=("$1")
        ;;
      --id)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        applicationId="$1"
        ;;
      --application)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        applicationPath=$(usageArgumentDirectory "$usage" applicationPath "$1") || return $?
        ;;
      --target)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        targetPackage="$1"
        ;;
      *)
        userHosts+=("$argument")
        ;;
    esac
    shift || __failArgument "$usage" "shift failed" || return $?
  done

  for envFile in "${envFiles[@]}"; do
    envFilesLoaded+=("$(usageArgumentLoadEnvironmentFile "$usage" "envFile" "$envFile")") 2>&1
  done

  buildEnvironmentLoad APPLICATION_ID DEPLOY_REMOTE_PATH APPLICATION_REMOTE_PATH DEPLOY_USER_HOSTS BUILD_TARGET || :

  ##
  ## APPLICATION_ID --id
  ##

  applicationId=${applicationId:-$APPLICATION_ID}
  # shellcheck disable=SC2016
  [ -n "$applicationId" ] || __failArgument "$usage" 'Requires non-blank `--id` or `APPLICATION_ID`' || return $?

  ##
  ## $DEPLOY_REMOTE_PATH --home
  ##

  deployHome="${deployHome:-$DEPLOY_REMOTE_PATH}"
  # shellcheck disable=SC2016
  [ -n "$deployHome" ] || __failArgument "$usage" 'Requires non-blank `--home` or `DEPLOY_REMOTE_PATH`' || return $?

  ##
  ## $APPLICATION_REMOTE_PATH --application
  ##
  applicationPath="${applicationPath:-$APPLICATION_REMOTE_PATH}"
  # shellcheck disable=SC2016
  [ -n "$applicationPath" ] || __failArgument "$usage" 'Requires non-blank `--application` or `APPLICATION_REMOTE_PATH`' || return $?

  ##
  ## $DEPLOY_USER_HOSTS --home or just non-flagged arguments
  ##
  if [ ${#userHosts[@]} -eq 0 ]; then
    read -r -a userHosts < <(printf "%s" "$DEPLOY_USER_HOSTS")
  fi
  # shellcheck disable=SC2016
  [ ${#userHosts[@]} -gt 0 ] || __failArgument "$usage" 'No user hosts supplied on command line, `--host` or in `DEPLOY_USER_HOSTS`' || return $?
  # shellcheck disable=SC2016
  [ -z "${userHosts[*]}" ] || __failArgument "$usage" 'Requires non-blank `--host` or `DEPLOY_USER_HOSTS`' || return $?

  ##
  ## $BUILD_TARGET --target
  ##
  targetPackage="${targetPackage:-$BUILD_TARGET}"
  # shellcheck disable=SC2016
  [ -n "$targetPackage" ] || __failArgument "$usage" 'Requires non-blank `--target` or `BUILD_TARGET`' || return $?

  deployArgs=(--id "$APPLICATION_ID" --home "${DEPLOY_REMOTE_PATH%/}" --application "${APPLICATION_REMOTE_PATH%/}" "${userHosts[@]}")

  # shellcheck disable=SC2059
  statusMessage consoleInfo "Deploying:$(printf " \"$(consoleCode "%s")\"" "${deployArgs[@]}")" || :
  ___deployBuildEnvironment "${deployArgs[@]}" || return $?
  bigText Success | wrapLines "$(consoleSuccess)" "$(consoleReset)"
}

#
# Meat of deployment which automatically rolls out to following function to clean up
#
___deployBuildEnvironment() {
  local fail="${FUNCNAME[0]#_}"
  # shellcheck disable=SC2059
  statusMessage consoleInfo "Deploying:$(printf " \"$(consoleCode "%s")\"" "$@")" || :
  if ! deployToRemote --deploy "$@"; then
    statusMessage consoleError "Deployment failed, reverting ..." || :
    "$fail" "$@" || return $?
  fi
  if hasHook deploy-confirm && ! runHook deploy-confirm; then
    statusMessage consoleWarning "Deployment confirmation failed, reverting" || :
    "$fail" "$@" || return $?
  fi
  if ! deployToRemote --cleanup "$@"; then
    statusMessage consoleError "Deployment cleanup failed, reverting"
    "$fail" "$@" || return $?
  fi
}

#
# Clean up --revert and then exit
#
__deployBuildEnvironment() {
  local fail="${FUNCNAME[0]#_}"
  if ! deployToRemote --revert "$@"; then
    consoleError "Deployment REVERT failed, system is unstable, intervention required." || :
  fi
  __failEnvironment "$fail" deployToRemote --deploy "$@" failed || return $?
}
_deployBuildEnvironment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
# Argument: --debug - Enable debugging. Defaults to `BUILD_DEBUG`
# Argument: --deploy - Optional. Flag, default setting - handles the remote deploy.
# Argument: --revert - Optional. Flag, Revert changes just made.
# Argument: --cleanup - Optional. Flag, Cleanup after success.
# Argument: --home deployPath - Required. Directory. Path where the deployments database is on remote system.
# Argument: --id applicationId - Required. String. Should match `APPLICATION_ID` in `.env`
# Argument: --application applicationPath - Required. String. Path on the remote system where the application is live
# Argument: --target targetPackage - Optional. Filename. Package name, defaults to `app.tar.gz`
# Test: testDeployRemoteFinish - INCOMPLETE
deployRemoteFinish() {
  local argument targetPackage revertFlag cleanupFlag applicationId applicationPath debuggingFlag start width deployHome firstFlags
  local usage

  usage="_${FUNCNAME[0]}"

  targetPackage=
  revertFlag=false
  cleanupFlag=false
  applicationId=
  applicationPath=
  debuggingFlag=false
  deployHome=
  firstFlags=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --debug)
        debuggingFlag=true
        ;;
      --deploy)
        # shellcheck disable=SC2015
        ! $cleanupFlag && ! $revertFlag || __failArgument "$usage" "$argument is incompatible with --cleanup and --revert" || return $?
        cleanupFlag=false
        revertFlag=false
        ;;
      --cleanup)
        cleanupFlag=true
        ;;
      --revert)
        revertFlag=true
        ;;
      --first)
        firstFlags+=("$argument")
        ;;
      --home)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        deployHome=$(usageArgumentDirectory "$usage" deployHome "${1-}") || return $?
        ;;
      --id)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        applicationId="$1"
        [ -n "$applicationId" ] || __failArgument "$usage" "Requires non-blank $argument" || return $?
        ;;
      --application)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        applicationPath=$(usageArgumentDirectory "$usage" applicationPath "$1") || return $?
        ;;
      --target)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        targetPackage="${1-}"
        ;;
      *)
        __failArgument "$usage" "Unknown argument $1" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift failed" || return $?
  done

  __usageEnvironment "$usage" dotEnvConfigure || return $?

  # Check arguments are non-blank and actually supplied
  for name in deployHome applicationId applicationPath; do
    if [ -z "${!name}" ]; then
      __failArgument "$usage" "$name is required" || return $?
    fi
  done

  [ -n "$targetPackage" ] || targetPackage="$(deployPackageName "$deployHome")" || __failArgument "$usage" "deployPackageName $deployHome failed" || return $?

  if test "${BUILD_DEBUG-}"; then
    debuggingFlag=true
  fi
  if $debuggingFlag; then
    consoleWarning "Debugging is enabled"
    set -x
  fi

  if $revertFlag && $cleanupFlag; then
    __failArgument "$usage" "--cleanup and --revert are mutually exclusive"
  fi

  start=$(beginTiming)
  width=50
  consoleNameValue $width "Host:" "$(uname -n)"
  consoleNameValue $width "Deployment path:" "$deployHome"
  consoleNameValue $width "Application path:" "$applicationPath"
  consoleNameValue $width "Application ID:" "$applicationId"

  if $cleanupFlag; then
    __usageEnvironment "$usage" cd "$applicationPath" || return $?
    consoleInfo "Cleaning up ... "
    if hasHook deploy-cleanup; then
      __usageEnvironment "$usage" runHook deploy-cleanup || return $?
    else
      printf "No %s hook in %s\n" "$(consoleInfo "deploy-cleanup")" "$(consoleCode "$applicationPath")"
    fi
  elif $revertFlag; then
    __usageEnvironment "$usage" _deployRevertApplication "$deployHome" "$applicationId" "$applicationPath" "$targetPackage" || return $?
  else
    if [ -z "$applicationId" ]; then
      __failArgument "$usage" "No argument applicationId passed" || return $?
    fi
    __usageEnvironment "$usage" deployApplication "${firstFlags[@]+${firstFlags[@]}}" --home "$deployHome" --id "$applicationId" --target "$targetPackage" --application "$applicationPath" || return $?
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
  local usage

  usage="_${FUNCNAME[0]}"
  # --first
  firstDeployment=

  # Arguments in order
  deployHome=
  applicationId=
  applicationPath=
  targetPackage=
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      __failArgument "$usage" "Blank argument" || return $?
    fi
    case "$1" in
      --first)
        firstDeployment=1
        ;;
      *)
        if [ -z "$deployHome" ]; then
          deployHome=$(usageArgumentDirectory "$usage" deployHome "$1") || return $?
        elif [ -z "$applicationId" ]; then
          applicationId="$1"
        elif [ -z "$applicationPath" ]; then
          applicationPath=$(usageArgumentDirectory "$usage" applicationPath "$1") || return $?
        elif [ -z "$targetPackage" ]; then
          targetPackage="$1"
        else
          __failArgument "$usage" "Unknown argument $1" || return $?
        fi
        ;;
    esac
    shift || :
  done
  [ -n "$targetPackage" ] || targetPackage="$(deployPackageName "$deployHome")" || __failArgument "$usage" "deployPackageName \"$deployHome\" failed" || return $?

  for name in deployHome applicationId applicationPath; do
    if [ -z "${!name}" ]; then
      __failArgument "$usage" "$name is required" || return $?
    fi
  done
  if ! previousChecksum=$(deployPreviousVersion "$deployHome" "$applicationId") || [ -z "$previousChecksum" ]; then
    if ! test "$firstDeployment"; then
      __failEnvironment "$usage" "Unable to get previous checksum for $versionName" || return $?
    fi
  else
    printf "%s %s -> %s\n" "$(consoleInfo "Reverting installation")" "$(consoleOrange "$applicationId")" "$(consoleGreen "$previousChecksum")"
    if ! deployApplication --revert --home "$deployHome" --id "$previousChecksum" --application "$applicationPath" --target "$targetPackage"; then
      __failEnvironment "$usage" "Undo deployment to $previousChecksum failed $applicationPath - system is unstable" || return $?
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

  local userHosts applicationId deployHome applicationPath buildTarget remoteArgs firstFlags
  local verb temporaryCommandsFile
  local commonArguments
  local nameWidth=50
  local argument
  local usage

  usage="_${FUNCNAME[0]}"

  __usageEnvironment "$usage" buildEnvironmentLoad HOME BUILD_DEBUG || return $?

  initTime=$(beginTiming)

  [ -d "$HOME" ] || __failEnvironment "$usage" "No HOME defined or not a directory: $HOME" || return $?

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
  firstFlags=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --target)
        shift || :
        [ -z "$buildTarget" ] || __failArgument "$usage" "$argument supplied twice" || return $?
        buildTarget="$1"
        ;;
      --home)
        shift || :
        [ -z "$deployHome" ] || __failArgument "$usage" "$argument supplied twice" || return $?
        deployHome="$1"
        ;;
      --first)
        firstFlags+=("$argument")
        ;;
      --application)
        shift || :
        [ -z "$applicationPath" ] || __failArgument "$usage" "$argument supplied twice" || return $?
        applicationPath="$1"
        ;;
      --id)
        shift || :
        [ -z "$applicationId" ] || __failArgument "$usage" "$argument supplied twice" || return $?
        applicationId="$1"
        ;;
      --help)
        _deployToRemote 0
        return 0
        ;;
      --deploy)
        if test "$deployFlag"; then
          __failArgument "$usage" "--deploy arg passed twice" || return $?
        fi
        deployFlag=1
        remoteArgs+=("$1")
        ;;
      --revert)
        if test "$revertFlag"; then
          __failArgument "$usage" "--revert specified twice" || return $?
        fi
        revertFlag=1
        remoteArgs+=("$1")
        ;;
      --cleanup)
        if test "$cleanupFlag"; then
          __failArgument "$usage" "--cleanup specified twice" || return $?
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
    __failArgument "$usage" "--revert and --cleanup are mutually exclusive" || return $?
  fi
  if test "$revertFlag" && test "$deployFlag"; then
    __failArgument "$usage" "--revert and --deploy are mutually exclusive" || return $?
  fi
  if test "$deployFlag" && test "$cleanupFlag"; then
    __failArgument "$usage" "--deploy and --cleanup are mutually exclusive" || return $?
  fi
  # Values are supplied (required)
  [ -n "$applicationId" ] || __failArgument "$usage" "Missing applicationId" || return $?

  [ -n "$deployHome" ] || __failArgument "$usage" "Missing deployHome" || return $?

  [ -n "$applicationPath" ] || __failArgument "$usage" "Missing applicationPath" || return $?
  if [ -z "$buildTarget" ]; then
    buildTarget=$(deployPackageName "$deployHome") || __failEnvironment "$usage" "Missing applicationPath" || return $?
  fi
  #
  # Current IP
  #
  if ! currentIP=$(ipLookup) || [ -z "$currentIP" ]; then
    __failEnvironment "$usage" "Unable to determine IP address: $currentIP" || return $?
  fi

  if [ 0 -eq ${#userHosts[@]} ]; then
    __failEnvironment "$usage" "No user hosts provided?" || return $?
  fi

  # sshAddKnownHost
  for userHost in "${userHosts[@]}"; do
    host="${userHost##*@}"
    __environment sshAddKnownHost "$host" || return $?
  done

  commonArguments=("${firstFlags[@]+${firstFlags[@]}}" "--target" "$buildTarget" "--home" "$deployHome" "--id" "$applicationId" "--application" "$applicationPath")
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
      __failEnvironment "$usage" "mktemp failed" || return $?
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
        __failEnvironment "$usage" "No permission to create directories" || return $?
      fi
      printf "%s: %s %s\n" "$(consoleGreen "$userHost")" "$(consoleInfo "Uploading to")" "$(consoleRed -n "$deployHome/$applicationId/$buildTarget")"
      if ! printf '@put %s %s' "$buildTarget" "$deployHome/$applicationId/$buildTarget" | sftp "$(__deploySSHOptions)" "$userHost" 2>/dev/null; then
        __failEnvironment "$usage" "$userHost failed" || return $?
      fi
      reportTiming "$start" "Deployment setup completed on $(consoleGreen "$userHost") in " || :
    done
    commandSuffix=''
    if
      ! __deployCommandsFile "$deployHome/$applicationId/app" \
        "printf '%s' \"Sweeping stage for $applicationId\" && rm -rf \"$deployHome/$applicationId/app.$$\"$commandSuffix" \
        "printf '%s\n' \"Setting stage for $applicationId\" && mkdir \"$deployHome/$applicationId/app.$$\"$commandSuffix" \
        "printf '%s\n' \"Opening package for $applicationId\" && tar -C \"$deployHome/$applicationId/app.$$\" -zxf \"$deployHome/$applicationId/$buildTarget\" --no-xattrs$commandSuffix" \
        "printf '%s\n' \"Hiding old $applicationId package\" && [ ! -d \"$deployHome/$applicationId/app\" ] || mv -f \"$deployHome/$applicationId/app\" \"$deployHome/$applicationId/app.$$.REPLACING\"$commandSuffix" \
        "printf '%s\n' \"Moving new $applicationId package\" && mv -f \"$deployHome/$applicationId/app.$$\" \"$deployHome/$applicationId/app\"$commandSuffix" \
        "printf '%s\n' \"Cleaning old $applicationId package\" && rm -rf \"$deployHome/$applicationId/app.$$.REPLACING\"$commandSuffix" \
        "--deploy" "${commonArguments[@]}" >"$temporaryCommandsFile"
    then
      __failEnvironment "$usage" "Generating commands file for $buildTarget expansion" || return $?
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
        __failEnvironment "$usage" "Unable to deploy to $host" || return $?
      fi
      consoleInfo "::: END $host output"
      printf "%s\n" "$host" >>"$deployedHostArtifact" || __failEnvironment "$usage" "Unable to write $host to $deployedHostArtifact" || return $?
      reportTiming "$start" "Deployed to $(consoleGreen "$userHost")" || :
    done

    reportTiming "$initTime" "Deploy completed in" || :
    return 0
  fi

  #
  #     ▜                                       ▐
  #  ▞▀▖▐ ▞▀▖▝▀▖▛▀▖▌ ▌▛▀▖ ▞▀▖▙▀▖ ▙▀▖▞▀▖▌ ▌▞▀▖▙▀▖▜▀
  #  ▌ ▖▐ ▛▀ ▞▀▌▌ ▌▌ ▌▙▄▘ ▌ ▌▌   ▌  ▛▀ ▐▐ ▛▀ ▌  ▐ ▖
  #  ▝▀  ▘▝▀▘▝▀▘▘ ▘▝▀▘▌   ▝▀ ▘   ▘  ▝▀▘ ▘ ▝▀▘▘   ▀
  #
  for userHost in "${userHosts[@]}"; do
    start=$(beginTiming)
    host="${userHost##*@}"
    if grep -q "$host" "$deployedHostArtifact"; then
      printf "%s %s (%s) " "$(consoleSuccess "$verb")" "$(consoleCode "$userHost")" "$(consoleBoldRed "$applicationPath")"
      # Runs --revert or --cleanup as configured above
      if ! __deployRemoteAction "$userHost" "$deployHome/$applicationId/app" "$deployArgs" "${commonArguments[@]}"; then
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
  printf "cd \"%s\" || exit \$?\n" "$appHome"
  # return $? is here for findUncaughtAssertions line
  printf "%s/bin/build/tools.sh __environment deployRemoteFinish %s|| exit \$?\n" "$appHome" "$(printf '"%s" ' "$@")" || return $?
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
    _environment "Failed to __deployCommandsFile $remoteContext $deployArg $* - $userHost" || return $?
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
