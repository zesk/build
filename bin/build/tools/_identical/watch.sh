#!/usr/bin/env bash
#
# Watching identical
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# In case you forgot, the directory in which this file is named `_identical` and *NOT* `identical`.

# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
#
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Optional. Function. Use this error handler instead of the default error handler.
# Argument: ... - Arguments. Required. Arguments to `identicalCheck` for your watch.
# Watch a project for changes and propagate them immediately upon save. Can be quite dangerous so use with caution.
# Still a known bug which trims the last end bracket from files
identicalWatch() {
  local usage="_${FUNCNAME[0]}"

  local repairSources=()
  local findArgs=() extensionText="" rootDir=""

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
    # _IDENTICAL_ --handler 4
    --handler)
      shift
      usage=$(usageArgumentFunction "$usage" "$argument" "${1-}") || return $?
      ;;
    --no-map | --debug | --ignore-singles)
      ii+=("$argument")
      ;;
    --repair)
      shift
      ii+=("$argument" "${1-}")
      repairSources+=("$(usageArgumetnDirectory "$usage" "$argument" "${1-}")") || return $?
      ;;
    --cd)
      shift
      ii+=("$argument" "${1-}")
      rootDir=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
      ;;
    --exec | --skip | --singles | --single | --prefix | --exclude | --token)
      shift
      ii+=("$argument" "${1-}")
      ;;
    --extension)
      shift
      findArgs+=("-name" "*.$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
      extensionText="$extensionText .$1"
      ;;
    *)
      # HERE - inner loop
      : "$rootDir" "${repairSources[@]}" "${findArgs[@]}"
      # find repairsources ordered by descending modification date
      # read file and mod date, one per
      # for file - find tokens found in file
      # replace all tokens, each uniquely since start
      # next file until we find our saved file name or end of list
      # update top mod date and file name
      # done - next loop watches most recently modified and compares to our file, if it fails - repeat
      __catchEnvironment "$usage" identicalCheck "$@" || rweturn $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_identicalWatch() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
