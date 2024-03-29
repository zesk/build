#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#
# Docs: o ./docs/_templates/tools/os.md
# Test: o ./test/tools/os-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

#
# Usage: {fn} source target
#
# Copy directory over another sort-of-atomically
#
directoryClobber() {
  local source target targetPath targetName sourceStage targetBackup

  if ! source=$(usageArgumentDirectory "_${FUNCNAME[0]}" source "$1"); then
    return $?
  fi
  shift || :
  target="${1-}"
  if ! targetPath="$(dirname "$target")" || [ ! -d "$targetPath" ]; then
    _directoryClobber "$errorArgument" "$targetPath parent directory does not exist" || return $?
  fi
  if ! targetName="$(basename "$target")"; then
    _directoryClobber "$errorArgument" "basename $target failed" || return $?
  fi
  sourceStage="$targetPath/.NEW.$$.$targetName"
  targetBackup="$targetPath/.OLD.$$.$targetName"
  if ! mv -f "$source" "$sourceStage"; then
    _directoryClobber "$errorEnvironment" "mv -f $source $sourceStage failed" || return $?
  fi
  if ! mv -f "$target" "$targetBackup"; then
    _directoryClobber "$errorEnvironment" "mv -f $target" "$targetBackup failed" || return $?
  fi
  if ! mv -f "$sourceStage" "$target"; then
    if ! mv -f "$targetBackup" "$target"; then
      consoleError "Unable to revert $targetBackup -> $target" || :
      return "$errorEnvironment"
    fi
    if ! mv -f "$sourceStage" "$source"; then
      consoleError "Unable to revert $sourceStage -> $source" || :
      return "$errorEnvironment"
    fi
    _directoryClobber "$errorEnvironment" "Clobber failed" || return $?
  fi
  rm -rf "$targetBackup" || _directoryClobber "$errorEnvironment" "Unable to delete $targetBackup" || return $?
}
_directoryClobber() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Path to cache directory for build system.
#
# Defaults to `$HOME/.build` unless `$HOME` is not a directory.
#
# Appends any passed in arguments as path segments.
#
# Example:     logFile=$({fn} test.log)
# Usage: {fn} [ pathSegment ... ]
# Argument: pathSegment - One or more directory or file path, concatenated as path segments using `/`
#
buildCacheDirectory() {
  local suffix
  # shellcheck source=/dev/null
  if ! buildEnvironmentLoad BUILD_CACHE; then
    printf "%s\n" "BUILD_CACHE failed" 1>&2
    return 1
  fi
  suffix="$(printf "%s/" "$@")"
  suffix="${suffix%/}"
  suffix="$(printf "%s/%s" "${BUILD_CACHE%/}" "${suffix%/}")"
  printf "%s\n" "${suffix%/}"
}
_buildCacheDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Load on or more environment settings from bin/build/env
#
# Usage: {fn} [ envName ... ]
# Argument: envName - The environment name to load
#
buildEnvironmentLoad() {
  local env file found

  if ! export BUILD_HOME "${@+$@}"; then
    _buildEnvironmentLoad "$errorEnvironment" "Exporting BUILD_HOME $* failed" || return $?
  fi
  if [ -z "${BUILD_HOME-}" ]; then
    # shellcheck source=/dev/null
    if ! source "$(dirname "${BASH_SOURCE[0]}")/../env/BUILD_HOME.sh"; then
      _buildEnvironmentLoad "$errorEnvironment" "Loading BUILD_HOME $* failed" || return $?
    fi
    if [ -z "${BUILD_HOME-}" ]; then
      _buildEnvironmentLoad "$errorEnvironment" "BUILD_HOME STILL blank" || return $?
    fi
  fi
  for env in "$@"; do
    found=false
    for file in "${BUILD_HOME-}/bin/build/env/$env.sh" "${BUILD_HOME-}/bin/env/$env.sh"; do
      if [ -f "$file" ]; then
        if ! $found && ! export "${env?}"; then
          _buildEnvironmentLoad "$errorArgument" "export $env failed" || return $?
        fi
        found=true
        set -a
        # shellcheck source=/dev/null
        if ! source "$file"; then
          set +a
          _buildEnvironmentLoad "$errorEnvironment" "Loading $file failed" || return $?
        fi
        set +a
      fi
    done
    if ! $found; then
      _buildEnvironmentLoad "$errorEnvironment" "Missing $file" || return $?
    fi
  done
}
_buildEnvironmentLoad() {
  local exitCode

  exitCode="${1-}"
  shift || :
  printf "bin/build/env ERROR: %s\n" "$@" 1>&2
  debuggingStack
  return "$exitCode"
}

