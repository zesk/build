#!/usr/bin/env bash
#
# cp ./bin/hooks/git-pre-commit.sh .git/hooks/pre-commit
#
# Part of build system integration with git
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../.."

fromTo=(bin/hooks/git-pre-commit.sh .git/hooks/pre-commit)
if ! diff -q "${fromTo[@]}" >/dev/null; then
    echo -n "Git pre-commit hook was updated ..."
    cp "${fromTo[@]}"
    exec .git/hooks/pre-commit "$@"
fi

# shellcheck source=/dev/null
. ./bin/build/tools.sh

statusMessage consoleSuccess Making shell files executable ...
./bin/build/chmod-sh.sh >/dev/null
statusMessage consoleSuccess Updating help files ...
./bin/update-md.sh >/dev/null
if which shellcheck >/dev/null; then
    failedReasons=()
    thisYear=$(date +%Y)

    statusMessage consoleSuccess Running shellcheck ...
    while IFS= read -r -d '' f; do
        if ! shellcheck "$f" >/dev/null; then
            failedReasons+=("shellcheck $f failed")
        fi
        if ! grep -q "Copyright &copy; $thisYear" "$f"; then
            failedReasons+=("$f missing copyright")
        fi
    done < <(find . -name '*.sh' ! -path '*/.*' -print0)
    if [ "${#failedReasons[@]}" -gt 0 ]; then
        clearLine
        consoleError -n "The following scripts failed:"
        for f in "${failedReasons[@]}"; do
            echo "$(consoleMagenta -n "$f")$(consoleInfo -n ", ")"
        done
        consoleError "done."
        exit 1
    else
        clearLine
        consoleSuccess "All scripts passed"
    fi
fi
