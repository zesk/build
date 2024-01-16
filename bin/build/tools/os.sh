#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#
# Docs: o ./docs/_templates/tools/os.md
# Test: o ./bin/tests/os-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

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
  export HOME
  local suffix useDir="${HOME-./}"
  if [ ! -d "$useDir" ]; then
    useDir="./"
  fi
  suffix="$(printf "%s/" "$@")"
  printf "%s/%s/%s" "${useDir%%/}" ".build" "${suffix%%/}"
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
        ;;
    esac
    shift
  done
  if test "$flagMake" && ! requireFileDirectory "$logFile"; then
    return $?
  fi
  printf %s "$logFile"
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
  local target=$1

  shift
  if tar --version | grep -q GNU; then
    # GNU
    # > tar --version
    # tar (GNU tar) 1.34
    # ...
    tar czf "$target" --owner=0 --group=0 --no-xattrs "$@"
  else
    # BSD
    # > tar --version
    # bsdtar 3.5.3 - libarchive 3.5.3 zlib/1.2.11 liblzma/5.0.5 bz2lib/1.0.8
    tar czf "$target" --uid 0 --gid 0 --no-xattrs "$@"
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
  find . -name '*.sh' ! -path '*/.*' "$@" -print0 | xargs -0 chmod -v +x
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
  printf "%s" "$theFile"
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

  export MANPATH
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

  export PATH
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
#
fileOwner() {
  local uid
  while [ $# -gt 0 ]; do
    # shellcheck disable=SC2012
    if ! uid="$(ls -ld "$1" | awk '{ print $3 }')"; then
      return "$errorEnvironment"
    fi
    printf "%s\n" "$uid"
    shift
  done
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
      _processMemoryUsageUsage "$errorArgument" "Not an integer"
      return $?
    fi
    # ps -o '%cpu %mem pid vsz rss tsiz %mem comm' -p "$pid" | tail -n 1
    printf %d $(("$(ps -o rss -p "$pid" | tail -n 1)" * 1))
    shift
  done
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
  local pid
  while [ $# -gt 0 ]; do
    pid="$1"
    if ! isInteger "$pid"; then
      _processVirtualMemoryAllocationUsage "$errorArgument" "Not an integer"
      return $?
    fi
    printf %d $(("$(ps -o vsz -p "$pid" | tail -n 1)" * 1))
    shift
  done
}

_processVirtualMemoryAllocationUsage() {
  usageDocument "bin/build/tools/$(basename "${BASH_SOURCE[0]}")" processMemoryUsage "$@"
}
