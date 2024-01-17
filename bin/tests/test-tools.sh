#!/usr/bin/env bash
#
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

export testTracing

# IDENTICAL errorEnvironment 1
errorEnvironment=1

errorTest=3

testSection() {
  boxedHeading --size 0 "$@"
}

testHeading() {
  if ! whichApt toilet toilet 2>/dev/null 1>&2; then
    consoleError "Unable to install toilet" 1>&2
    return $errorEnvironment
  fi
  printf "%s" "$(consoleCode)"
  consoleOrange "$(echoBar '*')"
  printf "%s" "$(consoleCode)$(clearLine)"
  bigText "$@" | prefixLines "  $(consoleCode)"
  consoleOrange "$(echoBar)"
  consoleReset
}

debugTermDisplay() {
  printf "TERM: %s DISPLAY: %s\n" "${TERM-none}" "${DISPLAY-none} hasColors: $(
    hasColors
    printf %d $?
  )"
}

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
  local fileCount testCount tests testName quietLog=$1 testDirectory resultCode=0 resultReason

  export tests
  resultReason="Success"
  shift
  statusMessage consoleWarning "Loading tests ..."
  fileCount="$#"
  tests=()
  while [ "$#" -gt 0 ]; do
    testName="$(cleanTestName "$1")"
    tests+=("#$testName") # Section
    statusMessage consoleError "Loading test section \"$testName\""
    if ! isExecutable "./bin/tests/$1"; then
      printf "\n%s %s (working directory: %s)\n\n" "$(consoleError "Unable to load")" "$(consoleCode "./bin/tests/$1")" "$(consoleInfo "$(pwd)")"
      resultReason="Not executable"
      resultCode="$errorTest"
    else
      testCount=${#tests[@]}
      # shellcheck source=/dev/null
      . "./bin/tests/$1"
      clearLine
      if [ "${#tests[@]}" -le "$testCount" ]; then
        consoleError "No tests defined in ./bin/tests/$1"
        resultReason="No tests defined in ./bin/tests/$1 ${#tests[@]} <= $testCount"
        resultCode="$errorTest"
      fi
    fi
    shift
  done
  testCount=$((${#tests[@]} - fileCount))
  statusMessage consoleSuccess "Loaded $testCount $(plural "$testCount" test tests) \"${tests[*]}\" ..."
  printf "\n"
  testDirectory=$(pwd)
  while [ ${#tests[@]} -gt 0 ]; do
    test="${tests[0]}"
    # Section
    if [ "${test#\#}" != "$test" ]; then
      testHeading "${test#\#}"
    else
      # Test
      testSection "${test#\#}"
      printf "%s %s ...\n" "$(consoleCyan "Running")" "$(consoleCode "$test")"
      if ! "$test" "$quietLog"; then
        cd "$testDirectory" || return $?
        printf "%s %s ...\n" "$(consoleCode "$test")" "$(consoleRed "FAILED")" 1>&2
        buildFailed "$quietLog"
        resultReason="test failed"
        return "$errorTest"
      fi
      cd "$testDirectory" || return $?
      printf "%s %s ...\n" "$(consoleCode "$test")" "$(consoleGreen "passed")"
    fi
    unset 'tests[0]'
    tests=("${tests[@]+${tests[@]}}")
  done
  printf "resultReason: %s\n" "$(consoleMagenta "$resultReason")"
  return $resultCode
}

testFailed() {
  local errorCode="$errorTest"
  printf "%s: %s - %s %s\n" "$(consoleError "Exit")" "$(consoleBoldRed "$errorCode")" "$(consoleError "Failed running")" "$(consoleInfo -n "$*")"
  return "$errorCode"
}
requireTestFiles() {
  testTracing="$2"
  if ! loadTestFiles "$@"; then
    testFailed "$(consoleInfo -n "$*")"
  fi
}

testCleanup() {
  printf "Call Stack: %s\n" "$(printf "\n    %s" "${FUNCNAME[@]}")"
  rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws "$(buildCacheDirectory)" 2>/dev/null || :
}
