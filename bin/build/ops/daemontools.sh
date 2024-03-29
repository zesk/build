#!/usr/bin/env bash
#
# daemontools Support
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/ops/daemontools.md
# Test: o ./test/tools/daemontools-tests.sh

#
# Install daemontools and dependencies
# Platform: `docker` containers will not install `daemontools-run` as it kills the container
daemontoolsInstall() {
  local packages

  packages=(daemontools svtools)
  if insideDocker; then
    consoleWarning "daemontools-run can not be installed because Docker exits 2024-03-21" 1>&2
  else
    packages+=(daemontools-run)
  fi
  __environment aptInstall "${packages[@]}" || return $?
  if insideDocker; then
    consoleWarning "daemontools run in background - not production" 1>&2
    __environment daemontoolsExecute || return $?
  fi
}

# Install a daemontools service which runs a binary as the file owner.
#
# Usage: {fn} [ --log-path path ] serviceFile [ serviceName ]
#
# Installs a `daemontools` service with an optional logging daemon process. Uses `_generic-service.sh` and `_generic-log.sh` files as templates.
#
# Argument: --home serviceHome - Optional. Path. Override `DAEMONTOOLS_HOME` which defaults to `/etc/service`. Specify once.
# Argument: serviceFile - Required. Binary. The daemon to run. The user of this file will be used to run this file and will run as this user and group.
# Argument: serviceName - Optional. String. The daemon service name. If not specified uses the `basename` of `serviceFile` with any extension removed.
# Argument: --log logPath - Optional. Path. The root logging directory where a directory called `serviceName` will be created which contains the `multilog` output `current`
#
daemontoolsInstallService() {
  local this usage arg serviceHome serviceName source target logPath logSource logTarget appUser serviceFile binaryPath
  local start elapsed

  here="$(dirname "${BASH_SOURCE[0]}")"
  this="${FUNCNAME[0]}"
  usage="_$this"
  __environment buildEnvironmentLoad DAEMONTOOLS_HOME || return $?
  serviceHome="${DAEMONTOOLS_HOME}"
  serviceName=
  serviceFile=

  logPath=
  while [ $# -gt 0 ]; do
    arg=$1
    [ -n "$arg" ] || __failArgument "$usage" "$this: Blank argument" || return $?
    case "$arg" in
      --home)
        shift || :
        serviceHome="${1-}"
        ;;
      --log)
        shift || __failArgument "$usage" "Missing log path" || return $?
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
    shift || __failArgument "$usage" "Failed after $arg" || return $?
  done

  [ -d "$serviceHome" ] || __failEnvironment "$usage" "daemontools home \"$serviceHome\" is not a directory" || return $?

  [ -n "$serviceFile" ] || __failArgument "$usage" "$serviceFile is required" || return $?
  if [ -z "$serviceName" ]; then
    serviceName="$(basename "$serviceFile")"
    serviceName="${serviceName%%.*}"
  fi
  appUser=$(fileOwner "$serviceFile") || __failEnvironment "$usage" "fileOwner $serviceFile failed" || return $?
  [ -n "$appUser" ] || __failEnvironment "$usage" "fileOwner $serviceFile returned blank" || return $?

  source="$here/_generic-service.sh"
  target="$DAEMONTOOLS_HOME/$serviceName"
  [ -d "$target" ] || (mkdir "$target" && echo "Created $target")

  binaryPath=$(realPath "$serviceFile") || __failEnvironment "$usage" "realPath $serviceFile" || return $?
  args=(--map "$source" "$target/run")
  if LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$binaryPath copyFileWouldChange "${args[@]}"; then
    LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$binaryPath __environment copyFile "${args[@]}" || return $?
    __environment chmod 700 "$target/run" || return $?
  fi
  if [ -n "$logPath" ]; then
    logSource="$here/_generic-log.sh"
    logTarget="$DAEMONTOOLS_HOME/$serviceName/log"
    [ -d "$logTarget" ] || (mkdir "$logTarget" && echo "Created $logTarget")
    args=(--map "$logSource" "$logTarget/run")
    if LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$serviceFile copyFileWouldChange "${args[@]}"; then
      LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$serviceFile __environment copyFile "${args[@]}" || return $?
      __environment chmod 700 "$logTarget/run" || return $?
    fi
  fi
  _daemontoolsSuperviseWait "$target" || return $?
  __environment svc -t "$target" || return $?
  if [ -n "$logPath" ]; then
    _daemontoolsSuperviseWait "$logTarget" || return $?
    __environment svc -t "$logTarget" || return $?
  fi
}
_daemontoolsInstallService() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_daemontoolsSuperviseWait() {
  local start elapsed

  clearLine
  start=$(date +%s)
  while [ ! -d "$1/supervise" ]; do
    sleep 1 || __failEnvironment "$usage" "interrupted" || return $?
    elapsed=$(($(date +%s) - start))
    if [ $elapsed -gt 5 ]; then
      statusMessage consoleInfo "Waiting for $1/supervise ($elapsed) ..."
    elif [ $elapsed -gt 10 ]; then
      __failEnvironment "$usage" "supervise is not running - $target/supervise never found" || return $?
    fi
  done
  clearLine
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
  serviceName=

  logPath=
  while [ $# -gt 0 ]; do
    arg=$1
    [ -n "$arg" ] || __failArgument "$usage" "$this: Blank argument" || return $?
    case "$arg" in
      --home)
        shift || :
        serviceHome="${1-}"
        ;;
      *)
        if [ -z "$serviceName" ]; then
          serviceName="$1"
        else
          __failArgument "$usage" "Extra argument $1" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "Failed after $arg" || return $?
  done

  [ -d "$serviceHome" ] || __failEnvironment "$usage" "daemontools home \"$serviceHome\" is not a directory" || return $?

  [ -d "$serviceHome/$serviceName" ] || __failEnvironment "$usage" "$serviceHome/$serviceName does not exist" || return $?

  __environment pushd "$serviceHome/$serviceName" >/dev/null || return $?
  __environment svc -dx . log || return $?
  __environment rm -rf "$serviceHome/$serviceName" || return $?
  __environment popd >/dev/null || return $?
}
_daemontoolsRemoveService() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Is daemontools running?
daemontoolsIsRunning() {
  local this usage
  local processIds processId

  this="${FUNCNAME[0]}"
  usage="_$this"
  [ "$(id -u)" -eq 0 ] || __failEnvironment "$usage" "$this: Must be root" || return $?
  processIds=()
  while read -r processId; do processIds+=("$processId"); done < <(daemontoolsProcessIds)
  [ 0 -eq "${#processIds[@]}" ] && return 1
  kill -0 "${processIds[@]}" && return 0
  return 1
}
_daemontoolsIsRunning() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Print the daemontools service home path
# Exit code: 0 - success
# Exit code: 1 - No environment file found
daemontoolsHome() {
  local home
  export DAEMONTOOLS_HOME
  buildEnvironmentLoad DAEMONTOOLS_HOME || _environment DAEMONTOOLS_HOME || return $?
  printf "%s\n" "${DAEMONTOOLS_HOME-}"
}

