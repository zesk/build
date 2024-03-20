#!/usr/bin/env bash
#
# daemontools Support
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/ops/daemontools.md
# Test: o ./test/tools/daemontools-tests.sh

# Install a daemontools service which runs a binary as the file owner.
#
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
  local this usage arg serviceHome serviceName source target logPath logSource logTarget appUser

  this="${FUNCNAME[0]}"
  usage="_$this"
  __environment buildEnvironmentLoad DAEMONTOOLS_HOME || return $?
  serviceHome="${DAEMONTOOLS_HOME}"

  logPath=
  while [ $# -gt 0 ]; do
    arg=$1
    [ -z "$arg" ] || __failArgument "$usage" "$this: Blank argument" || return $?
    case "$arg" in
      --home)
        shift || :
        serviceHome="${1-}"
        ;;
      --log)
        shift || :
        logPath=${1-}
        [ -d "$logPath" ] || __failEnvironment "$usage" "$this: $arg $logPath must be a directory" || return $?
        ;;
      *)
        if [ -z "$serviceFile" ]; then
          serviceFile="$1"
          [ -x "$serviceFile" ] || __failEnvironment "$usage" "$serviceFile must be executable" || return $?
        elif [ -z "$serviceName" ]; then
          serviceName="$1"
        else
          __failArgument "$usage" "Extra argument $1" || return $?
        fi
        ;;
    esac
  done

  [ -d "$serviceHome " ] || __failEnvironment "$usage" "daemontools home \"$serviceHome\" is not a directory" || return $?

  [ -n "$serviceFile" ] || __failArgument "$usage" "$serviceFile is required" || return $?
  if [ -z "$serviceName" ]; then
    serviceName="$(basename "$serviceFile")"
    serviceName="${serviceName%%.*}"
  fi
  appUser=$(fileOwner "$serviceFile") || __failEnvironment "fileOwner $serviceFile failed" || return $?
  [ -n "$appUser" ] || __failEnvironment "fileOwner $serviceFile returned blank" || return $?

  source="./bin/build/ops/_generic-service.sh"
  target="$DAEMONTOOLS_HOME/$serviceName"
  [ -d "$target" ] || (mkdir "$target" && echo "Created $target")

  args=(--map "$source" "$target/run")
  if LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$serviceFile copyFileWouldChange "${args[@]}"; then
    LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$serviceFile __environment copyFile "${args[@]}" || return $?
    __environment svc -t "$target" || return $?
  fi
  if [ -n "$logPath" ]; then
    logSource="./build/ops/_generic-log.sh"
    logTarget="$DAEMONTOOLS_HOME/$serviceName/log"
    [ -d "$logTarget" ] || (mkdir "$logTarget" && echo "Created $logTarget")
    args=(--map "$logSource" "$logTarget/run")
    if LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$serviceFile copyFileWouldChange "${args[@]}"; then
      LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$serviceFile __environment copyFile "${args[@]}" || return $?
      __environment svc -t "$logTarget" || return $?
    fi
  fi
}
_daemontoolsInstallService() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Remove a daemontools service by name
#
# Usage: {fn} serviceName
# Argument: serviceName - String. Required. Service name to remove.
daemontoolsRemoveService() {
  local this usage arg serviceHome serviceName

  this="${FUNCNAME[0]}"
  usage="_$this"
  __environment buildEnvironmentLoad DAEMONTOOLS_HOME || return $?
  serviceHome="${DAEMONTOOLS_HOME}"

  logPath=
  while [ $# -gt 0 ]; do
    arg=$1
    [ -z "$arg" ] || __failArgument "$usage" "$this: Blank argument" || return $?
    case "$arg" in
      --home)
        shift || :
        serviceHome="${1-}"
        ;;
      *)
        if [ -z "$serviceFile" ]; then
          serviceFile="$1"
          [ -x "$serviceFile" ] || __failEnvironment "$usage" "$serviceFile must be executable" || return $?
        elif [ -z "$serviceName" ]; then
          serviceName="$1"
        else
          __failArgument "$usage" "Extra argument $1" || return $?
        fi
        ;;
    esac
  done

  [ -d "$serviceHome " ] || __failEnvironment "$usage" "daemontools home \"$serviceHome\" is not a directory" || return $?

  [ -n "$serviceFile" ] || __failArgument "$usage" "$serviceFile is required" || return $?
  if [ -z "$serviceName" ]; then
    serviceName="$(basename "$serviceFile")"
    serviceName="${serviceName%%.*}"
  fi
  [ -d "$serviceHome/$serviceName" ] || __failEnvironment "$usage" "$serviceHome/$serviceName does not exist" || return $?
  __environment pushd "$serviceHome/$serviceName" >/dev/null || return $?
  __environment rm -rf "$serviceHome/$serviceName" || return $?
  __environment svc -dx . log || return $?
  __environment popd >/dev/null || return $?
}
