#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Test: o bin/build/tools/type.sh

testBinaryTypes() {
  local home handler="returnMessage"

  home=$(catchReturn "$handler" buildHome) || return $?
  catchEnvironment "$handler" muzzle pushd "$home" || return $?

  assertExitCode 0 isExecutable ./bin/build/map.sh || return $?
  assertExitCode 0 isExecutable ./bin/build/tools.sh || return $?

  assertNotExitCode 0 isCallable ./bin/build/LICENSE.md || return $?
  assertNotExitCode 0 isCallable ./bin/MISSING || return $?
  assertNotExitCode 0 isExecutable ./bin/build/LICENSE.md || return $?
  assertNotExitCode 0 isExecutable ./bin/MISSING || return $?

  catchEnvironment "$handler" muzzle popd || return $?
}
_testLineLabel() {
  printf "%s %s " "$(decorate info "$1")" "$(decorate code "$2")"
}
_testValidateMissingItems() {
  while IFS='' read -r testLine; do
    if ! assertNotExitCode 0 isCallable "$testLine"; then
      _testLineLabel _testValidateMissingItems "$testLine"
      return 1
    fi
    if ! assertNotExitCode 0 isExecutable "$testLine"; then
      _testLineLabel _testValidateMissingItems "$testLine"
      return 1
    fi
  done
}
_testValidateFunction() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isFunction "$testLine"; then
      _testLineLabel isFunction "$testLine"
      return 1
    fi
  done
}
_testValidateNotFunction() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isFunction "$testLine"; then
      _testLineLabel "NOT isFunction" "$testLine"
      return 1
    fi
  done
}
_testValidateExecutable() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isExecutable "$testLine"; then
      _testLineLabel "isExecutable" "$testLine"
      return 1
    fi
  done
}
_testValidateNotExecutable() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isExecutable "$testLine"; then
      _testLineLabel "NOT isExecutable" "$testLine"
      return 1
    fi
  done
}
_testValidateCallable() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isCallable "$testLine"; then
      _testLineLabel "isCallable" "$testLine"
      return 1
    fi
  done
}
_testValidateNotCallable() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isCallable "$testLine"; then
      _testLineLabel "NOT isCallable" "$testLine"
      return 1
    fi
  done
}

_dataCallableExecutables() {
  cat <<EOF
bin/build/map.sh
bin/build/cannon.sh
bin/build.sh
bin/test.sh
EOF
}

# Builtins count so source is a function! (. is excluded)
_dataCallableFunctions() {
  cat <<EOF
source
declare
echo
contextOpen
_dataCallableExecutables
_testValidateMissingItems
isUnsignedNumber
isCallable
EOF
}

# NOTHING Callable or Executable or Function
_dataSampleNotExecutable() {
  cat <<EOF
notAFile
/
.
..
$(pwd)
bin/build/README.md
bin/build/LICENSE.md
.gitignore
EOF

}

testNotExecutable() {
  _dataSampleNotExecutable | _testValidateMissingItems || return $?
  _dataSampleNotExecutable | _testValidateNotExecutable || return $?
}

testExecutableCallable() {
  local handler="returnMessage" home

  home=$(catchReturn "$handler" buildHome) || return $?
  catchEnvironment "$handler" muzzle pushd "$home" || return $?

  _dataCallableExecutables | _testValidateExecutable || return $?
  _dataCallableExecutables | _testValidateCallable || return $?
  _dataCallableExecutables | _testValidateNotFunction || return $?
  _dataCallableFunctions | grep -v echo | _testValidateNotExecutable || return $?
  _dataCallableFunctions | _testValidateCallable || return $?

  catchEnvironment "$handler" muzzle popd || return $?
}

_dataSignedIntegerSamples() {
  cat <<EOF
-1
-23
-4592312
-4912391293231
-987654321
-5318008
EOF
}

# must have no negative signs
_dataUnsignedIntegerSamples() {
  cat <<EOF
1
+0
+1
23
4592312
4912391293231
+4912391293231
987654321
5318008
EOF
}

# must be negative floats
_dataSignedNumberSamples() {
  cat <<EOF
-9999999999999.0
-512.4
-0.1
-1.0
-99.99
-531.8008
-6.022140769836232
-0.0
-1.0
EOF
}

# must have decimal
_dataUnsignedNumberSamples() {
  cat <<EOF
512.4
0.1
1.0
99.99
531.8008
6.0221407623
0.000
1.9999999999999999999999999999
111111111111111111111111111111.9999999999999999999999999999
EOF
}

# just plain bad
__badNumericSamples() {
  cat <<'EOF'
-6.02214076e23
NULL
NaN
null
0,0
0.0.0
1.2.3
127.0.0.1
--
-
*
+-1
--0
+0+
-0-
1-
0+
12+
12^
EOF
}

_testValidateSignedInteger() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isInteger "$testLine"; then
      _testLineLabel "isInteger" "$testLine"
      return 1
    fi
  done
}
_testValidateNotSignedInteger() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isInteger "$testLine"; then
      _testLineLabel "NOT isInteger" "$testLine"
      return 1
    fi
  done
}
_testValidateUnsignedInteger() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isUnsignedInteger "$testLine"; then
      _testLineLabel "isUnsignedInteger" "$testLine"
      return 1
    fi
  done
}
_testValidateNotUnsignedInteger() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isUnsignedInteger "$testLine"; then
      _testLineLabel "NOT isUnsignedInteger" "$testLine"
      return 1
    fi
  done
}
_testValidateUnsignedNumber() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isUnsignedNumber "$testLine"; then
      _testLineLabel "isUnsignedNumber" "$testLine"
      return 1
    fi
  done
}
_testValidateNotUnsignedNumber() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isUnsignedNumber "$testLine"; then
      _testLineLabel "NOT isUnsignedNumber" "$testLine"
      return 1
    fi
  done
}
_testValidateSignedNumber() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isNumber "$testLine"; then
      _testLineLabel "isNumber" "$testLine"
      return 1
    fi
  done
}
_testValidateNotSignedNumber() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isNumber "$testLine"; then
      _testLineLabel "NOT isNumber" "$testLine"
      return 1
    fi
  done
}

