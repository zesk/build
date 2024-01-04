#!/usr/bin/env bash
#
# Deploy a PHP application to a server host and path, assume git is set up remotely
#
# Artifact: .deployed-hosts
#
# Used to track failed or successful host deployment
# Must be preserved between pipeline steps
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

#
# /var/www/DEPLOY/app1/applicationChecksum1/app.tar.gz
# /var/www/DEPLOY/app1/applicationChecksum1/app/... - app files
# /var/www/DEPLOY/app1/applicationChecksum1.previous
# /var/www/DEPLOY/app1/applicationChecksum1.next
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

# IDENTICAL me 1
me="$(basename "${BASH_SOURCE[0]}")"

# IDENTICAL bashHeader 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

sshHome="$HOME/.ssh"
knownHostsFile="$sshHome/known_hosts"
temporaryCommandsFile=./.temp-sftp
deployedHostArtifact="./.deployed-hosts"
initTime=$(beginTiming)

_deployToUsage() {
  usageDocument "bin/build/pipeline/$me" deployAction "$@"
  exit $?
}

if [ ! -d "${HOME:-}" ]; then
  _deployToUsage $errorEnvironment "No HOME defined or not a directory: $HOME"
fi

# dotEnvConfigure

# DEBUGGING # consoleWarning "ARGS: $*"

deployFlag=
undoFlag=
debuggingFlag=
cleanupFlag=
userHosts=()
applicationChecksum=
remoteDeploymentPath=
remotePath=
buildTarget=
remoteArgs=()
while [ $# -gt 0 ]; do
  case $1 in
    --target)
      shift
      if [ -n "$buildTarget" ]; then
        _deployToUsage $errorArgument "--target supplied twice"
      fi
      buildTarget=$1
      if [ -z "$buildTarget" ]; then
        _deployToUsage $errorArgument "blank --target"
      fi
      ;;
    --help)
      _deployToUsage 0
      ;;
    --deploy)
      if test "$deployFlag"; then
        _deployToUsage $errorArgument "--deploy arg passed twice"
      fi
      deployFlag=1
      ;;
    --debug)
      debuggingFlag=1
      ;;
    --undo)
      if test "$undoFlag"; then
        _deployToUsage $errorArgument "--undo specified twice"
      fi
      undoFlag=1
      remoteArgs+=("--undo")
      ;;
    --cleanup)
      if test "$cleanupFlag"; then
        _deployToUsage $errorArgument "--undo specified twice"
      fi
      cleanupFlag=1
      remoteArgs+=("--cleanup")
      ;;
    *)
      if [ -z "$applicationChecksum" ]; then
        applicationChecksum=$1
      elif [ -z "$remoteDeploymentPath" ]; then
        remoteDeploymentPath=$1
      elif [ -z "$remotePath" ]; then
        remotePath=$1
      else
        IFS=' ' read -ra tokens <<<"$1"
        for token in "${tokens[@]}"; do
          userHosts+=("$token")
        done
      fi
      ;;
  esac
  shift
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
if test "$undoFlag" && test "$cleanupFlag"; then
  _deployToUsage $errorArgument "--undo and --cleanup are mutually exclusive"
fi
if test "$undoFlag" && test "$deployFlag"; then
  _deployToUsage $errorArgument "--undo and --deploy are mutually exclusive"
fi
if test "$deployFlag" && test "$cleanupFlag"; then
  _deployToUsage $errorArgument "--deploy and --cleanup are mutually exclusive"
fi
# Values are not blank
buildTarget="${buildTarget:-app.tar.gz}"
if [ -z "$applicationChecksum" ]; then
  _deployToUsage $errorArgument "Missing applicationChecksum"
fi
if [ -z "$remoteDeploymentPath" ]; then
  _deployToUsage $errorArgument "Missing remoteDeploymentPath"
fi
if [ -z "$remotePath" ]; then
  _deployToUsage $errorArgument "Missing remotePath"
fi

#
# Current IP
#
currentIP=$(ipLookup)
if [ -z "$currentIP" ]; then
  _deployToUsage $errorEnvironment "Unable to determine IP address"
fi

showInfo() {
  echo "$(consoleInfo -n "     IP is currently: ") $(consoleRed -n "$currentIP")"
  echo "$(consoleInfo -n "remoteDeploymentPath: ") $(consoleRed -n "$remoteDeploymentPath")"
  echo "$(consoleInfo -n "          remotePath: ") $(consoleRed -n "$remotePath")"
  echo "$(consoleInfo -n " applicationChecksum: ") $(consoleRed -n "$applicationChecksum")"
  echo "$(consoleInfo -n "           Hosts are: ") $(consoleRed -n "${userHosts[*]}")"
}

if [ -z "${userHosts[*]}" ]; then
  _deployToUsage $errorEnvironment "No user hosts provided?"
