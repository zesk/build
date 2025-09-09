#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
#
#    ▌      ▜
#  ▞▀▌▞▀▖▛▀▖▐ ▞▀▖▌ ▌
#  ▌ ▌▛▀ ▙▄▘▐ ▌ ▌▚▄▌
#  ▝▀▘▝▀▘▌   ▘▝▀ ▗▄▘
#

# Usage: {fn} applicationLinkPath
# Environment: PWD
# Argument: applicationLinkPath - Path. Required. Path where the link is created.
# Argument: applicationPath - Path. Optional. Path where the link will point to. If not supplied uses current working directory.
#
# Link new version of application.
#
# When called, current directory is the **new** application and the `applicationLinkPath` which is
# passed as an argument is the place where the **new** application should be linked to
# in order to activate it.
#
# Summary: Link deployment to new version of the application
# Argument: applicationLinkPath - This is the target for the current application
# Exit code: 0 - Success
# Exit code: 1 - Environment error
# Exit code: 2 - Argument error
#

__deployLink() {
  local handler="$1" && shift

  local applicationLinkPath="" currentApplicationHome=""
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$applicationLinkPath" ]; then
        applicationLinkPath="$argument"
        if [ -e "$applicationLinkPath" ]; then
          if [ ! -L "$applicationLinkPath" ]; then
            [ ! -d "$applicationLinkPath" ] || __throwArgument "$handler" "$applicationLinkPath is directory (should be a link)" || return $?
            # Not a link or directory
            __throwArgument "$handler" "Unknown file type $(fileType "$applicationLinkPath")" || return $?
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
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  if [ -z "$applicationLinkPath" ]; then
    __catchArgument "$handler" "Missing applicationLinkPath" || return $?
  fi
  if [ -z "$currentApplicationHome" ]; then
    currentApplicationHome="$(pwd -P 2>/dev/null)" || __throwEnvironment "$handler" "pwd failed" || return $?
  fi
  local newApplicationLinkPath
  newApplicationLinkPath="$applicationLinkPath.READY.$$"
  if ! ln -sf "$currentApplicationHome" "$newApplicationLinkPath" || ! linkRename "$newApplicationLinkPath" "$applicationLinkPath"; then
    rm -rf "$newApplicationLinkPath" 2>/dev/null
    __throwEnvironment "$handler" "Unable to link and rename" || return $?
  fi
}