testSignedIntegerSamples() {
  #
  # signed Integer
  #

  # Unsigned/Signed integers are signed
  _dataSignedIntegerSamples | _testValidateSignedInteger || return $?
  _dataSignedIntegerSamples | _testValidateSignedNumber || return $?
  # Signed integers is not unsigned anything
  _dataSignedIntegerSamples | _testValidateNotUnsignedInteger || return $?
  _dataSignedIntegerSamples | _testValidateNotUnsignedNumber || return $?
}

testUn_dataSignedIntegerSamples() {

  #
  # unsigned Integer
  #

  # Unsigned integers are just unsigned
  statusMessage decorate info _testValidateUnsignedInteger
  _dataUnsignedIntegerSamples | _testValidateUnsignedInteger || return $?

  statusMessage decorate info _testValidateSignedInteger
  _dataUnsignedIntegerSamples | _testValidateSignedInteger || return $?

  # Unsigned integers are both signed and unsigned numbers
  statusMessage decorate info _testValidateUnsignedNumber
  _dataUnsignedIntegerSamples | _testValidateUnsignedNumber || return $?

  statusMessage decorate info _testValidateSignedNumber
  _dataUnsignedIntegerSamples | _testValidateSignedNumber || return $?
}

testSignedNumberSamples() {

  #
  # signed Number
  #
  statusMessage decorate code _testValidateSignedNumber
  _dataSignedNumberSamples | _testValidateSignedNumber || return $?
  statusMessage decorate code _testValidateNotUnsignedNumber
  _dataSignedNumberSamples | _testValidateNotUnsignedNumber || return $?
  # signed numbers are not integers, ever
  statusMessage decorate code _testValidateNotSignedInteger
  _dataSignedNumberSamples | _testValidateNotSignedInteger || return $?
  statusMessage decorate code _testValidateNotUnsignedInteger
  _dataSignedNumberSamples | _testValidateNotUnsignedInteger || return $?
}

testUn_dataSignedNumberSamples() {

  # Number are neither signed nor unsigned
  statusMessage decorate code _testValidateUnsignedNumber
  _dataUnsignedNumberSamples | _testValidateUnsignedNumber || return $?

  statusMessage decorate code _testValidateSignedNumber
  _dataUnsignedNumberSamples | _testValidateSignedNumber || return $?
  # unsigned numbers are not integers, ever

  statusMessage decorate code _testValidateNotSignedInteger
  _dataUnsignedNumberSamples | _testValidateNotSignedInteger || return $?

  statusMessage decorate code _testValidateNotUnsignedInteger
  _dataUnsignedNumberSamples | _testValidateNotUnsignedInteger || return $?
}

testBadNumericSamples() {
  #
  # Nothing is good
  #
  statusMessage decorate code _testValidateNotSignedInteger
  __badNumericSamples | _testValidateNotSignedInteger || return $?

  statusMessage decorate code _testValidateNotUnsignedInteger
  __badNumericSamples | _testValidateNotUnsignedInteger || return $?

  statusMessage decorate code _testValidateNotSignedNumber
  __badNumericSamples | _testValidateNotSignedNumber || return $?

  statusMessage decorate code _testValidateNotUnsignedNumber
  __badNumericSamples | _testValidateNotUnsignedNumber || return $?
}

__trueValues() {
  cat <<EOF
true
enabled
yes
y
1
2
3
4
5
1923
1924123
EOF
}

__falseValues() {
  cat <<EOF
false
disabled
no
n
0
null
00000

0.0
EOF
}

testIsTrue() {
  local value trues=()
  while read -r value; do
    assertExitCode 0 isTrue "$value" || return $?
    trues+=("$value")
  done < <(__trueValues)
  assertExitCode 0 isTrue "${trues[@]}" || return $?
  assertExitCode 0 isTrue "${trues[@]}" "${trues[@]}" || return $?
  while read -r value; do
    assertNotExitCode 0 isTrue "$value" || return $?
  done < <(__falseValues)
  assertNotExitCode 0 isTrue "${trues[@]}" "$value" || return $?
  assertNotExitCode 0 isTrue "$value" "${trues[@]}" || return $?
}

testPositiveIntegers() {
  assertExitCode 0 isPositiveInteger 1 || return $?
  assertExitCode 0 isPositiveInteger 1 || return $?
}

testIsArray() {
  local argument=""

  assertNotExitCode 0 isArray argument || return $?
  argument=234
  assertNotExitCode 0 isArray argument || return $?
  argument=
  assertNotExitCode 0 isArray argument || return $?

  local arrayArgument=()
  assertExitCode 0 isArray arrayArgument || return $?

  arrayArgument+=(1)
  assertExitCode 0 isArray arrayArgument || return $?

  muzzle printf "%s\n" "$argument" "${arrayArgument[@]}" || return $?
}
