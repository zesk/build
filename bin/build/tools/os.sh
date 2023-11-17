#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#

# IDENTICAL errorArgument 1
errorArgument=2

# Given a list of files, ensure their parent directories exist
#
# Creates the directories for all files passed in.
#
# Usage: requireFileDirectory file1 file2 ...
# Example: logFile=./.build/$me.log
# Example: requireFileDirectory "$logFile"
#
requireFileDirectory() {
    local name
    while [ $# -gt 0 ]; do
        name="$(dirname "$1")"
        [ -d "$name" ] || mkdir -p "$name"
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
# Run apt-get update once and only once in the pipeline, at least
# once an hour as well (when testing)
#
# Short Description: Do `apt-get update` once
# Usage: aptUpdateOnce
# Environment: Stores state files in `./.build/` directory which is created if it does not exist.
#
aptUpdateOnce() {
    local older name quietLog start

    quietLog=./.build/apt-get-update.log
    requireFileDirectory "$quietLog"
    name=./.build/.apt-update
    # once an hour, technically
    older=$(find ./.build -name .apt-update -mmin +60 | head -n 1)
    if [ -n "$older" ]; then
        rm -rf "$older"
    fi
    if [ ! -f "$name" ]; then
        if ! which apt-get >/dev/null; then
            consoleError "No apt-get available" 1>&2
            return 1
        fi
        start=$(beginTiming)
        consoleInfo -n "apt-get update ... "
        if ! DEBIAN_FRONTEND=noninteractive apt-get update -y >"$quietLog" 2>&1; then
            buildFailed "$quietLog"
        fi
        reportTiming "$start" OK
        date >"$name"
    fi
}

#
# whichApt binary aptInstallPackage
#
# Installs an apt package if a binary does not exist in the which path.
# The assumption here is that `aptInstallPackage` will install the desired `binary`.
#
# If fails, runs `buildFailed` and outputs the log file.
#
# Confirms that `binary` is installed after installation succeeds.
#
# Short Description: Install tools using `apt-get` if they are not found
# Usage: whichApt binary aptInstallPackage
# Example: whichApt shellcheck shellcheck
# Example: whichApt mariadb mariadb-client
# Argument: binary - The binary to look for
# Argument: aptInstallPackage - The package name to install if the binary is not found in the `$PATH`.
# Environment: Technically this will install the binary and any related files as a package.
#
whichApt() {
    local binary=$1 quietLog
    shift
    if ! which "$binary" >/dev/null; then
        if aptUpdateOnce; then
            quietLog="./.build/apt.log"
            requireFileDirectory "$quietLog"
            if ! DEBIAN_FRONTEND=noninteractive apt-get install -y "$@" >>"$quietLog" 2>&1; then
                consoleError "Unable to install" "$@"
                buildFailed "$quietLog"
            fi
            if which "$binary" >/dev/null; then
                return 0
            fi
            consoleError "Apt packages $* do not add $binary to the PATH $PATH"
            buildFailed "$quietLog"
        fi
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

# Reverses a pipe's input lines to output using an awk trick.
#
# Short Description: Reverse output lines
# Source: https://web.archive.org/web/20090208232311/http://student.northpark.edu/pemente/awk/awk1line.txt
# Credits: Eric Pement
#
reverseFileLines() {
    awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
}