#
#
# Usage: {fn} name
# Argument: name - The log file name
# Argument: --no-create - Optional. Do not require creation of the directory where the log file will appear.
#
buildQuietLog() {
  local logFile flagMake=1
  while [ $# -gt 0 ]; do
    case $1 in
      --no-create)
        flagMake=
        ;;
      *)
        if [ -z "$1" ]; then
          consoleError "buildQuietLog requires a name parameter" 1>&2
          return 1
        fi
        logFile="$(buildCacheDirectory "$1.log")"
        if test "$flagMake" && ! requireFileDirectory "$logFile"; then
          return $?
        fi
        printf %s "$logFile"
        ;;
    esac
    shift
  done
}

#
# Given a list of files, ensure their parent directories exist
#
# Creates the directories for all files passed in.
#
# Usage: {fn} file1 file2 ...
# Example:     logFile=./.build/$me.log
# Example:     {fn} "$logFile"
#
requireFileDirectory() {
  local rs name
  while [ $# -gt 0 ]; do
    name="$(dirname "$1")"
    if [ ! -d "$name" ] && ! mkdir -p "$name"; then
      rs=$?
      consoleError "Unable to create directory \"$name\"" 1>&2
      return "$rs"
    fi
    shift
  done
}

#
# Does the file's directory exist?
#
fileDirectoryExists() {
  local path
  [ $# -eq 0 ] && return $errorArgument
  while [ $# -gt 0 ]; do
    if ! path=$(dirname "$1"); then
      return "$errorEnvironment"
    fi
    if [ ! -d "$path" ]; then
      return "$errorEnvironment"
    fi
    shift || return "$errorEnvironment"
  done
}

#
# Given a list of files, ensure their parent directories exist
#
# Creates the directories for all files passed in.
#
# Usage: {fn} dir1 [ dir2 ... ]
# Argument: dir1 - One or more directories to create
# Example:     {fn} "$cachePath"
#
requireDirectory() {
  local name
  while [ $# -gt 0 ]; do
    name="$1"
    if [ ! -d "$name" ] && ! mkdir -p "$name"; then
      consoleError "Unable to create directory \"$name\"" 1>&2
      return "$errorEnvironment"
    fi
    printf "%s\n" "$name"
    shift
  done
}

#
# Usage: {fn} count binary [ args ... ]
# Argument: count - The number of times to run the binary
# Argument: binary - The binary to run
# Argument: args ... - Any arguments to pass to the binary each run
# Exit Code: 0 - success
# Exit Code: 2 - `count` is not an unsigned number
# Exit Code: Any - If `binary` fails, the exit code is returned
# Summary: Run a binary count times
#
runCount() {
  local n
  n="$1"
  if ! isUnsignedInteger "$n"; then
    return "$errorArgument"
  fi
  shift
  while [ "$n" -gt 0 ]; do
    if ! "$@"; then
      return $?
    fi
    n=$((n - 1))
  done
}

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

#
# Platform agnostic tar cfz which ignores owner and attributes
#
# `tar` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (`.tgz` or `.tar.gz`) with user and group set to 0 and no extended attributes attached to the files.
# Short description: Platform agnostic tar create which keeps user and group as user 0
# Usage: createTarFile target files
# Argument: target - The tar.gz file to create
# Argument: files - A list of files to include in the tar file
#
createTarFile() {
  local target="${1-}"

  # -h means follow symlinks
  shift || return "$errorArgument"
  if tar --version | grep -q GNU; then
    # GNU
    # > tar --version
    # tar (GNU tar) 1.34
    # ...
    tar -czf "$target" --owner=0 --group=0 --no-xattrs -h "$@"
  else
    # BSD
    # > tar --version
    # bsdtar 3.5.3 - libarchive 3.5.3 zlib/1.2.11 liblzma/5.0.5 bz2lib/1.0.8
    tar -czf "$target" --uid 0 --gid 0 --no-acls --no-fflags --no-xattrs -h "$@"
  fi
}

#
# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
# Returns the list of defined environment variables exported in the current bash context.
#
# Summary: Fetch a list of environment variable names
# Usage: environmentVariables
# Output: Environment variable names, one per line.
# Example:     for f in $(environmentVariables); do
# Example:     echo "$f"
# Example:     done
#
environmentVariables() {
  # IDENTICAL environmentVariables 1
  declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}

#
# Reverses a pipe's input lines to output using an awk trick. Do not recommend on big files.
#
# Summary: Reverse output lines
# Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt
# Credits: Eric Pement
#
reverseFileLines() {
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}

# Makes all `*.sh` files executable
#
# Usage: {fn} [ findArguments ... ]
# Argument: findArguments - Optional. Add arguments to exclude files or paths.
# Environment: Works from the current directory
# See: makeShellFilesExecutable
# fn: chmod-sh.sh
makeShellFilesExecutable() {
  # IDENTICAL makeShellFilesExecutable 1
  find . -name '*.sh' -type f ! -path '*/.*' "$@" -print0 | xargs -0 chmod -v +x
}

# Fetch the modification time of a file as a timestamp
#
# Usage: modificationTime filename0 [ filename1 ... ]
# Exit Code: 2 - If file does not exist
# Exit Code: 0 - If file exists and modification times are output, one per line
# Example:     modificationTime ~/.bash_profile
#
modificationTime() {
  while [ $# -gt 0 ]; do
    if [ ! -f "$1" ]; then
      return "$errorArgument"
    fi
    printf "%d\n" "$(date -r "$1" +%s)"
    shift
  done
}

# Fetch the modification time in seconds from now of a file as a timestamp
#
# Usage: modificationTime filename0 [ filename1 ... ]
# Exit Code: 2 - If file does not exist
# Exit Code: 0 - If file exists and modification times are output, one per line
# Example:     modificationTime ~/.bash_profile
#
modificationSeconds() {
  local now

  now="$(date +%s)"
  while [ $# -gt 0 ]; do
    if [ ! -f "$1" ]; then
      return "$errorArgument"
    fi
    printf "%d\n" "$((now - "$(modificationTime "$1")"))"
    shift
  done
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
  local directory

  directory="$1"
  if [ ! -d "$directory" ]; then
    printf "%s: %s" "$(consoleError "Not a directory")" "$(consoleCode "$directory")" 1>&2
    return $errorArgument
  fi
  shift
  if [ "$(uname -s)" = "Darwin" ]; then
    find "$directory" -type f "$@" -exec stat -f '%m %N' {} \;
  else
    find "$directory" -type f "$@" -exec stat --format='%Y %n' {} \;
  fi
}

# List the most recently modified file in a directory
# Usage: {fn} directory [ findArgs ... ]
# Argument: directory - Required. Directory. Must exists - directory to list.
# Argument: findArgs - Optional additional arguments to modify the find query
mostRecentlyModifiedFile() {
  directory="$1"
  if [ ! -d "$directory" ]; then
    printf "%s: %s" "$(consoleError "Not a directory")" "$(consoleCode "$directory")" 1>&2
    return $errorArgument
  fi
  shift
  listFileModificationTimes "$directory" -type f "$@" | sort -r | head -1 | cut -f2- -d" "
}

# List the most recently modified file in a directory
# Usage: {fn} directory [ findArgs ... ]
# Argument: directory - Required. Directory. Must exists - directory to list.
# Argument: findArgs - Optional additional arguments to modify the find query
mostRecentlyModifiedTimestamp() {
  directory="$1"
  if [ ! -d "$directory" ]; then
    printf "%s: %s" "$(consoleError "Not a directory")" "$(consoleCode "$directory")" 1>&2
    return $errorArgument
  fi
  shift
  listFileModificationTimes "$directory" -type f "$@" | sort -r | head -1 | cut -f1 -d" "
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
# Return the oldest file in the list.
#
# Usage: {fn} file0 [ file1 ... ]
# Argument: file0 - One or more files to examine
#
oldestFile() {
  local tempTime oldestTime theFile=

  while [ $# -gt 0 ]; do
    if [ ! -f "$1" ]; then
      return "$errorArgument"
    fi
    tempTime=$(modificationTime "$1")
    if [ -z "$theFile" ] || [ "$tempTime" -lt "$oldestTime" ]; then
      theFile="$1"
      oldestTime="$tempTime"
    fi
    shift
  done
  printf "%s" "$theFile"
}

#
# Return the newest file in the list
#
# Usage: {fn} file0 [ file1 ... ]
# Argument: file0 - One or more files to examine
#
newestFile() {
  local tempTime newestTime theFile=

  while [ $# -gt 0 ]; do
    if [ ! -f "$1" ]; then
      return "$errorArgument"
    fi
    tempTime=$(modificationTime "$1")
    if [ -z "$theFile" ] || [ "$tempTime" -gt "$newestTime" ]; then
      theFile="$1"
      newestTime="$tempTime"
    fi
    shift
  done
  printf "%s\n" "$theFile"
}

#
# Prints seconds since modified
# Usage: {fn} file
# Exit Code: 0 - Success
# Exit Code: 2 - Can not get modification time
#
modifiedSeconds() {
  local ts

  if ! ts=$(modificationTime "$1"); then
    return $errorArgument
  fi
  printf %d "$(($(date +%s) - ts))"
}

#
# Prints days (integer) since modified
#
# Exit Code: 0 - Success
# Exit Code: 2 - Can not get modification time
#
modifiedDays() {
  local ts

  if ! ts=$(modifiedSeconds "$1"); then
    return $errorArgument
  fi
  printf %d "$((ts / 86400))"
}

#
# Usage: {fn} pathValue separator [ --first | --last | path ]
# Argument: pathValue - Required. Path value to modify.
# Argument: separator - Required. Separator string for path values (typically `:`)
# Argument: --first - Optional. Place any paths after this flag first in the list
# Argument: --last - Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `pathValue`
#
pathAppend() {
  local pathValue="$1" s="$2" exitCode=0 firstFlag=

  shift
  shift
  while [ $# -gt 0 ]; do
    case $1 in
      --first)
        firstFlag=1
        ;;
      --last)
        firstFlag=
        ;;
      *)
        if [ "$(stringOffset "$1$s" "$s$s$pathValue$s")" -lt 0 ]; then
          if [ ! -d "$1" ]; then
            exitCode=2
          elif [ -z "$pathValue" ]; then
            pathValue="$1"
          elif test "$firstFlag"; then
            pathValue="$1$s$pathValue"
          else
            pathValue="$pathValue$s$1"
          fi
        else
          exitCode=1
        fi
        ;;
    esac
    shift
  done
  printf %s "$pathValue"
  return "$exitCode"
}

#
# Usage: {fn} [ --first | --last | path ] ...
# Argument: --first - Optional. Place any paths after this flag first in the list
# Argument: --last - Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `MANPATH` environment
#
manPathConfigure() {
  local tempPath
  # shellcheck source=/dev/null
  source "$(dirname "${BASH_SOURCE[0]}")/../env/MANPATH.sh"
  if tempPath="$(pathAppend "$MANPATH" ':' "$@")"; then
    MANPATH="$tempPath"
    return 0
  fi
  return $?
}

#
# Usage: {fn} [ --first | --last | path ] ...
# Argument: --first - Optional. Place any paths after this flag first in the list
# Argument: --last - Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `PATH` environment
pathConfigure() {
  local tempPath
  # shellcheck source=/dev/null
  source "$(dirname "${BASH_SOURCE[0]}")/../env/PATH.sh"
  if tempPath="$(pathAppend "$PATH" ':' "$@")"; then
    PATH="$tempPath"
    return 0
  fi
  return $?
}

#
# Cleans the path and removes non-directory entries and duplicates
#
# Maintains ordering.
#
# Usage: pathCleanDuplicates
#
pathCleanDuplicates() {
  local tempPath elements delta removed=() s=':'

  export PATH
  IFS=$s read -r -a elements < <(printf %s "$PATH")
  delta="${#elements[@]}"
  tempPath=
  for p in "${elements[@]}"; do
    if [ ! -d "$p" ]; then
      removed+=("$(consoleError "Not a directory: $p")")
    elif ! tempPath=$(pathAppend "$tempPath" "$s" "$p"); then
      removed+=("$(consoleWarning "Duplicate: $p")")
    fi
  done
  IFS=$s read -r -a elements < <(printf %s "$tempPath")
  delta=$((delta - ${#elements[@]}))
  if [ "$delta" -gt 0 ]; then
    consoleSuccess "Removed $delta path $(plural "$delta" element elements)"
    printf "    %s\n" "${removed[@]}"
  fi
  echo "NEW PATH IS $tempPath"
  # PATH="$tempPath"
}

realPath() {
  #
  # realpath is not present always
  #
  if ! which realpath >/dev/null; then
    readlink -f -n "$@"
  else
    realpath "$@"
  fi
}

#
# Format something neatly as JSON
# Usage: JSON < inputFile > outputFile
# Depend: python
JSON() {
  python -c "import sys, json; print(json.dumps(json.load(sys.stdin), indent=4))"
}

#
# Usage: {fn} file ...
# Argument: file - File to get the owner for
# Outputs the file owner for each file passed on the command line
# Exit code: 0 - Success
# Exit code: 1 - Unable to access file
# Depends: ls
_fileListColumn() {
  local usageFunction column result
  usageFunction="$1"
  shift || :
  column="$1"
  shift || :
  while [ $# -gt 0 ]; do
    # shellcheck disable=SC2012
    if ! result="$(ls -ld "$1" | awk '{ print $'"$column"' }')"; then
      "$usageFunction" "$errorEnvironment" "Running ls -ld \"$1\"" || return $?
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
  _fileListColumn "_${FUNCNAME[0]}" 3 "$@"
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
  _fileListColumn "_${FUNCNAME[0]}" 4 "$@"
}
_fileGroup() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Outputs value of resident memory used by a process, value is in kilobytes
#
# Usage: {fn} pid
# Argument: pid - Process ID of running process
# Example:     > {fn} 23
# Output: 423
# Exit Code: 0 - Success
# Exit Code: 2 - Argument error
processMemoryUsage() {
  local pid
  while [ $# -gt 0 ]; do
    pid="$1"
    if ! isInteger "$pid"; then
      _processMemoryUsage "$errorArgument" "Not an integer"
      return $?
    fi
    # ps -o '%cpu %mem pid vsz rss tsiz %mem comm' -p "$pid" | tail -n 1
    if ! value="$(ps -o rss -p "$pid" | tail -n 1 | trimSpace)"; then
      _processMemoryUsage "$errorEnvironment" "Failed to get process status for $pid" || return $?
    fi
    if ! isInteger "$value"; then
      _processMemoryUsage "$errorEnvironment" "Bad memory value for $pid: $value" || return $?
    fi
    printf %d $((value * 1))
    shift
  done
}
_processMemoryUsage() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Outputs value of virtual memory allocated for a process, value is in kilobytes
#
# Usage: {fn} pid
# Argument: pid - Process ID of running process
# Example:     {fn} 23
# Output: 423
# Exit Code: 0 - Success
# Exit Code: 2 - Argument error
processVirtualMemoryAllocation() {
  local pid value
  while [ $# -gt 0 ]; do
    pid="$1"
    if ! isInteger "$pid"; then
      _processVirtualMemoryAllocation "$errorArgument" "Not an integer"
      return $?
    fi
    value="$(ps -o vsz -p "$pid" | tail -n 1 | trimSpace)"
    if ! isInteger "$value"; then
      _processVirtualMemoryAllocation "$errorEnvironment" "ps returned non-integer: \"$(consoleCode "$value")\"" || return $?
    fi
    printf %d $((value * 1))
    shift
  done
}
_processVirtualMemoryAllocation() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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

  # shellcheck source=/dev/null
  if ! . "$(dirname "${BASH_SOURCE[0]}")/../env/OSTYPE.sh"; then
    _fileSize "$errorEnvironment" "No OSTYPE environment file" || return $?
  fi

  case "$(lowercase "${OSTYPE}")" in
    *darwin*) opts=("-f" "%z") ;;
    *) opts=('-c%s') ;;
  esac
  while [ $# -gt 0 ]; do
    if ! size="$(stat "${opts[@]}" "$1")"; then
      _fileSize "$errorEnvironment" "Unable to stat ${opts[*]} $1"
    fi
    printf "%s\n" "$size" || :
    shift || :
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
# Usage: {fn} {from} {to}
#
# Uses mv and clobbers always
#
renameLink() {
  if mv --version >/dev/null; then
    # gnu version supports -T
    mv -fT "$@"
  else
    mv -fh "$@"
  fi
}

# Hard-coded services for:
#
# - `ssh` -> 22
# - `http`-> 80
# - `https`-> 80
# - `postgres`-> 5432
# - `mariadb`-> 3306
# - `mysql`-> 3306
#
# Backup when `/etc/services` does not exist.
#
# Usage: {fn} service [ ... ]
# Argument: service - A unix service typically found in `/etc/services`
# Output: Port number of associated service (integer) one per line
# Exit Code: 1 - service not found
# Exit Code: 0 - service found and output is an integer
# See: serviceToPort
#
serviceToStandardPort() {
  local port
  if [ $# -eq 0 ]; then
    return $errorArgument
  fi
  while [ $# -gt 0 ]; do
    case "$(trimSpace "${1-}")" in
      ssh) port=22 ;;
      http) port=80 ;;
      https) port=443 ;;
      mariadb | mysql) port=3306 ;;
      postgres) port=5432 ;;
      *) return $errorEnvironment ;;
    esac
    printf "%d\n" "$port"
    shift || return "$errorArgument"
  done
}

# Get the port number associated with a service
#
# Usage: {fn} service [ ... ]
# Argument: service - A unix service typically found in `/etc/services`
# Output: Port number of associated service (integer) one per line
# Exit Code: 1 - service not found
# Exit Code: 2 - bad argument or invalid port
# Exit Code: 0 - service found and output is an integer
#
serviceToPort() {
  local port servicesFile service

  servicesFile=/etc/services
  if [ ! -f "$servicesFile" ]; then
    serviceToStandardPort "$@"
  else
    if [ $# -eq 0 ]; then
      _serviceToPort "$errorArgument" "Require at least one service" || return $?
    fi
    while [ $# -gt 0 ]; do
      service="$(trimSpace "${1-}")"
      if port="$(grep /tcp "$servicesFile" | grep "^$service\s" | awk '{ print $2 }' | cut -d / -f 1)"; then
        if ! isInteger "$port"; then
          _serviceToPort "$errorEnvironment" "Port found in $servicesFile is not an integer: $port" || return $?
        fi
      else
        if ! port="$(serviceToStandardPort "$service")"; then
          return $errorEnvironment
        fi
      fi
      printf "%d\n" "$port"
      shift || _serviceToPort "$errorArgument" "shift failed" || return $?
    done
  fi
}
_serviceToPort() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
