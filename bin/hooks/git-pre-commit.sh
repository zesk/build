#!/usr/bin/env bash

set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

# shellcheck source=/dev/null
. ./bin/build/tools.sh

./bin/build/chmod-sh.sh
./bin/update-md.sh
if which shellcheck >/dev/null; then
    failedReasons=()
    thisYear=$(date +%Y)

    while IFS= read -r -d '' f; do
        if ! shellcheck "$f" >/dev/null; then
            failedReasons+=("shellcheck $f failed")
        fi
        if ! grep -q "Copyright &copy; $thisYear" "$f"; then
            failedReasons+=("$f missing copyright")
        fi
    done < <(find . -name '*.sh' ! -path '*/.*' -print0)
    if [ "${#failedReasons[@]}" -gt 0 ]; then
        consoleError -n "The following scripts failed:"
        for f in "${failedReasons[@]}"; do
            echo "$(consoleMagenta -n "$f")$(consoleInfo -n ", ")"
        done
        consoleError "done."
        exit 1
    else
        consoleSuccess "All scripts passed"
    fi
fi
