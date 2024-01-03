#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorArgument 1
errorArgument=2

errorFailures=100

# IDENTICAL bashHeader2 5
set -eou pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# IDENTICAL me 1
me="$(basename "${BASH_SOURCE[0]}")"

usage() {
    usageDocument "./bin/build/$me" "identicalCheck" "$@"
    exit $?
}

# fn: identical-check.sh
# Usage: identical-check.sh --extension extension0 --prefix prefix0  [ --cd directory ] [ --extension extension1 ... ] [ --prefix prefix1 ... ]
# Argument: --extension extension - Required. One or more extensions to search for in the current directory.
# Argument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
# Argument: --cd directory - Optional. Change to this directory before running. Defaults to current direcory.
# Argument: --help - Optional. This help.
#
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success, everything matches
# Exit Code: 100 - Failures
#
# When, for whatever reason, you need code to match between files, add a comment in the form:
#
#     # IDENTICAL tokenName n
#
# Where `tokenName` is unique to your project, `n` is the number of lines to match. All found sets of lines in this form
# must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout.
#
# The command to then check would be:
#
#     identical-check.sh --extension sh --prefix '# IDENTICAL'
#
# This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet
# should remain identical.
#
# Failures are considered:
#
# - Partial success, but warnings occurred with an invalid number in a file
# - Two code instances with the same token were found which were not identical
# - Two code instances with the same token were found which have different line counts
#
# This is best used as a pre-commit check, for example. Wink.
#
identicalCheck() {
    local rootDir findArgs prefixes exitCode tempDirectory resultsFile prefixIndex prefix
    local totalLines lineNumber token count tokenFile countFile
    local tokenLineCount tokenFileName compareFile
    rootDir=.
    findArgs=()
    prefixes=()
    while [ $# -gt 0 ]; do
        case "$1" in
        --cd)
            shift || usage $errorArgument "--cd not specified"
            rootDir=$1
            if [ ! -d "$rootDir" ]; then
                usage $errorArgument "--cd \"$1\" is not a directory"
            fi
            ;;
        --extension)
            shift || usage $errorArgument "--extension not specified"
            findArgs+=("-name" "*.$1")
            ;;
        --prefix)
            shift || usage $errorArgument "--prefix not specified"
            prefixes+=("$1")
            ;;
        esac
        shift
    done

    if [ ${#findArgs[@]} -eq 0 ]; then
        usage $errorArgument "Need to specify at least one extension"
    fi
    if [ ${#prefixes[@]} -eq 0 ]; then
        usage $errorArgument "Need to specify at least one prefix (Try --prefix '# IDENTICAL')"
    fi

    export exitCode=0
    tempDirectory="$(mktemp -d -t "$me.XXXXXXXX")"
    resultsFile=$(mktemp)
    find "$rootDir" "${findArgs[@]}" ! -path "*/.*" | sort | while IFS= read -r searchFile; do
        # Do not process files which look like `identical-check.sh`
        if [ "$(basename "$searchFile")" = "$me" ]; then
            # We are exceptional ;)
            continue
        fi
        prefixIndex=0
        for prefix in "${prefixes[@]}"; do
            [ -d "$tempDirectory/$prefixIndex" ] || mkdir "$tempDirectory/$prefixIndex"
            totalLines=$(wc -l <"$searchFile")
            grep -n "$prefix" "$searchFile" | while read -r identicalLine; do
                lineNumber=${identicalLine%%:*}
                identicalLine=${identicalLine#*:}
                identicalLine="$(trimSpace "${identicalLine##*"$prefix"}")"
                token=${identicalLine%% *}
                count=${identicalLine##* }
                tokenFile="$tempDirectory/$prefixIndex/$token"
                if ! isNumber "$count"; then
                    printf "%s\n%s\n" "$count" "$searchFile" >"$tokenFile"
                    clearLine 1>&2
                    printf "%s %s in %s\n" "$(consoleWarning -n "Count is not a number")" "$(consoleCode "$count")" "$(consoleError "$searchFile")" 1>&2
                    continue
                fi
                countFile="$tempDirectory/$prefixIndex/$count@$token.match"
                if [ -f "$tokenFile" ]; then
                    tokenLineCount=$(head -1 "$tokenFile")
                    tokenFileName=$(tail -1 "$tokenFile")
                    if [ ! -f "$countFile" ]; then
                        clearLine 1>&2
                        printf "%s: %s\n" "$(consoleInfo "$token")" "$(consoleError -n "Token counts do not match:")" 1>&2
                        printf "    %s has %s specified\n" "$(consoleCode -n "$tokenFileName")" "$(consoleSuccess -n "$tokenLineCount")" 1>&2
                        printf "    %s has %s specified\n" "$(consoleCode -n "$searchFile")" "$(consoleError -n "$count")" 1>&2
                    else
                        compareFile="${countFile}.compare"
                        # Extract our section of the file. Matching is done, use line numbers and math to extract exact section
                        # 10 lines in file, line 1 means: tail -n 10
                        # 10 lines in file, line 9 means: tail -n 2
                        # 10 lines in file, line 10 means: tail -n 1
                        tail -n $((totalLines - lineNumber + 1)) "$searchFile" | head -n "$((count + 1))" >"$compareFile"
                        if [ "$(grep "$prefix" -c "$compareFile")" -gt 1 ]; then
                            clearLine 1>&2
                            printf "%s: %s\n< %s%s\n" "$(consoleInfo "$token")" "$(consoleError -n "Identical sections overlap:")" "$(consoleSuccess "$searchFile")" "$(consoleCode)" 1>&2
                            prefixLines "$(consoleCode)    " <"$compareFile" 1>&2
                            consoleReset 1>&2
                            break
                        elif ! diff -q "$countFile" "${countFile}.compare" >/dev/null; then
                            clearLine 1>&2
                            printf "%s: %s\n< %s\n> %s%s\n" "$(consoleInfo "$token")" "$(consoleError -n "Token code changed:")" "$(consoleSuccess "$tokenFileName")" "$(consoleWarning "$searchFile")" "$(consoleCode)" 1>&2
                            diff "$countFile" "${countFile}.compare" | prefixLines "$(consoleCode)    " 1>&2
                            consoleReset 1>&2
                            break
                        else
                            statusMessage consoleSuccess "Verified $searchFile, lines $lineNumber-$((lineNumber + tokenLineCount))"
                        fi
                    fi
                else
                    printf "%s\n%s\n" "$count" "$searchFile" >"$tokenFile"
                    tail -n $((totalLines - lineNumber + 1)) "$searchFile" | head -n "$((count + 1))" >"$countFile"
                    statusMessage consoleInfo "$(printf "Found %d %s for %s (in %s)" "$count" "$(plural "$count" line lines)" "$(consoleCode "$token")" "$(consoleValue "$searchFile")")"
                fi
            done || :
            prefixIndex=$((prefixIndex + 1))
        done
    done 2>"$resultsFile"
    clearLine
    find "$tempDirectory" -type f -name '*.match' | while read -r matchFile; do
        if [ ! -f "$matchFile.compare" ]; then
            tokenFile="$(dirname "$matchFile")"
            token="$(basename "$matchFile")"
            token="${token%%.match}"
            token="${token#*@}"
            tokenFile="$tokenFile/$token"
            printf "%s: %s in %s\n" "$(consoleWarning "Single instance of token found:")" "$(consoleError "$token")" "$(consoleInfo "$(tail -n 1 "$tokenFile")")" >>"$resultsFile"
        fi
    done
    rm -rf "$tempDirectory"
    if [ "$(wc -l <"$resultsFile")" -ne 0 ]; then
        exitCode=$errorFailures
    fi
    cat "$resultsFile" 1>&2
    rm "$resultsFile"
    clearLine
    return "$exitCode"
}

identicalCheck "$@"
