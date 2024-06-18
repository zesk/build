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
  local testCount tests showTests testName quietLog=$1 __testDirectory resultCode=0 resultReason ignoreValues ignorePattern
  local __test __tests
  local __before __after changedGlobals

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
      statusMessage consoleInfo "Loading $1 ... "
      # shellcheck source=/dev/null
      if source "./test/tools/$1" 1>&2 > >(_environmentOutput source "./test/tools/$1"); then
        statusMessage consoleInfo "Loaded successfully ...":
      else
        resultReason="Include $1 failed"
        resultCode="$?"
      fi
      clearLine
      if [ "${#tests[@]}" -le "$testCount" ]; then
        statusMessage consoleError "No tests defined in ./test/tools/$1"
        resultReason="No tests defined in ./test/tools/$1 ${#tests[@]} <= $testCount"
        resultCode="$errorTest"
      fi
    fi
    shift
  done

  showTests=()
  for testName in "${tests[@]}"; do
    if [ "${testName:0:1}" != '#' ]; then
      showTests+=("$testName")
    fi
  done

  testCount="${#showTests[@]}"
  statusMessage consoleSuccess "Loaded $testCount $(plural "$testCount" test tests) \"${showTests[*]-}\" ..."
  printf "\n"

  # Renamed to avoid clobbering by tests
  __testDirectory=$(pwd)
  __tests=("${tests[@]}")
  __after=$(mktemp) || _environment mktemp || return $?
  __before="$__after.before"
  __after="$__after.after"

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

    # Set up state
    set -eou pipefail

    resultCode=0

    declare -p >"$__before"
    if ! "$__test" "$quietLog"; then
      resultCode=$errorTest
    fi
    cd "$__testDirectory"

    set -eou pipefail
    # So, `usage` can be overridden if it is made global somehow, declare -r prevents changing here
    # documentation-tests.sh change this apparently
    # Instead of preventing this usage, just work around it
    __usageEnvironment "_${FUNCNAME[0]}" cd "$__testDirectory" || return $?

    declare -p >"$__after"

    ignoreValues=(OLDPWD _ resultCode LINENO)
    ignorePattern="$(quoteGrepPattern "^($(joinArguments '|' "${ignoreValues[@]}"))=")"
    # printf "%s: \"%s\"\n" "$(consoleInfo "PATTERN")" "$(consoleMagenta "$ignorePattern")"

    # Diff before -> after
    # Only 'declare' lines
    # Remove unset variables (no `=`)
    # Remove lines with `-r` flags (READONLY)
    # Remove '< declare --` from each line (3 fields)
    # Remove `declare` and `flags` columns
    # Remove ignoredValues
    changedGlobals="$(diff "$__before" "$__after" | grep 'declare' | grep '=' | grep -v -e 'declare -[-a-z]*r ' | removeFields 3 | grep -v -e "$ignorePattern")" || :
    if grep -q -e 'COLUMNS\|LINES' < <(printf "%s\n" "$changedGlobals"); then
      consoleWarning "$__test set $(consoleValue "COLUMNS, LINES")"
      unset COLUMNS LINES
      changedGlobals="$(printf "%s\n" "$changedGlobals" | grep -v -e 'COLUMNS\|LINES' || :)" || __failEnvironment "$usage" "Removing COLUMNS and LINES from $changedGlobals" || return $?
    fi
    if [ -n "$changedGlobals" ]; then
      printf "%s\n" "$changedGlobals" | dumpPipe "$__test leaked local or export ($__before -> $__after)"
      resultCode=$errorTest
    fi

    if [ "$resultCode" -ne 0 ]; then
      printf "%s %s ...\n" "$(consoleCode "$__test")" "$(consoleRed "FAILED")" 1>&2
      buildFailed "$quietLog" || :
      resultReason="test $__test failed"
      break
    fi
    printf "%s %s ...\n" "$(consoleCode "$__test")" "$(consoleGreen "passed")"
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
  local errorCode="$errorTest" name
  export IFS
  printf "%s: %s - %s %s\n" "$(consoleError "Exit")" "$(consoleBoldRed "$errorCode")" "$(consoleError "Failed running")" "$(consoleInfo -n "$*")"
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
    testFailed "$(consoleInfo -n "$*")"
  fi
}

testCleanup() {
  rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws "$(buildCacheDirectory)" 2>/dev/null || :
}
