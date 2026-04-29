#!/usr/bin/env bash
#
# Checking identical
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# In case you forgot, the directory in which this file is named `_identical` and *NOT* `identical`.
#
# This is to avoid having this match when doing `identicalRepair` - causes issues.
#
# Thanks for your consideration.

# Argument: handler
# Argument: repairSource ...
# Argument: --
# Argument: directory
# Argument: findArgs ...
# stdout: list of files
__identicalCheckGenerateSearchFiles() {
  local handler="$1" && shift
  local directory && directory=$(validate "$handler" Directory "directory" "${1-%/}") && shift || return $?

  local repairSources=() && while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then shift && break; fi
    repairSources+=("$(validate "$handler" Directory repairSource "$1")") && shift || return $?
  done

  local directories=("${repairSources[@]+"${repairSources[@]}"}" -- "$directory")
  local searchFileList && searchFileList=$(fileTemporaryName "$handler") || return $?
  local clean=("$searchFileList")
  local ignorePatterns=() startExclude=false
  local directory && for directory in "${directories[@]}"; do
    directory="${directory%/}"
    if [ "$directory" = "--" ]; then
      startExclude=true
      continue
    fi
    local filter=("cat")
    if $startExclude && [ "${#ignorePatterns[@]}" -gt 0 ]; then
      filter=("grepSafe" "-v" "${ignorePatterns[@]}")
    fi
    directory=$(catchReturn "$handler" fileRealPath "$directory") || returnClean $? "${clean[@]}" || return $?
    if ! catchReturn "$handler" directoryChange "$directory" find . "$@" | sort | cut -c 3- | decorate wrap "${directory%/}/" | "${filter[@]}" >>"$searchFileList"; then
      # decorate warning "No matching files found in $directory" 1>&2
      : Do nothing for now
    fi
    ignorePatterns+=(-e "$(quoteGrepPattern "$directory/")")
  done
  catchEnvironment "$handler" cat "$searchFileList" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
}
