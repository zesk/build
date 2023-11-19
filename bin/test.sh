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

# IDENTICAL errorArgument 1
errorArgument=2

errorTest=3

set -eo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."
top=$(pwd)

# echo "TERM=$TERM"

# shellcheck source=/dev/null
. ./bin/build/tools.sh

me=$(basename "$0")
quietLog=$(buildQuietLog "$me")

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
    rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws "$(buildCacheDirectory)" 2>/dev/null || :
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

cleanTestName() {
    local testName
    testName="${1%%.sh}"
    testName="${testName%%-test}"
    testName="${testName%%-tests}"
    testName=${testName##tests-}
    testName=${testName##test-}
    printf %s "$testName"
}
loadTestFiles() {
    local testCount tests=() testName quietLog=$1

    shift
    statusMessage consoleWarning "Loading tests ..."
    while [ "$#" -gt 0 ]; do
        testName="$(cleanTestName "$1")"
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
            testHeading "${test#\#}"
        else
            # Test
            testSection "${test#\#}"
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

loadTestFiles "$quietLog" documentation-tests.sh docker-tests.sh text-tests.sh colors-tests.sh api-tests.sh aws-tests.sh usage-tests.sh deploy-tests.sh

# Side effects - install the software
loadTestFiles "$quietLog" bin-tests.sh

# tests-tests.sh has side-effects - installs shellcheck
loadTestFiles "$quietLog" tests-tests.sh

# aws-tests.sh testAWSIPAccess has side-effects, installs AWS
loadTestFiles "$quietLog" aws-tests.sh

for binTest in ./bin/tests/bin/*.sh; do
    testHeading "$(cleanTestName "$(basename "$binTest")")"
    "$binTest" "$(pwd)"
done

testCleanup

bigText Passed | prefixLines "$(consoleSuccess)"
consoleReset
