#!/usr/bin/env bash
#
# notify
#
# Copyright &copy; 2025 Market Acumen, Inc.

__notify() {
  local handler="$1" && shift
  local failMessage="" message="" verboseFlag=false nn=()

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
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --message)
      shift
      message="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --fail-message)
      shift
      failMessage="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --verbose)
      verboseFlag=true
      ;;
    --title)
      shift
      nn+=("$argument" "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --sound)
      shift
      nn+=("$argument" "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --fail-title)
      shift
      nnFail+=("--title" "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --fail-sound)
      nnFail+=("--sound" "$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    *)
      binary="$(usageArgumentCallable "$handler" "$argument" "$1")" || return $?
      shift
      break
      ;;
    esac
    shift
  done
  [ -n "$binary" ] || throwArgument "$handler" "Missing binary" || return $?
  [ -n "$message" ] || message="$binary"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  ! $verboseFlag || statusMessage --last decorate info "Running $(decorate each code "$binary" "$@") ... [$(decorate magenta "$message")]" || return $?
  local start tempOut tempErr dialog
  start=$(timingStart)
  tempOut=$(fileTemporaryName "$handler") || return $?
  tempErr="$tempOut.err"
  if CI=1 catchEnvironment "$handler" "$binary" "$@" 2>"$tempErr" | tee "$tempOut"; then
    local returnValue=$?
    ! $verboseFlag || statusMessage --last decorate "Exit Code:" "$returnValue"
    ! $verboseFlag || statusMessage --last decorate "Elapsed:" "$(timingReport "$start")"
    ! $verboseFlag || statusMessage --last decorate "stdout:" "$(tail -n 10 "$tempOut")"
    dialog=$(printf "%s\n" "$message" "" "Exit Code: $returnValue" "Exit String: $(returnCodeString $returnValue)" "Elapsed: $(timingReport "$start")" "" "stdout:" "$(tail -n 10 "$tempOut")")
    hookRun --application "$home" notify --title "$binary Succeeded" --sound zesk-build-notification "${nn[@]+"${nn[@]}"}" "Elapsed: $(timingReport "$start")"
  else
    [ -n "$failMessage" ] || failMessage="$message"
    dialog=$(printf "%s\n" "$failMessage" "" "Exit Code: $?" "Exit String: $(returnCodeString $?)" "Elapsed: $(timingReport "$start")" "" "stderr:" "$(tail -n 10 "$tempErr")" "" "stdout:" "$(tail -n 10 "$tempOut")")
    hookRun --application "$home" notify --title "$binary FAILED" --sound zesk-build-failed "${nn[@]+"${nn[@]}"}" "${nnFail[@]+"${nnFail[@]}"}" "$dialog"
  fi
  catchEnvironment "$handler" rm -f "$tempErr" "$tempOut" || return $?
}
