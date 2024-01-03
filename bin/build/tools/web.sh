#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh pipeline.sh
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

#
#
#
urlMatchesLocalFileSize() {
    local url file remoteSize localSize

    url=$1
    file=$2
    if [ -f "$file" ]; then
        return $errorEnvironment
    fi
    localSize=$(du -b "$file")
    localSize=$((localSize + 0))
    remoteSize=$(urlContentLength "$url")
    [ "$localSize" -eq "$remoteSize" ]
}

urlContentLength() {
    local url remoteSize

    while [ $# -gt 0 ]; do
        url=$1
        if ! remoteSize=$(curl -s -I "$url" | grep -i Content-Length | awk '{ print $2 }'); then
            consoleError "Fetching \"$url\" failed"
            return "$errorEnvironment"
        fi
        printf "%d\n" $((remoteSize + 0))
        shift
    done
}

hostIPList() {
    if [ "$OS_TYPE" = Linux ]; then
        ifconfig | grep 'inet addr:' | cut -f 2 -d : | cut -f 1 -d ' '
    elif [ "$OS_TYPE" = FreeBSD ]; then
        ifconfig | grep 'inet ' | cut -f 2 -d ' '
    else
        consoleError "hostIPList Unsupported OS_TYPE \"$OS_TYPE\"" 1>&2
        return "$errorEnvironment"
    fi
}

hostTTFB() {
    curl -L -s -o /dev/null -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" "$@"
}
