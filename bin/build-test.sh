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
. ./bin/build/tools.sh

bin/build/install/apt.sh shellcheck

whichApt shellcheck shellcheck

quietLog="./.build/$me.log"

requireFileDirectory "$quietLog"

failedScripts=()
for f in bin/build/*.sh bin/build/install/*.sh bin/build/pipeline/*.sh; do
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
    if which "$binary" >/dev/null; then
        consoleError "binary $binary is already installed?"
        return $errEnv
    fi
    $script
    if ! which "$binary" >/dev/null; then
        consoleError "binary $binary was not installed by $script"
        return $errEnv
    fi
}

if ! which docker-compose >/dev/null; then
    testScriptInstalls docker-compose "bin/build/install/docker-compose.sh"
fi
testScriptInstalls php "bin/build/install/php-cli.sh"
testScriptInstalls python "bin/build/install/python.sh"
testScriptInstalls mariadb "bin/build/install/mariadb-client.sh"
testScriptInstalls aws "bin/build/install/aws-cli.sh"
# requires docker
if which docker >/dev/null; then
    echo "{}" >composer.json
    "bin/build/composer.sh"
    if [ ! -d "vendor" ] || [ ! -f composer.lock ]; then
        consoleError "composer failed"
    fi
fi
if ! which git >/dev/null; then
    testScriptInstalls git "bin/build/install/git.sh"
fi
if ! which npm >/dev/null; then
    # npm 18 installed in this image
    testScriptInstalls npm "bin/build/install/npm.sh"
fi
testScriptInstalls prettier "bin/build/install/prettier.sh"

bigText Passed | prefixLines "$(consoleSuccess)"
