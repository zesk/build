#!/usr/bin/env bash
#
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL DAEMONTOOLS_HOME 2
export DAEMONTOOLS_HOME
DAEMONTOOLS_HOME=${DAEMONTOOLS_HOME-/etc/service}

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

_serviceControlDaemonUsage() {
  local errorCode="${1-0}"
  shift || :
  printf "ERROR: #$errorCode - %s\n" "$*" 1>&2
  return "$errorCode"
}

# Runs a daemon which monitors files and operates on services.
#
# To request a specific action write the file with the action as the first line.
#
# Allows control across user boundaries.
#
# Specify actions more than once on the command line to specify more than one set of permissions.
#
# Usage: {fn} [ --interval seconds ] [ --stat statFile ] [ --action actions ] service0 file0 [ service1 file1 ]
# Argument: --home serviceHome - Optional. Service directory home. Defaults to `/etc/service`.
# Argument: --interval intervalSeconds - Optional. Number of seconds to check for presence of the file. Defaults to 10.
# Argument: --stat statFile - Optional. Output the `svstat` status to this file every `intervalSeconds`. If not specified nothing is output.
# Argument: --chirp chirpSeconds - Optional. Output a message saying we're alive every `chirpSeconds` seconds.
# Argument: --action actions - Optional. String. Onr or more actions permitted `start`, `stop`, `restart`, use comma to separate. Default is `restart`.
# Argument: service0 - Required. Directory. Service to control (e.g. `/etc/service/application/`)
# Argument: file1 - Required. File. Absolute path to a file. Presence of  `file` triggers `action`
#
serviceControlDaemon() {
  local intervalSeconds chirpSeconds statFile serviceHome
  local directory svcBin svcBinFlags secondsNoun
  local lastChirp now
  local fileAction index
  local currentActions action
  local services files actions

  services=()
  files=()
  actions=()

  currentActions=("restart")
  intervalSeconds=10
  chirpSeconds=0
  statFile=
  serviceHome="$DAEMONTOOLS_HOME"
  if ! svcBin=$(which svc); then
    _serviceControlDaemonUsage "$errorEnvironment" "svc binary not found in PATH: $PATH"
    return $?
  fi

  while [ $# -gt 0 ]; do
    arg="$1"
    case "$arg" in
      --chirp)
        shift
        chirpSeconds=$((${1-0} + 0))
        if [ "$chirpSeconds" -le 0 ]; then
          _serviceControlDaemonUsage "$errorArgument" "Chirp \"$1\" must be an integer greater than zero"
          return $?
        fi
        ;;
      --interval)
        shift
        intervalSeconds=$((${1-0} + 0))
        if [ "$intervalSeconds" -le 0 ]; then
          _serviceControlDaemonUsage "$errorArgument" "Seconds \"$1\" must be an integer greater than zero"
          return $?
        fi
        ;;
      --stat)
        if [ -n "$statFile" ]; then
          _serviceControlDaemonUsage "$errorArgument" "--stat must be specified once $statFile and $1"
          return $?
        fi
        shift
        statFile="$1"
        if [ ! -d "$(dirname "$statFile")" ]; then
          _serviceControlDaemonUsage "$errorEnvironment" "--stat must be in a directory that exists: $statFile"
          return $?
        fi
        ;;
      --home)
        shift
        serviceHome="$1"
        if [ ! -d "$serviceHome" ]; then
          _serviceControlDaemonUsage "$errorEnvironment" "--home must be a directory that exists: $serviceHome"
          return $?
        fi
        ;;
      --action)
        shift
        IFS="," read -r -a currentActions <<<"$1"
        if [ ${#currentActions[@]} -eq 0 ]; then
          _serviceControlDaemonUsage "$errorArgument" "$arg No actions specified"
          return $?
        fi
        for action in "${currentActions[@]}"; do
          case $action in start | restart | stop) ;; *)
            _serviceControlDaemonUsage "$errorArgument" "Invalid action $action"
            return $?
            ;;
          esac
        done
        ;;
      *)
        if [ -z "$service" ]; then
          service="$1"
          if [ ! -d "$service" ]; then
            _serviceControlDaemonUsage "$errorEnvironment" "service must be a service directory that exists: $service"
            return $?
          fi
        else
          file="$1"
          if [ ! -d "$(dirname "$file")" ]; then
            _serviceControlDaemonUsage "$errorEnvironment" "file must be in a directory that exists: $file"
            return $?
          fi
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
  if [ "${#services[@]}" -eq 0 ]; then
    _serviceControlDaemonUsage "$errorArgument" "Need at least one service and file pair"
    return $?
  fi
  start=$(date +%s)
  lastChirp=$start
  secondsNoun=seconds
  if [ "$intervalSeconds" -eq 1 ]; then
    secondsNoun=second
  fi
  printf "%s: pid %d: (every %d %s)\n" "$(basename "${BASH_SOURCE[0]}")" "$$" "$intervalSeconds" "$secondsNoun"
  index=0
  while [ $index -lt ${#files[@]} ]; do
    printf "    service: %s file: %s actions: %s\n" "${services[$index]}" "${files[$index]}" "${actions[$index]}"
    index=$((index + 1))
  done
  while true; do
    if [ -n "$statFile" ]; then
      svstat "$serviceHome/*" "$serviceHome/*/log"
    fi
    index=0
    while [ $index -lt ${#files[@]} ]; do
      service="${services[$index]}"
      file="${files[$index]}"
      action=${actions[$index]}
      index=$((index + 1))
      directory="$(dirname "$file")"
      if [ ! -d "$directory" ]; then
        _serviceControlDaemonUsage $errorEnvironment "Parent directory deleted, exiting: $directory"
        return $errorEnvironment
      fi
      if [ ! -f "$file" ]; then
        continue
      fi
      fileAction="$(head -1 "$file")"
      case "$fileAction" in start | stop | restart) ;; *) fileAction="restart" ;; esac
      IFS=" " read -r -a currentActions <<<"$action"
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
          _serviceControlDaemonUsage $errorEnvironment "Unable to control service $service ($svcBinFlags)"
          return $errorEnvironment
        fi
      fi
      rm -f "$file" "$file.svc" 2>/dev/null
    done
    # Does this work?
    if ! sleep "$intervalSeconds"; then
      break
    fi
    if [ "$chirpSeconds" -gt 0 ]; then
      now=$(date +%s)
      if [ "$((now - lastChirp))" -gt "$chirpSeconds" ]; then
        printf "pid %d: %s has been alive for %d seconds\n" "$$" "${BASH_SOURCE[0]}" "$((now - start))"
        lastChirp=$now
      fi
    fi
  done
}

serviceControlDaemon "$@"
