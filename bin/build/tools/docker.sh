#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh text.sh
# bin: head grep

###############################################################################
#
# ▗▖          ▗▖
# ▐▌          ▐▌
#  ▟█▟▌ ▟█▙  ▟██▖▐▌▟▛  ▟█▙  █▟█▌
# ▐▛ ▜▌▐▛ ▜▌▐▛  ▘▐▙█  ▐▙▄▟▌ █▘
# ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▛█▖ ▐▛▀▀▘ █
# ▝█▄█▌▝█▄█▘▝█▄▄▌▐▌▝▙ ▝█▄▄▌ █
#  ▝▀▝▘ ▝▀▘  ▝▀▀ ▝▘ ▀▘ ▝▀▀  ▀
#
#------------------------------------------------------------------------------
#
# Debugging, dumps the proc1file which is used to figure out if we
# are insideDocker or not; use this to confirm platform implementation
#
dumpDockerTestFile() {
    local proc1File=/proc/1/sched

    if [ -f "$proc1File" ]; then
        bigText $proc1File
        prefixLines "$(consoleMagenta)" <"$proc1File"
    else
        consoleWarning "Missing $proc1File"
    fi
}

#
# Are we inside a docker container right now?
#
insideDocker() {
    if [ ! -f /proc/1/sched ]; then
        # Not inside
        return 1
    fi
    if head -n 1 /proc/1/sched | grep -q init; then
        # Not inside
        return 1
    fi
    # inside
    return 0
}
