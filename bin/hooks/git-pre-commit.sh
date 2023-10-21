#!/usr/bin/env bash
#
# cp ./bin/hooks/git-pre-commit.sh .git/hooks/pre-commit
#
# Part of build system integration with git
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
quietLog=$(mktemp)

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
statusMessage consoleSuccess Running shellcheck ...
if ! testShellScripts "$quietLog"; then
    buildFailed "$quietLog"
fi
clearLine
