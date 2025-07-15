#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
  local usage="_${FUNCNAME[0]}"

  local processIds=() requireFlag=false verboseFlag=false timeout=-1 signalTimeout=1 signals=()

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

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
    --require)
      requireFlag=true
      ;;
    --verbose)
      verboseFlag=true
      ;;
    --signals)
      shift || __throwArgument "$usage" "missing $argument argument" || return $?
      IFS=',' read -r -a signals < <(uppercase "$1")
      for signal in "${signals[@]}"; do
        case "$signal" in
        STOP | QUIT | INT | KILL | HUP | ABRT | TERM) ;;
        *)
          __throwArgument "$usage" "Invalid signal $signal" || return $?
          ;;
        esac
      done
      ;;
    --timeout)
      shift || __throwArgument "$usage" "missing $argument" || return $?
      timeout=$(usageArgumentInteger "$usage" "timeout" "$1") || return $?
      signalTimeout=$timeout
      ;;
    *)
      processId=$(usageArgumentInteger "$usage" "processId" "$1") || return $?
      processIds+=("$processId")
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local elapsed lastSignal sinceLastSignal now
  local timeout signalTimeout
  local signals signal
  local processId processIds aliveIds
  local requireFlag verboseFlag signals signal
  local STATUS_THRESHOLD=10
  local processTemp

  if [ 0 -eq ${#processIds[@]} ]; then
    __throwArgument "$usage" "Requires at least one processId" || return $?
  fi

  local start sendSignals sendSignals=("${signals[@]+"${signals[@]}"}") lastSignal=0 elapsed=0 processTemp

  start=$(date +%s) || __throwEnvironment "$usage" "date failed" || return $?

  processTemp=$(fileTemporaryName "$usage") || return $?
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
        __throwEnvironment "$usage" "All processes must be alive to start: ${processIds[*]} (Alive: ${aliveIds[*]-none})" || return $?
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
        ! $verboseFlag || statusMessage decorate info "Sending $(decorate label "$signal") to $(IFS=, decorate code "${processIds[*]}")"
        __environment _processSignal "$signal" "${processIds[@]}" >"$processTemp" || return $?
        aliveIds=()
        while read -r processId; do ! isInteger "$processId" || aliveIds+=("$processId"); done <"$processTemp"
        ! $verboseFlag && IFS=, statusMessage decorate info "Processes: ${processIds[*]} -> Alive: $(IFS=, decorate code "${aliveIds[*]-none}")"
      fi
      lastSignal=$now
      sinceLastSignal=0
    fi
    if [ "$timeout" -gt 0 ] && [ "$sinceLastSignal" -ge "$timeout" ] && [ ${#sendSignals[@]} -eq 0 ]; then
      __throwEnvironment "$usage" "Expired after $elapsed $(plural "$elapsed" second seconds) (timeout: $timeout, signals: ${signals[*]-wait}) Alive: ${aliveIds[*]-none}" || return $?
    fi
    if [ "$elapsed" -gt "$STATUS_THRESHOLD" ] || $verboseFlag; then
      statusMessage decorate info "${usage#_} ${processIds[*]} (${sendSignals[*]-wait}, $sinceLastSignal) - $elapsed seconds"
    fi
    sleep 1 || __throwEnvironment "$usage" "sleep interrupted" || return $?
  done
  if [ "$elapsed" -gt "$STATUS_THRESHOLD" ] || $verboseFlag; then
    statusMessage --last decorate warning "$elapsed $(plural "$elapsed" second seconds) elapsed (threshold is $(decorate code "$STATUS_THRESHOLD"))"
  fi
}
_processWait() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Outputs value of resident memory used by a process, value is in kilobytes
#
# Usage: {fn} pid
# Argument: pid - Process ID of running process
# Example:     > {fn} 23
# Output: 423
# Exit Code: 0 - Success
# Exit Code: 2 - Argument error
processMemoryUsage() {
  local usage="_${FUNCNAME[0]}"
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
    *)
      local pid="$argument"
      __catchArgument "$usage" isInteger "$pid" || return $?
      # ps -o '%cpu %mem pid vsz rss tsiz %mem comm' -p "$pid" | tail -n 1
      value="$(ps -o rss -p "$pid" | tail -n 1 | trimSpace)" || __throwEnvironment "$usage" "Failed to get process status for $pid" || return $?
      isInteger "$value" || __throwEnvironment "$usage" "Bad memory value for $pid: $value" || return $?
      printf %d $((value * 1))
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_processMemoryUsage() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Outputs value of virtual memory allocated for a process, value is in kilobytes
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: pid - Process ID of running process
# Example:     {fn} 23
# Output: 423
# Exit Code: 0 - Success
# Exit Code: 2 - Argument error
processVirtualMemoryAllocation() {
  local usage="_${FUNCNAME[0]}"
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
    *)
      local pid="$argument" value
      __catchArgument "$usage" isInteger "$pid" || return $?
      value="$(ps -o vsz -p "$pid" | tail -n 1 | trimSpace)"
      isInteger "$value" || __throwEnvironment "$usage" "ps returned non-integer: \"$(decorate code "$value")\"" || return $?
      printf %d $((value * 1))
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_processVirtualMemoryAllocation() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# TODO: This is in progress
# Output the number of open files for a process ID or group
# Not completed yet
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
processOpenPipes() {
  local usage="_${FUNCNAME[0]}"
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
    *)
      local pid
      pid="$(usageArgumentInteger "$usage" "pid" "$argument")" || return $?
      lsof -c 9999 -g "$pid" -l -F ckns
      # -c n - character width of COMMAND output
      # -F field format
      # -g pid | -p pid - process or group to list
      # -l - Do not translate uid to login
      # -n - Do not translate IPs to names
      # -s - Show SIZE always
      # -s - Show SIZE always
      ;;

    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_processOpenPipes() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# lsof
# Fields
#
#    a    file access mode
#    c    process command name (all characters from proc or
#        user structure)
#    C    file structure share count
#    d    file's device character code
#    D    file's major/minor device number (0x<hexadecimal>)
#    f    file descriptor
#    F    file structure address (0x<hexadecimal>)
#    G    file flaGs (0x<hexadecimal>; names if +fg follows)
#    i    file's inode number
#    k    link count
#    l    file's lock status
#    L    process login name
#    m    marker between repeated output
#    n    file name, comment, Internet address
#    N    node identifier (ox<hexadecimal>
#    o    file's offset (decimal)
#    p    process ID (always selected)
#    g    process group ID
#    P    protocol name
#    r    raw device number (0x<hexadecimal>)
#    R    parent process ID
#    s    file's size (decimal)
#    S    file's stream identification
#    t    file's type
#    T    TCP/TPI information, identified by prefixes (the
#        '=' is part of the prefix):
#            QR=<read queue size>
#            QS=<send queue size>
#            SO=<socket options and values> (not all dialects)
#            SS=<socket states> (not all dialects)
#            ST=<connection state>
#            TF=<TCP flags and values> (not all dialects)
#            WR=<window read size>  (not all dialects)
#            WW=<window write size>  (not all dialects)
#        (TCP/TPI information isn't reported for all supported
#          UNIX dialects. The -h or -? help output for the
#          -T option will show what TCP/TPI reporting can be
#          requested.)
#    u    process user ID
#    z    Solaris 10 and higher zone name
#    Z    SELinux security context (inhibited when SELinux is disabled)
#    0    use NUL field terminator character in place of NL
#    1-9    dialect-specific field identifiers (The output
#        of -F? identifies the information to be found
#        in dialect-specific fields.)
