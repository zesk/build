#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# process-related tools
#
# Test: o test/tools/process-tests.sh
# Docs: o docs/_templates/tools/process.md

#
# status to stdout
#
_processSignal() {
  local signal="$1"
  local signals

  shift || _argument "missing signal" || return $?
  signals=()
  while [ $# -gt 0 ]; do
    if kill "-$signal" "$1" 2>/dev/null; then
      signals+=("$1")
    fi
    shift
  done
  [ ${#signals[@]} -eq 0 ] && return 0
  printf "%s\n" "${signals[@]}"
}

# Wait for processes not owned by this process to exit, and send signals to terminate processes.
#
# Usage: {fn} processId ...
# Argument: processId - Integer. Required. Wait for process ID to exit.
# Argument: --timeout seconds - Integer. Optional. Wait for this long after sending a signals to see if a process exits. If not supplied waits 1 second after each signal, then waits forever.
# Argument: --signals signal - List of strings. Optional. Send each signal to processes, in order.
# Argument: --require - Flag. Optional. Require all processes to be alive upon first invocation.
#
processWait() {
  local usage this argument
  local start elapsed lastSignal sinceLastSignal now
  local timeout signalTimeout
  local signals signal sendSignals
  local processIds aliveIds
  local requireFlag verboseFlag signals signal
  local STATUS_THRESHOLD=10
  local processTemp

  this="${FUNCNAME[0]}"
  usage="_$this"

  processIds=()
  requireFlag=false
  verboseFlag=false
  timeout=-1
  signalTimeout=1
  signals=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --require)
        requireFlag=true
        ;;
      --verbose)
        verboseFlag=true
        ;;
      --signals)
        shift || __failArgument "$usage" "Missing $argument argument" || return $?
        IFS=',' read -r -a signals < <(uppercase "$1")
        for signal in "${signals[@]}"; do
          case "$signal" in
            STOP | QUIT | INT | KILL | HUP | ABRT | TERM) ;;
            *)
              __failArgument "$usage" "Invalid signal $signal" || return $?
              ;;
          esac
        done
        ;;
      --timeout)
        shift || __failArgument "$usage" "Missing $argument" || return $?
        timeout=$(usageArgumentInteger "$usage" "timeout" "$1") || return $?
        signalTimeout=$timeout
        ;;
      *)
        processId=$(usageArgumentInteger "$usage" "processId" "$1") || return $?
        processIds+=("$processId")
        ;;
    esac
    shift || __failArgument "$usage" "shift failed after $argument"
  done
  if [ 0 -eq ${#processIds[@]} ]; then
    __failArgument "$usage" "Requires at least one processId" || return $?
  fi

  start=$(date +%s) || __failEnvironment "$usage" "date failed" || return $?
  sendSignals=("${signals[@]+"${signals[@]}"}")
  lastSignal=0
  elapsed=0
  processTemp=$(mktemp)
  while [ ${#processIds[@]} -gt 0 ]; do
    __environment _processSignal 0 "${processIds[@]}" >"$processTemp" || return $?
    # Reset aliveIds, load them from _processSignal
    aliveIds=()
    while read -r processId; do ! isInteger "$processId" || aliveIds+=("$processId"); done <"$processTemp"
    rm -f "$processTemp" || :
    if $requireFlag; then
      # First - check --required - all processes must be running
      # And ensure they match (all processes running) and then clear the requireFlag
      if [ ${#processIds[@]} -ne ${#aliveIds[@]} ]; then
        __failEnvironment "$usage" "All processes must be alive to start: ${processIds[*]} (Alive: ${aliveIds[*]-none})" || return $?
      fi
      # Just the first time
      requireFlag=false
    fi
    processIds=("${aliveIds[@]+"${aliveIds[@]}"}")
    if [ "${#processIds[@]}" -eq 0 ]; then
      break
    fi
    now=$(date +%s)
    elapsed=$((now - start))
    sinceLastSignal=$((now - lastSignal))
    if [ "$sinceLastSignal" -gt "$signalTimeout" ]; then
      if [ ${#sendSignals[@]} -gt 0 ]; then
        signal="${sendSignals[0]}"
        unset 'sendSignals[0]'
        sendSignals=("${sendSignals[@]}")
        # Reset aliveIds, load them from _processSignal
        ! $verboseFlag || statusMessage consoleInfo "Sending $(consoleLabel "$signal") to $(IFS=, consoleCode "${processIds[*]}")"
        __environment _processSignal "$signal" "${processIds[@]}" >"$processTemp" || return $?
        aliveIds=()
        while read -r processId; do ! isInteger "$processId" || aliveIds+=("$processId"); done <"$processTemp"
        ! $verboseFlag && IFS=, statusMessage consoleInfo "Processes: ${processIds[*]} -> Alive: $(IFS=, consoleCode "${aliveIds[*]-none}")"
      fi
      lastSignal=$now
      sinceLastSignal=0
    fi
    if [ "$timeout" -gt 0 ] && [ "$sinceLastSignal" -ge "$timeout" ] && [ ${#sendSignals[@]} -eq 0 ]; then
      __failEnvironment "$usage" "Expired after $elapsed $(plural "$elapsed" second seconds) (timeout: $timeout, signals: ${signals[*]-wait}) Alive: ${aliveIds[*]-none}" || return $?
    fi
    if [ "$elapsed" -gt "$STATUS_THRESHOLD" ] || $verboseFlag; then
      statusMessage consoleInfo "$this ${processIds[*]} (${sendSignals[*]-wait}, $sinceLastSignal) - $elapsed seconds"
    fi
    sleep 1 || __failEnvironment "$usage" "sleep interrupted" || return $?
  done
  if [ "$elapsed" -gt "$STATUS_THRESHOLD" ] || $verboseFlag; then
    clearLine
  fi
}
_processWait() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
