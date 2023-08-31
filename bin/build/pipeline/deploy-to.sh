#!/usr/bin/env bash
#
# Deploy a PHP application to a server host and path, assume git is set up remotely
#
# Artifact: .deployed-hosts
#
# Used to track failed or successful host deployment
# Must be preserved between pipeline steps
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errEnv=1
errArg=2
# set -x # Uncomment to enable debugging
set -eo pipefail

me=$(basename "$0")
relTop="../../.."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
  echo "$me: Can not cd to $relTop" 1>&2
  exit $errEnv
fi
knownHostsFile=$HOME/.ssh/known_hosts
temporaryCommandsFile=./.temp-sftp
deployedHostArtifact="./.deployed-hosts"
SSH_KEY_TYPE=${SSH_KEY_TYPE:-rsa}

# shellcheck source=/dev/null
. ./bin/build/tools.sh

initTime=$(beginTiming)

usage() {
  local rs
  rs=$1
  shift
  exec 1>&2
  if [ -n "$*" ]; then
    echo "$@"
    echo
  fi
  echo "$me [ --undo | --cleanup ] remoteDeploymentPath remotePath 'user1@host1 user2@host2'"
  echo
  echo "Push current git tag to host at remotePath"
  echo
  echo "--undo                 Undo deployment using saved artifacts"
  echo "--cleanup              Clean up remote files after success"
  echo
  echo "remoteDeploymentPath   Path on remote host where deployment backup files are stored."
  echo "remotePath             Path on remote host where deployment application exists."
  echo "user1@host1            Deploy to this user at this host ..."
  echo
  exit "$rs"
}

dotEnvConfig

# DEBUGGING # consoleWarning "ARGS: $*"

undoFlag=
cleanupFlag=
userHosts=()
remoteDeploymentPath=
remotePath=
remoteArgs=()
while [ $# -gt 0 ]; do
  case $1 in
  --undo)
    undoFlag=1
    remoteArgs+=("--undo")
    ;;
  --cleanup)
    cleanupFlag=1
    remoteArgs+=("--cleanup")
    ;;
  *)
    if [ -z "$remoteDeploymentPath" ]; then
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

if test "$undoFlag" && test "$cleanupFlag"; then
  usage $errArg "--undo and --cleanup are mutually exclusive"
fi
if [ -z "$remoteDeploymentPath" ]; then
  usage $errArg "Missing remoteDeploymentPath"
fi
if [ -z "$remotePath" ]; then
  usage $errArg "Missing remotePath"
fi

#
# Current IP
#
currentIP=$(ipLookup)
if [ -z "$currentIP" ]; then
  usage $errEnv "Unable to determine IP address"
fi

showInfo() {
  echo "$(consoleInfo -n "     IP is currently: ") $(consoleRed -n "$currentIP")"
  echo "$(consoleInfo -n "remoteDeploymentPath: ") $(consoleRed -n "$remoteDeploymentPath")"
  echo "$(consoleInfo -n "          remotePath: ") $(consoleRed -n "$remotePath")"
  echo "$(consoleInfo -n "           Hosts are: ") $(consoleRed -n "${userHosts[*]}")"
}

if [ -z "${userHosts[*]}" ]; then
  usage $errEnv "No user hosts provided?"
fi
#
# known_hosts population
#
for userHost in "${userHosts[@]}"; do
  host="${userHost##*@}"
  if ! grep -q "$host" "$knownHostsFile"; then
    echo "$(consoleInfo "Adding")" "$(consoleRed "$host")" "$(consoleInfo to)" "$(consoleGreen "$knownHostsFile")"
    ssh-keyscan -H "$host" >>"$knownHostsFile" 2>/dev/null
  else
    consoleInfo "Using cached key $host in $knownHostsFile"
  fi
done

#
# Generate our commands file
#
generateCommandsFile() {
  echo "cd \"$remotePath\""
  if [ -n "$*" ]; then
    echo "$@"
  fi
  # shellcheck disable=SC2016
  echo "bin/build/pipeline/remote-deploy-finish.sh ${remoteArgs[*]} \"$APPLICATION_GIT_SHA\" \"$remoteDeploymentPath\""
}

undoAction() {
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
    if ! grep -q "$host" "$deployedHostArtifact"; then
      consoleWarning "$host not found in artifact file ... skipping"
      continue
    fi
    echo -n "$(consoleInfo -n "Reverting application at") $(consoleRed -n "$remotePath")"
    generateCommandsFile >"$temporaryCommandsFile"
    ssh -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile"
    reportTiming "$start" "Done."
  done
  rm "$deployedHostArtifact"
  # artifact removed: .deployed-hosts
}

cleanupAction() {
  #    ____ _
  #   / ___| | ___  __ _ _ __  _   _ _ __
  #  | |   | |/ _ \/ _` | '_ \| | | | '_ \
  #  | |___| |  __/ (_| | | | | |_| | |_) |
  #   \____|_|\___|\__,_|_| |_|\__,_| .__/
  #                                 |_|
  bigText Cleanup
  echo
  showInfo
  if [ -f "$deployedHostArtifact" ]; then
    consoleError "$deployedHostArtifact file found ... should not exist."
    exit 99
  fi
  for userHost in "${userHosts[@]}"; do
    start=$(beginTiming)
    echo -n "$(consoleInfo -n "Finishing application at") $(consoleRed -n "$remotePath")"
    generateCommandsFile >"$temporaryCommandsFile"
    ssh -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile"
    reportTiming "$start" "Done."
  done
}

deployAction() {
  #   ____             _
  #  |  _ \  ___ _ __ | | ___  _   _
  #  | | | |/ _ \ '_ \| |/ _ \| | | |
  #  | |_| |  __/ |_) | | (_) | |_| |
  #  |____/ \___| .__/|_|\___/ \__, |
  #             |_|            |___/
  bigText Deploy
  echo
  showInfo
  echo
  for userHost in "${userHosts[@]}"; do
    start=$(beginTiming)
    echo -n "$(consoleInfo -n "Uploading build environment to") $(consoleGreen -n "$userHost")$(consoleInfo -n ":")$(consoleRed -n "$remotePath") "
    echo "@put vendor.tar.gz" | sftp -q "$userHost:$remotePath"
    reportTiming "$start" "Done."
  done
  for userHost in "${userHosts[@]}"; do
    start=$(beginTiming)
    host="${userHost##*@}"
    generateCommandsFile "git fetch -q; git reset --hard $APPLICATION_GIT_SHA" >"$temporaryCommandsFile"
    echo "$(consoleInfo -n Deploying the code to) $(consoleGreen "$userHost") $(consoleRed -n "$remotePath") $(consoleInfo -n "SSH output BEGIN >>>")"
    ssh -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile"
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
  deployAction
fi

[ -f "$temporaryCommandsFile" ] && rm "$temporaryCommandsFile"

reportTiming "$initTime" DEPLOYMENT TOTAL