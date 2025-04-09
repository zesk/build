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

# TODO suggest rename
#mostRecentlyModifiedFile|fileRecentlyModified
#mostRecentlyModifiedTimestamp|fileTimestampRecentlyModified
#isNewestFile|fileIsNewest
#isOldestFile|fileIsOldest
#oldestFile|fileOldest
#newestFile|fileNewest
#modifiedSeconds|fileModifiedSeconds
#modifiedDays|fileModifiedDays
#modificationSeconds|fileModificationSeconds
#modificationTime|fileModificationTime
#renameFiles|filesRename


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
  local usage="_${FUNCNAME[0]}"

  local old new verb

  old=$(usageArgumentEmptyString "$usage" "oldSuffix" "${1-}") && shift || return $?
  new=$(usageArgumentEmptyString "$usage" "newSuffix" "${1-}") && shift || return $?
  verb="${1-}" && shift || :

  for i in "$@"; do
    if [ -f "$i$old" ]; then
      __catchEnvironment "$usage" mv "$i$old" "$i$new" || return $?
      __catchEnvironment "$usage" statusMessage --last decorate info "$verb $(decorate file "$i$old") -> $(decorate file "$i$new")" || return $?
    fi
  done
}
_renameFiles() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    [ -f "$argument" ] || __throwArgument "$usage" "$argument is not a file" || return $?
    printf "%d\n" "$(date -r "$argument" +%s)"
    shift || __throwArgument "$usage" "shift" || return $?
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
  local now_

  now_="$(__catchEnvironment "$usage" date +%s)" || return $?
  local __count=$#
  while [ $# -gt 0 ]; do
    local argument="$(usageArgumentFile "$usage" "argument #$((__count - $# + 1))" "${1-}")" || return $?
    __catchEnvironment "$usage" printf "%d\n" "$((now_ - $(modificationTime "$argument")))" || return $?
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
# Example: {fn} $myDir ! -path "*/.*/*"
# Output: 1705347087 bin/build/tools.sh
# Output: 1704312758 bin/build/deprecated.sh
# Output: 1705442647 bin/build/build.json
#
fileModificationTimes() {
  local usage="_${FUNCNAME[0]}"
  local directory

  directory="$1"
  [ -d "$directory" ] || __throwArgument "$usage" "Not a directory $(decorate code "$directory")" || return $?
  shift || :
  # See: platform
  __fileModificationTimes "$directory" "$@"
}
_fileModificationTimes() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List the most recently modified file in a directory
# Usage: {fn} directory [ findArgs ... ]
# Argument: directory - Required. Directory. Must exists - directory to list.
# Argument: findArgs - Optional additional arguments to modify the find query
mostRecentlyModifiedFile() {
  local usage="_${FUNCNAME[0]}"
  directory="$1"
  [ -d "$directory" ] || __throwArgument "$usage" "Not a directory $(decorate code "$directory")" || return $?
  shift || :
  fileModificationTimes "$directory" -type f "$@" | sort -r | head -1 | cut -f2- -d" "
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
  [ -d "$directory" ] || __throwArgument "$usage" "Not a directory $(decorate code "$directory")" || return $?
  shift || :
  fileModificationTimes "$directory" -type f "$@" | sort -r | head -1 | cut -f1 -d" "
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

  local gamutTime="" theFile=""

  local __saved=("$@")
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1)) tempTime
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    [ -f "$argument" ] || __throwArgument "$usage" "Not a file: $(decorate code "$argument"): #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
    tempTime=$(modificationTime "$argument") || __throwEnvironment "#$__index/$__count: modificationTime $argument: #$__index/$__count: $(decorate each code "${__saved[@]}")" || return $?
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

  timestamp=$(modificationTime "$1") || __throwArgument "$usage" modificationTime "$1" || return $?
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

  timestamp=$(modifiedSeconds "$1") || __throwArgument "$usage" modifiedSeconds "$1" || return $?
  printf %d "$((timestamp / 86400))"
}
_modifiedDays() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL _realPath 12

# Usage: realPath argument
# Argument: file ... - Required. File. One or more files to `realpath`.
# Requires: whichExists realpath
realPath() {
  [ -e "$1" ] || _argument "Not a file: $1" || return $?
  if whichExists realpath; then
    realpath "$@"
  else
    readlink -f -n "$@"
  fi
}

