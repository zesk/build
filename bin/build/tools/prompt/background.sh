#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__backgroundProcessCache() {
  local handler="$1" && shift
  __catch "$handler" directoryRequire "$(__catch "$handler" buildCacheDirectory "${FUNCNAME[0]}")" || return $?
}

# Main API interface to this feature
# Run a single process in the background continuously until a condition is met.
__backgroundProcess() {
  local handler="$1" && shift
  local condition=() command=()
  local stopSeconds=0 waitSeconds=5 frequency=60
  local actionFlag=""

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
    --monitor) actionFlag="monitor" ;;
    --report) actionFlag="report" ;;
    --stop-all) actionFlag="stop-all" ;;
    --verbose-toggle) actionFlag="verbose-toggle" ;;
    --stop) shift && stopSeconds=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $? ;;
    --wait) shift && waitSeconds=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $? ;;
    --frequency) shift && frequency=$(usageArgumentPositiveInteger "$handler" "$argument" "${1-}") || return $? ;;
    --go) actionFlag="go" ;;
    *)
      if [ 0 -eq ${#condition[@]} ]; then
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

  if [ -n "$actionFlag" ]; then
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
      loopExecute --until 1 --delay 4 backgroundProcess --report
      return 0
      ;;
    "stop-all")
      if [ -d "$cache/process/" ]; then
        while read -r processDirectory; do
          __backgroundProcessKill "$handler" "$processDirectory"
        done < <(find "$cache/process/" -maxdepth 1 -mindepth 1 -type d)
      fi
      return 0
      ;;
    "go")
      __catch "$handler" bashPromptModule_Background || return $?
      return 0
      ;;
    "report")
      if [ -d "$cache/process/" ]; then
        while read -r processDirectory; do
          __backgroundProcessReport "$handler" "$processDirectory"
        done < <(find "$cache/process/" -maxdepth 1 -mindepth 1 -type d)
      fi
      return 0
      ;;
    *) __throwEnvironment "$handler" "Unknown actionFlag? $actionFlag" || return $? ;;
    esac
  fi

  [ ${#condition[@]} -gt 0 ] || __throwArgument "$handler" "Requires a condition" || return $?
  [ ${#command[@]} -gt 0 ] || __throwArgument "$handler" "Requires a command" || return $?

  local id
  id=$(__catch "$handler" shaPipe <<<"${condition[*]} ${command[*]}") || return $?
  __catch "$handler" directoryRequire "$cache/process/$id" || return $?
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
  __catch "$handler" bashPrompt --skip-prompt --first bashPromptModule_Background || return $?
  statusMessage --last decorate info "Registered background process $(decorate code "$id") $(decorate each code "${command[*]}")"
}
