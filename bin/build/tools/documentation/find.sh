#!/usr/bin/env bash
#
# Documentation
#
# Copyright &copy; 2025 Market Acumen, Inc.

#
# Finds one ore more function definition and outputs the file or files in which a
# function definition is found. Searches solely `.sh` files. (Bash or sh scripts)
#
# Note this function succeeds if it finds all occurrences of each function, but
# may output partial results with a failure.
#
# Usage: __bashDocumentation_FindFunctionDefinitions directory fnName0 [ fnName1... ]
# Argument: `directory` - The directory to search
# Argument: `fnName0` - A function to find the file in which it is defined
# Argument: `fnName1...` - Additional functions are found are output as well
# Return Code: 0 - if one or more function definitions are found
# Return Code: 1 - if no function definitions are found
# Environment: Generates a temporary file which is removed
# Example:     __bashDocumentation_FindFunctionDefinitions . __bashDocumentation_FindFunctionDefinitions
# Example:     ./bin/build/tools/autodoc.sh
# Platform: `stat` is not cross-platform
# Summary: Find where a function is defined in a directory of shell scripts
#
__bashDocumentation_FindFunctionDefinitions() {
  local handler="_${FUNCNAME[0]}"

  local directory

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  directory=$(usageArgumentDirectory "$handler" "directory" "${1-}") && shift || return $?

  local foundCount=0 phraseCount=${#@}
  while [ "$#" -gt 0 ]; do
    local fn=$1 file escaped
    escaped=$(quoteGrepPattern "$fn")
    local functionPattern="^$escaped\(\) \{|^function $escaped \{"
    while read -r file; do
      if grep -E -q -e "$functionPattern" "$file"; then
        printf "%s\n" "$file"
        foundCount=$((foundCount + 1))
      fi
    done < <(find "$directory" -type f -name '*.sh' ! -path "*/.*/*")
    shift
  done
  [ "$phraseCount" -eq "$foundCount" ]
}
___bashDocumentation_FindFunctionDefinitions() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Finds a function definition and outputs the file in which it is found
# Searches solely `.sh` files. (Bash or sh scripts)
#
# Succeeds IFF only one version of a function is found.
#
# Usage: __bashDocumentation_FindFunctionDefinition directory fn
# Argument: `directory` - The directory to search
# Argument: `fn` - A function to find the file in which it is defined
# Return Code: 0 - if one or more function definitions are found
# Return Code: 1 - if no function definitions are found
# Environment: Generates a temporary file which is removed
# Example:     __bashDocumentation_FindFunctionDefinition . handler
# Summary: Find single location where a function is defined in a directory of shell scripts
# See: __bashDocumentation_FindFunctionDefinitions
__bashDocumentation_FindFunctionDefinition() {
  local handler="_${FUNCNAME[0]}"
  local directory fn

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  directory=$(usageArgumentDirectory "$handler" "directory" "${1-}") && shift || return $?
  fn=$(usageArgumentString "$handler" "fn" "${1-}") && shift || return $?

  local definitionFile
  definitionFile=$(__catch "$handler" __bashDocumentation_FindFunctionDefinitions "$directory" "$fn" | head -n 1) || return $?
  if [ -z "$definitionFile" ]; then
    __throwEnvironment "$handler" "No files found for $fn in $directory" || return $?
  fi
  printf "%s\n" "$definitionFile"
}
___bashDocumentation_FindFunctionDefinition() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
