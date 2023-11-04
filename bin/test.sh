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
. ./bin/tests/aws-tests.sh
# shellcheck source=/dev/null
. ./bin/tests/bin-tests.sh
# shellcheck source=/dev/null
. ./bin/tests/text-tests.sh
# shellcheck source=/dev/null
. ./bin/tests/deploy-tests.sh
# shellcheck source=/dev/null
. ./bin/tests/test-tools.sh

usageArguments() {
    echo "--help This help"
    echo "--clean Delete test artifact files before starting"
    echo "--messy Do not delete test artifact files afterwards"
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
    consoleInfo "$me [ --clean ] [ --messy ] - Test Zesk Build"
    echo
    usageArguments | usageGenerator $(("$(usageArguments | maximumFieldLength)" + 2))
    echo
    consoleReset
    exit "$result"
}

messyOption=

testCleanup() {
    cd "$top"
    if test "$messyOption"; then
        return 0
    fi
    rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws ./.build/ 2>/dev/null || :
}

while [ $# -gt 0 ]; do
    case $1 in
    --clean)
        consoleWarning -n "Cleaning ... "
        testCleanup
        consoleSuccess "done"
        ;;
    --messy)
        messyOption=1
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
testSection Deployment
deployApplicationTest

testSection Whoa, dude.

bigText allColorTest | prefixLines "$(consoleMagenta)"
allColorTest
echo
bigText colorTest | prefixLines "$(consoleGreen)"
colorTest
echo

testSection API Tests
testEnvMap
testTools
testUrlParse
testDotEnvConfigure
testHooks
testEnvironmentVariables
testDates

testSection Text Tests
testText

testSection bin Tests
testEnvmapPortability
testMakeEnv
testBuildSetup
testEnvMap

requireFileDirectory "$quietLog"
testShellScripts "$quietLog" # has side-effects
testScriptInstallations      # has side-effects

testSection AWS Tests
testAWSExpiration
testAWSIPAccess "$quietLog" # has side-effects

testSection "crontab-application-sync.sh (ops)"
./bin/tests/test-crontab-application-sync.sh -v | prefixLines "$(consoleCode)"

testSection "setup-git-test.sh"
./bin/tests/setup-git-test.sh "$(pwd)"

testCleanup

bigText Passed | prefixLines "$(consoleSuccess)"
