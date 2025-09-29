#!/usr/bin/env bash
#
# File Functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/file.md
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
filesRename() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local old new verb

  old=$(usageArgumentEmptyString "$handler" "oldSuffix" "${1-}") && shift || return $?
  new=$(usageArgumentEmptyString "$handler" "newSuffix" "${1-}") && shift || return $?
  verb="${1-}" && shift || return $?

  while [ $# -gt 0 ]; do
    local prefix="$1"
    if [ -f "$prefix$old" ]; then
      __catchEnvironment "$handler" mv "$prefix$old" "$prefix$new" || return $?
      __catchEnvironment "$handler" statusMessage --last decorate info "$verb $(decorate file "$prefix$old") -> $(decorate file "$prefix$new")" || return $?
    fi
    shift
  done
}
_filesRename() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch the modification time of a file as a timestamp
#
# Usage: fileModificationTime filename0 [ filename1 ... ]
# Return Code: 2 - If file does not exist
# Return Code: 0 - If file exists and modification times are output, one per line
# Example:     fileModificationTime ~/.bash_profile
#
fileModificationTime() {
  local handler="_${FUNCNAME[0]}"
  local argument
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$handler" "blank argument" || return $?
    [ -f "$argument" ] || __throwArgument "$handler" "$argument is not a file" || return $?
    printf "%d\n" "$(date -r "$argument" +%s)"
    shift || __throwArgument "$handler" "shift" || return $?
  done
}
_fileModificationTime() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch the modification time in seconds from now of a file as a timestamp
#
# Usage: {fn} filename0 [ filename1 ... ]
# Return Code: 2 - If file does not exist
# Return Code: 0 - If file exists and modification times are output, one per line
# Example:     fileModificationTime ~/.bash_profile
#
fileModificationSeconds() {
  local handler="_${FUNCNAME[0]}"
  local now_

  now_="$(__catchEnvironment "$handler" date +%s)" || return $?
  local __count=$#
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
    local argument
    argument="$(usageArgumentFile "$handler" "argument #$((__count - $# + 1))" "${1-}")" || return $?
    argument=$(__catchEnvironment "$handler" fileModificationTime "$argument") || return $?
    printf "%d\n" "$((now_ - argument))"
    shift
  done
}
_fileModificationSeconds() {
  # __IDENTICAL__ usageDocument 1
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
# Example: {fn} $myDir ! -path "*/.*/*"
# Output: 1705347087 bin/build/tools.sh
# Output: 1704312758 bin/build/deprecated.sh
# Output: 1705442647 bin/build/build.json
#
fileModificationTimes() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local directory="${1-}" && shift
  [ -d "$directory" ] || __throwArgument "$handler" "Not a directory $(decorate code "$directory")" || return $?
  # See: platform
  __fileModificationTimes "$directory" "$@"
}
_fileModificationTimes() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List the most recently modified file in a directory
# Usage: {fn} directory [ findArgs ... ]
# Argument: directory - Required. Directory. Must exists - directory to list.
# Argument: findArgs - Optional additional arguments to modify the find query
fileModifiedRecentlyName() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local directory="${1-}" && shift
  [ -d "$directory" ] || __throwArgument "$handler" "Not a directory $(decorate code "$directory")" || return $?
  fileModificationTimes "$directory" -type f "$@" | sort -r | head -1 | cut -f2- -d" "
}
_fileModifiedRecentlyName() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List the most recently modified timestamp in a directory
# Usage: {fn} directory [ findArgs ... ]
# Argument: directory - Required. Directory. Must exists - directory to list.
# Argument: findArgs - Optional additional arguments to modify the find query
fileModifiedRecentlyTimestamp() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local directory="${1-}" && shift
  [ -d "$directory" ] || __throwArgument "$handler" "Not a directory $(decorate code "$directory")" || return $?
  fileModificationTimes "$directory" -type f "$@" | sort -r | head -1 | cut -f1 -d" "
}
_fileModifiedRecentlyTimestamp() {
  # __IDENTICAL__ usageDocument 1
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
# Return Code: 1 - `sourceFile`, 'targetFile' does not exist, or
# Return Code: 0 - All files exist and `sourceFile` is the oldest file
#
fileIsNewest() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  if [ $# -eq 0 ]; then
    return 1
  fi
  [ "$1" = "$(fileNewest "$@")" ]
}
_fileIsNewest() {
  # __IDENTICAL__ usageDocument 1
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
# Return Code: 1 - `sourceFile`, 'targetFile' does not exist, or
# Return Code: 0 - All files exist and `sourceFile` is the oldest file
#
fileIsOldest() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  if [ $# -eq 0 ]; then
    return 1
  fi
  [ "$1" = "$(fileOldest "$@")" ]
}
_fileIsOldest() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# fileOldest and fileNewest refactor
#
__gamutFile() {
  local handler="$1" comparison="$2"

  shift 2 || _argument "${FUNCNAME[0]} used incorrectly" || return $?

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local gamutTime="" theFile=""

  local __saved=("$@")
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1)) tempTime
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    [ -f "$argument" ] || __throwArgument "$handler" "Not a file: $(decorate code "$argument"): #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    tempTime=$(fileModificationTime "$argument") || __throwEnvironment "#$__index/$__count: fileModificationTime $argument: #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    if [ -z "$theFile" ] || test "$tempTime" "$comparison" "$gamutTime"; then
      theFile="$1"
      gamutTime="$tempTime"
    fi
    shift
  done
  printf "%s" "$theFile"
}

