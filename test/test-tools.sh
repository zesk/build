#!/usr/bin/env bash
#
# test-tools.sh
#
# Test tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

export testTracing
export globalTestFailure=

errorTest=3

shortTestCodes() {
  local fileName
  find test/ -type f -name '*-tests.sh' | while IFS= read -r fileName; do
    fileName=$(basename "$fileName")
    printf "%s\n" "${fileName%-tests.sh}"
  done
}

didAnyTestsFail() {
  export globalTestFailure

  globalTestFailure=${globalTestFailure:-}
  if test "$globalTestFailure"; then
    printf %s "$globalTestFailure"
    return 0
  fi
  return 1
}
testSection() {
  boxedHeading --size 0 "$@"
}

testHeading() {
  whichApt toilet toilet 2>/dev/null 1>&2 || _environment "Unable to install toilet" || return $?
  printf "%s" "$(consoleCode)"
  consoleOrange "$(echoBar '*')"
  printf "%s" "$(consoleCode)$(clearLine)"
  bigText "$@" | wrapLines "  $(consoleCode)" "$(consoleReset)"
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

#
# Load one or more test files and run the tests defined within
#
# Usage: {fn} filename [ ... ]
# Argument: filename - File. Required. File located at `./test/tools/` and must be a valid shell file.
#
loadTestFiles() {
  local testCount tests showTests testName quietLog=$1 testDirectory resultCode=0 resultReason
  # IDENTICAL this_usage 4
  local this usage

  this="${FUNCNAME[0]}"
  usage="_$this"

  export tests
  resultReason="Success"
  shift
  statusMessage consoleWarning "Loading tests ..."
  tests=()
  while [ "$#" -gt 0 ]; do
    testName="$(cleanTestName "$1")"
    tests+=("#$testName") # Section
    statusMessage consoleError "Loading test section \"$testName\""
    if ! isExecutable "./test/tools/$1"; then
      printf "\n%s %s (working directory: %s)\n\n" "$(consoleError "Unable to load")" "$(consoleCode "./test/tools/$1")" "$(consoleInfo "$(pwd)")"
      resultReason="Not executable"
      resultCode="$errorTest"
    else
      testCount=${#tests[@]}
      # shellcheck source=/dev/null
      if . "./test/tools/$1"; then
        :
      else
        resultReason="Include $1 failed"
        resultCode="$?"
      fi
      clearLine
      if [ "${#tests[@]}" -le "$testCount" ]; then
        consoleError "No tests defined in ./test/tools/$1"
        resultReason="No tests defined in ./test/tools/$1 ${#tests[@]} <= $testCount"
        resultCode="$errorTest"
      fi
    fi
    shift
  done
  showTests=()
  for test in "${tests[@]}"; do
    if [ "${test#\#}" = "$test" ]; then
      showTests+=("$test")
    fi
  done
  testCount="${#showTests[@]}"
  statusMessage consoleSuccess "Loaded $testCount $(plural "$testCount" test tests) \"${showTests[*]}\" ..."
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
      printf "%s %s ...\n" "$(consoleInfo "Running")" "$(consoleCode "$test")"
      set -eou pipefail
      if ! "$test" "$quietLog"; then
        resultCode=$errorTest
      fi
      set +x
      set -eou pipefail
      __usageEnvironment "$usage" cd "$testDirectory" || return $?
      if [ "$resultCode" -ne 0 ]; then
        printf "%s %s ...\n" "$(consoleCode "$test")" "$(consoleRed "FAILED")" 1>&2
        buildFailed "$quietLog" || :
        resultReason="test failed"
        return "$resultCode"
      fi
      printf "%s %s ...\n" "$(consoleCode "$test")" "$(consoleGreen "passed")"
    fi
    unset 'tests[0]'
    tests=("${tests[@]+${tests[@]}}")
  done
  if [ "$resultCode" -eq 0 ] && resultReason=$(didAnyTestsFail); then
    # Should probably reset test status but ...
    resultCode=$errorTest
  fi
  if [ "$resultCode" -ne 0 ]; then
    printf "resultReason: %s\n" "$(consoleMagenta "$resultReason")"
  fi
  return $resultCode
}
_loadTestFiles() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

testFailed() {
  local errorCode="$errorTest"
  printf "%s: %s - %s %s\n" "$(consoleError "Exit")" "$(consoleBoldRed "$errorCode")" "$(consoleError "Failed running")" "$(consoleInfo -n "$*")"
  export globalTestFailure="$*"
  return "$errorCode"
}

#
# Usage: {fn}
#
requireTestFiles() {
  testTracing="$2"
  if ! loadTestFiles "$@"; then
    testFailed "$(consoleInfo -n "$*")"
  fi
}

testCleanup() {
  rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws "$(buildCacheDirectory)" 2>/dev/null || :
}
