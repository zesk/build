#!/usr/bin/env bash
#
# daemontools Support
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/ops/daemontools.md
# Test: o ./test/tools/daemontools-tests.sh

# Install daemontools and dependencies
# Platform: `docker` containers will not install `daemontools-run` as it kills the container
daemontoolsInstall() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local packages

  if isAlpine; then
    # not working, actually
    packages=(daemontools-encore)
  else
    packages=(daemontools svtools)
    if insideDocker; then
      decorate warning "daemontools-run can not be installed because Docker exits 2024-03-21" 1>&2
    else
      packages+=(daemontools-run)
    fi
  fi
  __environment packageInstall "${packages[@]}" || return $?
  if insideDocker; then
    decorate warning "daemontools run in background - not production" 1>&2
    __environment daemontoolsExecute || return $?
  fi
}
_daemontoolsInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
# Argument: --name serviceName - Optional. String. The daemon service name. If not specified uses the `basename` of `serviceFile` with any extension removed.
# Argument: --log logHome - Optional. Path. The root logging directory where a directory called `serviceName` will be created which contains the `multilog` output `current`
# Argument: --escalate - Optional. Flag. Only if the source file is owned by a non-root user.
# Argument: --log-arguments ... -- - Optional. ArgumentsList. List of arguments for the logger.
# Argument: --arguments ... -- - Optional. ArgumentsList. List of arguments for the service.
# Argument: -- ... - Arguments. Optional. List of arguments for the service.
#
daemontoolsInstallService() {
  local handler="_${FUNCNAME[0]}"

  local logTarget appUser binaryPath
  local elapsed here
  local debugFlag=false

  local serviceHome="" serviceName="" serviceFile="" extras=() logHome="" arguments=() logArguments=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug)
      debugFlag=true
      ;;
    --home)
      shift
      serviceHome="${1-}"
      ;;
    --escalate)
      extras+=("$argument")
      ;;
    --)
      shift
      arguments+=("$@")
      break
      ;;
    --arguments)
      shift
      # shellcheck disable=SC2015
      while [ $# -gt 0 ]; do [ "$1" != "--" ] && arguments+=("$1") && shift || break; done
      [ $# -gt 0 ] || break
      ;;
    --log-arguments)
      shift
      # shellcheck disable=SC2015
      while [ $# -gt 0 ]; do [ "$1" != "--" ] && logArguments+=("$1") && shift || break; done
      [ $# -gt 0 ] || break
      ;;
    --name)
      shift
      serviceName=$(usageArgumentString "$handler" "serviceName" "${1-}") || return $?
      ;;
    --log)
      shift
      logHome="$(usageArgumentDirectory "$handler" "$argument" "${1-}")" || return $?
      ;;
    *)
      if [ -z "$serviceFile" ]; then
        serviceFile=$(usageArgumentExecutable "$handler" "serviceFile" "$1") || return $?
      elif [ -z "$serviceName" ]; then
        serviceName=$(usageArgumentString "$handler" "serviceName" "$1") || return $?
      else
        __throwArgument "$handler" "Extra argument $1" || return $?
      fi
      ;;
    esac
    shift
  done

  here="$(__catch "$handler" buildHome)/bin/build/tools" || return $?

  __catch "$handler" buildEnvironmentLoad DAEMONTOOLS_HOME || return $?

  [ -n "$serviceHome" ] || serviceHome=${DAEMONTOOLS_HOME-}
  [ -d "$serviceHome" ] || __throwEnvironment "$handler" "daemontools home \"$serviceHome\" is not a directory" || return $?

  [ -n "$serviceFile" ] || __throwArgument "$handler" "$serviceFile is required" || return $?
  if [ -z "$serviceName" ]; then
    serviceName="$(basename "$serviceFile")"
    serviceName="${serviceName%%.*}"
  fi
  appUser=$(__catch "$handler" fileOwner "$serviceFile") || return $?
  [ -n "$appUser" ] || __throwEnvironment "$handler" "fileOwner $serviceFile returned blank" || return $?

  binaryPath=$(realPath "$serviceFile") || __throwEnvironment "$handler" "realPath $serviceFile" || return $?

  target="$serviceHome/$serviceName"
  logTarget="$serviceHome/$serviceName/log"

  local args="" logArgs=""
  [ "${#arguments[@]}" -eq 0 ] || args=" $(decorate each quote "${arguments[@]}")"
  ! $debugFlag || printf -- "- %s\n" "ARGUMENTS" "${#arguments[@]}" "${arguments[@]+"${arguments[@]}"}" 1>&2
  ! $debugFlag || printf -- "- %s %s\n" "args" "$args" 1>&2
  ARGUMENTS="$args" LOG_HOME="$logHome" APPLICATION_USER="$appUser" BINARY="$binaryPath" _daemontoolsInstallServiceRun "$handler" "$here/daemontools/_service.sh" "$target" "${extras[@]+"${extras[@]}"}" || return $?
  if [ -d "$logHome" ]; then
    [ "${#logArguments[@]}" -eq 0 ] || logArgs=" $(decorate each quote "${logArguments[@]}")"
    ARGUMENTS="$logArgs" LOG_HOME="$logHome" APPLICATION_USER="$appUser" BINARY="$binaryPath" _daemontoolsInstallServiceRun "$handler" "$here/daemontools/_log.sh" "$logTarget" "${extras[@]+"${extras[@]}"}" || return $?
  fi

  _daemontoolsSuperviseWait "$handler" "$target" || return $?
  if [ -d "$logHome" ]; then
    _daemontoolsSuperviseWait "$handler" "$logTarget" || return $?
  fi
}
_daemontoolsInstallService() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Copy run file to a service target
_daemontoolsInstallServiceRun() {
  local handler="$1" source="$2" target="$3" args
  shift 3 || __throwArgument "$handler" "Missing arguments" || return $?
  __catch "$handler" muzzle directoryRequire "$target" || return $?
  args=(--map "$source" "$target/run")
  if fileCopyWouldChange "${args[@]}"; then
    __catchEnvironment "$handler" fileCopy "$@" "${args[@]}" || return $?
    __catchEnvironment "$handler" chmod 700 "$target" "$target/run" || return $?
  fi
}