#
# Return the oldest file in the list.
#
# Usage: {fn} file0 [ file1 ... ]
# Argument: file0 - One or more files to examine
#
fileOldest() {
  __gamutFile "_${FUNCNAME[0]}" -lt "$@"
}
_fileOldest() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Return the newest file in the list
#
# Usage: {fn} file0 [ file1 ... ]
# Argument: file0 - One or more files to examine
#
fileNewest() {
  __gamutFile "_${FUNCNAME[0]}" -gt "$@"
}
_fileNewest() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Prints seconds since modified
# Usage: {fn} file
# Return Code: 0 - Success
# Return Code: 2 - Can not get modification time
#
fileModifiedSeconds() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local timestamp

  timestamp=$(fileModificationTime "$1") || __throwArgument "$handler" fileModificationTime "$1" || return $?
  printf %d "$(($(date +%s) - timestamp))"
}
_fileModifiedSeconds() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Prints days (integer) since modified
#
# Return Code: 0 - Success
# Return Code: 2 - Can not get modification time
#
fileModifiedDays() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local timestamp

  timestamp=$(fileModifiedSeconds "$1") || __throwArgument "$handler" fileModifiedSeconds "$1" || return $?
  printf %d "$((timestamp / 86400))"
}
_fileModifiedDays() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL _realPath 20

