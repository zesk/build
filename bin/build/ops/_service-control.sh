#!/usr/bin/env bash
#
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

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

# Runs a daemon which monitors
#
# Usage: {fn} {service} [ --interval seconds ] {file} [ action ... ]
# Argument: --interval intervalSeconds - Number of seconds to check for presence of the file
# Argument: --chirp chirpSeconds - Output a message saying we're alive every `chirpSeconds` seconds.
# Argument: service - Required. Directory. Service to control (e.g. `/etc/service/application/`)
# Argument: file - Required. File. Absolute path to a file. Presence of  `file` triggers `action`
# Argument: action - Optional. String. Action to perform `start`, `stop`, `restart`. Default is `restart`.
#
serviceControlDaemon() {
  local lastChirp now intervalSeconds chirpSeconds service file directory svcBin secondsNoun
  local fileAction action defaultAction action_start action_stop action_restart

  file=
  defaultAction=
  action_start=
  action_stop=
  action_restart=
  actions=()
  intervalSeconds=1
  chirpSeconds=0
  ! test "" || printf "%s" "$action_start $action_stop $action_restart"

  if ! svcBin=$(which svc); then
    _serviceControlDaemonUsage "$errorEnvironment" "svc binary not found in PATH: $PATH"
    return $?
  fi

  while [ $# -gt 0 ]; do
    case "$1" in
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
      *)
        if [ -z "$service" ]; then
          service="$1"
          if [ ! -d "$service" ]; then
            _serviceControlDaemonUsage "$errorEnvironment" "service must be a service directory that exists: $service"
            return $?
          fi
        elif [ -z "$file" ]; then
          file="$1"
          directory="$(dirname "$file")"
          if [ ! -d "$directory" ]; then
            _serviceControlDaemonUsage "$errorEnvironment" "file must be in a directory that exists: $file"
            return $?
          fi
        else
          case "$1" in
            stop | start | restart)
              action="action_$1"
              if ! test "${!action}"; then
                actions+=("$1")
                declare -i "$action"=1
                if [ -z "$defaultAction" ]; then
                  defaultAction=$action
                fi
              fi
              ;;
            *)
              _serviceControlDaemonUsage "$errorArgument" "Action must start, stop or restart: $1"
              return $?
              ;;
          esac
        fi
        ;;
    esac
  done
  if [ -z "$defaultAction" ]; then
    defaultAction=restart
    action_restart=1
    actions+=("$defaultAction")
  fi
  start=$(date +%s)
  lastChirp=$start
  secondsNoun=seconds
  if [ "$intervalSeconds" -eq 1 ]; then
    secondsNoun=second
  fi
  printf "%s: pid %d: service %s, file %s for: %s (every %d %s)\n" "$$" "$(basename "${BASH_SOURCE[0]}")" "$service" "$file" "$intervalSeconds" "${actions[*]}" "$secondsNoun"
  while true; do
    if [ ! -d "$directory" ]; then
      _serviceControlDaemonUsage $errorEnvironment "Parent directory deleted, exiting: $directory"
      return $errorEnvironment
    fi
    if [ -f "$file" ]; then
      fileAction="$(head -1 "$file")"
      case "$fileAction" in start | stop | restart) ;; *) fileAction="restart" ;; esac
      action="action_$fileAction"
      if ! test "${!action}"; then
        printf "%s requested but not permitted: %s\n" "$fileAction" "${actions[*]}" 1>&2
      else
        printf "start=%s\n""action=%s\n""daemon=%d\n""service=%s\n" "$(date +%s)" "$fileAction" "$$" "$service" >"$file.svc"
        printf "Service %s: %s\n" "$fileAction" "$(basename "$service")"
        case $fileAction in
          stop)
            "$svcBin" -d "$service"
            ;;
          start)
            "$svcBin" -u "$service"
            ;;
          *)
            "$svcBin" -t "$service"
            ;;
        esac
      fi
      rm -f "$file" "$file.svc" 2>/dev/null
    fi
    sleep "$intervalSeconds"
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
