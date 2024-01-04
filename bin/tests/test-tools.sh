#!/usr/bin/env bash
#
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

errorTest=3

testSection() {
  boxedHeading --size 0 "$@"
}

testHeading() {
  whichApt toilet toilet >/dev/null 2>&1
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
  local fileCount testCount tests=() testName quietLog=$1 testDirectory resultCode=0

  shift
  statusMessage consoleWarning "Loading tests ..."
  fileCount="$#"
  while [ "$#" -gt 0 ]; do
    testName="$(cleanTestName "$1")"
    tests+=("#$testName") # Section
    testCount=${#tests[@]}
    statusMessage consoleError "Loading test section \"$testName\""
    # shellcheck source=/dev/null
    . "./bin/tests/$1"
    clearLine
    if [ "${#tests[@]}" -le "$testCount" ]; then
      consoleError "No tests defined in ./bin/tests/$1"
      resultCode="$errorTest"
    fi
    shift
  done
  testCount=$((${#tests[@]} - fileCount))
  statusMessage consoleSuccess "Loaded $testCount $(plural "$testCount" test tests) \"${tests[*]}\" ..."
  echo
  testDirectory=$(pwd)
  while [ ${#tests[@]} -gt 0 ]; do
    test="${tests[0]}"
    # Section
    if [ "${test#\#}" != "$test" ]; then
      testHeading "${test#\#}"
    else
      # Test
      testSection "${test#\#}"
      if ! "$test" "$quietLog"; then
        cd "$testDirectory" || return $?
        consoleError "$test failed" 1>&2
        return "$errorTest"
      fi
      cd "$testDirectory" || return $?
      consoleSuccess "$test passed"
    fi
    unset 'tests[0]'
    tests=("${tests[@]+${tests[@]}}")
  done
  return $resultCode
}

testFailed() {
  local errorCode="$errorTest"
  printf "%s: %s - %s %s\n" "$(consoleError "Exit")" "$(consoleBoldRed "$errorCode")" "$(consoleError "Failed running")" "$(consoleInfo -n "$*")"
  exit "$errorCode"
}
requireTestFiles() {
  if ! loadTestFiles "$@"; then
    testFailed "$(consoleInfo -n "$*")"
  fi
}

testCleanup() {
  rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws "$(buildCacheDirectory)" 2>/dev/null || :
}
