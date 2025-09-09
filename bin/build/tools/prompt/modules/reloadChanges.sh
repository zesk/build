#!/usr/bin/env bash
#
# Bash Prompt Module: binBuild
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Check for shell files changing and reload a shell script after any changes and notify the user
#
# Source-Hook: project-activate
# Source-Hook: project-deactivate
# BUILD_DEBUG: reloadChanges - `bashPromptModule_reloadChanges` will show debugging information
bashPromptModule_reloadChanges() {
  __reloadChangesLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@" || return $?
}
_bashPromptModule_reloadChanges() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
