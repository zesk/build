#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Not sure how scopes work in Bash so here's one way to figure it out
#
set -eou pipefail

width=50
savedValue=$(fileTemporaryName _return)

_loadTools() {
  # shellcheck source=/dev/null
  if ! . "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh"; then
    return 1
  fi
  testTools :
}
_subprocessClearValue() {
  printf "%s" "" >"$savedValue"
}
_subprocessSaveValue() {
  printf "%s" "${TESTING-}" >"$savedValue"
}

_subprocessSavedValue() {
  cat "$savedValue"
}

_fail() {
  printf "\n%s\n" "$(decorate error "$@")" 1>&2
  exit "1"
}
_loadTools || _fail "_loadTools"

scopeTestDeclare() {
  declare -x TESTING
  TESTING=${TESTING:-"Totally"}
  _subprocessSaveValue
}
scopeTestDeclarePlusX() {
  declare +x TESTING
  TESTING=${TESTING:-"Totally"}
  _subprocessSaveValue
}

scopeTestExport() {
  export TESTING
  TESTING=${TESTING:-"Totally"}
  _subprocessSaveValue
}

scopeTestNada() {
  TESTING=${TESTING:-"Totally"}
  _subprocessSaveValue
}

scopeTestSetA() {
  set -a
  TESTING=${TESTING:-"Totally"}
  set +a
  _subprocessSaveValue
}

scopeDeleteIt() {
  export -n TESTING

  TESTING=${TESTING:-"Totally"}
  _subprocessSaveValue
}

testsWhichReturnBlank() {
  printf "%s\n" scopeTestDeclare scopeTestDeclarePlusX
}
testsWhichAppearToWork() {
  printf "%s\n" scopeTestExport scopeTestNada scopeTestSetA scopeDeleteIt
}

_subprocessAssertValue() {
  printf "%s %s" "$(decorate code "$(alignLeft "$width" "$2") ")" " -> "
  assertEquals "$1" "$(_subprocessSavedValue)" "_subprocessAssertValue $2 buildFailed " || _fail "_subprocessAssertValue $*"
}
_scopeAssert() {
  printf "%s %s" "$(decorate code "$(alignLeft "$width" "$3") ")" " -> "
  assertEquals "$1" "$2" "$3 failed" || _fail "$1 $2 $3"
}

#
# Refrain from refactoring this as scope is the test so scope MUST be explicit
#

#
############################################################################################
#
# Reset
#
export -n TESTING
unset TESTING
set +a

testName="Undeclared"
boxedHeading "$testName"
for func in $(testsWhichReturnBlank); do
  fullName="$testName $func"
  # -- precondition --
  _scopeAssert "" "${TESTING-}" "$fullName init"
  _subprocessAssertValue "" "$fullName init"
  # -- test --
  if ! "$func"; then
    _fail "$func failed"
  fi
  _scopeAssert "" "${TESTING-}" "$fullName"
  _subprocessAssertValue "Totally" "$fullName"
  # -- cleanup --
  export -n TESTING && unset TESTING && set +a && _subprocessClearValue
done
for func in $(testsWhichAppearToWork); do
  fullName="$testName $func"
  # -- precondition --
  _scopeAssert "" "${TESTING-}" "$fullName init"
  _subprocessAssertValue "" "$fullName init"
  # -- test --
  if ! "$func"; then
    _fail "$func failed"
  fi
  _scopeAssert "Totally" "${TESTING-}" "$fullName"
  _subprocessAssertValue "Totally" "$fullName"
  # -- cleanup --
  export -n TESTING && unset TESTING && set +a && _subprocessClearValue
done

############################################################################################
#
# Reset
#
export -n TESTING && unset TESTING && set +a && _subprocessClearValue

testName="export TESTING first"
boxedHeading "$testName"
for func in $(testsWhichReturnBlank); do
  fullName="$testName $func"
  # -- precondition --
  _scopeAssert "" "${TESTING-}" "$fullName init"
  _subprocessAssertValue "" "$fullName init"
  # -- test --
  export TESTING
  if ! "$func"; then
    _fail "$func failed"
  fi
  _scopeAssert "" "${TESTING-}" "$fullName"
  _subprocessAssertValue "Totally" "$fullName"
  # -- cleanup --
  export -n TESTING && unset TESTING && set +a && _subprocessClearValue
done

for func in $(testsWhichAppearToWork); do
  fullName="$testName $func"
  # -- precondition --
  _scopeAssert "" "${TESTING-}" "$fullName init"
  _subprocessAssertValue "" "$fullName init"
  # -- test --
  if ! "$func"; then
    _fail "$func failed"
  fi
  _scopeAssert "Totally" "${TESTING-}" "$fullName"
  _subprocessAssertValue "Totally" "$fullName"

  # -- cleanup --
  export -n TESTING && unset TESTING && set +a && _subprocessClearValue
done

############################################################################################
#
# Reset
#
export -n TESTING && unset TESTING && set +a && _subprocessClearValue

testName="set -a"

boxedHeading "$testName"
for func in $(testsWhichReturnBlank); do
  fullName="$testName $func"
  # -- precondition --
  _scopeAssert "" "${TESTING-}" "$fullName init"
  _subprocessAssertValue "" "$fullName init"
  # -- test --
  set -a
  if ! "$func"; then
    _fail "$func failed"
  fi
  _scopeAssert "" "${TESTING-}" "$fullName"
  _subprocessAssertValue "Totally" "$fullName"
  # -- cleanup --
  export -n TESTING && unset TESTING && set +a && _subprocessClearValue
done
for func in $(testsWhichAppearToWork); do
  fullName="$testName $func"
  # -- precondition --
  _scopeAssert "" "${TESTING-}" "$fullName init"
  _subprocessAssertValue "" "$fullName init"
  # -- test --
  if ! "$func"; then
    _fail "$func failed"
  fi
  _scopeAssert "${TESTING-}" "Totally" "$fullName"
  _subprocessAssertValue "Totally" "$fullName"
  # -- cleanup --
  export -n TESTING && unset TESTING && set +a && _subprocessClearValue
done

############################################################################################
#
# Reset
#
set +a
export -n TESTING
unset TESTING

function testLocalScope() {
  local TESTING

  testName="local scope"
  boxedHeading "$testName"
  for func in $(testsWhichReturnBlank); do
    fullName="$testName $func"
    # -- precondition --
    _scopeAssert "" "${TESTING-}" "$fullName init"
    _subprocessAssertValue "" "$fullName init"
    # -- test --
    if ! "$func"; then
      _fail "$func failed"
    fi
    _scopeAssert "${TESTING-}" "" "$fullName"
    _subprocessAssertValue "Totally" "$fullName"
    # -- cleanup --
    export -n TESTING && unset TESTING && set +a && _subprocessClearValue
  done
  for func in $(testsWhichAppearToWork); do
    fullName="$testName $func"
    # -- precondition --
    _scopeAssert "" "${TESTING-}" "$fullName init"
    _subprocessAssertValue "" "$fullName init"
    # -- test --
    if ! "$func"; then
      _fail "$func failed"
    fi
    _scopeAssert "${TESTING-}" "Totally" "$fullName"
    _subprocessAssertValue "Totally" "$testName $func"
    # -- cleanup --
    export -n TESTING && unset TESTING && set +a && _subprocessClearValue
  done
}

############################################################################################
#
# Reset
#
set +a
export -n TESTING
unset TESTING

testLocalScope

rm "$savedValue"

decorate bold-red 'Conclusion: Do not use declare -x in any function - locks scope to existing function and subprocesses'
