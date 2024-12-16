#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Test: o bin/build/tools/type.sh

testBinaryTypes() {
  assertExitCode 0 isExecutable ./bin/build/map.sh || return $?
  assertExitCode 0 isExecutable ./bin/build/tools.sh || return $?

  assertNotExitCode 0 isCallable ./bin/build/LICENSE.md || return $?
  assertNotExitCode 0 isCallable ./bin/MISSING || return $?
  assertNotExitCode 0 isExecutable ./bin/build/LICENSE.md || return $?
  assertNotExitCode 0 isExecutable ./bin/MISSING || return $?
}
_testLineLabel() {
  printf "%s %s " "$(decorate info "$1")" "$(decorate code "$2")"
}
validateMissingItems() {
  while IFS='' read -r testLine; do
    if ! assertNotExitCode 0 isCallable "$testLine"; then
      _testLineLabel validateMissingItems "$testLine"
      return 1
    fi
    if ! assertNotExitCode 0 isExecutable "$testLine"; then
      _testLineLabel validateMissingItems "$testLine"
      return 1
    fi
  done
}
validateFunction() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isFunction "$testLine"; then
      _testLineLabel isFunction "$testLine"
      return 1
    fi
  done
}
validateNotFunction() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isFunction "$testLine"; then
      _testLineLabel "NOT isFunction" "$testLine"
      return 1
    fi
  done
}
validateExecutable() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isExecutable "$testLine"; then
      _testLineLabel "isExecutable" "$testLine"
      return 1
    fi
  done
}
validateNotExecutable() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isExecutable "$testLine"; then
      _testLineLabel "NOT isExecutable" "$testLine"
      return 1
    fi
  done
}
validateCallable() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isCallable "$testLine"; then
      _testLineLabel "isCallable" "$testLine"
      return 1
    fi
  done
}
validateNotCallable() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isCallable "$testLine"; then
      _testLineLabel "NOT isCallable" "$testLine"
      return 1
    fi
  done
}

callableExecutables() {
  cat <<EOF
bin/build/map.sh
bin/build/cannon.sh
bin/build.sh
bin/test.sh
EOF
}

# Builtins count so source is a function! (. is excluded)
callableFunctions() {
  cat <<EOF
source
declare
echo
contextOpen
callableExecutables
validateMissingItems
isUnsignedNumber
isCallable
EOF
}

# NOTHING Callable or Executable or Function
sampleNotExecutable() {
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
  sampleNotExecutable | validateMissingItems || return $?
  sampleNotExecutable | validateNotExecutable || return $?
}

testExecutableCallable() {
  callableExecutables | validateExecutable || return $?
  callableExecutables | validateCallable || return $?
  callableExecutables | validateNotFunction || return $?
  callableFunctions | grep -v echo | validateNotExecutable || return $?
  callableFunctions | validateCallable || return $?
}

signedIntegerSamples() {
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
unsignedIntegerSamples() {
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
signedNumberSamples() {
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
unsignedNumberSamples() {
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
badNumericSamples() {
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

validateSignedInteger() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isInteger "$testLine"; then
      _testLineLabel "isInteger" "$testLine"
      return 1
    fi
  done
}
validateNotSignedInteger() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isInteger "$testLine"; then
      _testLineLabel "NOT isInteger" "$testLine"
      return 1
    fi
  done
}
validateUnsignedInteger() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isUnsignedInteger "$testLine"; then
      _testLineLabel "isUnsignedInteger" "$testLine"
      return 1
    fi
  done
}
validateNotUnsignedInteger() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isUnsignedInteger "$testLine"; then
      _testLineLabel "NOT isUnsignedInteger" "$testLine"
      return 1
    fi
  done
}
validateUnsignedNumber() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isUnsignedNumber "$testLine"; then
      _testLineLabel "isUnsignedNumber" "$testLine"
      return 1
    fi
  done
}
validateNotUnsignedNumber() {
  while IFS="" read -r testLine; do
    if ! assertNotExitCode 0 isUnsignedNumber "$testLine"; then
      _testLineLabel "NOT isUnsignedNumber" "$testLine"
      return 1
    fi
  done
}
validateSignedNumber() {
  while IFS="" read -r testLine; do
    if ! assertExitCode 0 isNumber "$testLine"; then
      _testLineLabel "isNumber" "$testLine"
      return 1
    fi
  done
}
validateNotSignedNumber() {
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
  signedIntegerSamples | validateSignedInteger || return $?
  signedIntegerSamples | validateSignedNumber || return $?
  # Signed integers is not unsigned anything
  signedIntegerSamples | validateNotUnsignedInteger || return $?
  signedIntegerSamples | validateNotUnsignedNumber || return $?
}

