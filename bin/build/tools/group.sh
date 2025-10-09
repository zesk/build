#!/bin/bash
#
# Unix "Group" Functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL groupID 41

# Convert a group name to a group ID
# Argument: groupName - String. Optional. Group name to convert to a group ID
# stdout: `Integer`. One line for each group name passed as an argument.
# Return Code: 0 - All groups were found in the database and IDs were output successfully
# Return Code: 1 - Any group is not found in the database.
# Return Code: 2 - Argument errors (blank argument)
# Requires: throwArgument getent cut printf usageDocument decorate grep  quoteGrepPattern
groupID() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local __saved=("$@") __count=$#
  local gid
  if whichExists getent; then
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      gid="$(getent group "$argument" | cut -d: -f3)" || return 1
      isInteger "$gid" || return 1
      printf "%d\n" "$gid" && shift
    done
  else
    local groupFile="/etc/group"
    [ -f "$groupFile" ] || throwEnvironment "$handler" "Unable to access $groupFile" || return $?
    while [ $# -gt 0 ]; do
      local argument="$1" __index=$((__count - $# + 1))
      # __IDENTICAL__ __checkBlankArgumentHandler 1
      [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
      gid="$(grep -e "^$(quoteGrepPattern "$argument")" <"$groupFile" | cut -d: -f3)" || return 1
      isInteger "$gid" || return 1
      printf "%d\n" "$gid" && shift
    done
  fi
}
_groupID() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
