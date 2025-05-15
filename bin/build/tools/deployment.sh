#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
#    ▌      ▜                 ▐
#  ▞▀▌▞▀▖▛▀▖▐ ▞▀▖▌ ▌▛▚▀▖▞▀▖▛▀▖▜▀
#  ▌ ▌▛▀ ▙▄▘▐ ▌ ▌▚▄▌▌▐ ▌▛▀ ▌ ▌▐ ▖
#  ▝▀▘▝▀▘▌   ▘▝▀ ▗▄▘▘▝ ▘▝▀▘▘ ▘ ▀
#
# Docs: o ./documentation/source/tools/deployment.md
# Test: o ./test/tools/deployment-tests.sh

deployedHostArtifact="./.deployed-hosts"

# Deploy to a host
#
# DOC TEMPLATE: --env-file 1
# Argument: --env-file envFile - Optional. File. Environment file to load - can handle any format.
# Argument: --debug - Optional. Flag. Enable debugging.
# Argument: --first - Optional. Flag. When it is the first deployment, use this flag.
# Argument: --home deployPath - Required. Directory. Path where the deployments database is on remote system. Uses
# Argument: --id applicationId - Required. String. If not specified, uses environment variable loaded from `.build.env`, or `APPLICATION_ID` environment.
# Argument: --application applicationPath - Required. String. Path on the remote system where the application is live. If not specified, uses environment variable loaded from `.build.env`, or `APPLICATION_REMOTE_HOME` environment.
# Argument: --target targetPackage - Optional. Filename. Package name usually an archive format.  If not specified, uses environment variable loaded from `.build.env`, or `BUILD_TARGET` environment. Defaults to `app.tar.gz`.
# Loads `./.build.env` if it exists.
# File: `./.build.env`
# Environment: DEPLOY_REMOTE_HOME - path on remote host for deployment data
# Environment: APPLICATION_REMOTE_HOME - path on remote host for application
# Environment: DEPLOY_USER_HOSTS - list of user@host (will be tokenized by spaces regardless of shell quoting)
# Environment: APPLICATION_ID - Version to be deployed
# Environment: BUILD_TARGET - The application package name
# Not possible to deploy to different paths on different hosts, currently. Hosts are assumeed to be similar.
#
# Test: testDeployBuildEnvironment - INCOMPLETE
deployBuildEnvironment() {
  local usage="_${FUNCNAME[0]}"
  local argument deployArgs deployHome applicationId applicationPath
  local buildEnv="./.build.env"
  local envFile envFiles envFilesLoaded dryRun targetPackage userHosts

  envFiles=()
  envFilesLoaded=()
  if [ -f "$buildEnv" ]; then
    envFiles=("$buildEnv")
  fi

  deployHome=
  applicationPath=
  applicationId=
  userHosts=()
  dryRun=false
  targetPackage=
  deployArgs=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --env-file)
      shift
      envFiles+=("$(usageArgumentFile "$usage" "envFile" "${1-}")") || return $?
      ;;
    --debug)
      debuggingFlag=true
      ;;
    --first)
      deployArgs+=("$argument")
      ;;
    --home)
      shift
      [ -n "${1-}" ] || __throwArgument "$usage" "blank $argument argument" || return $?
      deployHome="${1-}"
      ;;
    --host)
      shift
      [ -n "${1-}" ] || __throwArgument "$usage" "blank $argument argument" || return $?
      userHosts+=("$1")
      ;;
    --id)
      shift
      [ -n "${1-}" ] || __throwArgument "$usage" "blank $argument argument" || return $?
      applicationId="$1"
      ;;
    --application)
      shift
      applicationPath="${1-}"
      ;;
    --target)
      shift
      [ -n "${1-}" ] || __throwArgument "$usage" "blank $argument argument" || return $?
      targetPackage="${1-}"
      ;;
    --dry-run)
      dryRun=true
      ;;
    *)
      userHosts+=("$argument")
      ;;
    esac
    shift || __throwArgument "$usage" "missing argument $(decorate label "$argument")" || return $?
  done

  if [ ! -f "$buildEnv" ]; then
    decorate warning "No .build.env found - environment must be already configured" 1>&2
  fi

  for envFile in "${envFiles[@]+${envFiles[@]}}"; do
    muzzle usageArgumentLoadEnvironmentFile "$usage" "envFile" "$envFile" || return $?
    envFilesLoaded+=("$envFile")
  done

  buildEnvironmentLoad APPLICATION_ID DEPLOY_REMOTE_HOME APPLICATION_REMOTE_HOME DEPLOY_USER_HOSTS BUILD_TARGET || :

  ##
  ## APPLICATION_ID --id
  ##

  applicationId=${applicationId:-$APPLICATION_ID}
  # shellcheck disable=SC2016
  [ -n "$applicationId" ] || __throwArgument "$usage" 'Requires non-blank `--id` or `APPLICATION_ID`' || return $?

  ##
  ## $DEPLOY_REMOTE_HOME --home
  ##

  deployHome="${deployHome:-$DEPLOY_REMOTE_HOME}"
  # shellcheck disable=SC2016
  [ -n "$deployHome" ] || __throwArgument "$usage" 'Requires non-blank `--home` or `DEPLOY_REMOTE_HOME`' || return $?

  ##
  ## $APPLICATION_REMOTE_HOME --application
  ##
  applicationPath="${applicationPath:-$APPLICATION_REMOTE_HOME}"
  # shellcheck disable=SC2016
  [ -n "$applicationPath" ] || __throwArgument "$usage" 'Requires non-blank `--application` or `APPLICATION_REMOTE_HOME`' || return $?

  ##
  ## $DEPLOY_USER_HOSTS --home or just non-flagged arguments
  ##
  if [ ${#userHosts[@]} -eq 0 ]; then
    decorate info "Loading DEPLOY_USER_HOSTS: $DEPLOY_USER_HOSTS"
    read -r -a userHosts < <(printf "%s" "$DEPLOY_USER_HOSTS") || :
  fi
  # shellcheck disable=SC2016
  [ ${#userHosts[@]} -gt 0 ] || __throwArgument "$usage" 'No user hosts supplied on command line, `--host` or in `DEPLOY_USER_HOSTS`' || return $?
  # shellcheck disable=SC2016
  [ -n "${userHosts[*]}" ] || __throwArgument "$usage" 'Requires non-blank `--host` or `DEPLOY_USER_HOSTS`' || return $?

  ##
  ## $BUILD_TARGET --target
  ##
  targetPackage="${targetPackage:-$BUILD_TARGET}"
  # shellcheck disable=SC2016
  [ -n "$targetPackage" ] || __throwArgument "$usage" 'Requires non-blank `--target` or `BUILD_TARGET`' || return $?

  deployArgs=(--id "$applicationId" --home "${deployHome%/}" --application "${applicationPath%/}" "${userHosts[@]}")

  # shellcheck disable=SC2059
  statusMessage decorate info "Deploying:$(printf " \"$(decorate code "%s")\"" "${deployArgs[@]}")" || :
  if $dryRun; then
    printf "\n%s %s\b" ___deployBuildEnvironment "$(printf "\"%s\" " "${deployArgs[@]}")"
  else
    ___deployBuildEnvironment "${deployArgs[@]}" || return $?
    printf "\n%s\n" "$(bigText --bigger Success)" | decorate wrap --fill " " | decorate success
  fi
}

#
# Meat of deployment which automatically rolls out to following function to clean up
#
___deployBuildEnvironment() {
  local fail="${FUNCNAME[0]#_}"
  # shellcheck disable=SC2059
  statusMessage decorate info "Deploying:$(printf " \"$(decorate code "%s")\"" "$@")" || :
  if ! deployToRemote --deploy "$@"; then
    statusMessage decorate error "Deployment failed, reverting ..." || :
    "$fail" "$@" || return $?
  fi
  if hasHook deploy-confirm && ! hookRun deploy-confirm; then
    statusMessage decorate warning "Deployment confirmation failed, reverting" || :
    "$fail" "$@" || return $?
  fi
  if ! deployToRemote --cleanup "$@"; then
    statusMessage decorate error "Deployment cleanup failed, reverting"
    "$fail" "$@" || return $?
  fi
}

