#!/bin/bash
#
# Local local container to test build
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

#shellcheck source=/dev/null
. ./bin/build/tools.sh

functionTemplate="./docs/__function.sh.md"
for sourceShellScripts in bin/build/tools/*.sh; do
    base="$(basename "$sourceShellScripts")"
    templateFile="./docs/templates/tools/$base.md"
    targetFile="./docs/tools/$base.md"
    if [ -f "$templateFile" ]; then
        statusMessage consoleInfo "Generating $base ..."
        (
            functionTokensFile=$(mktemp)
            listTokens < "$templateFile" > "$functionTokensFile"
            while read -r token; do
                statusMessage consoleInfo "Generating $base ... $token"
                declare $token="$(bashDocumentFunction . "$token" "$functionTemplate")"
                export ${token?}
            done < "$functionTokensFile"
            rm "$functionTokensFile"
            clearLine
            consoleWarning "Writing $targetFile using $templateFile ..."
            ./bin/build/map.sh < "$templateFile" > "$targetFile"
        )
    fi
done
clearLine
