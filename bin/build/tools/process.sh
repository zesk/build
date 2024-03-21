#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# process-related tools
#
# Test: o test/tools/process-tests.sh
# Docs: o docs/_templates/tools/process.md

# Wait for processes not owned by this process to exit.
#
# Usage: {fn} processId ...
# Argument: processId - Integer. Required. Wait for process ID to exit.
# Argument: --timeout seconds - Integer. Optional. Wait for this long. If not supplied waits forever (but displays a status message to `stdout` after 10 seconds)
# Argument: --require - Flag. Optional. Require all processes to be alive upon first invocation.
#
processWait() {
  local usage this argument
  local start elapsed timeout processIds aliveIds
  local requireFlag

  this="${FUNCNAME[0]}"
  usage="_$this"

  processIds=()
  requireFlag=false
  timeout=-1
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --require)
        requireFlag=true
        ;;
      --timeout)
        shift || __failArgument "$usage" "Missing $argument" || return $?
        timeout=$(usageArgumentInteger "$usage" "timeout" "$1") || return $?
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

  elapsed=0
  start=$(date +%s) || __failEnvironment "$usage" "date failed" || return $?
  while [ ${#processIds[@]} -gt 0 ]; do
    aliveIds=()
    elapsed=$(($(date +%s) - start))
    for processId in "${processIds[@]}"; do
      if kill -0 "$processId" 2>/dev/null; then
        aliveIds+=("$processId")
      else
        consoleInfo "Process $processId terminated after $elapsed $(plural "$elapsed" second seconds)"
      fi
    done
    if $requireFlag; then
      if [ ${#processIds[@]} -ne ${#aliveIds[@]} ]; then
        __failEnvironment "$usage" "All processes must be alive to start: ${processIds[*]}" || return $?
      fi
      # Just the first time
      requireFlag=false
    fi
    processIds=("${aliveIds[@]}")
    if [ "$timeout" -gt 0 ] && [ "$elapsed" -ge "$timeout" ]; then
      __failEnvironment "$usage" "timeout of $elapsed $(plural "$elapsed" second seconds) expired. Alive: ${aliveIds[*]}" || return $?
    fi
    if [ "$elapsed" -gt 10 ]; then
      statusMessage consoleInfo "$this ${processIds[*]} - $elapsed seconds"
    fi
  done
  if [ "$elapsed" -gt 10 ]; then
    clearLine
  fi
}
_processWait() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
