#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
#  ▐        ▐     ▞▀▖▌ ▌▞▀▖
#  ▜▀ ▞▀▖▚▗▘▜▀ ▐▌ ▚▄ ▙▄▌▙▄▌
#  ▐ ▖▛▀ ▗▚ ▐ ▖▗▖ ▖ ▌▌ ▌▌ ▌
#   ▀ ▝▀▘▘ ▘ ▀ ▝▘ ▝▀ ▘ ▘▘ ▘


__shaPipe() {
  local handler="$1" && shift
  local argument
  whichExists sha1sum || __throwEnvironment "$handler" "Need packageGroupInstall sha1sum" || return $?
  if [ -n "$*" ]; then
    while [ $# -gt 0 ]; do
      argument="$1"
      [ "$argument" != "--help" ] || __help "$handler" "$@" || return 0
      [ -f "$1" ] || __throwArgument "$handler" "$1 is not a file" || return $?
      [ -n "$argument" ] || __throwArgument "$handler" "blank argument" || return $?
      if test "${DEBUG_SHAPIPE-}"; then
        printf "%s: %s\n" "$(date +"%FT%T")" "$argument" >>shaPipe.log
      fi
      sha1sum <"$argument" | cut -f 1 -d ' '
      shift || __throwArgument "$handler" "shift failed" || return $?
    done
  else
    if test "${DEBUG_SHAPIPE-}"; then
      printf "%s: stdin\n" "$(date +"%FT%T")" >>shaPipe.log
    fi
    sha1sum | cut -f 1 -d ' ' || __throwEnvironment "$handler" "sha1sum" || return $?
  fi
}

__cachedShaPipe() {
  local handler="$1" && shift
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local argument
  local cacheDirectory="${1-}"

  shift || __throwArgument "$handler" "Missing cacheDirectory" || return $?

  # Special case to skip caching
  if [ -z "$cacheDirectory" ]; then
    shaPipe "$@"
    return $?
  fi
  cacheDirectory="${cacheDirectory%/}"

  [ -d "$cacheDirectory" ] || __throwArgument "$handler" "cachedShaPipe: cacheDirectory \"$cacheDirectory\" is not a directory" || return $?
  if [ $# -gt 0 ]; then
    while [ $# -gt 0 ]; do
      argument="$1"
      [ "$argument" != "--help" ] || __help "$handler" "$@" || return 0
      [ -n "$argument" ] || __throwArgument "$handler" "blank argument" || return $?
      [ -f "$argument" ] || __throwArgument "$handler" "not a file $(decorate label "$argument")" || return $?
      cacheFile="$cacheDirectory/${argument#/}"
      cacheFile=$(__catch "$handler" fileDirectoryRequire "$cacheFile") || return $?
      if [ -f "$cacheFile" ] && fileIsNewest "$cacheFile" "$1"; then
        printf "%s\n" "$(cat "$cacheFile")"
      else
        __catch "$handler" shaPipe "$argument" | __catchEnvironment "$handler" tee "$cacheFile" || return $?
      fi
      shift
    done
  else
    shaPipe
  fi
}