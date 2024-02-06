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

unsignedIntegerSamples() {
  cat <<EOF
1
23
+4592312
4912391293231
987654321
+5318008
EOF
}

signedNumberSamples() {
  cat <<EOF
-9999999999999
-512.4
-0.1
-1.0
-99.99
-531.8008
-6.02214076e23
EOF
}

unsignedNumberSamples() {
  cat <<EOF
512.4
0.1
1.0
99.99
531.8008
6.0221407623
EOF
}

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

tests+=(testSignedUnsignedIntegerNumber)
testSignedUnsignedIntegerNumber() {
  #
  # signed Integer
  #

  # Unsigned/Signed integers are signed
  consoleInfo "signedIntegerSamples"
  signedIntegerSamples | validateSignedInteger  || return $?
  signedIntegerSamples | validateSignedNumber || return $?
  # Signed integers is not unsigned anything
  signedIntegerSamples | validateNotUnsignedInteger || return $?
  signedIntegerSamples | validateNotUnsignedNumber || return $?

  #
  # unsigned Integer
  #

  consoleInfo "unsignedIntegerSamples"
  # Unsigned integers are just unsigned
  unsignedIntegerSamples | validateUnsignedInteger || return $?
  unsignedIntegerSamples | validateNotSignedInteger || return $?
  unsignedIntegerSamples | validateSignedInteger || return $?
  # Unsigned integers are both signed and unsigned numbers
  unsignedIntegerSamples | validateUnsignedNumber || return $?
  unsignedIntegerSamples | validateSignedNumber || return $?

  #
  # signed Number
  #
  consoleInfo "signedNumberSamples"
  signedNumberSamples | validateSignedNumber || return $?
  signedNumberSamples | validateNotUnsignedNumber || return $?
  # signed numbers are not integers, ever
  signedNumberSamples | validateNotSignedInteger || return $?
  signedNumberSamples | validateNotUnsignedInteger || return $?

  #
  # unsigned Number
  #
  consoleInfo "unsignedNumberSamples"

  # Number are neither signed nor unsigned
  unsignedNumberSamples | validateUnsignedNumber || return $?
  unsignedNumberSamples | validateSignedNumber || return $?
  # unsigned numbers are not integers, ever
  unsignedNumberSamples | validateNotSignedInteger || return $?
  unsignedNumberSamples | validateNotUnsignedInteger || return $?

  consoleInfo "badNumericSamples"
  #
  # Nothing is good
  #
  badNumericSamples | validateNotSignedInteger || return $?
  badNumericSamples | validateNotUnsignedInteger || return $?
  badNumericSamples | validateNotSignedNumber || return $?
  badNumericSamples | validateNotUnsignedNumber || return $?
}
