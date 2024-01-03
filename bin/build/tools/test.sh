#!/usr/bin/env bash
#
# test.sh
#
# Test support functions
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh prefixLines
#

#
# dumpFile fileName0 [ fileName1 ... ]
#
dumpFile() {
    local nLines showLines=10 nBytes

    while [ $# -gt 0 ]; do
        if [ -f "$1" ]; then
            nLines=$(($(wc -l <"$1" | cut -f 1 -d' ') + 0))
            nBytes=$(($(wc -c <"$1") + 0))
            consoleInfo -n "$1"
            consoleSuccess -n ": $nLines $(plural "$nLines" line lines), $nBytes $(plural "$nBytes" byte bytes)"
            if [ $showLines -lt $nLines ]; then
                consoleWarning "(Showing $showLines)"
            else
                echo
            fi
            {
                echoBar " "
                head -$showLines "$1"
                echoBar " "
            } | prefixLines "$(consoleCode)    "
        else
            consoleError "dumpFile: $1 is not a file"
        fi
        shift
    done
}