# Launch the daemontools daemon
# Do not use this for production
# Usage: {fn}
# Run the daemontools root daemon
daemontoolsExecute() {
  local this usage
  local home

  this="${FUNCNAME[0]}"
  usage="_$this"
  [ "$(id -u)" -eq 0 ] || __failEnvironment "$usage" "$this: Must be root" || return $?
  home="$(daemontoolsHome)" || __failEnvironment "$usage" daemontoolsHome || return $?
  usageRequireBinary "$usage" svscanboot id svc svstat || return $?
  __environment requireDirectory "$home" >/dev/null || return $?
  __environment chmod 775 "$home" || return $?
  __environment chown root:root "$home" || return $?
  __environment bash -c 'svscanboot &' || return $?
}
_daemontoolsExecute() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List any processes associated with daemontools supervisors
daemontoolsProcessIds() {
  local processIds processId
  processIds=()
  while read -r processId; do processIds+=("$processId"); done < <(pgrep 'svscan*')
  if [ ${#processIds[@]} -eq 0 ]; then
    return 0
  fi
  printf "%s\n" "${processIds[@]}"
}

#
# Terminate daemontools as gracefully as possible
# Usage: {fn} [ --timeout seconds ]
# Argument: --timeout seconds - Integer. Optional.
daemontoolsTerminate() {
  local this usage argument
  local home service processIds processId remaining timeout

  this="${FUNCNAME[0]}"
  usage="_$this"
  [ "$(id -u)" -eq 0 ] || __failEnvironment "$usage" "$this: Must be root" || return $?
  home="$(daemontoolsHome)" || __failEnvironment "$usage" daemontoolsHome || return $?
  home="${home%/}"
  usageRequireBinary "$usage" svscanboot id svc svstat || return $?

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --timeout)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        timeout=$(usageArgumentInteger "$usage" "seconds" "$1") || return $?
        ;;
      *)
        __failArgument "$usage" "Unknown argument $argument" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift $argument failed" || return $?
  done
  clearLine
  statusMessage consoleWarning "Shutting down services ..."
  while read -r service; do
    service="${service%/}"
    if [ "$service" = "$home" ]; then
      continue
    fi
    statusMessage consoleWarning "Shutting down $service ..."
    __environment svc -dx "$service" || return $?
    [ ! -d "$service/log" ] || __environment svc -dx "$service/log" || return $?
  done < <(find "$home" -maxdepth 1 -type d)
  processIds=()
  while read -r processId; do processIds+=("$processId"); done < <(daemontoolsProcessIds)
  if [ ${#processIds[@]} -eq 0 ]; then
    clearLine
    consoleWarning "daemontools is not running"
  else
    statusMessage consoleWarning "Shutting down processes ..."
    printf "\n%s\n\n" "$(_list "processIds" "${processIds[@]}")"
    __environment processWait --verbose --signals TERM,QUIT,KILL --timeout "$timeout" "${processIds[@]}" || return $?
    remaining="$(daemontoolsProcessIds)"
    if [ -n "$remaining" ]; then
      _environment "daemontools processes still exist: $remaining" || return $?
    fi
    consoleSuccess "Terminated daemontools"
  fi
}
_daemontoolsTerminate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
