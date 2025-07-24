#!/usr/bin/env bash
#
# Checking identical
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# In case you forgot, the directory in which this file is named `_identical` and *NOT* `identical`.
#
# This is to avoid having this match when doing `identicalRepair` - causes issues.
#
# Thanks for your consideration.

# Usage: {fn} usage repairSource ... -- directory findArgs ...
# stdout: list of files
__identicalCheckGenerateSearchFiles() {
  local usage="$1" && shift

  local repairSources=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      shift
      break
    fi
    repairSources+=("$(usageArgumentDirectory "$usage" repairSource "${1%/}/")") || return $?
    shift # repairSource
  done

    local searchFileList directory directories

  directory=$(usageArgumentDirectory "$usage" "directory" "${1-%/}") || return $?
  local directories=("${repairSources[@]+"${repairSources[@]}"}" -- "$directory") && shift

  searchFileList=$(fileTemporaryName "$usage") || return $?
  local ignorePatterns=() startExclude=false
  for directory in "${directories[@]}"; do
    directory="${directory%/}"
    if [ "$directory" = "--" ]; then
      startExclude=true
      continue
    fi
    local filter=("cat")
    if $startExclude && [ "${#ignorePatterns[@]}" -gt 0 ]; then
      filter=("grepSafe" "-v" "${ignorePatterns[@]}")
    fi
    if ! find "$directory" "$@" | sort | "${filter[@]}" >>"$searchFileList"; then
      # decorate warning "No matching files found in $directory" 1>&2
      : Do nothing for now
    fi
    ignorePatterns+=(-e "$(quoteGrepPattern "$directory/")")
  done
  __catchEnvironment "$usage" cat "$searchFileList" || returnClean "$?" "$searchFileList" || return $?
  __catchEnvironment "$usage" rm -rf "$searchFileList" || return $?
}
