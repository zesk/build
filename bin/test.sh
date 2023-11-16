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

# IDENTICAL errorArgument 1
errorArgument=2

errorTest=3

quietLog="./.build/$me.log"

me=$(basename "$0")
top=$(pwd)
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# echo "TERM=$TERM"

# shellcheck source=/dev/null
. ./bin/build/tools.sh

# shellcheck source=/dev/null
. ./bin/tests/test-tools.sh

usageOptions() {
    cat <<EOF
--help This help
--clean Delete test artifact files before starting
--messy Do not delete test artifact files afterwards
EOF
}

usage() {
    usageMain "$me" "$@"
    exit "$?"
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

loadTestFiles() {
    local testCount tests=() testName quietLog=$1

    shift
    boxedHeading "Loading tests"
    while [ "$#" -gt 0 ]; do
        testName="${1%%.sh}"
        testName="${testName%%-test}"
        testName="${testName%%-tests}"
        tests+=("#$testName") # Section
        testCount=${#tests[@]}
        statusMessage consoleError "$testName"
        # shellcheck source=/dev/null
        . "./bin/tests/$1"
        clearLine
        printf "%s" "$(assertGreaterThan "$testCount" "${#tests[@]}" "No tests defined in ./bin/tests/$1")"
        shift
    done
    statusMessage consoleSuccess "Loaded ${#tests[@]} tests ..."
    echo
    while [ ${#tests[@]} -gt 0 ]; do
        test="${tests[0]}"
        # Section
        if [ "${test#\#}" != "$test" ]; then
            testSection "${test#\#}"
        else
            # Test
            testHeading "${test#\#}"
            if ! $test "$quietLog"; then
                consoleError "$test failed" 1>&2
                return $errorTest
            fi
        fi
        unset 'tests[0]'
        tests=("${tests[@]}")
    done
    return 0
}

requireFileDirectory "$quietLog"

# Unusual quoting here is to avoid matching HERE
./bin/build/identical-check.sh --extension sh --prefix '# ''IDENTICAL'

loadTestFiles "$quietLog" docker-tests.sh text-tests.sh colors-tests.sh api-tests.sh aws-tests.sh usage-tests.sh deploy-tests.sh

testShellScripts "$quietLog" # has side-effects

# aws-tests.sh testAWSIPAccess has side-effects

# Side effects
loadTestFiles bin-tests.sh

for binTest in ./bin/tests/bin/*.sh; do
    testHeading "$(basename "${binTest%%.sh}")"
    "$binTest" "$(pwd)" | prefixLines "$(consoleCode)"
done

testCleanup

bigText Passed | prefixLines "$(consoleSuccess)"
