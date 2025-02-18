#!/usr/bin/env bash
#
# daemontools Support
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
    decorate warning "daemontools-run can not be installed because Docker exits 2024-03-21" 1>&2
  else
    packages+=(daemontools-run)
  fi
  __environment packageInstall "${packages[@]}" || return $?
  if insideDocker; then
    decorate warning "daemontools run in background - not production" 1>&2
    __environment daemontoolsExecute || return $?
  fi
}

# Install a daemontools service which runs a binary as the file owner.
#
# Usage: {fn} [ --log-path path ] serviceFile [ serviceName ]
#
# Installs a `daemontools` service with an optional logging daemon process. Uses `daemontools/_service.sh` and `daemontools/_log.sh` files as templates.
#
# Argument: --home serviceHome - Optional. Path. Override `DAEMONTOOLS_HOME` which defaults to `/etc/service`. Specify once.
# Argument: serviceFile - Required. Binary. The daemon to run. The user of this file will be used to run this file and will run as this user and group.
# Argument: serviceName - Optional. String. The daemon service name. If not specified uses the `basename` of `serviceFile` with any extension removed.
# Argument: --log logPath - Optional. Path. The root logging directory where a directory called `serviceName` will be created which contains the `multilog` output `current`
# Argument: --escalate - Optional. Flag. Only if the source file is owned by a non-root user.
#
daemontoolsInstallService() {
  local usage="_${FUNCNAME[0]}"

  local source target logTarget appUser binaryPath
  local start elapsed here

  here="$(dirname "${BASH_SOURCE[0]}")"

  __catchEnvironment "$usage" buildEnvironmentLoad DAEMONTOOLS_HOME || return $?

  local serviceHome="${DAEMONTOOLS_HOME}" serviceName="" serviceFile="" extras=() logPath=""
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --home)
        shift
        serviceHome="${1-}"
        ;;
      --escalate)
        extras+=("$argument")
        ;;
      --log)
        shift
        logPath="$(usageArgumentDirectory "$usage" "$argument" "${1-}")" || return $?
        ;;
      *)
        if [ -z "$serviceFile" ]; then
          serviceFile=$(usageArgumentExecutable "$usage" "serviceFile" "$1") || return $?
        elif [ -z "$serviceName" ]; then
          serviceName=$(usageArgumentString "$usage" "serviceName" "$1") || return $?
        else
          __throwArgument "$usage" "Extra argument $1" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -d "$serviceHome" ] || __throwEnvironment "$usage" "daemontools home \"$serviceHome\" is not a directory" || return $?
  [ -n "$serviceFile" ] || __throwArgument "$usage" "$serviceFile is required" || return $?
  if [ -z "$serviceName" ]; then
    serviceName="$(basename "$serviceFile")"
    serviceName="${serviceName%%.*}"
  fi
  appUser=$(__catchEnvironment "$usage" fileOwner "$serviceFile") || return $?
  [ -n "$appUser" ] || __throwEnvironment "$usage" "fileOwner $serviceFile returned blank" || return $?

  binaryPath=$(realPath "$serviceFile") || __throwEnvironment "$usage" "realPath $serviceFile" || return $?

  target="$serviceHome/$serviceName"
  logTarget="$serviceHome/$serviceName/log"

  LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$binaryPath _daemontoolsInstallServiceRun "$usage" "$here/daemontools/_service.sh" "$target" "${extras[@]+"${extras[@]}"}" || return $?
  if [ -d "$logPath" ]; then
    LOG_PATH=$logPath APPLICATION_USER=$appUser BINARY=$binaryPath _daemontoolsInstallServiceRun "$usage" "$here/daemontools/_log.sh" "$logTarget" "${extras[@]+"${extras[@]}"}" || return $?
  fi

  _daemontoolsSuperviseWait "$usage" "$target" || return $?
  __catchEnvironment "$usage" svc -t "$target" || return $?
  if [ -d "$logPath" ]; then
    _daemontoolsSuperviseWait "$usage" "$logTarget" || return $?
    __catchEnvironment "$usage" svc -t "$logTarget" || return $?
  fi
}
_daemontoolsInstallService() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Copy run file to a service target
_daemontoolsInstallServiceRun() {
  local usage="$1" source="$2" target="$3" args
  shift 3 || __throwArgument "$usage" "Missing arguments" || return $?
  __catchEnvironment "$usage" requireDirectory "$target" || return $?
  args=(--map "$source" "$target/run")
  if copyFileWouldChange "${args[@]}"; then
    __catchEnvironment "$usage" copyFile "$@" "${args[@]}" || return $?
    __catchEnvironment "$usage" chmod 700 "$target" "$target/run" || return $?
  fi
}

