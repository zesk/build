#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# ordering.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Main ordering function
__testSuiteOrdering() {
  local handler="$1" && shift
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#

  local cacheDirectory=""

  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --cache) shift && cacheDirectory="$(validate "$handler" Directory "$argument" "${1-}")" || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local clean=()
  if [ "$cacheDirectory" = "" ]; then
    cacheDirectory="$(fileTemporaryName "$handler" -d)" || return $?
    clean+=("$cacheDirectory")
  fi

  local deferDirectory && deferDirectory=$(catchReturn "$handler" directoryRequire "$cacheDirectory/defer.$$") || returnClean $? "${clean[@]}" || return $?
  local tempInput="$cacheDirectory/${FUNCNAME[0]}.$$.input"
  local remainFile="$cacheDirectory/${FUNCNAME[0]}.$$.remain"

  clean+=("$deferDirectory" "$tempInput" "$remainFile")
  catchReturn "$handler" tee "$tempInput" | catchReturn "$handler" grepSafe -v 'before=' >"$remainFile" || returnClean $? "${clean[@]}" || return $?
  local testLine && while read -r testLine; do
    local returnCode=0 && functionName=$(___testSuiteOrderingDefer "$handler" "$deferDirectory" "$testLine") || returnCode=$?
    case "$returnCode" in 3) continue ;; 0) ;; *) returnClean "$returnCode" "${clean[@]}" || return $? ;; esac
    catchEnvironment "$handler" printf "%s\n" "$testLine" || returnClean $? "${clean[@]}" || return $?
    if [ -f "$deferDirectory/$functionName" ]; then
      ___testSuiteOrderingAfterProcessing "$handler" "$deferDirectory" "$functionName" <"$deferDirectory/$functionName" || return $?
      catchEnvironment "$handler" rm -f "$deferDirectory/$functionName" || returnClean $? "${clean[@]}" || return $?
    fi
  done < <(
    grepSafe 'before=' "$tempInput" &&
      grepSafe -v 'after=' "$remainFile" &&
      grepSafe 'after=' "$remainFile" | grepSafe 'before=' &&
      grepSafe 'after=' "$remainFile" | grepSafe -v 'before='
  )
  catchEnvironment "$handler" find "$deferDirectory" -type f -exec cat {} \; || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
}

___testSuiteOrderingAfterProcessing() {
  local handler="$1" && shift
  local deferDirectory="$1" && shift
  local functionName="$1" && shift

  local afterFunctionNames=()
  local testLine && while read -r testLine; do
    local returnCode=0 && afterFunctionName=$(___testSuiteOrderingDefer "$handler" "$deferDirectory" "$testLine" " after=$functionName") || returnCode=$?
    case "$returnCode" in 3) continue ;; 0) ;; *) returnClean "$returnCode" "${clean[@]}" || return $? ;; esac
    [ "${#afterFunctionNames[@]}" -eq 0 ] || ! inArray "$afterFunctionName" "${afterFunctionNames[@]}" || continue
    afterFunctionNames+=("$afterFunctionName")
    catchEnvironment "$handler" printf "%s\n" "$testLine" || returnClean $? "${clean[@]}" || return $?
  done
}

# Utility function for __testSuiteOrdering
# For each `after= ` write a defer file for the function to be after (each one)
# When we hit that function, remove the token and write it for the other one
# Eventually will be run after the 2nd one regardless of ordering
___testSuiteOrderingDefer() {
  local handler="$1" && shift
  local deferDirectory="$1" && shift
  local testLine="$1" && shift
  local removePattern="${1-}"

  local testItems=() && IFS=" " read -d $'\n' -r -a testItems <<<"$testLine"
  functionName="${testItems[0]}"
  local defer=() item && for item in "${testItems[@]}"; do
    case "$item" in after=*) defer+=("${item#*=}") && break ;; esac
  done
  if [ "${#defer[@]}" -gt 0 ]; then
    if [ -n "$removePattern" ]; then
      testLine="$(replaceFirstPattern "$removePattern" "" <<<"$testLine")"
    fi
    local item && for item in "${defer[@]}"; do
      catchEnvironment "$handler" printf "%s\n" "$testLine" >>"$deferDirectory/$item" || returnClean $? "${clean[@]}" || return $?
    done
    printf "%s\n" "$functionName"
    return 3
  fi
  printf "%s\n" "$functionName"
  return 0
}
