#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Show current application and path as a badge in iTerm2
# Platform: iTerm2
# Terminal: iTerm2
# Example:     bashPrompt bashPromptModule_ApplicationPath
bashPromptModule_ApplicationPath() {
  local handler="returnMessage"
  local folderIcon="📂"
  local path applicationPath
  [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0

  path=$(catchEnvironment "$handler" pwd) || return $?
  applicationPath=$(decoratePath "$path")
  if [ "$applicationPath" != "$path" ]; then
    iTerm2Badge -i "$(printf -- "%s\n%s %s\n" "$(buildEnvironmentGet APPLICATION_NAME)" "$folderIcon" "$applicationPath")"
  fi
}
_bashPromptModule_ApplicationPath() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
