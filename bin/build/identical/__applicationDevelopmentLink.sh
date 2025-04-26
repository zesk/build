#!/bin/bash
#
# Identical template
#
# Template for developerDevelopmentLink implementations
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# DOC TEMPLATE: developerDevelopmentLink 2
# Argument: --copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.
# Argument: --reset - Flag. Optional. Revert the link and reinstall using the original binary.
# Add a development link to the local version of MY APPLICATION for testing in local projects
# DOC TEMPLATE: developerDevelopmentLink 2
# Argument: --copy - Flag. Optional. Copy the files instead of creating a link - more compatible with Docker but slower and requires synchronization.
# Argument: --reset - Flag. Optional. Revert the link and reinstall using the original binary.
__applicationDevelopmentLink() {
  local usage="_${FUNCNAME[0]}"

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --reset | --copy) ;;

    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  developerDevelopmentLink --handler "$usage" --binary "install-application.sh" --path "bin/application" --development-path "bin/application" --version-json "bin/application/version.json" --variable "BUILD_MY_HOME" "${__saved[@]+"${__saved[@]}"}"
}
___applicationDevelopmentLink() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
