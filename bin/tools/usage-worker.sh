#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Experimental
buildUsageCompileParallel() {
  local handler="_${FUNCNAME[0]}"
  local totalWorkers=1 allFlag=false cleanFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --workers) shift && totalWorkers=$(validate "$handler" PositiveInteger "$argument" "${1-}") || return $? ;;
    --all) allFlag=true ;;
    --clean) cleanFlag=true ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local start && start=$(timingStart)

  # Load test stuff here
  __buildUsageLoad "$handler" || return $?

  set -euo pipefail
  local cachePath && cachePath="$(catchReturn "$handler" buildCacheDirectory "${FUNCNAME[0]}")" || return $?

  if $cleanFlag; then
    catchEnvironment "$handler" rm -rf "$cachePath" || return $?
    catchEnvironment "$handler" muzzle directoryRequire "$cachePath" || return $?
    decorate info "Cleaned process state"
  fi
  # shellcheck disable=SC2064
  trap "__buildUsageCompileParallel \"$cachePath\"" EXIT INT

  local fifo="$cachePath/fifo" writerPidFile="$cachePath/writer" workerPidFile="$cachePath/workers" pid

  if [ -f "$fifo" ]; then
    if [ ! -f "$writerPidFile" ]; then
      throwEnvironment "$handler" "FIFO exists in $cachePath but no writer file" || return $?
    fi
    pid=$(catchEnvironment "$handler" head -n 1 "$writerPidFile") || return $?
    isPositiveInteger "$pid" || throwEnvironment "$handler" "pid is not integer: $pid" || return $?
    if kill -0 "$pid" 2>/dev/null; then
      throwEnvironment "$handler" "${FUNCNAME[0]} already running as pid $(decorate value "$pid")" || return $?
    fi
    decorate warning "Cleaning up dead process ${FUNCNAME[0]} $(decorate value "$pid")"
    __buildUsageCompileCleanupProcesses "$handler" "$cachePath" || return $?
  fi

  local undo=(__buildUsageCompileParallel "$cachePath")

  catchEnvironment "$handler" rm -f "$fifo" || return $?
  catchEnvironment "$handler" mkfifo "$fifo" || returnUndo $? "${undo[@]}" || return $?
  catchEnvironment "$handler" touch "$cachePath/lock" || returnUndo $? "${undo[@]}" || return $?

  catchEnvironment "$handler" printf "%d\n" "$totalWorkers" >"$cachePath/total" || returnUndo $? "${undo[@]}" || return $?

  # start multiple workers in parallel
  catchEnvironment "$handler" rm -rf "$workerPidFile" || return $?
  local workerId && for workerId in $(seq 1 "$totalWorkers"); do
    __buildUsageCompileWorker "$handler" "$cachePath" "$workerId" &
    pid=$!
    catchEnvironment "$handler" printf "%d\n" "$!" >>"$workerPidFile" || returnUndo $? "${undo[@]}" || return $?
    statusMessage decorate info "Started worker $pid"
  done

  # start writer
  __buildUsageCompileWriter "$handler" "$cachePath" "$allFlag" &
  pid=$!
  catchEnvironment "$handler" printf "%d\n" "$pid" >"$writerPidFile" || returnUndo $? "${undo[@]}" || return $?
  statusMessage decorate info "Started writer $pid"

  catchEnvironment "$handler" wait || return $?

  __buildUsageCompileParallel "$cachePath" || return $?

  trap - EXIT INT
  statusMessage timingReport "$start" "Ran $(pluralWord "$totalWorkers" "worker")"
}
_buildUsageCompileParallel() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Cleanup function
__buildUsageCompileParallel() {
  local handler="${FUNCNAME[0]#_}"
  local cachePath="$1"
  if [ -d "$cachePath" ]; then
    __buildUsageCompileCleanupProcesses "$handler" "$cachePath" || return $?
    # catchEnvironment "$handler" rm -rf "$cachePath" || return $?
  fi
}

