#!/bin/bash
#
# Map environment to values in a target file
#
# Usage: map.sh [ --prefix prefixString ] [ --suffix suffixString ] [ env0 ... ]
#
# Map environment variables and convert input file tokens to values of environment variables.
#
# Renamed to `map.sh` in 2023 to keep it short and sweet.
#
# Argument: --prefix prefixString - Optional. The prefix string to determine what a token is. Defaults to `{`. Must be before any environment variable names, if any.
# Argument: --suffix suffixString - Optional. The suffix string to determine what a token is. Defaults to `}`. Must be before any environment variable names, if any.
# Argument: env0 - Optional. If specified, then ONLY these environment variables are mapped; all others are ignored. If not specified, then all environment variables are mapped.
# Argument: ... - Optional. Additional environment variables to map can be specified as additional arguments
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail

#
# Quote sed strings for shell use
#
quoteSedPattern() {
    # IDENTICAL quoteSedPattern 2
    value=$(printf %s "$1" | sed 's/\([.*+?]\)/\\\1/g')
    value="${value//\//\\\/}"
    value="${value//[/\\[}"
    value="${value//]/\\]}"
    printf %s "${value//$'\n'/\\n}"
}

#
# Output a list of environment variables and ignore function definitions
#
# both `set` and `env` output functions and this is an easy way to just output
# exported variables
#
environmentVariables() {
    declare -px | grep 'declare -x ' | cut -f 1 -d= | cut -f 3 -d' '
}

cleanup() {
    [ -f "$sedFile" ] && rm "$sedFile"
}
trap cleanup EXIT INT

prefix='{'
suffix='}'

generateSedFile() {
    local sedFile=$1 value

    shift
    for i in "$@"; do
        case "$i" in
            *[%{}]*) ;;
            LD_*) ;;
            _*) ;;
            *)
                printf "s/%s/%s/g\n" "$(quoteSedPattern "$prefix$i$suffix")" "$(quoteSedPattern "${!i-}")" >>"$sedFile"
                ;;
        esac
    done
}

while [ $# -gt 0 ]; do
    case $1 in
        --prefix)
            shift || usage $errorArgument "--prefix missing a value"
            prefix="$1"
            ;;
        --suffix)
            shift || usage $errorArgument "--suffix missing a value"
            suffix="$1"
            ;;
        *)
            break
            ;;
    esac
    shift
done

cd "$(dirname "${BASH_SOURCE[0]}")"
sedFile=$(mktemp)

if [ $# -eq 0 ]; then
    ee=()
    for e in $(environmentVariables); do
        ee+=("$e")
    done
    generateSedFile "$sedFile" "${ee[@]}"
else
    generateSedFile "$sedFile" "$@"
fi

if ! sed -f "$sedFile"; then
    rs=$?
    cat "$sedFile" 1>&2
    exit $rs
fi
