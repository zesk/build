#!/usr/bin/env bash
#
# File Functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/file.md
# Test: o ./test/tools/file-tests.sh
#
#

#
# Renames "$file0$oldSuffix" to "$file0$newSuffix" if file exists and outputs a message using the actionVerb
#
# If files do not exist, does nothing
#
# Used to move files, temporarily, sometimes and then move back easily.
#
# Renames files which have `oldSuffix` to then have `newSuffix` and output a message using `actionVerb`:
#
# Summary: Rename a list of files usually to back them up temporarily
# Usage: {fn} oldSuffix newSuffix actionVerb file0 [ file1 file2 ... ]
# Argument: oldSuffix - Required. String. Old suffix to look rename from.
# Argument: newSuffix - Required. String. New suffix to rename to.
# Argument: actionVerb - Required. String. Description to output for found files.
# Argument: file0 - Required. String. One or more files to rename, if found, renaming occurs.
# Example:     {fn} "" ".$$.backup" hiding etc/app.json etc/config.json
# Example:     ...
# Example:     {fn} ".$$.backup" "" restoring etc/app.json etc/config.json
#
renameFiles() {
  local old=$1 new=$2 verb=$3

  shift
  shift
  shift
  for i in "$@"; do
    if [ -f "$i$old" ]; then
      mv "$i$old" "$i$new"
      consoleWarning "$verb $i$old -> $i$new"
    fi
  done
}

