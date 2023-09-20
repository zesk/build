#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#

#
#
# Given a list of files, ensure their parent directories exist
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
# Platform agnostic tar cfz which ignores owner and attributes
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
# Installs an apt package if a binary does not exist in the which path
#
# The assuption here is that aptInstallPackage will install the desired binary
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