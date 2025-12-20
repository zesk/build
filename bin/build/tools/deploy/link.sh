#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
#    ▌      ▜
#  ▞▀▌▞▀▖▛▀▖▐ ▞▀▖▌ ▌
#  ▌ ▌▛▀ ▙▄▘▐ ▌ ▌▚▄▌
#  ▝▀▘▝▀▘▌   ▘▝▀ ▗▄▘
#

__deployLink() {
  local handler="$1" && shift

  local applicationLinkPath="" currentApplicationHome=""
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$applicationLinkPath" ]; then
        applicationLinkPath="$argument"
        if [ -e "$applicationLinkPath" ]; then
          if [ ! -L "$applicationLinkPath" ]; then
            [ ! -d "$applicationLinkPath" ] || throwArgument "$handler" "$applicationLinkPath is directory (should be a link)" || return $?
            # Not a link or directory
            throwArgument "$handler" "Unknown file type $(fileType "$applicationLinkPath")" || return $?
          fi
        else
          applicationLinkPath=$(usageArgumentFileDirectory "$handler" applicationLinkPath "$applicationLinkPath") || return $?
        fi
      elif [ -z "$currentApplicationHome" ]; then
        # No checking - allows pre-linking
        currentApplicationHome="$argument"
        if [ ! -d "$currentApplicationHome" ]; then
          decorate warning "currentApplicationHome $currentApplicationHome points to a non-existent directory"
        fi
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  if [ -z "$applicationLinkPath" ]; then
    catchArgument "$handler" "Missing applicationLinkPath" || return $?
  fi
  if [ -z "$currentApplicationHome" ]; then
    currentApplicationHome="$(pwd -P 2>/dev/null)" || throwEnvironment "$handler" "pwd failed" || return $?
  fi
  local newApplicationLinkPath
  newApplicationLinkPath="$applicationLinkPath.READY.$$"
  if ! ln -sf "$currentApplicationHome" "$newApplicationLinkPath" || ! linkRename "$newApplicationLinkPath" "$applicationLinkPath"; then
    rm -rf "$newApplicationLinkPath" 2>/dev/null
    throwEnvironment "$handler" "Unable to link and rename" || return $?
  fi
}
