#!/usr/bin/env bash
#
# daemontools Support
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o docs/_templates/ops/daemontools.md
# Test: o bin/tests/daemontools-tests.sh

# shellcheck source=/dev/null
. ./bin/build/env/DAEMONTOOLS_HOME.sh

# IDENTICAL errorArgument 1
errorArgument=2

# IDENTICAL errorEnvironment 1
errorEnvironment=1

_daemontoolsInstallServiceUsage() {
  usageDocument bin/build/tools/daemontools.sh daemontoolsInstallService "$@"
  return $?
}

# Usage: {fn} serviceFile [ serviceName ] [ --log-path path ]
#
# Installs a `daemontools` service with an optional logging daemon process. Uses `_generic-service.sh` and `_generic-log.sh` files as templates.
#
# Argument: --home serviceHome - Optional. Path. Override `DAEMONTOOLS_HOME` which defaults to `/etc/service`. Specify once.
# Argument: serviceFile - Required. Binary. The daemon to run. The user of this file will be used to run this file and will run as this user and group.
# Argument: serviceName - Optional. String. The daemon service name. If not specified uses the `basename` of `serviceFile` with any extension removed.
# Argument: --log logPath - Optional. Path. The root logging directory where a directory called `serviceName` will be created which contains the `multilog` output `current`
#
daemontoolsInstallService() {
  local arg serviceHome serviceName source target logPath logSource logTarget appUser

  logPath=
  serviceHome="${DAEMONTOOLS_HOME}"
  while [ $# -gt 0 ]; do
    arg=$1
    case "$arg" in
      --home)
        shift || :
        serviceHome="${1-}"
        if [ ! -d "$serviceHome" ]; then
          _daemontoolsInstallServiceUsage "$errorArgument" "$arg $serviceHome must be executable"
          return $?
        fi
        ;;
      --log)
        shift || :
        logPath=${1-}
        if [ ! -d "$logPath" ]; then
          _daemontoolsInstallServiceUsage "$errorEnvironment" "$arg $logPath must be a directory"
          return $?
        fi
        ;;
      *)
        if [ -z "$serviceFile" ]; then
          serviceFile="$1"
          if [ ! -x "$serviceFile" ]; then
            _daemontoolsInstallServiceUsage "$errorEnvironment" "$serviceFile must be executable"
            return $?

          fi
        elif [ -z "$serviceName" ]; then
          serviceName="$1"
        else
          _daemontoolsInstallServiceUsage "$errorArgument" "Extra argument $1"
          return $?
        fi
        ;;
    esac
  done
  if [ -z "$serviceFile" ]; then
    _daemontoolsInstallServiceUsage "$errorArgument" "$serviceFile is required"
    return $?
  fi
  if [ -z "$serviceName" ]; then
    serviceName="$(basename "$serviceFile")"
    serviceName="${serviceName%%.*}"
  fi

  appUser=$(fileOwner "$serviceFile")
  if [ -z "$appUser" ]; then
    _daemontoolsInstallServiceUsage "$errorArgument" "Unable to get owner name of $serviceFile"
    return $?
  fi

  source="./bin/build/ops/_generic-service.sh"
  target="$DAEMONTOOLS_HOME/$serviceName"
  [ -d "$target" ] || (mkdir "$target" && echo "Created $target")
  if LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$serviceFile escalatedMapCopyFileChanged "$source" "$target/run"; then
    svc -t "$target"
  fi
  if [ -n "$logPath" ]; then
    logSource="./build/ops/_generic-log.sh"
    logTarget="$DAEMONTOOLS_HOME/$serviceName/log"
    [ -d "$logTarget" ] || (mkdir "$logTarget" && echo "Created $logTarget")
    if LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$serviceFile escalatedCopyFileChanged "$logSource" "$logTarget/run"; then
      svc -t "$logTarget"
    fi
  fi
}
