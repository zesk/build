#!/bin/bash
#
# Local local container to test build
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eou pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
me=$(basename "$0")
cacheDirectory="./.build-docs"

#shellcheck source=/dev/null
. ./bin/build/tools.sh

export usageDelimiter=,
usageOptions() {
    cat <<EOF
--force,Force generation, ignore cache directives
--cache directory,Specify a cache directory different than the default \`$cacheDirectory\`
--no-cache,Do not generate or save cache files
EOF
}
usageDescription() {
    cat <<EOF
Build documentation for build system.
EOF
}
usage() {
    usageMain "$me" "$@"
    exit $?
}

optionCache=1
while [ $# -gt 0 ]; do
    case $1 in
        --force)
            optionForce=1
            optionCache=
            ;;
        --no-cache)
            optionCache=
            ;;
        --cache)
            shift || usage $errorArgument "--cache missing argument"
            cacheDirectory="${1%%/}"
            if [ ! -d "$cacheDirectory" ]; then
                usage $errorArgument "--cache $cacheDirectory is not a directory"
            fi
            ;;
    esac
    shift
done

if test $optionCache; then
    [ -d "$cacheDirectory" ] || mkdir -p "$cacheDirectory"
fi
functionTemplate="./docs/__function.sh.md"
functionSum="$(shaPipe < "$functionTemplate")"
for sourceShellScripts in bin/build/tools/*.sh; do
    reason=""
    base="$(basename "$sourceShellScripts")"
    templateFile="./docs/templates/tools/$base.md"
    targetFile="./docs/tools/$base.md"
    if [ -f "$templateFile" ]; then
        if test $optionCache; then
            checksum="${functionSum}:$(shaPipe <"$sourceShellScripts"):$(shaPipe <"$templateFile")"
            checksumFile="$cacheDirectory/$base.checksum"
            if [ -f "$checksumFile" ]; then
                generatedChecksum=$(cat "$checksumFile")
                if [ "$generatedChecksum" = "$checksum" ]; then
                    statusMessage consoleWarning "Skipping $sourceShellScripts as it has not changed ..."
                    continue
                fi
                reason="(Checksum changed)"
            else
                reason="(Need first time processing)"
            fi
        fi
        statusMessage consoleInfo "Generating $base ... $reason"
        (
            functionTokensFile=$(mktemp)
            listTokens <"$templateFile" >"$functionTokensFile"
            while read -r token; do
                statusMessage consoleInfo "Generating $base ... $(consoleValue "[$token]") ... $reason"
                declare "$token"="$(bashDocumentFunction . "$token" "$functionTemplate")"
                export "${token?}"
            done <"$functionTokensFile"
            rm "$functionTokensFile"
            clearLine
            statusMessage consoleSuccess "Writing $targetFile using $templateFile ..."
            ./bin/build/map.sh <"$templateFile" >"$targetFile"
        )
        if test $optionCache; then
            printf %s "$checksum" >$checksumFile
            statusMessage consoleSuccess "Saved $targetFile checksum $checksum ..."
        fi
    fi
done
clearLine
