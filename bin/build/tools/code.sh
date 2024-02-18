#!/usr/bin/env bash
#
# code.sh
#
# See: coding.md
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorArgument 1
errorArgument=2

# A contrived function to show some features and patterns.
#
# Usage: {fn} [ --debug ] [ --cleanup ] [ --undo ] [ --id id ] --home home --target target --application application
# Argument: --debug - Flag. Optional. Debugging mode.
# Argument: --cleanup - Flag. Optional. Debugging mode.
# Argument: --undo - Flag. Optional. Debugging mode.
# Argument: --home homePath - Required. Directory. Home path to show off directory validation.
# Argument: --target target - Required. File. Target file to show off file validation.
# Argument: --id id - Optional. String. Just an argument with a value.
# Argument: --application applicationPath - Required. Directory. Application path to show off directory validation.
#
simpleBashFunction() {
  local debuggingFlag cleanupFlag revertFlag homePath target id applicationPath

  # --debug
  debuggingFlag=
  # --cleanup
  cleanupFlag=
  # --undo
  revertFlag=

  # --home
  homePath=
  # --target
  target=
  # --id
  id=
  # --application
  applicationPath=

  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      "_${FUNCNAME[0]}" "$errorArgument" "Blank argument $1" || return $?
    fi
    case "$1" in
      --debug)
        debuggingFlag=1
        ;;
      --cleanup)
        cleanupFlag=1
        ;;
      --revert)
        revertFlag=1
        ;;
      --home)
        shift || :
        if ! homePath=$(usageArgumentDirectory "_${FUNCNAME[0]}" homePath "${1-}"); then
          return "$errorArgument"
        fi
        ;;
      --id)
        shift || "_${FUNCNAME[0]}" "$errorArgument" "--id id missing" || return $?
        if [ -z "$1" ]; then
          "_${FUNCNAME[0]}" "$errorArgument" "Blank --id"
        fi
        id="$1"
        ;;
      --application)
        shift || "_${FUNCNAME[0]}" "$errorArgument" "--application applicationPath missing" || return $?
        if ! applicationPath=$(usageArgumentDirectory "_${FUNCNAME[0]}" application "$1"); then
          return "$errorArgument"
        fi
        ;;
      --target)
        shift || "_${FUNCNAME[0]}" "$errorArgument" "--target target missing" || return $?
        if ! target=$(usageArgumentFile "_${FUNCNAME[0]}" target "$1"); then
          return "$errorArgument"
        fi
        ;;
      *)
        "_${FUNCNAME[0]}" "$errorArgument" "Unknown argument $1" || return $?
        ;;
    esac
    shift || "_${FUNCNAME[0]}" "$errorArgument" "shift failed" || return $?
  done
  # Check arguments are non-blank and actually supplied
  for name in home application target; do
    if [ -z "${!name}" ]; then
      "_${FUNCNAME[0]}" "$errorArgument" "$name is required" || return $?
    fi
  done

  consoleNameValue 30 "debuggingFlag" "$debuggingFlag"
  consoleNameValue 30 "cleanupFlag" "$cleanupFlag"
  consoleNameValue 30 "homePath" "$homePath"
  consoleNameValue 30 "revertFlag" "$revertFlag"
  consoleNameValue 30 "homePath" "$homePath"
  consoleNameValue 30 "id" "$id"
  consoleNameValue 30 "applicationPath" "$applicationPath"
  consoleNameValue 30 "target" "$target"
}
_simpleBashFunction() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
