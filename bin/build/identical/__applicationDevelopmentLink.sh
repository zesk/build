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
  local handler="_${FUNCNAME[0]}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ argumentBlankCheck 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --reset | --copy) ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  developerDevelopmentLink --handler "$handler" --binary "install-application.sh" --path "bin/application" --development-path "bin/application" --version-json "bin/application/version.json" --variable "BUILD_MY_HOME" "${__saved[@]+"${__saved[@]}"}"
}
___applicationDevelopmentLink() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
