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
cd "$(dirname "${BASH_SOURCE[0]}")/../../.."

knownHostsFile=$HOME/.ssh/known_hosts
temporaryCommandsFile=./.temp-sftp
deployedHostArtifact="./.deployed-hosts"

# shellcheck source=/dev/null
. ./bin/build/tools.sh

initTime=$(beginTiming)

usageOptions() {
  echo "--deploy;Deploy to remote host with the application checksum"
  echo "--undo;Undo deployment using saved artifacts"
  echo "--cleanup;Clean up remote files after success"
  echo "--help;This help"
  echo "--debug;Turn on debugging (defaults to BUILD_DEBUG environment variable)"
  echo
  echo "remoteDeploymentPath;Path on remote host where deployment backup files are stored."
  echo "remotePath;Path on remote host where deployment application exists."
  echo "user1@host1;Deploy to this user at this host ..."
}
usage() {
  local rs
  rs=$1
  shift
  exec 1>&2
  if [ -n "$*" ]; then
    echo "$@"
    echo
  fi
  echo "$me [ --undo | --cleanup | --deploy ] [ --debug ] [ --help ] applicationChecksum remoteDeploymentPath remotePath 'user1@host1 user2@host2'" | usageGenerator $((${#me} + 1))
  echo
  echo "Deploy current application to host at remotePath"
  echo
  usageOptions | usageGenerator "$(($(usageOptions | maximumFieldLength 1 ";") + 2))" ";"
  echo
  exit "$rs"
}

if [ ! -d "${HOME:-}" ]; then
  usage $errEnv "No HOME defined or not a directory: $HOME"
fi

# dotEnvConfig

# DEBUGGING # consoleWarning "ARGS: $*"

deployFlag=
undoFlag=
debuggingFlag=
cleanupFlag=
userHosts=()
applicationChecksum=
remoteDeploymentPath=
remotePath=
remoteArgs=()
while [ $# -gt 0 ]; do
  case $1 in
  --help)
    usage 0
    ;;
  --deploy)
    if test "$deployFlag"; then
      usage $errArg "--deploy arg passed twice"
    fi
    deployFlag=1
    ;;
  --debug)
    debuggingFlag=1
    ;;
  --undo)
    if test "$undoFlag"; then
      usage $errArg "--undo specified twice"
    fi
    undoFlag=1
    remoteArgs+=("--undo")
    ;;
  --cleanup)
    if test "$cleanupFlag"; then
      usage $errArg "--undo specified twice"
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
  usage $errArg "--undo and --cleanup are mutually exclusive"
fi
if test "$undoFlag" && test "$deployFlag"; then
  usage $errArg "--undo and --deploy are mutually exclusive"
fi
if test "$deployFlag" && test "$cleanupFlag"; then
  usage $errArg "--deploy and --cleanup are mutually exclusive"
fi
# Values are not blank
if [ -z "$applicationChecksum" ]; then
  usage $errArg "Missing applicationChecksum"
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
  echo "$(consoleInfo -n " applicationChecksum: ") $(consoleRed -n "$applicationChecksum")"
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
  if buildDebugEnabled; then
    # Debugging remote shell
    echo "export BUILD_DEBUG=1"
    echo "set -x"
  fi
  echo "cd \"$remotePath\""
  if [ -n "$*" ]; then
    echo "$@"
  fi
  # shellcheck disable=SC2016
  echo "bin/build/pipeline/remote-deploy-finish.sh ${remoteArgs[*]} \"$applicationChecksum\" \"$remoteDeploymentPath\""
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

sshishDeployOptions() {
  if buildDebugEnabled; then
    if [ "$BUILD_DEBUG" -ge 3 ]; then
      # Triple verbosity
      echo -n "-vvv"
    else
      echo -n "-v"
    fi
  else
    # Quiet mode. Causes most warning and diagnostic messages to be suppressed.
    echo -n "-q"
  fi

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
    echo "@put app.tar.gz" | sftp "$(sshishDeployOptions)" "$userHost:$remotePath"
    reportTiming "$start" "Done."
  done
  for userHost in "${userHosts[@]}"; do
    start=$(beginTiming)
    host="${userHost##*@}"
    generateCommandsFile "tar zxf app.tar.gz --no-xattrs" >"$temporaryCommandsFile"
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
  deployAction
fi

[ -f "$temporaryCommandsFile" ] && rm "$temporaryCommandsFile"

reportTiming "$initTime" DEPLOYMENT TOTAL
