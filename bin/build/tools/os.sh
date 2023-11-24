#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#

# IDENTICAL errorArgument 1
errorArgument=2

# Path to cache directory for build system.
#
# Defaults to `$HOME/.build` unless `$HOME` is not a directory.
#
# Appends any passed in arguments as path segments.
#
# Example: logFile=$(buildCacheDirectory test.log)
# Usage: buildCacheDirectory [ pathSegment ... ]
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
# Usage: buildQuietLog name
# Argument: name - The log file name
#
buildQuietLog() {
    if [ -z "$1" ]; then
        consoleError "buildQuietLog requires a name parameter" 1>&2
        return 1
    fi
    printf %s "$(buildCacheDirectory "$1.log")"
}
#
# Given a list of files, ensure their parent directories exist
#
# Creates the directories for all files passed in.
#
# Usage: requireFileDirectory file1 file2 ...
# Example: logFile=./.build/$me.log
# Example: requireFileDirectory "$logFile"
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
# Usage: requireDirectory dir1 [ dir2 ... ]
# Argumetn: dir1 - One or more directories to create
# Example: requireDirectory "$cachePath"
#
requireDirectory() {
    local rs name
    while [ $# -gt 0 ]; do
        name="$1"
        if [ ! -d "$name" ] && ! mkdir -p "$name"; then
            rs=$?
            consoleError "Unable to create directory \"$name\"" 1>&2
            return "$rs"
        fi
        shift
    done
}

#
# Usage: runCount count binary [ args ... ]
# Argument: count - The number of times to run the binary
# Argument: binary - The binary to run
# Argument: args ... - Any arguments to pass to the binary each run
# Exit Code: 0 - success
# Exit Code: 2 - `count` is not an unsigned number
# Exit Code: Any - If `binary` fails, the exit code is returned
# Short Description: Run a binary count times
#
runCount() {
    local n
    n="$1"
    if ! isUnsignedNumber "$n"; then
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
# Short Description: Rename a list of files usually to back them up temporarily
# Usage: renameFiles oldSuffix newSuffix actionVerb file0 [ file1 file2 ... ]
# Argument: oldSuffix - Required. String. Old suffix to look rename from.
# Argument: newSuffix - Required. String. New suffix to rename to.
# Argument: actionVerb - Required. String. Description to output for found files.
# Argument: file0 - Required. String. One or more files to rename, if found, renaming occurs.
# Example: renameFiles "" ".$$.backup" hiding etc/app.json etc/config.json
# Example: ...
# Example: renameFiles ".$$.backup" "" restoring etc/app.json etc/config.json
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
# Short Description: Fetch a list of environment variable names
# Usage: environmentVariables
# Output: Environment variable names, one per line.
# Example: for f in $(environmentVariables); do
# Example:     echo "$f"
# Example: done
#
environmentVariables() {
    # IDENTICAL environmentVariables 1
    declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}

#
# Reverses a pipe's input lines to output using an awk trick.
#
# Short Description: Reverse output lines
# Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt
# Credits: Eric Pement
#
reverseFileLines() {
    awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}

# Makes all `*.sh` files executable
#
# Usage: makeShellFilesExecutable
# Environment: Works from the current directory
# See: chmod-sh.sh
makeShellFilesExecutable() {
    # IDENTICAL makeShellFilesExecutable 1
    find . -name '*.sh' ! -path '*/.*' -print0 | xargs -0 chmod -v +x
}

# Fetch the modification time of a file as a timestamp
#
# Usage: modificationTime filename0 [ filename1 ... ]
# Exit Code: 2 - If file does not existd
# Exit Code: 0 - If file exists and modification times are output, one per line
# Example: modificationTime ~/.bash_profile
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

#
# Check to see if the first file is the newest one
#
# If `sourceFile` is modified AFTER ALL `targetFile`s, return `0``
# Otherwise return `1``
#
# Usage: isNewestFile firstFile [ targetFile0 ... ]
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
# Usage: isNewestFile firstFile [ targetFile0 ... ]
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
# Usage: oldestFile file0 [ file1 ... ]
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
# Usage: newestFile file0 [ file1 ... ]
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