fi

#
# known_hosts population
#
# Side effect: known_hosts is modified
#
if [ ! -d "$sshHome" ]; then
  mkdir -m 0700 "$sshHome" || _deployToUsage $errorEnvironment "Unable to create $sshHome for known_hosts files"
fi
for userHost in "${userHosts[@]}"; do
  host="${userHost##*@}"
  if [ ! -f "$knownHostsFile" ] || ! grep -q "$host" "$knownHostsFile"; then
    echo "$(consoleInfo "Adding")" "$(consoleRed "$host")" "$(consoleInfo to)" "$(consoleGreen "$knownHostsFile")"
    umask 0077
    ssh-keyscan -H "$host" >>"$knownHostsFile" 2>/dev/null
  else
    consoleInfo "Using cached key $host in $knownHostsFile"
  fi
done

#
# Generate our commands file
#
# Argument commands must cd such that current directory is a project directory
#
generateCommandsFile() {
  if buildDebugEnabled; then
    # Debugging remote shell
    echo "export BUILD_DEBUG=1"
    echo "set -x"
  fi
  echo "cd \"$remoteDeploymentPath/$applicationChecksum\""
  printf "%s\n" "$@"
  # shellcheck disable=SC2016
  echo "./bin/build/pipeline/remote-deploy-finish.sh ${remoteArgs[*]} \"$applicationChecksum\" \"$remoteDeploymentPath\" \"$remotePath\""
}

undoAction() {
  local rs=0
  #   _   _           _
  #  | | | |_ __   __| | ___
  #  | | | | '_ \ / _` |/ _ \
  #  | |_| | | | | (_| | (_) |
  #   \___/|_| |_|\__,_|\___/
  #
  if [ ! -f "$deployedHostArtifact" ]; then
    bigText Deployed AOK | prefixLines "$(consoleGreen)"
    echo
    showInfo
    echo
    consoleWarning "No $deployedHostArtifact file found ..."
    consoleSuccess "Nothing deployed or clean exit."
    exit 0
  fi
  bigText Undo | prefixLines "$(consoleOrange)"
  echo
  showInfo
  echo
  consoleInfo "$deployedHostArtifact found ..."
  for userHost in "${userHosts[@]}"; do
    start=$(beginTiming)
    host="${userHost##*@}"
    if ! grep -q "$host" "$deployedHostArtifact"; then
      consoleWarning "$host ($userHost) not found in artifact file ... skipping"
      rs=$errorEnvironment
      continue
    fi
    printf "%s %s" "$(consoleInfo "Reverting application at")" "$(consoleRed "$remotePath")"
    generateCommandsFile "cd \"$remotePath\"" >"$temporaryCommandsFile"
    ssh -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile"
    reportTiming "$start" "Done."
  done
  rm "$deployedHostArtifact"
  # artifact removed: .deployed-hosts
  return $rs
}

cleanupAction() {
  local rs=0
  #   ____ _
  #  / ___| | ___  __ _ _ __  _   _ _ __
  # | |   | |/ _ \/ _` | '_ \| | | | '_ \
  # | |___| |  __/ (_| | | | | |_| | |_) |
  #  \____|_|\___|\__,_|_| |_|\__,_| .__/
  # :::::::::::::::::::::::::::::::|_|:::
  bigText Cleanup
  echo
  showInfo
  if [ ! -f "$deployedHostArtifact" ]; then
    consoleError "$deployedHostArtifact file NOT found ... should exist."
    exit 99
  fi
  for userHost in "${userHosts[@]}"; do
    host="${userHost##*@}"
    if ! grep -q "$host" "$deployedHostArtifact"; then
      consoleWarning "$host ($userHost) not found in artifact file ... skipping"
      rs=$errorEnvironment
      continue
    fi
    echo
    start=$(beginTiming)
    echo "$(consoleInfo -n "Finishing application at") $(consoleSuccess "$host")@$(consoleRed -n "$remotePath")"
    echo
    generateCommandsFile "cd \"$remotePath\"" >"$temporaryCommandsFile"
    ssh -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile"
    reportTiming "$start" "$host deployed in"
  done
  rm "$deployedHostArtifact"
  # artifact removed: .deployed-hosts
  return $rs
}