# Cleanup function
__buildUsageCompileCleanupProcesses() {
  local handler="$1" && shift
  local cachePath="$1" && shift
  [ -d "$cachePath" ] || return 0
  local pids=()
  if [ -f "$cachePath/workers" ]; then
    IFS=$'\n' read -r -d '' -a pids <"$cachePath/workers"
  fi
  if [ -f "$cachePath/writer" ]; then
    local pid && pid=$(head -n 1 "$cachePath/writer")
    pids+=("$pid")
  fi
  [ "${#pids[@]}" -eq 0 ] || catchEnvironment "$handler" processWait --signals STOP,TERM,KILL "${pids[@]}" || return $?
  catchEnvironment "$handler" rm -rf "$cachePath/workers" "$cachePath/writer" || return $?
}

# --- writer: generate jobs into the FIFO in the background ---
__buildUsageCompileWriter() {
  local handler="$1" && shift
  local cachePath="$1" && shift
  local all="$1" && shift
  local id="writer"

  local verboseFlag=false

  ! buildDebugEnabled usage-writer || verboseFlag=true

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local docPath="$home/bin/build/documentation/"
  local toolsPath="$home/bin/build/tools/"
  local fifo="$cachePath/fifo"
  local fifoLog="$cachePath/fifo.log"
  local docMod="$cachePath/docMod"
  local toolsMod="$cachePath/toolsMod"
  local recordSizeFile="$cachePath/size"
  local clean=("$docMod" "$toolsMod" "$recordSizeFile")

  catchReturn "$handler" fileModificationTimes "$docPath" -name '*.sh' | sort -rn >"$docMod" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" fileModificationTimes "$toolsPath" -name '*.sh' | sort -rn >"$toolsMod" || returnClean $? "${clean[@]}" || return $?

  local docNewestModified docNewestModifiedFile
  read -r docNewestModified docNewestModifiedFile < <(catchEnvironment "$handler" head -n 1 "$docMod") || return $?
  local docOldestModified docOldestModifiedFile
  read -r docOldestModified docOldestModifiedFile < <(catchEnvironment "$handler" tail -n 1 "$docMod") || return $?

  local toolsNewestModified toolsNewestModifiedFile
  read -r toolsNewestModified toolsNewestModifiedFile < <(catchEnvironment "$handler" head -n 1 "$toolsMod") || return $?
  local toolsOldestModified toolsOldestModifiedFile
  read -r toolsOldestModified toolsOldestModifiedFile < <(catchEnvironment "$handler" tail -n 1 "$toolsMod") || return $?

  local recordSize && recordSize=$(catchEnvironment "$handler" cat "$docMod" "$toolsMod" | catchReturn "$handler" fileLineMaximum) || return $?
  maxFunctionLength=$(buildFunctions | fileLineMaximum)
  recordSize=$((recordSize + maxFunctionLength + 10))
  [ $recordSize -gt 1024 ] || recordSize=1024

  catchEnvironment "$handler" printf "%s\n" "$recordSize" >"$recordSizeFile" || return $?
  if $verboseFlag; then
    {
      decorate info "$id: Starting, wrote $(decorate file "$recordSizeFile")"
      decorate pair "RecordSize" "$recordSize"
      decorate pair "Max Function Length" "$maxFunctionLength"
      decorate pair "Cache" "$cachePath"
      decorate pair "Doc Newest" "$docNewestModifiedFile"
      decorate pair "Doc Newest" "$(dateFromTimestamp --local "$docNewestModified")"
      decorate pair "Doc Oldest" "$(dateFromTimestamp --local "$docOldestModified")"
      decorate pair "Doc Oldest" "$docOldestModifiedFile"
      decorate pair "Tools Newest" "$toolsNewestModifiedFile"
      decorate pair "Tools Newest" "$(dateFromTimestamp --local "$toolsNewestModified")"
      decorate pair "Tools Oldest" "$(dateFromTimestamp --local "$toolsOldestModified")"
      decorate pair "Tools Oldest" "$toolsOldestModifiedFile"
    } 1>&2
  fi
  {
    local fileModificationTime filePath && while read -r fileModificationTime filePath; do
      # If prefixed with a docPath, then skip it
      if ! $all && [ "$fileModificationTime" -lt "$docOldestModified" ]; then
        ! $verboseFlag || decorate info "$id: Stopping at $fileModificationTime $filePath older than documentation oldest $docOldestModified $docOldestModifiedFile" 1>&2
        break
      fi
      ! $verboseFlag || decorate info "$id: Processing $fileModificationTime $filePath" 1>&2
      local recordLine && while IFS="" read -r -d $'\n' recordLine; do
        local recordText && recordText=$(textAlignLeft "$recordSize" "$recordLine")
        ! $verboseFlag || decorate info "$id: Processing record $recordLine" 1>&2
        # Output record here
        printf "%s" "$recordText"
      done < <(catchEnvironment "$handler" bashListFunctions <"$filePath" | catchEnvironment "$handler" grepSafe -v '^_' | catchEnvironment "$handler" decorate wrap "" " $fileModificationTime $filePath") || return $?
    done <"$toolsMod"
    # Output final record here
    catchEnvironment "$handler" printf "%s" "$(textAlignLeft "$recordSize" "-")" || return $?
  } | tee -a "$fifoLog" >"$fifo" || return $?
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  ! $verboseFlag || decorate info "$id: Completed" 1>&2
  catchEnvironment "$handler" rm -f "$cachePath/writer" || return $?
}

