#!/usr/bin/env bash
#
# build-test.sh
#
# Testing
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

set -eo pipefail
errEnv=1

me=$(basename "$0")
relTop=".."
if ! cd "$(dirname "${BASH_SOURCE[0]}")/$relTop"; then
    echo "$me: Can not cd to $relTop" 1>&2
    exit $errEnv
fi

# shellcheck source=/dev/null
. "./bin/build/colors.sh"

bin/build/apt-utils.sh shellcheck

quietLog="./.build/$me.log"

requireFileDirectory "$quietLog"

failedScripts=()
for f in bin/build/*.sh; do
    consoleInfo "Checking $f"
    bash -n "$f"
    if ! shellcheck "$f" >>"$quietLog"; then
        failedScripts+=("$f")
    fi
done

if [ "${#failedScripts[@]}" -gt 0 ]; then
    consoleError -n "The following scripts failed:"
    for f in "${failedScripts[@]}"; do
        echo "$(consoleMagenta -n "$f") $(consoleWhite -n ", ")"
    done
    consoleError "done."
    failed "$quietLog"
else
    consoleSuccess "All scripts passed"
fi

testScriptInstalls() {
    local binary=$1 script=$2
    if which "$binary"; then
        consoleError "binary $binary is already installed?"
        return $errEnv
    fi
    $script
    if ! which "$binary"; then
        consoleError "binary $binary was not installed by $script"
        return $errEnv
    fi
}

testScriptInstalls aws "bin/build/aws-cli.sh"
# requires docker
if which docker >/dev/null; then
    echo "{}" >composer.json
    testScriptInstalls composer "bin/build/composer.sh"
fi
if ! which git >/dev/null; then
    testScriptInstalls git "bin/build/git.sh"
fi
testScriptInstalls mariadb "bin/build/mariadb-client.sh"
if ! which npm >/dev/null; then
    # npm 18 installed in this image
    testScriptInstalls npm "bin/build/npm.sh"
fi
testScriptInstalls php-cli "bin/build/php-cli.sh"
testScriptInstalls prettier "bin/build/prettier.sh"
testScriptInstalls python "bin/build/python.sh"
testScriptInstalls docker-compose "bin/build/docker-compose.sh"