# Usage: {fn} path ...
# Argument: path ... - Required. File. One or more paths to simplify
# Normalizes segments of `/./` and `/../` in a path without using `realPath`
# Removes dot and dot-dot paths from a path correctly
simplifyPath() {
  local path elements=() segment dot=0 result IFS="/"
  while [ $# -gt 0 ]; do
    path="$1"
    path="${path#"./"}"
    path="${path//\/\.\///}"
    read -r -a elements <<<"$path" || :
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
    printf "%s\n" "${result[*]}"
    shift
  done
}

# Outputs value of virtual memory allocated for a process, value is in kilobytes
# Usage: {fn} file
# Argument: file - Required. File to get size of.
# Exit Code: 0 - Success
# Exit Code: 1 - Environment error
fileSize() {
  local size opts
  local usage="_${FUNCNAME[0]}"

  export OSTYPE
  __catchEnvironment "$usage" buildEnvironmentLoad OSTYPE || return $?

  case "$(lowercase "${OSTYPE}")" in
    *darwin*) opts=("-f" "%z") ;;
    *) opts=('-c%s') ;;
  esac
  while [ $# -gt 0 ]; do
    size="$(stat "${opts[@]}" "$1")" || __throwEnvironment "$usage" "Unable to stat" "${opts[@]}" "$1" || return $?
    printf "%s\n" "$size"
    shift || __throwArgument "$usage" shift || return $?
  done
}
_fileSize() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} [ thing ]
# Better type handling of shell objects
#
# Outputs one of `type` output or enhancements:
# - `builtin`. `function`, `alias`, `file`
# - `link-directory`, `link-file`, `directory`, `integer`, `unknown`
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
# See: mv
renameLink() {
  local usage="_${FUNCNAME[0]}"

  local from="" to=""

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
      *)
        if [ -z "$from" ]; then
          from=$(usageArgumentLink "$usage" "from $(betterType "$1")" "$1") || return $?
        elif [ -z "$to" ]; then
          to=$(usageArgumentString "$usage" "to $(betterType "$1")" "$1") || return $?
        else
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$from" ] || __throwArgument "$usage" "Need a \"from\" argument" || return $?
  [ -n "$to" ] || __throwArgument "$usage" "Need a \"to\" argument" || return $?
  __renameLink "$from" "$to"
}
_renameLink() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  # _IDENTICAL_ usageDocument 1
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
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_fileMatchesHelper() {
  local usage="$1" success="$2" && shift 2

  local file patterns=() found=false exceptions=() clean fileList foundLines

  [ $# -gt 0 ] || return 0
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
  [ "${#patterns[@]}" -gt 0 ] || __catchArgument "$usage" "No patterns" || return $?
  [ $# -gt 0 ] || __catchArgument "$usage" "no exceptions or files" || return $?
  while [ $# -gt 0 ]; do [ "$1" = "--" ] && shift && break || exceptions+=("$1") && shift; done
  [ $# -gt 0 ] || __catchArgument "$usage" "no files" || return $?
  fileList=$(fileTemporaryName "$usage") || return $?
  foundLines="$fileList.found"
  clean=("$fileList" "$foundLines")
  if [ "$1" = "-" ]; then
    __catchEnvironment "$usage" cat >"$fileList" || _clean $? "${clean[@]}" || return $?
  fi
  for pattern in "${patterns[@]}"; do
    if [ "$1" != "-" ]; then
      __catchEnvironment "$usage" printf "%s\n" "$@" >"$fileList" || _clean $? "${clean[@]}" || return $?
    fi
    while read -r file; do
      if [ "${#exceptions[@]}" -gt 0 ] && stringContains "$file" "${exceptions[@]}"; then
        continue
      fi
      if $success; then
        if grep -n -e "$pattern" "$file" >"$foundLines"; then
          if ! isEmptyFile "$foundLines"; then
            found=true
            wrapLines "$file:" "" <"$foundLines"
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
  _clean 0 "$fileList" || return $?
  $found
}

# Is this an empty (zero-sized) file?
# Exit code: 0 - if all files passed in are empty files
# Exit code: 1 - if any files passed in are non-empty files
# Argument: file - File. Optional. One or more files, all of which must be empty.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
isEmptyFile() {
  local usage="_${FUNCNAME[0]}"

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
      *)
        argument="$(usageArgumentFile "$usage" "file" "$1")" || return $?
        [ ! -s "$argument" ] || return 1
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
}
_isEmptyFile() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} directory
_directoryGamutFile() {
  local gamutModified="" remain comparer="$1" gamut="" directory="${2-.}" && shift 2
  while read -r modified file; do
    isPositiveInteger "$modified" || __throwEnvironment "$usage" "__fileModificationTimes output a non-integer: \"$modified\" \"$file\"" || return $?
    # shellcheck disable=SC1073 disable=SC1072 disable=SC1009
    if [ -z "$gamutModified" ] || [ "$modified" "$comparer" "$gamutModified" ]; then
      gamutModified="$modified"
      gamut="$file"
    fi
  done < <(__fileModificationTimes "$directory" -type f ! -path "*/.*/*" "$@")
  [ -n "$gamut" ] || return 1
  printf "%s\n" "$gamut"
}

# Argument: --find findArgs ... -- - Optional. ArgumentsDoubleDashDelimited. Arguments delimited by a double-dash (or end of argument list)
_directoryGamutFileWrapper() {
  local usage="$1" comparator="$2" && shift 2
  local directory="" findArgs=()

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

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
        [ -z "$directory" ] || __throwArgument "$usage" "Directory already supplied" || return $?
        directory="$(usageArgumentDirectory "$usage" "$argument" "${1-}")" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  [ -n "$directory" ] || __throwArgument "$usage" "directory is required" || return $?
  if ! _directoryGamutFile "$comparator" "$directory" "${findArgs[@]+"${findArgs[@]}"}"; then
    __throwEnvironment "$usage" "No files in $(decorate file "$directory") ("${findArgs[*]-}")" || return $?
  fi
}

# Find the oldest file in a directory
# Argument: directory - Directory. Required. Directory to search for the oldest file.
# Argument: --find findArgs ... -- - Optional. Arguments. Arguments delimited by a double-dash (or end of argument list)
directoryOldestFile() {
  _directoryGamutFileWrapper "_${FUNCNAME[0]}" "-lt" "$@"
}
_directoryOldestFile() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Find the newest file in a directory
# Argument: directory - Directory. Required. Directory to search for the newest file.
# Argument: --find findArgs ... -- - Optional. Arguments. Arguments delimited by a double-dash (or end of argument list)
directoryNewestFile() {
  _directoryGamutFileWrapper "_${FUNCNAME[0]}" "-gt" "$@"
}
_directoryNewestFile() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Create a link
#
# Argument: target - Exists. File. Source file name or path.
# Argument: linkName - String. Required. Link short name, created next to `target`.
linkCreate() {
  local usage="_${FUNCNAME[0]}"

  local target="" path="" linkName="" backupFlag=true

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
      --no-backup)
        backupFlag=false
        ;;
      *)
        if [ -z "$target" ]; then
          target=$(usageArgumentExists "$usage" "target" "$argument") || return $?
          path=$(__catchEnvironment "$usage" dirname "$target") || return $?
        elif [ -z "$linkName" ]; then
          linkName=$(usageArgumentString "$usage" "linkName" "$argument") || return $?
        else
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$target" ] || __throwArgument "$usage" "Missing target" || return $?
  [ -n "$linkName" ] || __throwArgument "$usage" "Missing linkName" || return $?

  [ ! -L "$target" ] || __throwArgument "$usage" "Can not link to another link ($(decorate file "$target") is a link)" || return $?

  target=$(__catchEnvironment "$usage" basename "$target") || return $?

  [ -e "$path/$target" ] || __throwEnvironment "$usage" "$path/$target must be a file or directory" || return $?

  local link="$path/$linkName"
  if [ ! -L "$link" ]; then
    if [ -e "$link" ]; then
      __throwEnvironment "$usage" "$(decorate file "$link") exists and was not a link $(decorate code "$(betterType "$link")")" || :
      __catchEnvironment "$usage" mv "$link" "$link.createLink.$$.backup" || return $?
      clean+=("$link.$$.backup")
    fi
  else
    local actual
    actual=$(__catchEnvironment "$usage" readlink "$link") || return $?
    if [ "$actual" = "$target" ]; then
      return 0
    fi
    __catchEnvironment "$usage" mv "$link" "$link.createLink.$$.badLink" || return $?
    clean+=("$link.$$.badLink")
  fi
  __catchEnvironment "$usage" muzzle pushd "$path" || return $?
  __catchEnvironment "$usage" ln -s "$target" "$linkName" || _undo $? muzzle popd || return $?
  __catchEnvironment "$usage" muzzle popd || return $?
  $backupFlag || __catchEnvironment "$usage" rm -rf "${clean[@]}" || return $?
}
_linkCreate() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL fileTemporaryName 19

# Generate a temporary file name using mktemp, and fail using a function
# Argument: handler - Function. Required. Function to call if mktemp fails. Function Type: _return
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: ... - Optional. Arguments. Any additional arguments are passed through to mktemp.
# Requires: __help __catchEnvironment mktemp usageDocument
fileTemporaryName() {
  local handler="_${FUNCNAME[0]}"
  __help "$handler" "$@" || return 0
  handler="$1" && shift
  __catchEnvironment "$handler" mktemp "$@" || return $?
}
_fileTemporaryName() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# <-- END of IDENTICAL fileTemporaryName
