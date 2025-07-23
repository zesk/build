#!/usr/bin/env bash
#
# Watching tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Watch a directory
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: --target target - Optional. File. File to create. File must exist.
# Argument: --verbose - Optional. Flag. Be verbose.
# Argument: --file modifiedFile - Optional. File. Last known modified file in this directory.
# Argument: --modified modificationTime - Optional. UnsignedInteger. Last known modification timestamp in this directory.
# Argument: --timeout secondsToRun - Optional. UnsignedInteger. Last known modification timestamp in this directory.
# Argument: --state stateFile - Optional. File. Output of `fileModificationTimes` will be saved here (and modified)
# Argument: directory - Required. Directory. Directory to watch
# Argument: findArguments ... - Optional. Arguments. Passed to find to filter the files examined.
watchDirectory() {
  local handler="_${FUNCNAME[0]}"

  local rootDir="" lastTimestamp="" lastFile="" secondsToRun="" stateFile="" verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ argumentBlankCheck 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 2
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;

    --verbose) verboseFlag=true ;;
    --file) shift && lastFile=$(usageArgumentString "$handler" "$argument" "${1-}") || return $? ;;
    --modified) shift && lastTimestamp=$(usageArgumentUnsignedInteger "$handler" "$argument" "${1-}") || return $? ;;
    --timeout) shift && secondsToRun=$(usageArgumentUnsignedInteger "$handler" "$argument" "${1-}") || return $? ;;
    --state) shift && stateFile=$(usageArgumentFile "$handler" "$argument" "${1-}") || return $? ;;
    *)
      rootDir=$(usageArgumentDirectory "$handler" "directory" "$1") || return $?
      shift
      break
      ;;
    esac
    shift
  done

  [ -n "$rootDir" ] || __throwArgument "$handler" "Missing directory" || return $?
  local clean=()
  if [ -z "$stateFile" ]; then
    stateFile=$(fileTemporaryName "$handler") || return $?
    clean+=("$stateFile")
  fi
  local init start stop elapsed

  init=$(timingStart)
  while true; do
    printf -- "" >"$stateFile"
    start=$(timingStart)
    __catchEnvironment "$handler" fileModificationTimes "$rootDir" "$@" | sort -rn >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
    stop=$(timingStart)
    elapsed=$((stop - start))

    local newTimestamp newFile
    read -r newTimestamp newFile <"$stateFile" || :

    if [ "$newTimestamp" != "$lastTimestamp" ] || [ "$newFile" != "$lastFile" ]; then
      returnClean 0 "${clean[@]}"
      return $?
    fi

    elapsed=$(((elapsed + 999) / 1000))
    [ -z "$secondsToRun" ] || [ $(((stop - init) / 1000)) -lt "$secondsToRun" ] || break
    ! $verboseFlag || statusMessage decorate info "$(decorate subtle "$(date +%T)"): Sleeping for $elapsed $(plural $elapsed second seconds) $(decorate file "$lastFile") modified $(decorate magenta "$lastTimestamp") ..."
    __catchEnvironment "$handler" sleep "$elapsed" || returnClean $? "${clean[@]}" || return $?
  done
  ! $verboseFlag || statusMessage --last timingReport "$init" "Watch stopped after"
  returnClean 0 "${clean[@]}"
}
_watchDirectory() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
