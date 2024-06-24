#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#
# Docs: o ./docs/_templates/tools/os.md
# Test: o ./test/tools/os-tests.sh

#
# Usage: {fn} source target
#
# Copy directory over another sort-of-atomically
#
directoryClobber() {
  local usage="_${FUNCNAME[0]}"
  local source target targetPath targetName sourceStage targetBackup

  source=$(usageArgumentDirectory "$usage" source "$1") || return $?
  shift || :
  target="${1-}"
  targetPath="$(dirname "$target")" || __failArgument "$usage" "dirname $target" || return $?
  [ -d "$targetPath" ] || __failEnvironment "$usage" "$targetPath is not a directory" || return $?
  targetName="$(basename "$target")" || __failEnvironment basename "$target" || return $?
  sourceStage="$targetPath/.NEW.$$.$targetName"
  targetBackup="$targetPath/.OLD.$$.$targetName"
  __usageEnvironment "$usage" mv -f "$source" "$sourceStage" || return $?
  __usageEnvironment "$usage" mv -f "$target" "$targetBackup" || return $?
  if ! mv -f "$sourceStage" "$target"; then
    mv -f "$targetBackup" "$target" || __failEnvironment "$usage" "Unable to revert $targetBackup -> $target" || return $?
    mv -f "$sourceStage" "$source" || __failEnvironment "$usage" "Unable to revert $sourceStage -> $source" || return $?
    __failEnvironment "$usage" "Clobber failed" || return $?
  fi
  __usageEnvironment "$usage" rm -rf "$targetBackup" || return $?
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
  local usage="_${FUNCNAME[0]}"

  local suffix
  export BUILD_CACHE
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_CACHE || return $?

  suffix="$(printf "%s/" "$@")"
  suffix="${suffix%/}"
  suffix="$(printf "%s/%s" "${BUILD_CACHE%/}" "${suffix%/}")"
  printf "%s\n" "${suffix%/}"
}
_buildCacheDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Load one or more environment settings from bin/build/env or bin/env.
#
# Usage: {fn} [ envName ... ]
# Argument: envName - The environment name to load
#
# If BOTH files exist, both are sourced, so application environments should anticipate values
# created by default.
#
buildEnvironmentLoad() {
  local usage="_${FUNCNAME[0]}"
  local env file found

  export BUILD_HOME "${@+$@}" || __failEnvironment "$usage" export BUILD_HOME "${@+$@}" return $?
  if [ -z "${BUILD_HOME-}" ]; then
    __usageEnvironment "$usage" source "$(dirname "${BASH_SOURCE[0]}")/../env/BUILD_HOME.sh" || return $?
    [ -n "${BUILD_HOME-}" ] || __failEnvironment "$usage" "BUILD_HOME STILL blank" || return $?
  fi
  for env in "$@"; do
    found=false
    for file in "$BUILD_HOME/bin/build/env/$env.sh" "$BUILD_HOME/bin/env/$env.sh"; do
      if [ -x "$file" ]; then
        export "${env?}" || __failArgument "$usage" "export $env failed" || return $?
        found=true
        set -a || :
        # shellcheck source=/dev/null
        source "$file" || __failEnvironment "$usage" source "$file" return $?
        set +a || :
      fi
    done
    $found || __failEnvironment "$usage" "Missing $file" || return $?
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
  local argument logFile flagMake argument
  local usage="_${FUNCNAME[0]}"

  flagMake=true
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case $1 in
      --no-create)
        flagMake=false
        ;;
      *)
        logFile="$(buildCacheDirectory "$1.log")" || __failEnvironment "$usage" buildCacheDirectory "$1.log" || return $?
        ! "$flagMake" || __usageEnvironment "$usage" requireFileDirectory "$logFile" || return $?
        printf "%s\n" "$logFile"
        ;;
    esac
    shift || :
  done
}
_buildQuietLog() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  local name
  local argument usage="_${FUNCNAME[0]}"
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    name="$(dirname "$1")" || __failEnvironment "$usage" "dirname $argument" || return $?
    [ -d "$name" ] || mkdir -p "$name" || __failEnvironment "$usage" "Unable to create directory \"$(consoleCode "$name")\"" || return $?
    shift || __failArgument "$usage" shift || return $?
  done
}
_requireFileDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Does the file's directory exist?
#
# Usage: {fn} directory
# Argument: directory - Test if file directory exists (file does not have to exist)
fileDirectoryExists() {
  local path
  local argument usage="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || _argument "No arguments" || return $?
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    path=$(dirname "$argument") || __failEnvironment "$usage" "dirname $argument" || return $?
    [ -d "$path" ] || return 1
    shift || __failArgument "$usage" shift || return $?
  done
}
_fileDirectoryExists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  local usage="_${FUNCNAME[0]}"
  while [ $# -gt 0 ]; do
    name="$1"
    [ -n "$name" ] || __failArgument "$usage" "blank argument" || return $?
    [ -d "$name" ] || mkdir -p "$name" || __failEnvironment "$usage" "Unable to create directory \"$(consoleCode "$name")\"" || return $?
    printf "%s\n" "$name"
    shift || __failArgument "$usage" shift || return $?
  done
}
_requireDirectory() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  local usage="_${FUNCNAME[0]}"
  local argument index total

  total=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        if [ -z "$total" ]; then
          isUnsignedInteger "$argument" || __failArgument "$usage" "$argument must be a positive integer" || return $?
          total="$argument"
        else
          index=0
          while [ "$index" -lt "$total" ]; do
            index=$((index + 1))
            "$@" || __failEnvironment "$usage" "iteration #$index" "$@" return $?
          done
          return 0
        fi
        ;;
    esac
    shift || __failArgument "$usage" shift || return $?
  done

}
_runCount() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  local usage="_${FUNCNAME[0]}"
  local argument
  local target

  [ $# -gt 0 ] || __failArgument "$usage" "Need target and files" || return $?
  target=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        target="$argument"
        shift || __failArgument "No files supplied" || return $?
        # -h means follow symlinks
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
        return 0
        ;;
    esac
  done
}
_createTarFile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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