# Find the full, actual path of a file avoiding symlinks or redirection.
# See: readlink realpath
# DOC TEMPLATE: noArgumentsForHelp 1
# Without arguments, displays help.
# Argument: file ... - Required. File. One or more files to `realpath`.
# Requires: whichExists realpath __help usageDocument _argument
realPath() {
  # __IDENTICAL__ --help-when-blank 1
  [ $# -gt 0 ] || __help "_${FUNCNAME[0]}" --help || return 0
  if whichExists realpath; then
    realpath "$@"
  else
    readlink -f -n "$@"
  fi
}
_realPath() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: path ... - Required. File. One or more paths to simplify
# Normalizes segments of `/./` and `/../` in a path without using `realPath`
# Removes dot and dot-dot paths from a path correctly
directoryPathSimplify() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local path elements=() segment dot=0 result IFS="/"
  while [ $# -gt 0 ]; do
    path="$1"
    path="${path#"./"}"
    path="${path//\/\.\///}"
    read -r -a elements <<<"$path" || :
    if [ "${#elements[@]}" -gt 0 ]; then
      result=()
      for segment in "${elements[@]+"${elements[@]}"}"; do
        if [ "$segment" = ".." ]; then
          dot=$((dot + 1))
        elif [ $dot -gt 0 ]; then
          dot=$((dot - 1))
        else
          result+=("$segment")
        fi
      done
      printf "%s\n" "${result[*]-}"
    else
      printf "\n"
    fi
    shift
  done
}
_directoryPathSimplify() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Outputs value of virtual memory allocated for a process, value is in kilobytes
# Usage: {fn} file
# Argument: file - Required. File to get size of.
# Return Code: 0 - Success
# Return Code: 1 - Environment error
fileSize() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local size opts

  case "$(lowercase "${OSTYPE-}")" in
  *darwin*) opts=("-f" "%z") ;;
  *) opts=('-c%s') ;;
  esac
  while [ $# -gt 0 ]; do
    size="$(stat "${opts[@]}" "$1")" || __throwEnvironment "$handler" "Unable to stat" "${opts[@]}" "$1" || return $?
    printf "%s\n" "$size"
    shift || __throwArgument "$handler" shift || return $?
  done
}
_fileSize() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: item - String. Optional. Thing to classify
# Better type handling of shell objects
#
# Outputs one of `type` output or enhancements:
# - `builtin`, `function`, `alias`, `file`
# - `link-directory`, `link-file`, `link-dead`, `directory`, `integer`, `unknown`
fileType() {
  local t
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
    t="$(type -t "$1")" || :
    if [ -z "$t" ]; then
      if [ -L "$1" ]; then
        local ll
        if ! ll=$(readlink "$1"); then
          t="link-dead"
        elif [ -e "$ll" ]; then
          t="link-$(fileType "$ll")"
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
    shift
  done
}
_fileType() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} from to
#
# Renames a link forcing replacement, and works on different versions of `mv` which differs between systems.
# See: mv
linkRename() {
  local handler="_${FUNCNAME[0]}"

  local from="" to=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$from" ]; then
        from=$(usageArgumentLink "$handler" "from $(fileType "$1")" "$1") || return $?
      elif [ -z "$to" ]; then
        to=$(usageArgumentString "$handler" "to $(fileType "$1")" "$1") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done
  [ -n "$from" ] || __throwArgument "$handler" "Need a \"from\" argument" || return $?
  [ -n "$to" ] || __throwArgument "$handler" "Need a \"to\" argument" || return $?
  __linkRename "$from" "$to"
}
_linkRename() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} file ...
# Argument: file - File to get the owner for
# Outputs the file owner for each file passed on the command line
# Return Code: 0 - Success
# Return Code: 1 - Unable to access file
# Depends: ls
__fileListColumn() {
  local usageFunction="$1" column="${2-}" result

  shift 2
  while [ $# -gt 0 ]; do
    [ "${1-}" != "--help" ] || __help "$usageFunction" "$@" || return 0
    # shellcheck disable=SC2012
    if ! result="$(ls -ld "$1" | awk '{ print $'"$column"' }')"; then
      __throwEnvironment "$usageFunction" "Running ls -ld \"$1\"" || return $?
    fi
    printf "%s\n" "$result"
    shift
  done
}

#
# Usage: {fn} file ...
# Argument: file - File to get the owner for
# Outputs the file owner for each file passed on the command line
# Return Code: 0 - Success
# Return Code: 1 - Unable to access file
#
fileOwner() {
  __fileListColumn "_${FUNCNAME[0]}" 3 "$@"
}
_fileOwner() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} file ...
# Argument: file - File to get the owner for
# Outputs the file group for each file passed on the command line
# Return Code: 0 - Success
# Return Code: 1 - Unable to access file
#
fileGroup() {
  __fileListColumn "_${FUNCNAME[0]}" 4 "$@"
}
_fileGroup() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Find list of files which do NOT match a specific pattern or patterns and output them
#
# Usage: {fn} [ --help ] pattern ... -- [ exception ... ] -- file ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: pattern ... - Required. String. Pattern to find in files.
# Argument: -- - Required. Delimiter. exception.
# Argument: exception ... - Optional. String. File pattern which should be ignored.
# Argument: -- - Required. Delimiter. file.
# Argument: file ... - Required. File. File to search. Special file `-` indicates files should be read from `stdin`.
fileNotMatches() {
  _fileMatchesHelper "_${FUNCNAME[0]}" false "$@"
}
_fileNotMatches() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Find one or more patterns in a list of files, with a list of file name pattern exceptions.
#
# Usage: {fn} [ --help ] pattern ... -- [ exception ... ] -- file ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: pattern ... - Required. String. Pattern to find in files. No quoting is added so ensure these are compatible with `grep -e`.
# Argument: -- - Required. Delimiter. exception.
# Argument: exception ... - Optional. String. File pattern which should be ignored.
# Argument: -- - Required. Delimiter. file.
# Argument: file ... - Required. File. File to search. Special file `-` indicates files should be read from `stdin`.
fileMatches() {
  _fileMatchesHelper "_${FUNCNAME[0]}" true "$@"
}
_fileMatches() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_fileMatchesHelper() {
  local handler="$1" success="$2" && shift 2

  local file patterns=() found=false exceptions=() clean fileList foundLines

  [ $# -gt 0 ] || return 0
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --)
      shift
      break
      ;;
    *)
      patterns+=("$1")
      ;;
    esac
    shift
  done
  [ "${#patterns[@]}" -gt 0 ] || __catchArgument "$handler" "No patterns" || return $?
  [ $# -gt 0 ] || __catchArgument "$handler" "no exceptions or files" || return $?
  while [ $# -gt 0 ]; do [ "$1" = "--" ] && shift && break || exceptions+=("$1") && shift; done
  [ $# -gt 0 ] || __catchArgument "$handler" "no files" || return $?
  fileList=$(fileTemporaryName "$handler") || return $?
  foundLines="$fileList.found"
  clean=("$fileList" "$foundLines")
  if [ "$1" = "-" ]; then
    __catchEnvironment "$handler" cat >"$fileList" || returnClean $? "${clean[@]}" || return $?
  fi
  for pattern in "${patterns[@]}"; do
    if [ "$1" != "-" ]; then
      __catchEnvironment "$handler" printf "%s\n" "$@" >"$fileList" || returnClean $? "${clean[@]}" || return $?
    fi
    while read -r file; do
      if [ "${#exceptions[@]}" -gt 0 ] && stringContains "$file" "${exceptions[@]}"; then
        continue
      fi
      if $success; then
        if grep -n -e "$pattern" "$file" >"$foundLines"; then
          if ! fileIsEmpty "$foundLines"; then
            found=true
            decorate wrap "$file: " <"$foundLines"
          fi
        fi
      else
        if ! grep -q -e "$pattern" "$file"; then
          printf "%s:%s\n" "$file" "$pattern"
          found=true
        fi
      fi
    done <"$fileList"
  done
  returnClean 0 "${clean[@]}" || return $?
  $found
}

# Is this an empty (zero-sized) file?
# Return Code: 0 - if all files passed in are empty files
# Return Code: 1 - if any files passed in are non-empty files
# Argument: file - File. Optional. One or more files, all of which must be empty.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
fileIsEmpty() {
  local handler="_${FUNCNAME[0]}"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      argument="$(usageArgumentFile "$handler" "file" "$1")" || return $?
      [ ! -s "$argument" ] || return 1
      ;;
    esac
    shift
  done
}
_fileIsEmpty() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} directory
_directoryGamutFile() {
  local clipper="$1" directory="${2-.}" modified file && shift 2
  read -r modified file < <(__fileModificationTimes "$directory" -type f ! -path "*/.*/*" "$@" | sort -n | "$clipper" -n 1) || :
  [ -n "$modified" ] || return 0
  isPositiveInteger "$modified" || __throwEnvironment "$handler" "__fileModificationTimes output a non-integer: \"$modified\" \"$file\"" || return $?
  printf "%s\n" "$file"
}

# Argument: --find findArgs ... -- - Optional. ArgumentsDoubleDashDelimited. Arguments delimited by a double-dash (or end of argument list)
_directoryGamutFileWrapper() {
  local handler="$1" comparator="$2" && shift 2
  local directory="" findArgs=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --find)
      shift
      while [ $# -gt 0 ]; do
        [ "$1" != "--" ] || break
        findArgs+=("$1")
        shift
      done
      [ $# -gt 0 ] || break
      ;;
    *)
      [ -z "$directory" ] || __throwArgument "$handler" "Directory already supplied" || return $?
      directory="$(usageArgumentDirectory "$handler" "$argument" "${1-}")" || return $?
      ;;
    esac
    shift
  done
  [ -n "$directory" ] || __throwArgument "$handler" "directory is required" || return $?
  if ! _directoryGamutFile "$comparator" "$directory" "${findArgs[@]+"${findArgs[@]}"}"; then
    __throwEnvironment "$handler" "No files in $(decorate file "$directory") (${findArgs[*]-})" || return $?
  fi
}

# Find the oldest modified file in a directory
# Argument: directory - Directory. Required. Directory to search for the oldest file.
# Argument: --find findArgs ... -- - Optional. Arguments. Arguments delimited by a double-dash (or end of argument list)
directoryOldestFile() {
  _directoryGamutFileWrapper "_${FUNCNAME[0]}" head "$@"
}
_directoryOldestFile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Find the newest modified file in a directory
# Argument: directory - Directory. Required. Directory to search for the newest file.
# Argument: --find findArgs ... -- - Optional. Arguments. Arguments delimited by a double-dash (or end of argument list)
directoryNewestFile() {
  _directoryGamutFileWrapper "_${FUNCNAME[0]}" tail "$@"
}
_directoryNewestFile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Create a link
#
# Argument: target - Exists. File. Source file name or path.
# Argument: linkName - String. Required. Link short name, created next to `target`.
linkCreate() {
  local handler="_${FUNCNAME[0]}"

  local target="" path="" linkName="" backupFlag=true

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --no-backup)
      backupFlag=false
      ;;
    *)
      if [ -z "$target" ]; then
        target=$(usageArgumentExists "$handler" "target" "$argument") || return $?
        path=$(__catchEnvironment "$handler" dirname "$target") || return $?
      elif [ -z "$linkName" ]; then
        linkName=$(usageArgumentString "$handler" "linkName" "$argument") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$target" ] || __throwArgument "$handler" "Missing target" || return $?
  [ -n "$linkName" ] || __throwArgument "$handler" "Missing linkName" || return $?

  [ ! -L "$target" ] || __throwArgument "$handler" "Can not link to another link ($(decorate file "$target") is a link)" || return $?

  target=$(__catchEnvironment "$handler" basename "$target") || return $?

  [ -e "$path/$target" ] || __throwEnvironment "$handler" "$path/$target must be a file or directory" || return $?

  local link="$path/$linkName"
  if [ ! -L "$link" ]; then
    if [ -e "$link" ]; then
      __throwEnvironment "$handler" "$(decorate file "$link") exists and was not a link $(decorate code "$(fileType "$link")")" || :
      __catchEnvironment "$handler" mv "$link" "$link.createLink.$$.backup" || return $?
      clean+=("$link.$$.backup")
    fi
  else
    local actual
    actual=$(__catchEnvironment "$handler" readlink "$link") || return $?
    if [ "$actual" = "$target" ]; then
      return 0
    fi
    __catchEnvironment "$handler" mv "$link" "$link.createLink.$$.badLink" || return $?
    clean+=("$link.$$.badLink")
  fi
  __catchEnvironment "$handler" muzzle pushd "$path" || return $?
  __catchEnvironment "$handler" ln -s "$target" "$linkName" || returnUndo $? muzzle popd || return $?
  __catchEnvironment "$handler" muzzle popd || return $?
  $backupFlag || __catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
}
_linkCreate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL fileTemporaryName 33

