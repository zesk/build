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
  local handler="$1" && shift
  local directory

  directory=$(usageArgumentDirectory "$handler" "directory" "${1-%/}") && shift || return $?

  local repairSources=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then shift && break; fi
    repairSources+=("$(usageArgumentDirectory "$handler" repairSource "$1")") && shift || return $?
  done

  local searchFileList directory directories

  local directories=("${repairSources[@]+"${repairSources[@]}"}" -- "$directory")

  searchFileList=$(fileTemporaryName "$handler") || return $?
  local clean=("$searchFileList")
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
    directory=$(__catch "$handler" realPath "$directory") || returnClean $? "${clean[@]}" || return $?

    if ! __catch "$handler" directoryChange "$directory" find . "$@" | sort | "${filter[@]}" | cut -c 3- | decorate wrap "${directory%/}/" >>"$searchFileList"; then
      # decorate warning "No matching files found in $directory" 1>&2
      : Do nothing for now
    fi
    ignorePatterns+=(-e "$(quoteGrepPattern "$directory/")")
  done
  __catchEnvironment "$handler" cat "$searchFileList" || returnClean $? "${clean[@]}" || return $?
  __catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
}
