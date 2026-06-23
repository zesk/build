#!/usr/bin/env bash
#
# Run during `deployApplication` in the OLD application and is intended
# to signal the application to start shutting down for a new version to take
# its place. So any files in tge application root which for any reason need to
# be preserved should be managed here or in other hooks if needed.
# Ideally your application would consist solely of application code and no data files
# in which case it won't be an issue.
#
# This is run ON THE REMOTE SYSTEM, not in the pipeline
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# shellcheck source=/dev/null
if source "${BASH_SOURCE[0]%/*}/../../../tools.sh"; then

  set -eou pipefail

  # Summary: Sets the process title
  # Argument: message - String. Optional. A string to set the process title.
  # If blank, does nothing.
  __hookProcessTitle() {
    local handler="_${FUNCNAME[0]#_}"

    local message=""
    # _IDENTICAL_ argumentNonBlankLoopHandler 6
    local __saved=("$@") __count=$#
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
      case "$argument" in
      # _IDENTICAL_ helpHandler 1
      --help) "$handler" 0 && return $? || return $? ;;
      # _IDENTICAL_ handlerHandler 1
      --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
      *) message="$*" && break ;;
      esac
      shift
    done

    if [ -n "$message" ]; then
      iTerm2Badge -i "$message"
    fi
    # IDENTICAL hookRunOptionalNext 1
    catchReturn "$handler" hookRunOptional --next "${BASH_SOURCE[0]}" "$HOOK_NAME" "${__saved[@]+"${__saved[@]}"}" || return $?
  }
  ___hookProcessTitle() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }
  __hookProcessTitle "$@"
fi
