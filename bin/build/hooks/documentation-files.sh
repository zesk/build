#!/usr/bin/env bash
#
# Get a complete list of files which make up an application's documentation source.
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

# fn: hookRun application-files
# Summary: `application-files` hook default implementation
# Get a complete list of files which make up an application's state. Should include anything which is code, not design. (fine line)
# Argument: ... - Arguments. Optional. Arguments are passed to the find command.
# Argument: --debug - Flag. Optional. Show debugging information.
# Argument: --not - Flag. Optional. Show list of files which are still excluded by APPLICATION_CODE_IGNORE but show files which are NOT included by extension.
__hookDocumentationFiles() {
  local handler="_${FUNCNAME[0]}"
  local debugFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) debugFlag=true ;;
    *)
      break
      ;;
    esac
    shift
  done
  local home && home=$(catchReturn "$handler" buildHome) || return $?

  set -- directoryChange "$home" find "./documentation/source" -type f \( -name '*.md' -or -name '*.js' -or -name '*.jpg' -or -name '*.gif' -or -name '*.css' -or -name '*.png' -or -name '*.svg' \) ! -path '*/.*/*' "$@"
  ! $debugFlag || decorate each quote "$@"
  "$@"
}
___hookDocumentationFiles() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookDocumentationFiles "$@"