# Usage: {fn} directory
# Does a directory exist and is it empty?
# Exit code: 2 - Directory does not exist
# Exit code: 1 - Directory is not empty
# Exit code: 0 - Directory is empty
directoryIsEmpty() {
  local argument

  while [ $# -gt 0 ]; do
    argument="$1"
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        [ -d "$argument" ] || __failArgument "$usage" "Not a directory $(consoleCode "$argument")" || return $?
        find "$argument" -mindepth 1 -maxdepth 1 | read -r && return 1 || return 0
        ;;
    esac
  done
}
_directoryIsEmpty() {
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
# Usage: modificationTime filename0 [ filename1 ... ]
# Exit Code: 2 - If file does not exist
# Exit Code: 0 - If file exists and modification times are output, one per line
# Example:     modificationTime ~/.bash_profile
#
modificationSeconds() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local now

  now="$(date +%s)"
  while [ $# -gt 0 ]; do
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    [ -f "$argument" ] || __failArgument "$usage" "$argument is not a file" || return $?
    printf "%d\n" "$((now - "$(modificationTime "$1")"))"
    shift || __failArgument "$usage" "shift" || return $?
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

#
# Usage: {fn} pathValue separator [ --first | --last | path ]
# Argument: pathValue - Required. Path value to modify.
# Argument: separator - Required. Separator string for path values (typically `:`)
# Argument: --first - Optional. Place any paths after this flag first in the list
# Argument: --last - Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `pathValue`
#
pathAppend() {
  local usage="_${FUNCNAME[0]}"
  local argument pathValue="$1" separator="$2"

  shift 2 || :
  firstFlag=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$1" in
      --first)
        firstFlag=true
        ;;
      --last)
        firstFlag=false
        ;;
      *)
        if [ "$(stringOffset "$argument$separator" "$separator$separator$pathValue$separator")" -lt 0 ]; then
          [ -d "$argument" ] || __failEnvironment "$usage" "not a directory $(consoleCode "$argument")" || return $?
          if [ -z "$pathValue" ]; then
            pathValue="$argument"
          elif "$firstFlag"; then
            pathValue="$argument$separator${pathValue#"$separator"}"
          else
            pathValue="${pathValue%"$separator"}$separator$argument"
          fi
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shift $argument" || return $?
  done
  printf "%s\n" "$pathValue"
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

  __environment buildEnvironmentLoad MANPATH || return $?
  tempPath="$(pathAppend "$MANPATH" ':' "$@")" || _environment pathAppend "$MANPATH" ':' "$@" || return $?
  MANPATH="$tempPath"
}

