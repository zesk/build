#!/usr/bin/env bash
#
# Bash Prompt Module: background
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Runs background processes continuously until a condition is met.
# Manage processes with `backgroundProcess`
#
bashPromptModule_Background() {
  local handler="_${FUNCNAME[0]}" verboseFlag=false

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local cache

  cache=$(__backgroundProcessCache "$handler") || return $?

  local processDirectory
  [ ! -f "$cache/verbose" ] || verboseFlag=true
  while read -r processDirectory; do
    {
      __bashPromptModule_BackgroundProcessManager "$handler" "$verboseFlag" "$processDirectory" &
      disown
    } 2>/dev/null
  done < <(find "$cache/process/" -maxdepth 1 -mindepth 1 -type d)
}
_bashPromptModule_Background() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__bashPromptModule_BackgroundProcessManager() {
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

  local shouldRun=false

  if [ ! -f "$d/pid" ]; then
    local pid
    if [ "$now" -lt "$waitCheck" ]; then
      ! $verboseFlag || decorate info "$id: Wait check: $now -lt $waitCheck"
      return 0
    fi
    if ! "${condition[@]}" >"$d/condition"; then
      ! $verboseFlag || decorate info "$id:Condition trigger - will run $(decorate each code "${command[@]}")"
      shouldRun=true
    else
      ! $verboseFlag || decorate info "$id: Condition passed - waiting to check again in $frequency seconds."
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
        if muzzle diff -q "$d/condition" "$d/condition.stop" 2>&1; then
          ! $verboseFlag || decorate info "$id: Stop check - condition is the same, do nothing."
          __catchEnvironment "$handler" rm -f "$d/condition.stop" || return $?
          __catchEnvironment "$handler" printf -- "%s\n" "$((now + (stopSeconds * 1000)))" >"$d/waitStop" || return $?
        else
          kill -TERM "$pid" 2>>"$d/process-error" || :
          ! $verboseFlag || decorate info "$id: Stop check killed PID $pid $(decorate each code "${command[@]}") and waiting $waitSeconds seconds."
          __catchEnvironment "$handler" rm -f "$d/pid" "$d/waitStop" "$d/condition.stop" || return $?
          __catchEnvironment "$handler" printf -- "%s\n" "$((now + (waitSeconds * 1000)))" >"$d/waitCheck" || return $?
        fi
      else
        ! $verboseFlag || decorate info "$id: Waiting to check for stop [ $now -lt $waitStop ]"
      fi
    else
      __catchEnvironment "$handler" rm -f "$d/pid" "$d/run" "$d/failed" "$d/passed" || return $?
      local exitCode="" color="success" extra=""
      [ ! -f "$d/exit" ] || exitCode="$(cat "$d/exit")"
      if [ "$exitCode" != "0" ]; then
        color=warning
        extra=": $(decorate error "$(head -n 1 "$d/err")") $(decorate code "$(head -n 1 "$d/out")")"
        __catchEnvironment "$handler" printf -- "%s\n" "$((now + (waitSeconds * 1000)))" >"$d/waitCheck" || return $?
        __catchEnvironment "$handler" printf -- "%s\n" "$now" >"$d/failed" || return $?
      else
        __catchEnvironment "$handler" printf -- "%s\n" "$now" >"$d/passed" || return $?
      fi
      ! $verboseFlag || decorate info "$id: PID $pid $(decorate each code "${command[@]}") exited $(decorate "$color" "[$exitCode]")$extra"
    fi
  fi

  if $shouldRun; then
    __backgroundProcessExitWrapper "$home" "$d" "${command[@]}" &
    pid=$!
    __catchEnvironment "$handler" printf "%d\n" "$pid" >"$d/pid" || return $?
    __catchEnvironment "$handler" printf "%s\n" "$now" >"$d/run" || return $?
    if [ "$stopSeconds" -gt 0 ]; then
      __catchEnvironment "$handler" printf "%s\n" "$((now + (stopSeconds * 1000)))" >"$d/waitStop" || return $?
    fi
    ! $verboseFlag || decorate info "$id: Ran background $(decorate value "PID $pid") $(decorate each code "${command[@]}")"
  fi
}

