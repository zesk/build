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
while IFS= read -r -d '' f; do
    consoleInfo "Checking $f"
    bash -n "$f"
    if ! shellcheck "$f" >>"$quietLog"; then
        failedScripts+=("$f")
    fi
done < <(find . -name '*.sh' ! -path '*/.*' -print0)

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

assertEquals() {
    local a=$1 b=$2
    shift
    shift
    if [ "$a" != "$b" ]; then
        consoleError "$a != $b $*"
        exit $errEnv
    fi
}

testScriptInstalls() {
    local binary=$1 script=$2
    if which "$binary" >/dev/null; then
        consoleError "binary $binary is already installed?"
        return "$errEnv"
    fi
    $script
    if ! which "$binary" >/dev/null; then
        consoleError "binary $binary was not installed by $script"
        return "$errEnv"
    fi
}
randomString() {
    head --bytes=64 /dev/random | md5sum | cut -f 1 -d ' '
}

testEnvMap() {
    local result expected

    export FOO=test
    export BAR=goob

    result="$(echo "{FOO}{BAR}{foo}{bar}{BAR}" | bin/build/envmap.sh)"

    expected="testgoob{foo}{bar}goob"
    if [ "$result" != "$expected" ]; then
        consoleError "envmap.sh failed: $result != $expected"
        exit $errEnv
    fi
}

testBuildSetup() {
    local targetDir marker testBinary testOutput

    targetDir="test.$$/bin/deeper/deepest"
    mkdir -p "$targetDir"
    testBinary="$targetDir/build-setup.sh"
    cp bin/build/build-setup.sh "$testBinary"
    sed -i -e 's/^relTop=.*/relTop=..\/..\/../g' "$testBinary"
    chmod +x "$testBinary"
    marker=$(randomString)
    echo "# changed $marker" >>"$testBinary"

    if ! grep -q "$marker" "$testBinary"; then
        consoleError "binary $testBinary does not contain marker?"
        return $errEnv
    fi

    testOutput=$(mktemp)
    if ! $testBinary >"$testOutput"; then
        consoleError "Binary $testBinary failed"
        return $errEnv
    fi

    if ! grep -q "was updated" "$testOutput"; then
        consoleError "Missing was updated from $testBinary"
        failed "$testOutput"
    fi

    if [ ! -d "test.$$/bin/build" ]; then
        consoleError "binary $testBinary failed to do the job"
        return $errEnv
    fi
    if grep -q "$marker" "$testBinary"; then
        consoleError "binary $testBinary did not update itself as it should have"
        return $errEnv
    fi

    if ! $testBinary >"$testOutput"; then
        consoleError "Binary $testBinary failed 2nd round - ok as live script is dead"
        return $errEnv
    fi

    if ! grep -q "up to date" "$testOutput"; then
        consoleError "Missing up to date from $testBinary"
        failed "$testOutput"
    fi

    consoleSuccess "build-setup.sh update was tested successfully"
    rm -rf "$targetDir"
}

testUrlParse() {
    local u url user name password host port

    u=foo://user:hard-to-type@identity:4232/dbname

    eval "$(urlParse "$u")"

    assertEquals "$url" "$u"
    assertEquals "$user" user
    assertEquals "$name" dbname
    assertEquals "$host" identity
    assertEquals "$port" 4232
    assertEquals "$password" hard-to-type

    u=mysql://user:hard-to-type@identity/dbname

    eval "$(urlParse "$u")"

    assertEquals "$url" "$u"
    assertEquals "$user" user
    assertEquals "$name" dbname
    assertEquals "$host" identity
    assertEquals "$port" ""
    assertEquals "$password" hard-to-type
}
#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
testEnvMap
testBuildSetup
testUrlParse

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
    "bin/build/pipeline/composer.sh"
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