# Wrapper for `mktemp`. Generate a temporary file name, and fail using a function
# Argument: handler - Function. Required. Function to call on failure. Function Type: _return
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: ... - Optional. Arguments. Any additional arguments are passed through.
# Requires: mktemp __help __catchEnvironment usageDocument
# BUILD_DEBUG: temp - Logs backtrace of all temporary files to a file in application root named after this function to detect and clean up leaks
fileTemporaryName() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  handler="$1" && shift
  local debug=";${BUILD_DEBUG-};"
  if [ "${debug#*;temp;}" != "$debug" ]; then
    local target="${BUILD_HOME-.}/.${FUNCNAME[0]}"
    printf "%s" "fileTemporaryName: " >>"$target"
    __catchEnvironment "$handler" mktemp "$@" | tee -a "$target" || return $?
    local sources=() count=${#FUNCNAME[@]} index=0
    while [ "$index" -lt "$count" ]; do
      sources+=("${BASH_SOURCE[index + 1]-}:${BASH_LINENO[index]-"$LINENO"} - ${FUNCNAME[index]-}")
      index=$((index + 1))
    done
    printf "%s\n" "${sources[@]}" "-- END" >>"$target"
  else
    __catchEnvironment "$handler" mktemp "$@" || return $?
  fi
}
_fileTemporaryName() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL fileTemporaryName