__backgroundProcessKill() {
  local handler="$1" d="$2" && shift 2
  local stateFile="$d/state"

  local pid=""

  [ ! -f "$d/pid" ] || pid=$(__catchEnvironment "$handler" cat "$d/pid") || return $?
  local id
  id=$(__catch "$handler" environmentValueRead "$stateFile" "id") || return $?
  local command=()
  while read -r item; do command+=("$item"); done < <(__catch "$handler" environmentValueReadArray "$stateFile" "command") || return $?

  id=$(decorate label "$id")
  if [ -n "$pid" ]; then
    __catch "$handler" kill -TERM "$pid" 2>>"$d/process-errors" || :
    decorate info "Removed process $id (PID $pid) $(decorate each code "${command[@]}")"
  else
    decorate info "Removed process $id $(decorate each code "${command[@]}")"
  fi
  __catch "$handler" rm -rf "$d" || return $?
}
__backgroundProcessExitWrapper() {
  local e=0 home="$1" d="$2" && shift 2
  __environment cd "$home" || return $?
  rm -f "$d/exit"
  nohup "$@" >"$d/out" 2>"$d/err" || e=$?
  printf "%d\n" "$e" >"$d/exit" || :
  return $e
}

__nowRelative() {
  local now="$1" time="$2" delta

  local prefix suffix
  delta=$(((now - time) / 1000))
  if [ "$delta" -lt 0 ]; then
    prefix="in " && suffix=""
    delta=$((-delta))
  else
    prefix="" && suffix=" ago"
  fi
  printf -- "%s (%s%s %s%s)\n" "$(dateFromTimestamp "$((time / 1000))")" "$prefix" "$delta" "$(plural "$delta" second seconds)" "$suffix"
}

__backgroundProcessReport() {
  local handler="$1" d="$2"
  local stateFile="$d/state"

  local pid="" now id frequency stopSeconds waitSeconds waitCheck="" waitStop=""

  now=$(timingStart)
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
  lineFill "=" "$(decorate success "Process: $id ")"
  decorate pair Command "${command[*]}"
  decorate pair Condition "${condition[*]}"
  [ ! -f "$d/condition" ] || decorate pair "Condition Value" "$(tail -n 1 "$d/condition")"

  decorate pair Frequency "$frequency"
  decorate pair "Stop Check" "$stopSeconds"
  decorate pair "Wait after stopping" "$waitSeconds"
  [ ! -f "$d/failed" ] || decorate pair Failed "$(__nowRelative "$now" "$(tail -n 1 "$d/failed")")"
  [ ! -f "$d/passed" ] || decorate pair Passed "$(__nowRelative "$now" "$(tail -n 1 "$d/passed")")"
  decorate pair PID "${pid:-NONE}"
  # shellcheck disable=SC2015
  ! isPositiveInteger "$pid" || decorate pair Running "$(kill -0 "$pid" 2>/dev/null && decorate success "[YES]" || decorate red "[NO]")"
  [ ! -f "$d/run" ] || decorate pair Run "$(__nowRelative "$now" "$(cat "$d/run")")"
  [ -z "$waitCheck" ] || decorate pair WaitCheck "$(__nowRelative "$now" "$waitCheck")"
  [ -z "$waitStop" ] || decorate pair WaitStop "$(__nowRelative "$now" "$waitStop")"
  [ ! -f "$d/out" ] || fileIsEmpty "$d/out" || dumpPipe --lines 10 --tail OUTPUT <"$d/out"
  [ ! -f "$d/err" ] || fileIsEmpty "$d/err" || dumpPipe --lines 10 --tail ERROR <"$d/err"
}
