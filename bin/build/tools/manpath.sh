#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# MANPATH related
# See: MANPATH.sh

# Modify the MANPATH environment variable to add a path.
# See: manPathRemove
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --first - Flag. Optional. Place any paths after this flag first in the list
# Argument: --last - Flag. Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `MANPATH` environment
# Environment: MANPATH
manPathConfigure() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0

  local tempPath
  export MANPATH

  catchReturn "$handler" buildEnvironmentLoad MANPATH || return $?
  tempPath="$(catchEnvironment "$handler" listAppend "$MANPATH" ':' "$@")" || return $?
  MANPATH="$tempPath"
}
_manPathConfigure() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove a path from the MANPATH environment variable
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: path ... - Directory. Required. The path to be removed from the `MANPATH` environment
# Environment: MANPATH
manPathRemove() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0

  export MANPATH
  catchReturn "$handler" buildEnvironmentLoad MANPATH || return $?
  local tempPath && tempPath="$(catchEnvironment "$handler" listRemove "$MANPATH" ':' "$@")" || return $?
  MANPATH="$tempPath"
}
_manPathRemove() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Cleans the MANPATH and removes non-directory entries and duplicates
#
# Maintains ordering.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# No-Arguments: default
manPathCleanDuplicates() {
  local handler="_${FUNCNAME[0]}" newPath
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  export MANPATH

  catchReturn "$handler" buildEnvironmentLoad MANPATH || return $?

  newPath=$(catchEnvironment "$handler" listCleanDuplicates --test _pathIsDirectory ':' "${PATH-}") || return $?

  MANPATH="$newPath"
}
_manPathCleanDuplicates() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
