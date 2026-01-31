#!/usr/bin/env bash
returnMessage() {
  local handler="_${FUNCNAME[0]}"
  local to=1 icon="✅" code="${1:-1}" && shift 2>/dev/null
  if [ "$code" = "--help" ]; then "$handler" 0 && return; fi
  isUnsignedInteger "$code" || returnMessage 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${handler#_} non-integer \"$code\"" "$@" || return $?
  if [ "$code" -gt 0 ]; then icon="❌ [$code]" && to=2; fi
  printf -- "%s %s\n" "$icon" "${*-§}" 1>&"$to"
  return "$code"
}
_returnMessage() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isUnsignedInteger() {
  [ $# -eq 1 ] || returnMessage 2 "Single argument only: $*" || return $?
  case "${1#+}" in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}
_isUnsignedInteger() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__functionLoader() {
  local __saved=("$@") prefix="${1-}" functionName="${2-}" subdirectory="${3-}" handler="${4-}" command="${5-}"
  shift 5 || catchArgument "$handler" "Missing arguments: $(decorate each --count code -- "${__saved[@]}")" || return $?
  export BUILD_HOME
  if ! isFunction "$functionName"; then
    catchReturn "$handler" bashSourcePath "${BUILD_HOME-}/$prefix/$subdirectory/" || return $?
    export __BUILD_LOADER
    __BUILD_LOADER+=("$functionName")
  fi
  "$command" "$handler" "$@" || return $?
}
__buildFunctionLoader() {
  __functionLoader "bin/build/tools" "$@"
}
__toolsTimingLoad() {
  local internalError=253 toolsPath="$1" && shift
  local start elapsed="undefined"
  printf "" >"${BASH_SOURCE[0]%/*}/../../.tools.times"
  while [ "$#" -gt 0 ]; do
    ! isFunction __timestamp || start=$(__timestamp)
    source "$toolsPath/$1.sh" || returnMessage $internalError "%s\n" "Loading $1.sh failed" || return $?
    ! isFunction __timestamp || elapsed=$(($(__timestamp) - start))
    printf "%s %s\n" "$elapsed" "$1" >>"${BASH_SOURCE[0]%/*}/../../.tools.times"
    shift
  done
  sort -r "${BASH_SOURCE[0]%/*}/../../.tools.times" >"${BASH_SOURCE[0]%/*}/../../.tools.times.sorted"
}
__toolsInitialize() {
  export BUILD_DEBUG BUILD_HOME __BUILD_LOADER
  unset BUILD_HOME
  [ -z "${__BUILD_LOADER-}" ] || unset "${__BUILD_LOADER[@]}"
  __BUILD_LOADER=()
  unset "${FUNCNAME[0]}"
}
__toolsMain() {
  local exitCode=0 debug=",${BUILD_DEBUG-},"
  if [ "$(basename "${0##-}")" = "$(basename "${BASH_SOURCE[0]}")" ] && [ $# -gt 0 ]; then
    export BUILD_HOME
    set -eou pipefail
    BUILD_HOME="$BUILD_HOME" "$@" || exitCode=$?
  fi
  return $exitCode
}
__toolsInitialize
returnCode() {
  local k && while [ $# -gt 0 ]; do case "$1" in --help) ! "_${FUNCNAME[0]}" 0 || return 0 ;; success) k=0 ;; environment) k=1 ;; argument) k=2 ;; assert) k=97 ;; identical) k=105 ;; leak) k=108 ;; timeout) k=116 ;; exit) k=120 ;; user-interrupt) k=130 ;; interrupt) k=141 ;; internal) k=253 ;; *) k=254 ;; esac && shift && printf -- "%d\n" "$k"; done
}
_returnCode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
returnCodeString() {
  local k="" && while [ $# -gt 0 ]; do case "$1" in 0) k="success" ;; 1) k="environment" ;; 2) k="argument" ;; 97) k="assert" ;; 105) k="identical" ;; 108) k="leak" ;; 116) k="timeout" ;; 120) k="exit" ;; 127) k="not-found" ;; 130) k="user-interrupt" ;; 141) k="interrupt" ;; 253) k="internal" ;; 254) k="unknown" ;; --help) "_${FUNCNAME[0]}" 0 && return $? || return $? ;; *) k="[returnCodeString unknown \"$1\"]" ;; esac && [ -n "$k" ] || k="$1" && printf "%s\n" "$k" && shift; done
}
_returnCodeString() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isBoolean() {
  case "${1-}" in true | false) ;; --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; *) return 1 ;; esac
}
booleanChoose() {
  local testValue="${1-}" && shift
  if [ "$testValue" = "--help" ]; then usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 && return 0; fi
  isBoolean "$testValue" || returnArgument "${BASH_SOURCE[1]-no function name}:${BASH_LINENO[0]-no line} ${FUNCNAME[1]} -> ${FUNCNAME[0]} non-boolean: \"$testValue\"" || return $?
  "$testValue" && printf -- "%s\n" "${1-}" || printf -- "%s\n" "${2-}"
}
returnArgument() {
  returnMessage 2 "$@" || return $?
}
returnEnvironment() {
  returnMessage 1 "$@" || return $?
}
returnThrow() {
  local returnCode="${1-}" && shift || returnArgument "Missing return code" || return $?
  local handler="${1-}" && shift || returnArgument "Missing error handler" || return $?
  "$handler" "$returnCode" "$@" || return $?
}
catchReturn() {
  local handler="${1-}" && shift || returnArgument "Missing handler" || return $?
  "$@" || "$handler" "$?" "$@" || return $?
}
returnClean() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local exitCode="${1-}" && shift
  if ! isUnsignedInteger "$exitCode"; then
    throwArgument "$handler" "$exitCode (not an integer) $*" || return $?
  else
    catchEnvironment "$handler" rm -rf "$@" || return "$exitCode"
    return "$exitCode"
  fi
}
_returnClean() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
executeEcho() {
  printf -- "➡️ %s\n" "$(decorate each quote -- "$@")" && execute "$@" || return $?
}
execute() {
  "$@" || returnMessage "$?" "$@" || return $?
}
convertValue() {
  local __handler="_${FUNCNAME[0]}" value="" from="" to=""
  [ "${1-}" != "--help" ] || __help "$__handler" "$@" || return 0
  while [ $# -gt 0 ]; do
    if [ -z "$value" ]; then
      value=$(validate "$__handler" string "value" "$1") || return $?
    elif [ -z "$from" ]; then
      from=$(validate "$__handler" string "from" "$1") || return $?
    elif [ -z "$to" ]; then
      to=$(validate "$__handler" string "to" "$1") || return $?
      if [ "$value" = "$from" ]; then
        printf "%s\n" "$to"
        return 0
      fi
      from="" && to=""
    fi
    shift
  done
  printf "%s\n" "${value:-0}"
}
_convertValue() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
catchCode() {
  local __count=$# __saved=("$@") __handler="_${FUNCNAME[0]}" code="${1-0}" command="${3-}"
  isUnsignedInteger "$code" || throwArgument "$__handler" "Not unsigned integer: $(decorate value "[$code]") (#$__count $(decorate each code -- "${__saved[@]}"))" || return $?
  __handler="${2-}"
  isFunction "$__handler" || returnArgument "handler not callable \"$(decorate code "$__handler")\" Stack: $(debuggingStack)" || return $?
  isCallable "$command" || throwArgument "$__handler" "Not callable $(decorate code "$command")" || return $?
  shift 3
  "$command" "$@" || "$__handler" "$code" "$(decorate each code "$command" "$@")" || return $?
}
_catchCode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
catchEnvironment() {
  catchCode 1 "$@" || return $?
}
catchArgument() {
  catchCode 2 "$@" || return $?
}
throwEnvironment() {
  local __handler="${1-}"
  isFunction "$__handler" || returnArgument "handler not callable \"$(decorate code "$__handler")\" Stack: $(debuggingStack)" || return $?
  shift && "$__handler" 1 "$@" || return $?
}
throwArgument() {
  local __handler="${1-}"
  isFunction "$__handler" || returnArgument "handler not callable \"$(decorate code "$__handler")\" Stack: $(debuggingStack)" || return $?
  shift && "$__handler" 2 "$@" || return $?
}
catchEnvironmentQuiet() {
  local __handler="${1-}" quietLog="${2-}" clean=() && shift 2
  isFunction "$__handler" || returnArgument "handler not callable \"$(decorate code "$__handler")\" Stack: $(debuggingStack)" || return $?
  if [ ! -f "$quietLog" ]; then
    if [ "$quietLog" = "-" ]; then
      quietLog=$(fileTemporaryName "$handler") || return $?
      clean+=("$quietLog")
    elif [ ! -d "$(dirname "$quietLog")" ]; then
      throwArgument "$handler" "Directory for $(decorate file "$quietLog") does not exist!" || return $?
    fi
  fi
  if "$@" >>"$quietLog" 2>&1; then
    returnClean 0 "${clean[@]+"${clean[@]}"}" || return $?
    return 0
  fi
  tail -f 30 "$quietLog" 1>&2 || :
  throwEnvironment "$__handler" "$@" || returnClean $? "${clean[@]+"${clean[@]}"}" || return $?
}
_deprecated() {
  export BUILD_HOME
  printf "DEPRECATED: %s\n" "$@" 1>&2
  [ ! -d "$BUILD_HOME" ] || printf -- "$(date "+%F %T"),%s\n%s\n" "$*" "$(debuggingStack)" >>"$BUILD_HOME/.deprecated"
}
muzzle() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  "$@" >/dev/null
}
_muzzle() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
returnMap() {
  local __handler="_${FUNCNAME[0]}" value="" from="" to=""
  [ "${1-}" != "--help" ] || __help "$__handler" "$@" || return 0
  while [ $# -gt 0 ]; do
    if [ -z "$value" ]; then
      value=$(validate "$__handler" UnsignedInteger "value" "$1") || return $?
    elif [ -z "$from" ]; then
      from=$(validate "$__handler" UnsignedInteger "from" "$1") || return $?
    elif [ -z "$to" ]; then
      to=$(validate "$__handler" UnsignedInteger "to" "$1") || return $?
      if [ "$value" -eq "$from" ]; then
        return "$to"
      fi
      from="" && to=""
    fi
    shift
  done
  return "${value:-0}"
}
_returnMap() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
returnUndo() {
  local __count=$# __saved=("$@") __handler="_${FUNCNAME[0]}" code="${1-}" execArguments=()
  [ "${1-}" != "--help" ] || __help "$__handler" "$@" || return 0
  shift
  isUnsignedInteger "$code" || throwArgument "$__handler" "Not unsigned integer: $(decorate value "[$code]") (#$__count $(decorate each code -- "${__saved[@]}"))" || return $?
  while [ $# -gt 0 ]; do
    case "$1" in
    --)
      [ "${#execArguments[@]}" -eq 0 ] || muzzle execute "${execArguments[@]}" || :
      execArguments=()
      ;;
    *) execArguments+=("$1") ;;
    esac
    shift
  done
  [ "${#execArguments[@]}" -eq 0 ] || muzzle execute "${execArguments[@]}" || :
  return "$code"
}
_returnUndo() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
executeInputSupport() {
  local handler="$1" executor=() && shift
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      shift
      break
    fi
    executor+=("$1")
    shift
  done
  [ ${#executor[@]} -gt 0 ] || return 0
  local byte
  if [ $# -eq 0 ] && IFS="" read -r -t 1 -n 1 byte; then
    local line done=false
    if [ "$byte" = $'\n' ]; then
      catchEnvironment "$handler" "${executor[@]}" "" || return $?
      byte=""
    fi
    while ! $done; do
      IFS="" read -r line || done=true
      [ -n "$byte$line" ] || ! $done || break
      catchEnvironment "$handler" "${executor[@]}" "$byte$line" || return $?
      byte=""
    done
  else
    if [ "${1-}" = "--" ]; then
      shift
    fi
    catchEnvironment "$handler" "${executor[@]}" "$@" || return $?
  fi
}
timing() {
  local handler="_${FUNCNAME[0]}"
  local name=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --name) shift && name="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    *) break ;;
    esac
    shift
  done
  [ -n "$name" ] || name="$*"
  local start exitCode=0
  start=$(timingStart)
  isCallable "${1-}" || throwArgument "$handler" "${1-} must be callable" || return $?
  catchReturn "$handler" "$@" || exitCode="$?"
  timingReport "$start" "$name"
  [ $exitCode = 0 ] || returnMessage "$exitCode" "$@" || return $?
}
_timing() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
timingElapsed() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local start
  start=$(validate "$handler" UnsignedInteger timingOffset "${1-}") && shift || return $?
  printf "%d\n" "$(($(__timestamp) - start))"
}
_timingElapsed() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
timingStart() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  __timestamp
}
_timingStart() {
  ! false || timingStart --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
timingFormat() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  while [ $# -gt 0 ]; do
    local delta="$1" seconds remainder text
    if isUnsignedInteger "$delta"; then
      seconds=$((delta / 1000))
      remainder=$((delta % 1000))
      text=$(printf -- "%d.%03d\n" "$seconds" "$remainder")
      text=${text%0} && text=${text%0} && text=${text%0} && text=${text%.}
      printf "%s\n" "$text"
    else
      printf "(**%s**)\n" "$delta"
    fi
    shift
  done
}
_timingFormat() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
timingReport() {
  local handler="_${FUNCNAME[0]}"
  local color="green" start=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --color) shift && color=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    *) start="$argument" && shift && break ;;
    esac
    shift
  done
  if isUnsignedInteger "$start"; then
    local prefix=""
    if [ $# -gt 0 ]; then
      prefix="$(decorate "$color" "$@") "
    fi
    local value end delta
    end=$(timingStart)
    delta=$((end - start))
    if [ "$delta" -lt 0 ]; then
      printf "%s%s\n" "$prefix" "$(decorate BOLD red "$end - $start => $delta NEGATIVE")"
    else
      value=$(timingFormat "$delta") || :
      printf "%s%s\n" "$prefix" "$(decorate BOLD magenta "$value $(plural "$value" second seconds)")"
    fi
  else
    printf "%s %s %s\n" "$*" "$(decorate BOLD red "$start")" "$(decorate warning "(not integer)")"
  fi
}
_timingReport() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildDebugEnabled() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  export BUILD_DEBUG
  local debugString
  debugString="${BUILD_DEBUG-}"
  if [ -z "$debugString" ] || [ "$debugString" = "false" ]; then
    return 1
  fi
  if [ "$debugString" = "true" ] || [ $# -eq 0 ]; then return 0; fi
  debugString=",$debugString,"
  while [ $# -gt 0 ]; do
    if [ "${debugString/,$1,/}" != "$debugString" ]; then return 0; fi
    shift
  done
  return 1
}
_buildDebugEnabled() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__buildDebugEnable() {
  set "-x${1-}"
}
__buildDebugDisable() {
  set "+x${1-}"
}
buildDebugStart() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  if ! buildDebugEnabled "$@"; then
    return 1
  fi
  __buildDebugEnable
}
_buildDebugStart() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildDebugStop() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  if ! buildDebugEnabled "$@"; then
    return 1
  fi
  __buildDebugDisable
}
_buildDebugStop() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isBashDebug() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  case $- in *x*) return 0 ;; esac
  return 1
}
_isBashDebug() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashRecursionDebug() {
  local handler="_${FUNCNAME[0]}"
  export __BUILD_RECURSION
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local cacheFile
  cacheFile="$(catchReturn "$handler" buildCacheDirectory)/.${FUNCNAME[0]}" || return $?
  if [ "${__BUILD_RECURSION-}" = "true" ]; then
    if [ "${1-}" = "--end" ]; then
      unset __BUILD_RECURSION
      catchEnvironment "$handler" rm -f "$cacheFile" || return $?
      return 0
    fi
    printf "%s\n" "RECURSION FAILURE" "$(debuggingStack)" "" "INITIAL CALL" "$(decorate code <"$cacheFile")" 1>&2
    catchEnvironment "$handler" rm -f "$cacheFile" || return $?
    sleep 99
    exit 91
  fi
  if [ "${1-}" = "--end" ]; then
    printf "%s\n" "RECURSION FAILURE (end without start)" "$(debuggingStack)" 1>&2
    catchEnvironment "$handler" rm -f "$cacheFile" || return $?
    sleep 99
    exit 91
  fi
  __BUILD_RECURSION=true
  catchEnvironment "$handler" debuggingStack >"$cacheFile" || return $?
}
_bashRecursionDebug() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashDebugInterruptFile() {
  local handler="_${FUNCNAME[0]}"
  local name="__bashDebugInterruptFile" traps=() clearFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --clear) clearFlag=true ;;
    --interrupt)
      inArray INT "${traps[@]+"${traps[@]}"}" || traps+=("INT")
      ;;
    --error)
      inArray ERR "${traps[@]+"${traps[@]}"}" || traps+=("ERR")
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  [ "${#traps[@]}" -gt 0 ] || traps+=("INT")
  if $clearFlag; then
    catchEnvironment "$handler" trap - "${traps[@]}" || return $?
    return 0
  fi
  local currentTraps installed=()
  currentTraps=$(fileTemporaryName "$handler") || return $?
  trap >"$currentTraps" || returnClean "$?" "$currentTraps" || throwEnvironment "trap listing failed" || return $?
  for trap in "${traps[@]}"; do
    if grep "$name" "$currentTraps" | grep -q " SIG$trap"; then
      installed+=("$trap")
    fi
  done
  if [ "${#installed[@]}" -eq "${#traps[@]}" ]; then
    throwEnvironment "$handler" "Already installed" || returnClean $? "$currentTraps" || return $?
  fi
  catchEnvironment "$handler" rm -rf "$currentTraps" || return $?
  catchEnvironment "$handler" trap __bashDebugInterruptFile "${traps[@]}" || return $?
}
_bashDebugInterruptFile() {
  ! false || bashDebugInterruptFile --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__bashDebugInterruptFile() {
  local exitCode=$?
  export BUILD_HOME BASH_LINENO BASH_SOURCE BASH_ARGC BASH_ARGV FUNCNAME
  {
    local now
    now=$(date)
    printf "%s\n" "--- $BUILD_HOME terminated $now ------------------------------------------"
    debuggingStack -x --me
    printf "%s\n" "END --- $BUILD_HOME terminated $now ------------------------------------------" ""
  } >>"$BUILD_HOME/.interrupt.log" || :
  local suffix="="
  [ $exitCode -lt 10 ] || suffix="$suffix="
  [ $exitCode -lt 100 ] || suffix="$suffix="
  local box="+=================+=$suffix=+"
  printf -- "%s\n" "" "$box" "| DEBUG INTERRUPT | $exitCode |" "$box" 1>&2
  return 122
}
isErrorExit() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  case "$-" in *e* | *E*) return 0 ;; esac
  return 1
}
_isErrorExit() {
  ! false || isErrorExit --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
plumber() {
  local handler="_${FUNCNAME[0]}"
  export TMPDIR
  local __before __after __changed __ignore __pattern __cmd __tempDir=$TMPDIR
  local __result=0
  local __ignore=(OLDPWD _ resultCode LINENO PWD BASH_COMMAND BASH_ARGC BASH_ARGV BUILD_DEBUG)
  local __verboseFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --temporary) shift && __tempDir=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --leak) shift && __ignore+=("$(validate "$handler" String "globalName" "${1-}")") || return $? ;;
    --verbose) __verboseFlag=true ;;
    *) break ;;
    esac
    shift
  done
  [ $# -gt 0 ] || return 0
  isCallable "${1-}" || throwArgument "$handler" "$1 is not callable" "$@" || return $?
  __after=$(TMPDIR=$__tempDir fileTemporaryName "$handler") || return $?
  __before="$__after.before"
  declare -p >"$__before"
  ! $__verboseFlag || dumpPipe "BEFORE" <"$__before"
  if "$@"; then
    local __rawChanged
    declare -p >"$__after"
    ! $__verboseFlag || dumpPipe "AFTER $__before $__after" <"$__after"
    __pattern="^\($(quoteGrepPattern "$(listJoin '|' "${__ignore[@]+"${__ignore[@]}"}")")\)="
    __changed="$(diff -U0 "$__before" "$__after" | grep -e '^[-+][^-+]' | cut -c 2- | grep -e '^declare' | grep '=' | grep -v -e '^declare -[-a-z]*r ' | removeFields 2 | grep -v -e "$__pattern" || :)"
    __rawChanged=$__changed
    __cmd="$(decorate each code -- "$@")"
    if grep -q -e 'COLUMNS\|LINES' < <(printf "%s\n" "$__changed"); then
      unset COLUMNS LINES
      __changed="$(printf "%s\n" "$__changed" | grep -v -e 'COLUMNS\|LINES' || :)" || throwEnvironment "$handler" "Removing COLUMNS and LINES from $__changed" || return $?
    fi
    if [ -n "$__changed" ]; then
      printf "%s\n" "$__changed" "COMMAND: $__cmd" | dumpPipe "$(decorate BOLD orange "found leak"): $__rawChanged" 1>&2
      if buildDebugEnabled plumber-verbose; then
        dumpPipe BEFORE <"$__before" 1>&2
        dumpPipe AFTER <"$__after" 1>&2
      fi
      __result=$(returnCode leak)
    fi
  else
    __result=$?
  fi
  catchEnvironment "$handler" rm -f "$__before" "$__after" || return $?
  return "$__result"
}
_plumber() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_housekeeperAccountant() {
  local path cacheDirectory
  cacheDirectory="$1" && shift
  for path in "$@"; do
    if [ -d "$cacheDirectory" ]; then
      local saved
      saved=$(shaPipe <<<"$path")
      if [ -f "$cacheDirectory/$saved" ]; then
        cat "$cacheDirectory/$saved"
      else
        find "$path" -type f -print0 | xargs -0 sha1sum | tee "$cacheDirectory/$saved"
      fi
    else
      find "$path" -type f -print0 | xargs -0 sha1sum
    fi
  done | sort
}
housekeeper() {
  local handler="_${FUNCNAME[0]}"
  export TMPDIR
  local watchPaths path
  local __before __after __changed __ignore __pattern __cmd __tempDir=$TMPDIR
  local __result=0 overheadFlag=false __cacheDirectory=""
  local __ignore=()
  watchPaths=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --temporary) shift && __tempDir=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --ignore)
      shift
      __pattern="$(validate "$handler" String "grepPattern" "${1-}")" || return $?
      __ignore+=(-e "$__pattern")
      ;;
    --cache) shift && __cacheDirectory=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --overhead) overheadFlag=true ;;
    --path)
      shift
      path="$(validate "$handler" Directory "path" "${1-}")" || return $?
      watchPaths+=("$path")
      ;;
    *) if
      [ -d "$1" ]
    then
      watchPaths+=("$1")
    else
      break
    fi ;;
    esac
    shift
  done
  if [ "${#watchPaths[@]}" -eq 0 ]; then
    path=$(catchEnvironment "$handler" pwd) || return $?
    watchPaths+=("$path")
  fi
  [ $# -gt 0 ] || return 0
  isCallable "${1-}" || throwArgument "$handler" "$1 is not callable" "$@" || return $?
  __after=$(TMPDIR="$__tempDir" fileTemporaryName "$handler") || return $?
  __before="$__after.before"
  local start testStart testEnd
  start=$(timingStart)
  _housekeeperAccountant "$__cacheDirectory" "${watchPaths[@]}" >"$__before"
  testStart=$(timingStart)
  if "$@"; then
    testEnd=$(timingStart)
    _housekeeperAccountant "" "${watchPaths[@]}" >"$__after"
    if [ "${#__ignore[@]}" -gt 0 ]; then
      __changed="$(diff "$__before" "$__after" | grep -e '^[<>]' | grep -v "${__ignore[@]+${__ignore[@]}}" || :)"
    else
      __changed="$(diff "$__before" "$__after" | grep -e '^[<>]' || :)"
    fi
    __cmd=$(decorate each code -- "$@")
    if [ -n "$__changed" ]; then
      printf "%s\n" "$(decorate code "$__cmd") modified files:" "$(printf "%s\n" "$__changed" | decorate wrap "- ")" "Watching:" "$(printf "%s\n" "${watchPaths[@]}" | decorate wrap "- ")" 1>&2
      __result=$(returnCode leak)
    fi
  else
    __result=$?
  fi
  rm -rf "$__before" "$__after" || :
  if $overheadFlag; then
    local end overhead
    end=$(timingStart)
    overhead=$((end - start - (testEnd - testStart)))
    printf -- "housekeeper overhead: %s\n" "$(timingFormat "$overhead")"
  fi
  return "$__result"
}
_housekeeper() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
outputTrigger() {
  local handler="_${FUNCNAME[0]}"
  local name="${FUNCNAME[1]}}" verbose=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verbose=true
      ;;
    --name)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      [ -n "$1" ] || throwArgument "$handler" "Blank $argument argument" || return $?
      name="$1"
      ;;
    *) break ;;
    esac
    shift
  done
  local tempOutput lineCount=0
  tempOutput=$(fileTemporaryName "$handler") || return $?
  local finished=false
  while ! $finished; do
    read -r line || finished=true
    local delim=$'\n' && ! $finished || delim=""
    printf "%s%s" "$line" "$delim" >>"$tempOutput"
    lineCount=$((lineCount + 1))
  done
  if [ ! -s "$tempOutput" ]; then
    catchEnvironment "$handler" rm -rf "$tempOutput" || return $?
    ! $verbose || decorate info "No output in $(decorate code "$name") $(decorate value "$(pluralWord "$lineCount" line)")" || :
    return 0
  fi
  catchEnvironment "$handler" cat "$tempOutput" || return $?
  ! $verbose || throwEnvironment "$handler" "stderr found in $(decorate code "$name") $(decorate value "$(pluralWord "$lineCount" line)"): " "$@" || return $?
  return 1
}
_outputTrigger() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__filesOpenList() {
  lsof -a -d 0-2147483647 -p "$1"
}
__processChildrenIDs() {
  pgrep -P "$1"
}
filesOpenStatus() {
  local handler="_${FUNCNAME[0]}"
  local name="${FUNCNAME[1]}}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    esac
    shift
  done
  muzzle packageWhich lsof || return $?
  printf "%s\n" "PID: $$"
  __filesOpenList "$$"
  local child children=()
  read -r -a children < <(__processChildrenIDs "$$") || :
  for child in "${children[@]+"${children[@]}"}"; do
    printf "%s\n" "Child PID: $child"
    __filesOpenList "$child"
  done
}
_filesOpenStatus() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
debuggingStack() {
  local handler="_${FUNCNAME[0]}"
  local index count sources=() showExports=false addMe=false exitFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    -x) showExports=true ;;
    --me) addMe=true ;;
    --exit) exitFlag=true ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  if buildDebugEnabled debuggingStack; then
    showExports=true
    addMe=true
    printf -- "ARGS\n: %s %s\n" "${FUNCNAME[0]}" "$(decorate each quote "${__saved[@]+"${__saved[@]}"}" <&-)"
  fi
  sources=()
  count=${#FUNCNAME[@]}
  index=0
  while [ "$index" -lt "$count" ]; do
    sources+=("${BASH_SOURCE[index + 1]-}:${BASH_LINENO[index]-"$LINENO"} - ${FUNCNAME[index]-}")
    index=$((index + 1))
  done
  if $addMe; then
    sources+=("${BASH_SOURCE[0]}:$LINENO - ${FUNCNAME[0]} (ME)")
  fi
  ! $showExports || printf -- "STACK:\n"
  __debuggingStackCodeList "${sources[@]}" || :
  if $showExports; then
    printf -- "EXPORTS:\n"
    declare -px | removeFields 2
  fi
  ! $exitFlag || exit 0
}
_debuggingStack() {
  true || debuggingStack --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__debuggingStackCodeList() {
  local tick item index
  tick='`'
  index=0
  for item in "$@"; do
    printf -- '%d. %s%s%s\n' "$(($# - index))" "$tick" "$item" "$tick"
    index=$((index + 1))
  done
}
dumpPipe() {
  local handler="_${FUNCNAME[0]}"
  local showLines="" endBinary="head" names=() symbol="🐞" vanishFiles=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --head)
      endBinary="head"
      ;;
    --vanish)
      shift
      vanishFiles+=("$(validate "$handler" File "$argument" "${1-}")") || return $?
      ;;
    --tail)
      endBinary="tail"
      ;;
    --symbol)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      symbol="$1"
      ;;
    --lines) shift && showLines=$(validate "$handler" UnsignedInteger "showLines" "$1") || return $? ;;
    *)
      names+=("$argument")
      break
      ;;
    esac
    shift || throwArgument "$handler" shift || return $?
  done
  if [ -z "$showLines" ]; then
    export BUILD_DEBUG_LINES
    catchReturn "$handler" buildEnvironmentLoad BUILD_DEBUG_LINES || return $?
    showLines="${BUILD_DEBUG_LINES:-100}"
    isUnsignedInteger "$showLines" || returnEnvironment "BUILD_DEBUG_LINES is not an unsigned integer: $showLines" || showLines=10
  fi
  local item
  if [ "${#vanishFiles[@]}" -gt 0 ]; then
    for item in "${vanishFiles[@]}"; do
      local name
      name=$(decorate file "$(basename "$item")" "$item")
      catchEnvironment "$handler" dumpPipe "--$endBinary" --lines "$showLines" "${names[@]+"${names[@]}"}" "$name" <"$item" || return $?
      catchEnvironment "$handler" rm -rf "$item" || return $?
    done
    return 0
  fi
  item=$(fileTemporaryName "$handler") || return $?
  catchEnvironment "$handler" cat >"$item" || return $?
  local name="" nLines nBytes
  [ ${#names[@]} -eq 0 ] || name=$(decorate info "${names[*]}: ") || :
  nLines=$(($(fileLineCount "$item") + 0))
  nBytes=$(($(wc -c <"$item") + 0))
  [ ${#symbol} -eq 0 ] || symbol="$symbol "
  local suffix=""
  if [ $nBytes -eq 0 ]; then
    suffix=$(decorate orange "(empty)")
  elif [ "$showLines" -lt "$nLines" ]; then
    suffix="$(decorate warning "(showing $showLines $(plural "$showLines" line lines))")"
  else
    suffix="$(decorate success "(shown)")"
  fi
  statusMessage --last printf -- "%s%s %s, %s %s %s" \
    "$name" \
    "$nLines" "$(plural "$nLines" line lines)" \
    "$nBytes" "$(plural "$nBytes" byte bytes)" \
    "$suffix"
  if [ $nBytes -eq 0 ]; then
    rm -rf "$item" || :
    return 0
  fi
  local decoration width
  decoration="$(decorate code "$(consoleLine)")"
  width=$(consoleColumns) || throwEnvironment "$handler" consoleColumns || return $?
  printf -- "%s\n%s\n%s\n" "$decoration" "$("$endBinary" -n "$showLines" "$item" | decorate wrap --width "$((width - 2))" --fill " " "$symbol" "$(decorate reset --)")" "$decoration"
  rm -rf "$item" || :
}
_dumpPipe() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dumpFile() {
  local handler="_${FUNCNAME[0]}"
  local files=() dumpArgs=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --symbol) shift && dumpArgs+=("$argument" "$1") ;;
    --lines) shift && dumpArgs+=("--lines" "$1") ;;
    *)
      [ -f "$argument" ] || throwArgument "$handler" "$argument is not a item" || return $?
      files+=("$(validate "$handler" "File" "file" "$argument")") || return $?
      ;;
    esac
    shift
  done
  if [ ${#files[@]} -eq 0 ]; then
    catchEnvironment "$handler" dumpPipe "${dumpArgs[@]+${dumpArgs[@]}}" "(stdin)" || return $?
  else
    for tempFile in "${files[@]}"; do
      catchEnvironment "$handler" dumpPipe "${dumpArgs[@]+${dumpArgs[@]}}" "$tempFile" <"$tempFile" || return $?
    done
  fi
}
_dumpFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__internalDumpEnvironment() {
  local handler="$1" && shift
  local maxLen=64 skipEnv=() name matches=() fillMatches=true secureSuffix="- HIDDEN" showSkipped=false
  while read -r name; do
    if ! inArray "$name" PATH HOME OSTYPE PWD TERM; then skipEnv+=("$name"); fi
  done < <(environmentSecureVariables) || :
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --show-skipped)
      showSkipped=true
      ;;
    --maximum-length)
      shift
      maxLen=$(validate "$handler" PositiveInteger "$argument" "${1-}") || return $?
      ;;
    --skip-env)
      shift
      skipEnv+=("$(validate "$handler" EnvironmentVariable "$argument" "${1-}")") || return $?
      ;;
    --secure-match)
      shift
      case "${1-}" in
      "" | "-" | "--")
        matches=()
        fillMatches=false
        ;;
      *) matches+=("${1-}") ;;
      esac
      ;;
    --secure-suffix)
      shift
      secureSuffix="${1-}"
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  if "$fillMatches" && [ ${#matches[@]} -eq 0 ]; then
    matches=(key secret password)
  fi
  local secures=() regulars=() blanks=() skipped=()
  while read -r name; do
    if [ ${#skipEnv[@]} -gt 0 ] && inArray "$name" "${skipEnv[@]}"; then
      skipped+=("$name")
      continue
    fi
    local value="${!name-}"
    if [ ${#matches[@]} -gt 0 ] && stringContainsInsensitive "$name" "${matches[@]}"; then
      secures+=("$name")
    else
      if [ -n "$value" ]; then
        regulars+=("$name")
      else
        blanks+=("$name")
      fi
    fi
  done < <(environmentVariables | sort -u)
  [ ${#regulars[@]} -eq 0 ] || for name in "${regulars[@]}"; do
    local value="${!name-}"
    local len=${#value}
    [ "$len" -lt "$maxLen" ] || value="${value:0:maxLen} ... $(decorate green "$(pluralWord "$len" "character")")"
    value=$(newlineHide "$value" "$(decorate green "␤")")
    decorate pair -- "$name" "$value"
  done
  [ ${#blanks[@]} -eq 0 ] || decorate pair "[BLANK VARIABLES]" "$(decorate each code "${blanks[@]}")"
  ! $showSkipped || [ ${#skipped[@]} -eq 0 ] || decorate pair "[SKIPPED VARIABLES]" "$(decorate each code "${skipped[@]}")"
  [ ${#secures[@]} -eq 0 ] || for name in "${secures[@]}"; do
    local value="${!name-}"
    local len=${#value}
    decorate pair "$name" "$(decorate red "$len $(plural "$len" "character" "characters") $secureSuffix")"
  done
}
dumpEnvironment() {
  local handler="_${FUNCNAME[0]}"
  __internalDumpEnvironment "$handler" "$@" || return $?
}
_dumpEnvironment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dumpEnvironmentUnsafe() {
  local handler="_${FUNCNAME[0]}" argument
  [ $# -eq 0 ] || for argument in "--secure-match" "--secure-suffix"; do
    ! inArray "$argument" "$@" || throwArgument "$handler" "Unknown $argument (did you mean dumpEnvironment?)" || return $?
  done
  __internalDumpEnvironment "$handler" "$@" --secure-match - --secure-suffix ""
}
_dumpEnvironmentUnsafe() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dumpLoadAverages() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  local averages=()
  IFS=$'\n' read -d '' -r -a averages < <(catchEnvironment "$handler" loadAverage) || :
  catchEnvironment "$handler" decorate pair "Load averages:" "$(decorate each code "${averages[@]+"${averages[@]}"}")" || return $?
}
_dumpLoadAverages() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dumpHex() {
  local handler="_${FUNCNAME[0]}"
  local size="" arguments=()
  local runner=(od -w32 -A n -t xz -v)
  local runner=(od -t xCc)
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --size)
      shift
      size=$(validate "$handler" PositiveInteger "$argument" "${1-}") || return $?
      runner+=("-N" "$size")
      ;;
    *) arguments+=("$argument") ;;
    esac
    shift
  done
  executableExists od || throwEnvironment "$handler" "od required to be installed" || return $?
  if [ "${#arguments[@]}" -eq 0 ]; then
    "${runner[@]}"
  else
    local argument
    for argument in "${arguments[@]}"; do
      "${runner[@]}" <<<"$argument"
    done
  fi
}
_dumpHex() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dumpBinary() {
  local handler="_${FUNCNAME[0]}"
  local symbol="🔅" vanishFiles=() showBytes="" endBinary=tail names=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --vanish)
      shift
      vanishFiles+=("$(validate "$handler" File "$argument" "${1-}")") || return $?
      ;;
    --head)
      endBinary="head"
      ;;
    --tail)
      endBinary="tail"
      ;;
    --symbol)
      shift
      symbol="$1"
      ;;
    --bytes)
      shift
      if [ -n "$1" ]; then
        showBytes=$(validate "$handler" UnsignedInteger "bytes" "$1") || return $?
      fi
      ;;
    *)
      names+=("$argument")
      break
      ;;
    esac
    shift || throwArgument "$handler" shift || return $?
  done
  local item
  if [ "${#vanishFiles[@]}" -gt 0 ]; then
    for item in "${vanishFiles[@]}"; do
      local name
      name=$(decorate file "$(basename "$item")" "$item")
      catchEnvironment "$handler" dumpBinary --size "$showBytes" "${names[@]}" "$name" <"$item" || return $?
      catchEnvironment "$handler" rm -rf "$item" || return $?
    done
    return 0
  fi
  item=$(fileTemporaryName "$handler") || return $?
  catchEnvironment "$handler" cat >"$item" || return $?
  local name="" nLines nBytes
  [ ${#names[@]} -eq 0 ] || name=$(decorate info "${names[*]}: ")
  nLines=$(($(fileLineCount "$item") + 0))
  nBytes=$(($(wc -c <"$item") + 0))
  [ ${#symbol} -eq 0 ] || symbol="$symbol "
  if [ $nBytes -eq 0 ]; then
    suffix=$(decorate orange "(empty)")
  elif [ -n "$showBytes" ] && [ "$showBytes" -lt "$nBytes" ]; then
    suffix="$(decorate warning "(showing $showBytes $(plural "$showBytes" byte bytes))")"
  else
    suffix="$(decorate success "(shown)")"
  fi
  statusMessage --last printf -- "%s%s %s, %s %s %s" \
    "$name" \
    "$nLines" "$(plural "$nLines" line lines)" \
    "$nBytes" "$(plural "$nBytes" byte bytes)" \
    "$suffix"
  if [ $nBytes -eq 0 ]; then
    catchEnvironment "$handler" rm -rf "$item" || return $?
    return 0
  fi
  local endPreprocess=(cat)
  if [ -n "$showBytes" ]; then
    endPreprocess=("$endBinary" --bytes="$showBytes")
  fi
  catchEnvironment "$handler" "${endPreprocess[@]}" <"$item" | catchEnvironment "$handler" dumpHex | decorate code | decorate wrap "$symbol " || returnClean $? "$item" || return $?
  catchEnvironment "$handler" rm -rf "$item" || return $?
  return 0
}
_dumpBinary() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashDebug() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  bashDebuggerEnable
  "$@"
  bashDebuggerDisable
}
_bashDebug() {
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashDebuggerEnable() {
  export __BUILD_BASH_DEBUG_WATCH __BUILD_BASH_STEP_CONTROL __BUILD_BASH_DEBUG_LAST
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  __BUILD_BASH_DEBUG_WATCH=()
  __BUILD_BASH_STEP_CONTROL=()
  __BUILD_BASH_DEBUG_LAST="step"
  exec 20<&0 21>&1 22>&2
  set -o functrace
  shopt -s extdebug
  trap _bashDebugTrap DEBUG
}
_bashDebuggerEnable() {
  true || bashDebuggerEnable --help
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashDebuggerDisable() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  trap - DEBUG
  unset __BUILD_BASH_DEBUG_WATCH __BUILD_BASH_STEP_CONTROL __BUILD_BASH_DEBUG_LAST
  shopt -u extdebug
  set +o functrace
  exec 0<&20 1>&21 2>&22
  exec 20<&- 21>&- 22>&-
}
_bashDebuggerDisable() {
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_bashDebugWatch() {
  export __BUILD_BASH_DEBUG_WATCH
  [ "${#__BUILD_BASH_DEBUG_WATCH[@]}" -gt 0 ] || return 0
  local __item __index=0
  for __item in "${__BUILD_BASH_DEBUG_WATCH[@]}"; do
    local __value
    if ! __value="$(eval "printf \"%s\n\" \"$__item\"" 2>/dev/null)"; then
      __value="$(decorate red "unbound")"
    else
      __value="\"$(decorate code "$__value")\""
    fi
    printf -- "%2d: WATCH %s: %s\n" "$__index" "$__item" "$__value"
    __index=$((__index + 1))
  done
}
__bashDebugStep() {
  local source="$1" functionName="$2" line="$3" && shift 3
  [ $(($# % 3)) -eq 0 ] || returnArgument "__bashDebugStep $1 $2 $3: $# % 3 != 0" || return 1
  while [ $# -gt 0 ]; do
    checkSource="$1" checkFunctionName="$2" checkLine="$3"
    if [ "$checkSource" = "$source" ] && [ "$checkFunctionName" = "$functionName" ] && [ "$line" -gt "$checkLine" ]; then
      return 1
    fi
    shift 3
  done
}
__bashDebugWhere() {
  local index="${1:-0}" __where
  export BUILD_HOME
  __where="${BASH_SOURCE[index + 2]}"
  __where="$(directoryPathSimplify "$__where")"
  __where="${__where#"$BUILD_HOME"}"
  printf -- "%s:%s\n" "$(decorate value "$__where")" "$(decorate BOLD blue "${BASH_LINENO[index + 1]}")"
}
_bashDebugTrap() {
  export __BUILD_BASH_STEP_CONTROL
  if ! isArray __BUILD_BASH_STEP_CONTROL; then
    __BUILD_BASH_STEP_CONTROL=()
  fi
  if [ "${#__BUILD_BASH_STEP_CONTROL[@]}" -gt 0 ]; then
    [ "${BASH_SOURCE[1]}" != "${BASH_SOURCE[0]}" ] || return 0
    if __bashDebugStep "${BASH_SOURCE[1]}" "${FUNCNAME[1]}" $((BASH_LINENO[0] + 1)) "${__BUILD_BASH_STEP_CONTROL[@]}"; then
      return 0
    fi
    __BUILD_BASH_STEP_CONTROL=()
  fi
  case "$BASH_COMMAND" in
  bashDebuggerDisable | "trap - DEBUG" | '"$@"') return 0 ;;
  *) ;;
  esac
  local __where __cmd __item __value __rightArrow="➡️"
  export BUILD_HOME __BUILD_BASH_DEBUG_WATCH __BUILD_BASH_DEBUG_LAST
  exec 30<&0 31>&1 32>&2
  exec 0<&20 1>&21 2>&22
  local __topIndex=1
  printf "%s %s %s %s %s %s @ %s %s %s\n" "$(decorate code "${FUNCNAME[__topIndex + 2]-}")" "$__rightArrow" "$(decorate code "${FUNCNAME[__topIndex + 1]}")" "$__rightArrow" "$(decorate code "${FUNCNAME[__topIndex]}")" "$(decorate subtle "[${#FUNCNAME[@]}]")" "$(__bashDebugWhere 1)" ">" "$(__bashDebugWhere)"
  _bashDebugWatch
  printf -- "%s %s\n" "$(decorate green ">")" "$(decorate code "$BASH_COMMAND")"
  local __error="" __exitCode=0
  while read -n 1 -s -r -p "${__error}bashDebug $(decorate code "[$__BUILD_BASH_DEBUG_LAST]")> " __cmd </dev/tty; do
    local __aa=("$__cmd")
    __exitCode=0
    case "$__cmd" in
    "." | " " | "" | $'\r')
      __cmd="${__BUILD_BASH_DEBUG_LAST:0:1}"
      if [ -z "$__cmd" ]; then
        __error="$(decorate error "No last command")"
        __exitCode=1
        __aa=()
      else
        __aa=("${__BUILD_BASH_DEBUG_LAST:0:1}")
        [ ${#__BUILD_BASH_DEBUG_LAST} -eq 1 ] || __aa+=("${__BUILD_BASH_DEBUG_LAST:1}")
      fi
      ;;
    esac
    statusMessage printf -- "Execute: $(decorate code "$__cmd")"
    [ "${#__aa[@]}" -eq 0 ] || __bashDebugExecuteCommand "${__aa[@]}" || __exitCode=$?
    case $__exitCode in
    0)
      __error=""
      __exitCode=0
      break
      ;;
    1) ;;
    2)
      __error=""
      __exitCode=1
      break
      ;;
    3)
      exec 0<&30 1>&31 2>&32
      return 0
      ;;
    esac
    if [ -n "$__error" ]; then
      __error="${__error% } "
    fi
    statusMessage printf -- ""
  done
  exec 20<&0 21>&1 22>&2
  exec 0<&30 1>&31 2>&32
  return $__exitCode
}
__bashDebugExecuteCommand() {
  local __cmd="$1" __arg="${2-}"
  export __BUILD_BASH_DEBUG_LAST
  __error=""
  case "$__cmd" in
  "*")
    statusMessage printf -- ""
    if bashDebugInterruptFile 2>/dev/null; then
      statusMessage --last decorate info "$(decorate file "$HOME/.interrupt") will be created on interrupt"
    else
      statusMessage --last decorate notice "Interrupt handler already installed."
    fi
    return 1
    ;;
  "j")
    decorate warning "Skipping $BASH_COMMAND"
    __BUILD_BASH_DEBUG_LAST="jump"
    return 2
    ;;
  "d" | "i")
    statusMessage printf -- ""
    __BUILD_BASH_DEBUG_LAST="into"
    return 0
    ;;
  "k")
    statusMessage --last decorate info "Call stack:"
    debuggingStack
    return 1
    ;;
  "s" | "n")
    __bashDebugCommandStep
    statusMessage printf -- ""
    __BUILD_BASH_DEBUG_LAST="step"
    return 0
    ;;
  "?" | "h")
    _bashDebug 0
    return 1
    ;;
  "u")
    statusMessage printf -- ""
    __bashDebugCommandUnwatch
    return 1
    ;;
  "w")
    statusMessage printf -- ""
    __bashDebugCommandWatch
    return 1
    ;;
  "q")
    statusMessage --last decorate notice "Debugger control ended."
    bashDebuggerDisable
    return 3
    ;;
  "!")
    statusMessage printf -- ""
    if [ -n "$__arg" ]; then
      __bashDebugCommandEvaluate "$__arg"
    else
      __bashDebugCommandEvaluateLoop
    fi
    return 1
    ;;
  *)
    __error="[$(decorate error " $__cmd ")]($(decorate value "$(characterToInteger "$__cmd")")) No such command"
    return 1
    ;;
  esac
}
__bashDebugCommandStep() {
  local i=0 total=$((${#FUNCNAME[@]} - 1))
  while [ "$i" -lt "$total" ]; do
    if [ "$${BASH_SOURCE[i + 1]}" != "${BASH_SOURCE[0]}" ]; then
      __BUILD_BASH_STEP_CONTROL+=("${BASH_SOURCE[i + 1]}" "${FUNCNAME[i + 1]}" "$((BASH_LINENO[i] + 1))")
    fi
    i=$((i + 1))
  done
  return 0
}
__bashDebugCommandWatch() {
  local __item
  export __BUILD_BASH_DEBUG_WATCH
  while read -r -p "$(decorate info "Watch"): " __item; do
    if [ -z "$__item" ]; then
      statusMessage printf -- ""
      break
    fi
    decorate BOLD orange "Watching $(decorate code "$__item")"
    __BUILD_BASH_DEBUG_WATCH+=("$__item")
    _bashDebugWatch
  done
}
__bashDebugCommandUnwatch() {
  export __BUILD_BASH_DEBUG_WATCH
  while read -r -p "$(decorate warning "Unwatch"): " __item; do
    [ -n "$__item" ] || statusMessage printf -- "" && break
    local __index=0 __items=() __show=() __found
    __items=()
    __found=false
    for __value in "${__BUILD_BASH_DEBUG_WATCH[@]+"${__BUILD_BASH_DEBUG_WATCH[@]}"}"; do
      if [ "$__value" = "$__item" ] || [ "$__index" = "$__item" ]; then
        decorate BOLD orange "Removed $__item from watch list"
        __found=true
      else
        __show+=("[$(decorate value "$__index")] $(decorate code "$__value")")
        __items+=("$__value")
      fi
      __index=$((__index + 1))
    done
    if ! $__found; then
      printf -- "%s\n%s" "$(decorate error "No $__item found in watch list:")" "$(printf -- "- $(decorate code %s)\n" "${__show[@]+"${__show[@]}"}")"
    fi
    __BUILD_BASH_DEBUG_WATCH=("${__items[@]+"${__items[@]}"}")
    _bashDebugWatch
  done
}
__bashDebugCommandEvaluate() {
  local __cmd="$1"
  printf "%s \"%s\"\n" "$(decorate warning "Evaluating")" "$(decorate code "$__cmd")" >/dev/stdout
  exec 20<&0 21>&1 22>&2
  exec 0<&30 1>&31 2>&32
  set +eu
  set +o pipefail
  eval "$__cmd" || printf -- "%s\n" "EXIT $(decorate error "[$?]")" 1>&2
  set -eou pipefail
  exec 30<&0 31>&1 32>&2
  exec 0<&20 1>&21 2>&22
  export __BUILD_BASH_DEBUG_LAST
  __BUILD_BASH_DEBUG_LAST="!$__cmd"
}
__bashDebugCommandEvaluateLoop() {
  while read -r -p "$(decorate info "Shell"): " __cmd; do
    [ -n "$__cmd" ] || break
    __bashDebugCommandEvaluate "$__cmd"
  done
}
isUnsignedNumber() {
  [ $# -eq 1 ] || returnArgument "Single argument only: $*" || return $?
  case ${1#+} in --help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | . | *[!0-9.]* | *.*.*) return 1 ;; esac
}
isNumber() {
  [ $# -eq 1 ] || returnArgument "Single argument only: $*" || return $?
  case ${1#[-+]} in -help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | . | *[!0-9.]* | *.*.*) return 1 ;; esac
}
isInteger() {
  [ $# -eq 1 ] || returnArgument "Single argument only: $*" || return $?
  case ${1#[-+]} in -help) usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" 0 ;; '' | *[!0-9]*) return 1 ;; esac
}
isTrue() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || return 1
  while [ $# -gt 0 ]; do
    local value
    value=$(lowercase -- "$1")
    case "$value" in
    --help) "$handler" 0 && return $? || return $? ;;
    1 | true | yes | enabled | y) ;;
    "" | 0 | false | no | disabled | n | null | nil | "0.0") return 1 ;;
    *) ! isInteger "$value" || [ "$value" -ne 0 ] || ! isNumber "$value" || [ "$(floatTruncate "$value")" -ne 0 ] || return 1 ;;
    esac
    shift
  done
  return 0
}
_isTrue() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isType() {
  local text argument="${1-}"
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  if text=$(declare -p "$argument" 2>/dev/null); then
    case "$text" in
    *"declare -ax "*) printf -- "%s\n" "array" "export" ;;
    *"declare -a "*) printf -- "%s\n" "array" "local" ;;
    *"declare -x "*) printf -- "%s\n" "string" "export" ;;
    *"declare -- "*) printf -- "%s\n" "string" "local" ;;
    *"declare -fx "*) printf -- "%s\n" "function" "export" ;;
    *"declare -f "*) printf -- "%s\n" "function" "local" ;;
    *) throwArgument "$handler" "Unknown type: $1 -> \"$text\"" || return $? ;;
    esac
  elif [ "$(declare -F "$argument" || :)" = "$argument" ]; then
    printf "%s\n" "function"
  fi
}
_isType() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isArray() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    [ -n "${1-}" ] || return 1
    case "$(declare -p "${1-}" 2>/dev/null)" in
    *"declare -a"*) ;;
    *) return 1 ;;
    esac
    shift
  done
  return 0
}
_isArray() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isPositiveInteger() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || catchArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if isUnsignedInteger "${1-}"; then
    [ "$1" -gt 0 ] || return 1
    return 0
  fi
  return 1
}
_isPositiveInteger() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isFunction() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || catchArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ "$1" = "${1#-}" ] || return 1
  case "$(type -t "$1")" in function | builtin) [ "$1" != "." ] || return 1 ;; *) return 1 ;; esac
}
_isFunction() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isCallable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || throwArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if ! isFunction "$1" && ! isExecutable "$1"; then
    return 1
  fi
}
_isCallable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isExecutable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 1 ] || throwArgument "$handler" "Single argument only: $*" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ "$1" = "${1#-}" ] || return 1
  if [ -f "$1" ]; then
    local mode
    mode=$(catchEnvironment "$handler" ls -l "$1") || return $?
    mode="${mode%% *}"
    [ "${mode#*x}" != "$mode" ]
  else
    [ -n "$(command -v "$1")" ]
  fi
}
_isExecutable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_arguments() {
  local _handler_="_${FUNCNAME[0]}"
  local source="${1-}" this="${2-}"
  local handler="_$this"
  local stateFile checkFunction value clean required flags=() noneFlag=false
  ARGUMENTS="${ARGUMENTS-}"
  shift || throwArgument "$_handler_" "Missing this" || return $?
  shift || throwArgument "$_handler_" "Missing source" || return $?
  if [ "${1-}" = "--none" ]; then
    shift
    noneFlag=true
  fi
  stateFile=$(fileTemporaryName "$_handler_") || return $?
  spec=$(catchEnvironment "$_handler_" _commentArgumentSpecification "$source" "$this") || return $?
  catchEnvironment "$_handler_" _commentArgumentSpecificationDefaults "$spec" >"$stateFile" || return $?
  IFS=$'\n' read -d '' -r -a required <"$(__commentArgumentSpecification__required "$spec")" || :
  clean=("$stateFile")
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    type="$(_commentArgumentType "$spec" "$stateFile" "$__index" "$argument")" || returnClean "$?" "${clean[@]}" || return $?
    case "$type" in
    Flag)
      argumentName="$(_commentArgumentName "$spec" "$stateFile" "$__index" "$argument")" || returnClean "$?" "${clean[@]}" || return $?
      catchReturn "$handler" environmentValueWrite "$argumentName" "true" >>"$stateFile" || returnClean "$?" "${clean[@]}" || return $?
      if ! inArray "$argumentName" "${flags[@]+"${flags[@]}"}"; then
        flags+=("$argumentName")
      fi
      ;;
    -)
      shift
      break
      ;;
    *)
      if
        _commentArgumentTypeValid "${type#!}"
      then
        type="${type#!}"
        argumentName="$(_commentArgumentName "$spec" "$stateFile" "$__index" "$argument")" || returnClean "$?" "${clean[@]}" || return $?
      elif _commentArgumentTypeValid "$type"; then
        argumentName="$(_commentArgumentName "$spec" "$stateFile" "$__index" "$argument")" || returnClean "$?" "${clean[@]}" || return $?
        shift
        argument="${1-}"
      else
        find "$spec" -type f 1>&2
        dumpPipe stateFile <"$stateFile" 1>&2
        throwArgument "$handler" "unhandled argument type \"$type\" #$__index: $argument" || returnClean "$?" "${clean[@]}" || return $?
      fi
      checkFunction="handler""Argument$type"
      value="$("$checkFunction" "$handler" "$argumentName" "$argument")" || returnClean "$?" || return $?
      catchReturn "$handler" environmentValueWrite "$argumentName" "$value" >>"$stateFile" || returnClean "$?" || return $?
      ;;
    esac
    shift || throwArgument "$handler" "missing argument #$__index: $argument" || returnClean "$?" "${clean[@]}" || return $?
  done
  stateFile=$(_commentArgumentsRemainder "$handler" "$spec" "$stateFile" "$@") || returnClean "$?" "${clean[@]}" || return $?
  if inArray "help" "${flags[@]+"${flags[@]}"}"; then
    "$handler" 0
    rm -rf "${clean[@]}" || :
    return "$(returnCode exit)"
  fi
  if $noneFlag; then
    catchEnvironment "$_handler_" rm -rf "$stateFile" || return $?
    unset ARGUMENTS || return $?
    return 0
  fi
  if [ "${#flags[@]}" -gt 0 ]; then
    catchReturn "$handler" environmentValueWrite "_flags" "${flags[@]}" >>"$stateFile" || return $?
  fi
  ARGUMENTS="$stateFile" || return $?
}
__arguments() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_argumentReturn() {
  local exitCode="$1"
  [ "$exitCode" -ne "$(returnCode exit)" ] || exitCode=0
  printf "%d\n" "$exitCode"
}
__commentArgumentSpecificationMagic() {
  local handler="${1-}" specificationDirectory="${2-}"
  local magicFile="$specificationDirectory/.magic"
  if test "${3-}"; then
    catchEnvironment "$handler" touch "$magicFile" || return $?
  else
    [ -f "$magicFile" ] || throwEnvironment "$handler" "$specificationDirectory is not magic" || return $?
  fi
}
_commentArgumentSpecification() {
  local handler="_${FUNCNAME[0]}"
  local functionDefinitionFile="${1-}" functionName="${2-}"
  local functionCache cacheFile argumentIndex argumentDirectory argumentLine
  functionCache=$(catchReturn "$handler" buildCacheDirectory "ARGUMENTS") || return $?
  functionCache="$functionCache/$functionName"
  cacheFile="$functionCache/documentation"
  argumentDirectory=$(catchReturn "$handler" directoryRequire "$functionCache/parsed") || return $?
  catchEnvironment "$handler" touch "$functionCache/.magic" || return $?
  if [ ! -f "$functionDefinitionFile" ] && ! pathIsAbsolute "$functionDefinitionFile"; then
    local home
    home=$(catchReturn "$handler" buildHome) || return $?
    if [ -f "$home/$functionDefinitionFile" ]; then
      functionDefinitionFile="$home/$functionDefinitionFile"
    fi
  fi
  [ -f "$functionDefinitionFile" ] || throwArgument "$handler" "$functionDefinitionFile does not exist" || return $?
  [ -n "$functionName" ] || throwArgument "$handler" "functionName is blank" || return $?
  if [ ! -f "$cacheFile" ] || [ "$(fileNewest "$cacheFile" "$functionDefinitionFile")" = "$functionDefinitionFile" ]; then
    catchReturn "$handler" bashDocumentationExtract "$functionName" "$functionDefinitionFile" >"$cacheFile" < <(catchReturn "$handler" bashFunctionComment "$functionDefinitionFile" "$functionName") || return $?
    for file in "$(__commentArgumentSpecification__required "$functionCache")" "$(__commentArgumentSpecification__defaults "$functionCache")"; do
      catchEnvironment "$handler" printf "" >"$file" || return $?
    done
  fi
  argumentsFile="$functionCache/arguments"
  if [ ! -f "$argumentsFile" ] || [ "$(fileNewest "$cacheFile" "$argumentsFile")" = "$cacheFile" ]; then
    (
      local argument
      argument=
      source "$cacheFile"
      printf "%s\n" "$argument" >"$argumentsFile"
      rm -rf "${argumentDirectory:?}/*" || :
    ) || throwEnvironment "$handler" "Loading $cacheFile" || return $?
  fi
  if [ ! -f "$argumentDirectory/@" ]; then
    catchEnvironment "$handler" printf "%s" "" >"$functionCache/flags" || return $?
    argumentId=1
    while IFS=" " read -r -a argumentLine; do
      catchReturn "$handler" _commentArgumentSpecificationParseLine "$functionCache" "$argumentId" "${argumentLine[@]+"${argumentLine[@]}"}" || return $?
      argumentId=$((argumentId + 1))
    done <"$argumentsFile"
    catchEnvironment "$handler" date >"$argumentDirectory/@" || return $?
    __commentArgumentSpecificationMagic "$handler" "$functionCache" 1
  fi
  printf "%s\n" "$functionCache"
}
__commentArgumentSpecification() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_commentArgumentSpecificationComplete() {
  local handler="_${FUNCNAME[0]}" functionCache="$1" previous="$2" word="$3"
  if [ -z "$previous" ]; then
    local runner=(cat)
    [ -z "$word" ] || runner=(grepSafe -e "^$(quoteGrepPattern "$word")")
    "${runner[@]}" "$functionCache/flags"
  elif [ -f "$functionCache/parsed/$previous" ]; then
    local argumentType
    if argumentType=$(environmentValueRead "$functionCache/parsed/$previous" "argumentType"); then
      local completionFunction="__completionType$argumentType"
      if isFunction "$completionFunction"; then
        "$completionFunction" "$word"
      else
        printf "%s\n" "noCompletion:$argumentType"
      fi
    fi
  fi
}
__commentArgumentSpecification__defaults() {
  printf "%s/%s\n" "$1" "defaults"
}
__commentArgumentSpecification__required() {
  printf "%s/%s\n" "$1" "required"
}
_commentArgumentSpecificationDefaults() {
  local handler="_${FUNCNAME[0]}"
  local specification="${1-}"
  __commentArgumentSpecificationMagic "$handler" "$specification" || return $?
  file=$(__commentArgumentSpecification__defaults "$specification")
  if [ -f "$file" ]; then
    cat "$file"
  else
    printf "%s\n" "# No defaults"
  fi
}
__commentArgumentSpecificationDefaults() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_commentArgumentSpecificationParseLine() {
  local functionCache="${1-}" argumentId="${2-}"
  local argumentDirectory="${functionCache%/}/parsed"
  local argumentRemainder=false
  [ -d "$argumentDirectory" ] || returnArgument "$argumentDirectory is not a directory" || return $?
  isUnsignedInteger "$argumentId" || returnArgument "$argumentId is not an integer" || return $?
  shift 2
  local argument file
  local required argumentType argumentName argumentDefault="" argumentFlag=false
  local argumentName="" argumentIndex="" argumentFinder="" argumentRepeat=false doubleDashDelimit=false
  local savedLine
  savedLine="$(decorate each code -- "$@")"
  while [ "$#" -gt 0 ]; do
    local argument="$1"
    case "$argument" in
    --)
      doubleDashDelimit="--"
      ;;
    --[[:alnum:]]* | -[[:alpha:]]*)
      argumentIndex=
      argumentFlag=true
      argumentFinder="$argument"
      argumentName="${argument#-}"
      argumentName="${argumentName#-}"
      argumentRepeat=false
      if [ "${argumentName%...}" != "$argumentName" ]; then
        argumentRepeat=true
        argumentName="${argumentName%...}"
      fi
      ;;
    ...)
      if
        [ -z "$argumentName" ]
      then
        argumentRemainder=true
      else
        argumentRepeat=true
      fi
      ;;
    -)
      shift
      break
      ;;
    *)
      if
        [ -f "$argumentDirectory/index" ]
      then
        argumentIndex=$(($(head -n 1 "$argumentDirectory/index") + 1))
      else
        argumentIndex=0
      fi
      [ -n "$argumentFinder" ] || argumentFinder="#--$argumentIndex"
      printf "%d\n" "$argumentIndex" >"$argumentDirectory/index"
      argumentName="$argument"
      ;;
    esac
    shift
  done
  [ $# -eq 0 ] && return 0
  [ $# -ge 1 ] || returnArgument "$argumentId missing type: $savedLine" || return $?
  local rawType="${1%.}" maybeRequired="${2%.}"
  if required=$(_commentArgumentParseRequired "$maybeRequired" "$rawType"); then
    case "$required" in required) required=true ;; *) required=false ;; esac
  fi
  if ! argumentType=$(_commentArgumentTypeValid "$rawType" "$maybeRequired"); then
    returnArgument "Invalid argument type in: \"$rawType\" \"$maybeRequired\" (Required. was \"$required\")" || return $?
  fi
  description="$*"
  if ! $argumentRemainder || [ -n "$argumentName" ]; then
    for argument in argumentType argumentName argumentFinder; do
      [ -n "${!argument}" ] || returnArgument "Require a value for $argument in line: $savedLine" || return $?
    done
    {
      environmentValueWrite argumentName "$argumentName"
      environmentValueWrite argumentRepeat "$argumentRepeat"
      environmentValueWrite argumentType "$argumentType"
      environmentValueWrite argumentId "$argumentIndex"
      environmentValueWrite argumentRequired "$required"
      environmentValueWrite argumentFinder "$argumentFinder"
      environmentValueWrite argumentDelimiter "$doubleDashDelimit"
      environmentValueWrite argumentFlag "$argumentFlag"
      environmentValueWrite description "$description"
    } >"$argumentDirectory/$argumentFinder" || returnArgument "Unable to write $argumentDirectory/$argumentFinder" || return $?
    if $required; then
      catchEnvironment "$handler" printf "%s\n" "$argumentName" >>"$(__commentArgumentSpecification__required "$functionCache")" || return $?
    fi
    if inArray "$argumentType" "Boolean" "Flag"; then
      argumentDefault=false
    fi
    if [ -n "$argumentDefault" ]; then
      catchReturn "$handler" environmentValueWrite "${argumentName/-/_}" "$argumentDefault" >>"$(__commentArgumentSpecification__defaults "$functionCache")" || return $?
    fi
  fi
  if $argumentRemainder; then
    printf "%s\n" true >"$functionCache/remainder"
  fi
  if $argumentFlag; then
    printf "%s\n" "$argumentFinder" >>"$functionCache/flags"
  fi
}
__commentArgumentSpecificationParseLine() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_commentArgumentParseRequired() {
  while [ $# -gt 0 ]; do
    local text
    text="$(lowercase "${1-}")"
    if [ "${text#required}" != "$text" ]; then
      printf "%s\n" "required"
      return 0
    fi
    if [ "${text#optional}" != "$text" ]; then
      printf "%s\n" "optional"
      return 0
    fi
    shift
  done
  return 1
}
_commentArgumentTypeValid() {
  while [ $# -gt 0 ]; do
    local type="${1-}"
    case "$type" in
    File | FileDirectory | Directory | LoadEnvironmentFile | RealDirectory)
      printf "%s\n" "$type"
      return 0
      ;;
    EmptyString | String | EnvironmentVariable)
      printf "%s\n" "$type"
      return 0
      ;;
    Flag | Boolean | PositiveInteger | Integer | UnsignedInteger | Number)
      printf "%s\n" "$type"
      return 0
      ;;
    Executable | Callable | Function)
      printf "%s\n" "$type"
      return 0
      ;;
    URL)
      printf "%s\n" "$type"
      return 0
      ;;
    Arguments)
      printf "%s\n" "$type"
      return 0
      ;;
    esac
    shift
  done
  return 1
}
_commentArgumentName() {
  local handler="_${FUNCNAME[0]}"
  local specification="${1-}" stateFile="${2-}" argumentIndex="${3-}" argumentValue="${4-}" argumentNamed
  __commentArgumentSpecificationMagic "$handler" "$specification" || return $?
  specification="$specification/parsed"
  if [ -f "$specification/$argumentValue" ]; then
    environmentValueRead "$specification/$argumentValue" argumentName not-named
    return 0
  fi
  argumentNamed="$(environmentValueRead "$stateFile" argumentNamed "")"
  if [ -z "$argumentNamed" ]; then
    returnEnvironment "No current argument" || return $?
  fi
  if isUnsignedInteger "$argumentNamed"; then
    environmentValueRead "$specification/#--$argumentNamed" argumentName not-named
  fi
  return 0
}
___commentArgumentName() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_commentArgumentTypeFromSpec() {
  local handler="$1" specification="$2" argumentType argumentRepeat="${4-}"
  argumentType=$(catchReturn "$handler" environmentValueRead "$specification" argumentType undefined) || return $?
  [ -n "$argumentRepeat" ] || argumentRepeat=$(catchReturn "$handler" environmentValueRead "$specification" argumentRepeat false) || return $?
  printf "%s%s%s" "$3" "$argumentType" "$(catchEnvironment "$handler" booleanChoose "$argumentRepeat" '*' '')" || return $?
}
_commentArgumentType() {
  local handler="_${FUNCNAME[0]}"
  local specification="${1-}" stateFile="${2-}" argumentIndex="${3-}" argumentValue="${4-}"
  local argumentNamed argumentRepeat argumentSpec
  __commentArgumentSpecificationMagic "$handler" "$specification" || return $?
  specification="$specification/parsed"
  argumentSpec="$specification/$argumentValue"
  if [ -f "$argumentSpec" ]; then
    _commentArgumentTypeFromSpec "$handler" "$argumentSpec" "" || return $?
    return 0
  fi
  argumentNamed="$(environmentValueRead "$stateFile" argumentNamed "")"
  argumentRepeatName="$(environmentValueRead "$stateFile" argumentRepeatName false)"
  if [ -z "$argumentNamed" ]; then
    argumentNamed=0
  elif [ "$argumentRepeatName" != "$argumentNamed" ]; then
    argumentNamed=$((argumentNamed + 1))
  fi
  argumentSpec="$specification/#--$argumentNamed"
  if [ ! -f "$argumentSpec" ]; then
    printf -- "%s" "-"
    return 0
  fi
  environmentValueWrite argumentNamed "$argumentNamed" >>"$stateFile"
  if [ -z "$argumentRepeatName" ]; then
    argumentRepeat="$(environmentValueRead "$argumentSpec" argumentRepeat false)"
    isBoolean "$argumentRepeat" || throwEnvironment "$handler" "$argumentSpec non-boolean argumentRepeat" || return $?
    if $argumentRepeat; then
      catchReturn "$handler" environmentValueWrite argumentRepeatName "$argumentNamed" >>"$stateFile" || return $?
    fi
  fi
  _commentArgumentTypeFromSpec "$handler" "$argumentSpec" "!" "$argumentRepeat" || return $?
  return 0
}
__commentArgumentType() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_commentArgumentsRemainder() {
  local handler="$1" specification="$2" stateFile="$3" name value done=false
  shift && shift && shift
  __commentArgumentSpecificationMagic "$handler" "$specification" || return $?
  while ! $done; do
    read -d '' -r name || done=true
    [ -n "$name" ] || continue
    value="$(catchReturn "$handler" environmentValueRead "$stateFile" "$name" "")" || return $?
    if [ -z "$value" ]; then
      throwArgument "$handler" "$name is required" || return $?
    fi
  done <"$(__commentArgumentSpecification__required "$specification")"
  if [ $# -gt 0 ]; then
    if [ -f "$specification/remainder" ]; then
      catchReturn "$handler" environmentValueWrite _remainder "$@" >>"$stateFile" || return $?
    else
      throwArgument "$handler" "Unknown arguments $#: $(decorate each code -- "$@")" || return $?
    fi
  fi
  printf "%s\n" "$stateFile" "$@"
}
__help() {
  [ $# -gt 0 ] || ! ___help 0 || return 0
  local flag="--help"
  local handler="${1-}" && shift
  if [ "$handler" = "--only" ]; then
    handler="${1-}" && shift
    [ $# -gt 0 ] || return 0
    [ "$#" -eq 1 ] && [ "${1-}" = "$flag" ] || throwArgument "$handler" "Only argument allowed is \"$flag\": $*" || return $?
  fi
  while [ $# -gt 0 ]; do
    [ "$1" != "$flag" ] || ! "$handler" 0 || return 1
    shift
  done
  return 0
}
___help() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_processSignal() {
  local signal="$1"
  local signals
  shift || returnArgument "missing signal" || return $?
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
processWait() {
  local handler="_${FUNCNAME[0]}"
  local processId processIds=() requireFlag=false verboseFlag=false timeout=-1 signalTimeout=1 signals=()
  local start && start=$(timingStart) || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --require)
      requireFlag=true
      ;;
    --verbose)
      verboseFlag=true
      ;;
    --signals)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      IFS=',' read -r -a signals < <(uppercase "$1")
      for signal in "${signals[@]}"; do
        case "$signal" in
        STOP | QUIT | INT | KILL | HUP | ABRT | TERM) ;;
        *) throwArgument "$handler" "Invalid signal $signal" || return $? ;;
        esac
      done
      ;;
    --timeout)
      shift || throwArgument "$handler" "missing $argument" || return $?
      timeout=$(validate "$handler" Integer "timeout" "$1") || return $?
      signalTimeout=$timeout
      ;;
    *)
      processId=$(validate "$handler" Integer "processId" "$1") || return $?
      processIds+=("$processId")
      ;;
    esac
    shift
  done
  local elapsed lastSignal sinceLastSignal now
  local timeout signalTimeout
  local signals signal
  local processIds aliveIds
  local requireFlag verboseFlag signals signal
  local STATUS_THRESHOLD=10
  local processTemp
  if [ 0 -eq ${#processIds[@]} ]; then
    throwArgument "$handler" "Requires at least one processId" || return $?
  fi
  local start sendSignals sendSignals=("${signals[@]+"${signals[@]}"}") lastSignal=0 elapsed=0 processTemp
  start=$(date +%s) || throwEnvironment "$handler" "date failed" || return $?
  processTemp=$(fileTemporaryName "$handler") || return $?
  while [ ${#processIds[@]} -gt 0 ]; do
    catchEnvironment "$handler" _processSignal 0 "${processIds[@]}" >"$processTemp" || return $?
    aliveIds=()
    while read -r processId; do ! isInteger "$processId" || aliveIds+=("$processId"); done <"$processTemp"
    rm -f "$processTemp" || :
    if $requireFlag; then
      if [ ${#processIds[@]} -ne ${#aliveIds[@]} ]; then
        throwEnvironment "$handler" "All processes must be alive to start: ${processIds[*]} (Alive: ${aliveIds[*]-none})" || return $?
      fi
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
        sendSignals=("${sendSignals[@]+"${sendSignals[@]}"}")
        ! $verboseFlag || statusMessage decorate info "Sending $(decorate label "$signal") to $(IFS=, decorate code "${processIds[*]}")"
        catchEnvironment "$handler" _processSignal "$signal" "${processIds[@]}" >"$processTemp" || return $?
        aliveIds=()
        while read -r processId; do ! isInteger "$processId" || aliveIds+=("$processId"); done <"$processTemp"
        ! $verboseFlag && IFS=, statusMessage decorate info "Processes: ${processIds[*]} -> Alive: $(IFS=, decorate code "${aliveIds[*]-none}")"
      fi
      lastSignal=$now
      sinceLastSignal=0
    fi
    if [ "$timeout" -gt 0 ] && [ "$sinceLastSignal" -ge "$timeout" ] && [ ${#sendSignals[@]} -eq 0 ]; then
      throwEnvironment "$handler" "Expired after $elapsed $(plural "$elapsed" second seconds) (timeout: $timeout, signals: ${signals[*]-wait}) Alive: ${aliveIds[*]-none}" || return $?
    fi
    if [ "$elapsed" -gt "$STATUS_THRESHOLD" ] || $verboseFlag; then
      statusMessage decorate info "${handler#_} ${processIds[*]} (${sendSignals[*]-wait}, $sinceLastSignal) - $elapsed seconds"
    fi
    sleep 1 || throwEnvironment "$handler" "sleep interrupted" || return $?
  done
  if [ "$elapsed" -gt "$STATUS_THRESHOLD" ] || $verboseFlag; then
    statusMessage --last decorate warning "$elapsed $(plural "$elapsed" second seconds) elapsed (threshold is $(decorate code "$STATUS_THRESHOLD"))"
  fi
}
_processWait() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
processMemoryUsage() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local pid="$argument"
      catchArgument "$handler" isInteger "$pid" || return $?
      value="$(ps -o rss -p "$pid" | tail -n 1 | trimSpace)" || throwEnvironment "$handler" "Failed to get process status for $pid" || return $?
      isInteger "$value" || throwEnvironment "$handler" "Bad memory value for $pid: $value" || return $?
      printf %d $((value * 1))
      ;;
    esac
    shift
  done
}
_processMemoryUsage() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
processVirtualMemoryAllocation() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local pid="$argument" value
      catchArgument "$handler" isInteger "$pid" || return $?
      value="$(ps -o vsz -p "$pid" | tail -n 1 | trimSpace)"
      isInteger "$value" || throwEnvironment "$handler" "ps returned non-integer: \"$(decorate code "$value")\"" || return $?
      printf %d $((value * 1))
      ;;
    esac
    shift
  done
}
_processVirtualMemoryAllocation() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
processOpenPipes() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local pid
      pid="$(validate "$handler" Integer "pid" "$argument")" || return $?
      lsof -c 9999 -g "$pid" -l -F ckns
      ;;
    esac
    shift
  done
}
_processOpenPipes() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
runCount() {
  local handler="_${FUNCNAME[0]}"
  local total=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$total" ]
    then
      isUnsignedInteger "$argument" || throwArgument "$handler" "$argument must be a positive integer" || return $?
      total="$argument"
    else
      local index=0
      while [ "$index" -lt "$total" ]; do
        index=$((index + 1))
        "$@" || throwEnvironment "$handler" "iteration #$index" "$@" return $?
      done
      return 0
    fi ;;
    esac
    shift || throwArgument "$handler" shift || return $?
  done
}
_runCount() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileReverseLines() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}
_fileReverseLines() {
  true || fileReverseLines --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashMakeExecutable() {
  local handler="_${FUNCNAME[0]}"
  local path findArgs=() paths=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --find)
      local tempArgs && shift && IFS=' ' read -r -a tempArgs <<<"${1-}" || :
      findArgs+=("${tempArgs[@]+"${tempArgs[@]}"}")
      ;;
    *) paths+=("$(validate "$handler" Directory "directory" "$1")") || return $? ;;
    esac
    shift
  done
  [ "${#paths[@]}" -gt 0 ] || paths+=("$(catchEnvironment "$handler" pwd)") || return $?
  (for path in "${paths[@]}"; do
    catchEnvironment "$handler" cd "$path" || return $?
    find "." -name '*.sh' -type f ! -path "*/.*/*" "${findArgs[@]+"${findArgs[@]}"}" -exec chmod -v +x {} \;
  done) || return $?
}
_bashMakeExecutable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
executableExists() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$# anyFlag=false
  [ $# -gt 0 ] || throwArgument "$handler" "no arguments" || return $?
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --any) anyFlag=true ;;
    *)
      local bin
      bin=$(command -v "$1" 2>/dev/null) || return 1
      [ -n "$bin" ] || return 1
      [ "${bin:0:1}" != "/" ] || [ -e "$bin" ] || return 1
      ! $anyFlag || return 0
      ;;
    esac
    shift
  done
}
_executableExists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
serviceToStandardPort() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || throwArgument "$handler" "No arguments" || return $?
  local port
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    argument=$(catchReturn "$handler" trimSpace "$argument") || return $?
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    ssh) port=22 ;;
    http) port=80 ;;
    https) port=443 ;;
    mariadb | mysql) port=3306 ;;
    postgres) port=5432 ;;
    *) throwEnvironment "$handler" "$argument unknown" || return $? ;;
    esac
    printf "%d\n" "$port"
    shift
  done
}
_serviceToStandardPort() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
serviceToPort() {
  local handler="_${FUNCNAME[0]}"
  local port servicesFile=/etc/services service
  [ $# -gt 0 ] || throwArgument "$handler" "Require at least one service" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --services)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      servicesFile=$(validate "$handler" File "servicesFile" "$1") || return $?
      ;;
    *) if
      [ ! -f "$servicesFile" ]
    then
      catchEnvironment "$handler" serviceToStandardPort "$@" || return $?
    else
      service="$(trimSpace "$argument")"
      [ -n "$service" ] || throwArgument "$handler" "whitespace argument: $(decorate quote "$argument") #$__index/$__count" || return $?
      if port="$(grep /tcp "$servicesFile" | grep "^$service\s" | awk '{ print $2 }' | cut -d / -f 1)"; then
        isInteger "$port" || throwEnvironment "$handler" "Port found in $servicesFile is not an integer: $port" || return $?
      else
        port="$(serviceToStandardPort "$service")" || throwEnvironment "$handler" serviceToStandardPort "$service" || return $?
      fi
      printf "%d\n" "$port"
    fi ;;
    esac
    shift
  done
}
_serviceToPort() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__fileExtensionListsLog() {
  local directory="$1" original="$2"
  local name extension
  name="$(basename "$original")" || returnArgument "basename $name" || return $?
  extension="${name##*.}"
  [ "${name%%.*}" != "" ] && [ "$extension" != "$name" ] && [ "$extension" != "." ] && [ "$extension" != ".." ] && [ -n "$extension" ] || extension="!"
  printf "%s\n" "$original" | tee -a "$directory/@" >>"$directory/$extension" || returnEnvironment "writing $directory/$extension" || return $?
}
fileExtensionLists() {
  local handler="_${FUNCNAME[0]}"
  local names=() directory="" cleanFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --clean)
      cleanFlag=true
      ;;
    *) if
      [ -z "$directory" ]
    then
      directory=$(validate "$handler" Directory "directory" "$1") || return $?
    else
      names+=("$1")
    fi ;;
    esac
    shift
  done
  [ -n "$directory" ] || throwArgument "$handler" "No directory supplied" || return $?
  ! $cleanFlag || catchEnvironment "$handler" find "$directory" -type f -delete || return $?
  local name
  if [ ${#names[@]} -gt 0 ]; then
    for name in "${names[@]}"; do
      catchReturn "$handler" __fileExtensionListsLog "$directory" "$name" || return $?
    done
  else
    catchEnvironment "$handler" touch "$directory/@" || return $?
    while read -r name; do
      catchReturn "$handler" __fileExtensionListsLog "$directory" "$name" || return $?
    done
  fi
}
_fileExtensionLists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
loadAverage() {
  local handler="_${FUNCNAME[0]}"
  local text
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local averages=()
  if [ -f "/proc/loadavg" ]; then
    text="$(cat /proc/loadavg)"
  elif executableExists uptime; then
    text=$(catchEnvironment "$handler" uptime) || return $?
    text="${text##*average}"_
    text="${text##*:}"
    text="${text# }"
    text="${text//,/ }"
    text="${text//  / }"
  fi
  read -r -a averages <<<"$text" || :
  printf "%s\n" "${averages[0]}" "${averages[1]-}" "${averages[2]-}"
}
_loadAverage() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__pcregrepInstall() {
  packageGroupWhich "$(__pcregrepBinary)" pcregrep || return $?
}
pathRemove() {
  local handler="_${FUNCNAME[0]}"
  local items=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) items+=("$(validate "$handler" Directory "path" "$1")") || return $? ;;
    esac
    shift
  done
  [ "${#items[@]}" -gt 0 ] || return 0
  export PATH
  PATH="$(catchEnvironment "$handler" listRemove "${PATH-}" ':' "${items[@]}")" || return $?
}
_pathRemove() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pathConfigure() {
  local handler="_${FUNCNAME[0]}"
  export PATH
  local tempPath="${PATH-}" firstFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --first) firstFlag=true ;;
    --last) firstFlag=false ;;
    *)
      local item
      item=$(validate "$handler" Directory "path" "$1") || return $?
      $firstFlag && tempPath="$item:$tempPath" || tempPath="$tempPath:$item"
      ;;
    esac
    shift
  done
  tempPath="${tempPath#:}"
  tempPath="${tempPath%:}"
  PATH="$tempPath"
}
_pathConfigure() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_pathIsDirectory() {
  [ -n "$1" ] || return 1
  [ -d "$1" ] || return 1
}
pathCleanDuplicates() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  export PATH
  newPath=$(catchEnvironment "$handler" listCleanDuplicates --test _pathIsDirectory ':' "${PATH-}") || return $?
  PATH="$newPath"
}
_pathCleanDuplicates() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pathShow() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *) break ;;
    esac
    shift
  done
  local bf=() pp=() bb=("$@")
  IFS=":" read -r -a pp <<<"$PATH"
  local p
  for p in "${pp[@]}"; do
    local bt=() b
    for b in "${bb[@]+${bb[@]}}"; do
      if [ -x "$p/$b" ]; then
        local style=success
        if inArray "$b" "${bf[@]+"${bf[@]}"}"; then
          style=warning
        else
          bf+=("$b")
        fi
        bt+=("$(decorate "$style" "$b")")
      fi
    done
    [ "${#bt[@]}" -gt 0 ] || bt+=("$(decorate info none)")
    decorate pair 100 "$p" "${bt[*]}"
  done
  local foundAll=true
  for b in "${bb[@]+${bb[@]}}"; do
    if ! inArray "$b" "${bf[@]+"${bf[@]}"}"; then
      foundAll=false
      decorate error "binary $(decorate code "$b") not found" 1>&2
    fi
  done
  $foundAll
}
_pathShow() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
manPathConfigure() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local tempPath
  export MANPATH
  catchReturn "$handler" buildEnvironmentLoad MANPATH || return $?
  tempPath="$(catchEnvironment "$handler" listAppend "$MANPATH" ':' "$@")" || return $?
  MANPATH="$tempPath"
}
_manPathConfigure() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
manPathRemove() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local tempPath
  export MANPATH
  catchReturn "$handler" buildEnvironmentLoad MANPATH || return $?
  tempPath="$(catchEnvironment "$handler" listRemove "$MANPATH" ':' "$@")" || return $?
  MANPATH="$tempPath"
}
_manPathRemove() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
manPathCleanDuplicates() {
  local handler="_${FUNCNAME[0]}" newPath
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  export MANPATH
  catchReturn "$handler" buildEnvironmentLoad MANPATH || return $?
  newPath=$(catchEnvironment "$handler" listCleanDuplicates --test _pathIsDirectory ':' "${PATH-}") || return $?
  MANPATH="$newPath"
}
_manPathCleanDuplicates() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hostnameFull() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchReturn "$handler" __hostname || return $?
}
_hostnameFull() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
tarExtractPattern() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local pattern="$argument"
      shift || throwArgument "No pattern supplied" || return $?
      if tar --version | grep -q GNU; then
        tar -O -zx --wildcards "$pattern" "$@"
      else
        tar -O -zx "$pattern" "$@"
      fi
      return 0
      ;;
    esac
  done
}
_tarExtractPattern() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
tarCreate() {
  local handler="_${FUNCNAME[0]}"
  local target=""
  [ $# -gt 0 ] || throwArgument "$handler" "Need target and files" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      target="$argument"
      shift || throwArgument "No files supplied" || return $?
      if tar --version | grep -q GNU; then
        tar -czf "$target" --owner=0 --group=0 --no-xattrs -h "$@"
      else
        tar -czf "$target" --uid 0 --gid 0 --no-acls --no-fflags --no-xattrs -h "$@"
      fi
      return 0
      ;;
    esac
  done
}
_tarCreate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
filesRename() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local old new verb
  old=$(validate "$handler" EmptyString "oldSuffix" "${1-}") && shift || return $?
  new=$(validate "$handler" EmptyString "newSuffix" "${1-}") && shift || return $?
  verb="${1-}" && shift || return $?
  while [ $# -gt 0 ]; do
    local prefix="$1"
    if [ -f "$prefix$old" ]; then
      catchEnvironment "$handler" mv "$prefix$old" "$prefix$new" || return $?
      catchEnvironment "$handler" statusMessage --last decorate info "$verb $(decorate file "$prefix$old") -> $(decorate file "$prefix$new")" || return $?
    fi
    shift
  done
}
_filesRename() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileModificationTime() {
  local handler="_${FUNCNAME[0]}"
  local argument
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
    argument="$1"
    [ -n "$argument" ] || throwArgument "$handler" "blank argument" || return $?
    [ -f "$argument" ] || throwArgument "$handler" "$argument is not a file" || return $?
    printf "%d\n" "$(date -r "$argument" +%s)"
    shift || throwArgument "$handler" "shift" || return $?
  done
}
_fileModificationTime() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileModificationSeconds() {
  local handler="_${FUNCNAME[0]}"
  local now_
  now_="$(catchEnvironment "$handler" date +%s)" || return $?
  local __count=$#
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
    local argument
    argument="$(validate "$handler" File "argument #$((__count - $# + 1))" "${1-}")" || return $?
    argument=$(catchEnvironment "$handler" fileModificationTime "$argument") || return $?
    printf "%d\n" "$((now_ - argument))"
    shift
  done
}
_fileModificationSeconds() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileModificationTimes() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local directory="${1-}" && shift
  [ -d "$directory" ] || throwArgument "$handler" "Not a directory $(decorate code "$directory")" || return $?
  __fileModificationTimes "$directory" "$@"
}
_fileModificationTimes() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileModifiedRecently() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local directory="${1-}" && shift
  [ -d "$directory" ] || throwArgument "$handler" "Not a directory $(decorate code "$directory")" || return $?
  fileModificationTimes "$directory" -type f "$@" | sort -rn | head -n 1
}
_fileModifiedRecently() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileIsNewest() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  if [ $# -eq 0 ]; then
    return 1
  fi
  [ "$1" = "$(fileNewest "$@")" ]
}
_fileIsNewest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileIsOldest() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  if [ $# -eq 0 ]; then
    return 1
  fi
  [ "$1" = "$(fileOldest "$@")" ]
}
_fileIsOldest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__gamutFile() {
  local handler="$1" comparison="$2"
  shift 2 || returnArgument "${FUNCNAME[0]} used incorrectly" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local gamutTime="" theFile=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1)) tempTime
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count: $(decorate each code "${__saved[@]}") $(debuggingStack)" || return $?
    [ -f "$argument" ] || throwArgument "$handler" "Not a file: $(decorate code "$argument"): #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    tempTime=$(fileModificationTime "$argument") || throwEnvironment "#$__index/$__count: fileModificationTime $argument: #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    if [ -z "$theFile" ] || test "$tempTime" "$comparison" "$gamutTime"; then
      theFile="$1"
      gamutTime="$tempTime"
    fi
    shift
  done
  printf "%s" "$theFile"
}
fileOldest() {
  __gamutFile "_${FUNCNAME[0]}" -lt "$@"
}
_fileOldest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileNewest() {
  __gamutFile "_${FUNCNAME[0]}" -gt "$@"
}
_fileNewest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileModifiedSeconds() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local timestamp
  timestamp=$(fileModificationTime "$1") || throwArgument "$handler" fileModificationTime "$1" || return $?
  printf %d "$(($(date +%s) - timestamp))"
}
_fileModifiedSeconds() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileModifiedDays() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local timestamp
  timestamp=$(fileModifiedSeconds "$1") || throwArgument "$handler" fileModifiedSeconds "$1" || return $?
  printf %d "$((timestamp / 86400))"
}
_fileModifiedDays() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
realPath() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  if executableExists realpath; then
    realpath "$@"
  else
    readlink -f -n "$@"
  fi
}
_realPath() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
directoryPathSimplify() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local path elements=() segment dot=0 pathResult=() IFS="/"
  while [ $# -gt 0 ]; do
    path="$1"
    path="${path#"./"}"
    path="${path//\/\.\///}"
    read -r -a elements <<<"$path" || :
    if [ "${#elements[@]}" -gt 0 ]; then
      pathResult=()
      for segment in "${elements[@]+"${elements[@]}"}"; do
        if [ "$segment" = ".." ]; then
          dot=$((dot + 1))
        elif [ $dot -gt 0 ]; then
          dot=$((dot - 1))
        else
          pathResult+=("$segment")
        fi
      done
      printf "%s\n" "${pathResult[*]-}"
    else
      printf "\n"
    fi
    shift
  done
}
_directoryPathSimplify() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileSize() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local size opts
  case "$(lowercase "${OSTYPE-}")" in
  *darwin*) opts=("-f" "%z") ;;
  *) opts=('-c%s') ;;
  esac
  while [ $# -gt 0 ]; do
    size="$(stat "${opts[@]}" "$1")" || throwEnvironment "$handler" "Unable to stat" "${opts[@]}" "$1" || return $?
    printf "%s\n" "$size"
    shift || throwArgument "$handler" shift || return $?
  done
}
_fileSize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileType() {
  local t
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    t="$(type -t "$1")" || :
    if [ -z "$t" ]; then
      if [ -L "$1" ]; then
        local ll
        if ! ll=$(readlink "$1"); then
          t="link-dead"
        elif [ -e "$ll" ]; then
          t="link-$(fileType "$ll")"
        else
          t="link-unknown"
        fi
      elif [ -d "$1" ]; then
        t="directory"
      elif [ -f "$1" ]; then
        t="file"
      elif isInteger "$1"; then
        t="integer"
      else
        t="unknown"
      fi
    fi
    printf "%s\n" "$t" || return $?
    shift
  done
}
_fileType() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
linkRename() {
  local handler="_${FUNCNAME[0]}"
  local from="" to=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$from" ]
    then
      from=$(validate "$handler" Link "from $(fileType "$1")" "$1") || return $?
    elif [ -z "$to" ]; then
      to=$(validate "$handler" FileDirectory "to $(fileType "$1")" "$1") || return $?
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$from" ] || throwArgument "$handler" 'Need a "from" argument' || return $?
  [ -n "$to" ] || throwArgument "$handler" 'Need a "to" argument' || return $?
  __linkRename "$from" "$to"
}
_linkRename() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__fileListColumn() {
  local usageFunction="$1" column="${2-}" result
  shift 2
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$usageFunction" "$@" || return 0
    if ! result="$(ls -ld "$1" | awk '{ print $'"$column"' }')"; then
      throwEnvironment "$usageFunction" "Running ls -ld \"$1\"" || return $?
    fi
    printf "%s\n" "$result"
    shift
  done
}
fileOwner() {
  __fileListColumn "_${FUNCNAME[0]}" 3 "$@"
}
_fileOwner() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileGroup() {
  __fileListColumn "_${FUNCNAME[0]}" 4 "$@"
}
_fileGroup() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileNotMatches() {
  _fileMatchesHelper "_${FUNCNAME[0]}" false "$@"
}
_fileNotMatches() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileMatches() {
  _fileMatchesHelper "_${FUNCNAME[0]}" true "$@"
}
_fileMatches() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_fileMatchesHelper() {
  local handler="${1-}" && shift
  local success="${1-}" && shift
  local patterns=()
  local file patterns=() found=false exceptions=() clean fileList foundLines
  [ $# -gt 0 ] || return 0
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --) shift && break ;;
    *) patterns+=("$argument") ;;
    esac
    shift
  done
  [ "${#patterns[@]}" -gt 0 ] || catchArgument "$handler" "No patterns" || return $?
  while [ $# -gt 0 ]; do [ "$1" = "--" ] && shift && break || exceptions+=("$1") && shift; done
  fileList=$(fileTemporaryName "$handler") || return $?
  foundLines="$fileList.found"
  clean=("$fileList" "$foundLines")
  if [ $# -eq 0 ] || [ "$1" = "-" ]; then
    catchEnvironment "$handler" cat >"$fileList" || returnClean $? "${clean[@]}" || return $?
  else
    catchEnvironment "$handler" printf "%s\n" "$@" >"$fileList" || returnClean $? "${clean[@]}" || return $?
  fi
  for pattern in "${patterns[@]}"; do
    while read -r file; do
      if [ "${#exceptions[@]}" -gt 0 ] && stringContains "$file" "${exceptions[@]}"; then
        continue
      fi
      if $success; then
        if grep -n -e "$pattern" "$file" >"$foundLines"; then
          if ! fileIsEmpty "$foundLines"; then
            found=true
            decorate wrap "$file: " <"$foundLines"
          fi
        fi
      else
        if ! grep -q -e "$pattern" "$file"; then
          printf "%s:%s\n" "$file" "$pattern"
          found=true
        fi
      fi
    done <"$fileList"
  done
  returnClean 0 "${clean[@]}" || return $?
  $found
}
fileIsEmpty() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      argument="$(validate "$handler" File "file" "$1")" || return $?
      [ ! -s "$argument" ] || return 1
      ;;
    esac
    shift
  done
}
_fileIsEmpty() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_directoryGamutFile() {
  local clipper="$1" directory="${2-.}" modified file && shift 2
  read -r modified file < <(__fileModificationTimes "$directory" -type f ! -path "*/.*/*" "$@" | sort -n | "$clipper" -n 1) || :
  [ -n "$modified" ] || return 0
  isPositiveInteger "$modified" || throwEnvironment "$handler" "__fileModificationTimes output a non-integer: \"$modified\" \"$file\"" || return $?
  printf "%s\n" "$file"
}
_directoryGamutFileWrapper() {
  local handler="$1" comparator="$2" && shift 2
  local directory="" findArgs=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --find)
      shift
      while [ $# -gt 0 ]; do
        [ "$1" != "--" ] || break
        findArgs+=("$1")
        shift
      done
      [ $# -gt 0 ] || break
      ;;
    *)
      [ -z "$directory" ] || throwArgument "$handler" "Directory already supplied" || return $?
      directory="$(validate "$handler" Directory "$argument" "${1-}")" || return $?
      ;;
    esac
    shift
  done
  [ -n "$directory" ] || throwArgument "$handler" "directory is required" || return $?
  if ! _directoryGamutFile "$comparator" "$directory" "${findArgs[@]+"${findArgs[@]}"}"; then
    throwEnvironment "$handler" "No files in $(decorate file "$directory") (${findArgs[*]-})" || return $?
  fi
}
directoryOldestFile() {
  _directoryGamutFileWrapper "_${FUNCNAME[0]}" head "$@"
}
_directoryOldestFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
directoryNewestFile() {
  _directoryGamutFileWrapper "_${FUNCNAME[0]}" tail "$@"
}
_directoryNewestFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
linkCreate() {
  local handler="_${FUNCNAME[0]}"
  local target="" path="" linkName="" backupFlag=true
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --no-backup)
      backupFlag=false
      ;;
    *) if
      [ -z "$target" ]
    then
      target=$(validate "$handler" Exists "target" "$argument") || return $?
      path=$(catchEnvironment "$handler" dirname "$target") || return $?
    elif [ -z "$linkName" ]; then
      linkName=$(validate "$handler" String "linkName" "$argument") || return $?
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$target" ] || throwArgument "$handler" "Missing target" || return $?
  [ -n "$linkName" ] || throwArgument "$handler" "Missing linkName" || return $?
  [ ! -L "$target" ] || throwArgument "$handler" "Can not link to another link ($(decorate file "$target") is a link)" || return $?
  target=$(catchEnvironment "$handler" basename "$target") || return $?
  [ -e "$path/$target" ] || throwEnvironment "$handler" "$path/$target must be a file or directory" || return $?
  local link="$path/$linkName"
  if [ ! -L "$link" ]; then
    if [ -e "$link" ]; then
      throwEnvironment "$handler" "$(decorate file "$link") exists and was not a link $(decorate code "$(fileType "$link")")" || :
      catchEnvironment "$handler" mv "$link" "$link.createLink.$$.backup" || return $?
      clean+=("$link.$$.backup")
    fi
  else
    local actual
    actual=$(catchEnvironment "$handler" readlink "$link") || return $?
    if [ "$actual" = "$target" ]; then
      return 0
    fi
    catchEnvironment "$handler" mv "$link" "$link.createLink.$$.badLink" || return $?
    clean+=("$link.$$.badLink")
  fi
  catchEnvironment "$handler" muzzle pushd "$path" || return $?
  catchEnvironment "$handler" ln -s "$target" "$linkName" || returnUndo $? muzzle popd || return $?
  catchEnvironment "$handler" muzzle popd || return $?
  $backupFlag || catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
}
_linkCreate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileTemporaryName() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  handler="$1" && shift
  local debug=",${BUILD_DEBUG-},"
  if [ "${debug#*,temp,}" != "$debug" ]; then
    local target="${BUILD_HOME-.}/.${FUNCNAME[0]}"
    printf "%s" "fileTemporaryName: " >>"$target"
    catchEnvironment "$handler" mktemp "$@" | tee -a "$target" || return $?
    local sources=() count=${#FUNCNAME[@]} index=0
    while [ "$index" -lt "$count" ]; do
      sources+=("${BASH_SOURCE[index + 1]-}:${BASH_LINENO[index]-"$LINENO"} - ${FUNCNAME[index]-}")
      index=$((index + 1))
    done
    printf "%s\n" "${sources[@]}" "-- END" >>"$target"
  else
    catchEnvironment "$handler" mktemp "$@" || return $?
  fi
}
_fileTemporaryName() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileTeeAtomic() {
  local handler="_${FUNCNAME[0]}"
  local tt=() copy=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    -a) tt+=("$argument") && copy=true ;;
    *) target="$(validate "$handler" FileDirectory "target" "$argument")" && break || return $? ;;
    esac
    shift
  done
  [ ${#tt[@]} -eq 0 ] || throwArgument "$handler" "No file arguments: $__count ${__saved[*]}" || return $?
  local clean=("$target.$$")
  ! $copy || [ ! -f "$target" ] || catchEnvironment "$handler" cp -f "$target" "$target.$$" || return $?
  catchEnvironment "$handler" tee "${tt[@]+"${tt[@]}"}" "$target.$$" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" mv -f "$target.$$" "$target" || returnClean $? "${clean[@]}" || return $?
}
_fileTeeAtomic() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pathIsAbsolute() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  while [ $# -gt 0 ]; do
    [ "$1" != "${1#/}" ] || return 1
    shift || :
  done
}
_pathIsAbsolute() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
directoryChange() {
  local handler="_${FUNCNAME[0]}"
  local directory="" command=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *) if
      [ -z "$directory" ]
    then
      directory=$(validate "$handler" Directory "directory" "$1") || return $?
    elif [ -z "$command" ]; then
      command=$(validate "$handler" Callable "command" "$1") && shift || return $?
      catchEnvironment "$handler" muzzle pushd "$directory" || return $?
      catchEnvironment "$handler" "$command" "$@" || returnUndo $? muzzle popd || return $?
      catchEnvironment "$handler" muzzle popd || return $?
      return 0
    fi ;;
    esac
    shift
  done
  [ -n "$directory" ] || throwArgument "$handler" "Missing directory" || return $?
  throwArgument "$handler" "Missing command" || return $?
}
_directoryChange() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
directoryClobber() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local source target targetPath targetName sourceStage targetBackup
  source=$(validate "$handler" Directory source "$1") || return $?
  shift || :
  target="${1-}"
  targetPath="$(dirname "$target")" || throwArgument "$handler" "dirname $target" || return $?
  [ -d "$targetPath" ] || throwEnvironment "$handler" "$targetPath is not a directory" || return $?
  targetName="$(basename "$target")" || throwEnvironment basename "$target" || return $?
  sourceStage="$targetPath/.NEW.$$.$targetName"
  targetBackup="$targetPath/.OLD.$$.$targetName"
  catchEnvironment "$handler" mv -f "$source" "$sourceStage" || return $?
  catchEnvironment "$handler" mv -f "$target" "$targetBackup" || return $?
  if ! mv -f "$sourceStage" "$target"; then
    mv -f "$targetBackup" "$target" || throwEnvironment "$handler" "Unable to revert $targetBackup -> $target" || return $?
    mv -f "$sourceStage" "$source" || throwEnvironment "$handler" "Unable to revert $sourceStage -> $source" || return $?
    throwEnvironment "$handler" "Clobber failed" || return $?
  fi
  catchEnvironment "$handler" rm -rf "$targetBackup" || return $?
}
_directoryClobber() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileDirectoryRequire() {
  local handler="_${FUNCNAME[0]}"
  local name="" rr=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --owner | --mode)
      shift
      local value
      value=$(validate "$handler" String "$argument" "${1-}") || return $?
      rr+=("$argument" "$value") || return $?
      ;;
    *) rr+=(--output "$argument" "$(catchEnvironment "$handler" dirname "$argument")") || return $? ;;
    esac
    shift
  done
  directoryRequire --handler "$handler" --noun "file directory" "${rr[@]+"${rr[@]}"}" || return $?
}
_fileDirectoryRequire() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileDirectoryExists() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local path
      path=$(dirname "$argument") || throwEnvironment "$handler" "dirname $argument" || return $?
      [ -d "$path" ] || return 1
      ;;
    esac
    shift
  done
}
_fileDirectoryExists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
directoryRequire() {
  local handler="_${FUNCNAME[0]}"
  local modeArray=() owner="" directories=() noun="directory" output=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --owner)
      shift
      owner=$(validate "$handler" String "$argument" "${1-}") || return $?
      [ "$owner" != "-" ] || owner=""
      ;;
    --mode)
      shift
      modeArray=("$argument" "$(validate "$handler" String "$argument" "${1-}")") || return $?
      [ "${modeArray[1]}" != "-" ] || modeArray=()
      ;;
    --noun)
      shift
      noun=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --output)
      shift
      output=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    *)
      local name="$argument"
      if [ -d "$name" ]; then
        [ 0 -eq "${#modeArray[@]}" ] || catchEnvironment "$handler" chmod "${modeArray[1]}" "$name" || return $?
      else
        catchEnvironment "$handler" mkdir -p "${modeArray[@]+"${modeArray[@]}"}" "$name" || return $?
      fi
      [ -z "$owner" ] || catchEnvironment "$handler" chown "$owner" "$name" || return $?
      directories+=("$name")
      [ -z "$output" ] || name="$output"
      printf "%s\n" "$name"
      output=""
      ;;
    esac
    shift
  done
  [ ${#directories[@]} -gt 0 ] || throwArgument "$handler" "Need at least one $noun" || return $?
}
_directoryRequire() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
directoryIsEmpty() {
  local handler="_${FUNCNAME[0]}"
  local argument
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      [ -d "$argument" ] || throwArgument "$handler" "Not a directory $(decorate code "$argument")" || return $?
      find "$argument" -mindepth 1 -maxdepth 1 | read -r && return 1 || return 0
      ;;
    esac
  done
}
_directoryIsEmpty() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
directoryRelativePath() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local relTop
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      relTop=.
    else
      relTop=$(printf "%s\n" "$1" | sed -e 's/[^/]//g' -e 's/\//..\//g')
      relTop="${relTop%/}"
    fi
    printf "%s\n" "$relTop"
    shift
  done
}
_directoryRelativePath() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
directoryParent() {
  __directoryParent "_${FUNCNAME[0]}" "$@"
}
_directoryParent() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__directoryParent() {
  local handler="${1-}" && shift
  local testExpression directory lastDirectory="" passed passedExpression failedExpression
  local startingDirectory="" filePattern="" testExpressions=() bestFailure=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --pattern)
      [ -z "$filePattern" ] || throwArgument "$handler" "$argument already specified" || return $?
      shift
      filePattern=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --test)
      shift
      testExpressions+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    *)
      [ -z "$startingDirectory" ] || throwArgument "$handler" "startingDirectory $(decorate code "$argument") was already specified $(decorate value "$startingDirectory") (Arguments: $(decorate each code "${handler#_}" "${__saved[@]}"))" || return $?
      [ -n "$argument" ] || argument=$(catchEnvironment "$handler" pwd) || return $?
      startingDirectory=$(validate "$handler" RealDirectory startingDirectory "$argument") || return $?
      ;;
    esac
    shift
  done
  [ ${#testExpressions[@]} -gt 0 ] || testExpressions+=("-d")
  directory="$startingDirectory"
  while [ "$directory" != "$lastDirectory" ]; do
    passed=true
    passedExpression=""
    failedExpression=""
    for testExpression in "${testExpressions[@]+"${testExpressions[@]}"}"; do
      [ "$testExpression" != "${testExpression#-}" ] || throwArgument "$handler" "Invalid expression: $(decorate code "$testExpression") (Arguments: $(decorate each code "${handler#_}" "${__saved[@]}"))" || return $?
      if ! test "$testExpression" "$directory/$filePattern"; then
        passed=false
        failedExpression="$testExpression"
        break
      fi
      passedExpression="$testExpression"
    done
    if $passed; then
      printf "%s\n" "$directory"
      return 0
    fi
    if [ -n "$passedExpression" ]; then
      bestFailure="$directory/$filePattern ${#testExpressions[@]} passed $(decorate green "$passedExpression") failed: $(decorate red "$failedExpression")" || return $?
    fi
    lastDirectory="$directory"
    directory="$(dirname "$directory")"
  done
  [ -n "$bestFailure" ] || bestFailure="No $(decorate code "$filePattern") found above $(decorate value "$argument")"
  throwEnvironment "$handler" "$bestFailure" || return $?
  return 1
}
__characterLoader() {
  __buildFunctionLoader __characterClassReport character "$@"
}
characterClassReport() {
  __characterLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_characterClassReport() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
stringValidate() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local text character
  text="${1-}"
  shift || throwArgument "$handler" "missing text" || return $?
  [ $# -gt 0 ] || throwArgument "$handler" "missing class" || return $?
  for character in $(printf "%s" "$text" | grep -o .); do
    if ! isCharacterClasses "$character" "$@"; then
      return 1
    fi
  done
}
_stringValidate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
characterToInteger() {
  local index
  index=0
  while [ $# -gt 0 ]; do
    [ "$1" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    index=$((index + 1))
    [ "${#1}" = 1 ] || throwArgument "$handler" "Single characters only (argument #$index): \"$1\" (${#1} characters)" || return $?
    LC_CTYPE=C printf '%d' "'$1" || throwEnvironment "$handler" "Single characters only (argument #$index): \"$1\" (${#1} characters)" || return $?
    shift
  done
}
_characterToInteger() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isCharacterClasses() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local character="${1-}" class
  [ "${#character}" -eq 1 ] || throwArgument "$handler" "Non-single character: \"$character\"" || return $?
  if ! shift || [ $# -eq 0 ]; then
    throwArgument "$handler" "Need at least one class" || return $?
  fi
  while [ "$#" -gt 0 ]; do
    class="$1"
    if [ "${#class}" -eq 1 ]; then
      if [ "$class" = "$character" ]; then
        return 0
      fi
    elif isCharacterClass "$class" "$character"; then
      return 0
    fi
    shift
  done
  return 1
}
_isCharacterClasses() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
characterFromInteger() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      isUnsignedInteger "$argument" || throwArgument "$handler" "Argument is not unsigned integer: $(decorate code "$argument")" || return $?
      [ "$argument" -lt 256 ] || throwArgument "$handler" "Integer out of range: \"$argument\"" || return $?
      case "$argument" in
      *) printf "\\$(printf '%03o' "$argument")\n" ;;
      esac
      ;;
    esac
    shift
  done
}
_characterFromInteger() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
characterClasses() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if [ $# -eq 0 ]; then
    printf "%s\n" alnum alpha ascii blank cntrl digit graph lower print punct space upper word xdigit
  else
    while [ $# -gt 0 ]; do
      local character="${1:0:1}"
      local matchedClasses=()
      case "$character" in [[:alnum:]]) matchedClasses+=("alnum") ;; esac
      case "$character" in [[:alpha:]]) matchedClasses+=("alpha") ;; esac
      case "$character" in [[:ascii:]]) matchedClasses+=("ascii") ;; esac
      case "$character" in [[:blank:]]) matchedClasses+=("blank") ;; esac
      case "$character" in [[:cntrl:]]) matchedClasses+=("cntrl") ;; esac
      case "$character" in [[:digit:]]) matchedClasses+=("digit") ;; esac
      case "$character" in [[:graph:]]) matchedClasses+=("graph") ;; esac
      case "$character" in [[:lower:]]) matchedClasses+=("lower") ;; esac
      case "$character" in [[:print:]]) matchedClasses+=("print") ;; esac
      case "$character" in [[:punct:]]) matchedClasses+=("punct") ;; esac
      case "$character" in [[:space:]]) matchedClasses+=("space") ;; esac
      case "$character" in [[:upper:]]) matchedClasses+=("upper") ;; esac
      case "$character" in [[:word:]]) matchedClasses+=("word") ;; esac
      case "$character" in [[:xdigit:]]) matchedClasses+=("xdigit") ;; esac
      printf "%s\n" "${matchedClasses[@]}"
      shift
    done
  fi
}
_characterClasses() {
  true || characterClasses --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isCharacterClass() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local class="${1-}"
  case "$class" in alnum | alpha | ascii | blank | cntrl | digit | graph | lower | print | punct | space | upper | word | xdigit) ;; *) throwArgument "$handler" "Invalid class: $class" || return $? ;; esac
  shift
  while [ $# -gt 0 ]; do
    local character="${1:0:1}"
    character="$(escapeBash "$character")"
    if ! eval "case $character in [[:$class:]]) ;; *) return 1 ;; esac"; then
      return 1
    fi
    shift
  done
}
_isCharacterClass() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
quoteBashString() {
  printf "%s\n" "$@" | sed 's/\([$`<>'\'']\)/\\\1/g'
}
quoteGrepPattern() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  local value="${1-}"
  value="${value//\\/\\\\}"
  value="${value//./\\.}"
  value="${value//+/\\+}"
  value="${value//\*/\\*}"
  value="${value//"?"/\\?}"
  value="${value//[/\\[}"
  value="${value//]/\\]}"
  value="${value//|/\\|}"
  value="${value//$'\n'/\\n}"
  printf "%s\n" "$value"
}
_quoteGrepPattern() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
escapeDoubleQuotes() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  while [ $# -gt 0 ]; do
    printf "%s\n" "${1//\"/\\\"}"
    shift
  done
}
_escapeDoubleQuotes() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
escapeBash() {
  local jqArgs
  jqArgs=(-r --raw-input '@sh')
  if [ $# -gt 0 ]; then
    printf "%s\n" "$@" | jq "${jqArgs[@]}"
  else
    jq --slurp "${jqArgs[@]}"
  fi
}
_escapeBash() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
escapeSingleQuotes() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  printf "%s\n" "$@" | sed "s/'/\\\'/g"
}
_escapeSingleQuotes() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
unquote() {
  [ "$1" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local quote="$1" value="$2"
  if [ "$value" != "${value#"$quote"}" ] && [ "$value" != "${value%"$quote"}" ]; then
    value="${value#"$quote"}"
    value="${value%"$quote"}"
  fi
  printf "%s\n" "$value"
}
_unquote() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__unquote() {
  local value="${1-}"
  case "${value:0:1}" in
  "'") value="$(unquote "'" "$value")" ;;
  '"') value="$(unquote '"' "$value")" ;;
  *) ;;
  esac
  printf "%s\n" "$value"
}
__textLoader() {
  __buildFunctionLoader __shaPipe text "$@"
}
fileExtractLines() {
  local handler="_${FUNCNAME[0]}"
  local start="" end=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$start" ]
    then
      start="$(validate "$handler" PositiveInteger "start" "$1")" || return $?
    elif [ -z "$end" ]; then
      end="$(validate "$handler" PositiveInteger "end" "$1")" || return $?
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  sed -n "$start,${end}p;${end}q"
}
_fileExtractLines() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
grepSafe() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  grep "$@" || returnMap $? 1 0 || return $?
}
_grepSafe() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isPlain() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  while [ $# -gt 0 ]; do
    case "$1" in *[^[:print:]]*) return 1 ;; esac
    shift
  done
  return 0
}
_isPlain() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isMappable() {
  local handler="_${FUNCNAME[0]}"
  local prefix='{' suffix='}' tokenClasses='[-_A-Za-z0-9:]'
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --token) shift && tokenClasses="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --prefix) shift && prefix=$(quoteGrepPattern "$(validate "$handler" String "$argument" "${1-}")") || return $? ;;
    --suffix) shift && suffix=$(quoteGrepPattern "$(validate "$handler" String "$argument" "${1-}")") || return $? ;;
    *) if
      printf "%s\n" "$1" | grep -q -e "$prefix$tokenClasses$tokenClasses*$suffix"
    then
      return 0
    fi ;;
    esac
    shift
  done
  return 1
}
_isMappable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
parseBoolean() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  case "$(lowercase "${1-}")" in
  y | yes | 1 | true)
    return 0
    ;;
  n | no | 0 | false) return 1 ;;
  esac
  return 2
}
_parseBoolean() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
newlineHide() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  local text="${1-}" replace="${2-"␤"}"
  printf -- "%s\n" "${text//$'\n'/$replace}"
}
_newlineHide() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
escapeQuotes() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  printf %s "$(escapeDoubleQuotes "$(escapeSingleQuotes "$1")")"
}
_escapeQuotes() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
replaceFirstPattern() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  sed "s/$(quoteSedPattern "$1")/$(quoteSedPattern "$2")/1"
}
_replaceFirstPattern() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
trimBoth() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed -e :a -e '/./,$!d' -e '/^\n*$/{$d;N;ba' -e '}'
}
_trimBoth() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
trimHead() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed -e "/./!d" -e :r -e n -e br
}
_trimHead() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
trimTail() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed -e :a -e '/^\n*$/{$d;N;ba' -e '}'
}
_trimTail() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
singleBlankLines() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed '/^$/N;/^\n$/D'
}
_singleBlankLines() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
trimSpace() {
  local handler="_${FUNCNAME[0]}"
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      local var
      var="$1"
      var="${var#"${var%%[![:space:]]*}"}"
      printf -- "%s" "${var%"${var##*[![:space:]]}"}"
      shift
    done
  else
    catchEnvironment "$handler" awk '{$1=$1};NF' || return $?
  fi
}
_trimSpace() {
  true || trimSpace ""
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
inArray() {
  local element=${1-} arrayElement
  if ! shift 2>/dev/null; then
    _inArray 0 && return $? || return $?
  fi
  for arrayElement; do
    if [ "$element" == "$arrayElement" ]; then
      return 0
    fi
  done
  return 1
}
_inArray() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
stringContains() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local haystack="${1-}"
  [ -n "$haystack" ] || return 1
  shift
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || continue
    local needle="$1"
    [ "${haystack#*"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_stringContains() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
stringBegins() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local haystack="${1-}"
  [ -n "$haystack" ] || return 1
  shift
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || continue
    local needle="$1"
    [ "${haystack#"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_stringBegins() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
stringBeginsInsensitive() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local haystack="${1-}"
  [ -n "$haystack" ] || return 1
  shift
  haystack=$(lowercase "$haystack") || :
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || continue
    local needle
    needle=$(lowercase "$1") || :
    [ "${haystack#"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_stringBeginsInsensitive() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
stringContainsInsensitive() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local haystack="${1-}"
  [ -n "$haystack" ] || return 1
  shift
  haystack=$(lowercase "$haystack") || :
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || continue
    local needle
    needle=$(lowercase "$1") || :
    [ "${haystack#*"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_stringContainsInsensitive() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isSubstring() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local haystack needle=${1-}
  shift || return 1
  for haystack; do
    [ "${haystack#*"$needle"}" = "$haystack" ] || return 0
    shift
  done
  return 1
}
_isSubstring() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isSubstringInsensitive() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local element arrayElement
  element="$(lowercase "${1-}")"
  [ -n "$element" ] || throwArgument "$handler" "needle is blank" || return $?
  shift || return 1
  for arrayElement; do
    arrayElement=$(lowercase "$arrayElement")
    if [ "${arrayElement#*"$element"}" != "$arrayElement" ]; then
      return 0
    fi
  done
  return 1
}
_isSubstringInsensitive() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
trimWords() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local wordCount=$((${1-0} + 0)) words=() result
  shift || return 0
  while [ $# -gt 0 ] && [ ${#words[@]} -lt $wordCount ]; do
    IFS=' ' read -ra argumentWords <<<"${1-}"
    for argumentWord in "${argumentWords[@]+${argumentWords[@]}}"; do
      words+=("$argumentWord")
      if [ ${#words[@]} -ge $wordCount ]; then
        break
      fi
    done
    shift
  done
  result=$(printf '%s ' "${words[@]+${words[@]}}")
  printf %s "${result%% }"
}
_trimWords() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileFieldMaximum() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local index=$((${1-1} + 0)) charArg=${2-}
  local ss=()
  if [ -n "$charArg" ]; then
    ss=("-F$charArg")
  fi
  catchReturn "$handler" awk "${ss[@]+"${ss[@]}"}" "{ print length(\$$index) }" | catchReturn "$handler" sort -rn | catchReturn "$handler" head -n 1 || return $?
}
_fileFieldMaximum() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileLineMaximum() {
  local handler="_${FUNCNAME[0]}"
  local max
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  max=0
  while IFS= read -r line; do
    if [ "${#line}" -gt "$max" ]; then
      max=${#line}
    fi
  done
  printf "%d" "$max"
}
_fileLineMaximum() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileEndsWithNewline() {
  local handler="_${FUNCNAME[0]}" one=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      [ -f "$argument" ] || throwArgument "$handler" "not a file #$__index/$__count ($argument)" || return $?
      one=true
      [ -z "$(tail -c 1 "$argument")" ] || return 1
      ;;
    esac
    shift
  done
  $one || throwArgument "$handler" "Requires at least one file $(decorate each code -- "${__saved[@]}")" || return $?
}
_fileEndsWithNewline() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileLineCount() {
  local handler="_${FUNCNAME[0]}"
  local fileArgument=false newlineCheck=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --newline) newlineCheck=true ;;
    *)
      local file total
      file="$(validate "$handler" File "$argument" "${1-}")" || return $?
      total=$(catchEnvironment "$handler" wc -l <"$file" | trimSpace) || return $?
      if $newlineCheck; then
        if [ -s "$file" ]; then
          if fileEndsWithNewline "$file"; then
            printf "%d\n" "$total"
          else
            printf "%d\n" "$((total + 1))"
          fi
        else
          printf "%d\n" 0
        fi
      else
        printf "%d\n" "$total"
      fi
      fileArgument=true
      ;;
    esac
    shift
  done
  if ! $fileArgument; then
    if $newlineCheck; then
      local temp
      temp=$(fileTemporaryName "$handler") || return $?
      catchEnvironment "$handler" cat >"$temp" || returnClean $? "$temp" || return $?
      fileLineCount --newline --handler "$handler" "$temp" || return $?
      catchReturn "$handler" rm -f "$temp" || return $?
    else
      printf "%d\n" "$(catchEnvironment "$handler" wc -l | trimSpace)" || return $?
    fi
  fi
}
_fileLineCount() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pluralWord() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local word
  word=$(catchReturn "$handler" plural "$@") || return $?
  printf -- "%s %s\n" "$1" "$word" || return $?
}
_pluralWord() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
plural() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local count=${1-} plural="${3-"$2s"}"
  if [ "$count" -eq "$count" ] 2>/dev/null; then
    if [ "$((${1-} + 0))" -eq 1 ]; then
      printf %s "${2-}"
    else
      printf %s "$plural"
    fi
  elif isNumber "$count"; then
    case "${count#1.}" in
    *[^0]*) printf %s "$plural" ;;
    *) printf %s "${2-}" ;;
    esac
  else
    throwArgument "$handler" "plural argument: \"$count\" is not numeric" || return $?
    return 1
  fi
}
_plural() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
lowercase() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ "${1-}" != "--" ] || shift
  while [ $# -gt 0 ]; do
    if [ -n "$1" ]; then
      printf "%s\n" "$1" | tr '[:upper:]' '[:lower:]'
    fi
    shift
  done
}
_lowercase() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
uppercase() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ "${1-}" != "--" ] || shift
  while [ $# -gt 0 ]; do
    if [ -n "$1" ]; then
      printf "%s\n" "$1" | tr '[:lower:]' '[:upper:]'
    fi
    shift
  done
}
_uppercase() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleToPlain() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed -e $'s,\x1B\[[0-9;]*[a-zA-Z],,g' -e $'s,\x1B\][^\x1B]*\x1B\x5c\x5c,,g'
}
_consoleToPlain() {
  true || consoleToPlain --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consolePlainLength() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if [ $# -gt 0 ]; then
    local text && text="$(consoleToPlain <<<"$*")"
    printf "%d\n" "${#text}"
  else
    local count && count=$(trimSpace "$(consoleToPlain | wc -c)")
    printf "%d\n" "$((count - 1))"
  fi
}
_consolePlainLength() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleTrimWidth() {
  local handler="_${FUNCNAME[0]}"
  local foundArgument=false width=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$width" ]
    then
      width=$(validate "$handler" UnsignedInteger "characters" "$argument") || return $?
    else
      foundArgument=true
      __consoleTrimWidth "$handler" "$width" "$argument" || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$width" ] || throwArgument "$handler" "Need width" || return $?
  ! $foundArgument || return 0
  local finished=false && while ! $finished; do
    local textLine && read -r textLine || finished=true
    [ -n "$textLine" ] || ! $finished || continue
    __consoleTrimWidth "$handler" "$width" "$textLine" || return $?
  done
}
_consoleTrimWidth() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__consoleTrimWidth() {
  local handler="$1" && shift
  local trimWidth="$1" && shift
  local textLine="$1" && shift
  local search=$'\e'"[0m"
  local replace=$'\2'
  local modded=${textLine//"$search"/"$replace"}
  if [ "$modded" = "$textLine" ]; then
    printf "%s\n" "${textLine:0:trimWidth}"
    return 0
  fi
  local finished=false prefix="" textWidth=0
  while ! $finished; do
    local part="" && IFS="" read -r -d "$replace" part || finished=true
    local newWidth=0
    if [ -n "$part" ]; then
      newWidth=$(consolePlainLength "$part")
      if isInteger "$newWidth" && [ "$newWidth" -gt 0 ] && [ "$((textWidth + newWidth))" -gt "$trimWidth" ]; then
        part=$(printf -- "%s" "$part" | consoleToPlain)
        changed=$((trimWidth - textWidth))
        part="${part:0:changed}"
        finished=true
      fi
    fi
    printf -- "%s%s" "$prefix" "$part"
    textWidth=$((textWidth + newWidth))
    ! $finished || return 0
    prefix="$search"
  done <<<"$modded"
}
shaPipe() {
  __textLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_shaPipe() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
randomString() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  head --bytes=64 /dev/random | sha1sum | cut -f 1 -d ' '
}
_randomString() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
stringOffset() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local length=${#2}
  local substring="${2/${1-}*/}"
  local offset="${#substring}"
  if [ "$offset" -eq "$length" ]; then
    offset=-1
  fi
  printf %d "$offset"
}
_stringOffset() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
stringOffsetInsensitive() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local length=${#2}
  local needle haystack
  needle=$(lowercase "${1-}")
  haystack=$(lowercase "${2-}")
  local substring="${haystack/$needle*/}"
  local offset="${#substring}"
  if [ "$offset" -eq "$length" ]; then
    offset=-1
  fi
  printf %d "$offset"
}
_stringOffsetInsensitive() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
removeFields() {
  local handler="_${FUNCNAME[0]}"
  local fieldCount=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      [ -z "$fieldCount" ] || throwArgument "$handler" "Only one fieldCount should be provided argument #$__index: $argument" || return $?
      fieldCount="$(validate "$handler" PositiveInteger "fieldCount" "$argument")" || return $?
      ;;
    esac
    shift
  done
  fieldCount=${fieldCount:-1}
  sed -r 's/^([^ ]+ +){'"$fieldCount"'}//'
}
_removeFields() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
printfOutputPrefix() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || __help "$handler" --help || return 0
  local finished=false char=$'\n' line
  if ! IFS="" read -r line; then finished=true && char=""; fi
  [ -n "$line" ] || ! $finished || return 0
  catchReturn "$handler" printf -- "$@" || return $?
  catchReturn "$handler" printf -- "%s%s" "$line" "$char" || return $?
  catchReturn "$handler" cat || return $?
}
_printfOutputPrefix() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
printfOutputSuffix() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || __help "$handler" --help || return 0
  local finished=false char=$'\n' line
  if ! IFS="" read -r line; then finished=true && char=""; fi
  [ -n "$line" ] || ! $finished || return 0
  catchReturn "$handler" printf -- "%s%s" "$line" "$char" || return $?
  catchReturn "$handler" cat || return $?
  catchReturn "$handler" printf -- "$@" || return $?
}
_printfOutputSuffix() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
stringReplace() {
  local handler="_${FUNCNAME[0]}"
  local needle="" replacement="" sedCommand="" hasTextArguments=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$needle" ]
    then
      needle="$(validate "$handler" String "$argument" "${1-}")" || return $?
    elif [ -z "$sedCommand" ]; then
      replacement="$(validate "$handler" EmptyString "$argument" "${1-}")" || return $?
      sedCommand="s/$(quoteSedPattern "$needle")/$(quoteSedReplacement "$replacement")/g"
    else
      sed -e "$sedCommand" <<<"$1"
      hasTextArguments=true
    fi ;;
    esac
    shift
  done
  if $hasTextArguments; then
    return 0
  fi
  [ -n "$needle" ] || throwArgument "$handler" "Missing needle" || return $?
  [ -n "$sedCommand" ] || throwArgument "$handler" "Missing replacement" || return $?
  sed -e "$sedCommand"
}
_stringReplace() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
textAlignRight() {
  local handler="_${FUNCNAME[0]}"
  local n
  __help "$handler" "$@" || return 0
  n=$(validate "$handler" UnsignedInteger "characterWidth" "${1-}") && shift || return $?
  printf "%${n}s" "$*"
}
_textAlignRight() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
textAlignLeft() {
  local handler="_${FUNCNAME[0]}"
  local n
  __help "$handler" "$@" || return 0
  n=$(validate "$handler" UnsignedInteger "characterWidth" "${1-}") && shift || return $?
  catchEnvironment "$handler" printf -- "%-${n}s" "$*" || return $?
}
_textAlignLeft() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
textRepeat() {
  local handler="_${FUNCNAME[0]}"
  local count=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$count" ]
    then
      count="$(validate "$handler" UnsignedInteger "count" "$1")" || return $?
    else
      local powers curPow
      powers=("$*")
      curPow=${#powers[@]}
      while [ $((2 ** curPow)) -le "$count" ]; do
        powers["$curPow"]="${powers[curPow - 1]}${powers[curPow - 1]}"
        curPow=$((curPow + 1))
      done
      curPow=0
      while [ "$count" -gt 0 ] && [ $curPow -lt ${#powers[@]} ]; do
        if [ $((count & (2 ** curPow))) -ne 0 ]; then
          printf -- "%s" "${powers[$curPow]}"
          count=$((count - (2 ** curPow)))
        fi
        curPow=$((curPow + 1))
      done
      return 0
    fi ;;
    esac
    shift
  done
  throwArgument "$handler" "requires text" || return $?
}
_textRepeat() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
jsonField() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local handler="$1" jsonFile="$2" value message && shift 2
  [ -f "$jsonFile" ] || throwEnvironment "$handler" "$jsonFile is not a file" || return $?
  executableExists jq || throwEnvironment "$handler" "Requires jq - not installed" || return $?
  if ! value=$(jq -r "$@" <"$jsonFile"); then
    message="$(printf -- "%s\n%s\n" "Unable to fetch selector $(decorate each code -- "$@") from JSON:" "$(head -n 100 "$jsonFile")")"
    throwEnvironment "$handler" "$message" || return $?
  fi
  [ -n "$value" ] || throwEnvironment "$handler" "$(printf -- "%s\n%s\n" "Selector $(decorate each code -- "$@") was blank from JSON:" "$(head -n 100 "$jsonFile")")" || return $?
  printf -- "%s\n" "$value"
}
_jsonField() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
jsonPath() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  local paths=()
  while [ $# -gt 0 ]; do
    [ -z "$1" ] || paths+=("$1")
    shift
  done
  printf ".%s\n" "$(listJoin "." "${paths[@]}")"
}
_jsonPath() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__jqPathClean() {
  local path="$1"
  path="${path#.}"
  path="${path%.}"
  path=".$path"
  printf -- "%s\n" "$path"
}
__jqObject() {
  local path="$1" jqPrefix="${2-"{}"}"
  local segments=() segment
  IFS="." read -r -a segments <<<"${path#.}"
  local jqRev=()
  for segment in "${segments[@]}"; do
    jqRev=("$segment" "${jqRev[@]+"${jqRev[@]}"}")
  done
  for segment in "${jqRev[@]}"; do
    jqPrefix="{ $segment: $jqPrefix }"
  done
  printf "%s\n" "$jqPrefix"
}
jsonFileGet() {
  local handler="_${FUNCNAME[0]}"
  local jsonFile path value
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  jsonFile=$(validate "$handler" File "jsonFile" "${1-}") && shift || return $?
  path=$(validate "$handler" String "path" "${1-}") && shift || return $?
  path="$(__jqPathClean "$path")"
  catchReturn "$handler" jq -r "$(__jqObject "$path") + . | $path" <"$jsonFile" || return $?
}
_jsonFileGet() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
jsonFileSet() {
  local handler="_${FUNCNAME[0]}"
  local jsonFile path value
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  executableExists jq || throwEnvironment "$handler" "Requires jq - not installed" || return $?
  jsonFile=$(validate "$handler" File "jsonFile" "${1-}") && shift || return $?
  path=$(validate "$handler" String "path" "${1-}") && shift || return $?
  path=$(__jqPathClean "$path")
  if [ $# -eq 0 ]; then
    catchEnvironment "$handler" jq --sort-keys -r "del($path)" <"$jsonFile" >"$jsonFile.new" || returnClean $? "$jsonFile.new" || return $?
  else
    value=$(validate "$handler" EmptyString "value" "${1-}") && shift || return $?
    local rawValue
    if [ $# -eq 0 ]; then
      rawValue="\"$(escapeDoubleQuotes "$value")\""
    else
      local arrayValue=("\"$(escapeDoubleQuotes "$value")\"")
      while [ $# -gt 0 ]; do
        arrayValue+=("\"$(escapeDoubleQuotes "$1")\"") && shift
      done
      rawValue="[ $(listJoin , "${arrayValue[@]}") ]"
    fi
    catchEnvironment "$handler" jq --sort-keys -r "$(__jqObject "$path") + . | $path = $rawValue" <"$jsonFile" >"$jsonFile.new" || returnClean $? "$jsonFile.new" || return $?
  fi
  catchEnvironment "$handler" mv -f "$jsonFile.new" "$jsonFile" || returnClean $? "$jsonFile.new" || return $?
}
_jsonFileSet() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
jsonSetValue() {
  local handler="_${FUNCNAME[0]}"
  local value="" statusFlag=false quietFlag=false file="" key="version"
  local generator="hookVersionCurrent" filter="versionNoVee"
  executableExists jq || throwEnvironment "$handler" "Requires jq - not installed" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --generator)
      shift
      generator="$(validate "$handler" Function "$argument" "${1-}")" || return $?
      ;;
    --status)
      statusFlag=true
      ;;
    --quiet)
      quietFlag=true
      ;;
    --value)
      shift
      value="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    --key)
      shift
      key="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    --filter)
      shift
      filter="$(validate "$handler" Function "$argument" "${1-}")" || return $?
      ;;
    *)
      file="$(validate "$handler" File "$argument" "${1-}")" || return $?
      if [ -z "$value" ]; then
        if [ -z "$generator" ]; then
          throwArgument "$handler" "--generator or --value is required" || return $?
        fi
        value=$(catchEnvironment "$handler" "$generator") || return $?
        if [ -z "$value" ]; then
          throwEnvironment "$handler" "Value returned by --generator $generator hook is blank" || return $?
        fi
      fi
      if [ -n "$filter" ]; then
        value=$(catchEnvironment "$handler" "$filter" "$value") || return $?
        if [ -z "$value" ]; then
          throwEnvironment "$handler" "Value returned by --filter $filter hook is blank" || return $?
        fi
      fi
      __jsonSetValue "$handler" "$file" "$key" "$value" "$quietFlag" "$statusFlag" || return $?
      ;;
    esac
    shift
  done
  [ -n "$file" ] || throwArgument "$handler" "file is required" || return $?
}
_jsonSetValue() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__jsonSetValue() {
  local handler="$1" json="$2" key="$3" value="$4" quietFlag="$5" statusFlag="$6" key
  local oldValue decoratedJSON newJSON decoratedValue decoratedOldValue
  decoratedJSON="$(decorate file "$json")"
  newJSON="$json.${FUNCNAME[0]}.$$"
  key="${key#.}"
  oldValue="$(catchEnvironment "$handler" jq ".$key" <"$json")" || return $?
  catchEnvironment "$handler" jq --sort-keys --arg value "$value" ". + { $key: \$value }" <"$json" >"$newJSON" || returnClean $? "$newJSON" || return $?
  decoratedValue=$(decorate value "$value")
  decoratedOldValue=$(decorate value "$oldValue")
  if muzzle diff -q "$json" "$newJSON"; then
    $quietFlag || statusMessage --last decorate info "$decoratedJSON $key is $decoratedValue (up to date)"
    catchEnvironment "$handler" rm -rf "$newJSON" || return $?
    ! $statusFlag || return "$(returnCode identical)"
  else
    catchEnvironment "$handler" mv -f "$newJSON" "$json" || returnClean $? "$newJSON" || return $?
    $quietFlag || statusMessage --last decorate info "$decoratedJSON $key updated to $decoratedValue (old value $decoratedOldValue)"
  fi
}
json() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  jq .
}
_json() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mapTokens() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local prefix prefixQ suffix suffixQ removeQuotesPattern argument
  prefix="${1-"{"}"
  prefixQ=$(quoteSedPattern "$prefix")
  suffix="${2-"}"}"
  suffixQ=$(quoteSedPattern "$suffix")
  removeQuotesPattern="s/.*$prefixQ\([^$suffixQ]*\)$suffixQ.*/\1/g"
  sed -e "s/$prefixQ/\n$(quoteSedReplacement "$prefix")/g" -e "s/$suffixQ/$(quoteSedReplacement "$suffix")\n)/g" | sed -e "/$prefixQ/!d" -e "/$suffixQ/!d" -e "$removeQuotesPattern"
}
_mapTokens() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mapValue() {
  local handler="_${FUNCNAME[0]}"
  local searchFilters=() replaceFilters=() mapFile="" prefix='{' suffix='}'
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --prefix)
      shift
      prefix=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --suffix)
      shift
      suffix=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --search-filter)
      shift
      searchFilters+=("$(validate "$handler" Callable "searchFilter" "${1-}")") || return $?
      ;;
    --replace-filter)
      shift
      replaceFilters+=("$(validate "$handler" Callable "replaceFilter" "${1-}")") || return $?
      ;;
    *) if
      [ -z "$mapFile" ]
    then
      mapFile=$(validate "$handler" File "mapFile" "${1-}") || return $?
      shift
      break
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$mapFile" ] || throwArgument "$handler" "mapFile required" || return $?
  (
    local value environment searchToken environmentValue filter
    value="$*"
    while read -r environment; do
      environmentValue=$(catchReturn "$handler" environmentValueRead "$mapFile" "$environment") || return $?
      searchToken="$prefix$environment$suffix"
      if [ ${#searchFilters[@]} -gt 0 ]; then
        for filter in "${searchFilters[@]}"; do
          searchToken=$(catchEnvironment "$handler" "$filter" "$searchToken") || return $?
        done
      fi
      if [ ${#replaceFilters[@]} -gt 0 ]; then
        for filter in "${replaceFilters[@]}"; do
          environmentValue=$(catchEnvironment "$handler" "$filter" "$environmentValue") || return $?
        done
      fi
      value="${value/$searchToken/$environmentValue}"
    done < <(environmentNames <"$mapFile")
    printf "%s\n" "$value"
  )
}
_mapValue() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mapValueTrim() {
  mapValue --handler "_${FUNCNAME[0]}" --replace-filter trimSpace "$@"
}
_mapValueTrim() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mapEnvironment() {
  local handler="_${FUNCNAME[0]}"
  local __prefix='{' __suffix='}' __ee=() __searchFilters=() __replaceFilters=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix) shift && __prefix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --suffix) shift && __suffix=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --search-filter) shift && __searchFilters+=("$(validate "$handler" Callable "searchFilter" "${1-}")") || return $? ;;
    --replace-filter) shift && __replaceFilters+=("$(validate "$handler" Callable "replaceFilter" "${1-}")") || return $? ;;
    --env-file) shift && muzzle validate "$handler" LoadEnvironmentFile "$argument" "${1-}" || return $? ;;
    *) __ee+=("$(validate "$handler" String "environmentVariableName" "$argument")") || return $? ;;
    esac
    shift
  done
  local __e
  if [ "${#__ee[@]}" -eq 0 ]; then
    while read -r __e; do __ee+=("$__e"); done < <(environmentVariables)
  fi
  (
    local __filter __value __handler="$handler"
    unset handler
    __value="$(catchEnvironment "$__handler" cat)" || return $?
    if [ $((${#__replaceFilters[@]} + ${#__searchFilters[@]})) -gt 0 ]; then
      for __e in "${__ee[@]}"; do
        case "$__e" in *[!A-Za-z0-9_]*) continue ;; *) ;; esac
        local __search="$__prefix$__e$__suffix"
        local __replace="${!__e-}"
        if [ ${#__searchFilters[@]} -gt 0 ]; then
          for __filter in "${__searchFilters[@]}"; do
            __search=$(catchEnvironment "$__handler" "$__filter" "$__search") || return $?
          done
        fi
        if [ ${#__replaceFilters[@]} -gt 0 ]; then
          for __filter in "${__replace[@]}"; do
            __replace=$(catchEnvironment "$__handler" "$__filter" "$__replace") || return $?
          done
        fi
        __value="${__value//"$__search"/$__replace}"
      done
    else
      for __e in "${__ee[@]}"; do
        case "$__e" in *[!A-Za-z0-9_]*) continue ;; *) ;; esac
        local __search="$__prefix$__e$__suffix"
        local __replace="${!__e-}"
        __value="${__value//"$__search"/$__replace}"
      done
    fi
    printf "%s\n" "$__value"
  )
}
_mapEnvironment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
cannon() {
  local handler="_${FUNCNAME[0]}"
  local search="" cannonPath="." replace=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --path)
      shift
      cannonPath=$(validate "$handler" Directory "$argument cannonPath" "${1-}") || return $?
      ;;
    *) if
      [ -z "$search" ]
    then
      search="$(validate "$handler" String "searchText" "$argument")" || return $?
    elif [ -z "$replace" ]; then
      replace="$argument"
      shift
      break
    fi ;;
    esac
    shift
  done
  local searchQuoted replaceQuoted cannonLog
  searchQuoted=$(quoteSedPattern "$search")
  replaceQuoted=$(quoteSedPattern "$replace")
  [ "$searchQuoted" != "$replaceQuoted" ] || throwArgument "$handler" "from = to \"$search\" are identical" || return $?
  cannonLog=$(fileTemporaryName "$handler") || return $?
  local undo=(muzzle popd -- rm -f "$cannonLog" "$cannonLog.found" --)
  catchEnvironment "$handler" muzzle pushd "$cannonPath" || return $?
  if ! find "." -type f ! -path "*/.*/*" "$@" -print0 >"$cannonLog"; then
    printf "%s" "$(decorate success '# "')$(decorate code "$1")$(decorate success '" Not found')"
    returnUndo 0 "${undo[@]}"
    return $?
  fi
  xargs -0 grep -l "$search" <"$cannonLog" >"$cannonLog.found" || :
  local exitCode=0 count
  count="$(($(catchReturn "$handler" fileLineCount "$cannonLog.found") + 0))" || returnUndo 0 "${undo[@]}" || return $?
  if [ "$count" -eq 0 ]; then
    statusMessage --inline decorate warning "Modified (NO) files"
  else
    catchReturn "$handler" __xargsSedInPlaceReplace -e "s/$searchQuoted/$replaceQuoted/g" <"$cannonLog.found" || returnUndo 0 "${undo[@]}" || return $?
    statusMessage --inline decorate success "Modified $(decorate code "$(pluralWord "$count" file)")"
    exitCode=3
  fi
  returnUndo "$exitCode" "${undo[@]}" || return $?
  return $?
}
_cannon() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
listJoin() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local IFS="${1-:0:1}"
  shift || :
  printf "%s" "$*"
}
_listJoin() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
listRemove() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local argument listValue="${1-}" separator="${2-}"
  shift 2 || throwArgument "$handler" "Missing arguments" || return $?
  firstFlag=false
  while [ $# -gt 0 ]; do
    local offset next argument="$1"
    [ -n "$argument" ] || throwArgument "$handler" "blank argument" || return $?
    offset="$(stringOffset "$argument$separator" "$separator$separator$listValue$separator")"
    if [ "$offset" -lt 0 ]; then
      shift
      continue
    fi
    offset=$((offset - ${#separator} * 2))
    next=$((offset + ${#argument} + ${#separator}))
    listValue="${listValue:0:offset}${listValue:next}"
    shift
  done
  printf "%s\n" "$listValue"
}
_listRemove() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
listAppend() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local argument listValue="${1-}" separator="${2-}"
  [ ${#separator} -eq 1 ] || throwArgument "$handler" "character-length separator required: ${#separator} $(decorate code "$separator")" || return $?
  shift 2
  firstFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --first)
      firstFlag=true
      ;;
    --last)
      firstFlag=false
      ;;
    *) if
      [ "$(stringOffset "$separator$argument$separator" "$separator$separator$listValue$separator")" -lt 0 ]
    then
      if [ -z "$listValue" ]; then
        listValue="$argument"
      elif "$firstFlag"; then
        listValue="$argument$separator${listValue#"$separator"}"
      else
        listValue="${listValue%"$separator"}$separator$argument"
      fi
    fi ;;
    esac
    shift || throwArgument "$handler" "shift $argument" || return $?
  done
  printf "%s\n" "$listValue"
}
_listAppend() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
listCleanDuplicates() {
  local handler="_${FUNCNAME[0]}"
  local IFS
  local item separator="" showRemoved=false testFunction=""
  local debugFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) debugFlag=true ;;
    --test) shift && testFunction=$(validate "$handler" Callable "$argument" "${1-}") || return $? ;;
    --removed) showRemoved=true ;;
    *) if [ -z "$separator" ]; then separator="$argument"; else break; fi ;;
    esac
    shift
  done
  local tempPath="" removed=()
  while [ $# -gt 0 ]; do
    local items
    IFS="$separator" read -r -a items < <(printf "%s\n" "$1")
    local item
    for item in "${items[@]}"; do
      if [ -n "$testFunction" ] && ! "$testFunction" "$item"; then
        removed+=("$item")
        ! $debugFlag || decorate info "Removed $item with $testFunction"
      else
        tempPath=$(listAppend "$tempPath" "$separator" "$item")
        ! $debugFlag || decorate info "$(decorate code "$tempPath") - Added $item"
      fi
    done
    shift
  done
  IFS="$separator"
  if $showRemoved; then
    printf "%s\n" "${removed[*]}"
  else
    printf "%s\n" "$tempPath"
  fi
}
_listCleanDuplicates() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dateToFormat() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local format="${2-"%F %T"}"
  if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    throwArgument "$handler" "${FUNCNAME[0]} requires 1 or 2 arguments: date [ format ] –- Passed $#:" "$@" || return $?
  fi
  __dateToFormat "$1" "$format"
}
_dateToFormat() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dateToTimestamp() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  dateToFormat "$1" %s
}
_dateToTimestamp() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dateFromTimestamp() {
  local handler="_${FUNCNAME[0]}"
  local isUTC=true value="" format=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --local) isUTC=false ;;
    *) if
      [ -z "$value" ]
    then
      value=$(validate "$handler" UnsignedInteger "timestamp" "$argument") || return $?
    elif [ -z "$format" ]; then
      format=$(validate "$handler" String "format" "$argument") || return $?
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$value" ] || throwArgument "$handler" "No value supplied" || return $?
  [ -n "$format" ] || format="%F %T"
  __dateFromTimestamp "$value" "$format" "$isUTC"
}
_dateFromTimestamp() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dateYesterday() {
  local handler="_${FUNCNAME[0]}"
  if [ $# -eq 0 ]; then
    ts=$(date -u +%s) || return $?
  else
    case "$1" in
    --help) "$handler" 0 && return $? || return "$(convertValue $? 1 0)" ;;
    --local) ts=$(date +%s) ;;
    *) throwArgument "$handler" "Unknown argument: $1" || return $? ;;
    esac
  fi
  dateFromTimestamp "$(($(date -u +%s) - 86400))" %F
}
_dateYesterday() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dateTomorrow() {
  local handler="_${FUNCNAME[0]}" ts
  if [ $# -eq 0 ]; then
    ts=$(date -u +%s) || return $?
  else
    case "$1" in
    --help) "$handler" 0 && return $? || return "$(convertValue $? 1 0)" ;;
    --local) ts=$(date +%s) ;;
    *) throwArgument "$handler" "Unknown argument: $1" || return $? ;;
    esac
  fi
  dateFromTimestamp "$((ts + 86400))" %F
}
_dateTomorrow() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dateToday() {
  local handler="_${FUNCNAME[0]}"
  local uu=(-u)
  [ $# -eq 0 ] || case "$1" in
  --help) "$handler" 0 && return $? || return "$(convertValue $? 1 0)" ;;
  --local) uu=() ;;
  *) throwArgument "$handler" "Unknown argument: $1" || return $? ;;
  esac
  date "${uu[@]+"${uu[@]}"}" +%F
}
_dateToday() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dateValid() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ "${1-}" != "--" ] || shift
  local date="${1-}"
  catchEnvironment "$handler" [ "${date:4:1}${date:7:1}" = "--" ] || return 1
  local year="${date:0:4}" month="${date:5:2}" day="${date:8:2}"
  catchEnvironment "$handler" isUnsignedInteger "$year" || return $?
  catchEnvironment "$handler" isUnsignedInteger "${month#0}" || return $?
  catchEnvironment "$handler" isUnsignedInteger "${day#0}" || return $?
  catchEnvironment "$handler" [ "$year" -gt 1600 ] || return $?
  catchEnvironment "$handler" [ "${month#0}" -ge 1 ] || return $?
  catchEnvironment "$handler" [ "${month#0}" -le 12 ] || return $?
  catchEnvironment "$handler" [ "${day#0}" -ge 1 ] || return $?
  catchEnvironment "$handler" [ "${day#0}" -le 31 ] || return $?
}
_dateValid() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dateAdd() {
  local handler="_${FUNCNAME[0]}" days=1
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --days)
      shift
      days=$(validate "$handler" Integer "$argument" "${1-}") || return $?
      ;;
    *)
      timestamp=$(catchArgument "$handler" dateToTimestamp "$argument") || return $?
      catchArgument "$handler" dateFromTimestamp "$((timestamp + (86400 * days)))" "%F" || return $?
      ;;
    esac
    shift
  done
}
_dateAdd() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
floatRound() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    LC_ALL=C printf '%.0f' "$1"
    shift || :
  done
}
_floatRound() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
floatTruncate() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    LC_ALL=C printf '%d\n' "${1%.*}"
    shift || :
  done
}
_floatTruncate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
urlSchemeDefaultPort() {
  local handler="_${FUNCNAME[0]}"
  local port=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    ftp) port=21 ;;
    ssh) port=22 ;;
    http) port=80 ;;
    https) port=443 ;;
    ldap) port=389 ;;
    ldapa) port=636 ;;
    mysql*) port=3306 ;;
    postgres*) port=5432 ;;
    *) throwArgument "$handler" "unknown scheme #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $? ;;
    esac
    [ -z "$port" ] || printf "%d\n" "$port"
    port=""
    shift
  done
}
_urlSchemeDefaultPort() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
urlParse() {
  local handler="_${FUNCNAME[0]}" upperCase=false prefix="" intPort=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --integer-port)
      intPort=true
      ;;
    --uppercase)
      upperCase=true
      ;;
    --prefix)
      shift
      prefix=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    *)
      local u="${1-}"
      local url="$u" path="" name="" user="" password="" host="" port="" portDefault="" error=""
      local scheme="${u%%://*}"
      if [ "$scheme" != "$url" ] && [ -n "$scheme" ]; then
        u="${u#*://}"
        name="${u#*/}"
        if [ "$name" != "$u" ]; then
          path="/$name"
        else
          path="/"
          name=""
        fi
        u="${u%%/*}"
        host="${u##*@}"
        if [ "$host" = "$u" ]; then
          user=""
          password=""
        else
          user="${u%@*}"
          password="${user#*:}"
          if [ "$password" = "$user" ]; then
            password=""
          else
            user="${user%%:*}"
          fi
        fi
        port="${host##*:}"
        if [ "$port" = "$host" ]; then
          port=""
        else
          host="${host%:*}"
        fi
        error=""
        portDefault="$(urlSchemeDefaultPort --handler "$handler" "$scheme" 2>/dev/null || :)"
        ! $intPort || isPositiveInteger "$port" || port="$portDefault" || return $?
      else
        error="no-scheme"
        scheme=""
      fi
      local variable part
      for part in url path name scheme user password host port portDefault error; do
        variable="$part"
        ! $upperCase || variable=$(uppercase "$part")
        printf "%s%s=%s\n" "$prefix" "$variable" "$(quoteBashString "${!part}")"
      done
      : "$path"
      [ -z "$error" ] || return 1
      ;;
    esac
    shift
  done
}
_urlParse() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
urlParseItem() {
  local handler="_${FUNCNAME[0]}"
  local component="" url=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *) if
      [ -z "$component" ]
    then
      component=$(validate "$handler" String "component" "$1") || return $?
    else
      url="$1"
      (
        local url path name scheme user password host port error=""
        eval "$(urlParse "$url")" || throwArgument "$handler" "Unable to parse $url" || return $?
        [ -z "$error" ] || throwArgument "$handler" "Unable to parse $(decorate code "$url"): $(decorate error "$error")" || return $?
        printf "%s\n" "${!component-}"
      ) || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$url" ] || throwArgument "$handler" "Need at least one URL" || return $?
}
_urlParseItem() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
urlValid() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || throwArgument "$handler" "No arguments" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *) urlParse "$1" >/dev/null || return 1 ;;
    esac
    shift
  done
}
_urlValid() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
urlOpener() {
  local handler="_${FUNCNAME[0]}"
  local binary=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --exec)
      shift
      binary=$(validate "$handler" Executable "$argument" "${1-}") || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  [ -n "$binary" ] || binary="urlOpen"
  local line
  while read -r line; do
    printf -- "%s\n" "$line"
    printf -- "%s\n" "$line" | urlFilter | "$binary"
  done
}
_urlOpener() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_urlExtract() {
  local match foundPrefix minPrefix="" url="${1-}" prefix="$2" lineNumber="$3" debugFlag="${4-false}"
  for match in 'https://*' 'http://*'; do
    foundPrefix="${line%%$match}"
    if [ "$foundPrefix" != "$line" ]; then
      if [ -z "$minPrefix" ]; then
        minPrefix="$foundPrefix"
      elif [ "${#minPrefix}" -gt "${#foundPrefix}" ]; then
        minPrefix="$foundPrefix"
      fi
    fi
  done
  if [ -z "$minPrefix" ]; then
    return 1
  fi
  line="${line:${#minPrefix}}"
  local find="[\"']"
  line="${line//$find/ }"
  ! $debugFlag || printf -- "%s [%s] %s\n" "MATCH LINE CLEAN:" "$(decorate value "$lineNumber")" "$(decorate code "$line")"
  until [ -z "$line" ]; do
    IFS=" " read -r url remain <<<"$line" || :
    url=${url%\"*}
    url=${url%\'*}
    if [ "$url" != "${url#http}" ] && urlValid "$url"; then
      printf "%s%s\n" "$prefix" "$url"
    elif $debugFlag; then
      printf -- "%s [%s] %s\n" "! urlValid:" "$(decorate value "$lineNumber")" "$(decorate code "$url")"
    fi
    line="$remain"
  done
}
urlFilter() {
  local handler="_${FUNCNAME[0]}"
  local files=() file="" aa=() showFile=false debugFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --show-file)
      aa=("$argument")
      showFile=true
      ;;
    --debug)
      debugFlag=true
      ;;
    --file)
      shift
      file="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    *) files+=("$(validate "$handler" File "file" "$1")") || return $? ;;
    esac
    shift
  done
  if [ "${#files[@]}" -gt 0 ]; then
    for file in "${files[@]}"; do
      urlFilter "${aa[@]+"${aa[@]}"}" --file "$file" <"$file"
    done
    return 0
  fi
  local line prefix="" lineNumber=0
  if $showFile && [ -n "$file" ]; then
    prefix="$file: "
  fi
  consoleToPlain | while IFS="" read -r line; do
    lineNumber=$((lineNumber + 1))
    _urlExtract "$line" "$prefix" "$lineNumber" "$debugFlag" || :
  done
}
_urlFilter() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
urlOpen() {
  local handler="_${FUNCNAME[0]}"
  local urls=() waitFlag=false ignoreFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --ignore)
      ignoreFlag=true
      ;;
    --wait)
      waitFlag=true
      ;;
    *) urls+=("$(validate "$handler" String "url" "$1")") || return $? ;;
    esac
    shift
  done
  local url exitCode
  if [ ${#urls[@]} -eq 0 ]; then
    while IFS=' ' read -d$'\n' -r url; do
      exitCode=0
      __urlOpenInnerLoop "$handler" "$url" "$ignoreFlag" "$waitFlag" || exitCode=$?
      if [ "$exitCode" != 0 ]; then
        if [ "$exitCode" != 120 ]; then
          return $exitCode
        fi
        urls+=("$url")
      fi
    done
  else
    set - "${urls[@]}"
    urls=()
    while [ $# -gt 0 ]; do
      url="$1"
      exitCode=0
      __urlOpenInnerLoop "$handler" "$url" "$ignoreFlag" "$waitFlag" || exitCode=$?
      if [ "$exitCode" != 0 ]; then
        if [ "$exitCode" != 120 ]; then
          return $exitCode
        fi
        urls+=("$url")
      fi
      shift
    done
  fi
  $waitFlag || [ "${#urls[@]}" -eq 0 ] || catchReturn "$handler" __urlOpen "${urls[@]}" || return $?
  return 0
}
_urlOpen() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__urlOpenInnerLoop() {
  local handler="$1" url="$2" ignoreFlag="$3" waitFlag="$4"
  if ! urlValid "$url"; then
    if ! $ignoreFlag; then
      throwEnvironment "$handler" "Invalid URL: $(decorate error "$url")" || return $?
    fi
    return 0
  fi
  if $waitFlag; then
    catchReturn "$handler" __urlOpen "$url" || return $?
  else
    return 120
  fi
}
urlFetch() {
  local handler="_${FUNCNAME[0]}"
  local wgetArgs=() curlArgs=() genericArgs=() headers=()
  local binary=() userHasColons=false user="" password="" format="" url="" target=""
  local maxRedirections=9 timeoutSeconds="" debugFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --header)
      shift && local name="${1%%:}" value="${1#*:}"
      if [ "$name" = "${1-}" ] || [ "$value" = "${1-}" ]; then
        catchArgument "$handler" "Invalid $argument ${1-} passed" || return $?
      fi
      headers+=("$1")
      curlArgs+=("--header" "$1")
      wgetArgs+=("--header=$1")
      genericArgs+=("$argument" "$1")
      ;;
    --wget) binary=("wget") ;;
    --curl) binary=("curl") ;;
    --binary)
      local tempBin
      shift && tempBin=$(validate "$handler" String "$argument" "${1-}") || return $?
      executableExists "$tempBin" || throwArgument "$handler" "$tempBin must be in PATH: $PATH" || return $?
      binary=("$tempBin")
      ;;
    --argument-format)
      shift && format=$(validate "$handler" String "$argument" "${1-}") || return $?
      case "$format" in curl | wget) ;; *) throwArgument "$handler" "$argument must be curl or wget" || return $? ;; esac
      ;;
    --redirect-max) shift && maxRedirections=$(validate "$handler" PositiveInteger "$argument" "${1-}") || return $? ;;
    --password) shift && password="$1" ;;
    --user)
      shift && user=$(validate "$handler" String "$argument (user)" "$user") || return $?
      if [ "$user" != "${user#*:}" ]; then
        userHasColons=true
      fi
      curlArgs+=(--user "$user:$password")
      wgetArgs+=("--http-user=$user" "--http-password=$password")
      genericArgs+=("$argument" "$1")
      ;;
    --debug) debugFlag=true ;;
    --timeout)
      shift && timeoutSeconds=$(validate "$handler" PositiveInteger "$argument" "${1-}") || return $?
      ;;
    --agent)
      local agent
      shift && agent=$(validate "$handler" String "$argument" "${1-}") || return $?
      wgetArgs+=("--user-agent=$agent")
      curlArgs+=("--user-agent" "$agent")
      genericArgs+=("$argument" "$agent")
      ;;
    *) if
      [ -z "$url" ]
    then
      url="$1"
    elif [ -z "$target" ]; then
      target="$1"
      shift
      break
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  if [ -z "$timeoutSeconds" ]; then
    export BUILD_URL_TIMEOUT
    timeoutSeconds="${BUILD_URL_TIMEOUT-}"
  fi
  [ -n "$url" ] || throwArgument "$handler" "URL is required" || return $?
  [ -n "$target" ] || target="-"
  [ "$target" = "-" ] || curlArgs+=("-o" "$target")
  if [ -n "$user" ]; then
    curlArgs+=("--user" "$user:$password")
    wgetArgs+=("--http-user=$user" "--http-password=$password")
    genericArgs+=("--user" "$user" "--password" "$password")
  fi
  [ "${#binary[@]}" -gt 0 ] || executableExists wget && binary=("wget") || executableExists "curl" && binary=("curl") || throwArgument "$handler" "No binary found" || return $?
  if [ "${binary[0]}" = "curl" ] && $userHasColons; then
    throwArgument "$handler" "$argument: Users ($argument \"$(decorate code "$user")\") with colons are not supported by curl, use wget" || return $?
  fi
  if isPositiveInteger "$timeoutSeconds"; then
    curlArgs+=(--retry 1 --connect-timeout "$timeoutSeconds" --max-time "$timeoutSeconds")
    wgetArgs+=("--tries=1 --timeout=$timeoutSeconds")
    genericArgs+=(--timeout "$timeoutSeconds")
  fi
  [ "${#binary[@]}" -gt 0 ] || throwEnvironment "$handler" "wget or curl required" || return $?
  [ -n "$format" ] || format="${binary[0]}"
  ! $debugFlag || binary=("decorate" "each" "code" "${binary[@]}")
  case "$format" in
  wget)
    wgetArgs+=(--max-redirect "$maxRedirections" -q)
    catchEnvironment "$handler" "${binary[@]}" --output-document="$target" "${wgetArgs[@]+"${wgetArgs[@]}"}" "$url" "$@" || return $?
    ;;
  curl)
    curlArgs+=(-L --max-redirs "$maxRedirections" -s -f --no-show-error)
    catchEnvironment "$handler" "${binary[@]}" "$url" "$@" "${curlArgs[@]+"${curlArgs[@]}"}" || return $?
    ;;
  *) throwEnvironment "$handler" "No handler for binary format $(decorate value "$format") (binary is $(decorate each code "${binary[@]}")) $(decorate each value -- "${genericArgs[@]}")" || return $? ;;
  esac
}
_urlFetch() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__urlOpen() {
  local handler="${FUNCNAME[0]#_}" binary
  binary=$(catchReturn "$handler" buildEnvironmentGet BUILD_URL_BINARY) || return $?
  if [ -z "$binary" ]; then
    while IFS='' read -d$'\n' -r binary; do
      if executableExists "$binary"; then
        break
      fi
    done < <(catchReturn "$handler" __urlBinary) || return $?
    if [ -z "$binary" ]; then
      printf "%s %s\n" "OPEN: " "$(consoleLink "$url")"
      return 0
    fi
  else
    binary=$(validate "$handler" Executable "BUILD_URL_BINARY" "$binary") || return $?
  fi
  [ $# -gt 0 ] || catchArgument "$handler" "Require at least one URL" || return $?
  catchEnvironment "$handler" "$binary" "$@" || return $?
}
consoleHasColors() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  export BUILD_COLORS
  if [ -z "${BUILD_COLORS-}" ]; then
    BUILD_COLORS=false
    case "${TERM-}" in "" | "dumb" | "unknown") BUILD_COLORS=true ;; *)
      local termColors
      termColors="$(tput colors 2>/dev/null)"
      isPositiveInteger "$termColors" || termColors=2
      [ "$termColors" -lt 8 ] || BUILD_COLORS=true
      ;;
    esac
  elif [ "${BUILD_COLORS-}" != "true" ]; then
    BUILD_COLORS=false
  fi
  [ "${BUILD_COLORS-}" = "true" ]
}
_consoleHasColors() {
  true || consoleHasColors --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__decorate() {
  local prefix="$1" start="$2" end="$3" && shift 3
  export BUILD_COLORS
  if [ -n "${BUILD_COLORS-}" ] && [ "${BUILD_COLORS-}" = "true" ] || [ -z "${BUILD_COLORS-}" ] && consoleHasColors; then
    if [ $# -eq 0 ]; then printf -- "%s$start" ""; else printf -- "$start%s$end\n" "$*"; fi
    return 0
  fi
  [ $# -gt 0 ] || return 0
  if [ -n "$prefix" ]; then printf -- "%s: %s\n" "$prefix" "$*"; else printf -- "%s\n" "$*"; fi
}
decorations() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" reset \
    underline no-underline bold no-bold \
    black black-contrast blue cyan green magenta orange red white yellow \
    code info notice success warning error subtle label value decoration
}
_decorations() {
  ! false || decorations --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
decorate() {
  local handler="_${FUNCNAME[0]}" what="${1-}"
  [ "$what" != "--help" ] || __help "$handler" "$@" || return 0
  [ -n "$what" ] || catchArgument "$handler" "Requires at least one argument: \"$*\"" || return $?
  local style && shift && catchReturn "$handler" _decorateInitialize || return $?
  if ! style=$(__decorateStyle "$what"); then
    local extend func="${what/-/_}"
    extend="__decorateExtension$(printf "%s" "${func:0:1}" | awk '{print toupper($0)}')${func:1}"
    if isFunction "$extend"; then
      executeInputSupport "$handler" "$extend" -- "$@" || return $?
      return 0
    else
      executeInputSupport "$handler" __decorate "❌" "[$what ☹️" "]" -- "$@" || return 2
    fi
  fi
  local lp text="" && IFS=" " read -r lp text <<<"$style" || :
  local p='\033['
  executeInputSupport "$handler" __decorate "$text" "$p${lp}m" "${p}0m" -- "$@" || return $?
}
_decorate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
decorateInitialized() {
  [ "${1-}" != "--help" ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0
  export __BUILD_DECORATE
  [ -n "${__BUILD_DECORATE-}" ]
}
_decorateInitialized() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_decorateInitialize() {
  export __BUILD_DECORATE
  [ -n "${__BUILD_DECORATE-}" ] || __decorateStyles || return $?
}
__decorateStyle() {
  local original style pattern=":$1="
  original="$__BUILD_DECORATE"
  style="${__BUILD_DECORATE#*"$pattern"}"
  [ "$style" != "$original" ] || return 1
  printf "%s\n" "${style%%:*}"
}
if ! isFunction __decorateStyles; then
  __decorateStyles() {
    __decorateStylesDefaultLight
  }
fi
__decorateStylesBase() {
  local styles=":reset=0:underline=4:no-underline=24:bold=1:no-bold=21:black=109;7:black-contrast=107;30:blue=94:cyan=36:green=92:magenta=35:orange=33:red=31:white=48;5;0;37:yellow=48;5;16;38;5;11:"
  styles="$styles:$(printf "%s:" "$@")"
  styles="$styles:code=1;97;44:warning=1;93;41 Warning:error=1;91 ERROR:"
  export __BUILD_DECORATE
  __BUILD_DECORATE="$styles"
}
__decorateStylesDefaultLight() {
  local aa=(
    "info=38;5;20 Info"
    "notice=46;31 Notice"
    "success=42;30 Success"
    "subtle=1;38;5;252"
    "label=34;103"
    "value=30;107"
    "decoration=45;97")
  __decorateStylesBase "${aa[@]}"
}
__decorateStylesDefaultDark() {
  local aa=(
    "info=33 Info"
    "notice=97;44 Notice"
    "success=0;32 Success"
    "subtle=38;5;240"
    "label=96;40"
    "value=94"
    "decoration=45;30")
  __decorateStylesBase "${aa[@]}"
}
__decorateExtensionEach() {
  local __saved=("$@") __count=$#
  local formatted=() item addIndex=false showCount=false index=0 prefix="" style=""
  while [ $# -gt 0 ]; do
    case "$1" in --index) addIndex=true ;; --count) showCount=true ;; --arguments) showCount=true ;;
    "") throwArgument "$handler" "Blank argument" || return $? ;;
    *) style="$1" && shift && break ;;
    esac
    shift
  done
  local codes=("$style")
  if [ "$style" != "${style#*,}" ]; then
    IFS="," read -r -a codes <<<"$style"
    [ "${#codes[@]}" -gt 0 ] || throwArgument "$handler" "Blank style passed to each: \"$style\" (${__saved[*]})"
  fi
  if [ $# -eq 0 ]; then
    local byte
    if read -r -t 1 -n 1 byte; then
      if [ "$byte" = $'\n' ]; then
        formatted+=("$prefix$(decorate "${codes[@]}" "")")
        byte=""
      fi
      local done=false
      while ! $done; do
        IFS='' read -r item || done=true
        [ -n "$byte$item" ] || ! $done || break
        ! $addIndex || prefix="$index:"
        formatted+=("$prefix$(decorate "${codes[@]}" "$byte$item")")
        byte=""
        index=$((index + 1))
      done
    fi
  else
    [ "${1-}" != "--" ] || shift
    while [ $# -gt 0 ]; do
      ! $addIndex || prefix="$index:"
      item="$1"
      formatted+=("$prefix$(decorate "${codes[@]}" "$item")")
      shift
      index=$((index + 1))
    done
  fi
  ! $showCount || formatted+=("[$index]")
  IFS=" " printf -- "%s\n" "${formatted[*]-}"
}
__decorateExtensionBOLD() {
  local style="${1-}" && shift
  case "$style" in
  "" | "-" | "--")
    decorate bold "$*"
    return 0
    ;;
  esac
  local codes=("$style")
  if [ "$style" != "${style#*,}" ]; then
    IFS="," read -r -a codes <<<"$style"
    [ "${#codes[@]}" -gt 0 ] || throwArgument "$handler" "Blank style passed to BOLD: \"$style\" (${__saved[*]})"
  fi
  if [ "$*" != "--" ]; then
    if [ $# -eq 0 ]; then
      decorate "${codes[@]}" | decorate bold
    else
      decorate bold "$(decorate "${codes[@]}" -- "$@")"
    fi
  else
    decorate bold --
    decorate "${codes[@]}" --
  fi
}
__decorateExtensionQuote() {
  if [ $# -eq 0 ]; then
    local finished=false
    while ! $finished; do
      local line="" && IFS="" read -d $'\n' -r line || finished=true
      [ -n "$line" ] || ! $finished || continue
      __decorateExtensionQuoteProcessLine "$line" || return $?
    done
  else
    [ "$1" != "--" ] || shift
    __decorateExtensionQuoteProcessLine "$@" || return $?
  fi
}
__decorateExtensionQuoteProcessLine() {
  local text="$*"
  text="${text//\"/\\\"}"
  text="${text//\$/\\\$}"
  printf -- "\"%s\"\n" "$text"
}
decorateStyle() {
  local handler="_${FUNCNAME[0]}"
  local style="" newFormat="" oldFormat changed=false
  _decorateInitialize || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$style" ]
    then
      style=$(validate "$handler" String "style" "$1") || return $?
    else
      export __BUILD_DECORATE
      newFormat=$(validate "$handler" String "newFormat" "$1") || return $?
      if oldFormat=$(__decorateStyle "$style"); then
        __BUILD_DECORATE="$(__decorateStyleReplace "$__BUILD_DECORATE" "$style" "$newFormat")"
      else
        __BUILD_DECORATE="$__BUILD_DECORATE$style=$newFormat:"
      fi
      changed=true
    fi ;;
    esac
    shift
  done
  ! $changed || __decorateThemeSedFile "$handler" --delete
  if [ -n "$style" ]; then
    if ! oldFormat=$(__decorateStyle "$style"); then
      return 1
    fi
    printf "%s\n" "$oldFormat"
  fi
}
_decorateStyle() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__decorateStyleReplace() {
  local colors="$1" style="$2" newFormat="$3" result
  local pattern=":$style="
  result="${colors#*"$pattern"}"
  result="${colors%%"$pattern"*}$pattern$newFormat:${result#*:}"
  printf "%s\n" "$result"
}
decorateThemelessMode() {
  local handler="_${FUNCNAME[0]}"
  local endFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --end) endFlag=true ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  export __BUILD_DECORATE
  [ -n "${__BUILD_DECORATE-}" ] || throwEnvironment "$handler" "Decorate colors not initialized." || return $?
  export __BUILD_DECORATE_SAVED
  if $endFlag; then
    [ -n "${__BUILD_DECORATE_SAVED-}" ] || throwEnvironment "$handler" "Themeless mode not saved." || return $?
    __BUILD_DECORATE="$__BUILD_DECORATE_SAVED"
    unset __BUILD_DECORATE_SAVED
    return 0
  else
    [ -z "${__BUILD_DECORATE_SAVED-}" ] || throwEnvironment "$handler" "Themeless mode already initialized." || return $?
  fi
  local styles=()
  local finished=false && while ! $finished; do
    local style && read -r style || finished=true
    [ -n "$style" ] || continue
    styles+=("$style=[($style)]")
  done < <(decorations)
  __BUILD_DECORATE_SAVED="${__BUILD_DECORATE-}"
  __BUILD_DECORATE=":$(listJoin ":" "${styles[@]}"):"
}
_decorateThemelessMode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
decorateThemed() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) break ;;
    esac
    shift
  done
  if [ $# -gt 0 ]; then
    catchEnvironment "$handler" printf "%s\n" "$@" | __decorateThemed "$handler" || return $?
  else
    __decorateThemed "$handler" || return $?
  fi
}
_decorateThemed() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__decorateThemed() {
  local handler="$1" && shift
  export __BUILD_DECORATE
  [ -n "${__BUILD_DECORATE-}" ] || throwEnvironment "$handler" "Decorate colors not initialized." || return $?
  local sedFile && sedFile=$(__decorateThemeSedFile "$handler") || return $?
  catchEnvironment "$handler" sed -f "$sedFile" || return $?
}
__decorateThemeGenerateSedFile() {
  local handler="$1" && shift
  local style colorCode && while IFS="=" read -r -d ':' style colorCode; do
    [ -z "$style" ] || catchReturn "$handler" sedReplacePattern "[($style)]" "${colorCode%% *}" || return $?
  done
}
__decorateThemeSedFile() {
  local handler="$1" && shift
  export __BUILD_DECORATE_THEME
  case "${1-}" in
  --delete)
    [ -f "${__BUILD_DECORATE_THEME-}" ] || return 0
    catchEnvironment "$handler" rm -f "${__BUILD_DECORATE_THEME-}" || return $?
    unset __BUILD_DECORATE_THEME
    return 0
    ;;
  esac
  export __BUILD_DECORATE
  if [ ! -f "${__BUILD_DECORATE_THEME-}" ]; then
    local sedFile && sedFile="$(catchReturn "$handler" buildCacheDirectory)/theme.sed" || return $?
    __decorateThemeGenerateSedFile "$handler" >"$sedFile" <<<"${__BUILD_DECORATE-}" || returnClean $? "$sedFile" || return $?
    __BUILD_DECORATE_THEME="$sedFile"
  fi
  catchEnvironment "$handler" printf "%s\n" "${__BUILD_DECORATE_THEME-}" || return $?
}
__decorateExtensionPair() {
  local width="" name
  if isUnsignedInteger "${1-}"; then
    width="$1" && shift
  fi
  if [ -z "$width" ]; then
    export BUILD_PAIR_WIDTH
    width=${BUILD_PAIR_WIDTH-}
    isUnsignedInteger "$width" || width=40
  fi
  name="${1-}"
  shift 2>/dev/null || :
  if [ -z "$name" ]; then
    return 0
  fi
  printf "%s %s%s\n" "$(decorate label "$(textAlignLeft "$width" "$name")")" "$(decorate each -- value "$@")" "$(decorate reset --)"
}
__decorateExtensionDiff() {
  local handler="returnMessage"
  local leftStyle && leftStyle=$(validate "$handler" String "leftStyle" "${1-}") && shift || return $?
  local rightStyle && rightStyle=$(validate "$handler" String "leftStyle" "${1-}") && shift || return $?
  local finished=false
  while ! $finished; do
    local line && IFS="" read -r -d $'\n' line || finished=true
    [ -n "$line" ] || continue
    case "${line:0:3}" in
    "---") decorate "$leftStyle" "${line#--- }" ;;
    "-"*) decorate "$leftStyle" "${line:1}" ;;
    '+++') decorate "$rightStyle" "${line#+++ }" ;;
    "+"*) decorate "$rightStyle" "${line:1}" ;;
    "@"*) line="${line% @@*}" && decorate "subtle" "${line#@@* }" ;;
    " "*) printf "%s\n" "${line:1}" ;;
    *) printf "%s\n" "$line" ;;
    esac
  done
}
decoratePath() {
  local handler="_${FUNCNAME[0]}"
  local skipApp=false
  local mapping=() items=()
  local path icon
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --skip-app | --no-app) skipApp=true ;;
    --path)
      path="${argument%%=*}"
      icon="${argument#*=}"
      [ -n "$icon" ] || throwArgument "$handler" 'Invalid path, must be in the form `path=icon`' || return $?
      mapping=("$path" "$icon" "${mapping[@]+"${mapping[@]}"}")
      ;;
    *) items+=("$argument") ;;
    esac
    shift
  done
  [ "${#items[@]}" -gt 0 ] || return 0
  export HOME BUILD_HOME TMPDIR
  [ -z "${TMPDIR-}" ] || mapping+=("$TMPDIR" "💣")
  $skipApp || [ -z "${BUILD_HOME-}" ] || mapping+=("$BUILD_HOME" "🍎")
  [ -z "${HOME-}" ] || mapping+=("$HOME" "🏠")
  for item in "${items[@]}"; do
    set -- "${mapping[@]}"
    while [ $# -gt 1 ]; do
      item="${item//$1/$2}"
      shift 2
    done
    [ -z "$item" ] || printf "%s\n" "$item"
  done
}
_decoratePath() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__decorateExtensionSize() {
  while [ $# -gt 0 ]; do
    local size="$1"
    [ "$size" != "--" ] || continue
    if isUnsignedInteger "$size"; then
      if [ "$size" -lt 4096 ]; then
        printf "%db\n" "$size"
      elif [ "$size" -lt 4194304 ]; then
        printf "%dk (%d)\n" "$((size / 1024))" "$size"
      elif [ "$size" -lt 4294967296 ]; then
        printf "%dM (%d)\n" "$((size / 1048576))" "$size"
      else
        printf "%dG (%d)\n" "$((size / 1073741824))" "$size"
      fi
    else
      printf "%s\n" "[SIZE $size]"
    fi
    shift
  done
}
__decorateExtensionWrap() {
  local handler="_${FUNCNAME[0]}"
  local prefix=$'\1' suffix
  local fill="" width=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --fill)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      [ 1 -eq "${#1}" ] || throwArgument "$handler" "Fill character must be single character" || return $?
      fill="$1"
      width="${width:-needed}"
      ;;
    --width)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      isUnsignedInteger "$1" && [ "$1" -gt 0 ] || throwArgument "$handler" "$argument requires positive integer" || return $?
      width="$1"
      ;;
    *) if
      [ "$prefix" = $'\1' ]
    then
      prefix="$1"
      shift
      suffix="${*-}"
      [ $# -gt 0 ] || break
    fi ;;
    esac
    shift
  done
  if [ "$prefix" = $'\1' ]; then
    catchEnvironment "$handler" cat || return $?
    return 0
  fi
  if ! isUnsignedInteger "$width"; then
    width=$(consoleColumns) || throwEnvironment "$handler" "consoleColumns" || return $?
  fi
  local actualWidth
  if [ -n "$width" ]; then
    local strippedText
    strippedText="$(printf "%s" "$prefix$suffix" | consoleToPlain)"
    actualWidth=$((width - ${#strippedText}))
    if [ "$actualWidth" -lt 0 ]; then
      throwArgument "$handler" "$width is too small to support prefix and suffix characters (${#prefix} + ${#suffix}):"$'\n'"prefix=$prefix"$'\n'"suffix=$suffix" || return $?
    fi
    if [ "$actualWidth" -eq 0 ]; then
      fill=
    fi
  fi
  local pad="" line
  while IFS= read -r line; do
    if [ -n "$fill" ]; then
      local cleanLine
      cleanLine="$(printf "%s" "$line" | consoleToPlain)"
      padWidth=$((actualWidth - ${#cleanLine}))
      if [ $padWidth -gt 0 ]; then
        pad=$(textRepeat "$padWidth" "$fill")
      else
        pad=
      fi
    fi
    printf "%s%s%s%s\n" "$prefix" "$line" "$pad" "$suffix"
  done
}
___decorateExtensionWrap() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleLine() {
  local handler="_${FUNCNAME[0]}"
  local barText="" width count delta=""
  width=$(catchReturn "$handler" consoleColumns) || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if
        [ $# -gt 2 ]
      then
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      barText="$argument"
      shift
      if [ -n "${1-}" ]; then
        delta=$(validate "$handler" Integer "delta" "$1") || return $?
      else
        delta=0
        break
      fi
      ;;
    esac
    shift
  done
  [ -n "$barText" ] || barText="="
  [ -n "$delta" ] || delta=0
  count=$((width / ${#barText}))
  count=$((count + delta))
  [ $count -gt 0 ] || throwArgument "$handler" "count $count (delta $delta) less than zero?" || return $?
  printf -- "%s\n" "$(textRepeat "$count" "$barText")"
}
_consoleLine() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleHeadingLine() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local text cleanText width barText
  width=$(catchReturn "$handler" consoleColumns) || return $?
  barText=$(validate "$handler" String "barText" "${1:--}") || return $?
  shift || :
  text="$*"
  cleanText=$(consoleToPlain <<<"$text")
  local barWidth=$((width - ${#cleanText}))
  if [ $barWidth -gt 0 ]; then
    local count=$((barWidth / ${#barText}))
    if [ $count -gt 0 ]; then
      barText="$(textRepeat "$((count + 1))" "$barText")"
      printf "%s%s\n" "$text" "${barText:0:barWidth}"
      return 0
    fi
  fi
  printf "%s\n" "${text:0:width}"
}
_consoleHeadingLine() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleHeadingBoxed() {
  local handler="_${FUNCNAME[0]}"
  local textLines=() outside="decoration" inside="" shrink=0 nLines=1
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --outside) shift && outside=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    --inside) shift && inside=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    --shrink) shift && shrink=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $? ;;
    --size) shift && nLines=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $? ;;
    *) textLines+=("$argument") ;;
    esac
    shift
  done
  shrink=$((-(shrink + 2)))
  local bar && bar="+$(consoleLine '' "$shrink")+"
  local width=${#bar}
  local endBar && endBar="|"
  local emptyBar
  if [ -n "$inside" ]; then
    emptyBar="$endBar$(decorate "$inside" "$(consoleLine ' ' "$shrink")")$endBar"
  else
    emptyBar="|$(consoleLine ' ' $shrink)|"
  fi
  local run=(printf "%s\n")
  [ -z "$outside" ] || run=(decorate "$outside")
  local head && head=$([ "$nLines" -eq 0 ] || catchReturn "$handler" runCount "$nLines" "${run[@]}" "$emptyBar" || return $?) || return $?
  catchReturn "$handler" "${run[@]}" "$bar" || return $?
  catchReturn "$handler" printf "%s" "$head" || return $?
  endBar="$("${run[@]}" "$endBar")"
  if [ "${#textLines[@]}" -eq 0 ]; then
    local finished=false && while ! $finished; do
      local textLine && read -r textLine || finished=true
      [ -n "$textLine" ] || ! $finished || continue
      __boxLine "$handler" "$width" "$textLine" "$endBar" || return $?
    done
  else
    __boxLine "$handler" "$width" "${textLines[*]}" "$endBar" || return $?
  fi
  catchReturn "$handler" printf "%s" "$head" || return $?
  catchReturn "$handler" "${run[@]}" "$bar" || return $?
}
_consoleHeadingBoxed() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__boxLine() {
  local handler="$1" && shift
  local width="$1" && shift
  local textLine="$1" && shift
  local endBar="$1" && shift
  local allSpaces && allSpaces=$(textRepeat "$width" " ")
  textLine=$(consoleTrimWidth "$((width - 4))" "$textLine$allSpaces")
  if [ -n "$inside" ]; then
    textLine="$(decorate "$inside" " $textLine ")" || return $?
  else
    textLine=" $textLine "
  fi
  catchReturn "$handler" printf -- "%s\n" "$endBar$textLine$endBar" || return $?
}
bigText() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local fonts binary index=0
  binary=$(catchReturn "$handler" buildEnvironmentGet BUILD_TEXT_BINARY) || return $?
  [ -n "$binary" ] || binary="$(catchReturn "$handler" __bigTextBinary)" || return $?
  [ -n "$binary" ] || throwEnvironment "$handler" "Need BUILD_TEXT_BINARY" || return $?
  case "$binary" in
  figlet) fonts=("standard" "big") ;;
  toilet) fonts=("smblock" "smmono12") ;;
  *) throwEnvironment "$handler" "Unknown BUILD_TEXT_BINARY $(decorate code "$binary")" || return $? ;;
  esac
  if ! executableExists "$binary"; then
    decorate green "BIG TEXT: $*"
    return 0
  fi
  if [ "${1-}" = "--bigger" ]; then
    index=1
    shift
  fi
  "$binary" -w "$(consoleColumns)" -f "${fonts[index]}" "$@"
}
_bigText() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bigTextAt() {
  local handler="_${FUNCNAME[0]}"
  local message="" x="" y=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$x" ]
    then
      x=$(validate "$handler" Integer "xOffset" "$argument") || return $?
    elif [ -z "$y" ]; then
      y=$(validate "$handler" Integer "yOffset" "$argument") || return $?
    else
      message=$(catchEnvironment "$handler" bigText "$@") || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$x" ] || throwArgument "$handler" "Missing x" || return $?
  [ -n "$y" ] || throwArgument "$handler" "Missing y" || return $?
  local maxX maxY theX="$x" theY="$y" saveX saveY
  maxX=$(catchReturn "$handler" consoleColumns) || return $?
  maxY=$(catchReturn "$handler" consoleRows) || return $?
  [ "$x" -lt "$maxX" ] || throwArgument "$handler" "$x -gt $maxX exceeds column width" || return $?
  [ "$y" -lt "$maxY" ] || throwArgument "$handler" "$y -gt $maxY exceeds row height" || return $?
  [ "$x" -gt "-$maxX" ] || throwArgument "$handler" "$x -lt -$maxX exceeds negative column width" || return $?
  [ "$y" -gt "-$maxY" ] || throwArgument "$handler" "$y -lt -$maxY exceeds negative row height" || return $?
  IFS=$'\n' read -r -d '' saveX saveY < <(cursorGet)
  [ "$theX" -ge 0 ] || theX=$((maxX + theX))
  [ "$theY" -ge 0 ] || theY=$((maxY + theY))
  local outputLine
  while read -r outputLine; do
    catchEnvironment "$handler" cursorSet "$theX" "$theY" || return $?
    printf -- "%s" "$outputLine"
    theY=$((theY + 1))
    [ "$theY" -le "$maxY" ] || break
  done < <(printf "%s\n" "$message")
  catchEnvironment "$handler" cursorSet "$saveX" "$saveY" || return $?
}
_bigTextAt() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
labeledBigText() {
  local handler="_${FUNCNAME[0]}"
  local plainLabel="" label="" isBottom=true linePrefix="" lineSuffix="" tweenLabel="" tweenNonLabel=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --top)
      isBottom=false
      ;;
    --bottom)
      isBottom=true
      ;;
    --prefix)
      shift || :
      linePrefix="${1-}"
      ;;
    --suffix)
      shift || :
      lineSuffix="${1-}"
      ;;
    --tween)
      shift || :
      tweenLabel="${1-}"
      tweenNonLabel="${1-}"
      ;;
    *)
      if
        [ "$argument" != "${argument#-}" ]
      then
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      label="$argument"
      plainLabel="$(printf -- "%s\n" "$label" | consoleToPlain)" || throwArgument "$handler" "Unable to clean label" || return $?
      shift
      break
      ;;
    esac
    shift
  done
  local banner nLines
  banner="$(bigText "$@")"
  nLines=$(printf -- "%s\n" "$banner" | fileLineCount)
  plainLabel="$(printf -- "%s\n" "$label" | consoleToPlain)"
  tweenNonLabel="$(textRepeat "$((${#plainLabel}))" " ")$tweenNonLabel"
  if $isBottom; then
    printf -- "%s%s\n""%s%s%s\n" \
      "$(printf -- "%s\n" "$banner" | decorate wrap "$linePrefix$tweenNonLabel" "$lineSuffix" | head -n "$((nLines - 1))")" "$lineSuffix" \
      "$linePrefix$label$tweenLabel" "$(printf -- "%s\n" "$banner" | tail -n 1)" "$lineSuffix"
  else
    printf -- "%s%s%s\n""%s%s\n" \
      "$linePrefix$label$tweenLabel" "$(printf -- "%s\n" "$banner" | head -n 1)" "$lineSuffix" \
      "$(printf -- "%s\n" "$banner" | decorate wrap "$linePrefix$tweenNonLabel" "$lineSuffix" | tail -n "$((nLines - 1))")" "$lineSuffix"
  fi
}
_labeledBigText() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__wrapColor() {
  local escapeColor=$'\e'"["
  local wrapPrefix="$1" && shift
  local suffix="${escapeColor}0m" text="$*" _magic="¢" start starts end ends
  text="${text//$suffix/$_magic}"
  IFS="$_magic" read -r -a starts <<<"$text" || :
  if [ "${#starts[@]}" -ge 1 ]; then
    for start in "${starts[@]}"; do
      start="${start//$escapeColor/$_magic}"
      IFS="$_magic" read -r -a ends <<<"$start" || :
      if [ "${#ends[@]}" -eq 2 ]; then
        printf "%s" "$wrapPrefix"
        printf "%s" "${ends[0]}"
        printf "%s" "$suffix"
        printf "%s%s" "$escapeColor" "${ends[1]}"
      else
        printf -- "%s%s%s" "$wrapPrefix" "$start" "$suffix"
      fi
    done
  else
    printf -- "%s%s%s" "$wrapPrefix" "$text" "$suffix"
  fi
}
consoleHasAnimation() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  export CI
  [ -z "${CI-}" ]
}
_consoleHasAnimation() {
  true || consoleHasAnimation --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__consoleEscape() {
  local start="$1" end="$2"
  shift && shift
  if consoleHasColors; then
    if [ -z "$*" ]; then
      printf "%s$start" ""
    else
      printf "$start%s$end\n" "$*"
    fi
  else
    printf "%s\n" "$*"
  fi
}
__consoleEscape1() {
  local start="$1"
  shift
  if consoleHasColors; then
    if [ -z "$*" ]; then
      printf "%s$start" ""
    else
      __wrapColor "$start" "$@"
    fi
  else
    printf "%s\n" "$*"
  fi
}
colorSampleCodes() {
  local i j n
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  if ! consoleHasColors; then
    printf "no colors\n"
    return 0
  fi
  i=0
  while [ $i -lt 11 ]; do
    j=0
    while [ $j -lt 10 ]; do
      n=$((10 * i + j))
      if [ $n -gt 108 ]; then
        break
      fi
      printf "\033[%dm %3d\033[0m" $n $n
      j=$((j + 1))
    done
    printf "\n"
    i=$((i + 1))
  done
}
_colorSampleCodes() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
colorSampleCombinations() {
  local fg bg text extra padding
  local top3=37
  __help "_${FUNCNAME[0]}" "$@" || return 0
  extra="0;"
  if [ "$1" = "--bold" ]; then
    shift || :
    extra="1;"
  fi
  text="${*-" ABC "}"
  padding="$(textRepeat $((${#text} - 3)) " ")"
  printf "   "
  for fg in $(seq 30 "$top3") $(seq 90 97); do
    printf "\033[%s%dm%3d%s\033[0m " "$extra" "$fg" "$fg" "$padding"
  done
  printf "\n"
  for bg in $(seq 40 47) $(seq 100 107); do
    printf "\033[%s%dm%3d\033[0m " "$extra" "$bg" "$bg"
    for fg in $(seq 30 "$top3") $(seq 90 97); do
      printf "\033[%s%d;%dm$text\033[0m " "$extra" "$fg" "$bg"
    done
    printf "\n"
  done
}
_colorSampleCombinations() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
colorSampleStyles() {
  [ $# -eq 0 ] || __help "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local styles=(
    red
    green
    blue
    cyan
    orange
    magenta
    black
    black-contrast
    white
    underline
    bold
    code
    info
    notice
    success
    error
    label
    value
    warning
    decoration
    subtle)
  local text="$*" i
  [ -n "$text" ] || text="The quick brown fox jumped over the lazy dog."
  local style && for style in "${styles[@]}"; do
    local label
    label=$(textAlignLeft 10 "$style")
    printf -- "%s%s\n" "$(decorate reset --)" "$(decorate "$style" "     $label: $text")"
    printf -- "%s%s\n" "$(decorate reset --)" "$(decorate BOLD "$style" "BOLD $label: $text")"
  done
}
_colorSampleStyles() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
colorSampleSemanticStyles() {
  [ $# -eq 0 ] || __help "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local styles=(
    code
    decoration
    error
    info
    label
    notice
    subtle
    success
    value
    warning)
  local text="$*" reset=$'\e'"[0m"
  [ -n "$text" ] || text="The quick brown fox jumped over the lazy dog."
  local style && for style in "${styles[@]}"; do
    local leftLabel && leftLabel=$(textAlignLeft 10 "$style")
    printf "%s" "$reset"
    decorate "$style" "     $leftLabel: $text"
    printf "%s" "$reset"
    decorate BOLD "$style" "BOLD $leftLabel: $text"
  done
  decorate "pair" "pair" "$text"
  decorate BOLD "pair" "BOLD pair" "$text"
}
_colorSampleSemanticStyles() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleLineFill() {
  local handler="_${FUNCNAME[0]}"
  if consoleHasAnimation; then
    catchEnvironment "$handler" printf -- "\r%s\r%s" "$(textRepeat "$(consoleColumns)" " ")" "$*" || return $?
  else
    catchEnvironment "$handler" printf -- "%s\n" "$*" || return $?
  fi
}
_consoleLineFill() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
plasterLines() {
  local handler="_${FUNCNAME[0]}"
  local line curX curY rows character=" "
  IFS=$'\n' read -r -d '' curX curY < <(cursorGet) || :
  isUnsignedInteger "$curX" && isUnsignedInteger "$curY" || throwEnvironment "$handler" "cursorGet returned non-unsigned integer: \"$curX\" \"$curY\"" || return $?
  rows=$(catchReturn "$handler" consoleRows) || return $?
  columns=$(catchReturn "$handler" consoleColumns) || return $?
  while IFS="" read -r line; do
    catchEnvironment "$handler" cursorSet 1 "$curY" || return $?
    printf "%s" "$line"
    IFS=$'\n' read -r -d '' curX _ < <(cursorGet) || :
    printf "%s" "$(textRepeat $((columns - curX)) "$character")"
    curY=$((curY + 1))
    [ $curY -le "$rows" ] || break
  done
  printf "\n"
}
_plasterLines() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
statusMessage() {
  local handler="_${FUNCNAME[0]}"
  local lastMessage=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --first)
      if
        ! consoleHasAnimation
      then
        shift
        catchEnvironment "$handler" printf -- "%s" "$("$@")" || return $?
        return 0
      fi
      ;;
    --inline)
      shift
      local suffix="\n"
      ! consoleHasAnimation || suffix=""
      catchEnvironment "$handler" printf -- "%s$suffix" "$("$@")" || return $?
      return 0
      ;;
    --last)
      if
        consoleHasAnimation
      then
        lastMessage=$'\n'
      fi
      ;;
    -*)
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      muzzle validate "$handler" Callable "command" "${1-}" || return $?
      break
      ;;
    esac
    shift
  done
  local text
  text=$(catchEnvironment "$handler" "$@") || return $?
  catchReturn "$handler" consoleLineFill "$text$lastMessage" || return $?
}
_statusMessage() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isTTYAvailable() {
  export __BUILD_HAS_TTY
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  if [ "${__BUILD_HAS_TTY-}" != "true" ] && [ "${__BUILD_HAS_TTY-}" != "false" ]; then
    if bash -c ": >/dev/tty" >/dev/null 2>/dev/null; then
      __BUILD_HAS_TTY=true
      return 0
    else
      __BUILD_HAS_TTY=false
      return 1
    fi
  fi
  "$__BUILD_HAS_TTY"
}
_isTTYAvailable() {
  true || isTTYAvailable --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleColumns() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  if ! isTTYAvailable; then
    printf -- "%d" 120
  else
    shopt -s checkwinsize || :
    local size
    IFS=" " read -r -a size < <(stty size </dev/tty 2>/dev/null) || :
    local width="${size[1]}"
    if ! isPositiveInteger "$width"; then
      export COLUMNS
      if isPositiveInteger "${COLUMNS-}"; then
        width="$COLUMNS"
      else
        width=100
      fi
    fi
    printf -- "%d" "$width"
  fi
}
_consoleColumns() {
  true || consoleColumns --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleRows() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  if ! isTTYAvailable; then
    printf -- "%d" 60
  else
    shopt -s checkwinsize || :
    local height _
    IFS=" " read -r height _ < <(stty size </dev/tty 2>/dev/null) || :
    if ! isPositiveInteger "$height"; then
      export LINES
      if isPositiveInteger "${LINES-}"; then
        height="$LINES"
      else
        height=72
      fi
    fi
    printf -- "%d" "$height"
  fi
}
_consoleRows() {
  ! false || consoleRows --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
markdownToConsole() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  _toggleCharacterToColor '`' "$(decorate code --)" | _toggleCharacterToColor '**' "$(decorate red --)" | _toggleCharacterToColor '*' "$(decorate cyan --)"
}
_markdownToConsole() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__colorBrightness() {
  local handler="$1" r g b
  r=$(validate "$handler" UnsignedInteger "red" "$2") || return $?
  g=$(validate "$handler" UnsignedInteger "green" "$3") || return $?
  b=$(validate "$handler" UnsignedInteger "blue" "$4") || return $?
  printf "%d\n" $(((r * 299 + g * 587 + b * 114) / 2550))
}
colorBrightness() {
  local handler="_${FUNCNAME[0]}"
  local r g b
  if [ $# -eq 0 ]; then
    local done=false color colorsArray=()
    while ! $done; do
      read -r color || done=true
      colorsArray+=("$color")
      if [ ${#colorsArray[@]} -eq 3 ]; then
        __colorBrightness "$handler" "${colorsArray[@]}" || return $?
        colorsArray=()
      fi
    done
  elif [ $# -lt 3 ]; then
    [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    throwArgument "$handler" "Requires 3 arguments" || return $?
  fi
  while [ $# -ge 3 ]; do
    __colorBrightness "$handler" "$1" "$2" "$3" || return $?
    shift 3
  done
}
_colorBrightness() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__colorNormalize() {
  local red=$1 green=$2 blue=$3 threshold=255
  maxColor=$red
  [ "$green" -le "$maxColor" ] || maxColor=$green
  [ "$blue" -le "$maxColor" ] || maxColor=$blue
  if [ "$maxColor" -le "$threshold" ]; then
    printf "%d\n" "$red" "$green" "$blue"
    return
  fi
  local total=$((red + green + blue))
  if [ $total -gt $((3 * threshold)) ]; then
    printf "%d\n" "$threshold" "$threshold" "$threshold"
    return
  fi
  local fThreshold=255.999
  printf "%s\n" "f=(3*$fThreshold-$total)/(3*$maxColor-$total)" "gray=$fThreshold-f*$maxColor" "m=gray*f" "$red+m" "$green+m" "$blue+m" | tee bc.log | bc --scale=2 | cut -f 1 -d . | clampDigits 0 255
}
colorNormalize() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  executableExists bc || throwEnvironment "$handler" "Requires bc installed - missing" || return $?
  local red green blue
  if [ $# -eq 0 ]; then
    local done=false
    while ! $done; do
      IFS=$'\n' read -d'' -r red green blue || done=true
      red=$(validate "$handler" UnsignedInteger "redValue" "$red") || return $?
      green=$(validate "$handler" UnsignedInteger "greenValue" "$green") || return $?
      blue=$(validate "$handler" UnsignedInteger "blueValue" "$blue") || return $?
      __colorNormalize "$red" "$green" "$blue"
    done
  else
    while [ $# -gt 0 ]; do
      red=$(validate "$handler" UnsignedInteger "redValue" "${1-}") && shift || return $?
      green=$(validate "$handler" UnsignedInteger "greenValue" "${1-}") && shift || return $?
      blue=$(validate "$handler" UnsignedInteger "blueValue" "${1-}") && shift || return $?
      __colorNormalize "$red" "$green" "$blue"
    done
  fi
}
_colorNormalize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
clampDigits() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local min="${1-}" max="${2-}" number
  while read -r number; do
    isInteger "$number" || continue
    if isInteger "$min" && [ "$number" -lt "$min" ]; then
      printf -- "%d\n" "$min"
    elif isInteger "$max" && [ "$number" -gt "$max" ]; then
      printf -- "%d\n" "$max"
    else
      printf -- "%d\n" "$number"
    fi
    shift
  done
}
_clampDigits() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__colorHexToInteger() {
  local color="${1-}"
  printf "%d\n" "0x${color:0:2}" "0x${color:2:2}" "0x${color:4:2}" 2>/dev/null
}
__colorParse() {
  local color="$1"
  case "${#color}" in
  3) __colorHexToInteger "${color:0:1}${color:0:1}${color:1:1}${color:1:1}${color:2:1}${color:2:1}" ;;
  6) __colorHexToInteger "$color" ;;
  *) printf "%s\n" "hex-length" 1>&2 && return 1 ;;
  esac
}
__colorParseArgument() {
  local argument="${1-}"
  case "$argument" in
  [[:xdigit:]]*) __colorParse "$argument" || return $? ;;
  [[:alpha:]]*:[[:xdigit:]]*) __colorParse "${argument#*:}" || return $? ;;
  *) printf -- "%s\n" "invalid-color" 1>&2 || : && return 1 ;;
  esac
}
_colorRange() {
  local c="$1"
  isUnsignedInteger "$c" || return 1
  [ "$c" -le 255 ] || c=255
  printf "%d" "$c"
}
colorFormat() {
  local handler="_${FUNCNAME[0]}" format="%0.2X%0.2X%0.2X\n"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if [ $# -gt 0 ]; then format="${1:-"$format"}" && shift; fi
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      local r="${1-}" g="${2-}" b="${3-}"
      shift 3 2>/dev/null || throwArgument "$handler" "Arguments must be in threes after format" || return $?
      r=$(_colorRange "$r") || throwArgument "$handler" "Invalid r $r value" || return $?
      g=$(_colorRange "$g") || throwArgument "$handler" "Invalid g $g value" || return $?
      b=$(_colorRange "$b") || throwArgument "$handler" "Invalid b $b value" || return $?
      printf -- "$format" "$r" "$g" "$b"
    done
  else
    local done=false
    while ! $done; do
      IFS=$'\n' read -d "" -r r g b || done=true
      if r=$(_colorRange "$r") && g=$(_colorRange "$g") && b=$(_colorRange "$b"); then
        printf -- "$format" "$r" "$g" "$b"
      fi
    done
  fi
}
_colorFormat() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
colorParse() {
  if [ $# -gt 0 ]; then
    [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    while [ $# -gt 0 ]; do
      __colorParseArgument "$1" || return $?
      shift
    done
  else
    local color
    while read -r color; do
      __colorParseArgument "$color" || return $?
    done
  fi
}
_colorParse() {
  ! false || colorParse --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
colorMultiply() {
  local handler="_${FUNCNAME[0]}"
  local factor colorsArray=()
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  executableExists bc || throwEnvironment "$handler" "Requires bc binary" || return $?
  factor=$(validate "$handler" String "factor" "${1-}") && shift || return $?
  local red green blue
  if [ $# -gt 0 ]; then
    colorsArray=("$@")
  else
    local color && while read -r color; do colorsArray+=("$color"); done
  fi
  set -- "${colorsArray[@]+"${colorsArray[@]}"}"
  while [ $# -gt 0 ]; do
    local red green blue
    red=$(validate "$handler" UnsignedInteger "redValue" "${1-}") && shift || return $?
    green=$(validate "$handler" UnsignedInteger "greenValue" "${1-}") && shift || return $?
    blue=$(validate "$handler" UnsignedInteger "blueValue" "${1-}") && shift || return $?
    bc <<<"m=$factor;$red*m;$green*m;$blue*m" | cut -d . -f 1
  done
}
_colorMultiply() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_toggleCharacterToColor() {
  local sequence reset
  sequence="$(quoteSedPattern "$1")"
  local code="$2"
  reset="${3-$(decorate reset --)}"
  local finished=false
  while ! $finished; do
    local line
    IFS="" read -r -d $'\n' line || finished=true
    if [ -z "$line" ]; then
      $finished || printf "\n"
      continue
    fi
    local odd=0 lastOne=false
    while true; do
      local text remain
      text="${line%%$sequence*}"
      remain="${line#*$sequence}"
      if [ "$text" = "$remain" ]; then
        lastOne=true
      else
        line="$remain"
      fi
      if [ $((odd & 1)) -eq 1 ]; then
        printf "%s%s%s" "$code" "$text" "$reset"
      else
        printf "%s" "$text"
      fi
      if $lastOne; then
        printf "\n"
        break
      fi
      odd=$((odd + 1))
    done
  done
}
colorScheme() {
  local handler="_${FUNCNAME[0]}"
  local colorsFile debug=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --debug) debug=true ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  export __BUILD_TERM_COLORS
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  colorsFile=$(fileTemporaryName "$handler") || return 0
  catchEnvironment "$handler" grepSafe -v -e '^#' | catchEnvironment "$handler" sed '/^$/d' | catchEnvironment "$handler" muzzle tee "$colorsFile" || return $?
  local hash
  hash="$(shaPipe <"$colorsFile")" || :
  [ "$hash" != "$home:${__BUILD_TERM_COLORS-}" ] || return 0
  local it2=false iTerm2=false
  ! isiTerm2 || it2=true
  local bg="" bgs=()
  local name value newStyle newStyles=()
  while IFS="=" read -r name value; do
    local colorCode
    if $it2 && iTerm2IsColorType "$name"; then
      iTerm2=true
    fi
    if muzzle decorateStyle "$name"; then
      ! $debug || statusMessage decorate info "Parsing $(decorate code "$name") and $(decorate value "$value")"
      colorCode=$(colorParse <<<"$value" | colorFormat "%d;%d;%d")
      newStyle="38;2;$colorCode"
      newStyles+=("$name" "$newStyle")
    else
      local bgName="${name%bg}"
      if [ -n "$bgName" ] && [ "$name" != "$bgName" ] && muzzle decorateStyle "$bgName"; then
        colorCode=$(colorParse <<<"$value" | colorFormat "%d;%d;%d")
        bgs+=("$bgName" "$colorCode")
        ! $debug || statusMessage decorate info "Parsing background color for $(decorate code "$bgName"): $(decorate value "$value") -> $(decorate code "$colorCode")"
      elif [ -z "$bgName" ]; then
        bg="$value"
      fi
    fi
  done <"$colorsFile"
  ! $debug || dd+=(--verbose)
  ! $iTerm2 || iTerm2SetColors "${dd[@]+"${dd[@]}"}" --fill --ignore --skip-errors <"$colorsFile" || :
  [ -n "$bg" ] || bg="$(grep -e '^bg=' "$colorsFile" | tail -n 1 | cut -f 2 -d =)"
  catchEnvironment "$handler" rm -rf "$colorsFile" || return $?
  if [ -n "$bg" ]; then
    muzzle consoleConfigureDecorate "$bg"
    ! $debug || decorate info "Background set to $bg and mode is $(consoleConfigureColorMode "$bg") ..."
  else
    ! $debug || decorate info "No background color defined - color mode not set automatically"
  fi
  set -- "${newStyles[@]+"${newStyles[@]}"}"
  while [ $# -gt 0 ]; do
    ! $debug || statusMessage decorate info "Setting style $(decorate value "$1") to $(decorate code "$2")"
    catchEnvironment "$handler" muzzle decorateStyle "$1" "$2" || return $?
    shift 2
  done
  if [ ${#bgs[@]} -gt 0 ]; then
    set -- "${bgs[@]}"
    while [ $# -gt 1 ]; do
      name="$1"
      value="$2"
      newStyle=$(decorateStyle "$name")
      newStyle="${newStyle%%;48;2;*}"
      newStyle="$newStyle;48;2;$value"
      ! $debug || statusMessage decorate info "Setting background style for $(decorate value "$name") to $(decorate code "$newStyle")"
      catchEnvironment "$handler" muzzle decorateStyle "$name" "$newStyle" || return $?
      shift 2
    done
  fi
  __BUILD_TERM_COLORS="$home:$hash"
}
_colorScheme() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
cursorGet() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  isTTYAvailable || throwEnvironment "$handler" "no tty" || return $?
  local x y && IFS=';' read -d '' -t 2 -r -sdR -p $'\033[6n' y x </dev/tty >/dev/tty
  y=${y#*[}
  if ! isUnsignedInteger "$x" || ! isUnsignedInteger "$y"; then
    throwEnvironment "$handler" "Invalid response from tty: \"$(printf "%s" "$y;$x" | dumpBinary)\"" || return $?
  fi
  printf "%d\n" "$x" "$y"
}
_cursorGet() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
cursorSet() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  isTTYAvailable || throwEnvironment "$handler" "no tty" || return $?
  local x y
  x=$(validate "$handler" UnsignedInteger "x" "${1-}") && shift || return $?
  y=$(validate "$handler" UnsignedInteger "y" "${1-}") && shift || return $?
  printf "\e%s%d;%dH" "[" "$y" "$x" >/dev/tty
}
_cursorSet() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
sedReplacePattern() {
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  printf "s/%s/%s/g\n" "$(quoteSedPattern "$1")" "$(quoteSedReplacement "${2-}")"
}
_sedReplacePattern() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
quoteSedPattern() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local value="${1-}"
  value=$(printf -- "%s\n" "$value" | sed 's~\([][$/'$'\t''^\\.*+?]\)~\\\1~g')
  value="${value//$'\n'/\\n}"
  printf -- "%s\n" "$value"
}
_quoteSedPattern() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
quoteSedReplacement() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local value="${1-}" separator="${2-/}"
  value=$(printf -- "%s\n" "$value" | sed 's~\([\&'"$separator"']\)~\\\1~g')
  value="${value//$'\n'/\\n}"
  printf -- "%s\n" "$value"
}
_quoteSedReplacement() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__hookRunner() {
  local handler="${1-}" && shift
  local requireHook=false sourceHook=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --require)
      requireHook=true
      ;;
    --source)
      sourceHook=true
      ;;
    --)
      shift
      break
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  local applicationHome="" whichArgs=() nextSource="" ww=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --next)
      shift
      whichArgs+=("$argument" "$(validate "$handler" File "$argument" "${1-}")") || return $?
      ;;
    --extensions) shift && ww+=("$argument" "$(validate "$handler" String "$argument" "${1-}")") || return $? ;;
    --application)
      shift && applicationHome=$(validate "$handler" Directory applicationHome "${1-}") || return $?
      whichArgs+=(--application "$applicationHome")
      ;;
    *)
      local hook binary="$argument"
      shift
      if ! hook=$(hookFind "${ww[@]+"${ww[@]}"}" "${whichArgs[@]+${whichArgs[@]}}" "$binary"); then
        if $requireHook; then
          throwArgument "$handler" "Hook not found $(decorate code "$binary")" || return $?
        else
          if buildDebugEnabled hook; then
            printf "%s %s %s %s\n" "$(decorate warning "No hook")" "$(decorate code "$binary")" "$(decorate warning "in this project:")" "$(decorate code "$applicationHome")"
          fi
          return 0
        fi
      fi
      if "$sourceHook"; then
        set -- "$@"
        source "$hook" || throwEnvironment "$handler" "source $hook failed" || return $?
      else
        command env HOME="$HOME" PATH="$PATH" BUILD_HOME="$BUILD_HOME" "$hook" "$@" || return $?
      fi
      return 0
      ;;
    esac
    shift
  done
  throwArgument "$handler" "No hook name passed (Arguments: $(decorate each code "${__saved[@]}"))" || return $?
}
hookRun() {
  __hookRunner "_${FUNCNAME[0]}" --require -- "$@"
}
_hookRun() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hookRunOptional() {
  __hookRunner "_${FUNCNAME[0]}" -- "$@"
}
_hookRunOptional() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hookSource() {
  __hookRunner "_${FUNCNAME[0]}" --source --require -- "$@"
}
_hookSource() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hookSourceOptional() {
  __hookRunner "_${FUNCNAME[0]}" --source -- "$@"
}
_hookSourceOptional() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hasHook() {
  local handler="_${FUNCNAME[0]}"
  local applicationHome="" ww=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --extensions) shift && ww+=(--extensions "$(validate "$handler" String "$argument" "${1-}")") || return $? ;;
    --debug) ww+=("$argument") ;;
    --next) shift && ww+=("$argument" "$(validate "$handler" File "$argument" "${1-}")") || return $? ;;
    --application) shift && applicationHome=$(validate "$handler" Directory applicationHome "${1-}") || return $? ;;
    *)
      local binary
      [ -n "$applicationHome" ] || applicationHome="$(catchReturn "$handler" buildHome)" || return $?
      binary="$(hookFind "${ww[@]+${ww[@]}}" --application "$applicationHome" "$argument")" || return 1
      [ -n "$binary" ] || return 1
      ;;
    esac
    shift
  done
}
_hasHook() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hookFind() {
  local handler="_${FUNCNAME[0]}"
  local applicationHome="" hookPaths=() hookExtensions=() nextSource="" debugFlag=false extensionText=""
  local __saved=("$@") __count=$#
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --application) shift && applicationHome=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --extensions) shift && extensionText=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --next)
      shift
      nextSource=$(validate "$handler" File "$argument" "${1-}") || return $?
      nextSource=$(catchEnvironment "$handler" realPath "$nextSource") || return $?
      ;;
    --debug) debugFlag=true ;;
    *)
      [ -n "$applicationHome" ] || applicationHome="$(catchReturn "$handler" buildHome)" || return $?
      if [ "${#hookPaths[@]}" -eq 0 ]; then
        IFS=":" read -r -a hookPaths < <(buildEnvironmentGet --application "$applicationHome" BUILD_HOOK_DIRS) || :
        [ ${#hookPaths[@]} -gt 0 ] || throwEnvironment "$handler" "BUILD_HOOK_DIRS is blank" || return $?
      fi
      if [ "${#hookExtensions[@]}" -eq 0 ]; then
        [ -n "$extensionText" ] || extensionText="$(buildEnvironmentGet --application "$applicationHome" BUILD_HOOK_EXTENSIONS)"
        IFS=":" read -r -a hookExtensions <<<"$extensionText"
        [ ${#hookExtensions[@]} -gt 0 ] || throwEnvironment "$handler" "BUILD_HOOK_EXTENSIONS is blank" || return $?
      fi
      local hookPath
      ! $debugFlag || decorate info "Hook paths ${#hookPaths[@]} x extensions ${#hookExtensions[@]}" 1>&2
      for hookPath in "${hookPaths[@]}"; do
        local appPath
        pathIsAbsolute "$hookPath" && appPath="$hookPath" || appPath="${applicationHome%/}/${hookPath%/}"
        if [ -d "$appPath" ]; then
          ! $debugFlag || decorate info "Examining path: $appPath" 1>&2
        else
          ! $debugFlag || decorate info "Not a directory path: $appPath" 1>&2
          continue
        fi
        local extension
        for extension in "${hookExtensions[@]}"; do
          extension="${extension#.}"
          [ -z "$extension" ] || extension=".$extension"
          local binary="$appPath/$argument$extension"
          if [ -x "$binary" ]; then
            if [ -n "$nextSource" ]; then
              if [ "$binary" = "$nextSource" ]; then
                nextSource=""
                ! $debugFlag || decorate info "$binary matched NEXT" 1>&2
              else
                ! $debugFlag || decorate info "$binary did not match $nextSource" 1>&2
              fi
              break
            fi
            printf "%s\n" "$binary"
            return 0
          else
            ! $debugFlag || decorate info "$binary $([ -f "$binary" ] && printf "not executable" || printf "not found")" 1>&2
          fi
          [ ! -f "$binary" ] || returnEnvironment "$binary exists but is not executable and will be ignored" || return $?
        done
      done
      ! $debugFlag || decorate info "no more paths" 1>&2
      return 1
      ;;
    esac
    shift
  done
  throwArgument "$handler" "no arguments" || return $?
}
_hookFind() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_hookContextWrapper() {
  local handler="$1" hookName="$2"
  local application=""
  shift 2 || :
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --application)
      shift
      application=$(validate "$handler" Directory "home" "${1-}") || return $?
      ;;
    *) break ;;
    esac
    shift
  done
  local start home
  home=$(catchReturn "$handler" buildHome) || return $?
  start="$(pwd -P 2>/dev/null)" || throwEnvironment "$handler" "Failed to get pwd" || return $?
  start=$(catchEnvironment "$handler" realPath "$start") || return $?
  if [ -z "$application" ]; then
    if [ "${start#"$home"}" = "$start" ]; then
      application="$home"
    else
      application=$(catchReturn "$handler" bashLibraryHome "bin/build/tools.sh" "$start") || return $?
      application="${application%/}"
      if [ "${start#"$application"}" = "$start" ]; then
        buildEnvironmentContext "$application" hookRun --application "$application" "$hookName" "$@" || return $?
        return 0
      fi
    fi
  fi
  catchEnvironment "$handler" hookRun --application "$application" "$hookName" "$@" || return $?
}
hookVersionCurrent() {
  _hookContextWrapper "_${FUNCNAME[0]}" "version-current" "$@"
}
_hookVersionCurrent() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hookVersionLive() {
  _hookContextWrapper "_${FUNCNAME[0]}" "version-live" "$@"
}
_hookVersionLive() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
incrementor() {
  local handler="_${FUNCNAME[0]}"
  local argument cacheDirectory
  local name value counterFile
  cacheDirectory=$(catchReturn "$handler" buildCacheDirectory "${FUNCNAME[0]}/$$") || return $?
  cacheDirectory="$(catchReturn "$handler" directoryRequire "$cacheDirectory")" || return $?
  name=""
  value=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --reset)
      rm -rf "$cacheDirectory" || :
      return 0
      ;;
    *[^-_a-zA-Z0-9]*)
      throwArgument "$handler" "Invalid argument or variable name: $argument" || return $?
      ;;
    *) if
      isInteger "$argument"
    then
      if [ -n "$name" ]; then
        __incrementor "$cacheDirectory/$name" "$value"
        name=
      fi
      value="$argument"
    else
      if [ -n "$name" ]; then
        __incrementor "$cacheDirectory/$name" "$value"
      fi
      name="$argument"
      [ -n "$name" ] || name=default
    fi ;;
    esac
    shift
  done
  [ -n "$name" ] || name=default
  __incrementor "$cacheDirectory/$name" "$value"
}
_incrementor() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__incrementor() {
  local counterFile="$1" value="${2-}"
  if [ -z "$value" ]; then
    if [ -f "$counterFile" ]; then
      value="$(head -n 1 "$counterFile")"
    fi
    if ! isInteger "$value"; then
      value=0
    fi
    value=$((value + 1))
  fi
  printf -- "%d\n" "$value" | tee "$counterFile"
}
pipeRunner() {
  local handler="_${FUNCNAME[0]}"
  local binary="" namedPipe="" mode="0700"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --mode) shift && mode=$(validate "$handler" String "mode" "${1-}") || return $? ;;
    --writer)
      [ -z "$namedPipe" ] || throwArgument "$handler" "No namedPipe supplied" || return $?
      [ -p "$namedPipe" ] || throwEnvironment "$handler" "$namedPipe not a named pipe" || return $?
      shift && catchEnvironment "$handler" printf "%s\n" "$*" >"$namedPipe" || return $?
      ;;
    *) if
      [ -n "$namedPipe" ]
    then
      binary="$(validate "$handler" Callable "readerExecutable" "$argument")" || return $?
      break
    else
      namedPipe=$(validate "$handler" FileDirectory "namedPipe" "$argument") || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$namedPipe" ] || throwArgument "$handler" "No namedPipe supplied" || return $?
  [ ! -p "$namedPipe" ] || throwEnvironment "$handler" "$namedPipe already exists ($binary)" || return $?
  catchEnvironment "$handler" mkfifo -m "$mode" "$namedPipe" || return $?
  trap "rm -f \"$(quoteBashString "$namedPipe")\" 2>/dev/null 1>&2" EXIT INT HUP || :
  while read -r line; do
    if [ -n "$line" ]; then
      execute "$@" "$line" || break
    fi
  done <"$namedPipe"
  rm -f "$namedPipe" || :
}
_pipeRunner() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__selfLoader() {
  __buildFunctionLoader __installInstallBinary self "$@"
}
installInstallBinary() {
  __selfLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_installInstallBinary() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
installInstallBuild() {
  local handler="_${FUNCNAME[0]}"
  local home
  local binName="install-bin-build.sh"
  home=$(catchReturn "$handler" buildHome) || return $?
  installInstallBinary --handler "$handler" "$@" --bin "$binName" --source "$home/bin/build/$binName" --url-function __installInstallBuildRemote --post __installInstallBinaryLegacy
}
_installInstallBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildDeprecatedFunctions() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help --only "$handler" "$@" || return 0
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  {
    catchReturn "$handler" bashListFunctions "$home/bin/build/tools/deprecated.sh" || return $?
    catchReturn "$handler" bashCommentFilter <"$home/bin/build/deprecated.txt" | catchReturn "$handler" cut -f 1 -d '|' | catchReturn "$handler" grepSafe -e '^[A-Za-z_][A-Za-z0-9_]*$' || return $?
  } | catchReturn "$handler" sort -u || return $?
}
_buildDeprecatedFunctions() {
  true || buildDeprecatedFunctions --help || return $?
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildFunctions() {
  local handler="_${FUNCNAME[0]}" hideDeprecated=true
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --deprecated) hideDeprecated=false ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  local postprocess=(cat)
  if $hideDeprecated; then
    local pattern=() fun && while read -r fun; do pattern+=("$fun"); done < <(buildDeprecatedFunctions)
    local grepPattern && grepPattern="$(catchReturn "$handler" listJoin "|" "${pattern[@]}")" || return $?
    [ "${#pattern[@]}" -eq 0 ] || postprocess=(grep -v -e "^\($(quoteGrepPattern "$grepPattern")\)$")
  fi
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  env -i PATH="$PATH" "$home/bin/build/tools.sh" declare -F | cut -d ' ' -f 3 | grep -v -e '^_' | "${postprocess[@]}"
}
_buildFunctions() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildCacheDirectory() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local suffix
  suffix="$(printf "%s/" ".build" "$@")"
  catchReturn "$handler" buildEnvironmentGetDirectory --subdirectory "$suffix" XDG_CACHE_HOME || return $?
}
_buildCacheDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildHome() {
  local handler="_${FUNCNAME[0]}"
  export BUILD_HOME
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  if [ -z "${BUILD_HOME-}" ]; then
    local homeEnv="${BASH_SOURCE[0]%/*}/../env/BUILD_HOME.sh"
    if [ -f "$homeEnv" ]; then
      source "${BASH_SOURCE[0]%/*}/../env/BUILD_HOME.sh" || throwEnvironment "$handler" "BUILD_HOME.sh failed" || return $?
      [ -n "${BUILD_HOME-}" ] || throwEnvironment "$handler" "BUILD_HOME STILL blank" || return $?
    else
      throwEnvironment "$handler" "Unable to locate $homeEnv from $(pwd)"$'\n'"$(decorate each code "${BASH_SOURCE[@]}")" || return $?
    fi
  fi
  printf "%s\n" "${BUILD_HOME%/}"
}
_buildHome() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_buildEnvironmentPath() {
  local handler="$1" && shift
  local paths=() home
  export BUILD_ENVIRONMENT_DIRS BUILD_HOME
  home="${BUILD_HOME-}"
  if [ -z "$home" ]; then
    home=$(catchReturn "$handler" buildHome) || return $?
  fi
  source "$home/bin/build/env/BUILD_ENVIRONMENT_DIRS.sh" || throwEnvironment "$handler" "BUILD_ENVIRONMENT_DIRS.sh fail" || return $?
  IFS=":" read -r -a paths <<<"${BUILD_ENVIRONMENT_DIRS-}" || :
  printf "%s\n" "${paths[@]+"${paths[@]}"}" "$home/bin/build/env"
}
buildEnvironmentNames() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  (
    IFS=$'\n' read -d '' -r -a paths < <(_buildEnvironmentPath "$handler") || :
    for path in "${paths[@]}"; do
      find "$path" -type f -name '*.sh' -exec basename {} \; | cut -d . -f 1
    done
  ) | catchEnvironment "$handler" sort -u || return $?
}
_buildEnvironmentNames() {
  true || buildEnvironmentNames --help || return $?
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildEnvironmentFiles() {
  local handler="_${FUNCNAME[0]}" applicationHome="" foundOne=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --application) shift && applicationHome=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    *)
      local env paths=() path file=""
      [ -n "$applicationHome" ] || applicationHome=$(catchReturn "$handler" buildHome) || return $?
      env="$(validate "$handler" EnvironmentVariable "environmentVariable" "$argument")" || return $?
      IFS=$'\n' read -d '' -r -a paths < <(_buildEnvironmentPath "$handler") || :
      for path in "${paths[@]}"; do
        if ! pathIsAbsolute "$path"; then
          path="$applicationHome/$path"
        fi
        [ -d "$path" ] || continue
        file="$path/$env.sh"
        if [ -x "$file" ]; then
          printf "%s\n" "$file"
          foundOne=true
        fi
      done
      ;;
    esac
    shift
  done
  $foundOne || return 1
}
_buildEnvironmentFiles() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__buildEnvironmentFileHeader() {
  local handler="$1" && shift
  local year company
  year=$(catchEnvironment "$handler" date +%Y) || return $?
  company=$(catchReturn "$handler" buildEnvironmentGet BUILD_COMPANY) || return $?
  local ll=(
    "#!/usr/bin/env bash"
    "# Copyright &copy; $year $company")
  catchEnvironment "$handler" printf -- "%s\n" "${ll[@]+"${ll[@]}"}" || return $?
}
__buildEnvironmentDefaultFile() {
  local handler="$1" && shift
  local name="$1" && shift
  local app && app=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_CODE) || return $?
  local ll=(
    "# Category: Application"
    "# Application: $app"
    "# Type: String"
    "# A description of \"$name\" and how it is used"
    "export $name")
  catchEnvironment "$handler" printf -- "%s\n" "${ll[@]+"${ll[@]}"}" || return $?
}
__buildEnvironmentMakeFile() {
  local handler="$1" templateHome="$2" name="$3" value="$4"
  [ -n "$value" ] || value="\${$name-}"
  local template && template=$(buildEnvironmentFiles --application "$templateHome" "$name" 2>/dev/null | tail -n 1) || :
  __buildEnvironmentFileHeader "$handler" || return $?
  if [ -n "$template" ]; then
    catchReturn "$handler" grepSafe -v -e "^$name" -e "^#!" -e 'Copyright' "$template" || return $?
  else
    __buildEnvironmentDefaultFile "$handler" "$name" || return $?
  fi
  catchEnvironment "$handler" printf -- "%s\n" "$name=\"$value\"" || return $?
}
buildEnvironmentAdd() {
  local handler="_${FUNCNAME[0]}"
  local value="" environmentNames=() forceFlag=false verboseFlag=true
  local home=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --application) shift && home="$(validate "$handler" Directory "applicationHome" "${1-}")" || return $? ;;
    --force) forceFlag=true ;;
    --quiet) verboseFlag=false ;;
    --verbose) verboseFlag=true ;;
    --value) shift && value="${1-}" ;;
    *) environmentNames+=("$(validate "$handler" EnvironmentVariable "environmentVariable" "$argument")") || return $? ;;
    esac
    shift
  done
  [ ${#environmentNames[@]} -gt 0 ] || throwArgument "$handler" "Need at least one $(decorate code environmentVariable)" || return $?
  local templateHome && templateHome=$(catchReturn "$handler" buildHome) || return $?
  [ -n "$home" ] || home="$templateHome"
  local name && for name in "${environmentNames[@]}"; do
    local path="$home/bin/env/$name.sh"
    if [ -f "$path" ] && ! fileIsEmpty "$path" && ! $forceFlag; then
      if [ ! -x "$path" ]; then
        ! $verboseFlag || statusMessage --last decorate warning "Making existing $(decorate file "$path") executable ..."
        catchEnvironment "$handler" chmod +x "$path" || return $?
      else
        ! $verboseFlag || statusMessage --last decorate info "$(decorate file "$path") already exists, no changes made"
      fi
    else
      local verb="Created"
      [ ! -f "$path" ] || verb="Replaced"
      [ -n "$value" ] || value="\${$name-}"
      __buildEnvironmentMakeFile "$handler" "$templateHome" "$name" "$value" >"$path" || return $?
      catchEnvironment "$handler" chmod +x "$path" || return $?
      ! $verboseFlag || statusMessage --last decorate success "$verb $(decorate file "$path")"
    fi
  done
}
_buildEnvironmentAdd() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildEnvironmentLoad() {
  local handler="_${FUNCNAME[0]}" applicationHome="" printFlag=false tempFiles="" envNames=() allFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --print) printFlag=true ;;
    --all) allFlag=true ;;
    --application) shift && applicationHome=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    *) envNames+=("$(validate "$handler" EnvironmentVariable "environmentVariable" "$1")") || return $? ;;
    esac
    shift
  done
  local envName
  if [ ${#envNames[@]} -eq 0 ]; then
    $allFlag || throwEnvironment "$handler" "No environment values specified" || return $?
    while read -r envName < <(buildEnvironmentNames); do envNames+=("$envName"); done
  elif "$allFlag"; then
    throwArgument "$handler" "--all is not compatible with environment values: ${envNames[*]}" || return $?
  fi
  [ -n "$applicationHome" ] || applicationHome=$(catchReturn "$handler" buildHome) || return $?
  [ -f "$tempFiles" ] || tempFiles=$(fileTemporaryName "$handler") || return $?
  for envName in "${envNames[@]}"; do
    if ! buildEnvironmentFiles --application "$applicationHome" "$envName" >"$tempFiles"; then
      throwEnvironment "$handler" "Failed to find any files for $envName" || returnClean $? "$tempFiles" || return $?
    fi
    export "${envName?}" || throwEnvironment "$handler" "export $envName failed" || returnClean $? "$tempFiles" || return $?
    set -a
    local firstFile="" eof=false
    while ! $eof; do
      local f && read -r f || eof=true
      [ -n "$f" ] || continue
      source "$f" || throwEnvironment "$handler" "Failed: source $f" || returnClean $? "$tempFiles" || returnUndo $? set +a || return $?
      [ -n "$firstFile" ] || firstFile="$f"
    done <"$tempFiles"
    set +a
    [ -n "$firstFile" ] || throwEnvironment "$handler" "No files loaded for $argument" || return $?
    ! $printFlag || catchEnvironment "$handler" printf -- "%s\n" "$firstFile" || returnClean $? "$tempFiles" || return $?
  done
  [ -z "$tempFiles" ] || catchEnvironment "$handler" rm -f "$tempFiles" || return $?
}
_buildEnvironmentLoad() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
unalias tools 2>/dev/null || :
tools() {
  local handler="_${FUNCNAME[0]}"
  local toolsBin="bin/build/tools.sh" vv=() verboseFlag=false startDirectory=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --start)
      shift
      startDirectory=$(validate "$handler" Directory "$argument" "${1-}") || return $?
      ;;
    --verbose)
      vv+=("$argument")
      verboseFlag=true
      ;;
    *) break ;;
    esac
    shift
  done
  [ -n "$startDirectory" ] || startDirectory=$(catchEnvironment "$handler" pwd) || return $?
  local home code=0
  if ! home=$(bashLibraryHome "$toolsBin" "$startDirectory" 2>/dev/null); then
    home=$(catchReturn "$handler" buildHome) || return $?
    ! $verboseFlag || statusMessage decorate info "Running $(decorate file "$home/$toolsBin")" "$(decorate each code -- "$@")"
    "$home/$toolsBin" "$@" || code=$?
  else
    bashLibrary "${vv[@]+"${vv[@]}"}" "$toolsBin" "$@" || code=$?
  fi
  ! $verboseFlag || statusMessage --last printf -- "%s %s" "$(decorate each code "$home/$toolsBin" "$@")" "$(decorate notice "Return code: $code")"
  return $code
}
_tools() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildEnvironmentGet() {
  local handler="_${FUNCNAME[0]}" ll=()
  [ $# -gt 0 ] || throwArgument "$handler" "Requires at least one environment variable" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --application) shift && ll+=("$argument" "${1-}") ;;
    *)
      catchReturn "$handler" buildEnvironmentLoad "${ll[@]+"${ll[@]}"}" "$argument" || return $?
      printf "%s\n" "${!argument-}"
      ;;
    esac
    shift
  done
}
_buildEnvironmentGet() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildEnvironmentGetDirectory() {
  local handler="_${FUNCNAME[0]}"
  local createFlag=true existsFlag=false subdirectory="" rr=()
  [ $# -gt 0 ] || throwArgument "$handler" "Requires at least one environment variable" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --exists)
      existsFlag=true
      ;;
    --subdirectory)
      shift
      subdirectory=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --owner | --mode)
      shift
      rr+=("$argument" "$(validate "$handler" String "$argument" "${1-}")") || return $?
      createFlag=true
      ;;
    --no-create)
      createFlag=false
      ;;
    *)
      local path
      path=$(catchReturn "$handler" buildEnvironmentGet "$argument" 2>/dev/null) || return $?
      [ -z "$subdirectory" ] || subdirectory="${subdirectory#/}"
      subdirectory="${path%/}/$subdirectory"
      ! $createFlag || path=$(catchReturn "$handler" directoryRequire "${rr[@]+"${rr[@]}"}" "$subdirectory") || return $?
      ! $existsFlag || [ -d "$subdirectory" ] || throwEnvironment "$handler" "$argument -> $subdirectory does not exist" || return $?
      printf "%s\n" "${subdirectory%/}"
      ;;
    esac
    shift
  done
}
_buildEnvironmentGetDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildQuietLog() {
  local handler="_${FUNCNAME[0]}"
  local flagMake=true
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --no-create)
      flagMake=false
      ;;
    *)
      local logFile
      logFile="$(catchReturn "$handler" buildCacheDirectory)/${1#_}.log" || return $?
      ! "$flagMake" || logFile=$(catchReturn "$handler" fileDirectoryRequire "$logFile") || return $?
      printf -- "%s\n" "$logFile"
      return 0
      ;;
    esac
    shift || :
  done
  throwArgument "$handler" "No arguments" || return $?
}
_buildQuietLog() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildEnvironmentContext() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help "$handler" "$@" || return 0
  local start
  start="$(validate "$handler" Directory "contextStart" "${1-}")" && shift || return $?
  local codeHome home binTools="bin/build/tools.sh"
  codeHome=$(catchReturn "$handler" buildHome) || return $?
  home=$(catchEnvironment "$handler" bashLibraryHome "$binTools" "$start") || return $?
  if [ "$codeHome" != "$home" ]; then
    decorate warning "Build home is $(decorate code "$codeHome") - running locally at $(decorate code "$home")"
    [ -x "$home/$binTools" ] || throwEnvironment "Not executable $home/$binTools" || return $?
    catchEnvironment "$handler" "$home/$binTools" "$@" || return $?
    return 0
  fi
  catchEnvironment "$handler" "$@" || return $?
}
_buildEnvironmentContext() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
userHome() {
  local handler="_${FUNCNAME[0]}"
  __help "_${FUNCNAME[0]}" "$@" || return 0
  local home
  home=$(catchReturn "$handler" buildEnvironmentGet HOME) || return $?
  [ -d "$home" ] || throwEnvironment "$handler" "HOME is not a directory: $HOME" || return $?
  home="$(printf "%s%s" "$home" "$(printf "/%s" "$@")")"
  printf "%s\n" "${home%/}"
}
_userHome() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
userRecord() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local index="${1-}" user="${2-}" userDatabase=${3-"/etc/passwd"} value
  [ -n "$user" ] || user=$(catchReturn "$handler" whoami) || return $?
  [ -f "$userDatabase" ] || throwEnvironment "$handler" "No $userDatabase" || return $?
  set -o pipefail && value=$(grep "^$user:" "$userDatabase" | cut -d : -f "$index") || returnMessage $? "No such user $user in $userDatabase" || return $?
  printf -- "%s\n" "$value"
}
_userRecord() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
userRecordName() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  userRecord 5 "$@"
}
_userRecordName() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
userRecordHome() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  userRecord 6 "$@"
}
_userRecordHome() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
groupID() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local __saved=("$@") __count=$#
  local gid
  [ $# -gt 0 ] || throwArgument "$handler" "Requires a group name" || return $?
  if executableExists getent; then
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      gid="$(getent group "$argument" | cut -d: -f3)" || return 1
      isInteger "$gid" || return 1
      printf "%d\n" "$gid" && shift
    done
  else
    local groupFile="/etc/group"
    [ -f "$groupFile" ] || throwEnvironment "$handler" "Unable to access $groupFile" || return $?
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      gid="$(grep -e "^$(quoteGrepPattern "$argument")" <"$groupFile" | cut -d: -f3)" || return 1
      isInteger "$gid" || return 1
      printf "%d\n" "$gid" && shift
    done
  fi
}
_groupID() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__packageListFunction() {
  local handler="$1" functionVerb="$2"
  local manager=""
  local beforeFunctions=()
  shift 2
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --before)
      shift
      beforeFunctions+=("$(validate "$handler" Function "$argument" "${1-}")") || return $?
      ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  executableExists "$manager" || throwEnvironment "$handler" "$manager does not exist" || return $?
  local listFunction="__$manager${functionVerb}List"
  isFunction "$listFunction" || throwEnvironment "$handler" "$listFunction is not defined" || return $?
  local beforeFunction
  [ ${#beforeFunctions[@]} -eq 0 ] || for beforeFunction in "${beforeFunctions[@]}"; do
    catchEnvironment "$handler" muzzle "$beforeFunction" || return $?
  done
  catchEnvironment "$handler" "$listFunction" || return $?
}
__packageUpFunction() {
  local handler="$1" suffix="$2" verb
  local manager="" forceFlag=false verboseFlag=false start lastModified showLog=false
  verb=$(lowercase "$suffix")
  shift 2
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    --force)
      forceFlag=true
      ;;
    --show-log)
      showLog=true
      ;;
    --verbose)
      verboseFlag=true
      ;;
    *) break ;;
    esac
    shift
  done
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  executableExists "$manager" || throwEnvironment "$handler" "$manager does not exist" || return $?
  local packageFunction="__$manager$suffix"
  isFunction "$packageFunction" || throwEnvironment "$handler" "$packageFunction is not a defined function" || return $?
  local name
  name="$(catchReturn "$handler" buildCacheDirectory)/.packageUpdate" || return $?
  if $forceFlag; then
    ! $verboseFlag || statusMessage decorate info "Forcing $manager $verb ..."
  elif [ -f "$name" ]; then
    local lastModified
    lastModified="$(fileModificationSeconds "$name")"
    local threshold=3600
    if [ "$lastModified" -lt "$threshold" ]; then
      ! $verboseFlag || statusMessage --last decorate info "Updated $lastModified (threshold is $threshold) seconds ago. System is up to date."
      return 0
    fi
  fi
  start=$(timingStart) || return $?
  ! $verboseFlag || statusMessage decorate warning "$suffix ..."
  if ! $showLog; then
    local quietLog
    quietLog=$(catchReturn "$handler" buildQuietLog "${handler#_}$suffix") || return $?
    exec 3>&1
    exec 1>"$quietLog"
  fi
  catchEnvironment "$handler" "$packageFunction" "$@" || return $?
  if ! $showLog; then
    exec 1>&3
  fi
  ! $verboseFlag || statusMessage --last timingReport "$start" "$suffix $(decorate subtle "completed in")"
  date +%s >"$name" || :
}
packageUpgrade() {
  __packageUpFunction "_${FUNCNAME[0]}" Upgrade "$@"
}
_packageUpgrade() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageUpdate() {
  __packageUpFunction "_${FUNCNAME[0]}" Update "$@"
}
_packageUpdate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageDefault() {
  local handler="_${FUNCNAME[0]}"
  local lookup=() manager=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    -*)
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *) lookup+=("$(validate "$handler" String "binary" "$argument")") || return $? ;;
    esac
    shift
  done
  [ "${#lookup[@]}" -gt 0 ] || throwArgument "$handler" "Need at least one name" || return $?
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  local function="__${manager}Default"
  if ! isFunction "$function"; then
    throwEnvironment "$handler" "Missing $function implementation for $manager" || return $?
  fi
  "$function" "${lookup[@]}"
}
_packageDefault() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageWhich() {
  local handler="_${FUNCNAME[0]}"
  local binary="" packages=() manager="" forceFlag=false vv=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --force)
      forceFlag=true
      ;;
    --show-log | --verbose)
      vv=("$argument")
      ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    -*)
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *) if
      [ -z "$binary" ]
    then
      binary=$(validate "$handler" String "binary" "$argument") || return $?
    else
      packages+=("$(validate "$handler" String "binary" "$argument")") || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  executableExists "$manager" || throwEnvironment "$handler" "$manager does not exist" || return $?
  [ "${#packages[@]}" -gt 0 ] || packages+=("$binary")
  if ! $forceFlag; then
    [ -n "$binary" ] || throwArgument "$handler" "Missing binary" || return $?
    ! executableExists "$binary" || return 0
  fi
  catchReturn "$handler" packageInstall "${vv[@]+"${vv[@]}"}" --manager "$manager" --force "${packages[@]}" || return $?
  executableExists "$binary" || throwEnvironment "$handler" "$manager packages \"${packages[*]}\" did not add $binary to the PATH: ${PATH-}" || return $?
}
_packageWhich() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageWhichUninstall() {
  local handler="_${FUNCNAME[0]}"
  local binary="" packages=() manager="" foundPath vv=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    --verbose)
      vv=("$argument")
      ;;
    *) if
      [ -z "$binary" ]
    then
      binary=$(validate "$handler" String "binary" "$argument") || return $?
    else
      packages+=("$(validate "$handler" String "binary" "$argument")") || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  executableExists "$manager" || throwEnvironment "$handler" "$manager does not exist" || return $?
  [ -n "$binary" ] || throwArgument "$handler" "Missing binary" || return $?
  [ 0 -lt "${#packages[@]}" ] || throwArgument "$handler" "Missing packages" || return $?
  if ! executableExists "$binary"; then
    return 0
  fi
  catchReturn "$handler" packageUninstall "${vv[@]+"${vv[@]}"}" --manager "$manager" "${packages[@]}" || return $?
  if foundPath="$(command -v "$binary")" && [ -n "$foundPath" ]; then
    throwEnvironment "$handler" "packageUninstall ($manager) \"${packages[*]}\" did not remove $(decorate code "$foundPath") FROM the PATH: $(decorate value "${PATH-}")" || return $?
  fi
}
_packageWhichUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageInstall() {
  local handler="_${FUNCNAME[0]}"
  local forceFlag=false packages=() manager="" verboseFlag=false showLog=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    --force)
      forceFlag=true
      ;;
    --verbose)
      verboseFlag=true
      ;;
    --show-log)
      vv+=(--show-log)
      ;;
    *) if
      ! inArray "$argument" "${packages[@]+"${packages[@]}"}"
    then
      packages+=("$argument")
    fi ;;
    esac
    shift
  done
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  executableExists "$manager" || throwEnvironment "$handler" "$manager does not exist" || return $?
  local __start quietLog installed
  __start=$(timingStart) || return $?
  installed="$(fileTemporaryName "$handler")" || return $?
  catchReturn "$handler" packageUpdate "${vv[@]+"${vv[@]}"}" || return $?
  local __installStart clean=()
  __installStart=$(timingStart) || return $?
  catchReturn "$handler" packageInstalledList --manager "$manager" >"$installed" || return $?
  clean+=("$installed")
  local standardPackages=() actualPackages=() package installFunction
  muzzle _packageStandardPackages "$handler" "$manager" || throwEnvironment "$handler" "Unable to fetch standard packages" || returnClean $? "${clean[@]}" || return $?
  IFS=$'\n' read -d '' -r -a standardPackages < <(_packageStandardPackages "$handler" "$manager") || :
  if "$forceFlag"; then
    actualPackages=("${packages[@]}")
  else
    local package
    for package in "${packages[@]+"${packages[@]}"}" "${standardPackages[@]}"; do
      [ -n "$package" ] || continue
      if ! grep -q -e "^$package" <"$installed"; then
        if ! inArray "$package" "${actualPackages[@]+"${actualPackages[@]}"}"; then
          actualPackages+=("$package")
        fi
      elif $forceFlag; then
        if ! inArray "$package" "${actualPackages[@]+"${actualPackages[@]}"}"; then
          actualPackages+=("$package")
        fi
      fi
    done
  fi
  catchEnvironment "$handler" rm -f "$installed" || return $?
  if [ "${#actualPackages[@]}" -eq 0 ]; then
    if [ "${#packages[@]}" -gt 0 ]; then
      ! $verboseFlag || statusMessage --last decorate success "Already installed: ${packages[*]}"
    fi
    return 0
  fi
  ! $verboseFlag || statusMessage decorate info "Installing ${packages[*]+"${packages[*]}"} ... "
  local installFunction="__${manager}Install"
  isFunction "$installFunction" || throwEnvironment "$handler" "$installFunction is not defined" || return $?
  if ! $showLog; then
    local quietLog
    quietLog=$(catchReturn "$handler" buildQuietLog "${FUNCNAME[0]}") || return $?
    exec 3>&1
    exec 1>"$quietLog"
  fi
  catchEnvironment "$handler" "$installFunction" "${actualPackages[@]}" || return $?
  if ! $showLog; then
    exec 1>&3
  fi
  ! $verboseFlag || statusMessage timingReport "$__installStart" "Installed ${packages[*]+"${packages[*]}"} in"
  ! $verboseFlag || printf -- " %s\n" "($(timingReport "$__start" "total"))"
}
_packageInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageIsInstalled() {
  local handler="_${FUNCNAME[0]}"
  local packages=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) packages+=("$argument") ;;
    esac
    shift
  done
  [ "${#packages[@]}" -gt 0 ] || throwArgument "$handler" "Requires at least one package" || return $?
  local installed
  installed=$(fileTemporaryName "$handler") || return $?
  catchReturn "$handler" packageInstalledList >"$installed" || return $?
  local package
  for package in "${packages[@]}"; do
    if ! grep -q -e "^$(quoteGrepPattern "$package")$" "$installed"; then
      catchEnvironment "$handler" rm -rf "$installed" || return $?
      return 1
    fi
  done
  catchEnvironment "$handler" rm -rf "$installed" || return $?
}
_packageIsInstalled() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageUninstall() {
  local handler="_${FUNCNAME[0]}"
  local packages=() manager=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *) packages+=("$argument") ;;
    esac
    shift
  done
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  executableExists "$manager" || throwEnvironment "$handler" "$manager does not exist" || return $?
  [ 0 -lt "${#packages[@]}" ] || throwArgument "$handler" "Requires at least one package to uninstall" || return $?
  local start quietLog standardPackages=()
  start=$(timingStart) || return $?
  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  IFS=$'\n' read -d '' -r -a standardPackages < <(_packageStandardPackages "$handler" "$manager") || :
  local package
  for package in "${packages[@]}"; do
    if inArray "$package" "${standardPackages[@]}"; then
      throwEnvironment "$handler" "Unable to remove standard package $(decorate code "$package")" || return $?
    fi
  done
  local uninstallFunction="__${manager}Uninstall"
  isFunction "$uninstallFunction" || throwEnvironment "$handler" "$uninstallFunction is not defined" || return $?
  statusMessage decorate info "Uninstalling ${packages[*]} ... "
  catchEnvironmentQuiet "$handler" "$quietLog" "$uninstallFunction" "${packages[@]}" || return $?
  statusMessage --last timingReport "$start" "Uninstallation of ${packages[*]} completed in" || :
}
_packageUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_packageStandardPackages() {
  local handler="$1" && shift
  local manager="$1" packageFunction
  packageFunction="__$1StandardPackages"
  isFunction "$packageFunction" || throwEnvironment "$handler" "$packageFunction is not a defined function" || return $?
  catchEnvironment "$handler" "$packageFunction" || return $?
}
packageManagerValid() {
  local handler="_${FUNCNAME[0]}"
  case "${1-}" in
  --help) "$handler" 0 && return $? || return $? ;;
  apk | apt | brew | port | yum) return 0 ;;
  *) return 1 ;;
  esac
}
_packageManagerValid() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_packageDebugging() {
  local bin
  printf "\n"
  for bin in apk dpkg apt-get; do
    printf -- "%s: %s\n" "$bin" "$(command -v "$bin")"
  done
  ls -lad /etc/ | dumpPipe "/etc/ listing"
}
packageManagerDefault() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  export BUILD_PACKAGE_MANAGER
  catchReturn "$handler" buildEnvironmentLoad BUILD_PACKAGE_MANAGER || return $?
  __packageManagerDefault "${BUILD_PACKAGE_MANAGER-}"
}
_packageManagerDefault() {
  true || packageManagerDefault --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageInstalledList() {
  __packageListFunction "_${FUNCNAME[0]}" "Installed" "$@"
}
_packageInstalledList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageAvailableList() {
  __packageListFunction "_${FUNCNAME[0]}" "Available" --before packageUpdate "$@"
}
_packageAvailableList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageNeedRestartFlag() {
  local handler="_${FUNCNAME[0]}"
  local quietLog restartFile
  restartFile="$(catchReturn "$handler" buildCacheDirectory)/.needRestart" || return $?
  if [ $# -eq 0 ]; then
    if [ -f "$restartFile" ]; then
      catchEnvironment "$handler" cat "$restartFile" || return $?
    else
      return 1
    fi
  else
    [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
    if [ "$1" = "" ]; then
      catchEnvironment "$handler" rm -f "$restartFile" || return $?
    else
      printf "%s\n" "$@" >"$restartFile" || throwEnvironment "$handler" "Unable to write $restartFile" || return $?
    fi
  fi
}
_packageNeedRestartFlag() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageGroupWhich() {
  local handler="_${FUNCNAME[0]}"
  local binary="" manager="" groups=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *) if
      [ -z "$binary" ]
    then
      binary=$(validate "$handler" String "$argument" "${1-}") || return $?
    else
      groups+=("$(validate "$handler" String "group" "$argument")") || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$binary" ] || throwArgument "$handler" "Requires binary" || return $?
  [ 0 -lt "${#groups[@]}" ] || throwArgument "$handler" "Requires at least one package group" || return $?
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  executableExists "$manager" || throwEnvironment "$handler" "$manager does not exist" || return $?
  executableExists "$binary" || catchReturn "$handler" packageGroupInstall --manager "$manager" "${groups[@]}" || return $?
}
_packageGroupWhich() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageGroupInstall() {
  local handler="_${FUNCNAME[0]}"
  local groups=() manager=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *) groups+=("$(validate "$handler" String "group" "$argument")") || return $? ;;
    esac
    shift
  done
  [ 0 -lt "${#groups[@]}" ] || throwArgument "$handler" "Requires at least one package to map" || return $?
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  executableExists "$manager" || throwEnvironment "$handler" "$manager does not exist" || return $?
  local package group
  for group in "${groups[@]}"; do
    local packages=()
    while read -r package; do packages+=("$package"); done < <(packageMapping --manager "$manager" "$group")
    catchReturn "$handler" packageInstall --manager "$manager" "${packages[@]}" || return $?
  done
}
_packageGroupInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageGroupUninstall() {
  local handler="_${FUNCNAME[0]}"
  local groups=() manager=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *) groups+=("$(validate "$handler" String "group" "$argument")") || return $? ;;
    esac
    shift
  done
  [ 0 -lt "${#groups[@]}" ] || throwArgument "$handler" "Requires at least one package to map" || return $?
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  executableExists "$manager" || throwEnvironment "$handler" "$manager does not exist" || return $?
  local package group
  for group in "${groups[@]}"; do
    local packages=()
    while read -r package; do packages+=("$package"); done < <(packageMapping --manager "$manager" "$group")
    catchReturn "$handler" packageUninstall --manager "$manager" "${packages[@]}" || return $?
  done
}
_packageGroupUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
packageMapping() {
  local handler="_${FUNCNAME[0]}"
  local packages=() manager=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --manager)
      shift
      manager=$(validate "$handler" String "$argument" "${1-}") || return $?
      packageManagerValid "$manager" || throwArgument "$handler" "Manager is invalid: $(decorate code "$manager")" || return $?
      ;;
    *) packages+=("$argument") ;;
    esac
    shift
  done
  [ -n "$manager" ] || manager=$(packageManagerDefault) || throwEnvironment "$handler" "No package manager" || return $?
  [ 0 -lt "${#packages[@]}" ] || throwArgument "$handler" "Requires at least one package to map" || return $?
  local method="__${manager}PackageMapping"
  isFunction "$method" || throwEnvironment "$handler" "Missing method $method for package manager $manager" || return $?
  local package
  for package in "${packages[@]}"; do
    catchEnvironment "$handler" "$method" "$package" || return $?
  done
}
_packageMapping() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pcregrepInstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchReturn "$handler" packageGroupWhich "$(__pcregrepBinary)" pcregrep || return $?
}
_pcregrepInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pcregrepBinary() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  __pcregrepBinary
}
_pcregrepBinary() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__aptLoader() {
  __buildFunctionLoader ___aptUpdate apt "$@"
}
aptIsInstalled() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  executableExists apt apt-get dpkg 2>/dev/null && [ -f /etc/debian_version ]
}
_aptIsInstalled() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
aptNonInteractive() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  __aptLoader "$handler" "_$handler" "$@"
}
_aptNonInteractive() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
aptKeyRingDirectory() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  printf "%s\n" "/etc/apt/keyrings"
}
_aptKeyRingDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
aptSourcesDirectory() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  printf "%s\n" "/etc/apt/sources.list.d"
}
_aptSourcesDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
aptKeyAdd() {
  __aptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_aptKeyAdd() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
aptKeyRemove() {
  __aptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_aptKeyRemove() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__aptUninstall() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptDefault() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptUpdate() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptUpgrade() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptInstall() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptInstalledList() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptPackageMapping() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptStandardPackages() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
__aptAvailableList() {
  __aptLoader "returnMessage" "_${FUNCNAME[0]}" "$@"
}
yumIsInstalled() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ -x "/usr/bin/yum" ]
}
_yumIsInstalled() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__yumNonInteractive() {
  local handler="returnMessage"
  catchEnvironment "$handler" yum -y -q "$@" || return $?
}
__yumInstall() {
  __yumNonInteractive install "$@" 2> >(grep -v 'yum-utils is not installed' 1>&2) || return $?
}
__yumDefault() {
  while [ $# -gt 0 ]; do
    case "$1" in
    mysqldump) printf -- "%s\n" "mariadb-dump" ;;
    mysql) printf -- "%s\n" "mariadb" ;;
    *) printf -- "%s\n" "$1" ;;
    esac
    shift
  done
}
__yumUninstall() {
  __yumNonInteractive remove "$@" || return $?
}
__yumUpgrade() {
  __yumNonInteractive upgrade -y "$@" || return $?
}
__yumUpdate() {
  __yumNonInteractive update "$@" || return $?
}
__yumInstalledList() {
  __yumNonInteractive list --installed | sed 1d || return $?
}
__yumAvailableList() {
  __yumNonInteractive list --available | sed 1d || return $?
}
__yumStandardPackages() {
  printf "%s\n" which toilet jq shellcheck pcre2-tools diffutils
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="$(__bigTextBinary)"
}
__yumPackageMapping() {
  case "$1" in
  "pcregrep")
    printf "%s\n" "pcre2-utils"
    ;;
  "python")
    printf "%s\n" python-is-python3 python3 python3-pip
    ;;
  "mariadb")
    printf "%s\n" mariadb-common mariadb-client
    ;;
  "mariadb-server")
    printf "%s\n" mariadb-common mariadb-server
    ;;
  "mysql")
    printf "%s\n" mysql-client
    ;;
  "mysql-server")
    printf "%s\n" mysql-server
    ;;
  "sha1sum")
    printf "%s\n" "coreutils"
    ;;
  *) printf "%s\n" "$1" ;;
  esac
}
apkIsInstalled() {
  local handler="_${FUNCNAME[0]}"
  __help --only "$handler" "$@" || return 0
  isAlpine && executableExists apk
}
_apkIsInstalled() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isAlpine() {
  local handler="_${FUNCNAME[0]}"
  __help --only "$handler" "$@" || return 0
  [ -f /etc/alpine-release ]
}
_isAlpine() {
  ! false || isAlpine --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
alpineContainer() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  export LC_TERMINAL TERM
  catchReturn "$handler" buildEnvironmentLoad LC_TERMINAL TERM || return $?
  catchEnvironment "$handler" dockerLocalContainer --handler "$handler" --image alpine:latest --path /root/build --env LC_TERMINAL="$LC_TERMINAL" --env TERM="$TERM" /root/build/bin/build/need-bash.sh Alpine apk add bash ncurses -- "$@" || return $?
}
_alpineContainer() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__apkInstall() {
  apk add "$@"
}
__apkDefault() {
  while [ $# -gt 0 ]; do
    case "$1" in
    mysqldump) printf -- "%s\n" "mariadb-dump" ;;
    mysql) printf -- "%s\n" "mariadb" ;;
    *) printf -- "%s\n" "$1" ;;
    esac
    shift
  done
}
__apkUninstall() {
  apk del "$@"
}
__apkUpgrade() {
  local handler="_${FUNCNAME[0]}"
  local quietLog upgradeLog result clean=()
  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  upgradeLog=$(catchReturn "$handler" buildQuietLog "upgrade_${handler#_}") || return $?
  clean+=("$quietLog" "$upgradeLog")
  catchEnvironment "$handler" apk upgrade | tee -a "$upgradeLog" >>"$quietLog" || returnUndo $? dumpPipe "apk upgrade failed" <"$quietLog" || returnClean $? "${clean[@]}" || return $?
  if ! muzzle packageNeedRestartFlag; then
    if grep -q " restart " "$upgradeLog" || grep -qi needrestart "$upgradeLog" || grep -qi need-restart "$upgradeLog"; then
      catchReturn "$handler" packageNeedRestartFlag "true" || return $?
    fi
    result=restart
  else
    catchReturn "$handler" packageNeedRestartFlag "" || return $?
    result=ok
  fi
  printf "%s\n" "$result"
}
___apkUpgrade() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__apkUpdate() {
  apk update
}
__apkInstalledList() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument $*" || return $?
  apk list -I -q
}
___apkInstalledList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__apkStandardPackages() {
  printf "%s\n" figlet curl pcre2 pcre psutils readline jq
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="figlet"
}
__apkAvailableList() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument $*" || return $?
  apk list -a -q
}
___apkAvailableList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__apkPackageMapping() {
  case "$1" in
  "pcregrep")
    printf "%s\n" pcre2-tools
    ;;
  "python")
    printf "%s\n" python3
    ;;
  "mariadb")
    printf "%s\n" mariadb-client mariadb-common
    ;;
  "mariadb-server")
    printf "%s\n" mariadb-server mariadb-common mariadb-server-utils
    ;;
  "mysql")
    printf "%s\n" mysql-client
    ;;
  "mysql-server")
    printf "%s\n" mysql-server
    ;;
  "sha1sum")
    printf "%s\n" coreutils
    ;;
  *) printf "%s\n" "$1" ;;
  esac
}
__brewWrapper() {
  HOMEBREW_VERBOSE="" brew "$@"
}
brewInstall() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  isDarwin || throwEnvironment "$handler" "Only on Darwin (Mac OS X)" || return $?
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}
_brewInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__brewInstall() {
  __brewWrapper install "$@"
}
__brewDefault() {
  while [ $# -gt 0 ]; do
    case "$1" in
    mysqldump) printf -- "%s\n" "mariadb-dump" ;;
    mysql) printf -- "%s\n" "mariadb" ;;
    *) printf -- "%s\n" "$1" ;;
    esac
    shift
  done
}
__brewUninstall() {
  __brewWrapper uninstall "$@"
}
__brewUpgrade() {
  local handler="_${FUNCNAME[0]}"
  local quietLog upgradeLog result clean=()
  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  upgradeLog=$(catchReturn "$handler" buildQuietLog "upgrade_${handler#_}") || return $?
  clean+=("$quietLog" "$upgradeLog")
  catchEnvironmentQuiet "$quietLog" packageUpdate || return $?
  catchEnvironmentQuiet "$quietLog" packageInstall || return $?
  catchReturn "$handler" __brewWrapper upgrade --overwrite --greedy | tee -a "$upgradeLog" >>"$quietLog" || returnUndo $? dumpPipe "apk upgrade failed" <"$quietLog" || returnClean $? "${clean[@]}" || return $?
  if ! muzzle packageNeedRestartFlag; then
    if grep -q " restart " "$upgradeLog" || grep -qi needrestart "$upgradeLog" || grep -qi need-restart "$upgradeLog"; then
      catchReturn "$handler" packageNeedRestartFlag "true" || returnClean $? "${clean[@]}" || return $?
    fi
    result=restart
  else
    catchReturn "$handler" packageNeedRestartFlag "" || returnClean $? "${clean[@]}" || return $?
    result=ok
  fi
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  printf "%s\n" "$result"
}
___brewUpgrade() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__brewUpdate() {
  local handler="returnMessage" temp returnCode
  temp=$(fileTemporaryName "$handler") || return $?
  if __brewWrapper update 2>"$temp"; then
    rm -rf "$temp" || :
    return 0
  fi
  returnCode=$?
  cat "$temp" 1>&2
  rm -rf "$temp" || :
  return $returnCode
}
__brewInstalledList() {
  local handler="_${FUNCNAME[0]}"
  executableExists brew || throwEnvironment "$handler" "brew not installed - can not list" || return $?
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument $*" || return $?
  __brewWrapper list -1 | grep -v '^[^A-Za-z]'
}
___brewInstalledList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__brewAvailableList() {
  local handler="_${FUNCNAME[0]}"
  executableExists brew || throwEnvironment "$handler" "brew not installed - can not list" || return $?
  __brewWrapper search --formula '/.*/'
}
___brewAvailableList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__brewStandardPackages() {
  printf "%s\n" toilet curl pcre2 pcre psutils readline unzip
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="toilet"
}
__brewPackageMapping() {
  case "$1" in
  "pcregrep")
    printf "%s\n" "pcre2grep"
    ;;
  "python")
    printf "%s\n" python3
    ;;
  "mariadb")
    printf "%s\n" mariadb
    ;;
  "mariadb-server")
    printf "%s\n" mariadb-server
    ;;
  "mysql")
    printf "%s\n" mysql
    ;;
  "mysql-server")
    printf "%s\n" mysql-server
    ;;
  *) printf "%s\n" "$1" ;;
  esac
}
__portWrapper() {
  port "$@"
}
__sudoPortWrapper() {
  if ! sudo -n -v 2>/dev/null; then
    printf "%s%s\n" "$(decorate code MacPorts)" "$(decorate warning ": Attempting to $* ...")"
  fi
  sudo port "$@"
}
__portDefault() {
  printf -- "%s\n" "$@"
}
__portInstall() {
  local packages=() selections=()
  IFS="" read -d $'\n' -r -a packages < <(__portPackageNames "$@")
  __sudoPortWrapper install "${packages[@]}"
  IFS="" read -d $'\n' -r -a selections < <(__portPackageSelections "$@")
  set - "${selections[@]+${selections[@]}}"
  while [ $# -gt 0 ]; do
    __sudoPortWrapper select --set "$1" "$2"
    shift 2
  done
}
__portUninstall() {
  local packages=()
  IFS="" read -d $'\n' -r -a packages < <(__portPackageFilter "$@")
  __sudoPortWrapper uninstall "$@"
}
__portPackageNames() {
  while [ $# -gt 0 ]; do
    case "$1" in
    aws)
      printf "%s\n" "py313-awscli2"
      awscli py313-awscli2
      ;;
    terraform)
      printf "%s\n" "terraform-1.11"
      ;;
    *) printf "%s\n" "$1" ;;
    esac
  done
}
__portPackageSelections() {
  while [ $# -gt 0 ]; do
    case "$1" in
    aws)
      printf "%s\n" "awscli py313-awscli2"
      ;;
    terraform)
      printf "%s\n" "terraform" "terraform-1.11"
      ;;
    *) ;;
    esac
  done
}
__portUpgrade() {
  local handler="_${FUNCNAME[0]}"
  local quietLog upgradeLog result clean=()
  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  upgradeLog=$(catchReturn "$handler" buildQuietLog "upgrade_${handler#_}") || return $?
  clean+=("$quietLog" "$upgradeLog")
  catchEnvironmentQuiet "$quietLog" packageUpdate || return $?
  catchEnvironmentQuiet "$quietLog" packageInstall || return $?
  catchReturn "$handler" __sudoPortWrapper upgrade outdated | tee -a "$upgradeLog" >>"$quietLog" || returnUndo $? dumpPipe "macports upgrade failed" <"$quietLog" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  printf "%s\n" "$result"
}
___portUpgrade() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__portUpdate() {
  local handler="returnMessage" temp returnCode
  temp=$(fileTemporaryName "$handler") || return $?
  if __sudoPortWrapper sync 2>"$temp"; then
    rm -rf "$temp" || :
    return 0
  fi
  returnCode=$?
  cat "$temp" 1>&2
  rm -rf "$temp" || :
  return $returnCode
}
__portInstalledList() {
  local handler="_${FUNCNAME[0]}"
  executableExists port || throwEnvironment "$handler" "port not installed - can not list" || return $?
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument $*" || return $?
  __portWrapper installed | grep -v 'currently installed' | awk '{ print $1 }'
}
___portInstalledList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__portAvailableList() {
  local handler="_${FUNCNAME[0]}"
  executableExists port || throwEnvironment "$handler" "port not installed - can not list" || return $?
  __portWrapper list | awk '{ print $1 }'
}
___portAvailableList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__portStandardPackages() {
  printf "%s\n" toilet curl pcre2 pcre psutils readline unzip
  export BUILD_TEXT_BINARY
  [ -n "${BUILD_TEXT_BINARY-}" ] || BUILD_TEXT_BINARY="toilet"
}
__portPackageMapping() {
  case "$1" in
  "pcregrep")
    printf "%s\n" "pcre2grep"
    ;;
  "python")
    printf "%s\n" python33 py33-pip
    ;;
  "mariadb")
    printf "%s\n" mariadb
    ;;
  "mariadb-server")
    printf "%s\n" mariadb-server
    ;;
  "mysql")
    printf "%s\n" mysql8
    ;;
  "mysql-server")
    printf "%s\n" mysql8-server
    ;;
  *) printf "%s\n" "$1" ;;
  esac
}
__awsLoader() {
  __buildFunctionLoader __awsInstall aws "$@"
}
awsInstall() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsCredentialsFile() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsCredentialsFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsIsKeyUpToDate() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  export AWS_ACCESS_KEY_DATE
  catchReturn "$handler" buildEnvironmentLoad AWS_ACCESS_KEY_DATE || return $?
  isUpToDate "${AWS_ACCESS_KEY_DATE-}" "$@"
}
_awsIsKeyUpToDate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsHasEnvironment() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  catchReturn "$handler" buildEnvironmentLoad AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY || return $?
  [ -n "${AWS_ACCESS_KEY_ID-}" ] && [ -n "${AWS_SECRET_ACCESS_KEY-}" ]
}
_awsHasEnvironment() {
  true || awsHasEnvironment --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsProfilesList() {
  local handler="_${FUNCNAME[0]}"
  local file
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  file=$(catchReturn "$handler" awsCredentialsFile --path) || return $?
  [ -f "$file" ] || return 0
  grep -e '\[[^]]*\]' "$file" | sed 's/[]\[]//g' | sort -u || :
}
_awsProfilesList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsEnvironmentFromCredentials() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsEnvironmentFromCredentials() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsCredentialsHasProfile() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsCredentialsHasProfile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsCredentialsAdd() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsCredentialsAdd() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsCredentialsRemove() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsCredentialsRemove() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsCredentialsFromEnvironment() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  export AWS_PROFILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY
  catchReturn "$handler" buildEnvironmentLoad AWS_PROFILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY || return $?
  awsHasEnvironment || throwEnvironment "$handler" "Requires AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY" || return $?
  catchReturn "$handler" awsCredentialsAdd "$@" "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY" || return $?
}
_awsCredentialsFromEnvironment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsSecurityGroupIPModify() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsSecurityGroupIPModify() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsIPAccess() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsIPAccess() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsRegionValid() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || throwArgument "$handler" "Requires at least one region" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    eu-north-1) ;;
    eu-central-1) ;;
    eu-west-1 | eu-west-2 | eu-west-3) ;;
    ap-south-1) ;;
    ap-southeast-1 | ap-southeast-2) ;;
    ap-northeast-3 | ap-northeast-2 | ap-northeast-1) ;;
    ca-central-1) ;;
    sa-east-1) ;;
    us-east-1 | us-east-2 | us-west-1 | us-west-2) ;;
    *) return 1 ;;
    esac
    shift
  done
  return 0
}
_awsRegionValid() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isS3URL() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || __help "$handler" --help || return 0
  while [ $# -gt 0 ]; do
    [ "$(urlParseItem scheme "$1")" = "s3" ] || return 1
    shift
  done
}
_isS3URL() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsS3Upload() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsS3Upload() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
awsS3DirectoryDelete() {
  __awsLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_awsS3DirectoryDelete() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bitbucketGetVariable() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local value yml home
  home=$(catchReturn "$handler" buildHome) || return $?
  yml="$home/bitbucket-pipelines.yml"
  [ -f "$yml" ] || throwEnvironment "$handler" "Missing $yml" || return $?
  value=$(grep "$1" "$yml" | awk '{ print $2 }')
  value=${value:-$2}
  printf "%s" "$value"
}
_bitbucketGetVariable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bitbucketContainer() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  export BUILD_DOCKER_BITBUCKET_IMAGE BUILD_DOCKER_BITBUCKET_PATH
  if ! buildEnvironmentLoad BUILD_DOCKER_BITBUCKET_IMAGE BUILD_DOCKER_BITBUCKET_PATH; then
    return 1
  fi
  dockerLocalContainer --handler "$handler" --image "${BUILD_DOCKER_BITBUCKET_IMAGE-}" --path "${BUILD_DOCKER_BITBUCKET_PATH-}" "$@"
}
_bitbucketContainer() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isBitBucketPipeline() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  export BUILD_DEBUG BITBUCKET_WORKSPACE CI
  if ! buildEnvironmentLoad BITBUCKET_WORKSPACE CI; then
    return 1
  fi
  [ -n "${BITBUCKET_WORKSPACE-}" ] && test "${CI-}"
}
_isBitBucketPipeline() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bitbucketPRNewURL() {
  local handler="_${FUNCNAME[0]}"
  local org="" name="" eventSource="bash" source=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --event-source) shift && eventSource=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --source) shift && source=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    *) if
      [ -z "$org" ]
    then
      org=$(validate "$handler" String "$argument" "${1-}") || return $?
    elif [ -z "$name" ]; then
      name=$(validate "$handler" String "$argument" "${1-}") || return $?
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$org" ] || throwArgument "$handler" "Organization is required" || return $?
  [ -n "$name" ] || throwArgument "$handler" "Repository is required" || return $?
  [ -n "$source" ] || source=$(catchEnvironment "$handler" gitCurrentBranch) || return $?
  printf -- "https://bitbucket.org/%s/%s/pull-requests/new?source=%s&event_source=%s" "$org" "$name" "$source" "$eventSource"
}
_bitbucketPRNewURL() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__bashLoader() {
  __buildFunctionLoader __bashGetRequires bash "$@"
}
bashSanitize() {
  __bashLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashSanitize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashGetRequires() {
  __bashLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashGetRequires() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashCheckRequires() {
  __bashLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashCheckRequires() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashBuiltins() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" ":" "." "[" "alias" "bg" "bind" "break" "builtin" "case" "cd" "command" "compgen" "complete" "continue" "declare" "dirs" "disown" "echo" "enable" "eval" "exec" "exit" "export" "fc" "fg" "getopts" \
    "hash" "help" "history" "if" "jobs" "kill" "let" "local" "logout" "popd" "printf" "pushd" "pwd" "read" "readonly" "return" "set" "shift" "shopt" "source" "suspend" "test" "times" "trap" "type" "typeset" \
    "ulimit" "umask" "unalias" "unset" "until" "wait" "while"
}
_bashBuiltins() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isBashBuiltin() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || throwArgument "$handler" "Need builtin" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  case "${1-}" in
  ":" | "." | "[" | "alias" | "bg" | "bind" | "break" | "builtin" | "case" | "cd" | "command" | "compgen" | "complete" | "continue" | "declare" | "dirs" | "disown" | "echo" | "enable" | "eval" | "exec" | "exit" | "export" | "fc" | "fg" | "getopts")
    return 0
    ;;
  "hash" | "help" | "history" | "if" | "jobs" | "kill" | "let" | "local" | "logout" | "popd" | "printf" | "pushd" | "pwd" | "read" | "readonly" | "return" | "set" | "shift" | "shopt" | "source" | "suspend" | "test" | "times" | "trap" | "type" | "typeset")
    return 0
    ;;
  "ulimit" | "umask" | "unalias" | "unset" | "until" | "wait" | "while")
    return 0
    ;;
  *) return 1 ;;
  esac
}
_isBashBuiltin() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashLibraryHome() {
  local handler="_${FUNCNAME[0]}"
  local home run startDirectory="${2-}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  run=$(validate "$handler" String "libraryRelativePath" "${1-}") || return $?
  [ -n "$startDirectory" ] || startDirectory=$(catchEnvironment "$handler" pwd) || return $?
  startDirectory=$(validate "$handler" Directory "startDirectory" "$startDirectory") || return $?
  home=$(catchReturn "$handler" directoryParent --pattern "$run" --test -f --test -x "$startDirectory") || return $?
  printf "%s\n" "$home"
}
_bashLibraryHome() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashLibrary() {
  local handler="_${FUNCNAME[0]}"
  local home run="" verboseFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verboseFlag=true
      ;;
    *)
      run="$argument"
      shift
      break
      ;;
    esac
    shift
  done
  [ -n "$run" ] || throwArgument "$handler" "Missing libraryRelativePath" || return $?
  home=$(catchReturn "$handler" bashLibraryHome "$run") || return $?
  if [ $# -eq 0 ]; then
    export HOME
    source "$home/$run" || throwEnvironment "$handler" "source ${run//${HOME-}/~} failed" || return $?
    ! $verboseFlag || decorate info "Reloaded $(decorate code "$run") @ $(decorate info "${home//${HOME-}/~}")"
  else
    ! $verboseFlag || decorate info "Running $(decorate file "$home/$run")" "$(decorate each code -- "$@")"
    execute "$home/$run" "$@" || return $?
  fi
  return 0
}
_bashLibrary() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashSourcePath() {
  local handler="_${FUNCNAME[0]}"
  local ff=() foundOne=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --exclude)
      shift
      ff+=("!" "-path" "$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    *)
      local path tool
      foundOne=true
      path=$(validate "$handler" Directory "directory" "$argument") || return $?
      while read -r tool; do
        local tool="${tool#./}"
        [ -f "$path/$tool" ] || throwEnvironment "$handler" "$path/$tool is not a bash source file" || return $?
        [ -x "$path/$tool" ] || throwEnvironment "$handler" "$path/$tool is not executable" || return $?
        source "$path/$tool" || throwEnvironment "$handler" "source $path/$tool" || return $?
      done < <(cd "$path" && find "." -type f -name '*.sh' ! -path "*/.*/*" "${ff[@]+"${ff[@]}"}" | sort || :)
      ;;
    esac
    shift
  done
  $foundOne || throwArgument "$handler" "Requires a directory" || return $?
}
_bashSourcePath() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashFunctionDefined() {
  local handler="_${FUNCNAME[0]}"
  local files=() function=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$function" ]
    then
      function="$(validate "$handler" String "functionName" "${1-}")" || return $?
    else
      files+=("$(validate "$handler" File "file" "${1-}")") || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$function" ] || throwArgument "$handler" "functionName is required" || retrun $?
  [ ${#files[@]} -gt 0 ] || throwArgument "$handler" "Requires at least one file" || retrun $?
  grep -q -e "^\s*$(quoteGrepPattern "$function")() {" "${files[@]}"
}
_bashFunctionDefined() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashStripComments() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  sed '/^\s*#/d'
}
_bashStripComments() {
  true || bashStripComments --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashShowUsage() {
  local handler="_${FUNCNAME[0]}"
  local functionName="" files=() checkFlags=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --check)
      checkFlags=(-q)
      ;;
    *) if
      [ -z "$functionName" ]
    then
      functionName=$(validate "$handler" String "functionName" "$1") || return $?
    else
      files+=("$(validate "$handler" File "file" "$1")") || return $?
    fi ;;
    esac
    shift
  done
  local quoted
  quoted=$(quoteGrepPattern "$functionName")
  set +o pipefail
  cat "${files[@]+"${files[@]}"}" | bashStripComments | grep -v "^$quoted()" | grep "${checkFlags[@]+"${checkFlags[@]}"}" -e "\b$quoted\b"
}
_bashShowUsage() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashListFunctions() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || __bashListFunctions
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local file
      file=$(validate "$handler" File "file" "$1") || return $?
      __bashListFunctions <"$file"
      ;;
    esac
    shift
  done
}
_bashListFunctions() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__bashListFunctions() {
  local functionLine
  grep -e "^[A-Za-z_]*[A-Za-z0-9_]*() {$" | while read -r functionLine; do
    functionLine="${functionLine%() {}"
    printf "%s\n" "$functionLine"
  done | sort -u
}
bashFunctionCommentVariable() {
  local handler="_${FUNCNAME[0]}"
  local source="" functionName="" variableName="" prefixFlag=false aa=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix) aa+=("$argument") ;;
    *) if
      [ -z "$source" ]
    then
      source="$(validate "$handler" File "source" "${1-}")" || return $?
    elif [ -z "$functionName" ]; then
      functionName=$(validate "$handler" String "functionName" "${1-}") || return $?
    elif [ -z "$variableName" ]; then
      variableName=$(validate "$handler" String "variableName" "${1-}") || return $?
    fi ;;
    esac
    shift
  done
  catchReturn "$handler" bashCommentVariable "${aa[@]}" "$variableName" < <(catchReturn "$handler" bashFunctionComment "$source" "$functionName") || return $?
}
_bashFunctionCommentVariable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashCommentVariable() {
  local handler="_${FUNCNAME[0]}"
  local variableName="" prefixFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --prefix) prefixFlag=true ;;
    *) variableName="$(validate "$handler" String "variableName" "${1-}")" || return $? ;;
    esac
    shift
  done
  [ -n "$variableName" ] || throwArgument "$handler" "variableName is required" || return $?
  local matchLine grepSuffix="" trimSuffix=":"
  if $prefixFlag; then
    grepSuffix="[-_[:alnum:]]*"
    trimSuffix=""
  fi
  while read -r matchLine; do
    matchLine="${matchLine#*"$variableName$trimSuffix"}"
    matchLine=${matchLine# }
    printf "%s\n" "$matchLine"
  done < <(grepSafe -e "[[:space:]]*$variableName$grepSuffix:[[:space:]]*" | trimSpace)
}
_bashCommentVariable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashFileComment() {
  local source="${1-}" lineNumber="${2-}"
  __help "_${FUNCNAME[0]}" "$@" || return 0
  head -n "$((lineNumber + 1))" "$source" | bashFinalComment
}
_bashFileComment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashCommentFilter() {
  local handler="_${FUNCNAME[0]}"
  local ff=(-v) files=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --only)
      ff=()
      ;;
    *) files+=("$(validate "$handler" File "file" "$1")") || return $? ;;
    esac
    shift
  done
  grepSafe "${ff[@]+"${ff[@]}"}" -e '^[[:space:]]*#' "${files[@]+"${files[@]}"}"
}
_bashCommentFilter() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashFinalComment() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  grep -v -e '\(shellcheck \| IDENTICAL \|_IDENTICAL_\|DOC TEMPLATE:\|Internal:\|INTERNAL:\)' | fileReverseLines | sed -n -e 1d -e '/^[[:space:]]*#/ { p'$'\n''b'$'\n''}; q' | sed -e 's/^[[:space:]]*#[[:space:]]//' -e 's/^[[:space:]]*#$//' | fileReverseLines || :
}
_bashFinalComment() {
  ! false || bashFinalComment --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashFunctionComment() {
  local source="${1-}" functionName="${2-}"
  local maxLines=1000
  __help "_${FUNCNAME[0]}" "$@" || return 0
  grep -m 1 -B $maxLines -e "^\s*$functionName() {" "$source" | bashFinalComment
}
_bashFunctionComment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleGetColor() {
  local handler="_${FUNCNAME[0]}"
  local xtermCode="11"
  local timingTweak=0.1
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --background)
      xtermCode="11"
      ;;
    --foreground)
      xtermCode="10"
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  local exitCode=0 parsedColors=()
  local noTTY=false
  local sttyOld && if ! sttyOld=$(stty -g 2>/dev/null); then
    noTTY=true
    printf -- "\e]%d;?\e\\" "$xtermCode" || :
    sleep "$timingTweak" || :
    read -t 2 -r result
    exitCode=$?
  else
    catchEnvironment "$handler" stty raw -echo min 0 time 0 || return $?
    printf -- "\e]%d;?\e\\" "$xtermCode" >/dev/tty || :
    sleep "$timingTweak" || :
    read -t 2 -r result </dev/tty
    exitCode=$?
  fi
  local success=false result=""
  if [ $exitCode -ne 0 ]; then
    success=true
    result="${result#*;}"
    result="${result#rgb:}"
    IFS='/' read -r -a parsedColors < <(printf -- '%s\n' "$result" | sed 's/[^a-f0-9/]//g') || :
  fi
  if ! "$noTTY" && ! stty "$sttyOld"; then
    throwEnvironment "$handler" "stty reset to \"$sttyOld\" failed" || return $?
  fi
  if $success; then
    local color && for color in "${parsedColors[@]+${parsedColors[@]}}"; do
      case "$color" in
      [0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]) printf -- "%d\n" $(((0x$color + 0) / 256)) ;;
      esac
    done
  fi
}
_consoleGetColor() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleBrightness() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  if ! colorBrightness < <(consoleGetColor "$@") 2>/dev/null; then
    return 1
  fi
}
_consoleBrightness() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleConfigureColorMode() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local colorMode="light" color="${1-}" brightness
  if [ -n "$color" ]; then
    brightness=$(colorParse <<<"$color" | colorBrightness)
  else
    brightness=$(consoleBrightness --background)
  fi
  if isInteger "$brightness"; then
    if [ "$brightness" -lt 50 ]; then
      colorMode=dark
    fi
  elif isBitBucketPipeline; then
    colorMode=dark
  fi
  printf -- "%s\n" "$colorMode"
}
_consoleConfigureColorMode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleConfigureDecorate() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local mode && mode=$(catchReturn "$handler" consoleConfigureColorMode "$@") || return $?
  case "$mode" in
  dark) __decorateStylesDefaultDark ;;
  light) __decorateStylesDefaultLight ;;
  *) throwEnvironment "$handler" "Invalid mode returned by consoleConfigureColorMode: $mode" || return $? ;;
  esac
  printf "%s\n" "$mode"
}
_consoleConfigureDecorate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleSetTitle() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  printf -- "\e%s\007" "]0;$*"
}
_consoleSetTitle() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleDefaultTitle() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ -t 0 ] || throwEnvironment "$handler" "stdin is not a terminal" || return $?
  consoleSetTitle "$USER@${HOSTNAME%%.*}: ${PWD/#$HOME/~}"
}
_consoleDefaultTitle() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleLink() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local link="$1" text="${2-$1}" OSC="\e]" ST="\e\\"
  local OSC8="${OSC}8;;"
  printf -- "$OSC8%s$ST%s$OSC8$ST" "$link" "$text"
}
_consoleLink() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleLinksSupported() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  export HOSTNAME
  [ -n "${HOSTNAME-}" ] || return 1
  consoleHasAnimation || return 1
  ! isBitBucketPipeline || return 1
  ! isiTerm2 || return 0
}
_consoleLinksSupported() {
  ! false || consoleLinksSupported --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
consoleFileLink() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  export HOSTNAME HOME
  if ! consoleLinksSupported; then
    printf -- "%s\n" "$(decoratePath "$@")"
  else
    local aa=()
    while [ $# -gt 0 ]; do
      case "$1" in
      --no-app) aa=("$1") ;;
      *)
        local path="$1"
        isPlain "$path" || throwArgument "$handler" "Path contains non-plain characters:"$'\n\n'"$(dumpBinary <<<"$path")"$'\n'"$(debuggingStack)" || return $?
        if [ "${path:0:1}" != "/" ]; then
          path="$(pwd)/$(directoryPathSimplify "$path")"
        fi
        local value="$path"
        if [ $# -gt 1 ]; then
          shift
          value="$1"
        fi
        consoleLink "file://$HOSTNAME$path" "$(decoratePath "${aa[@]+"${aa[@]}"}" "$value")"
        ;;
      esac
      shift
    done
  fi
}
_consoleFileLink() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__decorateExtensionFile() {
  consoleFileLink "$@"
}
__decorateExtensionLink() {
  if ! consoleLinksSupported; then
    printf -- "%s\n" "$1"
  else
    consoleLink "$@"
  fi
}
__promptLoader() {
  __buildFunctionLoader __bashPrompt prompt "$@"
}
bashPrompt() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashPrompt() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashUserInput() {
  local handler="_${FUNCNAME[0]}"
  local word="" exitCode=0
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if ! isTTYAvailable; then
    throwEnvironment "$handler" "No TTY available for user input" || return $?
  fi
  stty -f /dev/tty echo 2>/dev/null || :
  printf "%s" "${__BASH_PROMPT_MARKERS[0]-}" >>/dev/tty
  read -r "$@" word </dev/tty 2>>/dev/tty || exitCode=$?
  printf "%s" "${__BASH_PROMPT_MARKERS[1]-}" >>/dev/tty
  printf "%s" "$word"
  return $exitCode
}
_bashUserInput() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashPromptMarkers() {
  local handler="_${FUNCNAME[0]}"
  local markers=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) markers+=("$1") ;;
    esac
    shift
  done
  [ "${#markers[@]}" -le 2 ] || throwArgument "$handler" "Maximum two markers supported (prefix suffix)"
  export __BASH_PROMPT_MARKERS
  catchReturn "$handler" buildEnvironmentLoad __BASH_PROMPT_MARKERS || return $?
  [ "${#markers[@]}" -eq 0 ] || __BASH_PROMPT_MARKERS=("${markers[@]}")
  printf "%s\n" "${__BASH_PROMPT_MARKERS[@]}"
}
_bashPromptMarkers() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashPromptColorScheme() {
  local handler="_${FUNCNAME[0]}"
  local colors="" exitColor="green:red"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    forest) colors="BOLD cyan:BOLD magenta:green:orange:code" && break ;;
    dark) colors="$exitColor:magenta:blue:BOLD white" && break ;;
    *) colors="$exitColor:magenta:blue:BOLD black" && break ;;
    esac
    shift
  done
  printf -- "%s" "$colors"
}
_bashPromptColorScheme() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashPromptColorsFormat() {
  local index color colorArray=() cc=()
  local all=("BOLD")
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while read -r color; do all+=("$color"); done < <(decorations)
  IFS=":" read -r -a colorArray <<<"$1:::::" || :
  for index in "${!colorArray[@]}"; do
    IFS=" " read -r -a cc <<<"${colorArray[index]}" || :
    local skip=false
    for color in "${cc[@]}"; do inArray "$color" "${all[@]}" || skip=true && break; done
    $skip && colorArray[index]="" || colorArray[index]=$(decorate "${cc[@]}" --)
    [ "$index" -le 4 ] || unset "colorArray[$index]"
  done
  colorArray+=("$(decorate reset --)")
  printf "%s\n" "$(listJoin ":" "${colorArray[@]}")"
}
_bashPromptColorsFormat() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashPromptModule_TermColors() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashPromptModule_TermColors() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
backgroundProcess() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_backgroundProcess() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
reloadChanges() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_reloadChanges() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashPromptModule_dotFilesWatcher() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashPromptModule_dotFilesWatcher() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dotFilesApprovedFile() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" "$(buildEnvironmentGetDirectory "XDG_DATA_HOME")/dotFilesWatcher"
}
_dotFilesApprovedFile() {
  true || dotFilesApprovedFile --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dotFilesApproved() {
  __promptLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_dotFilesApproved() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__crontabGenerate() {
  local crontabTemplate rootEnv rootPath user appName mapper env
  rootEnv=$1
  rootPath="${2%/}"
  user=$3
  mapper=$4
  find "$rootPath" -name "$user.crontab" | sort | grep -v stage | while IFS= read -r crontabTemplate; do
    appName="$(dirname "$crontabTemplate")"
    appName="${appName%/}"
    appName="${appName#"$rootPath"}"
    appName="${appName#/}"
    appName="${appName%%/*}"
    appName="${appName:-default}"
    (
      set -a
      for env in "$rootEnv" "$rootPath/$appName/.env" "$rootPath/$appName/.env.local"; do
        if [ -f "$env" ]; then
          source "$env" || :
        fi
      done
      set +a
      APPLICATION_NAME="$appName" APPLICATION_PATH="$rootPath/$appName" "$mapper" <"$crontabTemplate"
    )
  done || return 0
}
crontabApplicationUpdate() {
  local handler="_${FUNCNAME[0]}"
  catchReturn "$handler" packageWhich crontab cron || return $?
  local rootEnv="" appPath="" user
  user=$(whoami) || throwEnvironment "$handler" whoami || return $?
  [ -n "$user" ] || throwEnvironment "$handler" "whoami user is blank" || return $?
  local environmentMapper="" flagDiff=false flagShow=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --env-file)
      [ -z "$rootEnv" ] || throwArgument "$handler" "$argument already" || return $?
      shift
      rootEnv=$(validate "$handler" File "rootEnv" "$1") || return $?
      ;;
    --mapper)
      [ -z "$environmentMapper" ] || throwArgument "$handler" "$argument already" || return $?
      shift
      environmentMapper=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --user)
      shift
      user="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    --show)
      flagShow=true
      ;;
    --diff)
      flagDiff=true
      ;;
    *) appPath="$(validate "$handler" Directory "applicationPath" "$argument")" || return $? ;;
    esac
    shift
  done
  if [ -z "$environmentMapper" ]; then
    environmentMapper=mapEnvironment
  fi
  isCallable "$environmentMapper" || throwEnvironment "$handler" "$environmentMapper is not callable" || return $?
  [ -n "$appPath" ] || throwArgument "$handler" "Need to specify application path" || return $?
  [ -n "$user" ] || throwArgument "$handler" "Need to specify user" || return $?
  if $flagShow; then
    __crontabGenerate "$rootEnv" "$appPath" "$user" "$environmentMapper"
    return 0
  fi
  local newCrontab returnCode
  newCrontab=$(fileTemporaryName "$handler")
  __crontabGenerate "$rootEnv" "$appPath" "$user" "$environmentMapper" >"$newCrontab" || return $?
  if [ ! -s "$newCrontab" ]; then
    decorate warning "Crontab for $user is EMPTY"
  fi
  if $flagDiff; then
    printf "%s\n" "$(decorate red "Differences")"
    crontab -u "$user" -l | diff "$newCrontab" - | decorate code | decorate wrap --fill ">>> " " <<<"
    return $?
  fi
  if crontab -u "$user" -l 2>/dev/null | diff -q "$newCrontab" - >/dev/null; then
    rm -f "$newCrontab" || :
    return 0
  fi
  statusMessage printf "%s %s ...\n" "$(decorate info "Updating crontab on ")" "$(decorate value "$(date)")"
  returnCode=0
  catchEnvironment "$handler" crontab -u "$user" - <"$newCrontab" 2>/dev/null || returnCode=$?
  catchEnvironment "$handler" rm -f "$newCrontab" || return $?
  [ $returnCode -eq 0 ] || return "$returnCode"
  statusMessage --last printf -- "%s %s on %s\n" "$(decorate info "Updated crontab of ")" "$(decorate code "$user")" "$(decorate value "$(date)")"
  return 0
}
_crontabApplicationUpdate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isDarwin() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  [ "$(uname -s)" = "Darwin" ]
}
_isDarwin() {
  true || isDarwin --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
darwinSoundDirectory() {
  local handler="_${FUNCNAME[0]}" home
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  isDarwin || throwEnvironment "$handler" "Only on Darwin" || return $?
  home=$(catchReturn "$handler" userHome) || return $?
  printf "%s\n" "$home/Library/Sounds"
}
_darwinSoundDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
darwinSoundValid() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local sound sounds=()
  while read -r sound; do sounds+=("$sound"); done < <(darwinSoundNames)
  while [ $# -gt 0 ]; do
    [ "${#sounds[@]}" -gt 0 ] || return 1
    inArray "$1" "${sounds[@]}" || return 1
    shift
  done
}
_darwinSoundValid() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
darwinSoundInstall() {
  local handler="_${FUNCNAME[0]}"
  local soundFiles=() soundDirectory createFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --create)
      createFlag=true
      ;;
    *) soundFiles+=("$(validate "$handler" File "soundFile" "${1-}")") || return $? ;;
    esac
    shift
  done
  [ "${#soundFiles[@]}" -gt 0 ] || throwArgument "$handler" "Need at least one sound file" || return $?
  soundDirectory=$(catchEnvironment "$handler" darwinSoundDirectory) || return $?
  if [ ! -d "$soundDirectory" ]; then
    if "$createFlag"; then
      catchEnvironment "$handler" mkdir -p "$soundDirectory" || return $?
    else
      throwEnvironment "$handler" "No $soundDirectory" || return $?
    fi
  fi
  catchEnvironment "$handler" cp "${soundFiles[@]+"${soundFiles[@]}"}" "${soundDirectory%/}/" || return $?
}
_darwinSoundInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
darwinSoundNames() {
  local handler="_${FUNCNAME[0]}" soundDirectory
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  soundDirectory=$(catchEnvironment "$handler" darwinSoundDirectory) || return $?
  [ -d "$soundDirectory" ] || throwEnvironment "$handler" "No $soundDirectory" || return $?
  find "$soundDirectory" -type f ! -name '.*' -exec basename {} \; | while read -r file; do
    printf "%s\n" "${file%.*}"
  done
}
_darwinSoundNames() {
  ! false || darwinSoundNames --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__osascriptClean() {
  local text
  text="$(consoleToPlain <<<"$1")"
  text="${text//$'\n'/\\n}"
  text="${text//$'\r'/}"
  text="$(escapeDoubleQuotes "$text")"
  printf "%s" "$text"
}
darwinNotification() {
  local handler="_${FUNCNAME[0]}"
  local messages=() title="" soundName="" debugFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --debug)
      debugFlag=true
      ;;
    --title)
      shift
      title="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    --sound)
      shift
      soundName="$(validate "$handler" String "$argument" "${1-}")" || return $?
      darwinSoundValid "$soundName" || throwArgument "$handler" "Sound name $(decorate value "$soundName") not valid, ignoring: $(darwinSoundNames)" || :
      ;;
    --)
      shift
      messages=("$@")
      set --
      break
      ;;
    *) messages+=("$1") ;;
    esac
    shift
  done
  [ 0 -lt "${#messages[@]}" ] || throwArgument "$handler" "Requires a message" || return $?
  muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" osascript || return $?
  [ -n "$title" ] || title="Zesk Build Notification"
  local messageText
  messageText="$(__osascriptClean "${messages[*]}")"
  title="$(__osascriptClean "$title")"
  script="display notification \"$messageText\" with title \"$title\""
  [ -z "$soundName" ] || script="$script sound name \"$(escapeDoubleQuotes "$soundName")\""
  if $debugFlag; then
    printf "%s\n" "$script" >"$(buildHome)/${FUNCNAME[0]}.debug"
  fi
  catchEnvironment "$handler" /usr/bin/osascript -e "$script" || return $?
}
_darwinNotification() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
darwinDialog() {
  local handler="_${FUNCNAME[0]}"
  local message=() defaultButton=0 choices=() title="" icon="-" timeout="" debugFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --choice)
      shift
      choices+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --title)
      shift
      title="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    --icon)
      shift
      icon=$(validate "$handler" File "$argument" "${1-}") || return $?
      ;;
    --ok)
      choices+=("Ok")
      ;;
    --cancel)
      choices+=("Cancel")
      ;;
    --timeout)
      shift
      timeout=$(validate "$handler" PositiveInteger "$argument" $"${1-}") || return $?
      ;;
    --debug)
      debugFlag=true
      ;;
    --default)
      shift
      defaultButton="$(validate "$handler" UnsignedInteger "$argument" "${1-}")" || return $?
      ;;
    --)
      shift
      message=("$@")
      set --
      break
      ;;
    *) message+=("$1") ;;
    esac
    shift
  done
  muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" osascript || return $?
  [ "$icon" != "-" ] || icon="$(buildHome)/etc/zesk-build-icon.png"
  local choice choiceText=() messageText maxChoice quietErrors
  choiceText=()
  if [ ${#choices[@]} -eq 0 ]; then
    choices+=(Ok)
  fi
  for choice in "${choices[@]}"; do
    choiceText+=("$(printf '"%s"' "$(escapeDoubleQuotes "$choice")")")
  done
  maxChoice=$((${#choices[@]} - 1))
  if [ "$defaultButton" -gt $maxChoice ]; then
    throwArgument "$handler" "defaultButton $defaultButton is out of range 0 ... $maxChoice" || return $?
  fi
  messageText="$(escapeDoubleQuotes "$(printf "%s\\\n" "${message[@]}")")"
  quietErrors=$(fileTemporaryName "$handler") || return $?
  defaultButton=$((defaultButton + 1))
  (
    local choices
    choices=$(listJoin "," "${choiceText[@]}")
    local script="display dialog \"$messageText\" buttons { $choices } default button $defaultButton"
    [ -z "$timeout" ] || script="$script giving up after $timeout"
    [ -z "$title" ] || script="$script with title \"$(escapeDoubleQuotes "$title")\""
    IFS=','
    ! $debugFlag || printf "\n\n    %s\n\n" "$(decorate code "$script")"
    result="$(catchEnvironment "$handler" osascript -e "$script" 2>"$quietErrors")" || returnUndo $? cat "$quietErrors" || return $?
    rm -rf "$quietErrors" || :
    local name value button="none" done=false IFS
    while ! $done; do
      if ! IFS=":" read -d ',' -r name value; then
        done=true
      fi
      name="${name# }"
      value="$(trimSpace "$value")"
      ! $debugFlag || decorate pair "$name" "$value"
      case "$name" in
      "button returned")
        button="$value"
        ;;
      "gave up")
        isBoolean "$value" || throwEnvironment "$handler" "gave up should be a boolean: $value" || return $?
        ! "$value" || returnMessage "$(returnCode timeout)" "Dialog timed out" || return $?
        ;;
      *) throwEnvironment "$handler" "Unknown return value from dialog: $(decorate label "$name"): $(decorate value "$value")" || return $? ;;
      esac
    done <<<"$result"
    printf "%s\n" "$button"
  ) || returnClean $? "$quietErrors" || return $?
}
_darwinDialog() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
daemontoolsInstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local packages
  if isAlpine; then
    packages=(daemontools-encore)
  else
    packages=(daemontools svtools)
    if dockerInside; then
      decorate warning "daemontools-run can not be installed because Docker exits 2024-03-21" 1>&2
    else
      packages+=(daemontools-run)
    fi
  fi
  catchReturn "$handler" packageInstall "${packages[@]}" || return $?
  if dockerInside; then
    decorate warning "daemontools run in background - not production" 1>&2
    catchReturn "$handler" daemontoolsExecute || return $?
  fi
}
_daemontoolsInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
daemontoolsInstallService() {
  local handler="_${FUNCNAME[0]}"
  local debugFlag=false
  local serviceHome="" serviceName="" serviceFile="" extras=() logHome="" arguments=() logArguments=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --debug)
      debugFlag=true
      ;;
    --home)
      shift
      serviceHome="${1-}"
      ;;
    --escalate)
      extras+=("$argument")
      ;;
    --)
      shift
      arguments+=("$@")
      break
      ;;
    --arguments)
      shift
      while [ $# -gt 0 ]; do [ "$1" != "--" ] && arguments+=("$1") && shift || break; done
      [ $# -gt 0 ] || break
      ;;
    --log-arguments)
      shift
      while [ $# -gt 0 ]; do [ "$1" != "--" ] && logArguments+=("$1") && shift || break; done
      [ $# -gt 0 ] || break
      ;;
    --name)
      shift
      serviceName=$(validate "$handler" String "serviceName" "${1-}") || return $?
      ;;
    --log)
      shift
      logHome="$(validate "$handler" Directory "$argument" "${1-}")" || return $?
      ;;
    *) if
      [ -z "$serviceFile" ]
    then
      serviceFile=$(validate "$handler" Executable "serviceFile" "$1") || return $?
    elif [ -z "$serviceName" ]; then
      serviceName=$(validate "$handler" String "serviceName" "$1") || return $?
    else
      throwArgument "$handler" "Extra argument $1" || return $?
    fi ;;
    esac
    shift
  done
  local templateHome && templateHome="$(catchReturn "$handler" buildHome)/bin/build/identical" || return $?
  catchReturn "$handler" buildEnvironmentLoad DAEMONTOOLS_HOME || return $?
  [ -n "$serviceHome" ] || serviceHome=${DAEMONTOOLS_HOME-}
  [ -d "$serviceHome" ] || throwEnvironment "$handler" "daemontools home \"$serviceHome\" is not a directory" || return $?
  [ -n "$serviceFile" ] || throwArgument "$handler" "$serviceFile is required" || return $?
  if [ -z "$serviceName" ]; then
    serviceName="$(basename "$serviceFile")"
    serviceName="${serviceName%%.*}"
  fi
  local appUser
  appUser=$(catchReturn "$handler" fileOwner "$serviceFile") || return $?
  [ -n "$appUser" ] || throwEnvironment "$handler" "fileOwner $serviceFile returned blank" || return $?
  local binaryPath
  binaryPath=$(realPath "$serviceFile") || throwEnvironment "$handler" "realPath $serviceFile" || return $?
  local target="$serviceHome/$serviceName" logTarget="$serviceHome/$serviceName/log"
  local args="" logArgs=""
  [ "${#arguments[@]}" -eq 0 ] || args=" $(decorate each quote "${arguments[@]}")"
  ! $debugFlag || printf -- "- %s\n" "ARGUMENTS" "${#arguments[@]}" "${arguments[@]+"${arguments[@]}"}" 1>&2
  ! $debugFlag || printf -- "- %s %s\n" "args" "$args" 1>&2
  ARGUMENTS="$args" LOG_HOME="$logHome" APPLICATION_USER="$appUser" BINARY="$binaryPath" _daemontoolsInstallServiceRun "$handler" "$templateHome/daemontools-service.sh" "$target" "${extras[@]+"${extras[@]}"}" || return $?
  if [ -d "$logHome" ]; then
    [ "${#logArguments[@]}" -eq 0 ] || logArgs=" $(decorate each quote "${logArguments[@]}")"
    ARGUMENTS="$logArgs" LOG_HOME="$logHome" APPLICATION_USER="$appUser" BINARY="$binaryPath" _daemontoolsInstallServiceRun "$handler" "$templateHome/daemontools-log.sh" "$logTarget" "${extras[@]+"${extras[@]}"}" || return $?
  fi
  _daemontoolsSuperviseWait "$handler" "$target" || return $?
  if [ -d "$logHome" ]; then
    _daemontoolsSuperviseWait "$handler" "$logTarget" || return $?
  fi
}
_daemontoolsInstallService() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_daemontoolsInstallServiceRun() {
  local handler="$1" source="$2" target="$3" args
  shift 3 || throwArgument "$handler" "Missing arguments" || return $?
  catchReturn "$handler" muzzle directoryRequire "$target" || return $?
  args=(--map "$source" "$target/run")
  if fileCopyWouldChange "${args[@]}"; then
    catchEnvironment "$handler" fileCopy "$@" "${args[@]}" || return $?
    catchEnvironment "$handler" chmod 700 "$target" "$target/run" || return $?
  fi
}
_daemontoolsSuperviseWait() {
  local handler="$1" && shift
  local total=10 stayQuietFor=5
  statusMessage decorate info "Waiting for $(decorate file "$1/supervise") (START) ..."
  local start target="$1"
  start=$(catchEnvironment "$handler" date +%s) || return $?
  while [ ! -d "$target/supervise" ]; do
    sleep 1 || throwEnvironment "$handler" "interrupted" || return $?
    local elapsed
    elapsed=$(($(catchEnvironment "$handler" date +%s) - start)) || return $?
    if [ $elapsed -gt "$total" ]; then
      throwEnvironment "$handler" "supervise is not running - $target/supervise never found after $total seconds" || return $?
    elif [ $elapsed -gt "$stayQuietFor" ]; then
      statusMessage decorate info "Waiting for $(decorate file "$target/supervise") ($elapsed) ..."
    fi
  done
}
daemontoolsRemoveService() {
  local handler="_${FUNCNAME[0]}"
  local serviceHome="" serviceName=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --home)
      shift
      serviceHome=$(validate "$handler" Directory "$argument" "${1-}") || return $?
      ;;
    *) if
      [ -z "$serviceName" ]
    then
      serviceName="$1"
    else
      throwArgument "$handler" "Extra argument $1" || return $?
    fi ;;
    esac
    shift
  done
  if [ -z "$serviceHome" ]; then
    catchReturn "$handler" buildEnvironmentLoad DAEMONTOOLS_HOME || return $?
    serviceHome="$DAEMONTOOLS_HOME"
  fi
  [ -d "$serviceHome" ] || throwEnvironment "$handler" "daemontools home \"$serviceHome\" is not a directory" || return $?
  [ -d "$serviceHome/$serviceName" ] || throwEnvironment "$handler" "$serviceHome/$serviceName does not exist" || return $?
  catchEnvironment "$handler" pushd "$serviceHome/$serviceName" >/dev/null || return $?
  catchEnvironment "$handler" muzzle svc -dx . log 2>&1 || return $?
  catchEnvironment "$handler" rm -rf "$serviceHome/$serviceName" || return $?
  catchEnvironment "$handler" popd >/dev/null || return $?
}
_daemontoolsRemoveService() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
daemontoolsIsRunning() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local processIds processId
  [ "$(id -u 2>/dev/null)" = "0" ] || throwEnvironment "$handler" "Must be root" || return $?
  processIds=()
  while read -r processId; do processIds+=("$processId"); done < <(daemontoolsProcessIds)
  [ 0 -ne "${#processIds[@]}" ] || return 1
  ! kill -0 "${processIds[@]}" || return 0
  return 1
}
_daemontoolsIsRunning() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
daemontoolsHome() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchReturn "$handler" buildEnvironmentGet DAEMONTOOLS_HOME || return $?
}
_daemontoolsHome() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
daemontoolsExecute() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  [ "$(id -u 2>/dev/null)" = "0" ] || throwEnvironment "$handler" "Must be root" || return $?
  local home
  home="$(catchReturn "$handler" daemontoolsHome)" || return $?
  muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" svscanboot id svc svstat || return $?
  catchReturn "$handler" muzzle directoryRequire --mode 0775 --owner root:root "$home" || return $?
  catchEnvironment "$handler" muzzle nohup bash -c 'svscanboot &' 2>&1 || return $?
}
_daemontoolsExecute() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
daemontoolsProcessIds() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local processIds=() processId
  while read -r processId; do processIds+=("$processId"); done < <(pgrep 'svscan*')
  if [ ${#processIds[@]} -eq 0 ]; then
    return 0
  fi
  printf "%s\n" "${processIds[@]}"
}
_daemontoolsProcessIds() {
  ! false || daemontoolsProcessIds --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
daemontoolsTerminate() {
  local handler="_${FUNCNAME[0]}"
  local timeout=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --timeout) shift && timeout=$(validate "$handler" Integer "seconds" "$1") || return $? ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  [ "$(id -u 2>/dev/null)" = "0" ] || throwEnvironment "$handler" "Must be root" || return $?
  muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" svscanboot id svc svstat || return $?
  local home && home="$(catchEnvironment "$handler" daemontoolsHome)" && home="${home%/}" || return $?
  catchReturn "$handler" statusMessage decorate warning "Shutting down services [$(decorate file "$home")]" || return $?
  local service && while read -r service; do
    service="${service%/}"
    if [ "$service" = "$home" ]; then
      continue
    fi
    catchReturn "$handler" statusMessage decorate warning "Shutting down $service ..." || return $?
    catchEnvironment "$handler" svc -dx "$service" || return $?
    [ ! -d "$service/log" ] || catchEnvironment "$handler" svc -dx "$service/log" || return $?
  done < <(find "$home" -maxdepth 1 -type d)
  local processId processIds=() && while read -r processId; do processIds+=("$processId"); done < <(daemontoolsProcessIds)
  if [ ${#processIds[@]} -eq 0 ]; then
    catchReturn "$handler" statusMessage --last decorate warning "daemontools is not running" || return $?
  else
    catchReturn "$handler" statusMessage decorate warning "Shutting down processes ..." || return $?
    catchReturn "$handler" printf "%s\n%s\n" "processIds" "$(catchReturn "$handler" printf -- "- %s\n" "${processIds[@]}")" || return $?
    catchEnvironment "$handler" processWait --verbose --signals TERM,QUIT,KILL --timeout "$timeout" "${processIds[@]}" || return $?
    local remaining && remaining="$(catchReturn "$handler" daemontoolsProcessIds)" || return $?
    if [ -n "$remaining" ]; then
      throwEnvironment "$handler" "daemontools processes still exist: $remaining" || return $?
    fi
    statusMessage --last decorate success "Terminated daemontools" || return $?
  fi
}
_daemontoolsTerminate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
daemontoolsRestart() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  local home
  [ "$(id -u 2>/dev/null)" = "0" ] || throwEnvironment "$handler" "Must be root" || return $?
  home="$(catchEnvironment "$handler" daemontoolsHome)" || return $?
  home="${home%/}"
  muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" svscanboot id svc svstat || return $?
  local killLoop foundOne maxLoops
  statusMessage decorate info "Restarting daemontools [$(decorate file "$home")]..."
  killLoop=0
  maxLoops=4
  foundOne=true
  while $foundOne; do
    local pid name
    foundOne=false
    while read -r pid name; do
      statusMessage decorate info "$(printf "Killing %s %s " "$name" "$(decorate value "($pid)")")"
      kill -9 "$pid" || printf "kill %s FAILED (?: %d) " "$name" $?
      foundOne=true
    done < <(pgrep svscan -l)
    killLoop=$((killLoop + 1))
    [ $killLoop -le $maxLoops ] || throwEnvironment "$handler" "Unable to kill svscan processes after $maxLoops attempts" || return $?
  done
  catchEnvironment "$handler" pkill svscan -t KILL || return $?
  catchEnvironment "$handler" svc -dx "$home"/* "$home"/*/log || return $?
  local bootPid
  bootPid="$(
    nohup svscanboot 2>/dev/null &
    printf -- "%d" $!
  )"
  isPositiveInteger "$bootPid" || throwEnvironment "$handler" "No svscanboot PID: $bootPid [${#bootPid}]" || return $?
  statusMessage decorate warning "Waiting 5 seconds ..."
  sleep 5 || throwEnvironment "$handler" "Killed during sleep" || return $?
  kill -0 "$bootPid" || throwEnvironment "$handler" "Unable to signal svscanboot PID $bootPid" || return $?
  catchEnvironment "$handler" svstat "$home" || return $?
  statusMessage --last decorate success "Successfully restarted daemontools [$bootPid]"
}
_daemontoolsRestart() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
daemontoolsManager() {
  local handler="_${FUNCNAME[0]}"
  local services=() files=() actions=()
  local currentActions=("restart") intervalSeconds=10 chirpSeconds=0 statFile="" serviceHome="${DAEMONTOOLS_HOME-}" svcBin statBin service="" file=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --chirp)
      shift
      chirpSeconds=$(validate "$handler" PositiveInteger chirpSeconds "${1-}") || return $?
      ;;
    --interval)
      shift
      intervalSeconds=$(validate "$handler" PositiveInteger intervalSeconds "${1-}") || return $?
      ;;
    --stat)
      shift
      [ -z "$statFile" ] || throwArgument "$handler" "$argument must be specified once ($statFile and ${1-})" || return $?
      statFile=$(validate "$handler" FileDirectory "statFile" "${1-}") || return $?
      ;;
    --home)
      shift
      serviceHome=$(validate "$handler" Directory "serviceHome" "${1-}") || return $?
      ;;
    --action)
      shift
      IFS="," read -r -a currentActions <<<"$1" || :
      [ ${#currentActions[@]} -gt 0 ] || throwArgument "$handler" "$argument No actions specified"
      for action in "${currentActions[@]}"; do
        case "$action" in start | restart | stop) ;; *) throwArgument "$handler" "Invalid action $action" || return $? ;; esac
      done
      ;;
    *) if
      [ -z "$service" ]
    then
      service="$1"
      [ -d "$service" ] || throwEnvironment "$handler" "service must be a service directory that exists: $service" || return $?
    else
      file="$1"
      [ -d "$(dirname "$file")" ] || throwEnvironment "$handler" "file must be in a directory that exists: $file" || return $?
      services+=("$service")
      files+=("$file")
      actions+=("${currentActions[*]}")
      service=
      file=
    fi ;;
    esac
    shift
  done
  catchReturn "$handler" buildEnvironmentLoad DAEMONTOOLS_HOME || return $?
  muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" svc svstat || return $?
  svcBin=$(catchEnvironment "$handler" which svc) || return $?
  statBin=$(catchEnvironment "$handler" which svstat) || return $?
  [ "${#services[@]}" -gt 0 ] || throwArgument "$handler" "Need at least one service and file pair" || return $?
  local start lastChirp
  start=$(catchEnvironment "$handler" date +%s) || return $?
  lastChirp=$start
  printf "%s: pid %d: (every %d %s)\n" "$(basename "${BASH_SOURCE[0]}")" "$$" "$intervalSeconds" "$(plural "$intervalSeconds" second seconds)"
  local index=0
  while [ $index -lt ${#files[@]} ]; do
    printf "    service: %s file: %s actions: %s\n" "${services[$index]}" "${files[$index]}" "${actions[$index]}"
    index=$((index + 1))
  done
  while true; do
    if [ -n "$statFile" ]; then
      statFile=$(validate "$handler" FileDirectory "statFile" "$statFile") || return $?
      catchEnvironment "$handler" "$statBin" "$serviceHome/*" "$serviceHome/*/log" >"$statFile" || return $?
    fi
    index=0
    while [ $index -lt ${#files[@]} ]; do
      local service="${services[$index]}" file="${files[$index]}" action=${actions[$index]} directory fileAction svcBinFlags
      index=$((index + 1))
      directory="$(dirname "$file")"
      [ -d "$directory" ] || throwEnvironment "$handler" "Parent directory deleted, exiting: $directory" || return $?
      if [ ! -f "$file" ]; then
        continue
      fi
      fileAction="$(head -1 "$file")"
      case "$fileAction" in start | stop | restart) ;; *) fileAction="restart" ;; esac
      IFS=" " read -r -a currentActions <<<"$action" || :
      svcBinFlags=
      for action in "${currentActions[@]}"; do
        if [ "$action" = "$fileAction" ]; then
          printf "start=%s\n""action=%s\n""daemon=%d\n""service=%s\n" "$(date +%s)" "$fileAction" "$$" "$service" >"$file.svc"
          printf "Service %s: %s\n" "$fileAction" "$(basename "$service")"
          case $fileAction in
          start) svcBinFlags="-u" ;;
          stop) svcBinFlags="-d" ;;
          *) svcBinFlags="-t" ;;
          esac
          break
        fi
      done
      if [ -z "$svcBinFlags" ]; then
        printf "Service %s: %s requested but not permitted: %s\n" "$(basename "$service")" "$fileAction" "${actions[*]}" 1>&2
      else
        if "$svcBin" "$svcBinFlags" "$service" 2>&1 | grep -q warning; then
          throwEnvironment "$handler" "Unable to control service $service ($svcBinFlags)" || return $?
        fi
      fi
      rm -f "$file" "$file.svc" 2>/dev/null
    done
    if ! sleep "$intervalSeconds"; then
      statusMessage --last printf -- "%s\n%s%s\n" "$(decorate reset --)" "$(decorate warning "Interrupt")"
      break
    fi
    if [ "$chirpSeconds" -gt 0 ]; then
      local now
      now=$(date +%s)
      if [ "$((now - lastChirp))" -gt "$chirpSeconds" ]; then
        printf "pid %d: %s has been alive for %d seconds\n" "$$" "${BASH_SOURCE[0]}" "$((now - start))"
        lastChirp=$now
      fi
    fi
  done
}
_daemontoolsManager() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__deployLoader() {
  __buildFunctionLoader __deployApplication deploy "$@"
}
deployApplication() {
  __deployLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_deployApplication() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deployApplicationVersion() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local p="${1-}" value
  local tryVariables=(APPLICATION_ID APPLICATION_TAG)
  local deployFile
  [ -d "$p" ] || throwEnvironment "$handler" "$p is not a directory" || return $?
  for f in "${tryVariables[@]}"; do
    deployFile="$p/.deploy/$f"
    if [ -f "$deployFile" ]; then
      printf "%s\n" "$(head -n 1 "$deployFile")"
      return 0
    fi
  done
  [ -f "$p/.env" ] || throwEnvironment "$handler" "$p/.env does not exist" || return $?
  for f in "${tryVariables[@]}"; do
    value=$(
      source "$p/.env"
      printf "%s" "${!f-}"
    )
    if [ -n "$value" ]; then
      printf "%s\n" "$value"
      return 0
    fi
  done
  throwEnvironment "$handler" "No application version found" || return $?
}
_deployApplicationVersion() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deployPackageName() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  export BUILD_TARGET
  catchReturn "$handler" buildEnvironmentLoad BUILD_TARGET || return $?
  [ -n "${BUILD_TARGET-}" ] || throwEnvironment "$handler" "BUILD_TARGET is blank" || return $?
  printf "%s\n" "${BUILD_TARGET-}"
}
_deployPackageName() {
  true || deployPackageName --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deployHasVersion() {
  local handler="_${FUNCNAME[0]}"
  local deployHome versionName targetPackage
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  deployHome=$(validate "$handler" Directory deployHome "${1-}") || return $?
  versionName="${2-}"
  [ -n "$versionName" ] || throwArgument "$handler" "blank versionName" || return $?
  targetPackage="${3-$(deployPackageName)}"
  [ -d "$deployHome/$versionName" ] || throwEnvironment "$handler" "No deployment version found: $deployHome/$versionName" || return $?
  [ -f "$deployHome/$versionName/$targetPackage" ]
}
_deployHasVersion() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_applicationIdLink() {
  local handler="${1-}" fileSuffix="${2-}" && shift 2 || return $?
  [ -n "$fileSuffix" ] || throwArgument "$handler" "Internal fileSuffix is blank" || return $?
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local deployHome versionName
  deployHome="$(validate "$handler" Directory deployHome "${1-}")" && shift || return $?
  versionName=$(validate "$handler" String "versionName" "${1-}") && shift || return $?
  [ -f "$deployHome/$versionName.$fileSuffix" ] && cat "$deployHome/$versionName.$fileSuffix"
}
deployPreviousVersion() {
  _applicationIdLink "_${FUNCNAME[0]}" previous "$@"
}
_deployPreviousVersion() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deployNextVersion() {
  _applicationIdLink "_${FUNCNAME[0]}" next "$@"
}
_deployNextVersion() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deployMove() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local applicationPath newApplicationSource
  applicationPath=$(validate "$handler" Directory applicationPath "${1-}") || return $?
  shift || throwArgument "$handler" "missing argument" || return $?
  newApplicationSource=$(pwd) || throwEnvironment "$handler" "Unable to get pwd" || return $?
  directoryClobber "$newApplicationSource" "$applicationPath"
}
_deployMove() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deployLink() {
  __deployLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_deployLink() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deployMigrateDirectoryToLink() {
  __deployLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_deployMigrateDirectoryToLink() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deployBuildEnvironment() {
  local handler="_${FUNCNAME[0]}"
  local envFiles=() envFilesLoaded=()
  local deployHome="" applicationPath="" applicationId="" userHosts=() dryRun=false targetPackage="" deployArgs=()
  local buildEnv="./.build.env"
  envFiles=()
  envFilesLoaded=()
  if [ -f "$buildEnv" ]; then
    envFiles=("$buildEnv")
  fi
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --env-file)
      shift
      envFiles+=("$(validate "$handler" File "envFile" "${1-}")") || return $?
      ;;
    --debug)
      debuggingFlag=true
      ;;
    --first)
      deployArgs+=("$argument")
      ;;
    --home)
      shift
      deployHome="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    --host)
      shift
      userHosts+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --id)
      shift
      applicationId="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    --application)
      shift
      applicationPath="${1-}"
      ;;
    --target)
      shift
      targetPackage="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    --dry-run)
      dryRun=true
      ;;
    *) userHosts+=("$argument") ;;
    esac
    shift
  done
  if [ ! -f "$buildEnv" ]; then
    decorate warning "No .build.env found - environment must be already configured" 1>&2
  fi
  local envFile
  for envFile in "${envFiles[@]+${envFiles[@]}}"; do
    muzzle validate "$handler" LoadEnvironmentFile "envFile" "$envFile" || return $?
    envFilesLoaded+=("$envFile")
  done
  buildEnvironmentLoad APPLICATION_ID DEPLOY_REMOTE_HOME APPLICATION_REMOTE_HOME DEPLOY_USER_HOSTS BUILD_TARGET || :
  applicationId=${applicationId:-$APPLICATION_ID}
  [ -n "$applicationId" ] || throwArgument "$handler" 'Requires non-blank `--id` or `APPLICATION_ID`' || return $?
  deployHome="${deployHome:-$DEPLOY_REMOTE_HOME}"
  [ -n "$deployHome" ] || throwArgument "$handler" 'Requires non-blank `--home` or `DEPLOY_REMOTE_HOME`' || return $?
  applicationPath="${applicationPath:-$APPLICATION_REMOTE_HOME}"
  [ -n "$applicationPath" ] || throwArgument "$handler" 'Requires non-blank `--application` or `APPLICATION_REMOTE_HOME`' || return $?
  if [ ${#userHosts[@]} -eq 0 ]; then
    decorate info "Loading DEPLOY_USER_HOSTS: $DEPLOY_USER_HOSTS"
    read -r -a userHosts < <(printf "%s" "$DEPLOY_USER_HOSTS") || :
  fi
  [ ${#userHosts[@]} -gt 0 ] || throwArgument "$handler" 'No user hosts supplied on command line, `--host` or in `DEPLOY_USER_HOSTS`' || return $?
  [ -n "${userHosts[*]}" ] || throwArgument "$handler" 'Requires non-blank `--host` or `DEPLOY_USER_HOSTS`' || return $?
  targetPackage="${targetPackage:-$BUILD_TARGET}"
  [ -n "$targetPackage" ] || throwArgument "$handler" 'Requires non-blank `--target` or `BUILD_TARGET`' || return $?
  deployArgs=(--id "$applicationId" --home "${deployHome%/}" --application "${applicationPath%/}" "${userHosts[@]}")
  statusMessage decorate info "Deploying:$(printf " \"$(decorate code "%s")\"" "${deployArgs[@]}")" || :
  if $dryRun; then
    printf "\n%s %s\b" ___deployBuildEnvironment "$(printf '"%s" ' "${deployArgs[@]}")"
  else
    ___deployBuildEnvironment "${deployArgs[@]}" || return $?
    printf "\n%s\n" "$(bigText --bigger Success)" | decorate wrap --fill " " | decorate success
  fi
}
___deployBuildEnvironment() {
  local fail="${FUNCNAME[0]#_}"
  statusMessage decorate info "Deploying:$(printf " \"$(decorate code "%s")\"" "$@")" || :
  if ! deployToRemote --deploy "$@"; then
    statusMessage decorate error "Deployment failed, reverting ..." || :
    "$fail" "$@" || return $?
  fi
  if hasHook deploy-confirm && ! hookRun deploy-confirm; then
    statusMessage decorate warning "Deployment confirmation failed, reverting" || :
    "$fail" "$@" || return $?
  fi
  if ! deployToRemote --cleanup "$@"; then
    statusMessage decorate error "Deployment cleanup failed, reverting"
    "$fail" "$@" || return $?
  fi
}
__deployBuildEnvironment() {
  local handler="${FUNCNAME[0]#_}"
  if ! deployToRemote --revert "$@"; then
    decorate error "Deployment REVERT failed, system is unstable, intervention required." || :
  fi
  throwEnvironment "$handler" deployToRemote --deploy "$@" failed || return $?
}
_deployBuildEnvironment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deployRemoteFinish() {
  local handler="_${FUNCNAME[0]}"
  local targetPackage="" revertFlag=false cleanupFlag=false
  local applicationId="" applicationPath="" debuggingFlag=false deployHome="" firstFlags=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) debuggingFlag=true ;;
    --cleanup) cleanupFlag=true ;;
    --revert) revertFlag=true ;;
    --first) firstFlags+=("$argument") ;;
    --deploy)
      ! $cleanupFlag && ! $revertFlag || throwArgument "$handler" "$argument is incompatible with --cleanup and --revert" || return $?
      cleanupFlag=false
      revertFlag=false
      ;;
    --home)
      shift && deployHome=$(validate "$handler" Directory deployHome "${1-}") || return $?
      ;;
    --id)
      shift
      [ -n "${1-}" ] || throwArgument "$handler" "blank $argument $argument" || return $?
      applicationId="$1"
      ;;
    --application)
      shift
      applicationPath=$(validate "$handler" FileDirectory applicationPath "${1-}") || return $?
      ;;
    --target)
      shift
      [ -n "${1-}" ] || throwArgument "$handler" "blank $argument $argument" || return $?
      targetPackage="${1-}"
      ;;
    *) throwArgument "unknown argument: $(decorate value "$argument")" || return $? ;;
    esac
    shift || throwArgument "$handler" "missing argument $(decorate label "$argument")" || return $?
  done
  local start width name deployArguments
  local name
  for name in deployHome applicationId applicationPath; do
    if [ -z "${!name}" ]; then
      throwArgument "$handler" "$name is required" || return $?
    fi
  done
  [ -n "$targetPackage" ] || targetPackage="$(catchReturn "$handler" deployPackageName)" || return $?
  if buildDebugStart deployment; then
    debuggingFlag=true
    decorate warning "Debugging is enabled"
  fi
  if $revertFlag && $cleanupFlag; then
    throwArgument "$handler" "--cleanup and --revert are mutually exclusive" || return $?
  fi
  start=$(timingStart)
  width=50
  decorate pair $width "Host:" "$(uname -n)"
  decorate pair $width "Deployment path:" "$deployHome"
  decorate pair $width "Application path:" "$applicationPath"
  decorate pair $width "Application ID:" "$applicationId"
  if $cleanupFlag; then
    decorate info "Cleaning up ... "
    if hasHook --application "$applicationPath" deploy-cleanup; then
      catchEnvironment "$handler" hookRun --application "$applicationPath" deploy-cleanup || return $?
    else
      printf "No %s hook in %s\n" "$(decorate info "deploy-cleanup")" "$(decorate code "$applicationPath")"
    fi
  elif $revertFlag; then
    catchEnvironment "$handler" _deployRevertApplication "$deployHome" "$applicationId" "$applicationPath" "$targetPackage" || return $?
  else
    if [ -z "$applicationId" ]; then
      throwArgument "$handler" "No argument applicationId passed" || return $?
    fi
    deployArguments=(
      "${firstFlags[@]+${firstFlags[@]}}"
      --home "$deployHome"
      --id "$applicationId"
      --target "$targetPackage"
      --application "$applicationPath")
    ! $debuggingFlag || printf "%s %s\n" "RUN: deployApplication" "$(printf ' "%s"' "${deployArguments[@]}")"
    statusMessage decorate info "Deploying application ..."
    catchEnvironment "$handler" deployApplication "${deployArguments[@]}" || return $?
  fi
  statusMessage --last timingReport "$start" "Remote deployment finished in"
}
_deployRemoteFinish() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_deployRevertApplication() {
  local handler="_${FUNCNAME[0]}"
  local firstDeployment=false
  local deployHome="" applicationId="" applicationPath="" targetPackage=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --first)
      firstDeployment=true
      ;;
    *) if
      [ -z "$deployHome" ]
    then
      deployHome=$(validate "$handler" Directory deployHome "$1") || return $?
    elif [ -z "$applicationId" ]; then
      applicationId="$1"
    elif [ -z "$applicationPath" ]; then
      applicationPath=$(validate "$handler" Directory applicationPath "$1") || return $?
    elif [ -z "$targetPackage" ]; then
      targetPackage="$1"
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift || :
  done
  [ -n "$targetPackage" ] || targetPackage="$(catchReturn "$handler" deployPackageName)" || return $?
  local name
  for name in deployHome applicationId applicationPath; do
    if [ -z "${!name}" ]; then
      throwArgument "$handler" "$name is required" || return $?
    fi
  done
  local previousChecksum
  if ! previousChecksum=$(deployPreviousVersion "$deployHome" "$applicationId") || [ -z "$previousChecksum" ]; then
    if ! "$firstDeployment"; then
      throwEnvironment "$handler" "Unable to get previous checksum for $applicationId" || return $?
    fi
  else
    printf "%s %s -> %s\n" "$(decorate info "Reverting installation")" "$(decorate orange "$applicationId")" "$(decorate green "$previousChecksum")"
    if ! deployApplication --revert --home "$deployHome" --id "$applicationId" --application "$applicationPath" --target "$targetPackage"; then
      throwEnvironment "$handler" "Undo deployment to $previousChecksum failed $applicationPath - system is unstable" || return $?
    fi
  fi
  if ! hookRunOptional deploy-revert "$deployHome" "$applicationId"; then
    printf "%s %s\n" "$(decorate code "deploy-revert")" "$(decorate error "hook failed, continuing anyway")"
  fi
  decorate success "Application successfully reverted to version $(decorate code "$applicationId")" || :
  return 0
}
__deployRevertApplication() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__deployedHostArtifact() {
  printf "%s\n" "./.deployed-hosts"
}
_deploySuccessful() {
  bigText Deployed AOK | decorate green
  echo
  decorate warning "No $(__deployedHostArtifact) file found ..."
  decorate success "Nothing deployed or clean exit."
}
deployToRemote() {
  local handler="_${FUNCNAME[0]}"
  local initTime
  catchReturn "$handler" buildEnvironmentLoad HOME BUILD_DEBUG || return $?
  initTime=$(timingStart)
  [ -d "$HOME" ] || throwEnvironment "$handler" "No HOME defined or not a directory: $HOME" || return $?
  local deployFlag=false revertFlag=false debuggingFlag=false cleanupFlag=false
  local userHosts=() applicationId="" deployHome="" applicationPath="" buildTarget="" remoteArgs=() firstFlags=() addSSHHosts=true showCommands=false currentIP=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --target)
      shift
      [ -z "$buildTarget" ] || throwArgument "$handler" "$argument supplied twice" || return $?
      buildTarget="$1"
      ;;
    --skip-ssh-host)
      addSSHHosts=false
      ;;
    --add-ssh-host)
      addSSHHosts=true
      ;;
    --home)
      shift
      [ -z "$deployHome" ] || throwArgument "$handler" "$argument supplied twice" || return $?
      deployHome="$1"
      ;;
    --first)
      firstFlags+=("$argument")
      ;;
    --application)
      shift
      [ -z "$applicationPath" ] || throwArgument "$handler" "$argument supplied twice" || return $?
      applicationPath="$1"
      ;;
    --ip)
      shift
      currentIP=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --id)
      shift
      [ -z "$applicationId" ] || throwArgument "$handler" "$argument supplied twice" || return $?
      applicationId="$1"
      ;;
    --deploy)
      if
        "$deployFlag"
      then
        throwArgument "$handler" "--deploy arg passed twice" || return $?
      fi
      deployFlag=true
      remoteArgs+=("$1")
      ;;
    --revert)
      if
        "$revertFlag"
      then
        throwArgument "$handler" "--revert specified twice" || return $?
      fi
      revertFlag=true
      remoteArgs+=("$1")
      ;;
    --cleanup)
      if
        "$cleanupFlag"
      then
        throwArgument "$handler" "--cleanup specified twice" || return $?
      fi
      cleanupFlag=true
      remoteArgs+=("$1")
      ;;
    --debug)
      debuggingFlag=true
      ;;
    --commands)
      showCommands=true
      addSSHHosts=false
      ;;
    *) IFS=' ' read -r -a userHosts <<<"$1" || : ;;
    esac
    shift
  done
  if buildDebugStart deployment; then
    debuggingFlag=true
    decorate warning "Debugging is enabled"
  fi
  if "$revertFlag" && "$cleanupFlag"; then
    throwArgument "$handler" "--revert and --cleanup are mutually exclusive" || return $?
  fi
  if "$revertFlag" && "$deployFlag"; then
    throwArgument "$handler" "--revert and --deploy are mutually exclusive" || return $?
  fi
  if "$deployFlag" && "$cleanupFlag"; then
    throwArgument "$handler" "--deploy and --cleanup are mutually exclusive" || return $?
  fi
  [ -n "$applicationId" ] || throwArgument "$handler" "missing applicationId" || return $?
  [ -n "$deployHome" ] || throwArgument "$handler" "missing deployHome" || return $?
  [ -n "$applicationPath" ] || throwArgument "$handler" "missing applicationPath" || return $?
  if [ -z "$buildTarget" ]; then
    buildTarget=$(catchReturn "$handler" deployPackageName) || return $?
  fi
  if [ 0 -eq ${#userHosts[@]} ]; then
    throwArgument "$handler" "No user hosts provided" || return $?
  fi
  currentIP=$(catchEnvironment "$handler" ipLookup) || throwEnvironment "$handler" "Unable to determine IP address" || return $?
  [ -n "$currentIP" ] || throwEnvironment "$handler" "IP address lookup blank" || return $?
  if $addSSHHosts; then
    for userHost in "${userHosts[@]}"; do
      host="${userHost##*@}"
      catchEnvironment "$handler" sshKnownHostAdd "$host" || return $?
    done
  fi
  local verb color deployArg temporaryCommandsFile commonArguments
  temporaryCommandsFile=$(fileTemporaryName "$handler") || return $?
  commonArguments=("${firstFlags[@]+${firstFlags[@]}}" "--target" "$buildTarget" "--home" "$deployHome" "--id" "$applicationId" "--application" "$applicationPath")
  if $revertFlag; then
    verb=Revert
    color=orange
    deployArg=--revert
  elif $cleanupFlag; then
    applicationPath="$deployHome/$applicationId/app"
    verb="Clean up"
    color="blue"
    deployArg=--cleanup
  else
    local commandSuffix=""
    if
      ! __deployCommandsFile "$deployHome/$applicationId/app" \
        "printf '%s' \"Sweeping stage for $applicationId\" && rm -rf \"$deployHome/$applicationId/app.$$\"$commandSuffix" \
        "printf '%s\n' \"Setting stage for $applicationId\" && mkdir \"$deployHome/$applicationId/app.$$\"$commandSuffix" \
        "printf '%s\n' \"Opening package for $applicationId\" && tar -C \"$deployHome/$applicationId/app.$$\" -zxf \"$deployHome/$applicationId/$buildTarget\" --no-xattrs$commandSuffix" \
        "printf '%s\n' \"Hiding old $applicationId package\" && [ ! -d \"$deployHome/$applicationId/app\" ] || mv -f \"$deployHome/$applicationId/app\" \"$deployHome/$applicationId/app.$$.REPLACING\"$commandSuffix" \
        "printf '%s\n' \"Moving new $applicationId package\" && mv -f \"$deployHome/$applicationId/app.$$\" \"$deployHome/$applicationId/app\"$commandSuffix" \
        "printf '%s\n' \"Cleaning old $applicationId package\" && rm -rf \"$deployHome/$applicationId/app.$$.REPLACING\"$commandSuffix" \
        "--deploy" "${commonArguments[@]}" >"$temporaryCommandsFile"
    then
      throwEnvironment "$handler" "Generating commands file for $buildTarget expansion" || return $?
    fi
    if $showCommands; then
      cat "$temporaryCommandsFile"
      rm "$temporaryCommandsFile" || :
      return 0
    fi
    verb="Deploy"
    bigText "$verb" | decorate green
    local nameWidth=50
    {
      decorate pair $nameWidth "Current IP:" "$currentIP"
      decorate pair $nameWidth "Deploy Home:" "$deployHome"
      decorate pair $nameWidth "Application Path:" "$applicationPath"
      decorate pair $nameWidth "Application ID:" "$applicationId"
      decorate pair $nameWidth "Package:" "$buildTarget"
      for userHost in "${userHosts[@]}"; do
        decorate pair $nameWidth "Host:" "$userHost"
      done
    } || :
    local artifactFile
    artifactFile="$(__deployedHostArtifact)"
    printf "" >"$artifactFile"
    __deployUploadPackage "$handler" "$applicationPath" "$deployHome/$applicationId" "$buildTarget" "${userHosts[@]}" || return $?
    for userHost in "${userHosts[@]}"; do
      local start
      start=$(timingStart) || :
      host="${userHost##*@}"
      printf "%s %s: %s\n%s\n" "$(decorate info "Deploying the code to")" "$(decorate green "$userHost")" "$(decorate red "$applicationPath")" "$(decorate info "$host output BEGIN :::")"
      if buildDebugEnabled; then
        decorate info "DEBUG: Commands file is:"
        decorate code <"$temporaryCommandsFile"
      fi
      if ! ssh "$(__deploySSHOptions)" -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile" | decorate cyan | decorate wrap "$(decorate orange "$userHost"): "; then
        throwEnvironment "$handler" "Unable to deploy to $host" || return $?
      fi
      decorate info "::: END $host output"
      printf "%s\n" "$host" >>"$artifactFile" || throwEnvironment "$handler" "Unable to write $host to $artifactFile" || return $?
      statusMessage timingReport "$start" "Deployed to $(decorate green "$userHost")" || :
    done
    statusMessage --last timingReport "$initTime" "Deploy completed in" || :
    return 0
  fi
  catchReturn "$handler" __deployCommandsFile "$deployHome/$applicationId/app" "$deployArg" "${commonArguments[@]}" >"$temporaryCommandsFile" || return $?
  if $showCommands; then
    catchEnvironment "$handler" cat "$temporaryCommandsFile" || return $?
    rm -rf "$temporaryCommandsFile" || :
    return 0
  fi
  bigText "$verb" | decorate BOLD "$color"
  if [ ! -f "$artifactFile" ]; then
    if $revertFlag; then
      _deploySuccessful
      return 0
    else
      throwEnvironment "$handler" "$(decorate file "$artifactFile") file NOT found ... no remotes changed" || return $?
    fi
  fi
  local exitCode
  exitCode=0
  for userHost in "${userHosts[@]}"; do
    start=$(timingStart)
    host="${userHost##*@}"
    if grep -q "$host" "$artifactFile"; then
      printf "%s %s (%s) " "$(decorate success "$verb")" "$(decorate code "$userHost")" "$(decorate BOLD red "$applicationPath")"
      if ! ssh -T "$userHost" bash --noprofile -s -e <"$temporaryCommandsFile"; then
        printf "%s %s %s\n" "$(decorate error "$verb failed on")" "$(decorate code "$userHost")" "$(decorate error "- continuing")"
        exitCode=1
      fi
    else
      printf "%s %s\n" "$(decorate code "$host")" "$(decorate success "no artifact, so no $verb")"
    fi
    timingReport "$start" "$verb $(decorate value "$host") in"
  done
  buildDebugStop deployment || :
  statusMessage --last timingReport "$initTime" "All ${#userHosts[@]} $(plural ${#userHosts[@]} host hosts) completed" || :
  return "$exitCode"
}
_deployToRemote() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__deployCommandsFile() {
  local appHome
  if buildDebugEnabled; then
    printf "%s\n%s\n" "export BUILD_DEBUG=1" "set -vx"
  fi
  appHome="$1"
  shift || :
  while [ $# -gt 0 ]; do
    case "$1" in
    -*)
      break
      ;;
    *) printf "%s || exit \$?\n" "$1" ;;
    esac
    shift || :
  done
  printf -- "cd \"%s\" || exit \$?\n" "$appHome"
  printf -- "%s/bin/build/tools.sh execute deployRemoteFinish %s|| exit \$?\n" "$appHome" "$(printf '"%s" ' "$@")" || return $?
}
__deploySSHOptions() {
  if buildDebugEnabled ssh; then
    printf %s "-v"
  elif buildDebugEnabled ssh-debug; then
    printf %s "-vvv"
  else
    printf %s "-q"
  fi
}
__deployUploadPackage() {
  local start userHost
  local handler="$1" applicationPath="$2" remotePath="$3" buildTarget="$4"
  shift 4 || :
  for userHost in "$@"; do
    start=$(timingStart) || :
    printf "%s: %s\n" "$(decorate green "$userHost")" "$(decorate info "Setting up")"
    catchEnvironment "$handler" ssh "$(__deploySSHOptions)" -T "$userHost" bash --noprofile -s -e < <(__deployCreateDirectoryCommands "$applicationPath" "$remotePath") || return $?
    printf "%s: %s %s\n" "$(decorate green "$userHost")" "$(decorate info "Uploading to")" "$(decorate red "$remotePath/$buildTarget")"
    if ! printf -- '@put %s %s' "$buildTarget" "$remotePath/$buildTarget" | sftp "$(__deploySSHOptions)" "$userHost" 2>/dev/null; then
      throwEnvironment "$handler" "Upload $remotePath/$buildTarget to $userHost failed " || return $?
    fi
    timingReport "$start" "Deployment setup completed on $(decorate green "$userHost") in " || :
  done
}
__deployCreateDirectoryCommands() {
  while [ $# -gt 0 ]; do
    printf -- 'if [ ! -d "%s" ]; then mkdir -p "%s" && echo "Created %s"; fi\n' "$1" "$1" "$1"
    shift
  done
}
dockerPlatformDefault() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local os=linux chip
  case "$(uname -m)" in
  *arm*) chip=arm64 ;;
  *mips*) chip=mips64 ;;
  *x86* | *amd*) chip=amd64 ;;
  *) chip=default ;;
  esac
  printf -- "%s/%s" "$os" "$chip"
}
_dockerPlatformDefault() {
  true || dockerPlatformDefault --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__dumpDockerTestFile() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local proc1File=/proc/1/sched
  if [ -f "$proc1File" ]; then
    bigText $proc1File
    decorate magenta <"$proc1File"
  else
    decorate warning "Missing $proc1File"
  fi
}
___dumpDockerTestFile() {
  true || dumpDockerTestFile --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerInside() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  if [ ! -f /proc/1/cmdline ]; then
    return 1
  fi
  if grep -q init /proc/1/cmdline; then
    return 1
  fi
  return 0
}
_dockerInside() {
  true || dockerInside --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerListContext() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf 'FROM scratch\nCOPY . /\n' | DOCKER_BUILDKIT=1 docker build -q -f- -o- . | tar t
}
_dockerListContext() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerLocalContainer() {
  local handler="_${FUNCNAME[0]}"
  local localPath=""
  local exitCode=0 ee=() extraArgs=() tempEnvs=() verboseFlag=false envFiles=()
  local platform="" imageName="" imageApplicationPath=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --image) shift && imageName=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --local) shift && localPath=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --verbose) verboseFlag=true ;;
    --path)
      shift
      imageApplicationPath=$(validate "$handler" String "$argument" "${1-}") || return $?
      envFiles+=("-w" "$imageApplicationPath")
      ;;
    --env)
      local envPair
      shift
      envPair=$(validate "$handler" String "$argument" "${1-}") || return $?
      if [ "${envPair#*=}" = "$envPair" ]; then
        decorate warning "$argument does not look like a variable: $(decorate error "$envPair")" 1>&2
      fi
      ee+=("$argument" "$envPair")
      ;;
    --env-file)
      local envFile tempEnv
      shift
      envFile=$(validate "$handler" File "envFile" "$1") || return $?
      tempEnv=$(fileTemporaryName "$handler") || return $?
      catchArgument "$handler" environmentFileToDocker "$envFile" >"$tempEnv" || return $?
      tempEnvs+=("$tempEnv")
      ee+=("$argument" "$tempEnv")
      ;;
    --platform) shift && platform=$(validate "$handler" String "$argument" "$1") || return $? ;;
    *)
      extraArgs+=("$@")
      break
      ;;
    esac
    shift
  done
  export BUILD_DOCKER_PLATFORM BUILD_DOCKER_PATH BUILD_DOCKER_IMAGE
  catchReturn "$handler" buildEnvironmentLoad BUILD_DOCKER_PLATFORM BUILD_DOCKER_IMAGE BUILD_DOCKER_PATH || return $?
  [ -n "$platform" ] || platform=${BUILD_DOCKER_PLATFORM-}
  [ -n "$imageApplicationPath" ] || imageApplicationPath=${BUILD_DOCKER_PATH-}
  [ -n "$imageName" ] || imageName=${BUILD_DOCKER_IMAGE-}
  [ -n "$platform" ] || platform=$(dockerPlatformDefault)
  if [ -z "$localPath" ]; then
    localPath=$(catchEnvironment "$handler" pwd) || return $?
  fi
  local failedWhy=""
  if [ -z "$imageName" ]; then
    failedWhy="imageName is empty"
  elif [ -z "$imageApplicationPath" ]; then
    failedWhy="imageApplicationPath is empty"
  elif ! executableExists docker; then
    failedWhy="docker does not exist in path"
  fi
  if [ -n "$failedWhy" ]; then
    [ ${#tempEnvs[@]} -eq 0 ] || rm -f "${tempEnvs[@]}" || :
    throwEnvironment "$handler" "$failedWhy" || return $?
  fi
  local tt=()
  [ ! -t 0 ] || tt=(-it)
  if [ -z "$(dockerImages --filter "$imageName" 2>/dev/null || :)" ]; then
    ! $verboseFlag || statusMessage decorate info "Pulling $imageName ..."
    catchEnvironment "$handler" muzzle docker pull "$imageName" || return $?
  fi
  local start
  start=$(timingStart)
  ! $verboseFlag || statusMessage decorate info "Running $imageName on $platform ..."
  catchEnvironment "$handler" docker run "${ee[@]+"${ee[@]}"}" --platform "$platform" -v "$localPath:$imageApplicationPath" "${tt[@]+"${tt[@]}"}" --pull never "$imageName" "${extraArgs[@]+"${extraArgs[@]}"}" || exitCode=$?
  ! $verboseFlag || statusMessage timingReport "$start" "$imageName ($platform) completed in"
  [ ${#tempEnvs[@]} -eq 0 ] || rm -f "${tempEnvs[@]}" || :
  return $exitCode
}
_dockerLocalContainer() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerImages() {
  local handler="_${FUNCNAME[0]}"
  local filter=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --filter)
      shift
      [ 0 -eq "${#filter[@]}" ] || throwArgument "$handler" "--filter passed twice: #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
      filter+=("--filter" "reference=$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" docker || return $?
  docker images "${filter[@]+"${filter[@]}"}" | awk '{ print $1 ":" $2 }' | grep -v 'REPOSITORY:'
}
_dockerImages() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerVolumeExists() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  [ $# -eq 1 ] || throwArgument "$handler" "Requires a volume name" || return $?
  docker volume ls --format json | jq .Name | grep -q "$1"
}
_dockerVolumeExists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerVolumeDelete() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  [ $# -eq 1 ] || throwArgument "$handler" "Requires a volume name" || return $?
  docker volume ls --format json | jq .Name | grep -q "$1"
}
_dockerVolumeDelete() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__dockerVolumeDeleteInteractive() {
  local handler="$1" databaseVolume="$2" && shift 2
  local running=false suffix=""
  if dockerComposeIsRunning; then
    running=true
    suffix=" (container will also be shut down)"
  fi
  if dockerVolumeExists "$databaseVolume"; then
    if confirmYesNo --no --timeout 60 --info "Delete database volume $(decorate code "$databaseVolume")$suffix?"; then
      if $running; then
        statusMessage decorate info "Bringing down container ..."
        catchEnvironment "$handler" docker compose down --remove-orphans || return $?
      fi
      __dockerVolumeDelete "$handler" "$databaseVolume" || return $?
    fi
  fi
}
__dockerVolumeDelete() {
  local handler="$1" databaseVolume="$2" && shift 2
  catchEnvironment "$handler" docker volume rm "$databaseVolume" || return $?
}
dockerComposeWrapper() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  executableExists docker || throwEnvironment "$handler" "Missing docker binary" || return $?
  if muzzle docker compose --help; then
    catchEnvironment "$handler" docker compose "$@" || return $?
  else
    executableExists docker-compose || throwEnvironment "$handler" "Missing docker-compose binary" || return $?
    catchEnvironment "$handler" docker-compose "$@" || return $?
  fi
}
_dockerComposeWrapper() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerComposeInstall() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  executableExists docker || throwEnvironment "$handler" "Missing docker binary" || return $?
  if muzzle docker compose --help; then
    return 0
  fi
  local name="docker-compose"
  if pythonPackageInstalled "$name"; then
    return 0
  fi
  pipInstall --handler "$handler" "$name" "$@"
}
_dockerComposeInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerComposeUninstall() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if muzzle docker compose --help; then
    return 0
  fi
  local name="docker-compose"
  if ! pythonPackageInstalled "$name"; then
    return 0
  fi
  pipUninstall --handler "$handler" "$name" || return $?
}
_dockerComposeUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerComposeIsRunning() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local temp
  temp=$(fileTemporaryName "$handler") || return $?
  __dockerCompose "$handler" ps --format json >"$temp" || returnClean $? "$temp" || return $?
  local exitCode=1
  fileIsEmpty "$temp" || exitCode=0
  catchEnvironment "$handler" rm -rf "$temp" || return $?
  return $exitCode
}
_dockerComposeIsRunning() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerComposeCommandList() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf -- "%s\n" attach build commit config cp create down events exec export images kill logs ls pause port ps pull push restart rm run scale start stats stop top unpause up version wait watch | sort -u
}
_dockerComposeCommandList() {
  ! false || dockerComposeCommandList --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isDockerComposeCommand() {
  local handler="_${FUNCNAME[0]}" command="${1-}"
  [ -n "$command" ] || throwArgument "$handler" "command is blank" || return $?
  if [ "$command" = "--help" ]; then
    "$handler" 0
    return $?
  fi
  grep -q -e "$(quoteGrepPattern "$command")" < <(dockerComposeCommandList)
}
_isDockerComposeCommand() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dockerCompose() {
  local handler="_${FUNCNAME[0]}"
  local deployment="" aa=()
  local buildFlag=false deleteVolumes=false keepVolumes="" keepVolumesDefault=false debugFlag=false
  local databaseVolume="" requiredEnvironment=() requiredArguments=() command=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --debug)
      debugFlag=true
      ;;
    --production)
      deployment="production"
      ;;
    --staging)
      deployment="staging"
      ;;
    --deployment)
      shift
      deployment="$(validate "$handler" String "$argument" "${1-}")" || return $?
      deployment="$(uppercase "$deployment")"
      ! $debugFlag || decorate info "Deployment set to $deployment"
      ;;
    --volume)
      shift
      databaseVolume=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --clean)
      deleteVolumes=true
      ;;
    --keep)
      deleteVolumes=false
      keepVolumes=true
      ;;
    --build)
      command="build"
      ;;
    --arg | --default-env | --env)
      local environmentPair
      shift
      environmentPair="$(validate "$handler" String "$argument" "${1-}")" || return $?
      local name="${environmentPair%%=*}" value="${environmentPair#*=}"
      ! $debugFlag || decorate info "Variable $argument supplied $(decorate pair "$name" "$value")"
      name="$(validate "$handler" EnvironmentVariable "$argument" "$name")" || return $?
      if [ "$argument" = "--arg" ]; then
        if [ -z "$value" ]; then
          requiredArguments+=("$name")
        else
          aa+=("--build-arg" "$environmentPair")
        fi
      else
        requiredEnvironment+=("$name" "$value")
      fi
      ;;
    db)
      aa+=("$argument")
      keepVolumesDefault=false
      ;;
    web)
      keepVolumesDefault=true
      aa+=("$argument")
      ;;
    *)
      [ -z "$command" ] || throwArgument "$handler" "$command already specified ($argument)" || return $?
      if isDockerComposeCommand "$argument"; then
        command="$argument"
        shift
        break
      fi
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  [ -n "$deployment" ] || deployment="staging"
  [ -n "$keepVolumes" ] || keepVolumes=$keepVolumesDefault
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  if [ -z "$databaseVolume" ]; then
    local dockerName
    dockerName=$(basename "$home")
    databaseVolume="${dockerName}_database_data"
  fi
  local start
  start=$(timingStart)
  if [ -z "$command" ]; then
    throwArgument "$handler" "Need a docker command:"$'\n'"- $(dockerComposeCommandList | decorate each code)" || return $?
  fi
  [ "$command" != "build" ] || buildFlag=true
  aa=("$command" "${aa[@]+"${aa[@]}"}")
  __dockerComposeEnvironmentSetup "$handler" "$home" "$debugFlag" "$deployment" "${requiredEnvironment[@]+"${requiredEnvironment[@]}"}" DEPLOYMENT "$deployment" || return $?
  local argument
  [ "${#requiredArguments[@]}" -eq 0 ] || while read -r argument; do aa+=("$argument"); done < <(__dockerComposeArgumentSetup "$handler" "$home" "${requiredArguments[@]}") || return $?
  if $buildFlag; then
    if $deleteVolumes; then
      ! $debugFlag || decorate info "--clean supplied so deleting volumes"
      if dockerVolumeExists "$databaseVolume"; then
        ! $debugFlag || decorate info "$databaseVolume volume exists, deleting"
        __dockerVolumeDelete "$handler" "$databaseVolume" || return $?
        statusMessage decorate warning "Deleted volume $(decorate code "$databaseVolume") - will be created with new environment variables"
      else
        decorate info "Volume $(decorate code "$databaseVolume") does not exist"
      fi
    elif $keepVolumes; then
      ! $debugFlag || decorate info "--keep supplied, no deletion"
      if dockerVolumeExists "$databaseVolume"; then
        decorate info "Keeping volume $(decorate code "$databaseVolume")"
      fi
    else
      ! $debugFlag || decorate info "__dockerVolumeDeleteInteractive"
      __dockerVolumeDeleteInteractive "$handler" "$databaseVolume" || return $?
    fi
  fi
  [ $# -eq 0 ] || aa+=("$@")
  ! $debugFlag || decorate info "Running" "$(decorate label "docker compose")" "$(decorate each code "${aa[@]+"${aa[@]}"}")"
  __dockerCompose "$handler" "${aa[@]+"${aa[@]}"}" || return $?
  local name
  name="$(decorate label "$(buildEnvironmentGet APPLICATION_NAME)")"
  statusMessage --last timingReport "$start" "Completed $name in"
}
_dockerCompose() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__dockerCompose() {
  local handler="$1" home && shift
  home=$(catchReturn "$handler" buildHome) || return $?
  [ -f "$home/docker-compose.yml" ] || throwEnvironment "$handler" "Missing $(decorate file "$home/docker-compose.yml")" || return $?
  COMPOSE_BAKE=true docker compose -f "$home/docker-compose.yml" "$@"
}
__dockerComposeEnvironmentSetup() {
  local handler="$1" && shift
  local home="$1" && shift
  local debugFlag="$1" && shift
  local deployment="$1" && shift
  local deploymentEnv envFile
  deploymentEnv=".$(uppercase "$deployment").env"
  [ -f "$home/$deploymentEnv" ] || throwEnvironment "$handler" "Missing $deploymentEnv" || return $?
  envFile="$home/.env"
  if [ -f "$envFile" ]; then
    local checkEnv
    while read -r checkEnv; do
      if muzzle diff -q "$envFile" "$checkEnv"; then
        ! $debugFlag || statusMessage decorate warning "Deleting $(decorate file "$envFile")"
        catchEnvironment "$handler" rm -f "$envFile" || return $?
        break
      fi
    done < <(find "$home" -maxdepth 1 -name ".*.env")
  fi
  if [ -f "$envFile" ]; then
    local backupFile
    backupFile="$home/.$(date '+%F_%T').env"
    statusMessage decorate warning "Backing up $(decorate file "$envFile") to ... $(decorate file "$backupFile")"
    catchEnvironment "$handler" cp "$envFile" "$backupFile" || return $?
  fi
  ! $debugFlag || statusMessage decorate warning "Rewriting $(decorate file "$envFile") <- (copy from $deploymentEnv)"
  catchEnvironment "$handler" cp "$deploymentEnv" "$envFile" || return $?
  catchEnvironment "$handler" printf -- "%s\n" "" "# Adding values" >>"$envFile" || return $?
  local icon="⬅"
  while [ $# -gt 1 ]; do
    local variable="$1" value="$2" envValue
    envValue=$(environmentValueRead "$envFile" "$variable") || :
    if [ -z "$envValue" ]; then
      statusMessage decorate info "Appending $(decorate file "$envFile") $icon $(decorate code "$variable") $(decorate value "$value") (default)"
      catchReturn "$handler" environmentValueWrite "$variable" "$value" >>"$envFile" || return $?
    else
      ! $debugFlag || statusMessage decorate warning "Skipping $(decorate code "$variable")=$(decorate value "$envValue") ($(decorate magenta "$value"))"
    fi
    shift 2 || :
  done
}
__dockerComposeArgumentSetup() {
  local handler="$1" && shift
  local home="$1" && shift
  local envFile="$home/.env"
  local icon="⬅"
  while [ $# -gt 0 ]; do
    local variable="$1" envValue
    envValue=$(environmentValueRead "$envFile" "$variable") || :
    if [ -z "$envValue" ]; then
      throwArgument "$handler" "$envFile does not have a variable $variable" || return $?
    fi
    printf "%s\n" "--build-arg" "$variable=$envValue"
    shift
  done
}
__documentationLoader() {
  __buildFunctionLoader __bashDocumentationExtract documentation "$@" || return $?
}
bashDocumentationExtract() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashDocumentationExtract() {
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationBuild() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationBuild() {
  case "${1-}" in 0 | 2 | "") ;; *) hookRunOptional documentation-error "$@" || : ;; esac
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationUnlinked() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationUnlinked() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationTemplate() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local source="${BASH_SOURCE[0]%.sh}"
  local template="$source/__${1-}.md"
  [ -f "$template" ] || returnArgument "No template \"${1-}\" at $template" || return $?
  printf "%s\n" "$template"
}
_documentationTemplate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationBuildEnvironment() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationBuildEnvironment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationBuildCache() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local code
  code=$(catchReturn "$handler" buildEnvironmentGet "APPLICATION_CODE") || return $?
  catchReturn "$handler" buildCacheDirectory ".documentation/${code-default}/${1-}" || return $?
}
_documentationBuildCache() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationTemplateUpdate() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationTemplateUpdate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationTemplateCompile() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationTemplateCompile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationTemplateDirectoryCompile() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationTemplateDirectoryCompile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationTemplateFunctionCompile() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationTemplateFunctionCompile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__bashDocumentationDefaultArguments() {
  printf "%s\n" "$*" | sed 's/ - /^/1' | __documentationFormatArguments '^' '' ''
}
__documentationFormatArguments() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ $# -le 3 ] || throwArgument "$handler" "Requires 3 or fewer arguments" || return $?
  local separatorChar="${1-" "}" optionalDecoration="${2-blue}" requiredDecoration="${3-magenta}"
  local lineTokens=() lastLine=false
  while true; do
    if ! IFS="$separatorChar" read -r -a lineTokens; then
      lastLine=true
    fi
    if [ ${#lineTokens[@]} -gt 0 ]; then
      local __value="${lineTokens[0]}"
      unset "lineTokens[0]"
      lineTokens=("${lineTokens[@]+${lineTokens[@]}}")
      local __description
      __description=$(lowercase "${lineTokens[*]-}")
      if [ "${__description%*required.*}" = "$__description" ]; then
        __value="[ $__value ]"
        [ -z "$optionalDecoration" ] || __value="$(decorate "$optionalDecoration" "$__value")"
      else
        [ -z "$requiredDecoration" ] || __value="$(decorate BOLD "$requiredDecoration" "$__value")"
      fi
      printf " %s" "$__value"
    fi
    if $lastLine; then
      break
    fi
  done
}
___documentationFormatArguments() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationIndexLookup() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationIndexLookup() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationIndexDocumentation() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationIndexDocumentation() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__bashDocumentation_FindFunctionDefinitions() {
  local handler="_${FUNCNAME[0]}"
  local directory
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  directory=$(validate "$handler" Directory "directory" "${1-}") && shift || return $?
  local foundCount=0 phraseCount=${#@}
  while [ "$#" -gt 0 ]; do
    local fn=$1 escaped
    escaped=$(quoteGrepPattern "$fn")
    local functionPattern="^$escaped\(\) \{|^function $escaped \{"
    if find "$directory" -type f -name '*.sh' ! -path "*/.*/*" -print0 | xargs -0 grep -l -E "$functionPattern"; then
      foundCount=$((foundCount + 1))
    fi
    shift
  done
  [ "$phraseCount" -eq "$foundCount" ]
}
___bashDocumentation_FindFunctionDefinitions() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deprecatedFilePrependVersion() {
  local handler="_${FUNCNAME[0]}"
  local target="" version=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$target" ]
    then
      target="$(validate "$handler" File "target" "${1-}")" || return $?
    elif [ -z "$version" ]; then
      version="$(validate "$handler" String "version" "$1")" || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$target" ] || throwArgument "$handler" "Missing target" || return $?
  [ -n "$version" ] || throwArgument "$handler" "Missing version" || return $?
  local newTarget
  newTarget=$(fileTemporaryName "$handler") || returnClean $? "$newTarget" || return $?
  catchEnvironment "$handler" printf -- "%s\n\n" "# $version" >"$newTarget" || returnClean $? "$newTarget" || return $?
  catchEnvironment "$handler" cat "$target" >>"$newTarget" || returnClean $? "$newTarget" || return $?
  catchEnvironment "$handler" mv -f "$newTarget" "$target" || returnClean $? "$newTarget" || return $?
}
_deprecatedFilePrependVersion() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deprecatedIgnore() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local notes
  export __BUILD_DEPRECATED_EXTRAS
  isArray __BUILD_DEPRECATED_EXTRAS || __BUILD_DEPRECATED_EXTRAS=()
  notes=$(catchReturn "$handler" buildEnvironmentGet BUILD_RELEASE_NOTES) || return $?
  if [ -z "$notes" ]; then
    throwEnvironment "$handler" "BUILD_RELEASE_NOTES is blank?" || return $?
  fi
  notes="${notes#.}"
  notes="${notes#/}"
  notes="${notes%/}"
  printf -- "%s\n" \
    ! -name 'deprecated*.txt' \
    ! -name 'deprecated.sh' \
    ! -name 'deprecated*.md' \
    ! -name 'unused.md' \
    ! -path "*$notes/*" \
    ! -path "*/.*/*" \
    "${__BUILD_DEPRECATED_EXTRAS[@]+"${__BUILD_DEPRECATED_EXTRAS[@]}"}"
}
_deprecatedIgnore() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deprecatedTokensFile() {
  local handler="_${FUNCNAME[0]}"
  local findArgumentFunction="" files=() cannonPath=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --path)
      shift
      cannonPath=$(validate "$handler" Directory "$argument cannonPath" "${1-}") || return $?
      ;;
    *) if
      [ -z "$findArgumentFunction" ]
    then
      findArgumentFunction=$(validate "$handler" function "ignoreFunction" "$1") || return $?
    else
      files+=("$(validate "$handler" File "cannonFile" "$1")") || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$findArgumentFunction" ] || throwArgument "$handler" "findArgumentFunction required" || return $?
  [ -n "$cannonPath" ] || cannonPath=$(catchReturn "$handler" buildHome) || return $?
  local line tokens=()
  local exitCode=0 start results comment="" commentText="(start of file)"
  start=$(timingStart)
  results=$(fileTemporaryName "$handler") || return $?
  while read -r line; do
    comment="${line#\#}"
    if [ "$comment" != "$line" ]; then
      comment=$(trimSpace "$comment")
      commentText="$(decorate info "$(buildEnvironmentGet APPLICATION_NAME)") $(decorate label "$comment")"
      statusMessage printf "%s\n" "$commentText ..."
      continue
    fi
    IFS="|" read -r -a tokens <<<"$line" || :
    if [ "${#tokens[@]}" -gt 0 ]; then
      statusMessage decorate info "$commentText deprecated tokens: $(decorate each code "${tokens[@]}") ..."
      if deprecatedFind "$findArgumentFunction" "${tokens[@]}" >"$results"; then
        statusMessage --last decorate error "$commentText token found: $(decorate each code "${tokens[@]}")"
        decorate code <"$results"
        exitCode=1
      fi
    fi
  done < <(cat "${files[@]+"${files[@]}"}")
  catchEnvironment "$handler" rm -rf "$results" || return $?
  statusMessage --last timingReport "$start" "Deprecated token scan took"
}
_deprecatedTokensFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deprecatedCannonFile() {
  local handler="_${FUNCNAME[0]}"
  local findArgumentFunction="" files=() cannonPath=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --path)
      shift
      cannonPath=$(validate "$handler" Directory "$argument cannonPath" "${1-}") || return $?
      ;;
    *) if
      [ -z "$findArgumentFunction" ]
    then
      findArgumentFunction=$(validate "$handler" function "ignoreFunction" "$1") || return $?
    else
      files+=("$(validate "$handler" File "cannonFile" "$1")") || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$findArgumentFunction" ] || throwArgument "$handler" "findArgumentFunction required" || return $?
  [ -n "$cannonPath" ] || cannonPath=$(catchReturn "$handler" buildHome) || return $?
  local start
  start=$(catchReturn "$handler" timingStart) || return $?
  local exitCode=0 version="No version yet"
  while read -r line; do
    local IFS tokens=() trimmed
    trimmed=$(catchEnvironment "$handler" trimSpace "$line") || return $?
    [ -n "$trimmed" ] || continue
    if [ "${trimmed:0:1}" = "#" ]; then
      version="$(catchEnvironment "$handler" trimSpace "${trimmed:1}")" || return $?
      continue
    fi
    IFS="|" read -r -a tokens <<<"$line" || :
    if [ "${#tokens[@]}" -le 1 ]; then
      decorate error "Bad line: $line" || :
      exitCode=1
      continue
    fi
    statusMessage --first printf -- "%s: %s -> %s %s" "$(decorate BOLD magenta "$version")" "$(decorate code "${tokens[0]}")" "$(decorate code "${tokens[1]}")"
    if ! deprecatedCannon --path "$cannonPath" "$findArgumentFunction" "${tokens[@]}"; then
      printf -- "\n"
      exitCode=1
    fi
  done < <(cat "${files[@]+"${files[@]}"}")
  statusMessage --last timingReport "$start" "Deprecated cannon took"
  return "$exitCode"
}
_deprecatedCannonFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deprecatedFind() {
  local handler="_${FUNCNAME[0]}"
  local cannonPath="" search="" findArgumentFunction="" aa=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --path)
      shift
      cannonPath=$(validate "$handler" Directory "$argument" "${1-}") || return $?
      ;;
    *) if
      [ -z "$findArgumentFunction" ]
    then
      findArgumentFunction=$(validate "$handler" function "ignoreFunction" "$1") || return $?
      local aa=()
      read -d '' -r -a aa < <("$findArgumentFunction") || [ "${#aa[@]}" -gt 0 ] || throwArgument "$handler" "$findArgumentFunction returned empty" || return $?
    else
      [ -n "$cannonPath" ] || cannonPath=$(catchReturn "$handler" buildHome) || return $?
      search="$(validate "$handler" String "search" "${1-}")" || return $?
      search="$(quoteGrepPattern "$search")"
      if find "$cannonPath" -type f "${aa[@]}" -print0 | xargs -0 grep -n -l -e "$search"; then
        return 0
      fi
    fi ;;
    esac
    shift
  done
  return 1
}
_deprecatedFind() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
deprecatedCannon() {
  local handler="_${FUNCNAME[0]}"
  local search="" findArgumentFunction="" cannonPath=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --path)
      shift
      cannonPath=$(validate "$handler" Directory "$argument" "${1-}") || return $?
      ;;
    *) if
      [ -z "$findArgumentFunction" ]
    then
      findArgumentFunction=$(validate "$handler" function "ignoreFunction" "$1") || return $?
    elif [ -z "$search" ]; then
      search="$(validate "$handler" String "search" "${1-}")" || return $?
    else
      break
    fi ;;
    esac
    shift
  done
  [ -n "$cannonPath" ] || cannonPath=$(catchReturn "$handler" buildHome) || return $?
  [ -n "$findArgumentFunction" ] || throwArgument "$handler" "findArgumentFunction required" || return $?
  [ -n "$search" ] || throwArgument "$handler" "search required" || return $?
  local aa=()
  read -d '' -r -a aa < <("$findArgumentFunction") || [ "${#aa[@]}" -gt 0 ] || throwArgument "$handler" "$findArgumentFunction returned empty" || return $?
  cannon --path "$cannonPath" "$search" "$@" "${aa[@]}"
}
_deprecatedCannon() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
testTools() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "${1-}" || return 0
  _deprecated "${FUNCNAME[0]}"
  __testLoader "$handler" : || return $?
  catchEnvironment "$handler" isFunction __testSuite || return $?
  [ $# -ne 0 ] || return 0
  isCallable "$1" || throwArgument "$handler" "$1 is not callable" || return $?
  catchEnvironment "$handler" "$@" || return $?
}
_testTools() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
maximumFieldLength() {
  _deprecated "${FUNCNAME[0]}"
  fileFieldMaximum "$@"
}
maximumLineLength() {
  _deprecated "${FUNCNAME[0]}"
  fileLineMaximum "$@"
}
boxedHeading() {
  _deprecated "${FUNCNAME[0]}"
  consoleHeadingBoxed "$@" || return $?
}
lineFill() {
  _deprecated "${FUNCNAME[0]}"
  consoleHeadingLine
}
repeat() {
  _deprecated "${FUNCNAME[0]}"
  textRepeat "$@"
}
whichExists() {
  _deprecated "${FUNCNAME[0]}"
  executableExists "$@"
}
whichHook() {
  _deprecated "${FUNCNAME[0]}"
  hookFind "$@"
}
extensionLists() {
  fileExtensionLists "$@"
}
yesterdayDate() {
  _deprecated "${FUNCNAME[0]}"
  dateYesterday "$@"
}
todayDate() {
  _deprecated "${FUNCNAME[0]}"
  dateToday "$@"
}
tomorrowDate() {
  _deprecated "${FUNCNAME[0]}"
  dateTomorrow "$@"
}
buildFailed() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local quietLog="${1-}" && shift
  _deprecated "${FUNCNAME[0]}"
  local failBar
  failBar="$(consoleHeadingLine "*")"
  statusMessage --last decorate error "$failBar"
  bigText "Failed" | decorate error | decorate wrap "" " " | decorate wrap --fill "*" ""
  statusMessage --last decorate error "$failBar"
  showLines=$(catchReturn "$handler" buildEnvironmentGet BUILD_DEBUG_LINES) || return $?
  isUnsignedInteger "$showLines" || showLines=$(($(consoleRows) - 16)) || showLines=40
  dumpPipe --lines "$showLines" --tail "$(basename "$quietLog")" "$@" <"$quietLog"
  throwEnvironment "$handler" "Failed:" "$@" || return $?
}
_buildFailed() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
makeShellFilesExecutable() {
  _deprecated "${FUNCNAME[0]}"
  bashMakeExecutable "$@" || return $?
}
echoBar() {
  _deprecated "${FUNCNAME[0]}"
  consoleLine "$@" || return $?
}
isAbsolutePath() {
  _deprecated "${FUNCNAME[0]}"
  pathIsAbsolute "$@" || return $?
}
insideDocker() {
  true || isAbsolutePath --help
  _deprecated "${FUNCNAME[0]}"
  dockerInside "$@" || return $?
}
hasConsoleAnimation() {
  _deprecated "${FUNCNAME[0]}"
  consoleHasAnimation "$@" || return $?
}
hasColors() {
  _deprecated "${FUNCNAME[0]}"
  consoleHasColors "$@" || return $?
}
findUncaughtAssertions() {
  _deprecated "${FUNCNAME[0]}"
  bashFindUncaughtAssertions "$@" || return $?
}
debugOpenFiles() {
  _deprecated "${FUNCNAME[0]}"
  filesOpenStatus "$@" || return $?
}
clearLine() {
  _deprecated "${FUNCNAME[0]}"
  consoleLineFill "$@"
}
cachedShaPipe() {
  local cacheDirectory="${1-}"
  _deprecated "${FUNCNAME[0]}"
  if [ "${cacheDirectory#-}" != "$cacheDirectory" ]; then
    shaPipe "$@"
  else
    shaPipe --cache "$@"
  fi
}
consoleColorMode() {
  local handler="_${FUNCNAME[0]}"
  _deprecated "${handler#_}" "Use consoleConfigureDecorate" || :
  consoleConfigureDecorate
}
_consoleColorMode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
usageArgumentLoadEnvironmentFile() {
  _deprecated "${FUNCNAME[0]}"
  local envFile bashEnv usageFunction returnCode
  usageFunction="$1"
  envFile=$(validate "$usageFunction" File "${3-}") || return $?
  bashEnv=$(fileTemporaryName "$usageFunction") || return $?
  catchEnvironment "$usageFunction" environmentFileToBashCompatible "$envFile" >"$bashEnv" || returnClean $? "$bashEnv" || return $?
  set -a
  source "$bashEnv"
  returnCode=$?
  set +a
  rm -f "$bashEnv" || :
  if [ $returnCode -ne 0 ]; then
    "$usageFunction" "$returnCode" "source $envFile -> $bashEnv failed" || return $?
  fi
  printf "%s\n" "$envFile"
}
__catch() {
  catchReturn "$@" || return $?
}
__catchCode() {
  _deprecated "${FUNCNAME[0]}"
  catchCode "$@" || return $?
}
__throwEnvironment() {
  _deprecated "${FUNCNAME[0]}"
  throwEnvironment "$@" || return $?
}
__catchEnvironment() {
  _deprecated "${FUNCNAME[0]}"
  catchEnvironment "$@" || return $?
}
__catchArgument() {
  _deprecated "${FUNCNAME[0]}"
  catchArgument "$@" || return $?
}
__execute() {
  _deprecated "${FUNCNAME[0]}"
  execute "$@" || return $?
}
__echo() {
  _deprecated "${FUNCNAME[0]}"
  executeEcho "$@" || return $?
}
_choose() {
  _deprecated "${FUNCNAME[0]}"
  booleanChoose "$@"
}
newRelease() {
  _deprecated "${FUNCNAME[0]}"
  releaseNew "$@"
}
_home() {
  _deprecated "${FUNCNAME[0]}"
  userRecordHome "$@"
}
_argument() {
  _deprecated "${FUNCNAME[0]}"
  returnArgument "$@"
}
_environment() {
  _deprecated "${FUNCNAME[0]}"
  returnEnvironment "$@"
}
__environment() {
  _deprecated "${FUNCNAME[0]}"
  __catchEnvironment "returnMessage" "$@"
}
__argument() {
  _deprecated "${FUNCNAME[0]}"
  __catchArgument "returnMessage" "$@"
}
isAbsolutePath() {
  _deprecated "${FUNCNAME[0]}"
  pathIsAbsolute "$@"
}
interactiveBashSource() {
  _deprecated "${FUNCNAME[0]}"
  approveBashSource "$@"
}
developerAnnounce() {
  local handler="_${FUNCNAME[0]}"
  local skipItems=()
  local debugFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --debug)
      debugFlag=true
      ;;
    *) source=$(validate "$handler" RealFile "source" "${1-}") || return $? ;;
    esac
    shift
  done
  IFS=$'\n' read -r -d "" -a skipItems < <(environmentSecureVariables)
  local aa=() ff=() types=() unknowns=() item itemType blank
  blank=$(decorate BOLD orange "empty")
  while read -r item; do
    [ -n "$item" ] || continue
    [ "$item" = "${item#_}" ] || continue
    itemType=$(type -t "$item")
    case "$itemType" in
    alias) aa+=("$item") ;;
    function) ff+=("$item") ;;
    *)
      ! inArray "$item" "${skipItems[@]}" || continue
      if muzzle isType "$item"; then
        local message
        message="$(decorate info "$(decorate value "$item") is $(decorate BOLD magenta "${!item-$blank}") ($(isType "$item" | decorate each code))")"
        types+=("$message")
      else
        unknowns+=("$item")
      fi
      ;;
    esac
  done
  [ "${#ff[@]}" -eq 0 ] || decorate info "Available functions $(decorate each code "${ff[@]}")"
  [ "${#aa[@]}" -eq 0 ] || decorate info "Available aliases $(decorate each code "${aa[@]}")"
  [ "${#types[@]}" -eq 0 ] || decorate info "Available variables:"$'\n'"$(printf -- "- %s\n" "${types[@]}")"
  ! $debugFlag || [ "${#unknowns[@]}" -eq 0 ] || decorate info "Unknowns: $(decorate error "${#unknowns[@]}")"
}
_developerAnnounce() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
developerUndo() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local item
  while read -r item; do
    [ -n "$item" ] || continue
    local itemType
    itemType=$(type -t "$item")
    case "$itemType" in
    alias) unalias "$item" ;;
    function) unset "$item" ;;
    *) if
      muzzle isType "$item"
    then
      unset "$item"
    fi ;;
    esac
  done
}
_developerUndo() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
developerTrack() {
  local handler="_${FUNCNAME[0]}"
  local source="" verboseFlag=false profileFlag=false optionalFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --profile) profileFlag=true ;;
    --developer) profileFlag=true && optionalFlag=true ;;
    --verbose)
      verboseFlag=true
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  local cachePath
  cachePath=$(catchReturn "$handler" buildCacheDirectory "${FUNCNAME[0]}" "profile") || return $?
  if $profileFlag; then
    ! $optionalFlag || [ ! -f "$cachePath/environment" ] || return 0
    __developerTrack "$cachePath" || return $?
    return 0
  fi
  if [ ! -f "$cachePath/functions" ]; then
    throwEnvironment "$handler" "developerTrack --profile never called" || return $?
  fi
  local tempPath itemType
  source "$cachePath/alias.source" || throwEnvironment "$handler" "Aliases reload failed" || return $?
  tempPath=$(fileTemporaryName "$handler" -d) || return $?
  __developerTrack "$tempPath" || return $?
  ! $verboseFlag || statusMessage decorate info "Finishing tracking ... comparing $cachePath with $tempPath"
  for itemType in "alias" "environment" "functions"; do comm -13 "$cachePath/$itemType" "$tempPath/$itemType"; done | sort -u
  catchEnvironment "$handler" rm -rf "$tempPath" || return $?
}
__developerTrack() {
  local path="$1"
  __developerTrackEnvironment >"$path/environment"
  __developerTrackAliases "$path"
  __developerTrackFunctions >"$path/functions"
}
__developerTrackFunctions() {
  declare -F | awk '{ print $3 }' | sort -u
}
__developerTrackEnvironment() {
  environmentVariables | sort -u
}
__developerTrackAliases() {
  local path="$1"
  alias -p | sort -u | tee "$path/alias.source" | removeFields 1 | cut -d = -f 1 >"$path/alias" || return $?
}
_developerTrack() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildDevelopmentLink() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --reset | --copy) ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  developerDevelopmentLink --handler "$handler" --binary "install-bin-build.sh" --path "bin/build" --development-path "bin/build" --version-json "bin/build/build.json" --variable "BUILD_DEVELOPMENT_HOME" "${__saved[@]+"${__saved[@]}"}"
}
_buildDevelopmentLink() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
developerDevelopmentLink() {
  local handler="_${FUNCNAME[0]}"
  local resetFlag=false path="" versionJSON="" variable="" copyFlag=false composerPackage="" developmentPath="" versionSelector="" runBinary=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --copy)
      copyFlag=true
      ;;
    --composer)
      shift
      composerPackage=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --binary)
      shift
      runBinary+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --development-path)
      shift
      developmentPath=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --path)
      shift
      path=$(validate "$handler" ApplicationDirectory "$argument" "${1-}") || throwArgument "$handler" "path failed #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
      ;;
    --version-json)
      shift
      versionJSON=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --version-selector)
      shift
      versionSelector=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --variable)
      shift
      variable=$(validate "$handler" EnvironmentVariable "$argument" "${1-}") || return $?
      ;;
    --reset)
      resetFlag=true
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  [ -n "$versionSelector" ] || versionSelector=".version"
  local home target
  home=$(catchReturn "$handler" buildHome) || return $?
  home=$(catchEnvironment "$handler" realPath "${home%/}") || return $?
  if [ -z "$composerPackage" ]; then
    [ "${#runBinary[@]}" -gt 0 ] || throwArgument "$handler" "--binary or --composer is required" || return $?
    [ -n "$path" ] || throwArgument "$handler" "--path is required" || return $?
    [ -n "$versionJSON" ] || throwArgument "$handler" "--version-json is required" || return $?
  else
    runBinary=(composer require "$composerPackage")
    path="vendor/$composerPackage"
    versionJSON="$path/composer.json"
    developmentPath=""
  fi
  [ -n "$variable" ] || throwArgument "$handler" "--variable is required" || return $?
  local developmentHome=""
  path="${path%/}"
  target="$home/$path"
  developmentPath="${developmentPath#/}"
  developmentPath="${developmentPath%/}"
  showName=$(buildEnvironmentGet APPLICATION_NAME) || return $?
  showName=$(decorate label "$showName")
  developmentHome=$(catchReturn "$handler" buildEnvironmentGet "$variable") || return $?
  if [ -n "$developmentHome" ]; then
    developmentHome=$(catchEnvironment "$handler" realPath "${developmentHome%/}") || return $?
  fi
  local source="$developmentHome/$developmentPath"
  source="${source%/}"
  [ -d "$source" ] || throwEnvironment "$handler" "$variable is not a directory: $(decorate error "$source")" || return $?
  [ "$home" != "$developmentHome" ] || throwEnvironment "$handler" "This $(decorate warning "is") the development directory: $showName" || return $?
  if $resetFlag; then
    local versionText
    [ -f "$home/$versionJSON" ] || throwEnvironment "$handler" "$(decorate file "$home/$versionJSON") does not exist" || return $?
    versionText="$(jq -r "$versionSelector" <"$home/$versionJSON")"
    if [ -L "$target" ]; then
      __developerDevelopmentRevert "$handler" "$home" "$path" "$developmentHome" "${runBinary[@]}"
    else
      statusMessage --last printf -- "%s using %s\n" "$showName" "$(decorate file "$target")" "$versionText"
    fi
  else
    local arrowIcon="➡️" aok="✅"
    [ -z "$developmentPath" ] || [ -d "$source" ] || throwEnvironment "$handler" "$source is not a directory" || return $?
    if $copyFlag; then
      local verb
      if [ -L "$target" ]; then
        catchEnvironment "$handler" rm "$target" || return $?
        catchEnvironment "$handler" mkdir -p "$target" || return $?
      fi
      if executableExists rsync; then
        verb="Synchronized"
        catchEnvironment "$handler" rsync -a --exclude "*/.git/" --delete "$source/" "$target/" || return $?
      else
        verb="Copied"
        catchEnvironment "$handler" cp -R "$source/" "$target" || return $?
        catchEnvironment find "$target" -name .git -type d -delete || return $?
      fi
      printf -- "%s %s %s %s %s (%s)\n" "$aok" "$(decorate info "$verb")" "$(decorate file "$developmentHome")" "$arrowIcon" "$showName" "$(decorate file "$(realPath "$target")")"
    elif [ -L "$target" ]; then
      printf -- "%s %s %s %s\n" "$aok" "$(decorate file "$target")" "$arrowIcon" "$(decorate file "$(realPath "$target")")"
    elif [ -f "$home/$versionJSON" ]; then
      if confirmYesNo --timeout 30 --default false "$(decorate warning "Removing $(decorate file "$target") in project $showName"?)"; then
        catchEnvironment "$handler" rm -rf "$target" || return $?
        catchEnvironment "$handler" ln -s "$source" "$target" || return $?
      else
        statusMessage --last decorate error "Nothing removed."
      fi
    else
      throwEnvironment "$handler" "$versionJSON does not exist, will not update." || return $?
    fi
  fi
}
_developerDevelopmentLink() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__developerDevelopmentRevert() {
  local handler="$1" home="$2" relPath="$3" developmentHome="$4" && shift 4
  [ $# -gt 0 ] || throwArgument "$handler" "Missing installer" || return $?
  local target="$home/$relPath/"
  catchEnvironment "$handler" rm -rf "$target" || return $?
  if [ $# -eq 1 ] && ! isExecutable "$1"; then
    local binary="$1" installer
    installer="$developmentHome/$relPath/$binary"]
    [ -x "$installer" ] || throwEnvironment "$handler" "$installer does not exist" || return $?
    catchReturn "$handler" directoryRequire "$target" || return $?
    catchEnvironment "$handler" cp "$installer" "$target/$binary" || return $?
    set -- "$target/$binary"
  fi
  catchEnvironment "$handler" "$@" || return $?
  [ -d "$target" ] || throwEnvironment "$handler" "Installer $(decorate code "$*") did not install $(decorate file "$target")"
}
buildCompletion() {
  local handler="_${FUNCNAME[0]}"
  local aliasName="build" reloadAliasName="" quietFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --quiet)
      quietFlag=true
      ;;
    --alias)
      shift
      aliasName=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --reload-alias)
      shift
      reloadAliasName=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  complete -F __buildCompletion "$aliasName"
  local home name homeText
  home=$(catchReturn "$handler" buildHome) || return $?
  name="$(decorate info "$(buildEnvironmentGet APPLICATION_NAME)")"
  homeText="$(decorate code "$home")"
  shopt -s expand_aliases || return $?
  if [ -z "$reloadAliasName" ]; then
    reloadAliasName="${aliasName}Reload"
  fi
  if isFunction "$aliasName"; then
    throwEnvironment "$handler" "$aliasName is a function already can not create alias" || return $?
  fi
  alias "$aliasName"="$home/bin/build/tools.sh"
  local reloadCode="source \"$home/bin/build/tools.sh\" && decorate info \"Reloaded $name @ $homeText\""
  if isFunction "$reloadAliasName"; then
    throwEnvironment "$handler" "$reloadAliasName is a function already can not create alias" || return $?
  fi
  alias "$reloadAliasName"="$reloadCode"
  $quietFlag || printf "%s %s\n" "$(decorate info "Created aliases")" "$(decorate each code "$aliasName" "$reloadAliasName")"
}
_buildCompletion() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__buildCompletion() {
  export COMP_WORDS COMP_CWORD COMPREPLY
  local item
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local fun=()
  if [ "$COMP_CWORD" -le 1 ]; then
    fun=(__buildCompletionFunction "$cur")
  else
    fun=(__buildCompletionArguments)
  fi
  COMPREPLY=()
  while read -r item; do COMPREPLY+=("$item"); done < <("${fun[@]}")
}
__buildCompletionFunction() {
  if [ -z "$1" ]; then
    buildFunctions
  else
    buildFunctions | grepSafe -e "^$(quoteGrepPattern "$1")"
  fi
}
__buildCompletionArguments() {
  local handler="returnMessage"
  export COMP_WORDS COMP_CWORD COMPREPLY
  [ "$COMP_CWORD" -ge 2 ] || throwArgument "$handler" "ONLY call for arguments once function selected" || return $?
  local command="${COMP_WORDS[1]}"
  local word="${COMP_WORDS[COMP_CWORD]-}"
  local previous="${COMP_WORDS[COMP_CWORD - 1]}"
  if [ "$COMP_CWORD" -eq 2 ]; then
    previous=""
  fi
  if [ -n "$command" ]; then
    id=$(__buildCompletionFunctionID "$handler" "$command") || return $?
    if [ -n "$id" ]; then
      _commentArgumentSpecificationComplete "$id" "$previous" "$word"
    else
      printf "%s\n" "function not found"
    fi
  fi
  printf "%s\n" "#$COMP_CWORD" "${COMP_WORDS[@]}" "previous:$previous" "word:$word" >"$(buildHome)/.completion-debug"
}
__buildCompletionFunctionID() {
  local cache handler="$1" command="$2"
  cache="$(buildCacheDirectory "COMPLETION")"
  if [ -f "$cache/$command" ]; then
    cat "$cache/$command"
  else
    local home source
    home=$(catchReturn "$handler" buildHome) || return $?
    source=$(catchReturn "$handler" __bashDocumentation_FindFunctionDefinitions "$home" "$command" | grepSafe -v "/identical" | head -n 1) || return $?
    if [ -n "$source" ]; then
      id=$(catchReturn "$handler" _commentArgumentSpecification "$source" "$command") || return $?
      if [ -n "$id" ]; then
        printf "%s\n" "$id" | tee "$cache/$command"
      fi
    else
      printf "%s\n" "No source for $command: $home"
    fi
  fi
}
__completionTypeString() {
  printf "%s\n" "$@"
}
__completionTypeEmptyString() {
  printf "%s\n" "$@" '""'
}
__completionTypeArray() {
  printf "%s\n" "$@"
}
__completionTypeList() {
  printf "%s\n" "$@"
}
__completionTypeColonDelimitedList() {
  printf "%s\n" "$@"
}
__completionTypeCommaDelimitedList() {
  printf "%s\n" "$@"
}
__completionTypeUnsignedInteger() {
  local value="" i
  local digits=(0 1 2 3 4 5 6 7 8 9)
  if isUnsignedInteger "${1-}"; then
    value="$1"
    printf "%d\n" "$value"
  fi
  for i in "${digits[@]}"; do
    printf "%s%d\n" "$value" "$i"
  done
}
__completionTypePositiveInteger() {
  local value="" i
  local digits=(0 1 2 3 4 5 6 7 8 9)
  if isPositiveInteger "${1-}"; then
    value="$1"
    printf "%d\n" "$value"
  fi
  for i in "${digits[@]}"; do
    printf "%s%d\n" "$value" "$i"
  done
}
__completionTypeInteger() {
  local value="" i
  local digits=(0 1 2 3 4 5 6 7 8 9)
  if isInteger "${1-}"; then
    value="$1"
    printf "%d\n" "$value"
  fi
  for i in "${digits[@]}"; do
    printf "%s%d\n" "$value" "$i"
  done
}
__completionTypeNumber() {
  local value="" i
  local digits=(0 1 2 3 4 5 6 7 8 9)
  if isNumber "${1-}"; then
    value="$1"
    printf "%d\n" "$value"
  fi
  for i in "${digits[@]}"; do
    printf "%s%d\n" "$value" "$i"
  done
}
__completionTypeFunction() {
  local pattern
  if [ -n "${1-}" ]; then
    pattern=$(quoteGrepPattern "$1")
  else
    pattern="."
  fi
  declare -F | removeFields 2 | grep -e "^$pattern"
}
__completionTypeCallable() {
  __completionTypeFunction "$@"
  __completionTypeExecutable "$@"
}
__completionTypeExecutable() {
  comgen -A command "$@"
}
__completionTypeApplicationDirectory() {
  local search="$1" home
  home="$(buildHome)"
  home="${home%/}/"
  search="${search#"$home"}"
  search="$home${search%/}"
  search="${search%/}"
  compgen -A directory "$search" | cut -c "$((${#home} + 1))"-
  compgen -A directory "$search/" | cut -c "$((${#home} + 1))"-
}
__completionTypeApplicationFile() {
  local search="$1" home
  home="$(buildHome)"
  home="${home%/}/"
  search="${search#"$home"}"
  search="$home${search%/}"
  search="${search%/}"
  compgen -A file "$search" | cut -c "$((${#home} + 1))"-
  compgen -A file "$search/" | cut -c "$((${#home} + 1))"-
}
__completionTypeApplicationDirectoryList() {
  local search="$1" home
  home="$(buildHome)"
  home="${home%/}/"
  search="${search#"$home"}"
  search="$home${search%/}"
  search="${search%/}"
  compgen -A directory "$search" | cut -c "$((${#home} + 1))"-
  compgen -A directory "$search/" | cut -c "$((${#home} + 1))"-
}
__completionTypeBoolean() {
  printf "%s\n" "true" "false"
}
__completionTypeBooleanLike() {
  printf "%s\n" "true" "false" "yes" "no" "0" "1"
}
__completionTypeDate() {
  dateValid "${1-}" || __throwValidate || return $?
  printf "%s\n" "${1-}"
}
__completionTypeDirectoryList() {
  compgen -A directory "$@"
}
__completionTypeEnvironmentVariable() {
  comgen -A export
}
__completionTypeExists() {
  compgen -A file "$@"
}
__completionTypeFile() {
  compgen -A file "$@"
}
__completionTypeDirectory() {
  compgen -A directory "$@"
}
__completionTypeLink() {
  find "${1-.}" -type l
}
__completionTypeFileDirectory() {
  compgen -A directory "$@"
}
__completionTypeRealDirectory() {
  compgen -A directory "$@"
}
__completionTypeRealFile() {
  compgen -A file "$@"
}
__completionTypeRemoteDirectory() {
  [ "${1:0:1}" = "/" ] || __throwValidate "begins with a slash" || return $?
  printf "%s\n" "${1%/}"
}
__completionTypeURL() {
  urlValid "${1-}" || __throwValidate "invalid url" || return $?
  printf "%s\n" "${1-}"
}
__throwValidate() {
  printf -- "%s\n" "$@" 1>&2
  return 2
}
__xdebugInstallationArtifact() {
  printf -- "%s\n" "/etc/xdebug-enabled"
}
xdebugInstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local iniFile
  catchEnvironment "$handler" phpInstall || return $?
  catchReturn "$handler" packageWhich pear php-pear || return $?
  catchReturn "$handler" packageWhich phpize php-dev || return $?
  muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" pear pecl || return $?
  iniFile=$(catchEnvironment "$handler" phpIniFile) || return $?
  [ -f "$iniFile" ] || throwEnvironment "$handler" "php.ini not found $(decorate file "$iniFile")" || return $?
  statusMessage decorate info "Setting php ini path to $(decorate file "$iniFile")"
  catchEnvironment "$handler" pear config-set php_ini "$iniFile" || return $?
  statusMessage decorate info "Installing xdebug ..."
  catchEnvironment "$handler" pecl channel-update pecl.php.net || return $?
  if ! muzzle pecl list-files xdebug; then
    muzzle catchEnvironment "$handler" pecl install xdebug || return $?
  fi
  local artifact
  artifact=$(__xdebugInstallationArtifact)
  date | muzzle catchEnvironment "$handler" tee "$artifact" || return $?
}
_xdebugInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__xdebug_Require() {
  local artifact
  artifact=$(__xdebugInstallationArtifact)
  [ -f "$artifact" ] || throwArgument "$1" "xdebug is not installed on this system" || return $?
}
xdebugEnable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  __xdebug_Require "$handler" || return $?
  export XDEBUG_ENABLED=true
  decorate success "xdebug debugging $(decorate value "[ENABLED]")"
}
_xdebugEnable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
xdebugDisable() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  __xdebug_Require "$handler" || return $?
  export XDEBUG_ENABLED
  unset XDEBUG_ENABLED
  decorate info "xdebug debugging $(decorate value "(disabled)")"
}
_xdebugDisable() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentVariableNameValid() {
  local handler="_${FUNCNAME[0]}"
  local name
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || return 1
    case "$1" in
    --help) "$handler" 0 && return $? || return $? ;;
    *[!A-Za-z0-9_]*)
      return 1
      ;;
    *) case "${1:0:1}" in
      [A-Za-z_]) ;;
      *) return 1 ;;
      esac ;;
    esac
    shift
  done
}
_environmentVariableNameValid() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentSecureVariables() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf -- "%s\n" PATH LD_LIBRARY USER HOME HOSTNAME LANG PS1 PS2 PS3 CWD PWD SHELL SHLVL TERM TMPDIR VISUAL EDITOR
}
_environmentSecureVariables() {
  true || environmentSecureVariables --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentFileShow() {
  local handler="_${FUNCNAME[0]}"
  local name
  local width=40
  local extras=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --)
      shift
      break
      ;;
    *) extras+=("$(validate "$handler" EnvironmentVariable "variableName" "$argument")") || return $? ;;
    esac
    shift
  done
  local buildEnvironment=("$@")
  IFS=$'\n' read -d '' -r -a variables < <(environmentApplicationVariables) || :
  for name in "${variables[@]+"${variables[@]}"}" "${extras[@]+"${extras[@]}"}"; do
    environmentVariableNameValid "$name" || catchArgument "$handler" "Invalid environment name $(decorate code "$name")" 1>&2
  done
  export "${variables[@]}"
  catchEnvironment "$handler" muzzle environmentApplicationLoad || return $?
  environmentVariableNameValid "$@" || catchArgument "$handler" "Invalid variable name" || return $?
  printf -- "%s %s %s %s%s\n" "$(decorate info "Application")" "$(decorate magenta "$APPLICATION_VERSION")" "$(decorate info "on")" "$(decorate BOLD red "$APPLICATION_BUILD_DATE")" "$(decorate info "...")"
  if buildDebugEnabled; then
    decorate pair "$width" Checksum "$APPLICATION_ID"
    decorate pair "$width" Tag "$APPLICATION_TAG"
    decorate pair "$width" Timestamp "$BUILD_TIMESTAMP"
  fi
  local name missing=()
  for name in "${variables[@]}"; do
    if [ -z "${!name:-}" ]; then
      decorate pair "$width" "$name" "** No value **" 1>&2
      missing+=("$name")
    else
      decorate pair "$width" "$name" "${!name}"
    fi
  done
  for name in "${buildEnvironment[@]+"${buildEnvironment[@]}"}"; do
    if [ -z "${!name:-}" ]; then
      decorate pair "$width" "$name" "** Blank **"
    else
      decorate pair "$width" "$name" "${!name}"
    fi
  done
  [ ${#missing[@]} -eq 0 ] || throwEnvironment "$handler" "Missing environment $(decorate each code "${missing[@]}")" || return $?
}
_environmentFileShow() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentVariables() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  declare -px | grep 'declare -x ' | cut -f 1 -d "=" | cut -f 3 -d " "
}
_environmentVariables() {
  true || environmentVariables --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentParseVariables() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  grepSafe -e '^\(export \)\?\s*[A-Za-z_][A-Za-z_0-9]*=' | grep -v 'read -r' | sed 's/^export[[:space:]][[:space:]]*//g' | cut -f 1 -d = | sort -u
}
_environmentParseVariables() {
  true || environmentParseVariables --help || return $?
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentClean() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local finished=false variable keepers=(PATH LD_LIBRARY USER HOME PS1 PS2 PS3 PS4 BUILD_HOME "$@")
  while ! $finished; do
    read -r variable || finished=true
    [ -n "$variable" ] || continue
    ! inArray "$variable" "${keepers[@]}" || continue
    unset "${variable?}" 2>/dev/null || :
  done < <(environmentVariables)
}
_environmentClean() {
  true || environmentClean --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentOutput() {
  local handler="_${FUNCNAME[0]}"
  local __handler="$handler"
  local __skipSecure=true __skipUnderscore=true __variables=() __skipPrefix=() __debugFlag=false
  local __written=("")
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local __argument="$1" __index=$((__count - $# + 1))
    [ -n "$__argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$__argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --underscore) __skipUnderscore=false ;;
    --skip-prefix) shift && __skipPrefix+=("$(validate "$handler" String "$__argument" "${1-}")") || return $? ;;
    --secure) __skipSecure=false ;;
    --debug) __debugFlag=true ;;
    *) __variables+=("$(validate "$handler" "EnvironmentVariable" "variable" "$__argument")") || return $? ;;
    esac
    shift
  done
  if $__skipSecure; then
    local __secureVariable && while read -r __secureVariable; do __written+=("$__secureVariable"); done < <(environmentSecureVariables)
  fi
  if $__skipUnderscore; then
    __skipPrefix+=('_')
  fi
  local __name __value __finished=false
  while IFS='=' read -r __name __value; do
    ! $__debugFlag || printf "%s\n" "# ARRAY: $__name"
    [ "${#__skipPrefix[@]}" -eq 0 ] || ! stringBegins "$__name" "${__skipPrefix[@]}" || continue
    [ "${#__written[@]}" -eq 0 ] || ! inArray "$__name" "${__written[@]}" || continue
    catchReturn "$__handler" printf "%s=%s\n" "$__name" "$(unquote "'" "$__value")" || return $?
    __written+=("$__name")
  done < <(declare -ax | removeFields 2)
  ! $__debugFlag || printf "%s\n" "# above is arrays"
  while ! $__finished; do
    IFS="=" read -r -d $'\0' __name __value || __finished=true
    [ -n "$__name" ] && [ "${__name%\%}" = "$__name" ] || continue
    [ "${#__skipPrefix[@]}" -eq 0 ] || ! stringBegins "$__name" "${__skipPrefix[@]}" || continue
    [ "${#__written[@]}" -eq 0 ] || ! inArray "$__name" "${__written[@]}" || continue
    catchReturn "$__handler" environmentValueWrite "$__name" "$__value" || return $?
    __written+=("$__name")
  done < <(env -0)
  ! $__debugFlag || printf "%s\n" "# above is env -0"
  [ ${#__variables[@]} -eq 0 ] || for __name in "${__variables[@]}"; do
    [ "${#__skipPrefix[@]}" -eq 0 ] || ! stringBegins "$__name" "${__skipPrefix[@]}" || continue
    [ "${#__written[@]}" -eq 0 ] || ! inArray "$__name" "${__written[@]}" || continue
    __value="${!__name-}"
    catchReturn "$__handler" environmentValueWrite "$__name" "$__value" || return $?
    __written+=("$__name")
  done
  ! $__debugFlag || printf "%s\n" "# above is argument variables"
}
_environmentOutput() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentValueWrite() {
  local handler="_${FUNCNAME[0]}" name
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local value replace="\"$'\n'\""
  name=$(validate "$handler" EnvironmentVariable "name" "${1-}") || return $?
  shift
  [ $# -ge 1 ] || throwArgument "$handler" "value required" || return $?
  if [ $# -eq 1 ]; then
    value="${1-}"
    value="$(declare -p value)"
    [ "${value#*$'\n'}" = "$value" ] || value=${value//$'\n'/"$replace"}
    __environmentValueWrite "$name" "$value" || return $?
  else
    environmentValueWriteArray "$name" "$@"
  fi
}
_environmentValueWrite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentValueWriteArray() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local name value result search="'" replace="'\''"
  name=$(validate "$handler" EnvironmentVariable "name" "${1-}") || return $?
  shift
  if [ $# -eq 0 ]; then
    printf "%s=%s\n" "$name" "()"
  else
    value=("$@")
    result="$(__environmentValueClean "$(declare -pa value)")" || return $?
    if [ "${result:0:1}" = "'" ]; then
      result="$(unquote \' "$result")"
      printf "%s=%s\n" "$name" "${result//"$replace"/$search}"
    else
      printf "%s=%s\n" "$name" "$result"
    fi
  fi
}
_environmentValueWriteArray() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__environmentValueClean() {
  printf -- "%s\n" "${1#declare*value=}"
}
__environmentValueWrite() {
  printf "%s=%s\n" "$1" "$(__environmentValueClean "$2")" || return $?
}
environmentValueRead() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local stateFile name default="${3---}" value
  stateFile=$(validate "$handler" File "stateFile" "${1-}") || return $?
  name=$(validate "$handler" EnvironmentVariable "name" "${2-}") || return $?
  [ $# -le 3 ] || throwArgument "$handler" "Extra arguments: $#" || return $?
  if ! value="$(grep -e "^$(quoteGrepPattern "$name")=" "$stateFile" | tail -n 1 | cut -c $((${#name} + 2))-)" || [ -z "$value" ]; then
    if [ $# -le 2 ]; then
      return 1
    fi
    printf -- "%s\n" "$default"
  else
    declare "$name=$default"
    declare "$name=$(__unquote "$value")"
    printf -- "%s\n" "${!name-}"
  fi
}
_environmentValueRead() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentValueConvertArray() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local value prefix='([0]="' suffix='")'
  value=$(__unquote "${1-}")
  [ "$value" != "()" ] || return 0
  if [ "${value#*=}" != "$value" ]; then
    [ "${value#"$prefix"}" != "$value" ] || throwArgument "$handler" "Not an array value (prefix: \"${value:0:4}\")" || return $?
    [ "${value%"$suffix"}" != "$value" ] || throwArgument "$handler" "Not an array value (suffix)" || return $?
    declare -a "value=$value"
  else
    local n=$((${#value} - 1))
    if [ "${value:0:1}${value:0:1}${value:n:1}" = "()" ]; then
      IFS=" " read -r -d'' -a value <<<"${value:1:$((n - 1))}"
    fi
  fi
  printf -- "%s\n" "${value[@]+"${value[@]}"}"
}
_environmentValueConvertArray() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentValueReadArray() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local stateFile="${1-}" name value
  name=$(validate "$handler" EnvironmentVariable "name" "${2-}") || return $?
  value=$(catchReturn "$handler" environmentValueRead "$stateFile" "$name" "") || return $?
  environmentValueConvertArray "$value" || return $?
}
_environmentValueReadArray() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentNames() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  environmentLines | cut -f 1 -d =
}
_environmentNames() {
  true || environmentNames --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentLines() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  grepSafe -e "^[A-Za-z][A-Z0-9_a-z]*="
}
_environmentLines() {
  true || environmentLines --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentLoad() {
  local handler="_${FUNCNAME[0]}"
  local ff=() required=true ignoreList=() secureList=()
  local verboseMode=false debugMode=false hasOne=false execCommand=() variablePrefix="" context=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verboseMode=true
      ! $debugMode || printf -- "VERBOSE MODE on (Call: %s)\n" "$(decorate each code "${handler#_}" "${__saved[@]}")"
      ;;
    --debug)
      debugMode=true
      verboseMode=true
      statusMessage decorate info "Debug mode enabled"
      ;;
    --secure)
      shift
      secureList+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --prefix)
      shift
      variablePrefix="$(validate "$handler" EnvironmentVariable "$argument" "${1-}")" || return $?
      ;;
    --secure-defaults)
      read -d "" -r -a secureList < <(environmentSecureVariables) || :
      ;;
    --ignore)
      shift
      ignoreList+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --require)
      required=true
      ! $debugMode || printf -- "Current: %s\n" "$argument"
      ;;
    --optional)
      required=false
      ! $debugMode || printf -- "Current: %s\n" "$argument"
      ;;
    --context)
      shift
      context="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ! $debugMode || printf -- "Context: %s\n" "$context"
      ;;
    --execute)
      shift
      binary=$(validate "$handler" Callable "$argument" "${1-}") || return $?
      shift
      execCommand=("$binary" "$@")
      break
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  local name value environmentLine toExport=() line=1
  while read -r environmentLine; do
    ! $debugMode || printf "%s:%d: %s" "$context" "$line" "$(decorate code "$environmentLine")"
    name="${environmentLine%%=*}"
    if [ -z "$name" ] || [ "$name" != "${name###}" ]; then
      continue
    fi
    name="$variablePrefix$name"
    if ! environmentVariableNameValid "$name"; then
      ! $verboseMode || decorate warning "$(decorate code "$name") invalid name ($context:$line)"
      continue
    fi
    [ "${#secureList[@]}" -eq 0 ] || ! inArray "$name" "${secureList[@]}" || throwEnvironment "$handler" "$environmentFile contains secure value $(decorate BOLD red "$name") [$(decorate each --count code "${secureList[@]}")]" || return $?
    if [ "${#ignoreList[@]}" -gt 0 ] && inArray "$name" "${ignoreList[@]}"; then
      ! $debugMode || decorate warning "$(decorate code "$name") is ignored ($context:$line)"
      continue
    fi
    value="$(__unquote "${environmentLine#*=}")"
    toExport+=("$name=$value")
    ! $debugMode || printf "toExport: %s=%s\n" "$name" "$value"
    line=$((line + 1))
  done
  if [ "${#toExport[@]}" -gt 0 ]; then
    for value in "${toExport[@]}"; do
      name=${value%%=*}
      value=${value#*=}
      ! $debugMode || printf "EXPORTING: %s=%s\n" "$name" "$value"
      export "${name?}"="$value"
    done
  fi
  if [ ${#execCommand[@]} -gt 0 ]; then
    ! $debugMode || printf "RUNNING: %s" "$*"
    catchEnvironment "$handler" "${execCommand[@]}" || return $?
  fi
}
_environmentLoad() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentFileLoad() {
  local handler="_${FUNCNAME[0]}"
  local ff=() environmentFile required=true
  local verboseMode=false debugMode=false hasOne=false execCommand=() variablePrefix="" ee=() pp=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verboseMode=true
      ee+=("$argument")
      ! $debugMode || printf -- "VERBOSE MODE on (Call: %s)\n" "$(decorate each code "${handler#_}" "${__saved[@]}")"
      ;;
    --debug)
      debugMode=true
      verboseMode=true
      ee+=("$argument")
      statusMessage decorate info "Debug mode enabled"
      ;;
    --secure-defaults)
      ee+=("$argument")
      ;;
    --ignore | --secure)
      shift
      ee+=("$argument" "${1-}")
      ;;
    --prefix)
      shift
      pp=("$argument" "${1-}")
      ;;
    --require)
      required=true
      ! $debugMode || printf -- "Current: %s\n" "$argument"
      ;;
    --optional)
      required=false
      ! $debugMode || printf -- "Current: %s\n" "$argument"
      ;;
    --execute)
      shift
      binary=$(validate "$handler" Callable "$argument" "${1-}") || return $?
      shift
      execCommand=("$binary" "$@")
      break
      ;;
    *)
      hasOne=true
      if $required; then
        ! $debugMode || printf -- "Loading required file: %s\n" "$argument"
        environmentFile="$(validate "$handler" File "environmentFile" "$argument")" || return $?
        ff+=("$environmentFile") || return $?
      else
        ! $verboseMode || statusMessage decorate info "Loading optional file: $(decorate file "$argument")"
        environmentFile=$(validate "$handler" FileDirectory "environmentFile" "$argument") || return $?
        if [ -f "$environmentFile" ]; then
          ff+=("$environmentFile")
        else
          ! $debugMode || printf -- "Optional file does not exist: %s\n" "$environmentFile"
        fi
      fi
      ;;
    esac
    shift
  done
  $hasOne || throwArgument "$handler" "Requires at least one environmentFile" || return $?
  [ "${#ff[@]}" -gt 0 ] || return 0
  ! $debugMode || printf -- "Files to actually load: %d %s\n" "${#ff[@]}" "${ff[*]}"
  for environmentFile in "${ff[@]}"; do
    ! $debugMode || printf "%s lines:\n%s\n" "$(decorate code "$environmentFile")" "$(environmentLines <"$environmentFile")"
    catchReturn "$handler" environmentLoad --context "$environmentFile" "${pp[@]+"${pp[@]}"}" "${ee[@]+"${ee[@]}"}" < <(environmentLines <"$environmentFile") || return $?
  done
  if [ ${#execCommand[@]} -gt 0 ]; then
    ! $debugMode || printf "RUNNING: %s" "${execCommand[*]}"
    catchEnvironment "$handler" "${execCommand[@]}" || return $?
  fi
}
_environmentFileLoad() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentApplicationVariables() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf -- "%s\n" BUILD_TIMESTAMP APPLICATION_BUILD_DATE APPLICATION_VERSION APPLICATION_ID APPLICATION_TAG
}
_environmentApplicationVariables() {
  true || environmentApplicationVariables --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentApplicationLoad() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local variables=()
  IFS=$'\n' read -d '' -r -a variables < <(environmentApplicationVariables) || :
  export "${variables[@]}"
  here=$(catchReturn "$handler" buildHome) || return $?
  local env && for env in "${variables[@]}"; do
    source "$here/bin/build/env/$env.sh" || throwEnvironment "$handler" "source $env.sh" || return $?
  done
  local hook=""
  if [ -z "${APPLICATION_VERSION-}" ]; then
    hook="version-current"
    APPLICATION_VERSION="$(catchEnvironment "$handler" hookRun "$hook")" || return $?
  fi
  if [ -z "${APPLICATION_ID-}" ]; then
    hook="application-id"
    APPLICATION_ID="$(catchEnvironment "$handler" hookRun "$hook")" || return $?
  fi
  if [ -z "${APPLICATION_TAG-}" ]; then
    hook="application-tag"
    APPLICATION_TAG="$(catchEnvironment "$handler" hookRun "$hook")" || return $?
    if [ -z "${APPLICATION_TAG-}" ]; then
      APPLICATION_TAG=$APPLICATION_ID
    fi
  fi
  local variable
  for variable in "${variables[@]}" "$@"; do
    catchReturn "$handler" environmentValueWrite "$variable" "${!variable-}" || return $?
  done
}
_environmentApplicationLoad() {
  ! false || environmentApplicationLoad --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentFileApplicationMake() {
  local handler="_${FUNCNAME[0]}"
  local required=() optional=() isOptional=false variableName="requiredVariable"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --)
      if
        $isOptional
      then
        throwArgument "$handler" "Double -- found in argument list ($(decorate each quote "${__saved[@]}"))" || return $?
      fi
      isOptional=true
      variableName="optionalVariable"
      ;;
    *)
      local variable
      variable="$(validate "$handler" EnvironmentVariable "$variableName" "$1")" || return $?
      if $isOptional; then
        optional+=("$variable")
      else
        required+=("$variable")
      fi
      ;;
    esac
    shift
  done
  set -- "${required[@]+"${required[@]}"}"
  local loaded
  loaded="$(catchReturn "$handler" environmentApplicationLoad "$@" && catchReturn "$handler" environmentFileApplicationVerify "$@")" || return $?
  printf -- "%s\n" "$loaded"
  local name
  for name in "$@" "${optional[@]+"${optional[@]}"}"; do
    catchReturn "$handler" environmentValueWrite "$name" "${!name-}" || return $?
  done
}
_environmentFileApplicationMake() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentFileApplicationVerify() {
  local handler="_${FUNCNAME[0]}"
  local missing name requireEnvironment
  local requireEnvironment=() extras=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --)
      shift && break
      ;;
    *) extras+=("$1") ;;
    esac
    shift
  done
  IFS=$'\n' read -d '' -r -a requireEnvironment < <(environmentApplicationVariables) || :
  missing=()
  for name in "${requireEnvironment[@]}" "${extras[@]+"${extras[@]}"}"; do
    environmentVariableNameValid "$name" || throwEnvironment "$handler" "Invalid environment name found: $(decorate code "$name")" || return $?
    if [ -z "${!name:-}" ]; then
      missing+=("$name")
    fi
  done
  [ ${#missing[@]} -eq 0 ] || throwEnvironment "$handler" "Missing environment values:" "${missing[@]}" || return $?
}
_environmentFileApplicationVerify() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
dotEnvConfigure() {
  local handler="_${FUNCNAME[0]}"
  local aa=() where=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose | --debug)
      aa+=("$argument")
      ;;
    *) where=$(validate "$handler" Directory "where" "$1") || return $? ;;
    esac
    shift
  done
  if [ -z "$where" ]; then
    where=$(catchEnvironment "$handler" pwd) || return $?
  fi
  aa+=(--require "$where/.env" --optional "$where/.env.local" --require)
  catchReturn "$handler" environmentFileLoad "${aa[@]}" "$@" || return $?
}
_dotEnvConfigure() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentCompile() {
  local handler="_${FUNCNAME[0]}"
  local environmentFiles=() aa=() __debugFlag=false keepComments=false __parseFlag=false variables=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local __argument="$1" __index=$((__count - $# + 1))
    [ -n "$__argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$__argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) __debugFlag=true ;;
    --parse) __parseFlag=true ;;
    --variables)
      shift && local listText && listText="$(validate "$handler" "CommaDelimitedList" "$__argument" "${1-}")" || return $?
      local variableList=() && IFS="," read -r -a variableList <<<"$listText" || :
      variables+=("${variableList[@]+"${variableList[@]}"}")
      aa+=("${variableList[@]+"${variableList[@]}"}")
      ;;
    --keep-comments) keepComments=true ;;
    --underscore | --secure) aa+=("$__argument") ;;
    *) environmentFiles+=("$(validate "$handler" File "environmentFile" "$__argument")") || return $? ;;
    esac
    shift
  done
  local tempEnv
  tempEnv=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempEnv" "$tempEnv.after" "$tempEnv.source" "$tempEnv.save")
  if [ ${#environmentFiles[@]} -eq 0 ]; then
    catchEnvironment "$handler" cat >"$tempEnv.source" || return $?
    environmentFiles+=("$tempEnv.source")
  fi
  if $__parseFlag; then
    while read -r variable; do variables+=("$variable"); done < <(cat "${environmentFiles[@]}" | environmentParseVariables)
    if $__debugFlag; then printf "%s\n" "${variables[@]}" | dumpPipe "PARSED variables" 1>&2; fi
  fi
  if $__debugFlag; then cat "${environmentFiles[@]}" | dumpPipe SOURCES 1>&2; fi
  (
    local __handler="$handler"
    catchReturn "$__handler" environmentClean || return $?
    if $__debugFlag; then printf "# variables: %s\n" "${variables[*]}" | tee "$tempEnv" >"$tempEnv.after"; fi
    [ "${#variables[@]}" -eq 0 ] || export "${variables[@]+"${variables[@]}"}"
    ! $__debugFlag || statusMessage --last decorate info "environmentOutput(BEFORE)" "${aa[@]+"${aa[@]}"}" || :
    catchReturn "$__handler" environmentOutput "${aa[@]+"${aa[@]}"}" >>"$tempEnv" || returnClean $? "${clean[@]}" || return $?
    local environmentFile && for environmentFile in "${environmentFiles[@]}"; do
      ! $__debugFlag || statusMessage --last decorate source "$environmentFile" || :
      local __returnCode=0
      set -a
      source "$environmentFile" >(outputTrigger source "$environmentFile") 2>&1 || __returnCode=$?
      set +a
      if $__debugFlag; then
        declare -ax | dumpPipe "declare -ax INSIDE" 1>&2
        declare -x | dumpPipe "declare -x INSIDE" 1>&2
      fi
      [ "$__returnCode" -eq 0 ] || throwEnvironment "$__handler" "source $1 failed with $__returnCode" || returnClean "$__returnCode" "${clean[@]}" || returnUndo $? set +a || return $?
      ! $keepComments || catchReturn "$handler" bashCommentFilter --only <"$environmentFile" | grepSafe -e '^#' >>"$tempEnv.save" || returnClean $? "${clean[@]}" || returnUndo $? set +a || return $?
    done
    if $__debugFlag; then
      declare -ax | dumpPipe "declare -ax OUTSIDE" 1>&2
      declare -x | dumpPipe "declare -x OUTSIDE" 1>&2
    fi
    ! $__debugFlag || statusMessage --last decorate info "environmentOutput(AFTER)" "${aa[@]+"${aa[@]}"}" "${variables[@]+"${variables[@]}"}" || :
    catchReturn "$handler" environmentOutput "${aa[@]+"${aa[@]}"}" "${variables[@]+"${variables[@]}"}" >>"$tempEnv.after" || returnClean $? "${clean[@]}" || return $?
  ) || returnClean $? "${clean[@]}" || return $?
  if $__debugFlag; then
    dumpPipe BEFORE <"$tempEnv" 1>&2
    dumpPipe AFTER <"$tempEnv.after" 1>&2
    decorate info DIFF 1>&2
    diff -U0 "$tempEnv" "$tempEnv.after" 1>&2
    decorate success RESULT 1>&2
  fi
  [ ! -f "$tempEnv.save" ] || catchEnvironment "$handler" cat "$tempEnv.save" || return $?
  diff -U0 "$tempEnv" "$tempEnv.after" | grepSafe '^+' | cut -c 2- | grepSafe -v '^+' | sort -u || returnClean $? "${clean[@]}" || return 0
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
}
_environmentCompile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentFileIsDocker() {
  local file result=0 pattern='\$|="|='"'"
  for file in "$@"; do
    [ "$file" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    if grep -q -E -e "$pattern" "$file"; then
      grep -E -e "$pattern" "$file" 1>&2
      result=1
    fi
  done
  return "$result"
}
_environmentFileIsDocker() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__anyEnvToFunctionEnv() {
  local handler="$1" passConvertFunction="$2" failConvertFunction="$3" && shift 3
  if [ $# -gt 0 ]; then
    local file
    for file in "$@"; do
      if [ "$file" = "--help" ]; then
        "$handler" 0
        return 0
      fi
      if environmentFileIsDocker "$file" 2>/dev/null; then
        catchEnvironment "$handler" "$passConvertFunction" <"$file" || return $?
      else
        catchEnvironment "$handler" "$failConvertFunction" <"$file" || return $?
      fi
    done
  else
    local temp
    temp=$(fileTemporaryName "$handler") || return $?
    catchEnvironment "$handler" muzzle tee "$temp" || returnClean $? "$temp" || return $?
    catchReturn "$handler" __anyEnvToFunctionEnv "$handler" "$passConvertFunction" "$failConvertFunction" "$temp" || returnClean $? "$temp" || return $?
    catchEnvironment "$handler" rm "$temp" || return $?
    return 0
  fi
}
environmentFileToDocker() {
  __anyEnvToFunctionEnv "_${FUNCNAME[0]}" bashCommentFilter environmentFileBashCompatibleToDocker "$@" || return $?
}
_environmentFileToDocker() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentFileToBashCompatible() {
  __anyEnvToFunctionEnv "_${FUNCNAME[0]}" environmentFileDockerToBashCompatible cat "$@" || return $?
}
_environmentFileToBashCompatible() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
environmentFileDockerToBashCompatible() {
  local handler="_${FUNCNAME[0]}"
  local file index envLine result=0
  if [ $# -eq 0 ]; then
    __internalEnvironmentFileDockerToBashCompatiblePipe
  else
    for file in "$@"; do
      if [ "$file" = "--help" ]; then
        "$handler" 0
        return $?
      fi
      [ -f "$file" ] || throwArgument "$handler" "Not a file $file" || return $?
      __internalEnvironmentFileDockerToBashCompatiblePipe <"$file" || return $?
    done
  fi
}
_environmentFileDockerToBashCompatible() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__internalEnvironmentFileDockerToBashCompatiblePipe() {
  local result=0 index=0
  local envLine
  while IFS="" read -r envLine; do
    case "$envLine" in
    [[:space:]]*[#]* | [#]* | "")
      printf -- "%s\n" "$envLine"
      ;;
    *)
      local name value
      name="${envLine%%=*}"
      value="${envLine#*=}"
      if [ -n "$name" ] && [ "$name" != "$envLine" ]; then
        case "$name" in [^[:alpha:]_]* | *[^[:alnum:]_]]*)
          returnArgument "Invalid name at line $index: $name" || result=$?
          ;;
        *) printf -- "%s=\"%s\"\n" "$name" "$(escapeDoubleQuotes "$value")" ;;
        esac
      else
        returnArgument "Invalid line $index: $envLine" || result=$?
      fi
      ;;
    esac
    index=$((index + 1))
  done
  return $result
}
environmentFileBashCompatibleToDocker() {
  local handler="_${FUNCNAME[0]}"
  local tempFile
  tempFile=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempFile")
  if [ $# -eq 0 ]; then
    catchEnvironment "$handler" muzzle tee "$tempFile.bash" || returnClean $? "${clean[@]}" || return $?
    clean+=("$tempFile.bash")
    set -- "$tempFile.bash"
  fi
  local file
  for file in "$@"; do
    if [ "$file" = "--help" ]; then
      "$handler" 0 && returnClean $? "${clean[@]}" && return $? || return $?
    fi
    [ -f "$file" ] || throwArgument "$handler" "Not a file $file" || returnClean $? "${clean[@]}" || return $?
    env -i bash -c "set -eoua pipefail; source \"$file\"; declare -px; declare -pa" >"$tempFile" 2>&1 | outputTrigger --name "$file" || throwArgument "$handler" "$file is not a valid bash file" || returnClean $? "${clean[@]}" || return $?
  done
  while IFS='' read -r envLine; do
    local name=${envLine%%=*} value=${envLine#*=}
    printf -- "%s=%s\n" "$name" "$(unquote '"' "$value")"
  done < <(removeFields 2 <"$tempFile" | grep -E -v '^(UID|OLDPWD|PWD|_|SHLVL|FUNCNAME|PIPESTATUS|DIRSTACK|GROUPS)\b|^(BASH_)' || :)
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
}
_environmentFileBashCompatibleToDocker() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
rsyncInstall() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  packageWhich rsync
}
_rsyncInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitInstall() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  packageWhich git git "$@"
}
_gitInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitUninstall() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  packageWhichUninstall git git "$@"
}
_gitUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitEnsureSafeDirectory() {
  local handler="_${FUNCNAME[0]}"
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    [ -d "$1" ] || throwArgument "$handler" "$1 is not a directory" || return $?
    if ! git config --global --get safe.directory | grep -q "$1"; then
      catchEnvironment "$handler" git config --global --add safe.directory "$1" || return $?
    fi
    shift
  done
}
_gitEnsureSafeDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitTagDelete() {
  local handler="_${FUNCNAME[0]}"
  local exitCode=0
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      export GIT_REMOTE
      catchReturn "$handler" buildEnvironmentLoad GIT_REMOTE || return $?
      usageRequireEnvironment "$handler" GIT_REMOTE || return $?
      catchArgument "$handler" git tag -d "$argument" || exitCode=$?
      catchArgument "$handler" git push "${GIT_REMOTE-}" :"$argument" || exitCode=$?
      ;;
    esac
    shift
  done
  return "$exitCode"
}
_gitTagDelete() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitTagAgain() {
  local handler="_${FUNCNAME[0]}" a=("$@")
  [ $# -gt 0 ] || throwArgument "$handler" "No arguments" || return $?
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
    statusMessage decorate info "Deleting tag $1 ..."
    catchArgument "$handler" gitTagDelete "$1" || return $?
    statusMessage decorate info "Tagging again $1 ..."
    catchArgument "$handler" git tag "$1" || return $?
    catchArgument "$handler" git push --tags || return $?
  done
  statusMessage --last decorate info "All tags completed" "$(decorate orange "${a[@]}")"
}
_gitTagAgain() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitVersionList() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ -d "./.git" ] || throwEnvironment "$handler" "No .git directory at $(pwd), stopping" || return $?
  catchEnvironment "$handler" git tag | grep -e '^v[0-9.]*$' | versionSort "$@" || return $?
}
_gitVersionList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitVersionLast() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local skip
  if [ -n "${1-}" ]; then
    skip="$1"
    shift
    gitVersionList "$@" | grep -v "$skip" | tail -1
  else
    gitVersionList "$@" | tail -1
  fi
}
_gitVersionLast() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
veeGitTag() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local tagName
  tagName=$(validate "$handler" String "tagName" "${1-}") || return $?
  [ "$tagName" = "${tagName#v}" ] || throwArgument "$handler" "already v'd': $(decorate value "$tagName")" || return $?
  catchEnvironment "$handler" git tag "v$tagName" "$tagName" || return $?
  catchEnvironment "$handler" git tag -d "$tagName" || return $?
  catchEnvironment "$handler" git push origin "v$tagName" ":$tagName" || return $?
  catchEnvironment "$handler" git fetch -q --prune --prune-tags || return $?
}
_veeGitTag() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitRemoveFileFromHistory() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch $1" HEAD
}
_gitRemoveFileFromHistory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitRepositoryChanged() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  ! git diff-index --quiet HEAD 2>/dev/null
}
_gitRepositoryChanged() {
  true || gitRepositoryChanged --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitShowChanges() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  git diff-index --name-only HEAD
}
_gitShowChanges() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitShowStatus() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  git diff-index --name-status "$@" HEAD
}
_gitShowStatus() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitInsideHook() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  [ -n "${GIT_EXEC_PATH-}" ] && [ -n "${GIT_INDEX_FILE-}" ]
}
_gitInsideHook() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitRemoteHosts() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local remoteUrl host
  while read -r remoteUrl; do
    host=$(urlParseItem host "$remoteUrl") || host=$(urlParseItem host "git://$remoteUrl") || throwArgument "$handler" "Unable to extract host from \"$remoteUrl\"" || return $?
    printf -- "%s\n" "$host"
  done < <(git remote -v | awk '{ print $2 }')
}
_gitRemoteHosts() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitTagVersion() {
  local handler="_${FUNCNAME[0]}"
  local versionSuffix=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --suffix) shift && versionSuffix=$(validate "$handler" String "$argument" "${1-}") ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift || throwArgument "$handler" "shift $argument" || return $?
  done
  local maximumTagsPerVersion
  maximumTagsPerVersion=$(catchReturn "$handler" buildEnvironmentGet BUILD_MAXIMUM_TAGS_PER_VERSION) || return $?
  local init start
  init=$(timingStart) || return $?
  start=$init
  statusMessage decorate info "Pulling tags from origin "
  catchEnvironment "$handler" git pull --tags origin >/dev/null || return $?
  statusMessage timingReport "$start" "Pulled tags in"
  statusMessage decorate info "Pulling tags from origin "
  catchEnvironment "$handler" git pull --tags origin >/dev/null || return $?
  statusMessage timingReport "$start" "Pulled tags in"
  local currentVersion previousVersion releaseNotes
  local tagPrefix index tryVersion
  currentVersion=$(catchEnvironment "$handler" hookRun version-current) || return $?
  if ! previousVersion=$(gitVersionLast "$currentVersion"); then
    previousVersion="none"
  fi
  if git show-ref --tags "$currentVersion" --quiet; then
    decorate error "Version $currentVersion already exists, already tagged." 1>&2
    return 16
  fi
  if [ "$previousVersion" = "$currentVersion" ]; then
    decorate error "Version $currentVersion up to date, nothing to do." 1>&2
    return 17
  fi
  printf -- "%s %s\n%s %s\n" \
    "$(decorate label "Previous version is: ")" "$(decorate value "$previousVersion")" \
    "$(decorate label " Release version is: ")" "$(decorate value "$currentVersion")"
  releaseNotes="$(releaseNotes "$currentVersion")" || throwEnvironment "$handler" "releaseNotes $currentVersion failed" || return $?
  if [ ! -f "$releaseNotes" ]; then
    decorate error "Version $currentVersion no release notes \"$releaseNotes\" found, stopping." 1>&2
    return 18
  fi
  local tagFile clean=()
  tagFile=$(fileTemporaryName "$handler") || return $?
  clean=("$tagFile")
  versionSuffix=${versionSuffix:-${BUILD_VERSION_SUFFIX:-rc}}
  tagPrefix="$currentVersion$versionSuffix"
  catchEnvironment "$handler" git show-ref --tags | removeFields 1 | catchEnvironment "$handler" muzzle tee -a "$tagFile" || returnClean $? "${clean[@]}" || return $?
  index=0
  while true; do
    tryVersion="$tagPrefix$index"
    if ! grep -q "$tryVersion" "$tagFile"; then
      break
    fi
    index=$((index + 1))
    [ $index -lt "$maximumTagsPerVersion" ] || throwEnvironment "$handler" "Tag version exceeded maximum of $maximumTagsPerVersion" || returnClean $? "${clean[@]}" || return $?
  done
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  statusMessage decorate info "Tagging version $(decorate code "$tryVersion") ... " || return $?
  catchEnvironment "$handler" git tag "$tryVersion" || return $?
  statusMessage decorate info "Pushing version $(decorate code "$tryVersion") ... " || return $?
  catchEnvironment "$handler" git push --tags --quiet || return $?
  statusMessage decorate info "Fetching version $(decorate code "$tryVersion") ... " || return $?
  catchEnvironment "$handler" git fetch -q || return $?
  statusMessage --last timingReport "$init" "Tagged version completed in" || return $?
}
_gitTagVersion() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitFindHome() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  __directoryParent "$handler" --pattern ".git" "$@"
}
_gitFindHome() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitCommit() {
  local handler="_${FUNCNAME[0]}"
  local appendLast=false updateReleaseNotes=true comment="" home="" openLinks=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --home)
      shift
      home=$(validate "$handler" Directory "home" "${1-}") || return $?
      ;;
    --)
      updateReleaseNotes=false
      ;;
    --last)
      appendLast=true
      ;;
    --open-links)
      openLinks=true
      ;;
    *)
      comment="$*"
      break
      ;;
    esac
    shift
  done
  if ! isBoolean "$openLinks"; then
    openLinks=$(catchReturn "$handler" buildEnvironmentGet GIT_OPEN_LINKS) || return $?
  fi
  isBoolean "$openLinks" || openLinks=false
  if [ "$comment" = "last" ]; then
    appendLast=true
    comment=
  fi
  local start
  start="$(pwd -P 2>/dev/null)" || throwEnvironment "$handler" "Failed to get pwd" || return $?
  if [ -z "$home" ]; then
    home=$(gitFindHome "$start") || throwEnvironment "$handler" "Unable to find git home" || return $?
    buildEnvironmentContext "$home" gitCommit --home "$home" "${__saved[@]+"${__saved[@]}"}" || return $?
    return 0
  fi
  catchEnvironment "$handler" cd "$home" || return $?
  gitRepositoryChanged || throwEnvironment "$handler" "No changes to commit" || return $?
  local notes
  notes="$(releaseNotes)" || throwEnvironment "$handler" "No releaseNotes?" || return $?
  if $updateReleaseNotes && [ -n "$comment" ]; then
    statusMessage decorate info "Updating release notes ..."
    catchReturn "$handler" __gitCommitReleaseNotesUpdate "$handler" "$notes" "$comment" || return $?
  elif [ -z "$comment" ]; then
    comment=$(__gitCommitReleaseNotesGetLastComment "$handler" "$notes") || return $?
    [ -z "$comment" ] || printf -- "%s %s:\n%s\n" "$(decorate info "Using last release note line from")" "$(decorate file "$notes")" "$(consoleHeadingBoxed "$comment")"
  fi
  outputHandler="cat"
  ! $openLinks || outputHandler="urlOpener"
  if $appendLast || [ -z "$comment" ]; then
    statusMessage decorate info "Using last commit message ... ($(decorate subtle "$outputHandler"))"
    catchEnvironment "$handler" git commit --reuse-message=HEAD --reset-author -a 2>&1 | "$outputHandler" || return $?
  else
    statusMessage decorate info "Using commit comment \"$comment\" ... ($(decorate subtle "$outputHandler"))"
    catchEnvironment "$handler" git commit -a -m "$comment" 2>&1 | "$outputHandler" || return $?
  fi
  catchEnvironment "$handler" cd "$start" || return $?
  return 0
}
__gitCommitReleaseNotesUpdate() {
  local handler="$1" notes="$2" comment="$3"
  local pattern
  home=$(catchReturn "$handler" buildHome) || return $?
  pattern="$(quoteGrepPattern "$comment")"
  catchEnvironment "$handler" statusMessage --last printf -- "%s%s\n" "$(consoleHeadingLine '.' "$(decorate label "Release notes") $(decorate file "$notes") $(decorate decoration --)")" "$(decorate reset --)" || return $?
  if ! grep -q -e "$pattern" "$notes"; then
    local prefix=""
    fileEndsWithNewline "$notes" || prefix=$'\n'
    catchEnvironment "$handler" printf -- "%s%s %s\n" "$prefix" "-" "$comment" >>"$notes" || return $?
    printf -- "%s %s:\n%s\n" "$(decorate info "Adding comment to")" "$(decorate file "$notes")" "$(consoleHeadingBoxed "$comment")"
    catchEnvironment "$handler" git add "$notes" || return $?
    catchEnvironment "$handler" grep -B 10 -e "$pattern" "$notes" | decorate code || return $?
  else
    catchEnvironment "$handler" statusMessage printf -- "%s %s:\n" "$(decorate info "Comment already added to")" "$(decorate code "$notes")" || return $?
    catchEnvironment "$handler" grep -q -e "$pattern" "$notes" | decorate code || return $?
  fi
}
__gitCommitReleaseNotesGetLastComment() {
  local handler="$1" notes="$2"
  grep -e '^- ' "$notes" | tail -n 1 | cut -c 3-
}
_gitCommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitMainly() {
  local handler="_${FUNCNAME[0]}"
  local argument
  local branch returnCode updateOther
  local verboseFlag remote="origin"
  local errorLog
  verboseFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --remote)
      shift
      remote=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    --verbose)
      verboseFlag=true
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift || throwArgument "$handler" "missing argument $(decorate label "$argument")" || return $?
  done
  errorLog=$(fileTemporaryName "$handler") || return $?
  branch=$(git rev-parse --abbrev-ref HEAD) || returnEnvironment "Git not present" || return $?
  case "$branch" in
  main | staging)
    throwEnvironment "$handler" "Already in branch $(decorate code "$branch")" || return $?
    ;;
  HEAD)
    throwEnvironment "$handler" "Ignore branches named $(decorate code "$branch")" || return $?
    ;;
  *)
    returnCode=0
    for updateOther in staging main; do
      ! $verboseFlag || decorate info git checkout "$updateOther"
      if ! git checkout "$updateOther" >"$errorLog" 2>&1; then
        printf -- "%s %s\n" "$(decorate error "Unable to checkout branch")" "$(decorate code "$updateOther")" 1>&2
        returnCode=1
        catchEnvironment "$handler" git status -s || :
        break
      else
        ! $verboseFlag || decorate info git pull "# ($updateOther)"
        if ! catchEnvironment "$handler" git pull "$remote" "$updateOther" >"$errorLog" 2>&1; then
          printf -- "%s %s\n" "$(decorate error "Unable to pull branch")" "$(decorate code "$updateOther")" 1>&2
          ! $verboseFlag || dumpPipe errors <"$errorLog"
          returnCode=1
          break
        fi
      fi
    done
    if [ "$returnCode" -ne 0 ]; then
      catchEnvironment "$handler" git checkout -f "$branch" || :
      rm -rf "$errorLog"
      return "$returnCode"
    fi
    ! $verboseFlag || decorate info git checkout "$branch"
    if ! catchEnvironment "$handler" git checkout "$branch" >"$errorLog" 2>&1; then
      printf -- "%s %s\n" "$(decorate error "Unable to switch BACK to branch")" "$(decorate code "$updateOther")" 1>&2
      rm -rf "$errorLog"
      return 1
    fi
    ! $verboseFlag || decorate info git merge -m
    catchEnvironment "$handler" muzzle git merge -m "Merging staging and main with $branch" origin/staging origin/main || return $?
    if grep -q 'Already' "$errorLog"; then
      printf -- "%s %s\n" "$(decorate info "Already up to date")" "$(decorate code "$branch")"
    else
      printf -- "%s %s\n" "$(decorate info "Merged staging and main into branch")" "$(decorate code "$branch")"
    fi
    rm -rf "$errorLog"
    ;;
  esac
}
_gitMainly() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitCommitHash() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchEnvironment "$handler" git rev-parse --short HEAD || return $?
}
_gitCommitHash() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitCurrentBranch() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchEnvironment "$handler" git symbolic-ref --short HEAD || return $?
}
_gitCurrentBranch() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitHasAnyRefs() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local count
  count=$(catchEnvironment "$handler" git show-ref | grep -c refs/tags) || return $?
  [ $((0 + count)) -gt 0 ]
}
_gitHasAnyRefs() {
  true || gitHasAnyRefs --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitHookTypes() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf -- "%s " pre-commit pre-push pre-merge-commit pre-rebase pre-receive update post-update post-commit
}
_gitHookTypes() {
  true || gitHookTypes --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitInstallHooks() {
  local hook
  local argument
  local handler="_${FUNCNAME[0]}"
  local types home
  home=$(catchReturn "$handler" buildHome) || return $?
  local verbose=false hookNames=()
  read -r -a types < <(gitHookTypes) || :
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --copy)
      execute=false
      ;;
    --verbose)
      verbose=true
      ;;
    --application)
      shift || throwArgument "$handler" "missing $argument argument" || return $?
      home=$(validate "$handler" Directory "applicationHome" "$1") || return $?
      ;;
    *)
      hook="$argument"
      if inArray "$hook" "${types[@]}"; then
        hookNames+=("$hook")
      else
        throwArgument "$handler" "Unknown hook:" "$argument" "Allowed:" "${types[@]}" || return $?
      fi
      ;;
    esac
    shift
  done
  if [ ${#hookNames[@]} -eq 0 ]; then
    hookNames=("${types[@]}")
  fi
  for hook in "${hookNames[@]}"; do
    if hasHook --application "$home" "git-$hook"; then
      catchEnvironment "$handler" gitInstallHook --application "$home" --copy "$hook" || return $?
      ! $verbose || decorate success "Installed $(decorate value "$hook")" || :
    fi
  done
}
_gitInstallHooks() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitInstallHook() {
  local handler="_${FUNCNAME[0]}"
  local execute=true verbose=false home="" types=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --copy) execute=false ;;
    --verbose) verbose=true ;;
    --application) shift && home=$(validate "$handler" Directory "applicationHome" "$1") || return $? ;;
    *)
      [ "${#types[@]}" -gt 0 ] || read -r -a types < <(gitHookTypes) || :
      [ -n "$home" ] || home=$(catchReturn "$handler" buildHome) || return $?
      if inArray "$argument" "${types[@]}"; then
        local fromTo relFromTo item
        hasHook --application "$home" "git-$argument" || throwArgument "$handler" "Hook git-$argument does not exist (Home: $home)" || return $?
        fromTo=("$(hookFind --application "$home" "git-$argument")" "$home/.git/hooks/$argument") || throwEnvironment "$handler" "Unable to hookFind git-$argument (Home: $home)" || rewturn $?
        relFromTo=()
        home="${home%/}/"
        for item in "${fromTo[@]}"; do
          item="${item#"$home"}"
          relFromTo+=("./$item")
        done
        if [ -f "${fromTo[1]}" ]; then
          if diff -q "${fromTo[@]}" >/dev/null; then
            ! $verbose || decorate pair 15 "No changes:" "${relFromTo[@]}"
            return 0
          fi
          ! $verbose || decorate pair 15 "Changed:" "${relFromTo[@]}"
        else
          ! $verbose || decorate pair 15 "Installing" "${relFromTo[1]}"
        fi
        statusMessage --last printf "%s %s -> %s\n" "$(decorate success "git hook:")" "$(decorate warning "${relFromTo[0]}")" "$(decorate code "${relFromTo[1]}")" || :
        catchEnvironment "$handler" cp -f "${fromTo[@]}" || return $?
        ! $execute || catchEnvironment "$handler" exec "${fromTo[1]}" "$@" || return $?
        return 0
      else
        throwArgument "$handler" "Unknown hook:" "$argument" "Allowed:" "${types[@]}" || return $?
      fi
      ;;
    esac
    shift
  done
}
_gitInstallHook() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__gitPreCommitCache() {
  local handler="$1" && shift
  local directory create="${1-}" name
  name="pre-commit.$(catchEnvironment "$handler" whoami)" || return $?
  directory=$(catchReturn "$handler" buildCacheDirectory "$name") || return $?
  [ "$create" != "true" ] || [ -d "$directory" ] || catchEnvironment "$handler" mkdir -p "$directory" || return $?
  printf "%s\n" "$directory"
}
gitPreCommitSetup() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local directory total=0
  directory=$(catchReturn "$handler" __gitPreCommitCache "$handler" true) || return $?
  catchEnvironment "$handler" git diff --name-only --cached --diff-filter=ACMR | catchEnvironment "$handler" fileExtensionLists --clean "$directory" || return $?
  total=$(catchReturn "$handler" fileLineCount "$directory/@") || return $?
  if [ "$total" -eq 0 ]; then
    catchReturn "$handler" rm -rf "$directory" || return $?
    throwEnvironment "$handler" "No files to commit." || return $?
  fi
}
_gitPreCommitSetup() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitPreCommitHeader() {
  local handler="_${FUNCNAME[0]}" width=5
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local directory total color
  directory=$(catchReturn "$handler" __gitPreCommitCache "$handler" true) || return $?
  [ -f "$directory/@" ] || throwEnvironment "$handler" "$directory/@ missing" || return $?
  total=$(catchReturn "$handler" fileLineCount "$directory/@") || return $?
  statusMessage --last printf -- "%s: %s\n" "$(decorate success "$(textAlignRight "$width" "all")")" "$(decorate info "$total $(plural "$total" file files) changed")"
  while [ $# -gt 0 ]; do
    local extension="$1" label="$1"
    case "$extension" in
    @) label="all" ;;
    !) label="none" ;;
    [[:alnum:]][[:alnum:]]*) ;;
    *) throwArgument "$handler" "Invalid extension characters: $extension" || return $? ;;
    esac
    total=0
    color="warning"
    if [ -f "$directory/$extension" ]; then
      total=$(catchReturn "$handler" fileLineCount "$directory/$extension") || return $?
      color="success"
    fi
    printf "%s: %s\n" "$(decorate "$color" "$(textAlignRight "$width" "$label")")" "$(decorate info "$total $(plural "$total" file files) changed")"
    shift
  done
}
_gitPreCommitHeader() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitPreCommitHasExtension() {
  local handler="_${FUNCNAME[0]}"
  local directory
  directory=$(catchReturn "$handler" __gitPreCommitCache "$handler" true) || return $?
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
    [ -f "$directory/$1" ] || return 1
    shift
  done
}
_gitPreCommitHasExtension() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitPreCommitExtensionList() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local directory
  directory=$(catchReturn "$handler" __gitPreCommitCache "$handler" true) || return $?
  find "$directory" -maxdepth 1 -type f -exec basename {} \; | sort || return $?
}
_gitPreCommitExtensionList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitPreCommitListExtension() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local directory
  directory=$(catchReturn "$handler" __gitPreCommitCache "$handler" true) || return $?
  while [ $# -gt 0 ]; do
    [ -f "$directory/$1" ] || throwEnvironment "$handler" "No files with extension $1" || return $?
    catchEnvironment "$handler" cat "$directory/$1" || return $?
    shift
  done | sort
}
_gitPreCommitListExtension() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitPreCommitCleanup() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local directory
  directory=$(catchReturn "$handler" __gitPreCommitCache "$handler") || return $?
  [ ! -d "$directory" ] || catchEnvironment "$handler" rm -rf "$directory" || return $?
}
_gitPreCommitCleanup() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitBranchExists() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || throwArgument "$handler" "Requires at least one branch name" || return $?
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
    if ! gitBranchExistsLocal "$1" && ! gitBranchExistsRemote "$1"; then
      return 1
    fi
    shift
  done
}
_gitBranchExists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitBranchExistsLocal() {
  local handler="_${FUNCNAME[0]}"
  local branch
  [ $# -gt 0 ] || throwArgument "$handler" "Requires at least one branch name" || return $?
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
    branch=$(catchEnvironment "$handler" git branch --list "$1") || return $?
    [ -n "$branch" ] || return 1
    shift
  done
}
_gitBranchExistsLocal() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitBranchExistsRemote() {
  local handler="_${FUNCNAME[0]}"
  local branch
  export GIT_REMOTE
  catchReturn "$handler" buildEnvironmentLoad GIT_REMOTE || return $?
  [ -n "$GIT_REMOTE" ] || catchEnvironment "$handler" "GIT_REMOTE requires a value" || return $?
  [ $# -gt 0 ] || throwArgument "$handler" "Requires at least one branch name" || return $?
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
    branch=$(catchEnvironment "$handler" git ls-remote --heads "$GIT_REMOTE" "$1") || return $?
    [ -n "$branch" ] || return 1
    shift
  done
}
_gitBranchExistsRemote() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitBranchify() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local version user format branchName currentBranch
  export GIT_BRANCH_FORMAT GIT_REMOTE
  muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" whoami || return $?
  catchReturn "$handler" buildEnvironmentLoad GIT_BRANCH_FORMAT GIT_REMOTE || return $?
  [ -n "$GIT_REMOTE" ] || catchEnvironment "$handler" "GIT_REMOTE requires a value" || return $?
  version=$(catchEnvironment "$handler" hookVersionCurrent) || return $?
  user=$(catchEnvironment "$handler" whoami) || return $?
  format="${BUILD_BRANCH_FORMAT-}"
  [ -n "$format" ] || format="{version}-{user}"
  branchName="$(version=$version user=$user mapEnvironment < <(printf "%s\n" "$format"))"
  [ -n "$branchName" ] || throwEnvironment "$handler" "BUILD_BRANCH_FORMAT=\"$BUILD_BRANCH_FORMAT\" -> \"$format\" made blank branch (user=$user version=$version)" || return $?
  if gitBranchExists "$branchName"; then
    currentBranch=$(catchEnvironment "$handler" gitCurrentBranch) || return $?
    if [ "$currentBranch" != "$branchName" ]; then
      if ! muzzle git checkout "$branchName" 2>&1; then
        throwEnvironment "$handler" "Local changes in $(decorate value "$currentBranch") prevent switching to $(decorate code "$branchName") due to local changes" || return $?
      fi
      decorate success "Switched to $(decorate code "$branchName")"
    else
      decorate success "Branch is $(decorate code "$branchName")"
    fi
  else
    catchEnvironment "$handler" git checkout -b "$branchName" || return $?
    catchEnvironment "$handler" git push -u "$GIT_REMOTE" "$branchName" || return $?
    printf "%s %s %s%s%s\n" "$(decorate success "Branch is")" "$(decorate code "$branchName")" "$(decorate info "(pushed to ")" "$(decorate value "$GIT_REMOTE")" "$(decorate info ")")"
  fi
}
_gitBranchify() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
gitBranchMergeCurrent() {
  local handler="_${FUNCNAME[0]}"
  local targetBranch="" comment="" addIP=true
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --skip-ip)
      addIP=false
      ;;
    --comment)
      shift
      comment=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    *)
      [ -z "$targetBranch" ] || throwArgument "$handler" "Only one target branch should be specified: $targetBranch and $argument?" || return $?
      targetBranch="$(validate "$handler" String "$argument" "$1")" || return $?
      ;;
    esac
    shift
  done
  [ -n "$targetBranch" ] || throwArgument "$handler" "branch required" || return $?
  if [ -z "$comment" ]; then
    comment="${FUNCNAME[0]} by $(whoami) on $(hostname)"
  fi
  if $addIP; then
    comment="$comment @ $(ipLookup || printf "%s" "$? <- ipLookup failed")" 2>/dev/null
  fi
  local currentBranch
  currentBranch=$(catchEnvironment "$handler" gitCurrentBranch) || return $?
  if [ "$currentBranch" = "$targetBranch" ]; then
    throwEnvironment "$handler" "Already on $(decorate code "$targetBranch") branch" || return $?
  fi
  catchEnvironment "$handler" git checkout "$targetBranch" || return $?
  catchEnvironment "$handler" git merge -m "$comment" "$branch" || returnUndo $? git checkout --force "$branch" || return $?
  catchEnvironment "$handler" git push || returnUndo $? git checkout --force "$branch" || return $?
  catchEnvironment "$handler" git checkout "$branch" || return $?
}
_gitBranchMergeCurrent() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__githubAPI() {
  local handler="$1" query="$2" suffix="${3-}" && shift 3
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ $# -gt 0 ] || throwArgument "$handler" "projectName required" || return $?
  if ! packageWhich curl curl; then
    throwEnvironment "$handler" "curl is a required dependency" || return $?
  fi
  local accessToken hh=() details=()
  accessToken=$(catchReturn "$handler" buildEnvironmentGet GITHUB_ACCESS_TOKEN) || return $?
  if [ -n "$accessToken" ]; then
    hh+=(-H "Authorization: token $accessToken")
    details+=("$(decorate green Authenticated)")
  fi
  local errorFile
  errorFile=$(fileTemporaryName "$handler") || return $?
  while [ $# -gt 0 ]; do
    local url="https://api.github.com/repos/$1$suffix"
    if ! curl "${hh[@]+"${hh[@]}"}" -o - -s "$url" 2>>"$errorFile" | jq -r "$query" 2>>"$errorFile"; then
      throwEnvironment "$handler" "API call failed for $1 ($(decorate code "$url"))"$'\n'"${details[*]-}"$'\n'"$(dumpPipe Errors <"$errorFile")" || returnClean $? "$errorFile" || return $?
    fi
    shift
  done
  catchEnvironment "$handler" rm -rf "$errorFile" || return $?
}
__githubLatestVariable() {
  local handler="$1" query="$2" && shift 2
  __githubAPI "$handler" "$query" "/releases/latest" "$@"
}
githubURLParse() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || throwArgument "$handler" "url required" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local url path
      url=$(validate "$handler" URL "url" "$1") || return $?
      local host
      host=$(urlParseItem host "$url") || return $?
      if [ "$host" != "github.com" ]; then
        throwArgument "$handler" "Not a github site: $(decorate code "$url")" || return $?
      fi
      path=$(urlParseItem path "$url") || return $?
      path="${path#/}"
      path="${path%/}"
      local owner repository _
      IFS='/' read -d '' -r owner repository _ <<<"$path" || :
      [ -n "$owner" ] || throwArgument "handler" "Blank owner" || return $?
      [ -n "$repository" ] || throwArgument "handler" "Blank repository" || return $?
      printf "%s/%s\n" "$owner" "$repository"
      ;;
    esac
    shift
  done
}
_githubURLParse() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
githubPublishDate() {
  local handler="_${FUNCNAME[0]}"
  __githubLatestVariable "$handler" ".published_at" "$@"
}
_githubPublishDate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
githubLatestRelease() {
  local handler="_${FUNCNAME[0]}"
  __githubLatestVariable "$handler" ".name" "$@"
}
_githubLatestRelease() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
githubProjectJSON() {
  local handler="_${FUNCNAME[0]}"
  __githubLatestVariable "$handler" "." "$@"
}
_githubProjectJSON() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
githubLatest() {
  local handler="_${FUNCNAME[0]}"
  __githubAPI "$handler" "." "" "$@"
}
_githubLatest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
githubRelease() {
  local handler="_${FUNCNAME[0]}"
  export GITHUB_ACCESS_TOKEN
  export GITHUB_ACCESS_TOKEN_EXPIRE
  export GITHUB_REPOSITORY_OWNER
  export GITHUB_REPOSITORY_NAME
  local extras=() accessTokenExpire="${GITHUB_ACCESS_TOKEN_EXPIRE-}" accessToken="${GITHUB_ACCESS_TOKEN-}" repoOwner="${GITHUB_REPOSITORY_OWNER-}" repoName="${GITHUB_REPOSITORY_NAME-}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --token)
      shift
      [ -n "${1-}" ] || throwArgument "$handler" "Blank $argument argument" || return $?
      accessToken="$1"
      ;;
    --owner)
      shift
      [ -n "${1-}" ] || throwArgument "$handler" "Blank $argument argument" || return $?
      repoOwner="$1"
      ;;
    --name)
      shift
      [ -n "${1-}" ] || throwArgument "$handler" "Blank $argument argument" || return $?
      repoName="$1"
      ;;
    --expire)
      shift
      [ -n "${1-}" ] || throwArgument "$handler" "Blank $argument argument" || return $?
      accessTokenExpire="$1"
      ;;
    *) extras+=("$1") ;;
    esac
    shift
  done
  local descriptionFile releaseName commitish resultsFile
  [ ${#extras[@]} -eq 3 ] || throwArgument "$handler" "Need: descriptionFile releaseName commitish, found ${#extras[@]} arguments" || return $?
  descriptionFile="${extras[0]}"
  releaseName="${extras[1]}"
  commitish="${extras[2]}"
  isUpToDate --name "GITHUB_ACCESS_TOKEN_EXPIRE" "$accessTokenExpire" 0 || throwEnvironment "$handler" "Need to update the GitHub access token, expired" || return $?
  [ -f "$descriptionFile" ] || throwEnvironment "$handler" "Description file $descriptionFile is not a file" || return $?
  [ -n "$repoOwner" ] || throwArgument "$handler" "Repository owner is blank" || return $?
  [ -n "$repoName" ] || throwArgument "$handler" "Repository name is blank" || return $?
  [ -n "$accessToken" ] || throwArgument "$handler" "Access token is blank" || return $?
  catchReturn "$handler" packageWhich curl curl || return $?
  local host=github.com
  catchEnvironment "$handler" sshKnownHostAdd "$host" || return $?
  if git remote | grep -q github; then
    printf "%s %s %s" "$(decorate info Remote)" "$(decorate magenta github)" "$(decorate info exists, not adding again.) " || :
  else
    catchEnvironment "$handler" git remote add github "git@github.com:$repoOwner/$repoName.git" || return $?
  fi
  catchEnvironment "$handler" hookRunOptional github-release-before || return $?
  resultsFile="$(buildCacheDirectory)/results.json" || throwEnvironment "$handler" "Unable create cache directory" || return $?
  decorate decoration "$(consoleLine)" || :
  bigText "$releaseName" | decorate magenta
  decorate decoration "$(consoleLine)" || :
  printf "%s %s (%s) %s\n" "$(decorate green Tagging)" "$(decorate code "$releaseName")" "$(decorate magenta "$commitish")" "$(decorate green "and pushing ... ")" || :
  local start
  start=$(timingStart)
  statusMessage decorate warning "Deleting any trace of the $releaseName tag"
  git tag -d "$releaseName" 2>/dev/null || :
  git push origin ":$releaseName" --quiet 2>/dev/null || :
  git push github ":$releaseName" --quiet 2>/dev/null || :
  catchEnvironment "$handler" git tag "$releaseName" || return $?
  catchEnvironment "$handler" git push origin --tags --quiet || return $?
  catchEnvironment "$handler" git push github --tags --force --quiet || return $?
  catchEnvironment "$handler" git push github --all --force --quiet || return $?
  timingReport "$start" "Completed in" || :
  local JSON
  JSON='{"draft":false,"prerelease":false,"generate_release_notes":false}'
  JSON="$(echo "$JSON" | jq --arg name "$releaseName" --rawfile desc "$descriptionFile" '. + {body: $desc, tag_name: $name, name: $name}')" || throwEnvironment "$handler" "Generating JSON" || return $?
  decorate info
  if ! curl -s -L \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: token $accessToken" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/$repoOwner/$repoName/releases" \
    -d "$JSON" >"$resultsFile"; then
    decorate error "POST failed to GitHub" 1>&2 || :
    decorate code <<<"$JSON" | decorate wrap "$(decorate info "JSON: ")" 1>&2
    dumpPipe results <"$resultsFile" 1>&2 || return $?
  fi
  url="$(jq .html_url <"$resultsFile")"
  if [ -z "$url" ] || [ "$url" = "null" ]; then
    decorate error "Results had no html_url" 1>&2 || :
    decorate error "Access token length ${#accessToken}" 1>&2 || :
    decorate code <<<"$JSON" | decorate wrap "$(decorate info "Submitted JSON: ")" 1>&2
    dumpPipe results <"$resultsFile" 1>&2 || return $?
  fi
  printf "%s: %s\n" "$(decorate info URL)" "$(decorate orange "$url")" || :
  decorate success "Release $releaseName completed" || :
  rm "$resultsFile" || :
}
_githubRelease() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__identicalLoader() {
  __buildFunctionLoader __identicalLineParse _identical "$@"
}
identicalRepair() {
  __identicalLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_identicalRepair() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
identicalCheck() {
  __identicalLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_identicalCheck() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
identicalCheckShell() {
  __identicalLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_identicalCheckShell() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
identicalFindTokens() {
  __identicalLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_identicalFindTokens() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
identicalWatch() {
  __identicalLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_identicalWatch() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__interactiveLoader() {
  __buildFunctionLoader __fileCopy interactive "$@"
}
pause() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ "${1-}" != "--" ] || shift
  local prompt="${1-"PAUSE > "}"
  statusMessage printf -- "%s" "$prompt"
  bashUserInput
}
_pause() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileCopy() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_fileCopy() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
fileCopyWouldChange() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_fileCopyWouldChange() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
approveBashSource() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_approveBashSource() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
approvedSources() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_approvedSources() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
notify() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_notify() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
confirmYesNo() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_confirmYesNo() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
confirmMenu() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_confirmMenu() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
loopExecute() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_loopExecute() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
interactiveManager() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_interactiveManager() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
interactiveCountdown() {
  __interactiveLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_interactiveCountdown() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
interactiveOccasionally() {
  local handler="_${FUNCNAME[0]}"
  local name="" delta="" verboseFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --delta) shift && delta="$(validate "$handler" PositiveInteger "$argument" "${1-}")" || return $? ;;
    --verbose) verboseFlag=true ;;
    *) if
      [ -z "$name" ]
    then
      name="$(validate "$handler" EnvironmentVariable "$argument" "${1-}")" || return $?
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$name" ] || throwArgument "$handler" "name is required" || return $?
  [ -n "$delta" ] || delta=60000
  local cacheShown
  cacheShown="$(catchReturn "$handler" buildCacheDirectory "${FUNCNAME[0]}")/$name" || return $?
  ! $verboseFlag || printf "cacheFile: %s\n" "$(decorate file "$cacheShown")"
  local now lastShown
  now=$(timingStart)
  if [ -f "$cacheShown" ] && lastShown=$(head -n 1 "$cacheShown") && isInteger "$lastShown" && [ "$delta" -gt $((now - lastShown)) ]; then
    ! $verboseFlag || printf "NO: %s %s %s\n" "$(decorate code "$lastShown")" "Now: $(decorate info "$now")" "Delta: $(decorate value "$((now - lastShown)) ($delta)")"
    return 1
  else
    ! $verboseFlag || printf "YES: %s %s %s\n" "$(decorate code "$lastShown")" "Now: $(decorate info "$now")" "Delta: $(decorate value "$((now - lastShown)) ($delta)")"
    catchEnvironment "$handler" printf "%s\n" "$now" >"$cacheShown" || return $?
    return 0
  fi
}
_interactiveOccasionally() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
rotateLog() {
  local this="${FUNCNAME[0]}"
  local handler="_$this"
  local logFile="" count="" dryRun=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --dry-run)
      dryRun=true
      ;;
    *) if
      [ -z "$logFile" ]
    then
      logFile="$argument"
    elif [ -z "$count" ]; then
      count="$argument"
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  logFile="$(validate "$handler" File logFile "$logFile")" || return $?
  isInteger "$count" || throwArgument "$handler" "$this count $(decorate value "$count") must be a positive integer" || return $?
  [ "$count" -gt 0 ] || throwArgument "$handler" "$this count $(decorate value "$count") must be a positive integer greater than zero" || return $?
  local index="$count"
  if [ "$count" -gt 1 ]; then
    if [ -f "$logFile.$count" ]; then
      if "$dryRun"; then
        printf "%s \"%s\"\n" rm "$(escapeDoubleQuotes "$logFile.$count")"
      else
        rm "$logFile.$count" || throwEnvironment "$handler" "$this Can not remove $logFile.$count" || return $?
      fi
    fi
  fi
  index=$((index - 1))
  while [ "$index" -ge 1 ]; do
    if [ -f "$logFile.$index" ]; then
      if "$dryRun"; then
        printf "%s \"%s\" \"%s\"\n" mv "$(escapeDoubleQuotes "$logFile.$index")" "$(escapeDoubleQuotes "$logFile.$((index + 1))")"
      else
        mv "$logFile.$index" "$logFile.$((index + 1))" || throwEnvironment "$handler" "$this Failed to mv $logFile.$index -> $logFile.$((index + 1))" || return $?
      fi
    fi
    index=$((index - 1))
  done
  index=1
  if "$dryRun"; then
    printf "%s \"%s\" \"%s\"\n" cp "$(escapeDoubleQuotes "$logFile")" "$(escapeDoubleQuotes "$logFile.$index")"
    printf "printf \"\">\"%s\"\n" "$(escapeDoubleQuotes "$logFile")"
  else
    cp "$logFile" "$logFile.$index" || throwEnvironment "$handler" "$this Failed to copy $logFile $logFile.$index" || return $?
    printf "" >"$logFile" || throwEnvironment "$handler" "$this Failed to truncate $logFile" || return $?
  fi
}
_rotateLog() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
rotateLogs() {
  local handler="_${FUNCNAME[0]}"
  local logPath="" count="" dryRunArgs=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --dry-run)
      dryRunArgs=(--dry-run)
      ;;
    *) if
      [ -z "$logPath" ]
    then
      logPath="$(validate "$handler" Directory logPath "$logPath") || return $?"
    elif [ -z "$count" ]; then
      count="$(validate "$handler" PositiveInteger "count" "$argument")" || return $?
    else
      throwArgument "$handler" "$this Unknown argument $argument" || return $?
    fi ;;
    esac
    shift
  done
  [ -z "$logPath" ] || throwArgument "$handler" "missing logPath" || return $?
  [ -z "$count" ] || throwArgument "$handler" "missing count" || return $?
  statusMessage decorate info "Rotating log files in path $(decorate file "$logPath")"
  find "$logPath" -type f -name '*.log' ! -path "*/.*/*" | while IFS= read -r logFile; do
    statusMessage decorate info "Rotating log file $logFile" || :
    catchEnvironment "$handler" rotateLog "${dryRunArgs[@]+${dryRunArgs[@]}}" "$logFile" "$count" || return $?
  done
  statusMessage --last decorate info "Rotated log files in path $(decorate file "$logPath")"
}
_rotateLogs() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
markdownIndentHeading() {
  local handler="_${FUNCNAME[0]}"
  local direction=1
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  local line append
  append=$(textRepeat "$direction" "#")
  while IFS="" read -r line; do
    if [ "${line:0:1}" = "#" ]; then
      printf "%s\n" "$append$line"
    else
      printf "%s\n" "$line"
    fi
  done
}
_markdownIndentHeading() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
markdownRemoveUnfinishedSections() {
  local line section=() foundVar=false blankContent=true
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  while IFS='' read -r line; do
    if [ "${line:0:1}" = "#" ]; then
      if ! $foundVar && ! $blankContent; then
        printf '%s\n' "${section[@]+${section[@]}}"
      fi
      foundVar=false
      blankContent=true
      if isMappable "$line"; then
        foundVar=true
      fi
      section=("$line")
    else
      temp="$(trimSpace "$line")"
      if [ -n "$temp" ]; then
        if isMappable "$temp"; then
          foundVar=true
        fi
        blankContent=false
      fi
      section+=("$line")
    fi
  done
  if ! $foundVar && ! $blankContent; then
    printf '%s\n' "${section[@]+${section[@]}}"
  fi
}
_markdownRemoveUnfinishedSections() {
  true || markdownRemoveUnfinishedSections --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
markdownFormatList() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local wordClass='[-.`_A-Za-z0-9[:space:]]' spaceClass='[[:space:]]'
  sed \
    -e 's/[[:space:]]*$//g' \
    -e "s/^- //1" \
    -e "s/\`\($wordClass*\)\`$spaceClass-$spaceClass/\1 - /1" \
    -e "s/\($wordClass*\)$spaceClass-$spaceClass/- \`\1\` - /1" \
    -e "/^$/q" \
    -e "s/^\([^-]\)/- \1/1"
}
_markdownFormatList() {
  true || markdownFormatList --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
markdownCheckIndex() {
  local handler="_${FUNCNAME[0]}"
  local files=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *) files+=("$(validate "$handler" File "indexFile" "${1-}")") || return $? ;;
    esac
    shift
  done
  [ ${#files[@]} -gt 0 ] || throwArgument "$handler" "Requires at least one indexFile" || return $?
  local item code=0
  for item in "${files[@]}"; do
    local itemName itemDirectory
    itemDirectory=$(catchEnvironment "$handler" dirname "$item") || return $?
    itemName=$(catchEnvironment "$handler" basename "$item") || return $?
    catchEnvironment "$handler" muzzle pushd "$itemDirectory" || return $?
    local link itemText
    itemText="$(decorate file "$item"): "
    while read -r link; do
      if ! grep -q "$link" "$itemName"; then
        decorate warning "$itemText Missing $link"
        code=1
      fi
    done < <(find . -maxdepth 1 -name '*.md' ! -name "$itemName")
    catchEnvironment "$handler" muzzle popd || return $?
  done
  return $code
}
_markdownCheckIndex() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
nodeInstall() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  if packageIsInstalled nodejs; then
    __nodeInstall_corepackEnable "$handler" || return $?
    return 0
  fi
  local quietLog
  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  statusMessage --first decorate info "Installing nodejs ... " || return $?
  catchEnvironmentQuiet "$handler" "$quietLog" packageInstall nodejs || return $?
  __nodeInstall_corepackEnable "$handler" || return $?
}
_nodeInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__nodeInstall_corepackEnable() {
  local handler="$1"
  if ! executableExists corepack; then
    statusMessage decorate warning "No corepack - installing using npm" || return $?
    catchEnvironment "$handler" npmInstall || return $?
    catchEnvironment "$handler" npm install -g corepack || return $?
    executableExists corepack || throwEnvironment "$handler" "corepack not found after global installation - failing: PATH=$PATH" || return $?
  fi
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  catchEnvironment "$handler" muzzle pushd "$home" || return $?
  catchEnvironment "$handler" corepack enable || returnUndo $? muzzle popd || return $?
  catchEnvironment "$handler" muzzle popd || return $?
}
nodeUninstall() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  if ! packageIsInstalled nodejs; then
    return 0
  fi
  local start name quietLog
  name=$(decorate code node)
  start=$(timingStart) || return $?
  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  statusMessage --first decorate info "Uninstalling $name ... " || return $?
  catchEnvironmentQuiet "$handler" "$quietLog" packageUninstall nodejs || return $?
  statusMessage timingReport "$start" "Uninstalled $name in" || return $?
}
_nodeUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
nodePackageManager() {
  local handler="_${FUNCNAME[0]}"
  local arguments=() flags=() action="" debugFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --debug)
      debugFlag=true
      ;;
    --global)
      flags+=("$argument")
      ;;
    install | run | update | uninstall)
      [ -z "$action" ] || throwArgument "$handler" "Only a single action allowed: $argument (already: $action)"
      action="$argument"
      ;;
    -*)
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *)
      [ -n "$action" ] || throwArgument "$handler" "Requires an action" || return $?
      packages+=("$argument")
      ;;
    esac
    shift
  done
  local manager
  manager=$(catchReturn "$handler" buildEnvironmentGet NODE_PACKAGE_MANAGER) || return $?
  [ -n "$manager" ] || throwEnvironment "$handler" "NODE_PACKAGE_MANAGER is blank" || return $?
  nodePackageManagerValid "$manager" || throwEnvironment "$handler" "NODE_PACKAGE_MANAGER is not valid: $manager not in $(nodePackageManagerValid)" || return $?
  isExecutable "$manager" || throwEnvironment "$handler" "$(decorate code "$manager") is not an executable" || return $?
  if [ -z "$action" ]; then
    printf "%s\n" "$manager"
    return 0
  fi
  local managerArgumentFormatter="__nodePackageManagerArguments_$manager"
  isFunction "$managerArgumentFormatter" || throwEnvironment "$handler" "$managerArgumentFormatter is not defined, failing" || return $?
  IFS=$'\n' read -r -d "" -a arguments < <("$managerArgumentFormatter" "$handler" "$action" "${flags[@]+"${flags[@]}"}") || :
  ! $debugFlag || decorate each code "$manager" "${arguments[@]+"${arguments[@]}"}" "${packages[@]+"${packages[@]}"}" || :
  catchEnvironment "$handler" "$manager" "${arguments[@]+"${arguments[@]}"}" "${packages[@]+"${packages[@]}"}" || return $?
}
_nodePackageManager() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
nodePackageManagerInstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local manager
  manager=$(catchEnvironment "$handler" nodePackageManager) || return $?
  if executableExists "$manager"; then
    return 0
  fi
  local method="${manager}Install"
  isFunction "$method" || throwEnvironment "$handler" "No installer for $manager exists ($method)" || return $?
  catchEnvironment "$handler" "$method" "$@" || return $?
}
_nodePackageManagerInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
nodePackageManagerUninstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local manager
  manager=$(catchEnvironment "$handler" nodePackageManager) || return $?
  if ! executableExists "$manager"; then
    return 0
  fi
  local method="${manager}Uninstall"
  isFunction "$method" || throwEnvironment "$handler" "No uninstaller method for $manager exists ($method)" || return $?
  catchEnvironment "$handler" "$method" "$@" || return $?
}
_nodePackageManagerUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
nodePackageManagerValid() {
  local handler="_${FUNCNAME[0]}"
  local valid=("npm" "yarn")
  if [ $# -eq 0 ]; then
    printf -- "%s\n" "${valid[@]}"
    return 0
  fi
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) isFunction "$1Install" || return 1 ;;
    esac
    shift
  done
}
_nodePackageManagerValid() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
yarnInstall() {
  local handler="_${FUNCNAME[0]}"
  local version quietLog
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --version)
      shift
      version=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  if executableExists yarn; then
    return 0
  fi
  local home start
  start=$(timingStart) || return $?
  home=$(catchReturn "$handler" buildHome) || return $?
  catchReturn "$handler" buildEnvironmentLoad BUILD_YARN_VERSION || return $?
  version="${1-${BUILD_YARN_VERSION:-stable}}"
  quietLog=$(buildQuietLog "$handler") || throwEnvironment "buildQuietLog $handler"
  catchReturn "$handler" fileDirectoryRequire "$quietLog" || return $?
  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  statusMessage --first decorate info "Installing node ... " || return $?
  catchReturn "$handler" nodeInstall || return $?
  catchEnvironment "$handler" muzzle pushd "$home" || return $?
  catchEnvironment "$handler" yarn set version "$version" || returnUndo $? muzzle popd || return $?
  statusMessage decorate info "Installing yarn ... " || return $?
  catchEnvironment "$handler" yarn install || returnUndo $? muzzle popd || return $?
  catchEnvironment "$handler" muzzle popd || return $?
  statusMessage --last timingReport "$start" "Installed yarn in" || return $?
}
_yarnInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__nodePackageManagerArguments_yarn() {
  local handler="$1" action
  action=$(validate "$handler" String "action" "${2-}") || return $?
  shift 2
  local globalFlag=false
  while [ $# -gt 0 ]; do
    local argument
    argument="$(validate "$handler" String "argument" "$1")" || return $?
    case "$argument" in
    --global) globalFlag=true ;;
    esac
    shift
  done
  case "$action" in
  run)
    ! $globalFlag || throwArgument "$handler" "--global makes no sense with run" || return $?
    printf "%s\n" "run"
    ;;
  update)
    printf "%s\n" "install"
    ;;
  uninstall)
    if
      $globalFlag
    then
      printf "%s\n" "global" "remove"
    else
      printf "%s\n" "remove"
    fi
    ;;
  install)
    if
      $globalFlag
    then
      printf "%s\n" "global" "add"
    else
      printf "%s\n" "add"
    fi
    ;;
  *) catchArgument "$handler" "Unknown action: $action" || return $? ;;
  esac
}
npmInstall() {
  local handler="_${FUNCNAME[0]}"
  local version quietLog
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --version)
      shift
      version=$(validate "$handler" String "$argument" "${1-}") || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  if executableExists npm; then
    return 0
  fi
  catchReturn "$handler" buildEnvironmentLoad BUILD_NPM_VERSION || return $?
  local clean=() quietLog
  version="${1-${BUILD_NPM_VERSION:-latest}}"
  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  clean+=("$quietLog")
  catchEnvironmentQuiet "$handler" "$quietLog" packageInstall npm || returnClean $? "${clean[@]}" || return $?
  catchEnvironmentQuiet "$handler" "$quietLog" npm install -g "npm@$version" --force 2>&1 || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
}
_npmInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
npmUninstall() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  packageWhichUninstall npm npm "$@"
}
_npmUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__nodePackageManagerArguments_npm() {
  local handler="$1" action
  action=$(validate "$handler" String "action" "${2-}") || return $?
  shift 2
  local globalFlag=false
  while [ $# -gt 0 ]; do
    local argument
    argument="$(validate "$handler" String "argument" "$1")" || return $?
    case "$argument" in
    --global) globalFlag=true ;;
    esac
    shift
  done
  case "$action" in
  run)
    ! $globalFlag || throwArgument "$handler" "--global makes no sense with run" || return $?
    printf "%s\n" "run"
    ;;
  install | update | uninstall)
    if
      $globalFlag
    then
      printf "%s\n" "$action" "-g"
    else
      printf "%s\n" "$action"
    fi
    ;;
  *) catchArgument "$handler" "Unknown action: $action" || return $? ;;
  esac
}
phpInstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchReturn "$handler" packageWhich php php-common php-cli "$@" || return $?
}
_phpInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
phpUninstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchReturn "$handler" packageWhichUninstall php php-common php-cli "$@" || return $?
}
_phpUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
phpTailLog() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local logFile
  logFile=$(catchEnvironment "$handler" phpLog) || return $?
  [ -n "$logFile" ] || throwEnvironment "$handler" "PHP log file is blank" || return $?
  if [ ! -f "$logFile" ]; then
    statusMessage printf -- "%s %s" "$(decorate file "$logFile")" "$(decorate warning "does not exist - creating")" 1>&2
    catchEnvironment "$handler" touch "$logFile" || return $?
  elif fileIsEmpty "$logFile"; then
    statusMessage printf -- "%s %s" "$(decorate file "$logFile")" "$(decorate warning "is empty")" 1>&2
  fi
  tail "$@" "$logFile"
}
_phpTailLog() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
phpLog() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  executableExists php || throwEnvironment "$handler" "php not installed" || return $?
  php -r "echo ini_get('error_log');" 2>/dev/null || throwEnvironment "$handler" "php installation issue" || return $?
}
_phpLog() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
phpIniFile() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  executableExists php || throwEnvironment "$handler" "php not installed" || return $?
  php -r "echo get_cfg_var('cfg_file_path');" 2>/dev/null || throwEnvironment "$handler" "php installation issue" || return $?
}
_phpIniFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_deploymentGenerateValue() {
  local handler="$1" home="$2" variableName="$3" hook="$4"
  if [ -z "${!variableName}" ]; then
    catchEnvironment "$handler" hookRun --application "$home" "$hook" | catchEnvironment "$handler" tee "$home/.deploy/$variableName" || return $?
  else
    printf -- "%s" "${!variableName}" | catchEnvironment "$handler" tee "$home/.deploy/$variableName" || return $?
  fi
}
_deploymentToSuffix() {
  local handler="$1" deployment="$2"
  case "$deployment" in
  production) versionSuffix=rc ;;
  staging) versionSuffix=s ;;
  test) versionSuffix=t ;;
  *) throwArgument "$handler" "--deployment $deployment unknown - can not set versionSuffix" || return $? ;;
  esac
  printf "%s\n" "$versionSuffix"
}
phpBuild() {
  local handler="_${FUNCNAME[0]}"
  local environments=(BUILD_TIMESTAMP APPLICATION_BUILD_DATE APPLICATION_ID APPLICATION_TAG APPLICATION_VERSION)
  local optionals=(BUILD_DEBUG)
  local targetName optClean=false versionSuffix="" composerArgs=() home=""
  targetName="$(catchEnvironment "$handler" deployPackageName)" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --tag | --no-tag | --skip-tag)
      statusMessage decorate subtle "$argument is deprecated"
      ;;
    --composer)
      shift
      composerArgs+=("$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --name)
      shift
      targetName=$(validate "$handler" String "name" "${1-}") || return $?
      ;;
    --)
      shift
      break
      ;;
    --clean)
      optClean=1
      ;;
    --suffix)
      shift
      versionSuffix=$(validate "$handler" String "versionSuffix" "${1-}") || return $?
      ;;
    --home)
      shift
      home=$(validate "$handler" Directory "$argument" "${1-}") || return $?
      ;;
    *) environments+=("$(validate "$handler" EnvironmentVariable "environmentVariable" "$1")") ;;
    esac
    shift
  done
  [ -n "$home" ] || home=$(catchReturn "$handler" buildHome) || return $?
  [ -n "$targetName" ] || throwArgument "$handler" "--name argument blank" || return $?
  [ $# -gt 0 ] || throwArgument "$handler" "Need to supply a list of files for application $(decorate code "$targetName")" || return $?
  muzzle validate "$handler" Executable "${FUNCNAME[0]} requirements" tar || return $?
  catchReturn "$handler" buildEnvironmentLoad "${environments[@]}" "${optionals[@]}" || return $?
  local missingFile tarFile
  missingFile=()
  for tarFile in "$@"; do
    if [ ! -f "$tarFile" ] && [ ! -d "$tarFile" ]; then
      missingFile+=("$tarFile")
    fi
  done
  [ ${#missingFile[@]} -eq 0 ] || throwEnvironment "$handler" "Missing files: ${missingFile[*]}" || return $?
  local initTime
  initTime=$(timingStart) || return $?
  export BUILD_START_TIMESTAMP=$initTime
  _phpBuildBanner Build PHP || :
  _phpEchoBar || :
  statusMessage --first decorate info "Installing build tools ..." || :
  catchReturn "$handler" packageInstall || return $?
  catchEnvironment "$handler" phpInstall || return $?
  local dotEnv="$home/.env"
  local clean=()
  clean+=("$dotEnv")
  if hasHook application-environment; then
    catchEnvironment "$handler" hookRun --application "$home" application-environment "${environments[@]}" -- "${optionals[@]}" >"$dotEnv" || returnClean $? "${clean[@]}" || return $?
  else
    catchReturn "$handler" environmentFileApplicationMake "${environments[@]}" -- "${optionals[@]}" >"$dotEnv" || returnClean $? "${clean[@]}" || return $?
  fi
  if ! grep -q APPLICATION "$dotEnv"; then
    dumpFile "$dotEnv" 1>&2 || :
    throwEnvironment "$handler" "$dotEnv file seems to be invalid:" || returnClean $? "${clean[@]}" || return $?
  fi
  local environment
  for environment in "${environments[@]}" "${optionals[@]}"; do
    export "$environment"
    declare "$environment=$(environmentValueRead "$dotEnv" "$environment" "")"
  done
  _phpEchoBar || :
  environmentFileShow "${environments[@]}" -- "${optionals[@]}" || :
  [ ! -d "$home/.deploy" ] || catchEnvironment "$handler" rm -rf "$home/.deploy" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" mkdir -p "$home/.deploy" || returnClean $? "${clean[@]}" || return $?
  clean+=("$home/.deploy")
  APPLICATION_ID=$(_deploymentGenerateValue "$handler" "$home" APPLICATION_ID application-id) || returnClean $? "${clean[@]}" || return $?
  APPLICATION_TAG=$(_deploymentGenerateValue "$handler" "$home" APPLICATION_TAG application-tag) || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" declare -px >"$home/.build.env" || returnClean $? "${clean[@]}" || return $?
  clean+=("$home/.build.env")
  if [ -d "$home/vendor" ] || $optClean; then
    statusMessage decorate warning "vendor directory should not exist before composer, deleting"
    catchEnvironment "$handler" rm -rf "$home/vendor" || returnClean $? "${clean[@]}" || return $?
    clean+=("$home/vendor")
  fi
  statusMessage decorate info "Running PHP composer ..."
  catchEnvironment "$handler" phpComposer "$home" "${composerArgs[@]+${composerArgs[@]}}" || returnClean $? "${clean[@]}" || return $?
  [ -d "$home/vendor" ] || throwEnvironment "$handler" "Composer step did not create the vendor directory" || returnClean $? "${clean[@]}" || return $?
  _phpEchoBar
  _phpBuildBanner "Application ID" "$APPLICATION_ID"
  _phpEchoBar
  _phpBuildBanner "Application Tag" "$APPLICATION_TAG"
  _phpEchoBar
  catchEnvironment "$handler" muzzle pushd "$home" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" tarCreate "$targetName" .env vendor/ .deploy/ "$@" || returnUndo $? muzzle popd || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" muzzle popd || returnClean $? "${clean[@]}" || return $?
  statusMessage --last timingReport "$initTime" "PHP built $(decorate code "$targetName") in"
}
_phpBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_phpBuildBanner() {
  local label="$1"
  shift
  labeledBigText --top \
    --prefix "$(decorate blue PHP) $(decorate magenta ". . . .") $(decorate BOLD orange --)" \
    --suffix "$(decorate reset --)" --tween " $(decorate reset --)$(decorate green --)" \
    "$label: " "$@"
}
_phpEchoBar() {
  decorate BOLD blue "$(consoleLine '.-+^`^+-')" || :
}
phpTest() {
  local handler="_${FUNCNAME[0]}"
  local home=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --env-file)
      shift
      muzzle validate "$handler" LoadEnvironmentFile "$argument" "${1-}" || return $?
      statusMessage decorate info "Loaded $argument $(decorate file "$1") (wd: $(pwd))" || return $?
      ;;
    --home)
      shift
      home=$(validate "$handler" Directory "$argument" "${1-}") || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  [ -n "$home" ] || home=$(catchReturn "$handler" buildHome) || return $?
  [ -f "$home/docker-compose.yml" ] || catchEnvironment "$handler" "Requires $(decorate code "$home/docker-compose.yml")" || return $?
  local dca=()
  dca+=("-f" "$home/docker-compose.yml")
  statusMessage decorate info "Testing PHP in $(decorate file "$home")" || :
  local init quietLog
  init=$(timingStart) || return $?
  quietLog="$(catchReturn "$handler" buildQuietLog "$handler")" || return $?
  buildDebugStart "${FUNCNAME[0]}" || :
  catchEnvironment "$handler" dockerComposeInstall || return $?
  catchEnvironment "$handler" phpComposer "$home" || return $?
  statusMessage decorate info "Building test container" || :
  local start undo=()
  start=$(timingStart) || return $?
  catchEnvironment "$handler" _phpTestSetup "$handler" "$home" || return $?
  catchEnvironment "$handler" muzzle pushd "$home" || return $?
  undo+=(muzzle popd)
  catchEnvironment "$handler" hookRunOptional test-setup || returnUndo "$?" "${undo[@]}" || return $?
  catchEnvironmentQuiet "$handler" "$quietLog" docker-compose "${dca[@]}" build || returnUndo "$?" "${undo[@]}" || return $?
  statusMessage timingReport "$start" "Built in" || :
  statusMessage decorate info "Bringing up containers ..." || returnUndo "$?" "${undo[@]}" || return $?
  start=$(catchReturn "$handler" timingStart) || returnUndo "$?" "${undo[@]}" || return $?
  catchEnvironmentQuiet "$handler" "$quietLog" docker-compose "${dca[@]}" up -d || returnUndo "$?" "${undo[@]}" || return $?
  statusMessage timingReport "$start" "Up in" || :
  start=$(timingStart) || return $?
  local reason=""
  if ! hookRun test-runner; then
    reason="test-runner hook failed"
    _phpTestResult Failed orange "❌" "🔥" 13 2
  else
    _phpTestResult "  Success " green "☘️ " "💙" 18 4
  fi
  decorate info "Bringing down containers ..." || :
  start=$(timingStart) || return $?
  catchEnvironment "$handler" docker-compose "${dca[@]}" down || _phpTestCleanup "$handler" || throwEnvironment "$handler" "docker-compose down" || return $?
  _phpTestCleanup "$handler" || return $?
  statusMessage timingReport "$start" "Down in" || :
  if ! hookRunOptional test-cleanup; then
    reason="test-cleanup ALSO failed"
  fi
  [ -z "$reason" ] || throwEnvironment "$handler" "$reason" || return $?
  buildDebugStop "${FUNCNAME[0]}" || :
  statusMessage timingReport "$init" "PHP Test completed in" || return $?
}
_phpTest() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_phpTestSetup() {
  local handler="$1" home="$2"
  catchEnvironment "$handler" filesRename "" ".$$.backup" hiding "$home/.env" "$home/.env.local"
}
_phpTestCleanup() {
  local handler="$1" item
  for item in "$home/.env" "$home/.env.local" "$home/vendor"; do
    if [ -f "$item" ] || [ -d "$item" ]; then
      catchEnvironment "$handler" rm -rf "$item" || return $?
    fi
  done
  catchEnvironment "$handler" filesRename ".$$.backup" "" restoring "$home/.env" "$home/.env.local" || :
}
_phpTestResult() {
  local message=$1 color=$2 top=$3 bottom=$4 width=${5-16} thick="${6-3}"
  local gap="    "
  textRepeat "$thick" "$(printf "%s" "$(textRepeat "$width" "$top")")"$'\n'
  bigText "$message" | decorate "$color" | decorate wrap "$top$gap" "$gap$bottom"
  textRepeat "$thick" "$(printf "%s" "$(textRepeat "$width" "$bottom")")"$'\n'
}
pythonInstall() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if ! executableExists python; then
    catchReturn "$handler" packageGroupInstall "$@" python || return $?
  fi
}
_pythonInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pythonUninstall() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  if executableExists python; then
    catchReturn "$handler" packageGroupUninstall "$@" python || return $?
  fi
}
_pythonUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pipUpgrade() {
  local handler="_${FUNCNAME[0]}"
  local pp=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --bin) shift && pp+=("$argument" "${1-}") ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  PIP_ROOT_USER_ACTION=ignore catchReturn "$handler" pipWrapper "${pp[@]+"${pp[@]}"}" install --upgrade pip || return $?
}
_pipUpgrade() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pipInstall() {
  local handler="_${FUNCNAME[0]}"
  local names=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *) names+=("$(validate "$handler" String "name" "${1-}")") || return $? ;;
    esac
    shift
  done
  [ ${#names[@]} -gt 0 ] || throwArgument "$handler" "No pip package names specified to install" || return $?
  local start
  start=$(timingStart) || return $?
  catchEnvironment "$handler" pythonInstall || return $?
  local prettyNames
  prettyNames="$(decorate each code "${names[@]}")"
  statusMessage decorate info "Installing $prettyNames ... "
  local quietLog
  quietLog=$(catchReturn "$handler" buildQuietLog "$handler") || return $?
  catchEnvironmentQuiet "$handler" "$quietLog" pipWrapper install "${names[@]}" || returnClean $? "$quietLog" || return $?
  catchEnvironment "$handler" rm -f "$quietLog" || return $?
  statusMessage --last timingReport "$start" "Installed $prettyNames in"
}
_pipInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pipUninstall() {
  local handler="_${FUNCNAME[0]}"
  local removeNames=() names=() debugFlag=false aa=() prettyNames=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --debug) debugFlag=true && aa+=("$argument") ;;
    *)
      argument="$(validate "$handler" String "name" "$argument")" || return $?
      names+=("$argument")
      if pythonPackageInstalled "$argument"; then
        prettyNames+=("$(decorate code "$argument")")
        removeNames+=("$argument")
        ! $debugFlag || statusMessage decorate info "Package $(decorate code "$argument") is installed and will be removed" || return $?
      else
        prettyNames+=("$(decorate subtle "$argument")")
        ! $debugFlag || statusMessage decorate info "Package $(decorate code "$argument") is NOT installed" || return $?
      fi
      ;;
    esac
    shift
  done
  [ ${#names[@]} -gt 0 ] || throwArgument "$handler" "No pip package names specified to uninstall" || return $?
  [ ${#removeNames[@]} -gt 0 ] || return 0
  local start
  start=$(timingStart) || return $?
  catchEnvironment "$handler" pythonInstall "${aa[@]+"${aa[@]}"}" || return $?
  local showNames
  showNames="$(decorate each quote "${prettyNames[@]}")"
  statusMessage decorate info "Uninstalling $showNames ... "
  local quietLog
  statusMessage decorate info "Uninstalling pip packages $showNames ... "
  catchEnvironmentQuiet "$handler" - pipWrapper uninstall "${removeNames[@]}" || return $?
  if pythonPackageInstalled --any "${names[@]}"; then
    throwEnvironment "$handler" "One or more packages are still installed: $showNames" || return $?
  fi
  statusMessage --last timingReport "$start" "Uninstalled $showNames in"
}
_pipUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pipWrapper() {
  local handler="_${FUNCNAME[0]}"
  local binary="" debugFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --debug) debugFlag=true ;;
    --bin) shift && binary=$(validate "$handler" Executable "$argument" "${1-}") ;;
    *) break ;;
    esac
    shift
  done
  catchReturn "$handler" pythonInstall || return $?
  if [ -n "$binary" ]; then
    catchReturn "$handler" "$binary" "$@" || return $?
  elif executableExists pip; then
    ! $debugFlag || printf "%s\n" "which: $(which pip)" "command: $(command -v pip)" 1>&2
    catchReturn "$handler" pip "$@" || return $?
  else
    catchReturn "$handler" python -m pip "$@" || return $?
  fi
}
_pipWrapper() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pythonPackageInstalled() {
  local handler="_${FUNCNAME[0]}" packages=() anyMode=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --any) anyMode=true ;;
    *) packages+=("$(validate "$handler" String "pipPackage" "$1")") || return $? ;;
    esac
    shift
  done
  [ ${#packages[@]} -gt 0 ] || throwArgument "$handler" "No pip package names passed" || return $?
  local package
  for package in "${packages[@]}"; do
    if ! python -m "$package" --help >/dev/null 2>/dev/null; then
      return 1
    elif $anyMode; then
      return 0
    else
      :
    fi
  done
}
_pythonPackageInstalled() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
pythonVirtual() {
  local handler="_${FUNCNAME[0]}"
  local application="" pp=() cleanFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --application) shift && application=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --require) shift && pp+=("--requirement" "$(validate "$handler" File "$argument" "${1-}")") || return $? ;;
    --clean) cleanFlag=true ;;
    *) pp+=("$(validate "$handler" String "$argument" "${1-}")") || return $? ;;
    esac
    shift
  done
  [ -n "$application" ] || application=$(catchReturn "$handler" buildHome) || return $?
  [ ${#pp[@]} -gt 0 ] || throwArgument "$handler" "Need at "
  catchEnvironment "$handler" pythonInstall || return $?
  local venv="$application/.venv" clean=()
  ! $cleanFlag || [ ! -d "$venv" ] || catchEnvironment "$handler" rm -rf "$venv" || return $?
  if [ ! -d "$venv" ] || [ ! -f "$venv/bin/activate" ]; then
    if ! pythonPackageInstalled venv; then
      catchEnvironment "$handler" pipWrapper install venv || return $?
    fi
    catchEnvironment "$handler" python -m venv "$venv" || return $?
    [ -d "$venv" ] || throwEnvironment "$handler" "Unable to create $venv" || return $?
    clean+=(rm -rf "$venv" --)
  fi
  catchEnvironment "$handler" source "$venv/bin/activate" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" pipUpgrade --bin "$venv/bin/pip" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" pipWrapper --bin "$venv/bin/pip" install "${pp[@]}" || returnClean $? "${clean[@]}" || return $?
}
_pythonVirtual() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
phpComposer() {
  local handler="_${FUNCNAME[0]}"
  local start dockerImage=composer:${BUILD_COMPOSER_VERSION:-latest} composerDirectory="." cacheDir=".composer" forceDocker=false quietFlag=false
  start=$(timingStart)
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --quiet)
      quietFlag=true
      ;;
    --docker)
      decorate warning "Requiring docker composer"
      forceDocker=true
      ;;
    *)
      [ "$composerDirectory" = "." ] || throwArgument "$handler" "Unknown argument $1" || return $?
      [ -d "$argument" ] || throwArgument "$handler" "Directory does not exist: $argument" || return $?
      composerDirectory="$argument"
      statusMessage decorate info "Composer directory: $(decorate file "$composerDirectory")"
      break
      ;;
    esac
    shift
  done
  [ -d "$composerDirectory/$cacheDir" ] || mkdir -p "$composerDirectory/$cacheDir"
  local installArgs=("--ignore-platform-reqs") quietLog
  quietLog="$(catchReturn "$handler" buildQuietLog "$handler")" || return $?
  printf "%s\n" "Install vendor" >>"$quietLog"
  local butFirst="" composerBin=(composer)
  if $forceDocker; then
    $quietFlag || statusMessage decorate info "Pulling composer ... "
    catchEnvironmentQuiet "$handler" "$quietLog" docker pull "$dockerImage" || return $?
    composerBin=(docker run)
    composerBin+=("-v" "$composerDirectory:/app")
    composerBin+=("-v" "$composerDirectory/$cacheDir:/tmp")
    composerBin+=("$dockerImage")
    butFirst="Pulled composer image. "
  elif ! executableExists composer; then
    $quietFlag || statusMessage decorate info "Installing composer ... "
    catchEnvironment "$handler" phpComposerInstall || return $?
    butFirst="Installed composer. "
  fi
  $quietFlag || statusMessage decorate info "${butFirst}Validating ... "
  catchEnvironment "$handler" muzzle pushd "$composerDirectory" || return $?
  printf "%s\n" "Running: ${composerBin[*]} validate" >>"$quietLog"
  "${composerBin[@]}" validate >>"$quietLog" 2>&1 || returnUndo $? muzzle popd -- dumpFile "$quietLog" || return $?
  $quietFlag || statusMessage decorate info "Application packages ... " || :
  printf "%s\n" "Running: ${composerBin[*]} install ${installArgs[*]}" >>"$quietLog" || :
  "${composerBin[@]}" install "${installArgs[@]}" >>"$quietLog" 2>&1 || returnUndo $? muzzle popd -- dumpFile "$quietLog" || return $?
  catchEnvironment "$handler" muzzle popd || return $?
  $quietFlag || statusMessage --last timingReport "$start" "${FUNCNAME[0]} completed in" || :
}
_phpComposer() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
phpComposerInstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  ! executableExists composer || return 0
  catchReturn "$handler" phpInstall || return $?
  local target="/usr/local/bin/composer"
  local tempBinary="$target.$$"
  catchReturn "$handler" urlFetch "https://getcomposer.org/composer.phar" "$tempBinary" || returnClean $? "$tempBinary" || return $?
  catchEnvironment "$handler" mv -f "$tempBinary" "$target" || returnClean $? "$tempBinary" || return $?
  catchEnvironment "$handler" chmod +x "$target" || returnClean $? "$tempBinary" || return $?
}
_phpComposerInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
phpComposerSetVersion() {
  local handler="_${FUNCNAME[0]}"
  local home="" aa=() version=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --version)
      shift
      version="$(validate "$handler" String "$argument" "${1-}")" || return $?
      aa+=(--value "$version")
      ;;
    --status | --quiet)
      aa+=("$argument")
      ;;
    --home)
      shift
      home="$(validate "$handler" Directory "$argument" "${1-}")" || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  [ -n "$home" ] || home=$(catchReturn "$handler" buildHome) || return $?
  local composerJSON="$home/composer.json" decoratedComposerJSON
  decoratedComposerJSON="$(decorate file "$composerJSON")"
  [ -f "$composerJSON" ] || throwEnvironment "$handler" "No $decoratedComposerJSON" || return $?
  catchEnvironment "$handler" jsonSetValue "${aa[@]+"${aa[@]}"}" --key version --generator hookVersionCurrent --filter versionNoVee "$composerJSON" || return $?
}
_phpComposerSetVersion() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
versionSort() {
  local handler="_${FUNCNAME[0]}"
  local reverse=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    -r | --reverse)
      reverse="r"
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  sort -t . -k "1.2,1n$reverse" -k "2,2n$reverse" -k "3,3n$reverse"
}
_versionSort() {
  true || versionSort --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
ipLookup() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local url jqFilter
  url=$(catchReturn "$handler" buildEnvironmentGet IP_URL) || return $?
  [ -n "$url" ] || throwEnvironment "$handler" "$(decorate value "IP_URL") is required for $(decorate code "${handler#_}")" || return $?
  urlValid "$url" || throwEnvironment "$handler" "URL $(decorate error "$url") is not a valid URL" || return $?
  local jqFilter
  jqFilter=$(catchReturn "$handler" buildEnvironmentGet IP_URL_FILTER) || return $?
  local pp=(cat)
  [ -z "$jqFilter" ] || pp=(jq -r "$jqFilter")
  catchReturn "$handler" urlFetch "$url" - | catchEnvironment "$handler" "${pp[@]}" || return $?
}
_ipLookup() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isUpToDate() {
  local handler="_${FUNCNAME[0]}"
  local name="Key" keyDate="" upToDateDays=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --name)
      shift || :
      name="$1"
      ;;
    *) if
      [ -z "$keyDate" ]
    then
      keyDate=$(validate "$handler" String "keyDate" "$argument") || return $?
    elif [ -z "$upToDateDays" ]; then
      upToDateDays=$(validate "$handler" Integer "upToDateDays" "$argument") || return $?
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift || throwArgument "shift $argument" || return $?
  done
  [ -n "$keyDate" ] || throwArgument "$handler" "missing keyDate" || return $?
  [ -n "$upToDateDays" ] || upToDateDays=90
  keyDate="${keyDate:0:10}"
  [ -z "$name" ] || name="$name "
  local todayTimestamp
  todayTimestamp=$(dateToTimestamp "$(dateToday)") || throwEnvironment "$handler" "Unable to generate dateToday" || return $?
  local keyTimestamp maxDays
  keyTimestamp=$(dateToTimestamp "$keyDate") || throwArgument "$handler" "Invalid date $keyDate" || return $?
  isInteger "$upToDateDays" || throwArgument "$handler" "upToDateDays is not an integer ($upToDateDays)" || return $?
  maxDays=366
  [ "$upToDateDays" -le "$maxDays" ] || throwArgument "$handler" "isUpToDate $keyDate $upToDateDays - values not allowed greater than $maxDays" || return $?
  [ "$upToDateDays" -ge 0 ] || throwArgument "$handler" "isUpToDate $keyDate $upToDateDays - negative values not allowed" || return $?
  local expireDate
  local accessKeyTimestamp=$((keyTimestamp + ((23 * 60) + 59) * 60))
  local expireTimestamp=$((accessKeyTimestamp + 86400 * upToDateDays))
  expireDate=$(dateFromTimestamp "$expireTimestamp" '%A, %B %d, %Y %R')
  local deltaDays=$(((todayTimestamp - accessKeyTimestamp) / 86400))
  local daysAgo=$((deltaDays - upToDateDays))
  if [ "$todayTimestamp" -gt "$expireTimestamp" ]; then
    local label timeText
    label=$(printf "%s %s\n" "$(decorate error "${name}expired on ")" "$(decorate red "$keyDate")")
    case "$daysAgo" in
    0) timeText="Today" ;;
    1) timeText="Yesterday" ;;
    *) timeText="$(pluralWord $daysAgo day) ago" ;;
    esac
    labeledBigText --prefix "$(decorate reset --)" --top --tween "$(decorate red --)" "$label" "EXPIRED $timeText"
    return 1
  fi
  daysAgo=$((-daysAgo))
  if [ $daysAgo -lt 14 ]; then
    labeledBigText --prefix "$(decorate reset --)" --top --tween "$(decorate orange --)" "${name}expires on $(decorate code "$expireDate"), in " "$daysAgo $(plural $daysAgo day days)"
  elif [ $daysAgo -lt 30 ]; then
    printf "%s %s %s %s\n" \
      "$(decorate warning "${name}expires on")" \
      "$(decorate red "$expireDate")" \
      "$(decorate warning ", in")" \
      "$(decorate magenta "$(pluralWord $daysAgo day)")"
    return 0
  fi
  return 0
}
_isUpToDate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__doEvalCheck() {
  local handler="$1" && shift
  local file firstLine checkLine checkLineFailed failed tempResults
  tempResults=$(fileTemporaryName "$handler") || return $?
  while [ $# -gt 0 ]; do
    file=$(validate "$handler" File "file" "$1") || return $?
    shift
    if ! grep -n -B 1 -e '^[^#]*\seval "' <"$file" >"$tempResults"; then
      continue
    fi
    firstLine=false
    failed=0
    while read -r line; do
      lineNo="${line%%:*}"
      if [ "$lineNo" = "$line" ]; then
        lineNo="${line%%-*}"
        if [ -z "$lineNo" ]; then
          firstLine=true
          continue
        fi
        [ "$lineNo" != "$line" ] || catchEnvironment "$handler" "Unable to parse line: $line" || return $?
        line="${line#-*}"
      else
        line="${line#:*}"
      fi
      if $firstLine; then
        checkLineFailed=false
        checkLine="${line##*evalCheck:}"
        if [ "$checkLine" = "$line" ]; then
          checkLineFailed=true
        else
          checkLine="$(trimSpace "$checkLine")" || :
        fi
        firstLine=false
      else
        if "$checkLineFailed"; then
          failed=$((failed + 1))
          printf "%s in %s line %s: %s\n" "$(decorate error "Unchecked eval")" "$(decorate info "$1")" "$(decorate blue "$lineNo")" "$(decorate code "$line")"
        else
          printf "%s in %s line %s: %s\n" "$(decorate success "evalCheck FOUND")" "$(decorate info "$1")" "$(decorate blue "$lineNo")" "$(decorate code "$checkLine")"
        fi
      fi
    done <"$tempResults"
  done
  catchEnvironment "$handler" rm -rf "$tempResults" || return $?
  [ "$failed" -eq 0 ] || throwEnvironment "$handler" "evalCheck failed for $failed $(plural "$failed" file files)" || return $?
}
evalCheck() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local fileName
  if [ $# -gt 0 ]; then
    __doEvalCheck "$handler" "$@" || return $?
  else
    while IFS= read -r fileName; do
      statusMessage decorate info "Checking $fileName"
      __doEvalCheck "$handler" "$fileName" || return $?
    done
  fi
}
_evalCheck() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
sshKnownHostsFile() {
  local handler="_${FUNCNAME[0]}"
  local user sshKnown
  user=$(catchReturn "$handler" buildEnvironmentGet HOME) || return $?
  sshKnown="$user/.ssh/known_hosts"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --create)
      local sshHome
      sshHome=$(catchEnvironment "$handler" dirname "$sshKnown") || return $?
      if [ ! -d "$sshHome" ]; then
        sshHome=$(catchReturn "$handler" directoryRequire "$sshHome") || return $?
      fi
      [ -f "$sshKnown" ] || touch "$sshKnown" || throwEnvironment "$handler" "Unable to create $sshKnown" || return $?
      catchEnvironment "$handler" chmod 700 "$sshHome" || return $?
      catchEnvironment "$handler" chmod 600 "$sshKnown" || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  printf "%s\n" "$sshKnown"
}
_sshKnownHostsFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
sshKnownHostAdd() {
  local handler="_${FUNCNAME[0]}"
  local exitCode=0 verbose=false sshKnown=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose) verbose=true ;;
    *)
      [ -n "$sshKnown" ] || sshKnown="$(catchEnvironment "$handler" sshKnownHostsFile --create)" || return $?
      local remoteHost="$1"
      if grep -q "$remoteHost" "$sshKnown"; then
        ! $verbose || decorate info "Host $remoteHost already known"
      else
        local output
        output=$(fileTemporaryName "$handler") || return $?
        if ssh-keyscan "${verboseArgs[@]+"${verboseArgs[@]+}"}" "$remoteHost" >"$output" 2>&1; then
          catchEnvironment "$handler" cat "$output" >>"$sshKnown" || returnClean $? "$output" || return $?
          catchReturn "$handler" rm -f "$output" || return $?
          ! $verbose || decorate success "Added $remoteHost to $sshKnown"
        else
          exitCode=$?
          catchReturn "$handler" rm -f "$output" || return $?
          printf "%s: %s\nOUTPUT:\n%s\nEND OUTPUT\n" "$(decorate error "Failed to add $remoteHost to $sshKnown")" "$(decorate code "$exitCode")" "$(decorate code <"$output" | decorate wrap ">> ")" 1>&2
        fi
      fi
      ;;
    esac
    shift
  done
  [ -n "$sshKnown" ] || throwArgument "$handler" "Need at least one host to add" || return $?
  return $exitCode
}
_sshKnownHostAdd() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
sshKnownHostRemove() {
  local handler="_${FUNCNAME[0]}"
  local sshKnown="" exitCode=0 verbose=false verboseArgs=() backupFlag=true
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --skip-backup | --no-backup)
      backupFlag=false
      ;;
    --verbose)
      verbose=true
      verboseArgs=("-v")
      ;;
    *)
      [ -n "$sshKnown" ] || sshKnown="$(catchEnvironment "$handler" sshKnownHostsFile)" || return $?
      local remoteHost="$1"
      if ! grepSafe -q -e "$(quoteGrepPattern "$remoteHost")" <"$sshKnown"; then
        ! $verbose || decorate info "Host $remoteHost already removed"
      else
        local backupName
        backupName="$sshKnown.$(dateToday)"
        if $backupFlag && [ -f "$backupName" ]; then
          ! $verbose || decorate info "Rotating $(decorate file "$backupName")"
          catchEnvironment "$handler" rotateLog "$backupName" 9 || return $?
        fi
        catchEnvironment "$handler" cp "$sshKnown" "$backupName" || return $?
        catchEnvironment "$handler" grepSafe -v -e "$(quoteGrepPattern "$remoteHost")" <"$backupName" >"$sshKnown" || return $?
        $backupFlag || catchEnvironment "$handler" rm -f "$backupName" || return $?
        ! $verbose || decorate success "Removed $(decortae value "$remoteHost") from $(decorate file "$sshKnown")"
      fi
      ;;
    esac
    shift
  done
  [ -n "$sshKnown" ] || throwArgument "$handler" "Need at least one host to remove" || return $?
}
_sshKnownHostRemove() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
sshSetup() {
  local forceFlag=false servers=() keyType="ed25519" keyBits=2048 minBits=512
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --type)
      shift
      keyType="$(validate "$handler" String "$argument" "${1-}")" || return $?
      case "$keyType" in ed25519 | rsa | dsa) ;; *) throwArgument "$handler" "Key type $1 is not known: ed25519 | rsa | dsa" || return $? ;; esac
      ;;
    --bits)
      shift
      keyBits=$(validate "$handler" PositiveInteger "$argument" "${1-}") || return $?
      [ "$keyBits" -ge "$minBits" ] || throwArgument "$handler" "Key bits must be at least $minBits: $keyBits" || return $?
      ;;
    --force) forceFlag=true ;;
    *) servers+=("$argument") ;;
    esac
    shift
  done
  local home
  home=$(catchReturn "$handler" userHome) || return $?
  local sshHomePath="$home/.ssh/"
  [ -d "$sshHomePath" ] || mkdir -p "$sshHomePath" || throwEnvironment "$handler" "Can not create $sshHomePath" || return $?
  catchEnvironment "$handler" chmod 700 "$sshHomePath" || return $?
  user="$(catchEnvironment "$handler" whoami)" || return $?
  keyName="$user@$(catchEnvironment "$handler" uname -n)" || return $?
  if $forceFlag && [ -f "$keyName" ]; then
    [ ${#servers[@]} -gt 0 ] || returnArgument "Key $keyName already exists, exiting." || return $?
  else
    local newKeys=("$keyName" "$keyName.pub")
    statusMessage decorate info "Generating $keyName (keyType $keyType $keyBits keyBits)"
    catchEnvironment "$handler" muzzle pushd "$sshHomePath" || return $?
    catchEnvironment "$handler" ssh-keygen -f "$keyName" -t "$keyType" -b "$keyBits" -C "$keyName" -q -N "" || returnUndo $? muzzle popd || return $?
    catchEnvironment "$handler" muzzle popd || returnClean $? "${newKeys[@]}" || return $?
    local targetKeys=("id_$keyType" "id_$keyType.pub")
    local index
    for index in "${!targetKeys[@]}"; do
      catchEnvironment "$handler" cp "${newKeys[index]}" "${targetKeys[index]}" || returnClean $? "${targetKeys[@]}" "${newKeys[@]}" || return $?
    done
  fi
  local server
  for server in "${servers[@]}"; do
    local showServer
    showServer=$(decorate value "$server")
    statusMessage --last printf "%s\n" "Pushing to $showServer – (Please authenticate with sftp)"
    if ! printf "cd .ssh\n""put %s\n""quit" "$keyName.pub" | sftp "$server" >/dev/null; then
      throwEnvironment "$handler" "failed to upload key to $showServer" || return $?
    fi
    statusMessage decorate info "Configuring $server ..."
    if ! printf 'cd ~\n'"cd .ssh\n""cat *pub > authorized_keys\n""exit" | ssh -T "$server" >/dev/null; then
      throwEnvironment "$handler" "failed to add to authorized_keys on $showServer" || return $?
    fi
    statusMessage decorate success "Completed $server"
  done
}
_sshSetup() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_generateSSHKeyPair() {
  local keyName keyType keyBits
  keyType=ed25519
  keyBits=2048
  keyName="$1"
  ssh-keygen -f "$keyName" -t "$keyType" -b $keyBits -C "$keyName" -q -N ""
}
sysvInitScriptInstall() {
  local handler="_${FUNCNAME[0]}"
  local initHome=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local baseName target
      if [ -z "$initHome" ]; then
        initHome=$(__sysvInitScriptInitHome "$handler") || return $?
      fi
      baseName=$(catchArgument "$handler" basename "$argument") || return $?
      target="$initHome/$baseName"
      [ -x "$argument" ] || throwArgument "$handler" "Not executable: $argument" || return $?
      if [ -f "$target" ]; then
        if diff -q "$1" "$target" >/dev/null; then
          statusMessage decorate success "reinstalling script: $(decorate code "$baseName")"
        else
          throwEnvironment "$handler" "$(decorate code "$target") already exists - remove first" || return $?
        fi
      else
        statusMessage decorate success "installing script: $(decorate code "$baseName")"
      fi
      catchEnvironment "$handler" cp -f "$argument" "$target" || return $?
      statusMessage decorate warning "Updating mode of $(decorate code "$baseName") ..."
      catchEnvironment "$handler" chmod +x "$target" || return $?
      statusMessage decorate warning "rc.d defaults $(decorate code "$baseName") ..."
      catchEnvironment "$handler" update-rc.d "$baseName" defaults || return $?
      statusMessage --last printf -- "%s %s\n" "$(decorate code "$baseName")" "$(decorate success "installed successfully")"
      ;;
    esac
    shift
  done
}
_sysvInitScriptInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
sysvInitScriptUninstall() {
  local handler="_${FUNCNAME[0]}"
  local initHome=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local baseName target
      if [ -z "$initHome" ]; then
        initHome=$(__sysvInitScriptInitHome "$handler") || return $?
      fi
      baseName=$(catchArgument "$handler" basename "$argument") || return $?
      target="$initHome/$baseName"
      if [ -f "$target" ]; then
        update-rc.d -f "$baseName" remove || throwEnvironment "$handler" "update-rc.d $baseName remove failed" || return $?
        catchEnvironment "$handler" rm -f "$target" || return $?
        printf "%s %s\n" "$(decorate code "$baseName")" "$(decorate success "removed successfully")"
      else
        printf "%s %s\n" "$(decorate code "$baseName")" "$(decorate warning "not installed")"
      fi
      ;;
    esac
    shift
  done
}
_sysvInitScriptUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__sysvInitScriptInitHome() {
  local handler="$1" initHome=/etc/init.d
  [ -d "$initHome" ] || throwEnvironment "$handler" "sysvInit directory does not exist $(decorate code "$initHome")" || return $?
  printf "%s\n" "$initHome"
}
aptKeyAddOpenTofu() {
  local handler="_${FUNCNAME[0]}"
  local args=(
    --title OpenTOFU
    --name opentofu --url https://get.opentofu.org/opentofu.gpg
    --name opentofu-repo --url https://packages.opentofu.org/opentofu/tofu/gpgkey
    --repository-url https://packages.opentofu.org/opentofu/tofu/any/
    --release any
    --source deb-src)
  __help "$handler" "$@" || return 0
  catchReturn "$handler" aptKeyAdd "${args[@]}" || return $?
}
_aptKeyAddOpenTofu() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
aptKeyRemoveOpenTofu() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  catchReturn "$handler" aptKeyRemove opentofu "$@" || return $?
}
_aptKeyRemoveOpenTofu() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
tofuInstall() {
  local handler="_${FUNCNAME[0]}" binary="tofu"
  __help "$handler" "$@" || return 0
  ! executableExists "$binary" || return 0
  catchReturn "$handler" packageInstall apt-transport-https ca-certificates curl gnupg || return $?
  catchReturn "$handler" aptKeyAddOpenTofu || return $?
  catchReturn "$handler" packageInstall "$binary" "$@" || return $?
  executableExists "$binary" || throwEnvironment "$handler" "No $binary binary found - installation failed" || return $?
}
_tofuInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
tofuUninstall() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  catchReturn "$handler" packageWhichUninstall tofu tofu "$@" || return $?
  catchReturn "$handler" aptKeyRemoveOpenTofu || return $?
  catchReturn "$handler" packageUpdate --force || return $?
}
_tofuUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
aptKeyAddHashicorp() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  catchReturn "$handler" aptKeyAdd --title Hashicorp --name hashicorp --url https://apt.releases.hashicorp.com/gpg || return $?
}
_aptKeyAddHashicorp() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
aptKeyRemoveHashicorp() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  catchReturn "$handler" aptKeyRemove hashicorp "$@" || return $?
}
_aptKeyRemoveHashicorp() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
terraformInstall() {
  local handler="_${FUNCNAME[0]}" binary="terraform"
  __help "$handler" "$@" || return 0
  ! executableExists "$binary" || return 0
  if aptIsInstalled; then
    catchReturn "$handler" packageInstall gnupg software-properties-common curl figlet || return $?
    catchReturn "$handler" aptKeyAddHashicorp || return $?
  fi
  catchReturn "$handler" packageInstall "$binary" "$@" || return $?
  executableExists "$binary" || throwEnvironment "$handler" "No $binary binary found - installation failed" || return $?
}
_terraformInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
terraformUninstall() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  executableExists terraform || return 0
  catchReturn "$handler" packageWhichUninstall terraform terraform "$@" || return $?
  catchReturn "$handler" aptKeyRemoveHashicorp || return $?
  catchReturn "$handler" packageUpdate --force || return $?
}
_terraformUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mariadbInstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchReturn "$handler" packageGroupInstall mariadb || return $?
}
_mariadbInstall() {
  true || mariadbInstall --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mariadbUninstall() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  catchReturn "$handler" packageGroupUninstall mariadb || return $?
}
_mariadbUninstall() {
  true || mariadbUninstall --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mariadbDump() {
  local handler="_${FUNCNAME[0]}"
  local options=() printFlag=false binary
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --print)
      printFlag=true
      ;;
    --binary)
      shift
      binary=$(validate "$handler" Executable "$argument" "${1-}") || return $?
      ;;
    --lock)
      options+=(--lock-tables)
      ;;
    --user)
      shift
      options+=("--user=$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --password)
      shift
      options+=("--password=$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    --port)
      shift
      options+=("--port=$(validate "$handler" Integer "$argument" "${1-}")") || return $?
      ;;
    --host)
      shift
      options+=("--host=$(validate "$handler" String "$argument" "${1-}")") || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  export MARIADB_BINARY_DUMP
  [ -n "$binary" ] || binary=$(buildEnvironmentGet MARIADB_BINARY_DUMP) || return $?
  [ -n "$binary" ] || binary=$(packageDefault mysqldump)
  [ -n "$binary" ] || throwArgument "$handler" "--binary not supplied and MARIADB_BINARY_DUMP is blank - at least one is required (MARIADB_BINARY_DUMP=${MARIADB_BINARY_DUMP-})" || return $?
  executableExists "$binary" || catchEnvironment "$handler" "$binary not found in PATH: $PATH" || return $?
  options+=(--add-drop-table -c)
  if $printFlag; then
    printf "%s\n" "$binary ${options[*]-}"
  else
    "$binary" "${options[@]}" | mariadbDumpClean
  fi
}
_mariadbDump() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mariadbDumpClean() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  LC_CTYPE=C LANG=C sed '/^\/\*M!999999/d'
}
_mariadbDumpClean() {
  true || mariadbDumpClean --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mariadbConnect() {
  local handler="_${FUNCNAME[0]}"
  local dsn="" binary="" printFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --binary)
      shift
      binary=$(validate "$handler" Callable "$argument" "${1-}") || return $?
      ;;
    --print)
      printFlag=true
      ;;
    *)
      urlValid "$argument" || throwArgument "dsn is not valid: ${#argument} chars" || return $?
      dsn="$argument"
      shift
      break
      ;;
    esac
    shift
  done
  export MARIADB_BINARY_CONNECT
  [ -n "$binary" ] || binary=$(buildEnvironmentGet MARIADB_BINARY_CONNECT) || return $?
  [ -n "$binary" ] || binary=$(packageDefault mysql)
  [ -n "$binary" ] || throwArgument "$handler" "--binary not supplied and MARIADB_BINARY_CONNECT is blank - at least one is required (MARIADB_BINARY_CONNECT=${MARIADB_BINARY_CONNECT-})" || return $?
  $printFlag || isCallable "$binary" || throwArgument "$handler" "binary $binary is not executable (MARIADB_BINARY_CONNECT=${MARIADB_BINARY_CONNECT-})" || return $?
  [ -n "$dsn" ] || throwArgument "$handler" "dsn required" || return $?
  local url="" path="" name="" user="" password="" host="" port="" error=""
  eval "$(urlParse "$dsn")"
  [ -z "$error" ] || throwEnvironment "DSN Parsing failed: $error" || return $?
  isPositiveInteger "$port" || port=3306
  : "$url $path $error"
  [ -n "$user" ] && [ -n "$password" ] && [ -n "$name" ] && [ -n "$host" ] || throwArgument "$handler" "Unable to parse DSN: dsn=(${#dsn} chars)" "name=$name" "host=$host" "user=$user" "password=(${#password} chars)" || return $?
  local aa=(-u "$user" "-p$password" -h "$host")
  if [ $port != 3306 ]; then
    aa+=("--port=$port")
  fi
  aa+=("$name" "$@")
  if $printFlag; then
    printf "%s %s\n" "$binary" "${aa[*]}"
  else
    "$binary" "${aa[@]}"
  fi
}
_mariadbConnect() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__testLoader() {
  __buildFunctionLoader __testSuite test "$@"
}
testSuite() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_testSuite() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertExitCode() {
  __testLoader "_${FUNCNAME[0]}" _assertExitCodeHelper --success true "$@" || return $?
}
_assertExitCode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertNotExitCode() {
  __testLoader "_${FUNCNAME[0]}" _assertExitCodeHelper --success false "$@" || return $?
}
_assertNotExitCode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertEquals() {
  __testLoader "_${FUNCNAME[0]}" _assertEqualsHelper --success true "$@" || return $?
}
_assertEquals() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertNotEquals() {
  __testLoader "_${FUNCNAME[0]}" _assertEqualsHelper --success false "$@" || return $?
}
_assertNotEquals() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertStringNotEmpty() {
  __testLoader "_${FUNCNAME[0]}" _assertStringEmptyHelper --success false "$@" || return $?
}
_assertStringNotEmpty() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertStringEmpty() {
  __testLoader "_${FUNCNAME[0]}" _assertStringEmptyHelper --success true "$@" || return $?
}
_assertStringEmpty() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertContains() {
  __testLoader "_${FUNCNAME[0]}" _assertContainsHelper --success true "$@" || return $?
}
_assertContains() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertNotContains() {
  __testLoader "_${FUNCNAME[0]}" _assertContainsHelper --success false "$@" || return $?
}
_assertNotContains() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertDirectoryExists() {
  __testLoader "_${FUNCNAME[0]}" _assertDirectoryExistsHelper "$@" || return $?
}
_assertDirectoryExists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertDirectoryDoesNotExist() {
  __testLoader "_${FUNCNAME[0]}" _assertDirectoryExistsHelper --success false "$@" || return $?
}
_assertDirectoryDoesNotExist() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertDirectoryEmpty() {
  local handler="_${FUNCNAME[0]}"
  __testLoader "$handler" _assertDirectoryExistsHelper "$@" || return $?
  __testLoader "$handler" _assertDirectoryEmptyHelper "$@" || return $?
}
_assertDirectoryEmpty() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertDirectoryNotEmpty() {
  local handler="_${FUNCNAME[0]}"
  __testLoader "$handler" _assertDirectoryExistsHelper "$@" || return $?
  __testLoader "$handler" _assertDirectoryEmptyHelper --success false "$@" || return $?
}
_assertDirectoryNotEmpty() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertFileExists() {
  __testLoader "_${FUNCNAME[0]}" _assertFileExistsHelper "$@" || return $?
}
_assertFileExists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertFileDoesNotExist() {
  __testLoader "_${FUNCNAME[0]}" _assertFileExistsHelper --success false "$@" || return $?
}
_assertFileDoesNotExist() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertOutputEquals() {
  __testLoader "_${FUNCNAME[0]}" _assertOutputEqualsHelper "$@" || return $?
}
_assertOutputEquals() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertOutputContains() {
  __testLoader "_${FUNCNAME[0]}" _assertOutputContainsHelper --success true "$@" || return $?
}
_assertOutputContains() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertOutputDoesNotContain() {
  __testLoader "_${FUNCNAME[0]}" _assertOutputContainsHelper --success false "$@" || return $?
}
_assertOutputDoesNotContain() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertFileContains() {
  __testLoader "_${FUNCNAME[0]}" __assertFileContainsHelper true false --line-depth 2 "$@" || return $?
}
_assertFileContains() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertFileDoesNotContain() {
  __testLoader "_${FUNCNAME[0]}" __assertFileContainsHelper false false --line-depth 2 "$@" || return $?
}
_assertFileDoesNotContain() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertFileSize() {
  __testLoader "_${FUNCNAME[0]}" _assertFileSizeHelper "$@" || return $?
}
_assertFileSize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertNotFileSize() {
  __testLoader "_${FUNCNAME[0]}" _assertFileSizeHelper --success false "$@" || return $?
}
_assertNotFileSize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertZeroFileSize() {
  assertFileSize --handler "_${FUNCNAME[0]}" 0 "$@" || return $?
}
_assertZeroFileSize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertNotZeroFileSize() {
  assertNotFileSize --handler "_${FUNCNAME[0]}" 0 "$@" || return $?
}
_assertNotZeroFileSize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertGreaterThan() {
  __testLoader "_${FUNCNAME[0]}" _assertNumericHelper "$@" -gt || return $?
}
_assertGreaterThan() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertGreaterThanOrEqual() {
  __testLoader "_${FUNCNAME[0]}" _assertNumericHelper "$@" -ge || return $?
}
_assertGreaterThanOrEqual() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertLessThan() {
  __testLoader "_${FUNCNAME[0]}" _assertNumericHelper "$@" -lt || return $?
}
_assertLessThan() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
assertLessThanOrEqual() {
  __testLoader "_${FUNCNAME[0]}" _assertNumericHelper "$@" -le || return $?
}
_assertLessThanOrEqual() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mockEnvironmentStart() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_mockEnvironmentStart() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mockEnvironmentStop() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_mockEnvironmentStop() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mockConsoleAnimationStart() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_mockConsoleAnimationStart() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
mockConsoleAnimationStop() {
  __testLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_mockConsoleAnimationStop() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
returnAssert() {
  return 97
}
returnIdentical() {
  return 105
}
returnLeak() {
  return 108
}
__xmlHeader() {
  printf "%s%s%s\n" "<?xml" "$(__xmlAttributes "$@" "version=1.0" "encoding=UTF-8")" "?>"
}
__xmlTag() {
  local name="$1" && shift
  printf -- "<%s%s />\n" "$name" "$(__xmlAttributes "$@")"
}
__xmlTagOpen() {
  local name="$1" && shift
  printf -- "<%s%s>\n" "$name" "$(__xmlAttributes "$@")"
}
__xmlTagClose() {
  local name="$1" && shift
  printf -- "</%s>\n" "$name"
}
__xmlAttributeValue() {
  while [ $# -gt 0 ]; do
    local value="$1"
    value=${value//&/&amp;}
    value=${value//\"/&quot;}
    printf -- "%s\n" "$value"
    shift
  done
}
__xmlAttributes() {
  local attr=() found=()
  while [ $# -gt 0 ]; do
    case "$1" in
    "") ;;
    *=*)
      local name value="$1"
      name="${value%%=*}"
      value="${value#*=}"
      if [ ${#found[@]} -eq 0 ] || ! inArray "$name" "${found[@]}"; then
        found+=("$name")
        [ -z "$value" ] || name="$(printf -- "%s=%s" "$name" "\"$(__xmlAttributeValue "$value")")\""
        attr+=("$name")
      fi
      ;;
    *) if
      [ ${#found[@]} -eq 0 ] || ! inArray "$1" "${found[@]}"
    then
      attr+=("$1") && found+=("$1")
    fi ;;
    esac
    shift
  done
  [ ${#attr[@]} -eq 0 ] || printf -- " %s" "${attr[*]-}"
}
junitOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagOpen testsuites "$@" name="" tests=0 failures=0 errors=0 skipped=0 assertions=0 time=0 timestamp="$(date +%FT%T)" || return $?
}
_junitOpen() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitClose() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagClose testsuites "$@" || return $?
}
_junitClose() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitSuiteOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTag testsuite "$@" name || return $?
}
_junitSuiteOpen() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitSuiteClose() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagClose testsuite "$@" || return $?
}
_junitSuiteClose() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitProperties() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagOpen properties || return $?
  junitPropertyList --handler "$handler" "$@" || return $?
  catchReturn "$handler" __xmlTagClose properties || return $?
}
_junitProperties() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitPropertyList() {
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *)
      local name value
      IFS="=" read -r name value <<<"$1" || :
      [ -n "$name" ] || continue
      if stringContains "$value" $'\n'; then
        catchReturn "$handler" __xmlTagOpen property name="$name" || return $?
        catchReturn "$handler" printf "%s\n" "$value" || return $?
        catchReturn "$handler" __xmlTagClose property || return $?
      else
        catchReturn "$handler" __xmlTag property name="$name" value="$value" || return $?
      fi
      ;;
    esac
    shift
  done
}
_junitPropertyList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitSystemOutputOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagOpen system-out || return $?
}
_junitSystemOutputOpen() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitSystemOutputClose() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlCLose system-out || return $?
}
_junitSystemOutputClose() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitSystemErrorOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagOpen system-err || return $?
}
_junitSystemErrorOpen() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitSystemErrorClose() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlCLose system-err || return $?
}
_junitSystemErrorClose() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitTestCaseOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTagOpen testcase "$@" || return $?
}
_junitTestCaseOpen() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitTestCaseClose() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlClsoe testcase || return $?
}
_junitTestCaseClose() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitTestCaseSkipped() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlTag skipped message="$*" || return $?
}
_junitTestCaseSkipped() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitTestCaseFailedOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  local message="$1" && shift
  catchReturn "$handler" __xmlTagOpen failure message="$message" "$@" || return $?
}
_junitTestCaseFailedOpen() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitTestCaseFailedClose() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlCLose failure || return $?
}
_junitTestCaseFailedClose() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitTestCaseErrorOpen() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  local message="$1" && shift
  catchReturn "$handler" __xmlTagOpen error message="$message" "$@" || return $?
}
_junitTestCaseErrorOpen() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
junitTestCaseErrorClose() {
  local handler="_${FUNCNAME[0]}"
  [ "$1" != "--help" ] || __help "$handler" "$@" || return 0
  catchReturn "$handler" __xmlCLose error || return $?
}
_junitTestCaseErrorClose() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashLint() {
  local handler="_${FUNCNAME[0]}" fixFlag=false verboseFlag=false
  local installed=false
  exec 3>/dev/null 4>&1
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --fix)
      fixFlag=true
      ;;
    --verbose)
      exec 3>&1 4>/dev/null
      verboseFlag=true
      ;;
    *)
      if
        ! $installed
      then
        catchReturn "$handler" packageWhich shellcheck shellcheck || return $?
        catchReturn "$handler" pcregrepInstall || return $?
        installed=true
      fi
      if ! [ -f "$argument" ]; then
        throwArgument "$handler" "$(printf -- "%s: %s PWD: %s" "Not a item" "$(decorate code "$argument")" "$(pwd)")" || return $?
      fi
      catchEnvironment "$handler" bash -n "$argument" 1>&3 2>&4 || returnUndo $? printf "%s\n" "bash -n" 1>&4 || ! exec 3>&- 4>&- || return $?
      catchEnvironment "$handler" shellcheck "$argument" 1>&3 2>&4 || returnUndo $? printf "%s\n" "shellcheck" 1>&4 || ! exec 3>&- 4>&- || return $?
      local found
      if found=$(__pcregrep -n -l -M '\n\}\n#' "$argument"); then
        if $fixFlag; then
          catchEnvironment "$handler" sed -i 's/}\n#/}\n\n#/' "$argument" || returnUndo $? printf "%s\n" "comment following brace" 1>&4 || ! exec 3>&- 4>&- || return $?
          $verboseFlag
        else
          throwEnvironment "$handler" "found }\\n#: $(decorate code "$found")" 1>&3 2>&3 || returnUndo $? printf "%s\n" "comment following brace" 1>&4 || ! exec 3>&- 4>&- || return $?
        fi
      fi
      ;;
    esac
    shift
  done
  exec 3>&- 4>&1
}
_bashLint() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashLintFiles() {
  local handler="_${FUNCNAME[0]}"
  local verbose=false failedFiles=() checkedFiles=() binary="" sleepDelay=7 ii=() interactive=false ff=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verbose=true
      ;;
    --fix)
      ff=("$argument")
      ;;
    --exec)
      shift
      binary="$(validate "$handler" Callable "$argument" "${1-}")" || return $?
      ii+=("$argument" "$binary")
      ;;
    --interactive)
      interactive=true
      ;;
    *) checkedFiles+=("$(validate "$handler" File "checkFile" "$argument")") || return $? ;;
    esac
    shift || throwArgument "$handler" "shift after $argument failed" || return $?
  done
  catchReturn "$handler" buildEnvironmentLoad BUILD_INTERACTIVE_REFRESH || return $?
  statusMessage --first decorate info "Checking all shell scripts ..."
  local source=none
  if [ ${#checkedFiles[@]} -gt 0 ]; then
    source="argument"
    ! $verbose || statusMessage decorate info "Reading item list from arguments ..."
    for argument in "${checkedFiles[@]}"; do
      [ -n "$argument" ] || continue
      if ! message=$(_bashLintFilesHelper "$verbose" "$argument" "$source"); then
        statusMessage decorate warning "Failed: $(decorate file "$argument") $(decorate code "$message")"
        failedFiles+=("$argument")
      fi
    done
  elif [ $# -eq 0 ]; then
    source="stdin"
    ! $verbose || statusMessage decorate info "Reading item list from stdin ..."
    while read -r argument; do
      [ -n "$argument" ] || continue
      if ! message=$(_bashLintFilesHelper "$verbose" "$argument" "$source"); then
        statusMessage decorate warning "Failed: $(decorate file "$argument") $message)"
        failedFiles+=("$argument")
      fi
    done
  fi
  if [ "${#failedFiles[@]}" -gt 0 ]; then
    {
      statusMessage --last printf -- "%s\n" "$(decorate warning "$(pluralWord ${#failedFiles[@]} file) failed:")"
      for failedFile in "${failedFiles[@]}"; do
        bashLint "${ff[@]+"${ff[@]}"}" --verbose "$failedFile" 2>/dev/null | dumpPipe "$(decorate warning "$(consoleHeadingLine "•" "••[ $(decorate file "$failedFile") ]")")"
      done
    } 1>&2
    if $interactive; then
      bashLintFilesInteractive "${ii[@]+"${ii[@]}"}" "${failedFiles[@]}"
    elif [ -n "$binary" ]; then
      if [ ${#failedFiles[@]} -gt 0 ]; then
        "$binary" "${failedFiles[@]}"
      fi
    fi
    return 1
  fi
  statusMessage decorate success "All scripts passed validation ($source)"
  printf -- "\n"
}
_bashLintFiles() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_bashLintFilesHelper() {
  local verbose="$1" file="$2" source="$3" reason vv=()
  ! $verbose || vv+=(--verbose)
  ! $verbose || statusMessage decorate info "👀 Checking \"$file\" ($source) ..." || :
  if reason=$(bashLint "${vv[@]+"${vv[@]}"}" "$file"); then
    ! $verbose || statusMessage --last decorate success "bashLint $file passed"
  else
    ! $verbose || statusMessage --last decorate info "bashLint $file failed: $reason"
    printf -- "%s\n" "$reason"
    return 1
  fi
}
bashLintFilesInteractive() {
  local handler="_${FUNCNAME[0]}"
  local sleepDelay="" binary=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --exec) shift && binary="$(validate "$handler" Callable "$argument" "${1-}")" || return $? ;;
    --delay) shift && sleepDelay=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $? ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  printf -- "%s\n%s\n%s\n" "$(decorate red "BEFORE")" \
    "$(decorate label "Queue")" \
    "$(decorate subtle "$(printf -- "- %s\n" "$@")")"
  while [ "$#" -gt 0 ]; do
    if _bashLintInteractiveCheck "$handler" "$@"; then
      shift
    else
      local countdown=$sleepDelay
      while [ "$countdown" -gt 0 ]; do
        statusMessage decorate warning "Refresh in $(decorate value " $countdown ") $(plural "$countdown" second seconds)"
        countdown=$((countdown - 1))
        sleep 1 || throwEnvironment "$handler" "Interrupt ..." || return $?
      done
      clear
    fi
  done
}
_bashLintFilesInteractive() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_bashLintInteractiveCheck() {
  local handler="${1-}" script="${2-}" scriptPassed
  if [ -z "$script" ]; then
    return 0
  fi
  if failedReason=$(bashLint --verbose "$1"); then
    scriptPassed=true
  else
    scriptPassed=false
  fi
  if $scriptPassed; then
    bigText "SUCCESS $(basename "$script")" | decorate green
    consoleHeadingBoxed "$script now passes" | decorate BOLD green
    decorate orange "$(consoleLine "*")"
    return 0
  fi
  shift 2
  bigText "FAIL $(basename "$script")" | decorate BOLD red | decorate wrap "$(decorate subtle "bashLint ")"
  printf -- "%s\n%s\n%s\n" "$(decorate red "$failedReason")" \
    "$(decorate label "Queue")" \
    "$(decorate subtle "$(printf -- "- %s\n" "$@")")"
  decorate blue "$(consoleLine "+-")"
  decorate info "$# $(plural $# item files) remain"
  return 1
}
bashFindUncaughtAssertions() {
  local handler="_${FUNCNAME[0]}"
  local listFlag=false binary="" directory="" ff=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || throwArgument "$handler" "blank argument" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --exec) shift && binary="$(validate "$handler" Callable "$argument" "${1-}")" || return $? ;;
    --exclude) shift && ff+=(! -path "*$(validate "$handler" String "$argument" "${1-}")*") || return $? ;;
    --list) listFlag=true ;;
    *)
      if
        [ -n "$directory" ]
      then
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      directory=$(validate "$handler" Directory "directory" "$1") || return $?
      ;;
    esac
    shift
  done
  [ -n "$directory" ] || directory=$(catchReturn "$handler" pwd) || return $?
  local tempFile
  tempFile=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempFile")
  local suffixCheck='(local|return|; then|\ \|\||:[0-9]+:\s*#|\(\)\ \{)'
  {
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" "${ff[@]+"${ff[@]}"}" -print0 | xargs -0 grep -n -E 'assert[A-Z]|usageArgument' | grep -E -v "$suffixCheck" || :
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" "${ff[@]+"${ff[@]}"}" -print0 | xargs -0 grep -n -E 'return(Clean|Undo|Argument|Environment|Code)' | grep -E -v "$suffixCheck" || :
    find "${directory%/}" -type f -name '*.sh' ! -path "*/.*/*" "${ff[@]+"${ff[@]}"}" -print0 | xargs -0 grep -n -E '(execute|catch|throw)[A-Z ]' | grep -E -v "$suffixCheck" || :
  } >"$tempFile" || returnClean $? "${clean[@]}" || return $?
  local problemFiles=()
  if [ -s "$tempFile" ]; then
    if [ -n "$binary" ] || $listFlag; then
      local lastProblemFile="" problemLines=() problemFile=""
      while IFS='' read -r problemFile; do
        local problemLine="${problemFile##*:}"
        problemFile="${problemFile%:*}"
        if [ "$problemFile" != "$lastProblemFile" ]; then
          if $listFlag && [ -n "$lastProblemFile" ]; then
            printf -- "%s (Lines %s)\n" "$(decorate code "$lastProblemFile")" "$(IFS=, decorate magenta "${problemLines[*]}")"
          fi
          problemFiles+=("$problemFile")
          lastProblemFile=$problemFile
          problemLines=()
        fi
        problemLines+=("$problemLine")
      done < <(cut -d : -f 1,2 <"$tempFile" | sort -u)
      if $listFlag && [ -n "$lastProblemFile" ]; then
        printf -- "%s (Lines %s)\n" "$(decorate code "$lastProblemFile")" "$(IFS=, decorate magenta "${problemLines[*]}")"
      fi
      [ ${#problemFiles[@]} -eq 0 ] || [ -z "$binary" ] || catchReturn "$binary" "${problemFiles[@]}" || returnClean $? "${clean[@]}" || return $?
    else
      catchEnvironment "$handler" cat "$tempFile" || returnClean $? "${clean[@]}" || return $?
    fi
  fi
  catchEnvironment "$handler" rm "$tempFile" || return $?
  [ ${#problemFiles[@]} -eq 0 ]
}
_bashFindUncaughtAssertions() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
validate() {
  local handler="_${FUNCNAME[0]}"
  local prefix="__validateType"
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  [ $# -ge 4 ] || throwArgument "$handler" "Missing arguments - expect 4 or more (#$#: $(decorate each code -- "$@"))" || return $?
  local handler="$1" && shift
  while [ $# -ge 3 ]; do
    local type="$1" name="$2" value="$3"
    if isFunction _validateTypeMapper; then
      type=$(_validateTypeMapper "$type")
    fi
    local typeFunction="$prefix$type"
    isFunction "$typeFunction" || throwArgument "$handler" "validate $type is not a valid type:"$'\n'"$(validateTypeList)" || return $?
    if ! "$typeFunction" "$value"; then
      local suffix=""
      [ -z "$value" ] || suffix=" $(decorate error "$value")"
      throwArgument "$handler" "$name ($(decorate each code -- "$@")) is not type $(decorate label "$type")$suffix" || return $?
    fi
    shift 3
  done
}
_validate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_validateThrow() {
  printf -- "%s\n" "$@" 1>&2
  return 2
}
__validateTypeString() {
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  printf "%s\n" "${1-}"
}
__validateTypePositiveInteger() {
  isPositiveInteger "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}
__validateTypeFunction() {
  isFunction "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}
__validateTypeCallable() {
  isCallable "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}
_validateHelperApplicationTest() {
  local test="$1" home="$2" item="$3"
  [ -n "$item" ] || _validateThrow "blank" || return $?
  item="${item#./}"
  item="${item#/}"
  test "$test" "$home/$item" || _validateThrow || return $?
  printf "%s\n" "$item"
}
_validateHelperCheck() {
  local testFlag="$1" && shift
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  test "$testFlag" "$@" || _validateThrow || return $?
  printf "%s\n" "$@"
}
__validateTypeEmptyString() {
  printf "%s\n" "${1-}"
  return 0
}
__validateTypeArray() {
  __validateTypeEmptyString "$@"
}
__validateTypeList() {
  __validateTypeEmptyString "$@"
}
__validateTypeColonDelimitedList() {
  __validateTypeEmptyString "$@"
}
__validateTypeArguments() {
  __validateTypeEmptyString "$@"
}
__validateTypeCommaDelimitedList() {
  __validateTypeEmptyString "$@"
}
__validateTypeUnsignedInteger() {
  isUnsignedInteger "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}
__validateTypeInteger() {
  isInteger "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}
__validateTypeNumber() {
  isNumber "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1#+}"
}
__validateTypeExecutable() {
  isExecutable "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}
__validateTypeApplicationDirectory() {
  local home directory="${1-}"
  home=$(buildHome) || return $?
  _validateHelperApplicationTest -d "$home" "${directory%/}" || return $?
}
__validateTypeApplicationFile() {
  local home file="${1-}"
  home=$(buildHome) || return $?
  _validateHelperApplicationTest -f "$home" "$file" || return $?
}
__validateTypeApplicationDirectoryList() {
  local value="${1-}"
  local home directories=() directory dd=() index=0
  home=$(catchReturn "$handler" buildHome) || return $?
  home="${home%/}"
  IFS=":" read -r -a directories <<<"$value" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    directory="$(___validateTypeApplicationDirectory "$home" "$directory")" || _validateThrow "element #$index ($(decorate error "$directory"): $(decorate value "$value")" || return $?
    dd+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${dd[@]+"${dd[@]}"}")"
}
__validateTypeFlag() {
  return 0
}
__validateTypeBoolean() {
  isBoolean "${1-}" || _validateThrow || return $?
  printf "%s\n" "$1"
}
__validateTypeBooleanLike() {
  local rs=0
  parseBoolean "${1-}" || rs=$?
  case "$rs" in
  0) rs="true" ;;
  1) rs="false" ;;
  *) _validateThrow "parse boolean failed" || return $? ;;
  esac
  printf "%s\n" "$rs"
}
__validateTypeDate() {
  dateValid "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}
__validateTypeDirectoryList() {
  local value="${1-}"
  local directories=() directory dd=() index=0
  IFS=":" read -r -a directories <<<"$value" || :
  for directory in "${directories[@]+"${directories[@]}"}"; do
    [ -n "$directory" ] || continue
    [ -d "$directory" ] || _validateThrow "element #$index is not type directory $(decorate code "$directory"): $(decorate value "$value")" || return $?
    dd+=("$directory")
    index=$((index + 1))
  done
  printf "%s\n" "$(listJoin ":" "${dd[@]+"${dd[@]}"}")"
}
__validateTypeEnvironmentVariable() {
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  environmentVariableNameValid "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}
__validateTypeExists() {
  _validateHelperCheck -e "$@" || return $?
}
__validateTypeFile() {
  _validateHelperCheck -f "$@" || return $?
}
__validateTypeDirectory() {
  _validateHelperCheck -d "${1%/}" || return $?
}
__validateTypeLink() {
  _validateHelperCheck -L "$@" || return $?
}
__validateTypeFileDirectory() {
  [ -n "${1-}" ] || _validateThrow "blank" || return $?
  fileDirectoryExists "${1-}" || _validateThrow "Parent directory does not exist for $1" || return $?
  printf "%s\n" "${1-}"
}
__validateTypeRealDirectory() {
  local value="${1-}"
  [ -n "$value" ] || _validateThrow "blank" || return $?
  value=$(realPath "$value") || _validateThrow "realPath failed" || return $?
  [ -d "$value" ] || _validateThrow || return $?
  printf "%s\n" "${value%/}"
}
__validateTypeRealFile() {
  local value="${1-}"
  [ -n "$value" ] || _validateThrow "blank" || return $?
  value=$(realPath "$value") || _validateThrow "realPath failed" || return $?
  printf "%s\n" "$value"
}
__validateTypeRemoteDirectory() {
  [ "${1:0:1}" = "/" ] || _validateThrow "begins with a slash" || return $?
  printf "%s\n" "${1%/}"
}
__validateTypeSecret() {
  __validateTypeString "$@"
}
__validateTypeURL() {
  urlValid "${1-}" || _validateThrow || return $?
  printf "%s\n" "${1-}"
}
__validateTypeLoadEnvironmentFile() {
  local handler="returnMessage"
  local envFile bashEnv
  envFile=$(__validateTypeFile "$@") || return $?
  bashEnv=$(fileTemporaryName "$handler") || return $?
  catchEnvironment "$handler" environmentFileToBashCompatible "$envFile" >"$bashEnv" || returnClean $? "$bashEnv" || return $?
  local exitCode=0
  set -a
  source "$bashEnv" || exitCode=$?
  set +a
  catchEnvironment "$handler" rm -f "$bashEnv" || return $?
  [ "$exitCode" != 0 ] || printf -- "%s\n" "$envFile"
  return "$exitCode"
}
validateTypeList() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local prefix="__validateType"
  declare -F | removeFields 2 | grepSafe -e "^$prefix" | cut -c "$((${#prefix} + 1))"- | sort
}
_validateTypeList() {
  true || validateTypeList --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isValidateType() {
  local handler="_${FUNCNAME[0]}"
  local prefix="__validateType"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local mapped
      mapped=$(_validateTypeMapper "$argument")
      isFunction "$prefix$mapped" || throwArgument "$handler" "Invalid type $argument (-> \"$mapped\")" || return $?
      ;;
    esac
    shift
  done
}
_isValidateType() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_validateTypeMapper() {
  while [ $# -gt 0 ]; do
    local t="$1"
    case "$(lowercase "$t")" in
    string) t=String ;;
    emptystring | string? | any) t=EmptyString ;;
    array) t=Array ;;
    list) t=List ;;
    flag) t=Flag ;;
    colondelimitedlist | list:) t=ColonDelimitedList ;;
    commadelimitedlist | list,) t=CommaDelimitedList ;;
    unsignedinteger | uint | unsigned) t=UnsignedInteger ;;
    positiveinteger | positive) t=PositiveInteger ;;
    integer | int) t=Integer ;;
    number) t=Number ;;
    function) t=Function ;;
    callable) t=Callable ;;
    executable | bin) t=Executable ;;
    applicationdirectory | appdir) t=ApplicationDirectory ;;
    applicationfile | appfile) t=ApplicationFile ;;
    applicationdirectorylist | appdirlist) t=ApplicationDirectoryList ;;
    boolean | bool) t=Boolean ;;
    booleanlike | "boolean?" | "bool?") t=BooleanLike ;;
    date) t=Date ;;
    directorylist | dirlist) t=DirectoryList ;;
    environmentvariable | env) t=EnvironmentVariable ;;
    loadenvironmentfile | load-env) t=LoadEnvironmentFile ;;
    exists) t=Exists ;;
    file) t=File ;;
    directory | dir) t=Directory ;;
    link) t=Link ;;
    filedirectory | parent) t=FileDirectory ;;
    realdirectory | realdir) t=RealDirectory ;;
    realfile | real) t=RealFile ;;
    remotedirectory | remotedir) t=RemoteDirectory ;;
    secret) t=Secret ;;
    url) t=URL ;;
    *) ;;
    esac
    printf "%s\n" "$t"
    shift
  done
}
__usageLoader() {
  __buildFunctionLoader __usageDocument usage "$@"
}
usageDocument() {
  __usageLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_usageDocument() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__usageDocumentCached() {
  local handler="${1-}" && shift
  local home="${1-}" && shift
  local functionName="${1-}" && shift
  local suffix="bin/build/documentation/$functionName.sh"
  local settingsFile="$home/$suffix"
  [ -f "$settingsFile" ] || return 1
  (
    local helpConsole="" helpPlain="no helpPlain in $suffix"
    catchEnvironment "$handler" source "$settingsFile" || return $?
    if [ "${BUILD_COLORS-}" != "false" ] && [ -n "$helpConsole" ]; then
      catchEnvironment "$handler" decorateThemed <<<"$helpConsole" || return $?
    else
      catchEnvironment "$handler" printf "%s\n" "$helpPlain" || return $?
    fi
  ) || return $?
}
usageDocumentSimple() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local source="${1-}" functionName="${2-}" returnCode="${3-}" color helpColor="info" icon="❌" skip=false && shift 3
  case "$returnCode" in 0) icon="🏆" && color="info" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="red" ;; *) color="orange" ;; esac
  [ "$returnCode" -eq 0 ] || exec 1>&2
  $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(returnCodeString "$returnCode")")" "$(decorate BOLD "$color" "$*")"
  export BUILD_HOME
  if [ ! -f "$source" ]; then
    [ -d "${BUILD_HOME-}" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
    source="$BUILD_HOME/$source"
    [ -f "$source" ] || returnArgument "Unable to locate $source (${PWD-})" || return $?
  fi
  if ! __usageDocumentCached "$handler" "${BUILD_HOME-}" "$functionName"; then
    bashFunctionComment "$source" "$functionName" | sed "s/{fn}/$functionName/g" | decorate "$helpColor"
  fi
  return "$returnCode"
}
_usageDocumentSimple() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
usageRequireBinary() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local usageFunction="${1-}" && shift
  if [ "$(type -t "$usageFunction")" != "function" ]; then
    catchArgument "$handler" "$(decorate code "$handler") must be a valid function" || return $?
  fi
  local binary
  for binary in "$@"; do
    executableExists "$binary" || throwEnvironment "$handler" "$binary is not available in path, not found: $(decorate code "$PATH")"
  done
}
_usageRequireBinary() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
usageRequireEnvironment() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local usageFunction="${1-}" && shift
  if [ "$(type -t "$usageFunction")" != "function" ]; then
    catchArgument "$handler" "$(decorate code "$handler") must be a valid function" || return $?
  fi
  local environmentVariable
  for environmentVariable in "$@"; do
    if [ -z "${!environmentVariable-}" ]; then
      throwEnvironment "$usageFunction" "Environment variable $(decorate code "$environmentVariable") is required" || return $?
    fi
  done
}
_usageRequireEnvironment() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
export XPC_SERVICE_NAME
export VSCODE_SHELL_INTEGRATION
export __CFBundleIdentifier
isPHPStorm() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  local xpc="${XPC_SERVICE_NAME-}" cfb=${__CFBundleIdentifier:-}
  [ "${xpc%%PhpStorm*}" != "$xpc" ] || [ "${cfb%%PhpStorm*}" != "$cfb" ]
}
_isPHPStorm() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isPyCharm() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  local xpc="${XPC_SERVICE_NAME-}"
  [ "${xpc%%pycharm*}" != "$xpc" ]
}
_isPyCharm() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isVisualStudioCode() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  [ "${VSCODE_SHELL_INTEGRATION-}" = "1" ]
}
_isVisualStudioCode() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
contextOpen() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  if isPHPStorm; then
    true || isPHPStorm --help
    phpstorm "$@"
  elif isPyCharm; then
    true || isPyCharm --help
    charm "$@"
  elif isVisualStudioCode; then
    true || isVisualStudioCode --help
    code "$@"
  elif [ -n "${EDITOR-}" ]; then
    $EDITOR "$@"
  elif [ -n "${VISUAL-}" ]; then
    $VISUAL "$@"
  fi
}
_contextOpen() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
contextShow() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  if isPHPStorm; then
    printf "%s\n" phpstorm
  elif isPyCharm; then
    printf "%s\n" charm
  elif isVisualStudioCode; then
    printf "%s\n" code
  elif [ -n "${EDITOR-}" ]; then
    printf "%s\n" "$EDITOR"
  elif [ -n "${VISUAL-}" ]; then
    printf "%s\n" "$VISUAL"
  else
    return 1
  fi
}
_contextShow() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
isVersion() {
  local part parts
  [ $# -gt 0 ] || return 1
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    [ -n "$1" ] || return 1
    IFS=. read -r -a parts < <(printf "%s\n" "$1") || :
    for part in "${parts[@]}"; do
      isUnsignedInteger "$part" || return 1
    done
    shift
  done
}
_isVersion() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
versionNoVee() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  while [ $# -gt 0 ]; do
    printf "%s\n" "${1#v}"
    shift
  done
}
_versionNoVee() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
releaseNotes() {
  local handler="_${FUNCNAME[0]}"
  local version="" home=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --application) shift && home="$(validate "$handler" Directory "$argument" "${1-}")" || return $? ;;
    *) if
      [ -n "$version" ]
    then
      decorate error "Version $version already specified: $argument"
    else
      version="$argument"
    fi ;;
    esac
    shift
  done
  [ -n "$home" ] || home="$(catchReturn "$handler" buildHome)" || return $?
  catchReturn "$handler" buildEnvironmentContext "$home" __releaseNotes "$handler" "$version" || return $?
}
_releaseNotes() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__releaseNotes() {
  local handler="$1" version="${2-}" home releasePath
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  if [ -z "$version" ]; then
    version=$(catchEnvironment "$handler" hookRun --application "$home" version-current) || return $?
    [ -n "$version" ] || throwEnvironment "$handler" "version-current hook returned blank" || return $?
  fi
  local notes
  notes=$(catchReturn "$handler" buildEnvironmentGet --application "$home" BUILD_RELEASE_NOTES) || return $?
  [ -n "$notes" ] || throwEnvironment "$handler" "BUILD_RELEASE_NOTES is blank" || return $?
  releasePath="${notes%/}"
  pathIsAbsolute "$releasePath" || releasePath=$(catchReturn "$handler" directoryPathSimplify "$home/$releasePath") || return $?
  printf "%s/%s.md\n" "${releasePath%/}" "$version"
}
versionNextMinor() {
  local handler="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || throwArgument "$handler" "lastVersion required" || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local last prefix
      last="${1##*.}"
      catchArgument "$handler" isInteger "$last" || return $?
      prefix="${1%.*}"
      prefix="${prefix#v*}"
      if [ "$prefix" != "${1-}" ]; then
        prefix="$prefix."
      else
        prefix=
      fi
      last=$((last + 1))
      printf "%s%s" "$prefix" "$last"
      ;;
    esac
    shift
  done
}
_versionNextMinor() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
releaseNew() {
  local handler="_${FUNCNAME[0]}"
  local isInteractive=true newVersion="" application=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --non-interactive)
      isInteractive=false
      decorate warning "Non-interactive mode set"
      ;;
    --application) shift && application=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    *)
      if
        [ -n "$newVersion" ]
      then
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      newVersion="${argument#v}"
      isVersion "$newVersion" || throwArgument "$handler" "$argument is not a version" || return $?
      newVersion="v$newVersion"
      ;;
    esac
    shift
  done
  [ -n "$application" ] || application=$(catchReturn "$handler" buildHome) || return $?
  buildEnvironmentContext "$application" __releaseNew "$handler" "$isInteractive" "$newVersion"
}
__releaseNew() {
  local handler="$1" isInteractive="$2" newVersion="$3"
  local newVersion readLoop=false currentVersion liveVersion nextVersion notes isInteractive
  local versionOrdering
  local width=40
  if [ -z "$newVersion" ]; then
    readLoop=true
  fi
  hasHook version-current || throwEnvironment "$handler" "Requires hook version-current" || return $?
  currentVersion=$(catchEnvironment "$handler" hookRun version-current) || return $?
  [ -n "$currentVersion" ] || throwEnvironment "$handler" "version-current hook returned empty string" || return $?
  if hasHook version-live; then
    liveVersion=$(catchEnvironment "$handler" hookRun version-live) || return $?
    [ -n "$currentVersion" ] || throwEnvironment "$handler" "version-live hook returned empty string" || return $?
    decorate pair $width "Live:" "$liveVersion"
  else
    liveVersion=$currentVersion
  fi
  notes="$(catchEnvironment "$handler" releaseNotes "$currentVersion")" || return $?
  nextVersion=$(versionNextMinor "$liveVersion")
  decorate pair $width "Current:" "$currentVersion"
  if [ -n "$newVersion" ] && [ "$currentVersion" != "$newVersion" ]; then
    decorate pair "$width" "New:" "$(decorate BOLD green "$newVersion")"
    local checkVersion="$liveVersion"
    [ -n "$checkVersion" ] || checkVersion="$lastVersion"
    lastVersion="$(printf "%s\n" "$liveVersion" "$newVersion" | versionSort | tail -n 1)" || return $?
    if [ "$newVersion" != "$lastVersion" ]; then
      throwArgument "$handler" "$(decorate error "$newVersion") is before live $(decorate code "$liveVersion")" || return $?
    fi
    ! $isInteractive || confirmYesNo --yes "Change version to $(decorate code "$newVersion")? " || return $?
    if [ -f "$notes" ]; then
      local newNotes
      newNotes=$(catchEnvironment "$handler" releaseNotes "$newVersion") || return $?
      if [ -f "$newNotes" ]; then
        throwEnvironment "$handler" "$(decorate file "$notes") and $(decorate file "$newNotes") both exist - can not re-version" || return $?
      fi
      catchEnvironment "$handler" sed "s/$(quoteSedPattern "$currentVersion")/$(quoteSedReplacement "$newVersion")/g" <"$notes" >"$notes.fixed" || returnClean $? "$notes.fixed" || return $?
      catchEnvironment "$handler" git mv "$notes" "$newNotes" || returnClean $? "$notes.fixed" || return $?
      catchEnvironment "$handler" mv -f "$notes.fixed" "$newNotes" || returnClean $? "$notes.fixed" || return $?
    fi
    currentVersion="$newVersion"
    notes="$(catchEnvironment "$handler" releaseNotes "$currentVersion")" || return $?
    nextVersion=$(versionNextMinor "$liveVersion")
    if $isInteractive; then
      catchEnvironment "$handler" hookRun version-created "$currentVersion" "$notes" || return $?
    fi
  fi
  versionOrdering="$(printf "%s\n%s" "$liveVersion" "$currentVersion")"
  if [ "$currentVersion" != "$liveVersion" ] && [ "$(printf %s "$versionOrdering" | versionSort)" = "$versionOrdering" ] || [ "$currentVersion" == "v$nextVersion" ]; then
    decorate pair $width "Ready to deploy:" "$currentVersion"
    decorate pair $width "Release notes:" "$notes"
    if $isInteractive; then
      catchEnvironment "$handler" hookRun version-already "$currentVersion" "$notes" || return $?
    fi
    return 0
  fi
  if ! $isInteractive; then
    if [ -z "$newVersion" ]; then
      newVersion=$nextVersion
    elif ! isVersion "$newVersion"; then
      throwArgument "$handler" "New version $newVersion is not a valid version tag" || return $?
    fi
  else
    while true; do
      if $readLoop; then
        local message
        message="$(printf "%s? (%s %s) " "$(decorate info "New version")" "$(decorate BOLD magenta "default")" "$(decorate code "$nextVersion")")"
        printf "%s" "$message"
        read -r newVersion || :
        if [ -z "$newVersion" ]; then
          newVersion=$nextVersion
        fi
      fi
      if isVersion "$newVersion"; then
        newVersion="v$newVersion"
        break
      else
        if ! $readLoop; then
          throwArgument "$handler" "Invalid version $newVersion" || return $?
        fi
        decorate error "Invalid version $newVersion"
      fi
    done
  fi
  notes="$(catchEnvironment "$handler" releaseNotes "$newVersion")" || return $?
  if [ ! -f "$notes" ]; then
    catchEnvironment "$handler" hookRunOptional version-notes "$newVersion" "$currentVersion" >"$notes" || returnClean $? "$notes" || return $?
    if fileIsEmpty "$notes"; then
      __releaseNewNotes "$newVersion" "$currentVersion" >"$notes"
    fi
    decorate success "Version $newVersion ready - release notes: $notes"
    if $isInteractive; then
      catchEnvironment "$handler" hookRun version-created "$newVersion" "$notes" || return $?
    fi
  else
    decorate warning "Version $newVersion already - release notes: $notes"
    if $isInteractive; then
      catchEnvironment "$handler" hookRun version-already "$newVersion" "$notes" || return $?
    fi
  fi
  git add "$notes"
}
_releaseNew() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__releaseNewNotes() {
  local newVersion=$1 currentVersion=$2
  cat <<EOF
# Release $newVersion

- Upgrade from $currentVersion
- New snazzy features here
EOF
}
__networkConfigurationFiltered() {
  local patternNotGNU patternGNU handler="$1" && shift
  patternNotGNU=$(validate "$handler" String "patternNotGNU" "${1-}") && shift || return $?
  patternGNU=$(validate "$handler" String "patternGNU" "${1-}") && shift || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --install)
      catchReturn "$handler" packageWhich ifconfig net-tools || return $?
      ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  executableExists ifconfig || throwEnvironment "$handler" "Need ifconfig (net-tools) installed. not available in PATH: $PATH" || return $?
  case "$(lowercase "${OSTYPE-}")" in
  linux) ifconfig | grep "$patternNotGNU" | cut -f 2 -d : | trimSpace | cut -f 1 -d ' ' ;;
  linux-gnu | darwin* | freebsd*) ifconfig | grep "$patternGNU " | trimSpace | cut -f 2 -d ' ' ;;
  *) throwEnvironment "$handler" "networkIPList Unsupported OSTYPE \"${OSTYPE-}\"" || return $? ;;
  esac
}
networkIPList() {
  local handler="_${FUNCNAME[0]}"
  __networkConfigurationFiltered "$handler" 'inet addr:' 'inet' "$@" || return $?
}
_networkIPList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
networkMACAddressList() {
  local handler="_${FUNCNAME[0]}"
  __networkConfigurationFiltered "$handler" 'ether:' 'ether' "$@" || return $?
}
_networkMACAddressList() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
urlMatchesLocalFileSize() {
  local handler="_${FUNCNAME[0]}"
  local url="" file=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$url" ]
    then
      url=$(validate "$handler" String "url" "$1") || return $?
    elif [ -z "$file" ]; then
      file="$(validate "$handler" File "file" "$1")" || return $?
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  local remoteSize localSize
  localSize=$(catchReturn "$handler" fileSize "$file") || return $?
  remoteSize=$(catchReturn "$handler" urlContentLength "$url") || return $?
  localSize=$((localSize + 0))
  isPositiveInteger "$remoteSize" || throwEnvironment "$handler" "Remote size is not integer: $(decorate value "$remoteSize")" || return $?
  [ "$localSize" -eq "$remoteSize" ]
}
_urlMatchesLocalFileSize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
urlContentLength() {
  local handler="_${FUNCNAME[0]}"
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    *)
      local tempFile url remoteSize
      tempFile=$(fileTemporaryName "$handler") || return $?
      url=$(validate "$handler" URL "url" "$1") || return $?
      catchEnvironment "$handler" curl -s -I "$url" >"$tempFile" || returnClean $? "$tempFile" || return $?
      remoteSize=$(grep -i 'Content-Length' "$tempFile" | awk '{ print $2 }') || throwEnvironment "$handler" "Remote URL did not return Content-Length" || returnClean $? "$tempFile" || return $?
      catchReturn "$handler" rm -f "$tempFile" || return $?
      remoteSize="$(trimSpace "$remoteSize")"
      isUnsignedInteger "$remoteSize" || throwEnvironment "$handler" "Remote content length was non-integer: $remoteSize" || return $?
      printf "%d\n" $((remoteSize + 0))
      ;;
    esac
    shift
  done
}
_urlContentLength() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
hostTTFB() {
  __help "_${FUNCNAME[0]}" "$@" || return 0
  curl -L -s -o /dev/null -w "connect=%{time_connect}\n""ttfb: %{time_starttransfer}\n""total: %{time_total} \n" "$@"
}
_hostTTFB() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_watchFile() {
  decorate info "Watching $1"
  local line
  while IFS='' read -r line; do
    if [ "$line" != "${line#--}" ]; then
      line=$(trimSpace "${line##.*--}")
      statusMessage --last decorate green "$line"
    fi
  done
}
websiteScrape() {
  local handler="_${FUNCNAME[0]}"
  local url=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      url=$(validate "$handler" URL "url" "$1") || return $?
      break
      ;;
    esac
    shift
  done
  [ -z "$url" ] || throwArgument "$handler" "Need URL" || return $?
  local logFile progressFile
  logFile=$(catchReturn "$handler" buildQuietLog "$handler.$$.log") || return $?
  progressFile=$(catchReturn "$handler" buildQuietLog "$handler.$$.progress.log") || return $?
  catchReturn "$handler" packageWhich wget wget || return $?
  local aa=()
  aa+=(-e robots=off)
  aa+=(-R "zip,exe")
  aa+=(--no-check-certificate)
  aa+=(--user-agent="Mozilla/4.0 (compatible; MSIE 10.0; Windows NT 5.1)")
  aa+=(-r --level=5 -t 10 --random-wait --force-directories --html-extension)
  aa+=(--no-parent --convert-links --backup-converted --page-requisites)
  local pid
  pid=$(
    wget "${aa[@]}" "$url" 2>&1 | tee "$logFile" | grep -E '^--' >"$progressFile" &
    printf "%d" $!
  ) || returnClean $? "$logFile" || return $?
  statusMessage decorate success "Launched scraping process $(decorate code "$pid") ($progressFile)"
  _watchFile "$progressFile"
}
_websiteScrape() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__coverageLoader() {
  __buildFunctionLoader __bashCoverageReport coverage "$@"
}
bashCoverage() {
  local handler="_${FUNCNAME[0]}"
  local target="" verbose=false
  local start && start=$(timingStart) || return $?
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose) verbose=true ;;
    --target) shift && target="$(validate "$handler" FileDirectory "$argument" "${1-}")" || return $? ;;
    *) break ;;
    esac
    shift
  done
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  [ -n "$target" ] || target="$home/coverage.stats"
  ! $verbose || decorate info "Collecting coverage to $(decorate code "${target#"$home"}")"
  catchReturn "$handler" __bashCoverageWrapper "$target" "$@" || return $?
  ! $verbose || timingReport "$start" "Coverage completed in"
}
_bashCoverage() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
bashCoverageReport() {
  __coverageLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashCoverageReport() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__bashCoverageMarker() {
  export BUILD_HOME
  local source=${BASH_SOURCE[1]} home="${BUILD_HOME%/}/" command="${BASH_COMMAND//$'\n'/\n}"
  source="${source#"$home"}"
  printf -- "%s:%s %s %s\n" "$source" "${BASH_LINENO[1]}" "${FUNCNAME[1]}" "$command" >>"$1"
}
___bashCoverageMarker() {
  __bashCoverageEnd
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__bashCoverageWrapper() {
  local e=0 target="$1" && shift
  __bashCoverageStart "$target"
  "$@" || e=$?
  __bashCoverageEnd
  return $e
}
__bashCoverageStart() {
  shopt -s extdebug
  set -o functrace
  trap "__bashCoverageMarker \"$1\"" DEBUG
}
__bashCoverageEnd() {
  trap - DEBUG
  set +o functrace
  shopt -u extdebug
}
isiTerm2() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  export LC_TERMINAL TERM
  [ "${LC_TERMINAL-}" = "iTerm2" ] && [ "${TERM-}" != "screen" ]
}
_isiTerm2() {
  true || isiTerm2 --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_iTerm2_osc() {
  printf "\033]%s\007" "$1"
}
_iTerm2_setValue() {
  _iTerm2_osc "$(printf "1337;%s=%s" "$@")"
}
_iTerm2_setBase64Value() {
  local name="${1-}"
  [ -n "$name" ] || returnArgument "${FUNCNAME[0]} name is blank" || return $?
  shift && _iTerm2_setValue "$name" "$(printf "%s\n" "$@" | base64 | tr -d '\n')"
}
__iTerm2HideOutput() {
  _iTerm2_osc "133;C;"
}
__iTerm2SetUserVariable() {
  local name="${1-}" value="${2-}"
  name=$(validate "$handler" EnvironmentVariable "name" "$name") || return $?
  _iTerm2_setValue "SetUserVar" "$(printf "%s" "$value" | base64 | tr -d '\n')"
}
__iTerm2_version() {
  _iTerm2_osc "1337;ShellIntegrationVersion=8;shell=bash"
}
__iTerm2_prefix() {
  _iTerm2_osc '133;D;$?'
}
__iTerm2_mark() {
  _iTerm2_osc '133;A;$?'
}
__iTerm2_suffix() {
  _iTerm2_osc "133;B"
}
__iTerm2UpdateState() {
  local host=""
  export USER PWD __ITERM2_HOST __ITERM2_HOST_TIME
  __iTerm2HideOutput
  host=${__ITERM2_HOST-}
  if [ -n "$host" ] || [ "$(date +%s)" -gt $((${__ITERM2_HOST_TIME-0} + 60)) ]; then
    __ITERM2_HOST=$(hostname)
    __ITERM2_HOST_TIME=$(date +%s)
  fi
  _iTerm2_setValue "RemoteHost" "$USER@$__ITERM2_HOST"
  _iTerm2_setValue "CurrentDir" "$PWD"
  __iTerm2_prefix
}
iTerm2PromptSupport() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  catchEnvironment "$handler" muzzle bashPromptMarkers "$(__iTerm2_mark)" "$(__iTerm2_suffix)" || return $?
  catchEnvironment "$handler" bashPrompt --skip-prompt --last __iTerm2UpdateState || return $?
}
_iTerm2PromptSupport() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2Aliases() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local home skipped=()
  home=$(catchReturn "$handler" userHome) || return $?
  [ -d "$home/.iterm2" ] || throwEnvironment "$handler" "Missing ~/.iterm2" || return $?
  for item in imgcat imgls it2attention it2check it2copy it2dl it2ul it2getvar it2setcolor it2setkeylabel it2universion; do
    local target="$home/.iterm2/$item"
    if [ -x "$target" ]; then
      alias "$item"="$target"
    else
      skipped+=("$item")
    fi
  done
  [ ${#skipped[@]} -eq 0 ] || decorate subtle "Skipped $(decorate each code "${skipped[@]}")" 1>&2
}
_iTerm2Aliases() {
  true || iTerm2Aliases --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2ColorNames() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  printf "%s\n" black red green yellow blue magenta cyan white
}
_iTerm2ColorNames() {
  true || iTerm2ColorNames --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2IsColorName() {
  local handler="_${FUNCNAME[0]}"
  case "${1-}" in
  --help) "$handler" 0 && return $? || return $? ;;
  black | red | green | yellow | blue | magenta | cyan | white) return 0 ;; *) return 1 ;;
  esac
}
_iTerm2IsColorName() {
  true || iTerm2ColorNames --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2IsColorType() {
  local handler="_${FUNCNAME[0]}"
  case "${1-}" in
  --help) "$handler" 0 && return $? || return $? ;;
  fg | bg | selbg | selfg | curbg | curfg) return 0 ;;
  bold | link | underline) return 0 ;;
  tab) return 0 ;;
  black | red | green | yellow | blue | magenta | cyan | white) return 0 ;;
  br_black | br_red | br_green | br_yellow | br_blue | br_magenta | br_cyan | br_white) return 0 ;;
  *) return 1 ;;
  esac
}
_iTerm2IsColorType() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2ColorTypes() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local colors
  printf "%s\n" fg bg selbg selfg curbg curfg
  printf "%s\n" bold link underline
  printf "%s\n" tab
  read -r -d "" -a colors < <(iTerm2ColorNames)
  printf -- "%s\n" "${colors[@]}"
  printf -- "%s\n" "${colors[@]}" | decorate wrap "br_" ""
}
_iTerm2ColorTypes() {
  true || iTerm2ColorTypes --help
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2Image() {
  local handler="_${FUNCNAME[0]}"
  local ignoreErrors=false images=() width="" height="" aspectRatio=true
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --width)
      shift
      width=$(validate "$handler" PositiveInteger "$argument" "${1-}") || return $?
      ;;
    --height)
      shift
      height=$(validate "$handler" PositiveInteger "$argument" "${1-}") || return $?
      ;;
    --scale)
      aspectRatio=false
      ;;
    --preserve-aspect-ratio)
      aspectRatio=true
      ;;
    --ignore | -i) ignoreErrors=true ;;
    -*)
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *) images+=("$(validate "$handler" File "imageFile" "$1")" "$(__iTerm2ImageExtras "$width" "$height" "$aspectRatio")") || return $? ;;
    esac
    shift
  done
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    throwEnvironment "$handler" "Not iTerm2" || return $?
  fi
  if [ "${#images[@]}" -gt 0 ]; then
    set -- "${images[@]}"
    while [ $# -gt 1 ]; do
      catchReturn "$handler" __iTerm2Image "$1" "$1" "$2" || return $?
      shift 2
    done
  else
    local image
    image=$(fileTemporaryName "$handler") || return $?
    catchEnvironment "$handler" cat >"$image" || return $?
    catchReturn "$handler" __iTerm2Image "$image" "$(__iTerm2ImageExtras "$width" "$height" "$aspectRatio")" || return $?
    catchEnvironment "$handler" rm -rf "$image" || return $?
  fi
}
_iTerm2Image() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__iTerm2ImageExtras() {
  local extras=() width="${1-}" height="${2-}" aspectRatio="${3-}"
  [ -z "$width" ] || extras+=("width=$width")
  [ -z "$height" ] || extras+=("height=$height")
  [ 0 -eq "${#extras[@]}" ] || extras+=("preserveAspectRatio=$aspectRatio")
  listJoin ";" "${extras[@]+"${extras[@]}"}"
}
__iTerm2Download() {
  local binary="$1" name="${2-}" suffix="${3-}" fileValue=""
  [ -z "$suffix" ] || suffix=";${suffix#;}"
  [ -z "$name" ] || fileValue="${fileValue}name=$(printf -- "%s" "$name" | base64);"
  fileValue="${fileValue}size=$(fileSize "$binary")}$suffix:$(base64 <"$binary")"
  statusMessage --last _iTerm2_setValue File "$fileValue"
}
__iTerm2Image() {
  local suffix="${3-}"
  [ -z "$suffix" ] || suffix=";${suffix#;}"
  __iTerm2Download "${1-}" "${2-}" ";inline=1$suffix"
}
iTerm2Download() {
  local handler="_${FUNCNAME[0]}"
  local ignoreErrors=true files=() name=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --name)
      shift
      name="$(validate "$handler" String "$argument" "${1-}")" || return $?
      ;;
    --ignore | -i) ignoreErrors=true ;;
    -*)
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *) files+=("$(validate "$handler" File "imageFile" "$1")") || return $? ;;
    esac
    shift
  done
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    throwEnvironment "$handler" "Not iTerm2" || return $?
  fi
  if [ "${#files[@]}" -gt 0 ]; then
    set -- "${files[@]}"
    while [ $# -gt 0 ]; do
      catchReturn "$handler" __iTerm2Download "$1" "$1" || return $?
      shift
    done
  else
    local file
    file=$(fileTemporaryName "$handler") || return $?
    catchEnvironment "$handler" cat >"$file" || return $?
    catchReturn "$handler" __iTerm2Download "$file" "$name" || return $?
    catchEnvironment "$handler" rm -rf "$file" || return $?
  fi
}
_iTerm2Download() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2SetColors() {
  local handler="_${FUNCNAME[0]}"
  local verboseFlag=false skipColorErrors=false ignoreErrors=false fillMissing=false
  local colorSettings=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --skip-errors)
      skipColorErrors=true
      ;;
    --fill)
      fillMissing=true
      ;;
    --verbose | -v)
      verboseFlag=true
      ;;
    --ignore | -i) ignoreErrors=true ;;
    -*)
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    *) colorSettings+=("$(validate "$handler" String "colorSetting" "$1")") || return $? ;;
    esac
    shift
  done
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    throwEnvironment "$handler" "Not iTerm2" || return $?
  fi
  local colorSetting
  if [ 0 -eq "${#colorSettings[@]}" ]; then
    ! $verboseFlag || statusMessage decorate info "Reading colors from stdin"
    while read -r colorSetting; do
      colorSetting=$(trimSpace "$colorSetting")
      [ -n "$colorSetting" ] || continue
      [ "$colorSetting" = "${colorSetting#\#}" ] || continue
      colorSettings+=("$colorSetting")
    done
  fi
  local didColors=() needColors=() exitCode=0
  for colorSetting in "${colorSettings[@]+"${colorSettings[@]}"}"; do
    local colorType="${colorSetting%%=*}" colorValue="${colorSetting#*=}"
    if ! iTerm2IsColorType "$colorType"; then
      $skipColorErrors || throwArgument "$handler" "Invalid color $(decorate value "$colorType")" || return $?
    else
      __iTerm2SetColors "$handler" "$verboseFlag" "$colorType" "$colorValue" || return $?
      if $fillMissing; then
        local nonBrightColorName="${colorType#br_}"
        if iTerm2IsColorName "$colorType"; then
          needColors+=("br_$colorType" "$colorValue")
        elif iTerm2IsColorName "$nonBrightColorName"; then
          needColors+=("$nonBrightColorName" "$colorValue")
        fi
        didColors+=("$colorType")
      fi
    fi
  done
  ! $verboseFlag || statusMessage decorate info "Need colors: $(decorate each --count --index code "${needColors[@]+"${needColors[@]}"}")"
  if ! "$fillMissing" || [ ${#needColors[@]} -eq 0 ]; then
    return $exitCode
  fi
  if executableExists bc; then
    ! $verboseFlag || statusMessage decorate info "Filling in missing colors: $(decorate each --count --index code "${needColors[@]}")"
    set -- "${needColors[@]}"
    while [ $# -gt 0 ]; do
      local colorName="$1" colorValue colorMod
      if inArray "$colorName" "${didColors[@]}"; then
        ! $verboseFlag || statusMessage decorate notice "No need to fill $(decorate value "$colorName")"
        shift 2
        continue
      fi
      if [ "${colorName#br_}" != "$colorName" ]; then
        colorMod=0.7
      else
        colorMod=1.3
      fi
      colorValue="$(colorParse <<<"$colorValue" | colorMultiply "$colorMod" | colorFormat)"
      __iTerm2SetColors "$handler" "$verboseFlag" "$colorName" "$colorValue" || exitCode=$?
      ! $verboseFlag || statusMessage decorate notice "Filled $(decorate code "$colorName") with $(decorate value "$colorMod") $(decorate blue "$2") -> $(decorate BOLD blue "$colorValue")"
      shift 2 || throwEnvironment "$handler" "${FUNCNAME[0]}:$LINENO" || return $?
    done
  else
    ! $verboseFlag || statusMessage decorate warning "bc binary required to fill in missing colors, skipping"
  fi
  return $exitCode
}
__iTerm2SetColors() {
  local handler="$1" verboseFlag="$2" colorType="$3" colorValue="$4"
  local colorSpace colorCode=""
  IFS=":" read -r colorSpace colorCode <<<"$colorValue" || :
  if [ -z "$colorCode" ]; then
    colorCode=$colorValue
    colorSpace=""
  else
    case "$colorSpace" in
    srgb | rgb | p3) ;; *) throwArgument "$handler" "Invalid color space $(decorate error "$colorSpace") in $(decorate code "$colorValue")" || return $? ;;
    esac
  fi
  colorCode=$(uppercase "$colorCode")
  case "$colorCode" in
  [[:xdigit:]]*) ;;
  *) throwArgument "$handler" "Invalid hexadecimal color: $(decorate error "$colorCode") in $(decorate code "$colorValue")" || return $? ;;
  esac
  ! $verboseFlag || statusMessage decorate info "Setting color $(decorate label "$colorType") to $(decorate value "$colorCode")"
  _iTerm2_setValue SetColors "$colorType=$colorCode"
}
_iTerm2SetColors() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2Attention() {
  local handler="_${FUNCNAME[0]}"
  local ignoreErrors=false verboseFlag=false didSomething=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose | -v)
      verboseFlag=true
      ;;
    --ignore | -i) ignoreErrors=true ;;
    *)
      if
        ! isiTerm2
      then
        ! $ignoreErrors || return 0
        throwEnvironment "$handler" "Not iTerm2" || return $?
      fi
      local result=0
      parseBoolean "$argument" || result=$?
      case "$result" in 0 | 1)
        ! $verboseFlag || statusMessage decorate info "Requesting attention: $result"
        _iTerm2_setValue RequestAttention "$((result - 1))"
        didSomething=true
        ;;
      *) case "$argument" in
        "start")
          _iTerm2_setValue RequestAttention 1
          didSomething=true
          ;;
        "stop")
          _iTerm2_setValue RequestAttention 1
          didSomething=true
          ;;
        "!" | "fireworks")
          ! $verboseFlag || statusMessage decorate info "Requesting fireworks"
          _iTerm2_setValue RequestAttention "fireworks"
          didSomething=true
          ;;
        *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
        esac ;;
      esac
      ;;
    esac
    shift
  done
  $didSomething || throwArgument "$handler" "Requires at least one argument" || return $?
}
_iTerm2Attention() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2Badge() {
  local handler="_${FUNCNAME[0]}"
  local message=() ignoreErrors=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --ignore | -i) ignoreErrors=true ;;
    *) message+=("$argument") ;;
    esac
    shift
  done
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    throwEnvironment "$handler" "Not iTerm2" || return $?
  fi
  _iTerm2_setBase64Value "SetBadgeFormat" "${message[@]+"${message[@]}"}"
}
_iTerm2Badge() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
_readBytes() {
  dd bs=1 count="$1" 2>/dev/null
}
__iTerm2Version() {
  local version="" byte=""
  _readBytes 2 >/dev/null || return $?
  while [ "$byte" != "n" ]; do
    version="$version$byte"
    byte="$(_readBytes 1)" || return $?
  done
  printf "%s\n" "$version"
}
iTerm2Version() {
  local handler="_${FUNCNAME[0]}"
  local ignoreErrors=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --ignore | -i) ignoreErrors=true ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    throwEnvironment "$handler" "Not iTerm2" || return $?
  fi
  local savedTTY undo=()
  savedTTY=$(catchEnvironment "$handler" stty -g) || return $?
  undo=(stty "$savedTTY")
  stty -echo -icanon raw || returnUndo $? "${undo[@]}" || return $?
  printf "\e[1337n""\e[5n"
  local version
  version=$(__iTerm2Version)
  case "$version" in
  "0" | "3")
    stty "$savedTTY" || :
    throwEnvironment "$handler" "iTerm2 did not respond to DSR 1337: $version" || return $?
    ;;
  *) muzzle __iTerm2Version || : ;;
  esac
  stty "$savedTTY" || :
  printf "%s\n" "$version"
}
_iTerm2Version() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2Notify() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local handler="_${FUNCNAME[0]}"
  local ignoreErrors=false messageText=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --ignore | -i) ignoreErrors=true ;;
    *)
      messageText="$*"
      break
      ;;
    esac
    shift
  done
  [ -n "$messageText" ] || throwArgument "handler" "Requires a notification message" || return $?
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    throwEnvironment "$handler" "Not iTerm2" || return $?
  fi
  printf "\e]9;%s\007" "$messageText"
}
_iTerm2Notify() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
iTerm2Init() {
  local handler="_${FUNCNAME[0]}"
  local ignoreErrors=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --ignore | -i) ignoreErrors=true ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  if ! isiTerm2; then
    ! $ignoreErrors || return 0
    throwEnvironment "$handler" "Not iTerm2" || return $?
  fi
  local home
  catchReturn "$handler" buildEnvironmentLoad TERM || return $?
  home=$(catchReturn "$handler" userHome) || return $?
  local ii=()
  ! $ignoreErrors || ii=(--ignore)
  catchEnvironment "$handler" iTerm2PromptSupport "${ii[@]+"${ii[@]}"}" || return $?
  export BUILD_HOOK_DIRS
  buildEnvironmentLoad BUILD_HOOK_DIRS || return $?
  BUILD_HOOK_DIRS=$(listAppend "${BUILD_HOOK_DIRS[@]}" ":" --first "bin/build/tools/iterm2/hooks")
  [ ! -d "$home/.iterm2" ] || catchEnvironment "$handler" iTerm2Aliases || return $?
}
_iTerm2Init() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
readlineConfigurationAdd() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local target=".input""rc" keyStroke="${1-}" action="${2-}" pattern
  local home
  home="$(catchReturn "$handler" buildEnvironmentGet HOME)" || return $?
  target="$home/$target"
  [ -f "$target" ] || catchEnvironment "$handler" touch "$target" || return $?
  pattern="^$(quoteGrepPattern "\"$keyStroke\":")"
  if grep -q -e "$pattern" <"$target"; then
    grep -v "$pattern" >"$target.new" <"$target"
    catchEnvironment "$handler" mv -f "$target.new" "$target" || returnClean $? "$target.new" || return $?
  fi
  catchEnvironment "$handler" printf "\"%s\": %s\n" "$keyStroke" "$action" >>"$target" || return $?
}
_readlineConfigurationAdd() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__applicationHomeFile() {
  local f home
  home=$(catchReturn "$handler" buildEnvironmentGetDirectory XDG_STATE_HOME) || return $?
  f="$home/.applicationHome"
  [ -f "$f" ] || catchEnvironment "$handler" touch "$f" || return $?
  printf "%s\n" "$f"
}
__applicationHomeGo() {
  local handler="$1" && shift
  local file home label uHome oldHome=""
  file=$(catchReturn "$handler" __applicationHomeFile) || return $?
  home=$(trimSpace "$(catchEnvironment "$handler" head -n 1 "$file")") || return $?
  if [ -z "$home" ]; then
    throwEnvironment "$handler" "No code home set, try $(decorate code "applicationHome")" || return $?
  fi
  [ -d "$home" ] || throwEnvironment "$handler" "Application home directory deleted $(decorate code "$home")" || return $?
  oldHome=$(catchReturn "$handler" buildHome) || return $?
  if [ -d "$oldHome" ] && [ "$oldHome" != "$home" ]; then
    hookSourceOptional --application "$oldHome" project-deactivate "$home" || :
  fi
  catchEnvironment "$handler" cd "$home" || return $?
  label="Working in"
  if [ $# -gt 0 ]; then
    label="${*-}"
    [ -n "$label" ] || return 0
  fi
  uHome="${HOME%/}"
  printf "%s %s\n" "$(decorate label "$label")" "$(decorate value "${home//"$uHome"/~}")"
  hookSourceOptional --application "$home" project-activate "$oldHome" || :
  return 0
}
applicationHome() {
  local handler="_${FUNCNAME[0]}"
  local here="" home="" buildTools="bin/build/tools.sh"
  export HOME
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --go)
      shift
      __applicationHomeGo "$handler" "$@"
      return 0
      ;;
    *)
      [ -z "$here" ] || throwArgument "$handler" "Unknown argument (applicationHome set already to $(decorate code "$here"))"
      here=$(validate "$handler" Directory "directory" "$argument") || return $?
      ;;
    esac
    shift
  done
  [ -n "$here" ] || here=$(catchEnvironment "$handler" pwd) || return $?
  home=$(bashLibraryHome "$buildTools" "$here" 2>/dev/null) || home="$here"
  printf "%s\n" "$home" >"$(__applicationHomeFile)"
  __applicationHomeGo "$handler" "${__saved[0]-} Application home set to" || return $?
}
_applicationHome() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
applicationHomeAliases() {
  local handler="_${FUNCNAME[0]}"
  local goAlias="" setAlias=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    *) if
      [ -z "$goAlias" ]
    then
      goAlias=$(validate "$handler" String "goAlias" "$argument") || return $?
    elif [ -z "$setAlias" ]; then
      setAlias=$(validate "$handler" String "setAlias" "$argument") || return $?
    else
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
    fi ;;
    esac
    shift
  done
  [ -n "$goAlias" ] || goAlias="g"
  [ -n "$setAlias" ] || setAlias="G"
  alias "$goAlias"='applicationHome --go' || throwEnvironment "$handler" "alias $goAlias failed" || return $?
  alias "$setAlias"=applicationHome || throwEnvironment "$handler" "alias $setAlias failed" || return $?
}
_applicationHomeAliases() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
buildApplicationConfigure() {
  local handler="_${FUNCNAME[0]}"
  local home="" name="" interactive=true code=""
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --non-interactive) interactive=false ;;
    --name) shift && name="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --code) shift && code="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --path) shift && home="$(validate "$handler" Directory "$argument" "${1-}")" || return $? ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  local templateHome && templateHome=$(catchReturn "$handler" buildHome) || return $?
  [ -n "$home" ] || home="$templateHome"
  [ -n "$name" ] || throwArgument "$handler" "Requires name" || return $?
  if [ -z "$code" ]; then
    catchReturn "$handler" decorate warning "Using default code $(decorate code "$code")" || return $?
    code="$(catchReturn "$handler" basename "$home")" || return $?
  fi
  __buildApplicationConfigurePaths "$handler" "$home" true || return $?
  __buildApplicationConfigureShellFiles "$handler" "$home" true "$templateHome" || return $?
  APPLICATION_CODE=$code APPLICATION_NAME=$name __buildApplicationConfigureEnvironmentFiles "$handler" "$home" true "$interactive" || return $?
  __buildApplicationConfigurePaths "$handler" "$home" false || return $?
  __buildApplicationConfigureShellFiles "$handler" "$home" false "$templateHome" || return $?
  APPLICATION_CODE=$code APPLICATION_NAME=$name __buildApplicationConfigureEnvironmentFiles "$handler" "$home" false "$interactive" || return $?
}
_buildApplicationConfigure() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__buildApplicationConfigurePaths() {
  local handler="$1" && shift
  local home="$1" && shift
  local preflight="$1" && shift
  local d && for d in bin/env bin/hooks bin/tools etc; do
    local target="$home/$d"
    if $preflight; then
      [ -d "$target" ] || decorate info "Will create $(decorate file "$target")" || return $?
    else
      directoryRequire --handler "$handler" "$home/$d" || return $?
    fi
  done
}
__buildApplicationConfigureEnvironmentFiles() {
  local handler="$1" && shift
  local home="$1" && shift
  local preflight="$1" && shift
  local interactive="$1" && shift
  local envs=(
    APPLICATION_NAME APPLICATION_CODE APPLICATION_CODE_EXTENSIONS APPLICATION_CODE_IGNORE APPLICATION_JSON APPLICATION_JSON_PREFIX BUILD_RELEASE_NOTES)
  local e && for e in "${envs[@]}"; do
    local target="$home/bin/env/$e.sh"
    local value="${!e-}"
    if $preflight; then
      [ -f "$target" ] || decorate info "Will create $(decorate file "$target") - current value \"$(decorate code "$value")\"" || return $?
      if [ -z "$value" ]; then
        local type
        local envFileSource && envFileSource="$(catchReturn "$handler" buildEnvironmentFiles --application "$home" "$e" | tail -n 1)" || return $?
        type=$(catchReturn "$handler" bashCommentVariable Type <"$envFileSource") || return $?
        if [ -z "$type" ]; then
          decorate warning "Unable to retrieve type from file $(decorate file "$envFileSource")"
          type="String"
        fi
        if $interactive; then
          local finished=false && while ! $finished; do
            local newEnvValue && newEnvValue=$(bashUserInput -p "$(decorate notice "Value for") $(decorate code "$e")? (type $(decorate value "$type")) ")
            if newEnvValue=$(validate "$type" "$e" "$newEnvValue"); then
              finished=true
              declare -x "$e"="$newEnvValue"
            else
              decorate warning "$newEnvValue is not a valid $(decorate code "$type")"
            fi
          done
        fi
      fi
    else
      catchReturn "$handler" buildEnvironmentAdd --application "$home" "$e" --value "$value" || return $?
    fi
  done
}
__buildApplicationConfigureShellFiles() {
  local handler="$1" && shift
  local home="$1" && shift
  local preflight="$1" && shift
  local templateHome="$1" && shift
  local files=(
    bin/tools.sh
    bin/developer.sh
    bin/tools/__developer.sh
    bin/install-bin-build.sh)
  local file target
  if $preflight; then
    for file in "${files[@]}"; do
      target="$home/$file"
      [ -f "$target" ] || decorate info "Will create $(decorate file "$target")" || return $?
    done
  else
    file=${files[0]}
    target="$home/$file"
    catchEnvironment "$handler" cp -f "$templateHome/bin/build/identical/application.sh" "$target" || return $?
    file=${files[1]}
    target="$home/$file"
    if [ ! -e "$target" ]; then
      catchReturn "$handler" mapEnvironment <"$templateHome/bin/build/developer.sample.sh" >"$target" || return $?
    fi
    file=${files[2]}
    target="$home/$file"
    if [ ! -e "$target" ]; then
      catchEnvironment "$handler" cp -f "$templateHome/bin/build/identical/__developer.sh" "$target" || return $?
    fi
    catchReturn "$handler" installInstallBuild "$home/bin" "$home" || return $?
  fi
}
fingerprint() {
  local handler="_${FUNCNAME[0]}"
  local key="" verboseFlag=false checkFlag=false prefix=""
  ! buildDebugEnabled fingerprint || verboseFlag=true
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --check) checkFlag=true ;;
    --verbose) verboseFlag=true ;;
    --quiet) verboseFlag=false ;;
    --key) shift && key=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --prefix) shift && prefix=$(validate "$handler" EmptyString "$argument" "${1-}") || return $? ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  [ -n "$prefix" ] || prefix=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_JSON_PREFIX) || return $?
  [ -n "$key" ] || key="fingerprint"
  local jqPath
  jqPath=$(catchReturn "$handler" jsonPath "$prefix" "$key") || return $?
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  jsonFile="$home/$(catchReturn "$handler" buildEnvironmentGet APPLICATION_JSON)" || return $?
  [ -f "$jsonFile" ] || throwEnvironment "$handler" "Missing $(decorate file "$jsonFile")" || return $?
  local savedFingerprint fingerprint
  savedFingerprint="$(catchReturn "$handler" jsonFileGet "$jsonFile" "$jqPath")" || return $?
  fingerprint=$(catchReturn "$handler" hookRun application-fingerprint) || return $?
  if [ "$fingerprint" = "$savedFingerprint" ]; then
    if $checkFlag; then
      printf -- "%s\n" "$fingerprint"
    else
      ! $verboseFlag || decorate subtle "Fingerprint is unchanged."
    fi
    return 0
  else
    if $checkFlag; then
      printf -- "%s\n" "$fingerprint"
      return 1
    fi
    catchEnvironment "$handler" jsonFileSet "$jsonFile" "$jqPath" "$fingerprint" || return $?
    ! $verboseFlag || decorate subtle "Fingerprint updated to $(decorate code "$fingerprint") [$savedFingerprint]. (path: $(decorate value "$jqPath"))"
  fi
}
_fingerprint() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
watchDirectory() {
  local handler="_${FUNCNAME[0]}"
  local rootDir="" lastTimestamp="" lastFile="" secondsToRun="" stateFile="" verboseFlag=false
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --verbose) verboseFlag=true ;;
    --file) shift && lastFile=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --modified) shift && lastTimestamp=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $? ;;
    --timeout) shift && secondsToRun=$(validate "$handler" UnsignedInteger "$argument" "${1-}") || return $? ;;
    --state) shift && stateFile=$(validate "$handler" File "$argument" "${1-}") || return $? ;;
    *)
      rootDir=$(validate "$handler" Directory "directory" "$1") || return $?
      shift
      break
      ;;
    esac
    shift
  done
  [ -n "$rootDir" ] || throwArgument "$handler" "Missing directory" || return $?
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
    catchEnvironment "$handler" fileModificationTimes "$rootDir" "$@" | sort -rn >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
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
    catchEnvironment "$handler" sleep "$elapsed" || returnClean $? "${clean[@]}" || return $?
  done
  ! $verboseFlag || statusMessage --last timingReport "$init" "Watch stopped after"
  returnClean 0 "${clean[@]}"
}
_watchDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
documentationMkdocs() {
  local handler="_${FUNCNAME[0]}"
  local rootPath="" template="" packages=("mkdocs") pv=()
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    --help) "$handler" 0 && return $? || return $? ;;
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --template) shift && template=$(validate "$handler" File "$argument" "${1-}") || return $? ;;
    --package) shift && packages+=("$(validate "$handler" String "$argument" "${1-}")") || return $? ;;
    --path) shift && rootPath="$(validate "$handler" Directory "$argument" "${1-}")" || return $? ;;
    --clean) pv+=("--clean") ;;
    *) throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $? ;;
    esac
    shift
  done
  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  [ -n "$rootPath" ] || rootPath="$home"
  catchEnvironment "$handler" pythonVirtual "${pv[@]+"${pv[@]}"}" --application "$rootPath" "${packages[@]}" || return $?
  catchEnvironment "$handler" muzzle pushd "$rootPath" || return $?
  statusMessage --last decorate notice "Updating mkdocs.yml ..."
  __mkdocsConfiguration "$handler" "$template" || returnUndo $? muzzle popd || return $?
  local tempLog
  tempLog=$(fileTemporaryName "$handler") || returnUndo $? muzzle popd || return $?
  statusMessage --last decorate notice "Building with mkdocs ..."
  catchEnvironmentQuiet "$handler" "$tempLog" python -m mkdocs build || returnUndo $? dumpPipe "mkdocs log" <"$tempLog" || returnUndo $? muzzle popd || returnClean $? "$tempLog" || return $?
  catchEnvironment "$handler" rm -f "$tempLog" || returnUndo $? muzzle popd || return $?
  catchEnvironment "$handler" muzzle popd || return $?
}
_documentationMkdocs() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__mkdocsConfiguration() {
  local handler="${1-}" && shift
  local source="${1-}" && shift
  [ -n "$source" ] || source="mkdocs.template.yml"
  local target="mkdocs.yml"
  [ -f "$source" ] || throwEnvironment "$handler" "missing $source" || return $?
  (
    local token
    while IFS="" read -r token; do
      [ "$token" != "$(lowercase "$token")" ] || continue
      catchReturn "$handler" buildEnvironmentLoad "$token" || return $?
      export "${token?}"
    done < <(mapTokens <"$source")
    catchReturn "$handler" mapEnvironment <"$source" >"$target" || return $?
  ) || return $?
}
export BUILD_HOME
BUILD_HOME="${BUILD_HOME-}"
if [ -z "$BUILD_HOME" ]; then
  BUILD_HOME="$(printf -- "%s\n" "$(cd "${BASH_SOURCE[0]%/*}/../.." && pwd || printf -- "%s\n" "Unable to determine BUILD_HOME: $(pwd)")")"
  if [ ! -d "$BUILD_HOME" ]; then
    printf "%s\n" "Unable to determine BUILD_HOME - system is unstable: $BUILD_HOME" 1>&2
  fi
fi
__toolsMain "$@"
