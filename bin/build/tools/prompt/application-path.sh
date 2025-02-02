#!/usr/bin/env bash
#
# Bash Prompt Module: ApplicationPath
#
# Copyright &copy; 2025 Market Acumen, Inc.

#
# Show current application and path as a badge
# Platform: iTerm2
# Terminal: iTerm2
# Example:     bashPrompt bashPromptModule_ApplicationPath
bashPromptModule_ApplicationPath() {
  local folderIcon="📂"
  local path applicationPath
  path=$(__environment pwd) || return $?
  applicationPath=$(decoratePath "$path")
  if [ "$applicationPath" != "$path" ]; then
    iTerm2Badge -i "$(printf -- "%s\n%s %s\n" "$(buildEnvironmentGet APPLICATION_NAME)" "$folderIcon" "$applicationPath")"
  fi
}
