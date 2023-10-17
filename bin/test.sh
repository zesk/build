#!/usr/bin/env bash
#
# test.sh
#
# Testing
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Test locally:
# bin/local-container.sh
# . bin/test-reset.sh; bin/test.sh

set -eo pipefail
# set -x

errorArgument=2
quietLog="./.build/$me.log"

me=$(basename "$0")
top=$(pwd)
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# echo "TERM=$TERM"

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# shellcheck source=/dev/null
. ./bin/tests/api-tests.sh
# shellcheck source=/dev/null
. ./bin/tests/assert.sh
# shellcheck source=/dev/null
. ./bin/tests/aws-tests.sh
# shellcheck source=/dev/null
. ./bin/tests/bin-tests.sh
# shellcheck source=/dev/null
. ./bin/tests/test-tools.sh

usageArguments() {
    echo "--help This help"
    echo "--clean Delete test artifact files before starting"
}

usage() {
    local result

    result=$1
    shift
    if [ $# -gt 0 ]; then
        consoleError "$*"
        echo
    fi
    echo
    consoleInfo "$me [ --clean ] - Test Zesk Build"
    echo
    usageArguments | usageGenerator "$(maximumFieldLength | usageArguments)"
    exit "$result"
}
testCleanup() {
    cd "$top"
    rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws ./.build/ 2>/dev/null || :
}

while [ $# -gt 0 ]; do
    case $1 in
    --clean)
        consoleWarning -n "Cleaning ... "
        testCleanup
        consoleSuccess "done"
        ;;
    *)
        usage "$errorArgument" "Unknown argument $1"
        ;;
    esac
    shift
done
trap testCleanup EXIT QUIT TERM

#  _____         _
# |_   _|__  ___| |_
#   | |/ _ \/ __| __|
#   | |  __/\__ \ |_
#   |_|\___||___/\__|
#
testSection Whoa, dude.

bigText allColorTest | prefixLines "$(consoleMagenta)"
allColorTest
echo
bigText colorTest | prefixLines "$(consoleGreen)"
colorTest
echo

testSection API Tests

testTools
testUrlParse
testDotEnvConfigure
testHooks
testEnvironmentVariables

testSection bin Tests
testMakeEnv
testBuildSetup
testEnvMap

requireFileDirectory "$quietLog"
testScripts "$quietLog" # has side-effects
testScriptIntallations  # has side-effects

testSection AWS Tests
testAWSExpiration
testAWSIPAccess "$quietLog" # has side-effects

testCleanup

bigText Passed | prefixLines "$(consoleSuccess)"