#
# Usage: {fn} [ --first | --last | path ] ...
# Argument: --first - Optional. Place any paths after this flag first in the list
# Argument: --last - Optional. Place any paths after this flag last in the list. Default.
# Argument: path - the path to be added to the `PATH` environment
pathConfigure() {
  local tempPath
  export PATH

  __environment buildEnvironmentLoad PATH || return $?
  tempPath="$(pathAppend "$PATH" ':' "$@")" || _environment pathAppend "$PATH" ':' "$@" || return $?
  PATH="$tempPath"
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
  local usage="_${FUNCNAME[0]}"
  local pid
  while [ $# -gt 0 ]; do
    pid="$1"
    __usageArgument "$usage" isInteger "$pid" || return $?
    # ps -o '%cpu %mem pid vsz rss tsiz %mem comm' -p "$pid" | tail -n 1
    value="$(ps -o rss -p "$pid" | tail -n 1 | trimSpace)" || __failEnvironment "$usage" "Failed to get process status for $pid" || return $?
    isInteger "$value" || __failEnvironment "$usage" "Bad memory value for $pid: $value" || return $?
    printf %d $((value * 1))
    shift || __failArgument "$usage" "shift" || return $?
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
  local usage="_${FUNCNAME[0]}"
  local pid value
  while [ $# -gt 0 ]; do
    pid="$1"
    __usageArgument "$usage" isInteger "$pid" || return $?
    value="$(ps -o vsz -p "$pid" | tail -n 1 | trimSpace)"
    isInteger "$value" || __failEnvironment "$usage" "ps returned non-integer: \"$(consoleCode "$value")\"" || return $?
    printf %d $((value * 1))
    shift || __failArgument "$usage" "shift" || return $?
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
# Uses mv and clobbers always
#
renameLink() {
  if mv --version >/dev/null 2>&1; then
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
  local usage="_${FUNCNAME[0]}"
  local port service
  [ $# -gt 0 ] || __failArgument "$usage" "No arguments" || return $?
  while [ $# -gt 0 ]; do
    service="$(trimSpace "${1-}")"
    case "$service" in
      ssh) port=22 ;;
      http) port=80 ;;
      https) port=443 ;;
      mariadb | mysql) port=3306 ;;
      postgres) port=5432 ;;
      *) __failEnvironment "$usage" "$service unknown" || return $? ;;
    esac
    printf "%d\n" "$port"
    shift || __failArgument "$usage" shift "$argument" "$@" || return $?
  done
}
_serviceToStandardPort() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the port number associated with a service
#
# Usage: {fn} service [ ... ]
# Argument: service - A unix service typically found in `/etc/services`
# Argument: --services servicesFile - Optional. File. File like '/etc/services`.
# Output: Port number of associated service (integer) one per line
# Exit Code: 1 - service not found
# Exit Code: 2 - bad argument or invalid port
# Exit Code: 0 - service found and output is an integer
#
serviceToPort() {
  local usage="_${FUNCNAME[0]}"
  local argument
  local port servicesFile service

  servicesFile=/etc/services
  [ $# -gt 0 ] || __failArgument "$usage" "Require at least one service" || return $?
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --services)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        servicesFile=$(usageArgumentFile "$usage" "servicesFile" "$1") || return $?
        ;;
      *)
        if [ ! -f "$servicesFile" ]; then
          __usageEnvironment "$usage" serviceToStandardPort "$@" || return $?
        else
          service="$(trimSpace "${1-}")"
          if port="$(grep /tcp "$servicesFile" | grep "^$service\s" | awk '{ print $2 }' | cut -d / -f 1)"; then
            isInteger "$port" || __failEnvironment "$usage" "Port found in $servicesFile is not an integer: $port" || return $?
          else
            port="$(serviceToStandardPort "$service")" || __failEnvironment "$usage" serviceToStandardPort "$service" || return $?
          fi
          printf "%d\n" "$port"
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $argument" || return $?
  done
}
_serviceToPort() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} directory original
# Appends (or creates) `original` to the file named `extension` in `directory`
# Appends `original` to file `directory/@` as well.
# `extension` is computed from `original` and an empty extension is written to '!'
__extensionListsLog() {
  local directory="$1" original="$2"
  local name extension
  name="$(basename "$original")" || _argument "basename $name" || return $?
  extension="${name##*.}"
  # Tests, in order:
  # - Not `.just-extension`
  # - Not `no-period`
  # - Not `".."` or `"."` or `""`
  # If any of the above - use `!` bucket
  [ "${name%%.*}" != "" ] && [ "$extension" != "$name" ] && [ "$extension" != "." ] && [ "$extension" != ".." ] && [ -n "$extension" ] || extension="!"
  printf "%s\n" "$original" | tee -a "$directory/@" >>"$directory/$extension" || _environment "writing $directory/$extension" || return $?
}