testUnsignedIntegerSamples() {

  #
  # unsigned Integer
  #

  # Unsigned integers are just unsigned
  statusMessage decorate info validateUnsignedInteger
  unsignedIntegerSamples | validateUnsignedInteger || return $?

  statusMessage decorate info validateSignedInteger
  unsignedIntegerSamples | validateSignedInteger || return $?

  # Unsigned integers are both signed and unsigned numbers
  statusMessage decorate info validateUnsignedNumber
  unsignedIntegerSamples | validateUnsignedNumber || return $?

  statusMessage decorate info validateSignedNumber
  unsignedIntegerSamples | validateSignedNumber || return $?
}

testSignedNumberSamples() {

  #
  # signed Number
  #
  statusMessage decorate code validateSignedNumber
  signedNumberSamples | validateSignedNumber || return $?
  statusMessage decorate code validateNotUnsignedNumber
  signedNumberSamples | validateNotUnsignedNumber || return $?
  # signed numbers are not integers, ever
  statusMessage decorate code validateNotSignedInteger
  signedNumberSamples | validateNotSignedInteger || return $?
  statusMessage decorate code validateNotUnsignedInteger
  signedNumberSamples | validateNotUnsignedInteger || return $?
}

testUnsignedNumberSamples() {

  # Number are neither signed nor unsigned
  statusMessage decorate code validateUnsignedNumber
  unsignedNumberSamples | validateUnsignedNumber || return $?

  statusMessage decorate code validateSignedNumber
  unsignedNumberSamples | validateSignedNumber || return $?
  # unsigned numbers are not integers, ever

  statusMessage decorate code validateNotSignedInteger
  unsignedNumberSamples | validateNotSignedInteger || return $?

  statusMessage decorate code validateNotUnsignedInteger
  unsignedNumberSamples | validateNotUnsignedInteger || return $?
}

testBadNumericSamples() {
  #
  # Nothing is good
  #
  statusMessage decorate code validateNotSignedInteger
  badNumericSamples | validateNotSignedInteger || return $?

  statusMessage decorate code validateNotUnsignedInteger
  badNumericSamples | validateNotUnsignedInteger || return $?

  statusMessage decorate code validateNotSignedNumber
  badNumericSamples | validateNotSignedNumber || return $?

  statusMessage decorate code validateNotUnsignedNumber
  badNumericSamples | validateNotUnsignedNumber || return $?
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
    assertExitCode --line "$LINENO" 0 isTrue "$value" || return $?
    trues+=("$value")
  done < <(__trueValues)
  assertExitCode --line "$LINENO" 0 isTrue "${trues[@]}" || return $?
  assertExitCode --line "$LINENO" 0 isTrue "${trues[@]}" "${trues[@]}" || return $?
  while read -r value; do
    assertNotExitCode --line "$LINENO" 0 isTrue "$value" || return $?
  done < <(__falseValues)
  assertNotExitCode --line "$LINENO" 0 isTrue "${trues[@]}" "$value" || return $?
  assertNotExitCode --line "$LINENO" 0 isTrue "$value" "${trues[@]}" || return $?
}

testPositiveIntegers() {
  assertExitCode --line "$LINENO" 0 isPositiveInteger 1 || return $?
  assertExitCode --line "$LINENO" 0 isPositiveInteger 1 || return $?
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