# Wait for supervise directory to appear
_daemontoolsSuperviseWait() {
  local usage="$1" && shift
  local total=10 stayQuietFor=5

  local start
  start=$(__catchEnvironment "$usage" date +%s) || return $?
  while [ ! -d "$1/supervise" ]; do
    sleep 1 || __throwEnvironment "$usage" "interrupted" || return $?
    local elapsed
    elapsed=$(($(__catchEnvironment "$usage" date +%s) - start)) || return $?
    if [ $elapsed -gt "$total" ]; then
      __throwEnvironment "$usage" "supervise is not running - $target/supervise never found after $total seconds" || return $?
    elif [ $elapsed -gt "$stayQuietFor" ]; then
      statusMessage decorate info "Waiting for $(decorate file "$1/supervise") ($elapsed) ..."
    fi
  done
  statusMessage --last decorate info "Supervise waiting completed" || return $?
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

  while [ $# -gt 0 ]; do
    arg=$1
    [ -n "$arg" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$arg" in
      --home)
        shift || :
        serviceHome="${1-}"
        ;;
      *)
        if [ -z "$serviceName" ]; then
          serviceName="$1"
        else
          __throwArgument "$usage" "Extra argument $1" || return $?
        fi
        ;;
    esac
    shift || __throwArgument "$usage" "Failed after $arg" || return $?
  done

  [ -d "$serviceHome" ] || __throwEnvironment "$usage" "daemontools home \"$serviceHome\" is not a directory" || return $?
  [ -d "$serviceHome/$serviceName" ] || __throwEnvironment "$usage" "$serviceHome/$serviceName does not exist" || return $?

  __catchEnvironment "$usage" pushd "$serviceHome/$serviceName" >/dev/null || return $?
  __catchEnvironment "$usage" muzzle svc -dx . log 2>&1 || return $?
  __catchEnvironment "$usage" rm -rf "$serviceHome/$serviceName" || return $?
  __catchEnvironment "$usage" popd >/dev/null || return $?
}
_daemontoolsRemoveService() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Is daemontools running?
daemontoolsIsRunning() {
  local this="${FUNCNAME[0]}"
  local usage="_$this"
  local processIds processId

  [ "$(id -u 2>/dev/null)" = "0" ] || __throwEnvironment "$usage" "Must be root" || return $?
  processIds=()
  while read -r processId; do processIds+=("$processId"); done < <(daemontoolsProcessIds)
  [ 0 -ne "${#processIds[@]}" ] || return 1
  ! kill -0 "${processIds[@]}" || return 0
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
  [ "$(id -u)" -eq 0 ] || __throwEnvironment "$usage" "$this: Must be root" || return $?
  home="$(daemontoolsHome)" || __throwEnvironment "$usage" daemontoolsHome || return $?
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
  [ "$(id -u)" -eq 0 ] || __throwEnvironment "$usage" "$this: Must be root" || return $?
  home="$(daemontoolsHome)" || __throwEnvironment "$usage" daemontoolsHome || return $?
  home="${home%/}"
  usageRequireBinary "$usage" svscanboot id svc svstat || return $?

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --timeout)
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
        timeout=$(usageArgumentInteger "$usage" "seconds" "$1") || return $?
        ;;
      *)
        __throwArgument "$usage" "unknown argument $(decorate value "$argument")" || return $?
        ;;
    esac
    shift || __throwArgument "$usage" "shift argument $(decorate code "$argument")" || return $?
  done
  statusMessage decorate warning "Shutting down services ..."
  while read -r service; do
    service="${service%/}"
    if [ "$service" = "$home" ]; then
      continue
    fi
    statusMessage decorate warning "Shutting down $service ..."
    __environment svc -dx "$service" || return $?
    [ ! -d "$service/log" ] || __environment svc -dx "$service/log" || return $?
  done < <(find "$home" -maxdepth 1 -type d)
  processIds=()
  while read -r processId; do processIds+=("$processId"); done < <(daemontoolsProcessIds)
  if [ ${#processIds[@]} -eq 0 ]; then
    statusMessage --last decorate warning "daemontools is not running"
  else
    statusMessage decorate warning "Shutting down processes ..."
    printf "%s\n%s\n" "processIds" "$(printf -- "- %s\n" "${processIds[@]}")"
    __environment processWait --verbose --signals TERM,QUIT,KILL --timeout "$timeout" "${processIds[@]}" || return $?
    remaining="$(daemontoolsProcessIds)"
    if [ -n "$remaining" ]; then
      _environment "daemontools processes still exist: $remaining" || return $?
    fi
    statusMessage --last decorate success "Terminated daemontools"
  fi
}
_daemontoolsTerminate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Restart the daemontools processes from scratch.
# Dangerous. Stops any running services and restarts them.
daemontoolsRestart() {
  local killLoop foundOne maxLoops

  local usage

  usage="_${FUNCNAME[0]}"

  export DAEMONTOOLS_HOME

  __throwEnvironment "$usage" buildEnvironmentLoad DAEMONTOOLS_HOME || return $?
  statusMessage decorate info "Restarting daemontools ..."
  killLoop=0
  maxLoops=4
  foundOne=true
  while $foundOne; do
    foundOne=false
    while read -r pid name; do
      statusMessage decorate info "$(printf "Killing %s %s " "$name" "$(decorate value "($pid)")")"
      kill -9 "$pid" || printf "kill %s FAILED (?: %d) " "$name" $?
      foundOne=true
    done < <(pgrep svscan -l)
    killLoop=$((killLoop + 1))
    [ $killLoop -le $maxLoops ] || __throwEnvironment "$usage" "Unable to kill svscan processes after $maxLoops attempts" || return $?
  done
  pkill svscan -t KILL
  svc -dx /etc/service/* /etc/service/*/log

  nohup svscanboot 2>/dev/null &

  echo "Waiting 5 seconds ..."
  sleep 5
  svstat /etc/service
  echo "Done."
}
_daemontoolsRestart() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Runs a daemon which monitors files and operates on services.
#
# To request a specific action write the file with the action as the first line.
#
# Allows control across user boundaries. (e.g. user can control root services)
#
# Specify actions more than once on the command line to specify more than one set of permissions.
#
# Usage: {fn} [ --interval seconds ] [ --stat statFile ] [ --action actions ] service0 file0 [ service1 file1 ]
# Argument: --home serviceHome - Optional. Service directory home. Defaults to `DAEMONTOOLS_HOME`.
# Argument: --interval intervalSeconds - Optional. Number of seconds to check for presence of the file. Defaults to 10.
# Argument: --stat statFile - Optional. Output the `svstat` status to this file every `intervalSeconds`. If not specified nothing is output.
# Argument: --chirp chirpSeconds - Optional. Output a message saying we're alive every `chirpSeconds` seconds.
# Argument: --action actions - Optional. String. Onr or more actions permitted `start`, `stop`, `restart`, use comma to separate. Default is `restart`.
# Argument: service0 - Required. Directory. Service to control (e.g. `/etc/service/application/`)
# Argument: file1 - Required. File. Absolute path to a file. Presence of  `file` triggers `action`
# Environment: DAEMONTOOLS_HOME - The default home directory for `daemontools`
#
daemontoolsManager() {
  local usage="_${FUNCNAME[0]}"

  __catchEnvironment "$usage" buildEnvironmentLoad DAEMONTOOLS_HOME || return $?

  local services=() files=() actions=()
  local currentActions=("restart") intervalSeconds=10 chirpSeconds=0 statFile="" serviceHome="${DAEMONTOOLS_HOME-}" svcBin statBin service="" file=""

  usageRequireBinary "$usage" svc svstat || return $?

  svcBin=$(__catchEnvironment "$usage" which svc) || return $?
  statBin=$(__catchEnvironment "$usage" which svstat) || return $?

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
      # _IDENTICAL_ --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --chirp)
        shift
        chirpSeconds=$(usageArgumentPositiveInteger "$usage" chirpSeconds "${1-}") || return $?
        ;;
      --interval)
        shift
        intervalSeconds=$(usageArgumentPositiveInteger "$usage" intervalSeconds "${1-}") || return $?
        ;;
      --stat)
        shift
        [ -z "$statFile" ] || __throwArgument "$usage" "$argument must be specified once ($statFile and ${1-})" || return $?
        statFile=$(usageArgumentFileDirectory "$usage" "statFile" "${1-}") || return $?
        ;;
      --home)
        shift
        serviceHome=$(usageArgumentDirectory "$usage" "serviceHome" "${1-}") || return $?
        ;;
      --action)
        shift
        IFS="," read -r -a currentActions <<<"$1" || :
        [ ${#currentActions[@]} -gt 0 ] || __throwArgument "$usage" "$argument No actions specified"
        for action in "${currentActions[@]}"; do
          case "$action" in start | restart | stop) ;; *) __throwArgument "$usage" "Invalid action $action" || return $? ;; esac
        done
        ;;
      *)
        if [ -z "$service" ]; then
          service="$1"
          [ -d "$service" ] || __throwEnvironment "$usage" "service must be a service directory that exists: $service" || return $?
        else
          file="$1"
          [ -d "$(dirname "$file")" ] || __throwEnvironment "$usage" "file must be in a directory that exists: $file" || return $?
          services+=("$service")
          files+=("$file")
          actions+=("${currentActions[*]}")
          service=
          file=
        fi
        ;;
    esac
    shift
  done

  [ "${#services[@]}" -gt 0 ] || __throwArgument "$usage" "Need at least one service and file pair" || return $?

  local start lastChirp

  start=$(__catchEnvironment "$usage" date +%s) || return $?
  lastChirp=$start
  printf "%s: pid %d: (every %d %s)\n" "$(basename "${BASH_SOURCE[0]}")" "$$" "$intervalSeconds" "$(plural "$intervalSeconds" second seconds)"

  local index=0
  while [ $index -lt ${#files[@]} ]; do
    printf "    service: %s file: %s actions: %s\n" "${services[$index]}" "${files[$index]}" "${actions[$index]}"
    index=$((index + 1))
  done
  while true; do
    if [ -n "$statFile" ]; then
      statFile=$(usageArgumentFileDirectory "$usage" "statFile" "$statFile") || return $?
      __catchEnvironment "$usage" "$statBin" "$serviceHome/*" "$serviceHome/*/log" >"$statFile" || return $?
    fi
    index=0
    while [ $index -lt ${#files[@]} ]; do
      local service="${services[$index]}" file="${files[$index]}" action=${actions[$index]} directory fileAction svcBinFlags
      index=$((index + 1))
      directory="$(dirname "$file")"
      [ -d "$directory" ] || __throwEnvironment "$usage" "Parent directory deleted, exiting: $directory" || return $?
      if [ ! -f "$file" ]; then
        continue
      fi
      fileAction="$(head -1 "$file")"
      case "$fileAction" in start | stop | restart) ;; *) fileAction="restart" ;; esac
      IFS=" " read -r -a currentActions <<<"$action" || :
      svcBinFlags=
      for action in "${currentActions[@]}"; do
        if [ "$action" = "$fileAction" ]; then
          printf "start=%s\n""action=%s\n""daemon=%d\n""service=%s\n" "$(date +%s)" "$fileAction" "$$" "$service" >"$file.svc"
          printf "Service %s: %s\n" "$fileAction" "$(basename "$service")"
          case $fileAction in
            start) svcBinFlags="-u" ;;
            stop) svcBinFlags="-d" ;;
            *) svcBinFlags="-t" ;;
          esac
          break
        fi
      done
      if [ -z "$svcBinFlags" ]; then
        printf "Service %s: %s requested but not permitted: %s\n" "$(basename "$service")" "$fileAction" "${actions[*]}" 1>&2
      else
        if "$svcBin" "$svcBinFlags" "$service" 2>&1 | grep -q warning; then
          __throwEnvironment "$usage" "Unable to control service $service ($svcBinFlags)" || return $?
        fi
      fi
      rm -f "$file" "$file.svc" 2>/dev/null
    done
    # Does this work?
    if ! sleep "$intervalSeconds"; then
      statusMessage --last printf -- "%s\n%s%s\n" "$(decorate reset)" "$(decorate warning "Interrupt")"
      break
    fi
    if [ "$chirpSeconds" -gt 0 ]; then
      local now
      now=$(date +%s)
      if [ "$((now - lastChirp))" -gt "$chirpSeconds" ]; then
        printf "pid %d: %s has been alive for %d seconds\n" "$$" "${BASH_SOURCE[0]}" "$((now - start))"
        lastChirp=$now
      fi
    fi
  done
}
_daemontoolsManager() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