#
# Clean up --revert and then exit
#
__deployBuildEnvironment() {
  local usage="${FUNCNAME[0]#_}"
  if ! deployToRemote --revert "$@"; then
    decorate error "Deployment REVERT failed, system is unstable, intervention required." || :
  fi
  __throwEnvironment "$usage" deployToRemote --deploy "$@" failed || return $?
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
  local argument targetPackage revertFlag cleanupFlag name deployArguments
  local applicationId applicationPath debuggingFlag start width deployHome firstFlags
  local usage="_${FUNCNAME[0]}"

  targetPackage=
  revertFlag=false
  cleanupFlag=false
  applicationId=
  applicationPath=
  debuggingFlag=false
  deployHome=
  firstFlags=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --debug)
      debuggingFlag=true
      ;;
    --deploy)
      # shellcheck disable=SC2015
      ! $cleanupFlag && ! $revertFlag || __throwArgument "$usage" "$argument is incompatible with --cleanup and --revert" || return $?
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
      shift
      deployHome=$(usageArgumentDirectory "$usage" deployHome "${1-}") || return $?
      ;;
    --id)
      shift
      [ -n "${1-}" ] || __throwArgument "$usage" "blank $argument $argument" || return $?
      applicationId="$1"
      ;;
    --application)
      shift
      applicationPath=$(usageArgumentFileDirectory "$usage" applicationPath "${1-}") || return $?
      ;;
    --target)
      shift
      [ -n "${1-}" ] || __throwArgument "$usage" "blank $argument $argument" || return $?
      targetPackage="${1-}"
      ;;
    *)
      __throwArgument "unknown argument: $(decorate value "$argument")" || return $?
      ;;
    esac
    shift || __throwArgument "$usage" "missing argument $(decorate label "$argument")" || return $?
  done

  # Check arguments are non-blank and actually supplied
  for name in deployHome applicationId applicationPath; do
    if [ -z "${!name}" ]; then
      __throwArgument "$usage" "$name is required" || return $?
    fi
  done

  [ -n "$targetPackage" ] || targetPackage="$(deployPackageName "$deployHome")" || __throwArgument "$usage" "deployPackageName $deployHome failed" || return $?

  if buildDebugStart deployment; then
    debuggingFlag=true
    decorate warning "Debugging is enabled"
  fi

  if $revertFlag && $cleanupFlag; then
    __throwArgument "$usage" "--cleanup and --revert are mutually exclusive" || return $?
  fi

  start=$(timingStart)
  width=50
  decorate pair $width "Host:" "$(uname -n)"
  decorate pair $width "Deployment path:" "$deployHome"
  decorate pair $width "Application path:" "$applicationPath"
  decorate pair $width "Application ID:" "$applicationId"

  if $cleanupFlag; then
    __catchEnvironment "$usage" cd "$applicationPath" || return $?
    decorate info "Cleaning up ... "
    if hasHook --application "$applicationPath" deploy-cleanup; then
      __catchEnvironment "$usage" hookRun deploy-cleanup || return $?
    else
      printf "No %s hook in %s\n" "$(decorate info "deploy-cleanup")" "$(decorate code "$applicationPath")"
    fi
  elif $revertFlag; then
    __catchEnvironment "$usage" _deployRevertApplication "$deployHome" "$applicationId" "$applicationPath" "$targetPackage" || return $?
  else
    if [ -z "$applicationId" ]; then
      __throwArgument "$usage" "No argument applicationId passed" || return $?
    fi
    __catchEnvironment "$usage" cd "$deployHome" || return $?
    deployArguments=(
      "${firstFlags[@]+${firstFlags[@]}}"
      --home "$deployHome"
      --id "$applicationId"
      --target "$targetPackage"
      --application "$applicationPath"
    )
    ! $debuggingFlag || printf "%s %s\n" "RUN: deployApplication" "$(printf " \"%s\"" "${deployArguments[@]}")"

    #
    # deployApplication call "the chewy center"
    #
    #  ┏━ ┏━┛┏━┃┃  ┏━┃┃ ┃┏━┃┏━┃┏━┃┃  ┛┏━┛┏━┃━┏┛┛┏━┃┏━
    #  ┃ ┃┏━┛┏━┛┃  ┃ ┃━┏┛┏━┃┏━┛┏━┛┃  ┃┃  ┏━┃ ┃ ┃┃ ┃┃ ┃
    #  ━━ ━━┛┛  ━━┛━━┛ ┛ ┛ ┛┛  ┛  ━━┛┛━━┛┛ ┛ ┛ ┛━━┛┛ ┛
    #
    statusMessage decorate info "Deploying application ..."
    __catchEnvironment "$usage" deployApplication "${deployArguments[@]}" || return $?
  fi
  statusMessage --last timingReport "$start" "Remote deployment finished in"
}
_deployRemoteFinish() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Revert a deployed application from a deployment repository
#
# Usage: {fn} [ --first ] deployHome applicationId applicationPath [ targetPackage ]
# Argument: --first - Optional. Flag. Undo the first deployment.
# Argument: deployHome - Required. Directory. The deployment repository database home.
# Argument: applicationId - Required. The version to revert FROM (string)
# Argument: applicationPath - Required. Directory. The FROM application deployed path.
# Argument: targetPackage - Optional. Filename. Package name, defaults to `BUILD_TARGET`
# See: BUILD_TARGET.sh
_deployRevertApplication() {
  local firstDeployment name deployHome versionName previousChecksum targetPackage
  local usage

  usage="_${FUNCNAME[0]}"
  # --first
  firstDeployment=false

  # Arguments in order
  deployHome=
  applicationId=
  applicationPath=
  targetPackage=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    --first)
      firstDeployment=true
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
        __throwArgument "unknown argument: $(decorate value "$argument")" || return $?
      fi
      ;;
    esac
    shift || :
  done
  [ -n "$targetPackage" ] || targetPackage="$(deployPackageName "$deployHome")" || __throwArgument "$usage" "deployPackageName \"$deployHome\" failed" || return $?

  for name in deployHome applicationId applicationPath; do
    if [ -z "${!name}" ]; then
      __throwArgument "$usage" "$name is required" || return $?
    fi
  done

  if ! previousChecksum=$(deployPreviousVersion "$deployHome" "$applicationId") || [ -z "$previousChecksum" ]; then
    if ! "$firstDeployment"; then
      __throwEnvironment "$usage" "Unable to get previous checksum for $versionName" || return $?
    fi
  else
    printf "%s %s -> %s\n" "$(decorate info "Reverting installation")" "$(decorate orange "$applicationId")" "$(decorate green "$previousChecksum")"
    if ! deployApplication --revert --home "$deployHome" --id "$applicationId" --application "$applicationPath" --target "$targetPackage"; then
      __throwEnvironment "$usage" "Undo deployment to $previousChecksum failed $applicationPath - system is unstable" || return $?
    fi
  fi
  if ! hookRunOptional deploy-revert "$deployHome" "$applicationId"; then
    printf "%s %s\n" "$(decorate code "deploy-revert")" "$(decorate error "hook failed, continuing anyway")"
  fi
  decorate success "Application successfully reverted to version $(decorate code "$applicationId")" || :
  return 0
}
__deployRevertApplication() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_deploySuccessful() {
  bigText Deployed AOK | decorate green
  echo
  decorate warning "No $deployedHostArtifact file found ..."
  decorate success "Nothing deployed or clean exit."
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
# Argument: --commands - Optional. Flag. Display commands sent to server but do not execute them. For debugging or testing. Implies --skip-ssh-host
# Argument: --skip-ssh-host - Optional. Flag. Do not add ssh hosts to known hosts file.
# Argument: --add-ssh-host - Optional. Flag. Add hosts to known hosts file in SSH if not already added.

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
# Environment: BUILD_DEBUG
deployToRemote() {
  local usage="_${FUNCNAME[0]}"
  local initTime

  __catchEnvironment "$usage" buildEnvironmentLoad HOME BUILD_DEBUG || return $?

  initTime=$(timingStart) || return $?

  [ -d "$HOME" ] || __throwEnvironment "$usage" "No HOME defined or not a directory: $HOME" || return $?

  local deployFlag=false revertFlag=false debuggingFlag=false cleanupFlag=false
  local userHosts=() applicationId="" deployHome="" applicationPath="" buildTarget="" remoteArgs=() firstFlags=() addSSHHosts=true showCommands=false currentIP=""

  while [ $# -gt 0 ]; do
    local argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    --target)
      shift
      [ -z "$buildTarget" ] || __throwArgument "$usage" "$argument supplied twice" || return $?
      buildTarget="$1"
      ;;
    --skip-ssh-host)
      addSSHHosts=false
      ;;
    --add-ssh-host)
      addSSHHosts=true
      ;;
    --home)
      shift
      [ -z "$deployHome" ] || __throwArgument "$usage" "$argument supplied twice" || return $?
      deployHome="$1"
      ;;
    --first)
      firstFlags+=("$argument")
      ;;
    --application)
      shift
      [ -z "$applicationPath" ] || __throwArgument "$usage" "$argument supplied twice" || return $?
      applicationPath="$1"
      ;;
    --ip)
      shift
      currentIP=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --id)
      shift
      [ -z "$applicationId" ] || __throwArgument "$usage" "$argument supplied twice" || return $?
      applicationId="$1"
      ;;
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --deploy)
      if "$deployFlag"; then
        __throwArgument "$usage" "--deploy arg passed twice" || return $?
      fi
      deployFlag=true
      remoteArgs+=("$1")
      ;;
    --revert)
      if "$revertFlag"; then
        __throwArgument "$usage" "--revert specified twice" || return $?
      fi
      revertFlag=true
      remoteArgs+=("$1")
      ;;
    --cleanup)
      if "$cleanupFlag"; then
        __throwArgument "$usage" "--cleanup specified twice" || return $?
      fi
      cleanupFlag=true
      remoteArgs+=("$1")
      ;;
    --debug)
      debuggingFlag=true
      ;;
    --commands)
      showCommands=true
      # Technically, you can enable after this `--commands --add-ssh-hosts` on CLI
      addSSHHosts=false
      ;;
    *)
      # Breaks a single argument "A B C" into three arguments "A" "B" "C" by space
      IFS=' ' read -r -a userHosts <<<"$1" || :
      ;;
    esac
    shift || :
  done

  # Debugging
  if buildDebugStart deployment; then
    debuggingFlag=true
    decorate warning "Debugging is enabled"
  fi

  # Flag semantics
  if "$revertFlag" && "$cleanupFlag"; then
    __throwArgument "$usage" "--revert and --cleanup are mutually exclusive" || return $?
  fi
  if "$revertFlag" && "$deployFlag"; then
    __throwArgument "$usage" "--revert and --deploy are mutually exclusive" || return $?
  fi
  if "$deployFlag" && "$cleanupFlag"; then
    __throwArgument "$usage" "--deploy and --cleanup are mutually exclusive" || return $?
  fi
  # Values are supplied (required)
  [ -n "$applicationId" ] || __throwArgument "$usage" "missing applicationId" || return $?

  [ -n "$deployHome" ] || __throwArgument "$usage" "missing deployHome" || return $?

  [ -n "$applicationPath" ] || __throwArgument "$usage" "missing applicationPath" || return $?

  if [ -z "$buildTarget" ]; then
    buildTarget=$(deployPackageName "$deployHome") || __throwEnvironment "$usage" deployPackageName "$deployHome" || return $?
  fi
  if [ 0 -eq ${#userHosts[@]} ]; then
    __throwArgument "$usage" "No user hosts provided" || return $?
  fi

  #
  # Current IP
  #
  currentIP=$(__catchEnvironment "$usage" ipLookup) || __throwEnvironment "$usage" "Unable to determine IP address" || return $?
  [ -n "$currentIP" ] || __throwEnvironment "$usage" "IP address lookup blank" || return $?

  if $addSSHHosts; then
    # sshKnownHostAdd
    for userHost in "${userHosts[@]}"; do
      host="${userHost##*@}"
      __environment sshKnownHostAdd "$host" || return $?
    done
  fi

  local verb color deployArg temporaryCommandsFile commonArguments

  temporaryCommandsFile=$(mktemp) || __throwEnvironment "$usage" "mktemp failed" || return $?
  commonArguments=("${firstFlags[@]+${firstFlags[@]}}" "--target" "$buildTarget" "--home" "$deployHome" "--id" "$applicationId" "--application" "$applicationPath")
  if $revertFlag; then
    verb=Revert
    color=orange
    deployArg=--revert
  elif $cleanupFlag; then
    # Clean up deployed target
    applicationPath="$deployHome/$applicationId/app"
    verb="Clean up"
    color="bold-blue"
    deployArg=--cleanup
  else
    #
    #  ▛▀▖▛▀▘▛▀▖▌  ▞▀▖▌ ▌
    #  ▌ ▌▙▄ ▙▄▘▌  ▌ ▌▝▞
    #  ▌ ▌▌  ▌  ▌  ▌ ▌ ▌
    #  ▀▀ ▀▀▘▘  ▀▀▘▝▀  ▘
    #
    local commandSuffix=""
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
      __throwEnvironment "$usage" "Generating commands file for $buildTarget expansion" || return $?
    fi
    if $showCommands; then
      cat "$temporaryCommandsFile"
      rm "$temporaryCommandsFile" || :
      return 0
    fi

    verb="Deploy"
    bigText "$verb" | decorate green

    local nameWidth=50
    {
      decorate pair $nameWidth "Current IP:" "$currentIP"
      decorate pair $nameWidth "Deploy Home:" "$deployHome"
      decorate pair $nameWidth "Application Path:" "$applicationPath"
      decorate pair $nameWidth "Application ID:" "$applicationId"
      decorate pair $nameWidth "Package:" "$buildTarget"
      for userHost in "${userHosts[@]}"; do
        decorate pair $nameWidth "Host:" "${userHost}"
      done
    } || :

    # reset artifact file
    printf "" >"$deployedHostArtifact"
    __catchEnvironment "$usage" __deployUploadPackage "$applicationPath" "$deployHome/$applicationId" "$buildTarget" "${userHosts[@]}" || return $?

    for userHost in "${userHosts[@]}"; do
      local start
      start=$(timingStart) || :

      host="${userHost##*@}"
      printf "%s %s: %s\n%s\n" "$(decorate info "Deploying the code to")" "$(decorate green "$userHost")" "$(decorate red "$applicationPath")" "$(decorate info "$host output BEGIN :::")"
      if buildDebugEnabled; then
        decorate info "DEBUG: Commands file is:"
        decorate code <"$temporaryCommandsFile"
      fi
      if ! ssh "$(__deploySSHOptions)" -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile" | decorate bold-bold | decorate wrap "$(decorate orange "$userHost"): "; then
        __throwEnvironment "$usage" "Unable to deploy to $host" || return $?
      fi
      decorate info "::: END $host output"
      printf "%s\n" "$host" >>"$deployedHostArtifact" || __throwEnvironment "$usage" "Unable to write $host to $deployedHostArtifact" || return $?
      statusMessage timingReport "$start" "Deployed to $(decorate green "$userHost")" || :
    done

    statusMessage --last timingReport "$initTime" "Deploy completed in" || :
    return 0
  fi

  __catchEnvironment "$usage" __deployCommandsFile "$deployHome/$applicationId/app" "$deployArg" "${commonArguments[@]}" >"$temporaryCommandsFile" || return $?
  if $showCommands; then
    __catchEnvironment "$usage" cat "$temporaryCommandsFile" || return $?
    rm -rf "$temporaryCommandsFile" || :
    return 0
  fi
  bigText "$verb" | decorate "$color"
  if [ ! -f "$deployedHostArtifact" ]; then
    if $revertFlag; then
      _deploySuccessful
      return 0
    else
      __throwEnvironment "$usage" "$(decorate file "$deployedHostArtifact") file NOT found ... no remotes changed" || return $?
    fi
  fi
  #
  #     ▜                                       ▐
  #  ▞▀▖▐ ▞▀▖▝▀▖▛▀▖▌ ▌▛▀▖ ▞▀▖▙▀▖ ▙▀▖▞▀▖▌ ▌▞▀▖▙▀▖▜▀
  #  ▌ ▖▐ ▛▀ ▞▀▌▌ ▌▌ ▌▙▄▘ ▌ ▌▌   ▌  ▛▀ ▐▐ ▛▀ ▌  ▐ ▖
  #  ▝▀  ▘▝▀▘▝▀▘▘ ▘▝▀▘▌   ▝▀ ▘   ▘  ▝▀▘ ▘ ▝▀▘▘   ▀
  #
  local exitCode
  exitCode=0
  for userHost in "${userHosts[@]}"; do
    start=$(timingStart)
    host="${userHost##*@}"
    if grep -q "$host" "$deployedHostArtifact"; then
      printf "%s %s (%s) " "$(decorate success "$verb")" "$(decorate code "$userHost")" "$(decorate bold-red "$applicationPath")"
      if ! ssh -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile"; then
        printf "%s %s %s\n" "$(decorate error "$verb failed on")" "$(decorate code "$userHost")" "$(decorate error "- continuing")"
        exitCode=1
      fi
    else
      printf "%s %s\n" "$(decorate code "$host")" "$(decorate success "no artifact, so no $verb")"
    fi
    timingReport "$start" "$verb $(decorate value "$host") in"
  done
  buildDebugStop deployment || :
  statusMessage --last timingReport "$initTime" "All ${#userHosts[@]} $(plural ${#userHosts[@]} host hosts) completed" || :
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
    printf "%s\n%s\n" "export BUILD_DEBUG=1" "set -vx" # Debugging
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
  printf -- "cd \"%s\" || exit \$?\n" "$appHome"
  # return $? is here for findUncaughtAssertions line
  printf -- "%s/bin/build/tools.sh __environment deployRemoteFinish %s|| exit \$?\n" "$appHome" "$(printf '"%s" ' "$@")" || return $?
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

# Usage: {fn} applicationPath remotePath buildTarget [ userHost ... ]
# Create base directories and upload package
__deployUploadPackage() {
  local start userHost
  local applicationPath=$1 remotePath=$2 buildTarget=$3

  shift 3 || :
  #
  # Create directories and upload the app.tar.gz
  #
  for userHost in "$@"; do
    start=$(timingStart) || :
    printf "%s: %s\n" "$(decorate green "$userHost")" "$(decorate info "Setting up")"
    __catchEnvironment "$usage" ssh "$(__deploySSHOptions)" -T "$userHost" bash --noprofile -s -e < <(__deployCreateDirectoryCommands "$applicationPath" "$remotePath") || return $?
    printf "%s: %s %s\n" "$(decorate green "$userHost")" "$(decorate info "Uploading to")" "$(decorate red "$remotePath/$buildTarget")"
    if ! printf -- '@put %s %s' "$buildTarget" "$remotePath/$buildTarget" | sftp "$(__deploySSHOptions)" "$userHost" 2>/dev/null; then
      __throwEnvironment "$usage" "Upload $remotePath/$buildTarget to $userHost buildFailed " || return $?
    fi
    timingReport "$start" "Deployment setup completed on $(decorate green "$userHost") in " || :
  done
}

__deployCreateDirectoryCommands() {
  while [ $# -gt 0 ]; do
    printf -- 'if [ ! -d "%s" ]; then mkdir -p "%s" && echo "Created %s"; fi\n' "$1" "$1" "$1"
    shift
  done
}
