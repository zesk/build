#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh
#
###############################################################################
#
# ▐▌ ▐▌▗▟██▖ ▟██▖ ▟█▟▌ ▟█▙
# ▐▌ ▐▌▐▙▄▖▘ ▘▄▟▌▐▛ ▜▌▐▙▄▟▌
# ▐▌ ▐▌ ▀▀█▖▗█▀▜▌▐▌ ▐▌▐▛▀▀▘
# ▐▙▄█▌▐▄▄▟▌▐▙▄█▌▝█▄█▌▝█▄▄▌
#  ▀▀▝▘ ▀▀▀  ▀▀▝▘ ▞▀▐▌ ▝▀▀
#                 ▜█▛▘
#------------------------------------------------------------------------------

#
# Formats name value pairs separated by separatorChar (default ;) and uses
# $nSpaces width for first field
#
# usageGenerator nSpaces separatorChar labelPrefix valuePrefix < formatFile
#
usageGenerator() {
    local nSpaces=$((${1-30} + 0)) separatorChar=${2-\;} labelPrefix valuePrefix

    labelPrefix=${3-"$(consoleLabel)"}
    # shellcheck disable=SC2119
    valuePrefix=${4-"$(consoleValue)"}

    awk "-F$separatorChar" "{ print \"$labelPrefix\" sprintf(\"%-\" $nSpaces \"s\", \$1) \"$valuePrefix\" substr(\$0, index(\$0, \"$separatorChar\") + 1) }"
}

#
# Requires environment variables to be set and non-blank
#
usageEnvironment() {
    set +u
    for e in "$@"; do
        if [ -z "${!e}" ]; then
            usage 1 "Required $e not set"
            return 1
        fi
    done
    set -u
}

#
# Requires the binaries to be found in the $PATH variable
# fails if not
#
usageWhich() {
    for b in "$@"; do
        if [ -z "$(which "$b")" ]; then
            usage 1 "$b is not available in path, not found: $PATH"
            return 1
        fi
    done
}
