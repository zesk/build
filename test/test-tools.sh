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

__testCodes() {
  local fileName
  find test/ -type f -name '*-tests.sh' | while IFS= read -r fileName; do
    fileName=$(basename "$fileName")
    printf "%s\n" "${fileName%-tests.sh}"
  done
}

__testDidAnythingFail() {
  export globalTestFailure

  globalTestFailure=${globalTestFailure:-}
  if test "$globalTestFailure"; then
    printf %s "$globalTestFailure"
    return 0
  fi
  return 1
}

__testSection() {
  [ -n "$*" ] || _argument "Blank argument $(debuggingStack)"
  clearLine
  boxedHeading --size 0 "$@"
}

__testHeading() {
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

#
# Load one or more test files and run the tests defined within
#
# Usage: {fn} filename [ ... ]
# Argument: filename - File. Required. File located at `./test/tools/` and must be a valid shell file.
#
__testLoad() {
  local usage="_${FUNCNAME[0]}"
  local tests __testDirectory resultCode stickyCode resultReason
  local __test __tests tests

  __beforeFunctions=$(__usageEnvironment "$usage" mktemp) || return $?
  __testFunctions="$__beforeFunctions.after"
  __tests=()
  while [ "$#" -gt 0 ]; do
    __usageEnvironment "$usage" isExecutable "./test/tools/$1" || _clean $? "$__beforeFunctions" "$__testFunctions" || return $?

    declare -pF | removeFields 2 | grep -e '^test' >"$__beforeFunctions"
    tests=()
    # shellcheck source=/dev/null
    source "./test/tools/$1" 1>&2 || __failEnvironment source "./test/tools/$1" || _clean $? "$__beforeFunctions" "$__testFunctions" || return $?

    declare -pF | removeFields 2 | grep -e '^test' | diff "$__beforeFunctions" - | grep -e '^[<>]' | cut -c 3- >"$__testFunctions" || :
    [ "${#tests[@]}" -gt 0 ] || break
    __tests+=("${tests[@]}")
    while read -r __test; do
      inArray "$__test" "${tests[@]}" || consoleError "$(clearLine)Test defined but not run: $(consoleCode "$__test")" 1>&2
      __tests+=("$__test")
    done <"$__testFunctions"
    shift
  done
  rm -rf "$__beforeFunctions" "$__testFunctions" || :
  printf "%s\n" "${__tests[@]}"
}
___testLoad() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Load one or more test files and run the tests defined within
#
# Usage: {fn} filename [ ... ]
# Argument: filename - File. Required. File located at `./test/tools/` and must be a valid shell file.
#
__testRun() {
  local usage="_${FUNCNAME[0]}"
  local quietLog="$1"
  local tests testName __testDirectory resultCode stickyCode resultReason
  local __test __tests tests
  local __beforeFunctions errorTest

  export testTracing
  export resultReason

  errorTest=$(_code test)
  stickyCode=0
  shift || :

  # Renamed to avoid clobbering by tests
  __testDirectory=$(pwd)

  resultReason=AOK
  while [ $# -gt 0 ]; do
    __test="$1"
    shift
    # Test
    __testSection "$__test" || :
    printf "%s %s ...\n" "$(consoleInfo "Running")" "$(consoleCode "$__test")"

    printf "%s\n" "Running $__test" >>"$quietLog"
    resultCode=0
    testTracing="$__test"
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
  if [ "$stickyCode" -eq 0 ] && resultReason=$(__testDidAnythingFail); then
    # Should probably reset test status but ...
    stickyCode=$errorTest
  fi
  if [ "$stickyCode" -ne 0 ]; then
    printf "%s %s\n" "$(consoleLabel "Reason:")" "$(consoleMagenta "$resultReason")"
  fi
  return "$stickyCode"
}
___testRun() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__testMatches() {
  local testName match

  testName=$(lowercase "$1")
  shift
  while [ "$#" -gt 0 ]; do
    match=$(lowercase "$1")
    if [ "${testName#*"$match"}" != "$testName" ]; then
      return 0
    fi
    shift
  done
  return 1
}

__testFailed() {
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
__testCleanup() {
  __environment rm -rf ./vendor/ ./node_modules/ ./composer.json ./composer.lock ./test.*/ ./aws "$(buildCacheDirectory)" || :
}