#
# Usage: {fn} directory file0 ...
# Argument: --help - Optional. Flag. This help.
# Argument: --clean - Optional. Flag. Clean directory of all files first.
# Argument: directory - Required. Directory. Directory to create extension lists.
# Argument: directory - Required. Directory. Directory to create extension lists.
# Argument: file0 - Optional. List of files to add to the extension list.
# Input: Takes a list of files, one per line
# Generates a directory containing files with `extension` as the file names.
# All files passed to this are added to the `@` file, the `!` file is used for files without extensions.
# Extension parsing is done by removing the final dot from the filename:
# - `foo.sh` -> `"sh"`
# - `foo.tar.gz` -> `"gz"`
# - `foo.` -> `"!"``
# - `foo-bar` -> `"!"``
#
extensionLists() {
  local usage="_${FUNCNAME[0]}"
  local argument directory name names extension cleanFlag

  names=()
  directory=
  cleanFlag=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return $?
        ;;
      --clean)
        cleanFlag=true
        ;;
      *)
        if [ -z "$directory" ]; then
          directory=$(usageArgumentDirectory "$usage" "directory" "$1") || return $?
        else
          names+=("$1")
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $argument" || return $?
  done
  [ -n "$directory" ] || __failArgument "$usage" "No directory supplied" || return $?

  ! $cleanFlag || statusMessage consoleInfo "Cleaning ..." || :
  ! $cleanFlag || __usageEnvironment "$usage" find "$directory" -type f -delete || return $? && clearLine

  if [ ${#names[@]} -gt 0 ]; then
    for name in "${names[@]}"; do
      __usageEnvironment "$usage" __extensionListsLog "$directory" "$name" || return $?
    done
  else
    while read -r name; do
      __usageEnvironment "$usage" __extensionListsLog "$directory" "$name" || return $?
    done
  fi
}
_extensionLists() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Is a path an absolute path?
# Usage: {fn} path ...
# Exit Code: 0 - if all paths passed in are absolute paths (begin with `/`).
# Exit Code: 1 - one ore more paths are not absolute paths
isAbsolutePath() {
  local usage="_${FUNCNAME[0]}"
  [ $# -gt 0 ] || __failArgument "$usage" "Need at least one argument" || return $?
  while [ $# -gt 0 ]; do
    [ "$1" != "${1#/}" ] || return 1
    shift || :
  done
}
_isAbsolutePath() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
