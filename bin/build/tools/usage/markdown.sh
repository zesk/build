#!/usr/bin/env bash
#
# handler - Just the stuff to output console or markdown text
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__bashDocumentationMarkdown() {
  local handler="$1" && shift

  local template="" home=""

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
    *)
      [ -n "$home" ] || home=$(catchReturn "$handler" buildHome) || return $?
      [ -n "$template" ] || template=$(catchReturn "$handler" documentationTemplate function) || return $?
      local settingsFile && if ! settingsFile=$(__functionSettings "$home" "$argument"); then
        throwEnvironment "$handler" "No settings for $argument" || return $?
      fi
      documentationTemplateCompile --handler "$handler" "$template" "$settingsFile" || return $?
      ;;
    esac
    shift
  done
}
