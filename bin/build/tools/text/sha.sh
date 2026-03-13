#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
#  ▐        ▐     ▞▀▖▌ ▌▞▀▖
#  ▜▀ ▞▀▖▚▗▘▜▀ ▐▌ ▚▄ ▙▄▌▙▄▌
#  ▐ ▖▛▀ ▗▚ ▐ ▖▗▖ ▖ ▌▌ ▌▌ ▌
#   ▀ ▝▀▘▘ ▘ ▀ ▝▘ ▝▀ ▘ ▘▘ ▘

__textSHA() {
  local handler="$1" && shift
  local debugFlag=false files=() cachePath=""

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
    --debug) debugFlag=true ;;
    --cached) cachedFlag=true ;;
    --cache) shift && cachePath="$(validate "$handler" Directory "$argument" "${1-}")" && cachedFlag=true || return $? ;;
    *)
      files+=("$(validate "$handler" File "fileToChecksum" "$argument")") || return $?
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  executableExists sha1sum || throwEnvironment "$handler" "Need packageGroupInstall sha1sum" || return $?

  local debugLog=""
  if $debugFlag || buildDebugEnabled textSHA; then
    debugLog="$(catchReturn "$handler" buildCacheDirectory)/textSHA.log" || return $?
  fi

  if [ "${#files[@]}" -eq 0 ]; then
    [ -z "$debugLog" ] || printf "%s: stdin\n" "$(date +"%FT%T")" >>textSHA.log
    ___textSHA "$handler" || throwEnvironment "$handler" "sha1sum" || return $?
  elif "$cachedFlag"; then
    __textSHACached "$handler" "$cachePath" "${files[@]}" || return $?
  else
    set -- "${files[@]}"
    while [ $# -gt 0 ]; do
      [ -z "$debugLog" ] || printf "%s: %s\n" "$(date +"%FT%T")" "$1" >>textSHA.log
      ___textSHA "$handler" <"$1"
      shift
    done
  fi
}

___textSHA() {
  local handler="$1" && shift
  catchReturn "$handler" sha1sum "$@" | catchReturn "$handler" cut -f 1 -d ' ' || return $?
}

__textSHACached() {
  local handler="$1" && shift
  local cacheDirectory="" files=()

  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    case "$1" in
    "") shift && ___textSHA "$handler" "$@" && return $? || return $? ;;
    *)
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory="$(validate "$handler" Directory "cacheDirectory" "$1")" || return $?
      else
        files+=("$(validate "$handler" RealFile "file" "$1")") || return $?
      fi
      ;;
    esac
    shift
  done
  if [ ${#files[@]} -gt 0 ]; then
    cacheDirectory="${cacheDirectory%/}"
    local file && for file in "${files[@]}"; do
      cacheFile="$cacheDirectory/${file#/}"
      cacheFile=$(catchReturn "$handler" fileDirectoryRequire "$cacheFile") || return $?
      if [ -f "$cacheFile" ] && [ "$cacheFile" -nt "$1" ]; then
        printf "%s\n" "$(cat "$cacheFile")"
      else
        ___textSHA "$handler" "$argument" | catchEnvironment "$handler" tee "$cacheFile" || return $?
      fi
      shift
    done
  else
    ___textSHA "$handler" || return $?
  fi
}
