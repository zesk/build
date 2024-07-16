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
  clearLine
  boxedHeading --size 0 "$@"
}

testHeading() {
  whichApt toilet toilet 2>/dev/null 1>&2 || _environment "Unable to install toilet" || return $?
  consoleCode "$(consoleOrange "$(echoBar '*')")"
  printf "%s" "$(consoleCode)$(clearLine)"
  bigText "$@" | wrapLines --fill " " "$(consoleCode)    " "$(consoleReset)"
  consoleCode "$(consoleOrange "$(echoBar '=')")"
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
  local testCount tests showTests testName quietLog=$1 __testDirectory resultCode stickyCode resultReason
  local __test __tests tests
  local __beforeFunctions errorTest

  errorTest=$(_code test)
  stickyCode=0

  __beforeFunctions=$(mktemp) || _environment mktemp || return $?
  __testFunctions=$(mktemp) || _environment mktemp || return $?
  resultReason="Success"
  shift
  statusMessage consoleWarning "Loading tests ..."
  __tests=()
  while [ "$#" -gt 0 ]; do
    testName="$(cleanTestName "$1")"
    tests=("#$testName") # Section
    statusMessage consoleError "Loading test section \"$testName\""
    if ! isExecutable "./test/tools/$1"; then
      printf "\n%s %s (working directory: %s)\n\n" "$(consoleError "Unable to load")" "$(consoleCode "./test/tools/$1")" "$(consoleInfo "$(pwd)")"
      resultReason="Not executable"
      stickyCode="$errorTest"
    else
      testCount=${#tests[@]}
      statusMessage consoleInfo "Loading $1 ... "

      declare -pF | removeFields 2 | grep -e '^test' >"$__beforeFunctions"
      # shellcheck source=/dev/null
      if source "./test/tools/$1" 1>&2 > >(_environmentOutput source "./test/tools/$1"); then
        statusMessage consoleInfo "Loaded successfully ...":
      else
        resultReason="Include $1 failed"
        stickyCode="$errorTest"
      fi
      declare -pF | removeFields 2 | grep -e '^test' | diff "$__beforeFunctions" - | grep -e '^[<>]' | cut -c 3- >"$__testFunctions"
      if [ "${#tests[@]}" -le "$testCount" ]; then
        statusMessage consoleError "No tests defined in ./test/tools/$1"
        resultReason="No tests defined in ./test/tools/$1 ${#tests[@]} <= $testCount"
        stickyCode="$errorTest"
      else
        __tests+=("${tests[@]}")
      fi
      while read -r __test; do
        inArray "$__test" "${tests[@]}" || consoleError "Test defined but not run: $(consoleCode "$__test")"
      done <"$__testFunctions"
      clearLine
    fi
    shift
  done
  rm -rf "$__beforeFunctions" "$__testFunctions" || :

  showTests=()
  for testName in "${__tests[@]}"; do
    if [ "${testName:0:1}" != '#' ]; then
      showTests+=("$testName")
    fi
  done

  testCount="${#showTests[@]}"
  statusMessage consoleSuccess "Loaded $testCount $(plural "$testCount" test tests) \"${showTests[*]-}\" ..."
  printf "\n"

  # Renamed to avoid clobbering by tests
  __testDirectory=$(pwd)

  # Set up state
  while [ ${#__tests[@]} -gt 0 ]; do
    __test="${__tests[0]}"
    unset '__tests[0]'
    __tests=("${__tests[@]+${__tests[@]}}")
    # Section
    if [ "${__test#\#}" != "$__test" ]; then
      testHeading "${__test#\#}" || :
      continue
    fi
    # Test
    testSection "$__test" || :
    printf "%s %s ...\n" "$(consoleInfo "Running")" "$(consoleCode "$__test")"

    printf "%s\n" "Running $__test" >>"$quietLog"
    resultCode=0
    if plumber "$__test" "$quietLog"; then
      printf "%s\n" "SUCCESS $__test" >>"$quietLog"
    else
      resultCode=$?
      printf "%s\n" "FAILED $__test" >>"$quietLog"
      stickyCode=$errorTest
    fi

    # So, `usage` can be overridden if it is made global somehow, declare -r prevents changing here
    # documentation-tests.sh change this apparently
    # Instead of preventing this usage, just work around it
    __usageEnvironment "_${FUNCNAME[0]}" cd "$__testDirectory" || return $?

    if [ "$resultCode" = "$(_code leak)" ]; then
      resultCode=0
      printf "%s %s ...\n" "$(consoleCode "$__test")" "$(consoleWarning "passed with leaks")"
    elif [ "$resultCode" -eq 0 ]; then
      printf "%s %s ...\n" "$(consoleCode "$__test")" "$(consoleGreen "passed")"
    else
      printf "[%d] %s %s\n" "$resultCode" "$(consoleCode "$__test")" "$(consoleError "FAILED")" 1>&2
      buildFailed "$quietLog" || :
      resultReason="test $__test failed"
      stickyCode=$errorTest
      break
    fi
  done
  if [ "$stickyCode" -eq 0 ] && resultReason=$(didAnyTestsFail); then
    # Should probably reset test status but ...
    stickyCode=$errorTest
  fi
  if [ "$stickyCode" -ne 0 ]; then
    printf "%s %s\n" "$(consoleLabel "Reason:")" "$(consoleMagenta "$resultReason")"
  fi
  return "$stickyCode"
}
_loadTestFiles() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

testFailed() {
  local errorCode name

  errorCode="$(_code test)"
  export IFS
  printf "%s: %s - %s %s\n" "$(consoleError "Exit")" "$(consoleBoldRed "$errorCode")" "$(consoleError "Failed running")" "$(consoleInfo "$*")"
  for name in IFS HOME LINES COLUMNS OSTYPE PPID PID; do
    printf "%s=%s\n" "$(consoleLabel "$name")" "$(consoleValue "${!name-}")"
  done
  export globalTestFailure="$*"
  return "$errorCode"
}

#
# Usage: {fn}
#
requireTestFiles() {
  testTracing="$2"
  if ! loadTestFiles "$@"; then
    testFailed "$(consoleInfo "$*")"
  fi
}

testCleanup() {
  __environment rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws "$(buildCacheDirectory)" || :
}