# Fetch the modification time of a file as a timestamp
#
# Usage: modificationTime filename0 [ filename1 ... ]
# Exit Code: 2 - If file does not exist
# Exit Code: 0 - If file exists and modification times are output, one per line
# Example:     modificationTime ~/.bash_profile
#
modificationTime() {
  local usage="_${FUNCNAME[0]}"
  local argument
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    [ -f "$argument" ] || __failArgument "$usage" "$argument is not a file" || return $?
    printf "%d\n" "$(date -r "$argument" +%s)"
    shift || __failArgument "$usage" "shift" || return $?
  done
}
_modificationTime() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch the modification time in seconds from now of a file as a timestamp
#
# Usage: {fn} filename0 [ filename1 ... ]
# Exit Code: 2 - If file does not exist
# Exit Code: 0 - If file exists and modification times are output, one per line
# Example:     modificationTime ~/.bash_profile
#
modificationSeconds() {
  local usage="_${FUNCNAME[0]}"
  local nArguments argument
  local now

  now="$(date +%s)"
  nArguments=$#
  while [ $# -gt 0 ]; do
    argument="$(usageArgumentFile "$usage" "argument #$((nArguments - $# + 1))" "${1-}")" || return $?
    __usageEnvironment "$usage" printf "%d\n" "$((now - $(modificationTime "$argument")))" || return $?
    shift
  done
}
_modificationSeconds() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Lists files in a directory recursively along with their modification time in seconds.
#
# Output is unsorted.
#
# Usage: {fn} directory [ findArgs ... ]
# Argument: directory - Required. Directory. Must exists - directory to list.
# Argument: findArgs - Optional additional arguments to modify the find query
# Example: {fn} $myDir ! -path '*/.*'
# Output: 1705347087 bin/build/tools.sh
# Output: 1704312758 bin/build/deprecated.sh
# Output: 1705442647 bin/build/build.json
#
listFileModificationTimes() {
  local usage="_${FUNCNAME[0]}"
  local directory

  directory="$1"
  [ -d "$directory" ] || __failArgument "$usage" "Not a directory $(consoleCode "$directory")" || return $?
  shift || :
  if [ "$(uname -s)" = "Darwin" ]; then
    find "$directory" -type f "$@" -exec stat -f '%m %N' {} \;
  else
    find "$directory" -type f "$@" -exec stat --format='%Y %n' {} \;
  fi
}
_listFileModificationTimes() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List the most recently modified file in a directory
# Usage: {fn} directory [ findArgs ... ]
# Argument: directory - Required. Directory. Must exists - directory to list.
# Argument: findArgs - Optional additional arguments to modify the find query
mostRecentlyModifiedFile() {
  local usage="_${FUNCNAME[0]}"
  directory="$1"
  [ -d "$directory" ] || __failArgument "$usage" "Not a directory $(consoleCode "$directory")" || return $?
  shift || :
  listFileModificationTimes "$directory" -type f "$@" | sort -r | head -1 | cut -f2- -d" "
}
_mostRecentlyModifiedFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List the most recently modified timestamp in a directory
# Usage: {fn} directory [ findArgs ... ]
# Argument: directory - Required. Directory. Must exists - directory to list.
# Argument: findArgs - Optional additional arguments to modify the find query
mostRecentlyModifiedTimestamp() {
  local usage="_${FUNCNAME[0]}"
  directory="$1"
  [ -d "$directory" ] || __failArgument "$usage" "Not a directory $(consoleCode "$directory")" || return $?
  shift || :
  listFileModificationTimes "$directory" -type f "$@" | sort -r | head -1 | cut -f1 -d" "
}
_mostRecentlyModifiedTimestamp() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Check to see if the first file is the newest one
#
# If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
# Otherwise return `1``
#
# Usage: {fn} firstFile [ targetFile0 ... ]
# Argument: sourceFile - File to check
# Argument: targetFile0 - One or more files to compare
#
# Exit code: 1 - `sourceFile`, 'targetFile' does not exist, or
# Exit code: 0 - All files exist and `sourceFile` is the oldest file
#
isNewestFile() {
  if [ $# -eq 0 ]; then
    return 1
  fi
  [ "$1" = "$(newestFile "$@")" ]
}

#
# Check to see if the first file is the newest one
#
# If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
# Otherwise return `1``
#
# Usage: {fn} firstFile [ targetFile0 ... ]
# Argument: sourceFile - File to check
# Argument: targetFile0 - One or more files to compare
#
# Exit code: 1 - `sourceFile`, 'targetFile' does not exist, or
# Exit code: 0 - All files exist and `sourceFile` is the oldest file
#
isOldestFile() {
  if [ $# -eq 0 ]; then
    return 1
  fi
  [ "$1" = "$(oldestFile "$@")" ]
}

#
# oldestFile and newestFile refactor
#
__gamutFile() {
  local usage="$1" comparison="$2"

  shift 2 || _argument "${FUNCNAME[0]} used incorrectly" || return $?

  local argument
  local tempTime gamutTime theFile=

  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    [ -f "$argument" ] || __failArgument "$usage" "Not a file $(consoleCode "$argument")" || return $?
    tempTime=$(modificationTime "$argument") || __failEnvironment modificationTime "$argument" || return $?
    if [ -z "$theFile" ] || test "$tempTime" "$comparison" "$gamutTime"; then
      theFile="$1"
      gamutTime="$tempTime"
    fi
    shift || :
  done
  printf "%s" "$theFile"
}

#
# Return the oldest file in the list.
#
# Usage: {fn} file0 [ file1 ... ]
# Argument: file0 - One or more files to examine
#
oldestFile() {
  __gamutFile "_${FUNCNAME[0]}" -lt "$@"
}
_oldestFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Return the newest file in the list
#
# Usage: {fn} file0 [ file1 ... ]
# Argument: file0 - One or more files to examine
#
newestFile() {
  __gamutFile "_${FUNCNAME[0]}" -gt "$@"
}
_newestFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Prints seconds since modified
# Usage: {fn} file
# Exit Code: 0 - Success
# Exit Code: 2 - Can not get modification time
#
modifiedSeconds() {
  local usage="_${FUNCNAME[0]}"
  local timestamp

  timestamp=$(modificationTime "$1") || __failArgument "$usage" modificationTime "$1" || return $?
  printf %d "$(($(date +%s) - timestamp))"
}
_modifiedSeconds() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Prints days (integer) since modified
#
# Exit Code: 0 - Success
# Exit Code: 2 - Can not get modification time
#
modifiedDays() {
  local usage="_${FUNCNAME[0]}"
  local timestamp

  timestamp=$(modifiedSeconds "$1") || __failArgument "$usage" modifiedSeconds "$1" || return $?
  printf %d "$((timestamp / 86400))"
}
_modifiedDays() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL _realPath 10
# Usage: realPath argument
# Argument: file ... - Required. File. One or more files to `realpath`.
realPath() {
  # realpath is not present always
  if whichExists realpath; then
    realpath "$@"
  else
    readlink -f -n "$@"
  fi
}

#
# Outputs value of virtual memory allocated for a process, value is in kilobytes
# Usage: {fn} file
# Argument: file - Required. File to get size of.
# Exit Code: 0 - Success
# Exit Code: 1 - Environment error
#
fileSize() {
  local size opts
  local usage="_${FUNCNAME[0]}"

  export OSTYPE
  __usageEnvironment "$usage" buildEnvironmentLoad OSTYPE || return $?

  case "$(lowercase "${OSTYPE}")" in
    *darwin*) opts=("-f" "%z") ;;
    *) opts=('-c%s') ;;
  esac
  while [ $# -gt 0 ]; do
    size="$(stat "${opts[@]}" "$1")" || __failEnvironment "$usage" "Unable to stat" "${opts[@]}" "$1" || return $?
    printf "%s\n" "$size"
    shift || __failArgument "$usage" shift || return $?
  done
}
_fileSize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} [ thing ]
# Better type handling of shell objects
#
# Outputs one of `type` output or enhancements:
# - `builtin`. `function`, `alias`, `file`
# - `link-directory`, `link-file`, `directory`, `integer`, `unknown`
#
betterType() {
  local t
  while [ $# -gt 0 ]; do
    t="$(type -t "$1")" || :
    if [ -z "$t" ]; then
      if [ -L "$1" ]; then
        local ll
        if ! ll=$(readlink "$1"); then
          t="link-fail"
        elif [ -e "$ll" ]; then
          t="link-$(betterType "$ll")"
        else
          t="link-unknown"
        fi
      elif [ -d "$1" ]; then
        t="directory"
      elif [ -f "$1" ]; then
        t="file"
      elif isInteger "$1"; then
        t="integer"
      else
        t="unknown"
      fi
    fi
    printf "%s\n" "$t" || return $?
    shift || :
  done
}

#
# Usage: {fn} from to
#
# Renames a link forcing replacement, and works on different versions of `mv` which differs between systems.
#
renameLink() {
  if mv --version >/dev/null 2>&1; then
    # gnu version supports -T
    mv -fT "$@"
  else
    mv -fh "$@"
  fi
}

#
# Usage: {fn} file ...
# Argument: file - File to get the owner for
# Outputs the file owner for each file passed on the command line
# Exit code: 0 - Success
# Exit code: 1 - Unable to access file
# Depends: ls
__fileListColumn() {
  local usageFunction="$1" column="${2-}" result

  shift 2
  while [ $# -gt 0 ]; do
    # shellcheck disable=SC2012
    if ! result="$(ls -ld "$1" | awk '{ print $'"$column"' }')"; then
      __failEnvironment "$usageFunction" "Running ls -ld \"$1\"" || return $?
    fi
    printf "%s\n" "$result"
    shift
  done
}

#
# Usage: {fn} file ...
# Argument: file - File to get the owner for
# Outputs the file owner for each file passed on the command line
# Exit code: 0 - Success
# Exit code: 1 - Unable to access file
#
fileOwner() {
  __fileListColumn "_${FUNCNAME[0]}" 3 "$@"
}
_fileOwner() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} file ...
# Argument: file - File to get the owner for
# Outputs the file group for each file passed on the command line
# Exit code: 0 - Success
# Exit code: 1 - Unable to access file
#
fileGroup() {
  __fileListColumn "_${FUNCNAME[0]}" 4 "$@"
}
_fileGroup() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