__buildUsageCompileWorker() {
  local handler="$1" && shift
  local cachePath="$1" && shift
  local workerId="$1" && shift
  local workerCount && catchEnvironment "$handler" read -r workerCount <"$cachePath/total" || return $?
  local recordSizeFile="$cachePath/size"
  local prefix && prefix="Worker $(catchReturn "$handler" textAlignRight "${#workerCount}" "$workerId")/$workerCount:" || return $?

  local debugFlag=false

  ! buildDebugEnabled usage-worker || debugFlag=true

  local init && init=$(timingStart)
  while [ ! -f "$recordSizeFile" ]; do
    catchEnvironment "$handler" sleep 0.1 || return $?
    if [ "$(timingElapsed "$init")" -gt 10000 ]; then
      throwEnvironment "$handler" "$prefix quit waiting for the record size $(decorate file "$recordSizeFile")" || return $?
    fi
  done
  local recordSize && recordSize="$(head -n 1 "$recordSizeFile")"
  if ! isUnsignedInteger "$recordSize"; then
    throwEnvironment "$handler" "$prefix Record size is non integer: $recordSize" || return $?
  fi
  local docPath && docPath="$(catchReturn "$handler" buildHome)/bin/build/documentation" || return $?
  local functionName fileModificationTime sourceFile
  local fifo="$cachePath/fifo"
  local lock="$cachePath/lock"
  [ -e "$fifo" ] || throwEnvironment "$handler" "$prefix missing fifo $(decorate file "$fifo")" || return $?
  [ -e "$lock" ] || throwEnvironment "$handler" "$prefix missing lock $(decorate file "$lock")" || return $?

  ! $debugFlag || statusMessage --last printf -- "%s starting up (record size: %d)" "$prefix" "$recordSize" 1>&2
  # open fifo and lock
  exec 3<"$fifo"
  exec 4<"$lock"
  local icon="✅"
  local returnCode=0 && while true; do
    flock 4 # grab lock
    if ! IFS="" read -r -d $'\0' -n "$recordSize" -u 3 recordLine; then
      flock -u 4
      break
    fi
    flock -u 4 # release lock
    ! $debugFlag || decorate pair "$prefix line (${#recordLine})" "$(trimSpace "$recordLine")" 1>&2
    IFS=" " read -r functionName fileModificationTime sourceFile <<<"$recordLine"
    [ -n "$functionName" ] || continue
    [ "$functionName" != "-" ] || break
    ! $debugFlag || statusMessage --last printf -- "%s job \"%s\", \"%s\", \"%s\"\n" "$prefix" "$functionName" "$fileModificationTime" "$sourceFile" 1>&2
    if ! isFunction "$functionName"; then
      printf "%s\n" "$prefix: Not a function: $functionName; fileModificationTime:$fileModificationTime; sourceFile:$sourceFile; – skipping" 1>&2
      continue
    fi
    local start && start=$(timingStart)
    if ! __buildUsageCompileFunction "$handler" "$docPath" "$functionName" "$sourceFile" "$prefix" 1>&2; then
      returnCode=1
      break
    fi
    statusMessage printf "%s %s %s %s %s" "$(decorate info "$prefix")" "$(timingFormat "$(timingElapsed "$start")")" "$icon" "$(decorate code "$functionName")" "$(decorate file "$sourceFile")"
  done <"$fifo"
  exec 3<&- 4<&-
  return $returnCode
}
