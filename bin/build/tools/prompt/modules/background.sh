#!/usr/bin/env bash
#
# Bash Prompt Module: background
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Directory where we store everything
__backgroundProcessCache() {
  local handler="$1" && shift
  __catch "$handler" buildEnvironmentGetDirectory --subdirectory "${FUNCNAME[0]}" XDG_CACHE_HOME || return $?
}

# Main API interface to this feature
# Run a single process in the background continuously until a condition is met.
__backgroundProcess() {
  local handler="$1" && shift
  local condition=() command=()
  local stopSeconds=0 waitSeconds=5 frequency=60
  local actionFlag="" verboseFlag=false vv=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --watch) actionFlag="watch" ;;
    --summary) actionFlag="summary" ;;
    --monitor) actionFlag="monitor" ;;
    --report) actionFlag="report" ;;
    --terminate) actionFlag="stop-all" ;;
    --verbose) verboseFlag=true && vv=("$argument") ;;
    --quiet) verboseFlag=false && vv=() ;;
    --verbose-toggle) actionFlag="verbose-toggle" ;;
    --stop) shift && stopSeconds=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $? ;;
    --wait) shift && waitSeconds=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $? ;;
    --frequency) shift && frequency=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $? ;;
    --go) actionFlag="go" ;;
    *)
      if [ 0 -eq ${#condition[@]} ]; then
        actionFlag="condition"
        condition=("$(usageArgumentCallable "$handler" "condition" "$argument")") || return $?
        shift
        while [ $# -gt 0 ] && [ "$1" != '--' ]; do condition+=("$1") && shift; done
        # Get that --
        [ $# -gt 0 ] || __throwArgument "$handler" "No command passed: [$__count] $(decorate each quote -- "${__saved[@]}")" || return $?
      else
        shift
        command=("$(usageArgumentCallable "$handler" "command" "$argument")" "$@") || return $?
        break
      fi
      ;;
    esac
    shift
  done
  local home
  home=$(__catch "$handler" buildHome) || return $?

  local cache
  cache=$(__backgroundProcessCache "$handler") || return $?

  [ -n "$actionFlag" ] || actionFlag="summary"
  case "$actionFlag" in
  "verbose-toggle")
    if [ -f "$cache/verbose" ]; then
      __catchEnvironment "$handler" rm -f "$cache/verbose" || return $?
      decorate info "Verbose mode is off."
    else
      decorate info "Verbose mode is ON."
      __catchEnvironment "$handler" touch "$cache/verbose" || return $?
    fi
    return 0
    ;;
  "monitor")
    loopExecute --title "Background Process Monitor" --until 1 --delay 5 "$home/bin/build/tools.sh" backgroundProcess --report
    return 0
    ;;
  "watch")
    local x y temp lines
    temp=$(fileTemporaryName "$handler") || return $?
    while true; do
      backgroundProcess --summary | tee "$temp" || break
      lines=$(fileLineCount "$temp") || break
      IFS=$'\n' read -d '' -r x y < <(cursorGet) || :
      sleep 2 || break
      cursorSet "$x" "$((y - lines))" || break
    done
    __catchEnvironment "$handler" rm -f "$temp" || return $?
    return 0
    ;;
  "stop-all")
    if [ -f "$cache/main.pid" ]; then
      local pid

      pid="$(cat "$cache/main.pid")"
      if isPositiveInteger "$pid"; then
        if ! kill -TERM "$pid" 2>/dev/null; then
          ! $verboseFlag || decorate error "Killing [$pid] failed"
        else
          ! $verboseFlag || decorate notice "Main manager terminated [$pid]"
        fi
      fi
      rm -f "$cache/main.pid" || :
    else
      ! $verboseFlag || decorate notice "No main background process."
    fi
    if [ -d "$cache/process/" ]; then
      while read -r processDirectory; do
        __backgroundProcessKill "$handler" "$processDirectory" "$verboseFlag"
      done < <(find "$cache/process/" -maxdepth 1 -mindepth 1 -type d)
    else
      ! $verboseFlag || decorate notice "No background processes registered."
    fi
    __catchEnvironment "$handler" rm -rf "$cache" || return $?
    bashPrompt --skip-prompt --remove __bashPromptModule_Background 2>/dev/null || :
    return 0
    ;;
  "go")
    __catch "$handler" __bashPromptModule_Background "${vv[@]+"${vv[@]}"}" || return $?
    return 0
    ;;
  "summary")
    local now
    now=$(timingStart)
    __backgroundMainSummary "$handler" "$now" "$cache"
    if [ -d "$cache/process/" ]; then
      while read -r processDirectory; do
        __backgroundProcessSummary "$handler" "$now" "$processDirectory"
      done < <(find "$cache/process/" -maxdepth 1 -mindepth 1 -type d)
    else
      decorate notice "No background processes registered."
    fi
    return 0
    ;;
  "report")
    local now
    now=$(timingStart)
    __backgroundMainReport "$handler" "$now" "$cache"
    if [ -d "$cache/process/" ]; then
      while read -r processDirectory; do
        __backgroundProcessReport "$handler" "$now" "$processDirectory"
      done < <(find "$cache/process/" -maxdepth 1 -mindepth 1 -type d)
    fi
    return 0
    ;;
  "condition") ;;
  *) __throwEnvironment "$handler" "Unknown actionFlag? $actionFlag" || return $? ;;
  esac

  [ ${#condition[@]} -gt 0 ] || __throwArgument "$handler" "Requires a condition" || return $?
  [ ${#command[@]} -gt 0 ] || __throwArgument "$handler" "Requires a command" || return $?

  local id
  id=$(__catch "$handler" shaPipe <<<"${condition[*]} ${command[*]}") || return $?
  __catch "$handler" muzzle directoryRequire "$cache/process/$id" || return $?
  {
    __catch "$handler" environmentValueWrite home "$home" || return $?
    __catch "$handler" environmentValueWriteArray condition "${condition[@]}" || return $?
    __catch "$handler" environmentValueWriteArray command "${command[@]}" || return $?
    __catch "$handler" environmentValueWrite id "$id" || return $?
    __catch "$handler" environmentValueWrite created "$(timingStart)" || return $?
    __catch "$handler" environmentValueWrite stopSeconds "$stopSeconds" || return $?
    __catch "$handler" environmentValueWrite waitSeconds "$waitSeconds" || return $?
    __catch "$handler" environmentValueWrite frequency "$frequency" || return $?
  } >"$cache/process/$id/state" || return $?
  __catchEnvironment "$handler" printf "%s\n" "$(timingStart) created by $(id -u) on $(uname -a)" >"$cache/process/$id/log" || return $?
  __catch "$handler" bashPrompt --skip-prompt --first __bashPromptModule_Background || return $?
  ! $verboseFlag || statusMessage --last decorate info "Registered background process $(decorate each code "${command[*]}") $(decorate code "[${id:0:6}]") "
}

# Runs background processes continuously until a condition is met.
# Manage processes with `backgroundProcess`
#
__bashPromptModule_Background() {
  local handler="_${FUNCNAME[0]}" verboseFlag=false

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local cache threshold=""

  cache=$(__backgroundProcessCache "$handler") || return $?

  [ ! -f "$cache/threshold" ] || threshold="$(cat "$cache/threshold")"

  local verboseFlag=false
  [ ! -f "$cache/verbose" ] || verboseFlag=true
  ! inArray "--verbose" "$@" || verboseFlag=true

  isPositiveInteger "$threshold" || threshold=30

  (
    local pid="" alive=""
    [ ! -f "$cache/main.pid" ] || pid=$(cat "$cache/main.pid")
    [ ! -f "$cache/main.alive" ] || alive=$(cat "$cache/main.alive")
    local delta=$(((now - alive) / 1000))
    if kill -0 "$pid" 2>/dev/null; then
      if [ -n "$alive" ] && [ "$delta" -lt "$threshold" ]; then
        ! $verboseFlag || statusMessage decorate notice "Background process monitor already running as pid $pid"
        return 0
      fi
    else
      __catchEnvironment "$handler" rm -f "$d/main.pid" "$d/main.alive" || return $?
    fi
    ! $verboseFlag || statusMessage decorate success "Launching background main ... PID: "
    __backgroundMain "$handler" "$cache" "$verboseFlag" "$threshold" 2>>"$cache/main.err" &
    disown
  )
}
___bashPromptModule_Background() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Daemon which runs the other background processes
# - ./main.pid - Integer. Process ID.
# - ./main.alive - Integer. Millisecond timestamp.
# - ./main.elapsed - Float. Time elapsed to manage all background process in a loop.
# - ./main.err - `stderr` of main process
# - ./main.out - `stdout` of main process
# - ./verbose - If exists, be verbose.
# - ./threshold - Seconds after which main process is considered "not alive" and we kill it and restart it.
__backgroundMain() {
  local handler="$1" d="$2" verboseFlag="$3" aliveThreshold="$4" && shift 4

  local pid="" now alive=""
  now=$(timingStart)
  [ ! -f "$d/main.pid" ] || pid=$(cat "$d/main.pid")
  [ ! -f "$d/main.alive" ] || alive=$(cat "$d/main.alive")
  if isPositiveInteger "$pid"; then
    local delta=$(((now - alive) / 1000))
    if kill -0 "$pid" 2>/dev/null; then
      if [ -z "$alive" ] || [ $delta -gt "$aliveThreshold" ]; then
        decorate error "Background main frozen? Killing $pid and restarting alive $(__nowRelative "$now" "$alive") ($delta > threshold $aliveThreshold)"
        __catchEnvironment "$handler" kill -TERM "$pid" || :
        __catchEnvironment "$handler" rm -f "$d/main.pid" "$d/main.alive" || return $?
      else
        ! $verboseFlag || decorate info "Main process ID is $pid - and is alive ($(__nowRelative "$now" "$alive") ($delta < threshold $aliveThreshold)"
        return 0
      fi
    else
      ! $verboseFlag || decorate info "Main process ID is $pid - and is dead"
      kill -TERM "$pid" 2>/dev/null || :
      __catchEnvironment "$handler" rm -f "$d/main.pid" "$d/main.alive" || return $?
    fi
  else
    ! $verboseFlag || decorate info "pid is non-integer? $pid"
    __catchEnvironment "$handler" rm -f "$d/main.pid" "$d/main.alive" || return $?
  fi

  # shellcheck disable=SC2064
  trap "__backgroundMainTrap \"$d\"" INT EXIT TERM
  local processDirectory finished=false
  printf "%d\n" "$$" >"$d/main.pid"
  local delay=5
  while ! $finished; do
    local start elapsed elapsedInt
    finished=true
    [ -d "$cache/process/" ] || break
    start="$(timingStart | tee "$d/main.alive")"
    while read -r processDirectory; do
      __backgroundProcessManager "$handler" "$verboseFlag" "$processDirectory"
      [ -d "$cache/process/" ] || break
      finished=false
    done < <(find "$cache/process/" -maxdepth 1 -mindepth 1 -type d)
    elapsedInt=$(($(timingStart) - start))
    elapsed=$(timingFormat "$elapsedInt")
    printf -- "%s\n" "$elapsed" >"$d/main.elapsed"
    [ -d "$cache/process/" ] || break
    elapsedInt=$((elapsedInt / 1000))
    elapsedInt=$((elapsedInt + delay))
    elapsedInt=$((elapsedInt - (elapsedInt % delay)))
    __catchEnvironment "$handler" sleep "$elapsedInt" || finished=true
  done
  __catchEnvironment "$handler" rm -f "$d/main.pid" "$d/main.alive" || return $?
}
__backgroundMainTrap() {
  local d="$1" e=$?
  rm -f "$d/main.alive" "$d/main.pid"
  printf "Trap hit with %s\n" "$e" >>"$d/main.err"
  debuggingStack >>"$d/main.err"
  return $e
}

#
# Process Directory:
# - ./state - EnvironmentFile. Has `id`, `home` and all configuration settings: `frequency`, `stopSeconds`, `waitSeconds`, `command`, `condition`
# - ./waitCheck - UnsignedInteger. Milliseconds time in the future after which we can check the `condition` to see if we need to run our command.
# - ./waitStop - UnsignedInteger. Milliseconds time in the future after which we can check the `condition` to see if we need to stop our (running) command.
# - ./pid - UnsignedInteger. Process ID of running background process.
# - ./run - UnsignedInteger. Milliseconds time of launch time of background process. (Outside the process)
# - ./start - UnsignedInteger. Milliseconds time of start time of background process. (Inside the process)
# - ./stop - UnsignedInteger. Milliseconds time of stop time of background process. (Inside the process)
# - ./passed - UnsignedInteger. Milliseconds time of last successful background process run.
# - ./failed - UnsignedInteger. Milliseconds time of last successful background process run.
# - ./elapsed - Float. Elapsed time in seconds of last background process run. (Inside the process)
# - ./err - File. `stderr` of background process.
# - ./out - File. `stdout` of background process.
# - ./exit - UnsignedInteger. Exit code of background process.
# - ./process-errors - File. Errors terminating processes.
# - ./condition - File. The condition output which is saved upon initial run.
__backgroundProcessManager() {
  local handler="$1" verboseFlag="$2" d="$3" item
  local stateFile="$d/state"

  if [ ! -f "$stateFile" ]; then
    ! $verboseFlag || decorate warning "Removing stateless directory $(decorate file "$d")"
    __catchEnvironment "$handler" rm -rf "$d" || return $?
    return 0
  fi

  local stopSeconds frequency waitSeconds=0 waitCheck=0 waitStop=0 now id

  now=$(timingStart)
  id=$(__catch "$handler" environmentValueRead "$stateFile" "id") || return $?
  home=$(__catch "$handler" environmentValueRead "$stateFile" "home") || return $?
  frequency=$(__catch "$handler" environmentValueRead "$stateFile" "frequency") || return $?
  stopSeconds=$(__catch "$handler" environmentValueRead "$stateFile" "stopSeconds") || return $?
  waitSeconds=$(__catch "$handler" environmentValueRead "$stateFile" "waitSeconds") || return $?
  [ ! -f "$d/waitCheck" ] || waitCheck="$(cat "$d/waitCheck")"
  [ ! -f "$d/waitStop" ] || waitStop="$(cat "$d/waitStop")"

  local condition=() command=()
  while read -r item; do condition+=("$item"); done < <(__catch "$handler" environmentValueReadArray "$stateFile" "condition") || return $?
  while read -r item; do command+=("$item"); done < <(__catch "$handler" environmentValueReadArray "$stateFile" "command") || return $?

  local shouldRun=false showId

  showId="$(decorate red "[$$]")$(decorate subtle "${id:0:6}")"
  if [ ! -f "$d/pid" ]; then
    local pid
    if [ "$now" -lt "$waitCheck" ]; then
      ! $verboseFlag || decorate info "$showId: Wait check: $now -lt $waitCheck"
      return 0
    fi
    if ! "${condition[@]}" >"$d/condition"; then
      ! $verboseFlag || decorate info "$showId: Condition trigger - will run $(decorate each code "${command[@]}")"
      shouldRun=true
    else
      ! $verboseFlag || decorate info "$showId: Condition passed - waiting to check again in $frequency seconds."
      __catchEnvironment "$handler" printf -- "%s\n" "$((now + (frequency * 1000)))" >"$d/waitCheck" || return $?
    fi
    __catchEnvironment "$handler" rm -f "$d/waitStop" || return $?
  else
    pid=$(__catchEnvironment "$handler" cat "$d/pid") || return $?
    isPositiveInteger "$pid" || __throwEnvironment "$handler" "PID is not integer $d/pid?" || returnClean $? "$d/pid" || return $?
    if kill -0 "$pid" 2>/dev/null; then
      # Running. Should we check the condition behind the back and kill it?
      if [ "$stopSeconds" -gt 0 ] && [ "$now" -gt "$waitStop" ]; then
        "${condition[@]}" >"$d/condition.stop" || :
        # Just compare
        if [ -f "$d/condition.stop" ] && muzzle diff -q "$d/condition" "$d/condition.stop" 2>&1; then
          ! $verboseFlag || decorate info "$showId: Stop check - condition is the same, do nothing."
          __catchEnvironment "$handler" rm -f "$d/condition.stop" || return $?
          __catchEnvironment "$handler" printf -- "%s\n" "$((now + (stopSeconds * 1000)))" >"$d/waitStop" || return $?
        else
          kill -TERM "$pid" 2>>"$d/process-error" || :
          ! $verboseFlag || decorate info "$showId: Stop check killed PID $pid $(decorate each code "${command[@]}") and waiting $waitSeconds seconds."
          __catchEnvironment "$handler" rm -f "$d/pid" "$d/waitStop" "$d/condition.stop" || return $?
          __catchEnvironment "$handler" printf -- "%s\n" "$((now + (waitSeconds * 1000)))" >"$d/waitCheck" || return $?
        fi
      else
        ! $verboseFlag || decorate info "$showId: Waiting to check for stop [ $now -lt $waitStop ]"
      fi
    else
      __catchEnvironment "$handler" rm -f "$d/pid" "$d/run" "$d/failed" "$d/passed" || return $?
      local exitCode="" color="success" extra=""
      [ ! -f "$d/exit" ] || exitCode="$(cat "$d/exit")"
      if [ "$exitCode" != "0" ]; then
        color=warning
        extra=": $(decorate error "$(head -n 1 "$d/err")") $(decorate code "$(head -n 1 "$d/out")")"
        __catchEnvironment "$handler" printf -- "%s\n" "$((now + (waitSeconds * 1000)))" >"$d/waitCheck" || return $?
        __catchEnvironment "$handler" rm -f "$d/waitStop" || return $?
        __catchEnvironment "$handler" printf -- "%s\n" "$now" >"$d/failed" || return $?
      else
        __catchEnvironment "$handler" printf -- "%s\n" "$now" >"$d/passed" || return $?
      fi
      ! $verboseFlag || decorate info "$showId: PID $pid $(decorate each code "${command[@]}") exited $(decorate "$color" "[$exitCode]")$extra"
    fi
  fi

  if $shouldRun; then
    printf -- "" | tee "$d/out" | tee "$d/err" || :
    __catchEnvironment "$handler" printf -- "%s\n" "$now" >"$d/run" || return $?
    __backgroundProcessExitWrapper "$home" "$d" "${command[@]}" &
    pid=$!
    __catchEnvironment "$handler" printf -- "%d\n" "$pid" >"$d/pid" || return $?
    if [ "$stopSeconds" -gt 0 ]; then
      __catchEnvironment "$handler" printf -- "%s\n" "$((now + (stopSeconds * 1000)))" >"$d/waitStop" || return $?
      __catchEnvironment "$handler" rm -f "$d/waitCheck" || return $?
    fi
    ! $verboseFlag || decorate info "$id: Ran background $(decorate value "PID $pid") $(decorate each code "${command[@]}")"
  fi
}

__backgroundProcessKill() {
  local handler="$1" d="$2" verboseFlag="$3" && shift 3
  local stateFile="$d/state"

  local pid=""

  [ ! -f "$d/pid" ] || pid=$(__catchEnvironment "$handler" cat "$d/pid") || return $?
  local id
  id=$(__catch "$handler" environmentValueRead "$stateFile" "id") || return $?
  local command=()
  while read -r item; do command+=("$item"); done < <(__catch "$handler" environmentValueReadArray "$stateFile" "command") || return $?

  id=$(decorate label "${id:0:6}")
  if [ -n "$pid" ]; then
    __catch "$handler" kill -TERM "$pid" 2>>"$d/process-errors" || :
    ! $verboseFlag || statusMessage decorate info "Removed process $id (PID $pid) $(decorate each code "${command[@]}")"
  else
    ! $verboseFlag || statusMessage decorate info "Removed process $id $(decorate each code "${command[@]}")"
  fi
  __catch "$handler" rm -rf "$d" || return $?
}

__backgroundProcessExitWrapper() {
  local e=0 home="$1" d="$2" && shift 2
  __environment cd "$home" || return $?
  rm -f "$d/exit"
  local start stop
  start="$(timingStart | tee "$d/start")" || :
  export PATH HOME BUILD_HOME PWD
  printf "%s\n" "$d: Running $* at $home" >"$d/out"
  nohup env -i "PWD=$PWD PATH=$PATH" "HOME=$HOME" "BUILD_HOME=$BUILD_HOME" "CI=1" "$@" >>"$d/out" 2>"$d/err" || e=$?
  stop="$(timingStart | tee "$d/stop")" || :
  printf "%s\n" "$(timingFormat "$((stop - start))")" >"$d/elapsed"
  printf "%d\n" "$e" >"$d/exit" || :
  return $e
}

__pidStatus() {
  local pid="$1" icon="💤"
  if isPositiveInteger "$pid"; then
    if kill -0 "$pid" 2>/dev/null; then
      icon="✅"
      pid=" $(decorate success "[$pid]")"
    else
      icon="❌"
      pid=" $(decorate subtle "[$pid]")"
    fi
  else
    pid=" $(decorate subtle "[sleep]")"
  fi
  printf "%s%s\n" "$icon" "$pid"
}

__nowRelative() {
  local now="$1" time="$2" delta

  if [ "$time" -eq 0 ]; then
    decorate error never
    return 0
  fi
  local prefix suffix
  delta=$(((now - time) / 1000))
  if [ "$delta" -lt 0 ]; then
    prefix="in " && suffix=""
    delta=$((-delta))
  else
    prefix="" && suffix=" ago"
  fi
  printf -- "%s (%s%s %s%s)\n" "$(dateFromTimestamp "$((time / 1000))")" "$prefix" "$delta" "$(plural "$delta" sec secs)" "$suffix"
}

__backgroundMainReport() {
  local handler="$1" now="$2" cache="$3"

  now=$(timingStart)
  local pid
  [ ! -f "$cache/main.pid" ] || pid="$(cat "$cache/main.pid")"
  isPositiveInteger "$pid" || pid=$(decorate error "not running")
  decorate orange "$(lineFill "*" "Manager")"
  local alive="" elapsed=""
  [ ! -f "$cache/main.alive" ] || alive=" $(__nowRelative "$now" "$(cat "$cache/main.alive")")"
  [ ! -f "$cache/main.elapsed" ] || elapsed="$(cat "$cache/main.elapsed")"
  [ -z "$elapsed" ] || elapsed=" $(decorate bold-blue "(loop elapsed: $elapsed $(plural "$elapsed" second seconds))")"
  decorate pair "Main PID" "$(__pidStatus "$pid")$alive$elapsed"
  __backgroundReportFile "Main output" "$cache/main.out" 3
  __backgroundReportFile "Main error" "$cache/main.err" 3
}

__backgroundProcessReport() {
  local handler="$1" now="$2" d="$3"
  local stateFile="$d/state"

  local pid="" now id frequency stopSeconds waitSeconds waitCheck="" waitStop=""

  id=$(__catch "$handler" environmentValueRead "$stateFile" "id") || return $?
  frequency=$(__catch "$handler" environmentValueRead "$stateFile" "frequency") || return $?
  stopSeconds=$(__catch "$handler" environmentValueRead "$stateFile" "stopSeconds") || return $?
  waitSeconds=$(__catch "$handler" environmentValueRead "$stateFile" "waitSeconds") || return $?
  [ ! -f "$d/waitCheck" ] || waitCheck="$(cat "$d/waitCheck")"
  [ ! -f "$d/waitStop" ] || waitStop="$(cat "$d/waitStop")"

  local condition=() command=()
  while read -r item; do condition+=("$item"); done < <(__catch "$handler" environmentValueReadArray "$stateFile" "condition") || return $?
  while read -r item; do command+=("$item"); done < <(__catch "$handler" environmentValueReadArray "$stateFile" "command") || return $?

  [ ! -f "$d/pid" ] || pid="$(cat "$d/pid")"
  lineFill "=" "$(decorate success "Process: $(decorate each code "${command[@]}") ")"
  decorate pair ID "${id:0:6}"
  decorate pair Condition "${condition[*]}"
  [ ! -f "$d/condition" ] || decorate pair "Condition Value" "$(tail -n 1 "$d/condition")"

  local config=()
  config+=("frequency $frequency $(plural "$frequency" sec secs),")
  config+=("stop check $stopSeconds $(plural "$stopSeconds" sec secs),")
  config+=("wait after stop $waitSeconds $(plural "$waitSeconds" sec secs)")
  decorate pair Configuration "$(decorate each code -- "${config[@]}")"

  local status=()
  status+=("PID $(__pidStatus "$pid")")
  [ ! -f "$d/run" ] || status+=("Run $(__nowRelative "$now" "$(cat "$d/run")")")
  [ ! -f "$d/start" ] || status+=("Started $(__nowRelative "$now" "$(cat "$d/start")")")
  [ ! -f "$d/stop" ] || status+=("Stopped $(__nowRelative "$now" "$(cat "$d/stop")")")
  [ ${#status[@]} -eq 0 ] || decorate pair Status "$(decorate each info -- "${status[@]}")"

  status=()
  [ ! -f "$d/failed" ] || status+=("Failed $(__nowRelative "$now" "$(cat "$d/failed")")")
  [ ! -f "$d/passed" ] || status+=("Passed $(__nowRelative "$now" "$(cat "$d/passed")")")
  [ ! -f "$d/exit" ] || status+=("Exit $(cat "$d/exit")")
  [ ! -f "$d/elapsed" ] || status+=("Elapsed $(cat "$d/elapsed")")
  [ ${#status[@]} -eq 0 ] || decorate pair "Exit Status" "$(decorate each info -- "${status[@]}")"

  local waitStatus=()
  [ -z "$waitCheck" ] || waitStatus+=("Waiting to check $(__nowRelative "$now" "$waitCheck")")
  [ -z "$waitStop" ] || waitStatus+=("Waiting to check stop $(__nowRelative "$now" "$waitStop")")
  [ ${#waitStatus[@]} -eq 0 ] || decorate pair Waiting "$(decorate each warning -- "${waitStatus[@]}")"

  if isPositiveInteger "$pid"; then
    __backgroundReportFile OUTPUT "$d/out"
    __backgroundReportFile ERROR "$d/err"
  fi
  __backgroundReportFile Process Errors "$d/process-errors"
}

__backgroundReportFile() {
  local title="$1" file="$2" lines="${3-10}"
  [ ! -f "$file" ] || fileIsEmpty "$file" || dumpPipe --lines "$lines" --tail "$title" <"$file"
}

__backgroundMainSummary() {
  local handler="$1" now="$2" cache="$3"

  local pid=""
  [ ! -f "$cache/main.pid" ] || pid="$(cat "$cache/main.pid")"

  local alive=""
  [ ! -f "$cache/main.alive" ] || alive="alive $(__nowRelative "$now" "$(cat "$cache/main.alive")")"
  [ -n "$alive" ] || alive=$(decorate subtle "not alive")

  printf -- "%s %s %s\n" "$(__pidStatus "$pid")" "$(decorate magenta "Background process manager")" "$alive"
}

__backgroundProcessSummary() {
  local handler="$1" now="$2" d="$3"
  local stateFile="$d/state"

  local id home
  id=$(__catch "$handler" environmentValueRead "$stateFile" "id") || return $?
  home=$(__catch "$handler" environmentValueRead "$stateFile" "home") || return $?
  local command=()
  while read -r item; do command+=("$item"); done < <(__catch "$handler" environmentValueReadArray "$stateFile" "command") || return $?

  local pid=""
  [ ! -f "$d/pid" ] || pid="$(cat "$d/pid")"

  local extras=()
  [ ! -f "$d/failed" ] || extras+=("Failed $(__nowRelative "$now" "$(cat "$d/failed")")")
  [ ! -f "$d/passed" ] || extras+=("Passed $(__nowRelative "$now" "$(cat "$d/passed")")")
  [ ! -f "$d/run" ] || extras+=("Ran $(__nowRelative "$now" "$(cat "$d/run")")")
  [ ! -f "$d/elapsed" ] || extras+=("Elapsed $(cat "$d/elapsed")")

  printf "%s %s %s %s %s\n" "$(__pidStatus "$pid")" "$(decorate value "${id:0:6}")" "$(decorate file "$home")" "$(decorate each code "${command[@]}")" "${extras[*]}"

}
