#!/usr/bin/env bash
#
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

export testTracing

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
    if ! isExecutable "./bin/tests/$1"; then
      printf "\n%s %s (working directory: %s)\n\n" "$(consoleError "Unable to load")" "$(consoleCode "./bin/tests/$1")" "$(consoleInfo "$(pwd)")"
      resultCode="$errorTest"
    else
      . "./bin/tests/$1"
      clearLine
      if [ "${#tests[@]}" -le "$testCount" ]; then
        consoleError "No tests defined in ./bin/tests/$1"
        resultCode="$errorTest"
      fi
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
      printf "%s %s ...\n" "$(consoleCyan "Running")" "$(consoleCode "$test")"
      if ! "$test" "$quietLog"; then
        cd "$testDirectory" || return $?
      printf "%s %s ...\n" "$(consoleCode "$test")" "$(consoleRed "FAILED")" 1>&2
        return "$errorTest"
      fi
      cd "$testDirectory" || return $?
      printf "%s %s ...\n" "$(consoleCode "$test")" "$(consoleGreen "passed")"
    fi
    unset 'tests[0]'
    tests=("${tests[@]+${tests[@]}}")
  done
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
  rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws "$(buildCacheDirectory)" 2>/dev/null || :
}
