#!/usr/bin/env bash
#
# executeLoop
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#

# Run checks interactively until errors are all fixed.
__executeLoop() {
  local handler="$1" && shift

  local loopCallable="" sleepDelay=10 title="" until=()

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
    --title)
      shift
      title=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --until)
      shift
      until+=("$(validate "$handler" UnsignedInteger "$argument" "${1-}")") || return $?
      ;;
    --delay)
      shift
      sleepDelay=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $?
      ;;
    *)
      if [ -z "$loopCallable" ]; then
        loopCallable=$(validate "$handler" Callable "loopCallable" "$1") || return $?
        shift
        break
      fi
      ;;
    esac
    shift
  done

  [ -n "$loopCallable" ] || throwArgument "$handler" "No loopCallable" || return $?
  [ -n "$title" ] || title="$(decorate each code "$loopCallable" "$@")"
  [ ${#until[@]} -gt 0 ] || until=("0")

  local done=false exitCode=0 outputBuffer statusLine rowCount outsideColor
  outsideColor="code"
  outputBuffer=$(fileTemporaryName "$handler") || return $?
  iterations=1
  statusLine="Running first iteration ..."
  rowCount=$(consoleRows)
  while ! $done; do
    local saveY suffix

    if [ $iterations = 1 ]; then
      clear
      suffix=$(decorate notice "(first run)")
    else
      cursorSet 1 1
      suffix=$(decorate warning "(loading)")
    fi

    catchReturn "$handler" decorate box --size 0 --outside "$outsideColor" --inside "$outsideColor" "$title $suffix" && printf -- "%s\n" "$statusLine" | plasterLines || return $?
    IFS=$'\n' read -r -d '' _ saveY < <(cursorGet)

    local start showRows

    start=$(timingStart) || return $?
    showRows=$((rowCount - saveY))
    exitCode=0
    set +e +u +o pipefail
    if [ $iterations = 1 ]; then
      "$loopCallable" "$@" 2>&1 || exitCode=$?
    else
      "$loopCallable" "$@" >"$outputBuffer" 2>&1 || exitCode=$?
    fi

    # Compute status line
    local elapsed seconds nLines stamp
    nLines=$(catchReturn "$handler" fileLineCount "$outputBuffer") || return $?
    elapsed=$(($(catchReturn "$handler" timingStart) - start)) || return $?
    seconds=$(timingFormat "$elapsed")
    seconds="$seconds $(localePlural "$seconds" second seconds)"
    stamp=$(date "+%F %T")
    local returnCodeString
    returnCodeString="$(decorate value "$exitCode") $(decorate label "[$(returnCodeString "$exitCode")]")"
    statusLine="$(decorate blue "[#$iterations]") $(decorate yellow "$stamp") $returnCodeString, $nLines $(localePlural "$nLines" line lines), $seconds"
    cursorSet 1 1

    if inArray "$exitCode" "${until[@]}"; then
      catchReturn "$handler" decorate box --size 0 --outside "$outsideColor" --inside success "$title (SUCCESS)" | plasterLines || return $?
      printf "%s\n" "$statusLine" | plasterLines || return $?
      catchEnvironment "$handler" plasterLines <"$outputBuffer" || return $?
      cursorSet 1 "$((rowCount - 1))"
      decorate big "Success"
      done=true
    else
      catchReturn "$handler" decorate box --size 0 --outside "$outsideColor" --inside "" "$title $(decorate orange "(looping)")" && printf -- "%s\n" "$statusLine" | plasterLines || echo "EXIT CODE: $?"
      (
        tail -n "$showRows" <"$outputBuffer"
        [ "$showRows" -lt "$nLines" ] || textRepeat "$((showRows - nLines))" "\n"
      ) | plasterLines
      elapsed=$((elapsed / 1000))
      if [ "$elapsed" -lt "$sleepDelay" ]; then
        cursorSet 1 "$((saveY - 1))"
        catchReturn "$handler" interactiveCountdown --prefix "$statusLine, running in" "$((sleepDelay - elapsed))" || return $?
      fi
    fi
    iterations=$((iterations + 1))
    rowCount=$(consoleRows)
  done
  catchEnvironment "$handler" rm -rf "$outputBuffer" || return $?
}