sshishDeployOptions() {
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
# fn: {base}
#
# Summary:Deploy current application to host at remotePath
# Usage: deploy-to.sh [ --undo | --cleanup | --deploy ] [ --debug ] [ --help ] applicationChecksum remoteDeploymentPath remotePath 'user1@host1 user2@host2'
# Argument: --target target$ - Optional. String. Build target file, defaults to `app.tar.gz`
# Argument: --deploy - Default. Flag. deploy an application to a remote host
# Argument: --undo - Optional. Flag. Reverses a deployment
# Argument: --cleanup - Optional. Flag. After all hosts have been `--deploy`ed successfully the `--cleanup` step is run on all hosts to finish up (or clean up) the deployment.
# Argument: --help - Optional. Flag. Show help
# Argument: --debug - Optional. Flag. Turn on debugging (defaults to `BUILD_DEBUG` environment variable)
# Argument: applicationChecksum - Required. String. The application package will contain a `.env` with `APPLICATION_CHECKSUM` set to this Value
# Argument: remoteDeploymentPath - Required. Path. Remote path where we can store deployment state files.
# Argument: remotePath - Required. Path. Path where the application will be deployed
# Argument: user1@host1 - Required. Strings. A list of space-separated values or arguments which match users at remote hosts
#
# Deploy current application to host at remotePath.
#
# If this fails it will output the installation log.
#
# When this tool succeeds the application:
#
# - `--deploy` - has been deployed in the remote systems successfully but temporary files may still exist
# - `--undo` - No changes should have occurred on the remote host (not guaranteed)
# - `--cleanup` - has been installed in the remote systems successfully
#
# Operation:
#
# ## Deploy `--deploy` Operation
#
# - On each host, `app.tar.gz` is uploaded to the `remotePath` first
# - On each host, via the shell, change to the `remotePath` directory
# - Decompress the application package, and run the `remote-deploy-finish.sh` script
#
# ## Cleanup `--cleanup` Operation
#
# - On each host, via the shell, change to the `remotePath` directory
# - Run the `remote-deploy-finish.sh` script which ...
# - Deletes the application package if it still exists, and runs the `deploy-cleanup` hook
#
# ## Undo `--undo` Operation
#
# - On each host, via the shell, change to the `remotePath` directory
# - Run the `remote-deploy-finish.sh` script which ...
# - Deploys the prior version in the same manner, and ... <!-- needs expansion TODO -->
# - Runs the `deploy-undo` hook afterwards
#
# Local cache: `remoteDeploymentPath` is considered a state directory so removing entries in this should be managed separately.
#
# TODO: add ability to prune past n versions safely on all hosts.
#
deployAction() {
  local buildTarget=$1
  #
  #   ____             _
  #  |  _ \  ___ _ __ | | ___  _   _
  #  | | | |/ _ \ '_ \| |/ _ \| | | |
  #  | |_| |  __/ |_) | | (_) | |_| |
  #  |____/ \___| .__/|_|\___/ \__, |
  #  :::::::::::|_|::::::::::::|___/
  #
  bigText Deploy
  printf "\n"
  showInfo
  printf "\n"
  for userHost in "${userHosts[@]}"; do
    start=$(beginTiming)
    printf "%s: %s\n" "$(consoleGreen "$userHost")" "$(consoleInfo "Setting up")"
    for makeDirectory in "$remotePath" "$remoteDeploymentPath" "$remoteDeploymentPath/$applicationChecksum/app"; do
      printf '[ -d "%s" ] || || mkdir -p "%s" && echo "Created %s"\n' "$makeDirectory" "$makeDirectory" "$makeDirectory"
    done | ssh "$(sshishDeployOptions)" -T "$userHost" bash --noprofile -s -e
    printf "%s: %s %s\n" "$(consoleGreen "$userHost")" "$(consoleInfo "Uploading to")" "$(consoleRed -n "$remoteDeploymentPath/$applicationChecksum/$buildTarget")"
    printf '@put %s %s' "$buildTarget" "$applicationChecksum/$buildTarget" | sftp "$(sshishDeployOptions)" "$userHost:$remoteDeploymentPath"
    reportTiming "$start" "Completed $(consoleGreen "$userHost")"
  done

  for userHost in "${userHosts[@]}"; do
    start=$(beginTiming)
    host="${userHost##*@}"
    generateCommandsFile "cd app" "tar zxf ../$buildTarget --no-xattrs" >"$temporaryCommandsFile"
    echo "$(consoleInfo -n Deploying the code to) $(consoleGreen "$userHost") $(consoleRed -n "$remotePath") $(consoleInfo -n "SSH output BEGIN >>>")"
    if buildDebugEnabled; then
      consoleInfo "DEBUG: Commands file is:"
      prefixLines "$(consoleCode)" <"$temporaryCommandsFile"
    fi
    ssh "$(sshishDeployOptions)" -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile"
    consoleInfo "<<< SSH output END"
    reportTiming "$start" "Done."
    echo "$host" >>"$deployedHostArtifact"
  done
  # artifact: .deployed-hosts
}

#
# Put vendor.tar.gz
#
if test $undoFlag; then
  undoAction
elif test $cleanupFlag; then
  cleanupAction
else
  deployAction "$buildTarget"
fi

[ -f "$temporaryCommandsFile" ] && rm "$temporaryCommandsFile"

reportTiming "$initTime" DEPLOYMENT TOTAL
