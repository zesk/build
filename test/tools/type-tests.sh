#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Test: o bin/build/tools/type.sh
export tests

declare -a tests

tests+=(testBinaryTypes)
testBinaryTypes() {
  assertExitCode 0 isExecutable ./bin/build/map.sh || return $?
  assertExitCode 0 isExecutable ./bin/build/tools.sh || return $?

  assertNotExitCode 0 isCallable ./bin/build/LICENSE.md || return $?
  assertNotExitCode 0 isCallable ./bin/MISSING || return $?
  assertNotExitCode 0 isExecutable ./bin/build/LICENSE.md || return $?
  assertNotExitCode 0 isExecutable ./bin/MISSING || return $?
}
_testLineLabel() {
  printf "%s %s\n" "$(consoleInfo "$1")" "$(consoleCode "$2")"
}
validateMissingItems() {
  while IF='' read -r testLine; do
    _testLineLabel validateMissingItems "$testLine"
    if ! assertNotExitCode 0 isCallable "$testLine"; then
      return 1
    fi
    if ! assertNotExitCode 0 isExecutable "$testLine"; then
      return 1
    fi
  done
}
validateFunction() {
  while IF="" read -r testLine; do
    _testLineLabel isFunction "$testLine"
    if ! assertExitCode 0 isFunction "$testLine"; then
      return 1
    fi
  done
}
validateNotFunction() {
  while IF="" read -r testLine; do
    _testLineLabel "NOT isFunction" "$testLine"
    if ! assertNotExitCode 0 isFunction "$testLine"; then
      return 1
    fi
  done
}
validateExecutable() {
  while IF="" read -r testLine; do
    _testLineLabel "isExecutable" "$testLine"
    if ! assertExitCode 0 isExecutable "$testLine"; then
      return 1
    fi
  done
}
validateNotExecutable() {
  while IF="" read -r testLine; do
    _testLineLabel "NOT isExecutable" "$testLine"
    if ! assertNotExitCode 0 isExecutable "$testLine"; then
      return 1
    fi
  done
}
validateCallable() {
  while IF="" read -r testLine; do
    _testLineLabel "isCallable" "$testLine"
    if ! assertExitCode 0 isCallable "$testLine"; then
      return 1
    fi
  done
}
validateNotCallable() {
  while IF="" read -r testLine; do
    _testLineLabel "NOT isCallable" "$testLine"
    if ! assertNotExitCode 0 isCallable "$testLine"; then
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

callableFunctions() {
  cat <<EOF
contextOpen
executableFiles
validateMissingItems
isUnsignedNumber
isCallable
EOF
}

# NOTHING Callable or Executable or Functino
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

tests+=(testNotExecutable)
testNotExecutable() {
  sampleNotExecutable | validateMissingItems
}

tests+=(testExecutableCallable)
testExecutableCallable() {
  callableExecutables | validateExecutable
  callableExecutables | validateCallable
  callableExecutables | validateNotFunction
  callableFunctions | validateNotExecutable
  callableFunctions | validateCallable
  callableFunctions | validateNotExecutable
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
  while IF="" read -r testLine; do
    _testLineLabel "isInteger" "$testLine"
    if ! assertExitCode 0 isInteger "$testLine"; then
      return 1
    fi
  done
}
validateNotSignedInteger() {
  while IF="" read -r testLine; do
    _testLineLabel "NOT isInteger" "$testLine"
    if ! assertNotExitCode 0 isInteger "$testLine"; then
      return 1
    fi
  done
}
validateUnsignedInteger() {
  while IF="" read -r testLine; do
    _testLineLabel "isUnsignedInteger" "$testLine"
    if ! assertExitCode 0 isUnsignedInteger "$testLine"; then
      return 1
    fi
  done
}
validateNotUnsignedInteger() {
  while IF="" read -r testLine; do
    _testLineLabel "NOT isUnsignedInteger" "$testLine"
    if ! assertNotExitCode 0 isUnsignedInteger "$testLine"; then
      return 1
    fi
  done
}
validateUnsignedNumber() {
  while IF="" read -r testLine; do
    _testLineLabel "isUnsignedNumber" "$testLine"
    if ! assertExitCode 0 isUnsignedNumber "$testLine"; then
      return 1
    fi
  done
}
validateNotUnsignedNumber() {
  while IF="" read -r testLine; do
    _testLineLabel "NOT isUnsignedNumber" "$testLine"
    if ! assertNotExitCode 0 isUnsignedNumber "$testLine"; then
      return 1
    fi
  done
}
validateSignedNumber() {
  while IF="" read -r testLine; do
    _testLineLabel "isNumber" "$testLine"
    if ! assertExitCode 0 isNumber "$testLine"; then
      return 1
    fi
  done
}
validateNotSignedNumber() {
  while IF="" read -r testLine; do
    _testLineLabel "NOT isNumber" "$testLine"
    if ! assertNotExitCode 0 isNumber "$testLine"; then
      return 1
    fi
  done
}

tests+=(testSignedIntegerSamples)
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

tests+=(testUnsignedIntegerSamples)
testUnsignedIntegerSamples() {

  #
  # unsigned Integer
  #

  consoleInfo "unsignedIntegerSamples"
  # Unsigned integers are just unsigned
  consoleInfo validateUnsignedInteger
  unsignedIntegerSamples | validateUnsignedInteger || return $?
  consoleInfo validateSignedInteger
  unsignedIntegerSamples | validateSignedInteger || return $?
  # Unsigned integers are both signed and unsigned numbers
  consoleInfo validateUnsignedNumber
  unsignedIntegerSamples | validateUnsignedNumber || return $?
  consoleInfo validateSignedNumber
  unsignedIntegerSamples | validateSignedNumber || return $?
}

tests+=(testSignedNumberSamples)
testSignedNumberSamples() {

  #
  # signed Number
  #
  consoleCode validateSignedNumber
  signedNumberSamples | validateSignedNumber || return $?
  consoleCode validateNotUnsignedNumber
  signedNumberSamples | validateNotUnsignedNumber || return $?
  # signed numbers are not integers, ever
  consoleCode validateNotSignedInteger
  signedNumberSamples | validateNotSignedInteger || return $?
  consoleCode validateNotUnsignedInteger
  signedNumberSamples | validateNotUnsignedInteger || return $?
}

tests+=(testUnsignedNumberSamples)
testUnsignedNumberSamples() {

  # Number are neither signed nor unsigned
  consoleCode validateUnsignedNumber
  unsignedNumberSamples | validateUnsignedNumber || return $?
  consoleCode validateSignedNumber
  unsignedNumberSamples | validateSignedNumber || return $?
  # unsigned numbers are not integers, ever
  consoleCode validateNotSignedInteger
  unsignedNumberSamples | validateNotSignedInteger || return $?
  consoleCode validateNotUnsignedInteger
  unsignedNumberSamples | validateNotUnsignedInteger || return $?
}

tests+=(testBadNumericSamples)
testBadNumericSamples() {
  #
  # Nothing is good
  #
  consoleCode validateNotSignedInteger
  badNumericSamples | validateNotSignedInteger || return $?
  consoleCode validateNotUnsignedInteger
  badNumericSamples | validateNotUnsignedInteger || return $?
  consoleCode validateNotSignedNumber
  badNumericSamples | validateNotSignedNumber || return $?
  consoleCode validateNotUnsignedNumber
  badNumericSamples | validateNotUnsignedNumber || return $?
}
