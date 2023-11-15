#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
errorArgument=1
set -eo pipefail

#
# Argument: - `--extension extension` - Required. One or more extensions to search for in the current directory.
# Argument: - `--prefix prefix` - Required. One or more string prefixes to search for in matching files.
#
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success, everything matches
# Exit Code: 100 - Failures
#

me="$(basename "$0")"
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

export usageDelimiter=,
usageOptions() {
    cat <<EOF
--extension extension,Required. The extension to search for files to match (may specify more than one)
--prefix prefix,Required. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
EOF
}
usageDescription() {
    cat <<'EOF'
When, for whatever reason, you need code to match between files, add a comment in the form:

    # IDENTICAL tokenName n

Where tokenName is unique to your project, n is the number of lines to match. All found sets of lines in this form
must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout.

The command to then check would be:

    identical-check.sh --extension sh --prefix '# IDENTICAL'

This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet should remain identical.

Failures are considered:

- Partial success, but warnings occurred with an invalid number in a file
- Two code instances with the same token were found which were not identical
- Two code instances with the same token were found which have different line counts

This is best used as a pre-commit check, for example. Wink.
EOF
}
usage() {
    usageMain "$me" "$@"
    exit $?
}
errorFailures=100

findArgs=()
prefixes=()
while [ $# -gt 0 ]; do
    case "$1" in
    --extension)
        shift || usage $errorArgument "--extension not specified"
        findArgs+=("-name" "*.$1")
        ;;
    --prefix)
        shift || usage $errorArgument "--prefix not specified"
        prefixes+=("$1")
    esac
    shift
done

if [ ${#findArgs[@]} -eq 0 ]; then
    usage $errorArgument "Need to specify at least one extension"
fi
if [ ${#prefixes[@]} -eq 0 ]; then
    usage $errorArgument "Need to specify at least one prefix (Try --prefix '# IDENTICAL')"
fi
# set -x

export exitCode=0
tempDirectory="$(mktemp -d -t "$me.XXXXXXXX")"
resultsFile=$(mktemp)
find . "${findArgs[@]}" ! -path "*/.*" | while IFS= read -r searchFile; do
    if [ "$(basename "$searchFile")" = "$me" ]; then
        # We are exceptional ;)
        continue
    fi
    prefixIndex=0
    for prefix in "${prefixes[@]}"; do
        [ -d "$tempDirectory/$prefixIndex" ] || mkdir "$tempDirectory/$prefixIndex"
        grep "$prefix" "$searchFile" | while read -r identicalLine; do
            identicalLine="$(trimSpace "${identicalLine##$prefix}")"
            token=${identicalLine%% *}
            count=${identicalLine##* }
            if ! isNumber "$count"; then
                clearLine
                printf "%s %s, Bad count: %s" "$(consoleWarning -n "Skipping bad instance at ")" "$(consoleCode $searchFile)" "$count"
                continue
            fi
            tokenFile="$tempDirectory/$prefixIndex/$token"
            countFile="$tempDirectory/$prefixIndex/$token-$count"
            if [ -f "$tokenFile" ]; then
                tokenLineCount=$(head -1 "$tokenFile")
                tokenFileName=$(tail -1 "$tokenFile")
                if [ ! -f "$countFile" ]; then
                    clearLine
                    printf "%s: %s\n" "$(consoleInfo "$token")" "$(consoleError -n "Token counts do not match:")"  1>&2
                    printf "    %s has %s specified\n" "$(consoleCode -n "$tokenFileName")" "$(consoleSuccess -n "$tokenLineCount")" 1>&2
                    printf "    %s has %s specified\n" "$(consoleCode -n "$searchFile")" "$(consoleError -n "$count")" 1>&2
                else
                    grep "$prefix" -A "$count" "$searchFile" >"${countFile}.compare"
                    if ! diff -q "$countFile" "${countFile}.compare" >/dev/null; then
                        clearLine
                        printf "%s: %s\n< %s\n> %s%s\n" "$(consoleInfo "$token")" "$(consoleError -n "Token code changed:")" "$(consoleSuccess "$tokenFileName")" "$(consoleWarning "$searchFile")" "$(consoleCode)" 1>&2
                        diff "$countFile" "${countFile}.compare" | prefixLines "$(consoleCode)    " 1>&2
                        consoleReset 1>&2
                    fi
                    statusMessage consoleSuccess "Verified $searchFile"
                fi
            else
                printf "%s\n%s\n" "$count" "$searchFile" >"$tokenFile"
                grep "$prefix" -A "$count" "$searchFile" >"$countFile"
                statusMessage consoleInfo "Found $count lines for $token and comparing"
            fi
        done || :
        prefixIndex=$((prefixIndex + 1))
    done
done 2>"$resultsFile"
clearLine
rm -rf "$tempDirectory"
if [ "$(wc -l < "$resultsFile")" -ne 0 ]; then
    exitCode=$errorFailures
fi
cat "$resultsFile" 1>&2
rm "$resultsFile"
clearLine
exit "$exitCode"