# Wait for supervise directory to appear
_daemontoolsSuperviseWait() {
  local handler="$1" && shift
  local total=10 stayQuietFor=5

  statusMessage decorate info "Waiting for $(decorate file "$1/supervise") (START) ..."
  local start target="$1"
  start=$(__catchEnvironment "$handler" date +%s) || return $?
  while [ ! -d "$target/supervise" ]; do
    sleep 1 || __throwEnvironment "$handler" "interrupted" || return $?
    local elapsed
    elapsed=$(($(__catchEnvironment "$handler" date +%s) - start)) || return $?
    if [ $elapsed -gt "$total" ]; then
      __throwEnvironment "$handler" "supervise is not running - $target/supervise never found after $total seconds" || return $?
    elif [ $elapsed -gt "$stayQuietFor" ]; then
      statusMessage decorate info "Waiting for $(decorate file "$target/supervise") ($elapsed) ..."
    fi
  done
}

#
# Remove a daemontools service by name
#
# Usage: {fn} serviceName
# Argument: serviceName - String. Required. Service name to remove.
daemontoolsRemoveService() {
  local handler="_${FUNCNAME[0]}"
  local serviceHome="" serviceName=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --home)
      shift
      serviceHome=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $?
      ;;
    *)
      if [ -z "$serviceName" ]; then
        serviceName="$1"
      else
        __throwArgument "$handler" "Extra argument $1" || return $?
      fi
      ;;
    esac
    shift
  done

  if [ -z "$serviceHome" ]; then
    __environment buildEnvironmentLoad DAEMONTOOLS_HOME || return $?
    serviceHome="${DAEMONTOOLS_HOME}"
  fi
  [ -d "$serviceHome" ] || __throwEnvironment "$handler" "daemontools home \"$serviceHome\" is not a directory" || return $?
  [ -d "$serviceHome/$serviceName" ] || __throwEnvironment "$handler" "$serviceHome/$serviceName does not exist" || return $?

  __catchEnvironment "$handler" pushd "$serviceHome/$serviceName" >/dev/null || return $?
  __catchEnvironment "$handler" muzzle svc -dx . log 2>&1 || return $?
  __catchEnvironment "$handler" rm -rf "$serviceHome/$serviceName" || return $?
  __catchEnvironment "$handler" popd >/dev/null || return $?
}
_daemontoolsRemoveService() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Is daemontools running?
daemontoolsIsRunning() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"

  local processIds processId

  # IDENTICAL rootUser 1
  [ "$(id -u 2>/dev/null)" = "0" ] || __throwEnvironment "$handler" "Must be root" || return $?

  processIds=()
  while read -r processId; do processIds+=("$processId"); done < <(daemontoolsProcessIds)
  [ 0 -ne "${#processIds[@]}" ] || return 1
  ! kill -0 "${processIds[@]}" || return 0
  return 1
}
_daemontoolsIsRunning() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Print the daemontools service home path
# Exit code: 0 - success
# Exit code: 1 - No environment file found
daemontoolsHome() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local home
  export DAEMONTOOLS_HOME
  __catch "$handler" buildEnvironmentLoad DAEMONTOOLS_HOME || return $?
  printf "%s\n" "${DAEMONTOOLS_HOME-}"
}
_daemontoolsHome() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Launch the daemontools daemon
# Do not use this for production
# Usage: {fn}
# Run the daemontools root daemon
daemontoolsExecute() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  # IDENTICAL rootUser 1
  [ "$(id -u 2>/dev/null)" = "0" ] || __throwEnvironment "$handler" "Must be root" || return $?

  local home
  home="$(__catch "$handler" daemontoolsHome)" || return $?

  usageRequireBinary "$handler" svscanboot id svc svstat || return $?
  __catch "$handler" muzzle directoryRequire --mode 0775 --owner root:root "$home" || return $?
  __catchEnvironment "$handler" muzzle nohup bash -c 'svscanboot &' 2>&1 || return $?
}
_daemontoolsExecute() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List any processes associated with daemontools supervisors
# Requires: pgrep read printf
daemontoolsProcessIds() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  local processIds=() processId
  while read -r processId; do processIds+=("$processId"); done < <(pgrep 'svscan*')
  if [ ${#processIds[@]} -eq 0 ]; then
    return 0
  fi
  printf "%s\n" "${processIds[@]}"
}
_daemontoolsProcessIds() {
  ! false || daemontoolsProcessIds --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Terminate daemontools as gracefully as possible
# Usage: {fn} [ --timeout seconds ]
# Argument: --timeout seconds - Integer. Optional.
# Requires: __throwArgument decorate usageArgumentInteger __throwEnvironment __catchEnvironment usageRequireBinary statusMessage
# Requires: svscanboot id svc svstat
daemontoolsTerminate() {
  local handler="_${FUNCNAME[0]}"

  local timeout=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --timeout)
      shift || __throwArgument "$handler" "missing $argument argument" || return $?
      timeout=$(handlerArgumentInteger "$handler" "seconds" "$1") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home

  # IDENTICAL rootUser 1
  [ "$(id -u 2>/dev/null)" = "0" ] || __throwEnvironment "$handler" "Must be root" || return $?

  home="$(__catchEnvironment "$handler" daemontoolsHome)" || return $?
  home="${home%/}"
  usageRequireBinary "$handler" svscanboot id svc svstat || return $?

  statusMessage decorate warning "Shutting down services ..."
  local service
  while read -r service; do
    service="${service%/}"
    if [ "$service" = "$home" ]; then
      continue
    fi
    statusMessage decorate warning "Shutting down $service ..."
    __catchEnvironment "$handler" svc -dx "$service" || return $?
    [ ! -d "$service/log" ] || __environment svc -dx "$service/log" || return $?
  done < <(find "$home" -maxdepth 1 -type d)
  local processId processIds=()
  while read -r processId; do processIds+=("$processId"); done < <(daemontoolsProcessIds)
  if [ ${#processIds[@]} -eq 0 ]; then
    statusMessage --last decorate warning "daemontools is not running"
  else
    statusMessage decorate warning "Shutting down processes ..."
    printf "%s\n%s\n" "processIds" "$(printf -- "- %s\n" "${processIds[@]}")"
    __catchEnvironment "$handler" processWait --verbose --signals TERM,QUIT,KILL --timeout "$timeout" "${processIds[@]}" || return $?
    local remaining
    remaining="$(daemontoolsProcessIds)"
    if [ -n "$remaining" ]; then
      __throwEnvironment "$handler" "daemontools processes still exist: $remaining" || return $?
    fi
    statusMessage --last decorate success "Terminated daemontools"
  fi
}
_daemontoolsTerminate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
# Restart the daemontools processes from scratch.
# Dangerous. Stops any running services and restarts them.
daemontoolsRestart() {
  local handler="_${FUNCNAME[0]}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home

  # IDENTICAL rootUser 1
  [ "$(id -u 2>/dev/null)" = "0" ] || __throwEnvironment "$handler" "Must be root" || return $?

  home="$(__catchEnvironment "$handler" daemontoolsHome)" || return $?
  home="${home%/}"
  usageRequireBinary "$handler" svscanboot id svc svstat || return $?

  local killLoop foundOne maxLoops

  statusMessage decorate info "Restarting daemontools [$(decorate file "$home")]..."
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
    [ $killLoop -le $maxLoops ] || __throwEnvironment "$handler" "Unable to kill svscan processes after $maxLoops attempts" || return $?
  done
  __catchEnvironment "$handler" pkill svscan -t KILL || return $?
  __catchEnvironment "$handler" svc -dx "$home"/* "$home"/*/log || return $?

  local bootPid

  bootPid="$(
    nohup svscanboot 2>/dev/null &
    printf -- "%d" $!
  )"
  isPositiveInteger "$bootPid" || __throwEnvironment "$handler" "No svscanboot PID: $bootPid [${#bootPid}]" || return $?
  statusMessage decorate warning "Waiting 5 seconds ..."
  sleep 5 || __throwEnvironment "$handler" "Killed during sleep" || return $?
  kill -0 "$bootPid" || __throwEnvironment "$handler" "Unable to signal svscanboot PID $bootPid" || return $?
  __catchEnvironment "$handler" svstat "$home" || return $?
  statusMessage --last decorate success "Successfully restarted daemontools [$bootPid]"
}
_daemontoolsRestart() {
  # __IDENTICAL__ usageDocument 1
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
  local handler="_${FUNCNAME[0]}"

  local services=() files=() actions=()
  local currentActions=("restart") intervalSeconds=10 chirpSeconds=0 statFile="" serviceHome="${DAEMONTOOLS_HOME-}" svcBin statBin service="" file=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --chirp)
      shift
      chirpSeconds=$(usageArgumentPositiveInteger "$handler" chirpSeconds "${1-}") || return $?
      ;;
    --interval)
      shift
      intervalSeconds=$(usageArgumentPositiveInteger "$handler" intervalSeconds "${1-}") || return $?
      ;;
    --stat)
      shift
      [ -z "$statFile" ] || __throwArgument "$handler" "$argument must be specified once ($statFile and ${1-})" || return $?
      statFile=$(usageArgumentFileDirectory "$handler" "statFile" "${1-}") || return $?
      ;;
    --home)
      shift
      serviceHome=$(usageArgumentDirectory "$handler" "serviceHome" "${1-}") || return $?
      ;;
    --action)
      shift
      IFS="," read -r -a currentActions <<<"$1" || :
      [ ${#currentActions[@]} -gt 0 ] || __throwArgument "$handler" "$argument No actions specified"
      for action in "${currentActions[@]}"; do
        case "$action" in start | restart | stop) ;; *) __throwArgument "$handler" "Invalid action $action" || return $? ;; esac
      done
      ;;
    *)
      if [ -z "$service" ]; then
        service="$1"
        [ -d "$service" ] || __throwEnvironment "$handler" "service must be a service directory that exists: $service" || return $?
      else
        file="$1"
        [ -d "$(dirname "$file")" ] || __throwEnvironment "$handler" "file must be in a directory that exists: $file" || return $?
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

  __catch "$handler" buildEnvironmentLoad DAEMONTOOLS_HOME || return $?

  usageRequireBinary "$handler" svc svstat || return $?

  svcBin=$(__catchEnvironment "$handler" which svc) || return $?
  statBin=$(__catchEnvironment "$handler" which svstat) || return $?

  [ "${#services[@]}" -gt 0 ] || __throwArgument "$handler" "Need at least one service and file pair" || return $?

  local start lastChirp

  start=$(__catchEnvironment "$handler" date +%s) || return $?
  lastChirp=$start
  printf "%s: pid %d: (every %d %s)\n" "$(basename "${BASH_SOURCE[0]}")" "$$" "$intervalSeconds" "$(plural "$intervalSeconds" second seconds)"

  local index=0
  while [ $index -lt ${#files[@]} ]; do
    printf "    service: %s file: %s actions: %s\n" "${services[$index]}" "${files[$index]}" "${actions[$index]}"
    index=$((index + 1))
  done
  while true; do
    if [ -n "$statFile" ]; then
      statFile=$(usageArgumentFileDirectory "$handler" "statFile" "$statFile") || return $?
      __catchEnvironment "$handler" "$statBin" "$serviceHome/*" "$serviceHome/*/log" >"$statFile" || return $?
    fi
    index=0
    while [ $index -lt ${#files[@]} ]; do
      local service="${services[$index]}" file="${files[$index]}" action=${actions[$index]} directory fileAction svcBinFlags
      index=$((index + 1))
      directory="$(dirname "$file")"
      [ -d "$directory" ] || __throwEnvironment "$handler" "Parent directory deleted, exiting: $directory" || return $?
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
          __throwEnvironment "$handler" "Unable to control service $service ($svcBinFlags)" || return $?
        fi
      fi
      rm -f "$file" "$file.svc" 2>/dev/null
    done
    # Does this work?
    if ! sleep "$intervalSeconds"; then
      statusMessage --last printf -- "%s\n%s%s\n" "$(decorate reset --)" "$(decorate warning "Interrupt")"
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
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
