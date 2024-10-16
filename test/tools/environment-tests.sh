#!/usr/bin/env bash
#
# environment-tests.sh
#
# Environment tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testDotEnvConfigure() {
  local tempDir tempEnv magic
  export TESTENVWORKS TESTENVLOCALWORKS

  magic=$(randomString)
  tempDir="$(__environment buildCacheDirectory)/$$.dotEnvConfig" || return $?

  __environment mkdir -p "$tempDir" || return $?
  __environment cd "$tempDir" || return $?
  consoleInfo "$(pwd)"
  assertNotExitCode --line "$LINENO" --stderr-match "is not file" 0 dotEnvConfigure || return $?

  tempEnv="$tempDir/.env"
  __environment touch "$tempEnv" || return $?
  __environment environmentValueWrite TESTENVWORKS "$magic" >>"$tempEnv" || return $?

  assertEquals --line "$LINENO" "" "${TESTENVWORKS-}" || return $?
  assertEquals --line "$LINENO" "" "${TESTENVLOCALWORKS-}" || return $?

  assertExitCode --leak TESTENVWORKS --line "$LINENO" 0 dotEnvConfigure --debug "$tempDir" || return $?
  dotEnvConfigure "$tempDir" || return $?

  assertEquals --line "$LINENO" "$magic" "${TESTENVWORKS-}" || return $?

  assertEquals --line "$LINENO" "" "${TESTENVLOCALWORKS-}" || return $?

  __environment environmentValueWrite TESTENVLOCALWORKS "$magic" >>"$tempEnv" || return $?
  __environment environmentValueWrite TESTENVWORKS "NEW-$magic" >>"$tempEnv" || return $?
  __environment touch .env.local || return $?

  dotEnvConfigure "$tempDir" || return $?
  assertExitCode --line "$LINENO" 0 dotEnvConfigure "$tempDir" || return $?

  assertEquals --line "$LINENO" "NEW-$magic" "${TESTENVWORKS-}" || return $?
  assertEquals --line "$LINENO" "$magic" "${TESTENVLOCALWORKS-}" || return $?

  __environment cd .. || return $?
  __environment rm -rf "$tempDir" || return $?
  consoleSuccess dotEnvConfigure works AOK

  unset TESTENVWORKS TESTENVLOCALWORKS
}

testEnvironmentFileLoad() {
  local tempDir envFile name=TESTVAR

  export "${name?}"

  set -eou pipefail

  tempDir="$(__environment buildCacheDirectory)/$$.${FUNCNAME[0]}" || return $?

  __environment mkdir -p "$tempDir" || return $?
  __environment muzzle pushd "$tempDir" || return $?

  envFile="$tempDir/.env"

  assertNotExitCode --stderr-match "is not file" --line "$LINENO" 0 environmentFileLoad "$envFile" || return $?

  __environment touch "$envFile" || return $?
  assertExitCode --line "$LINENO" 0 environmentFileLoad "$envFile" || return $?
  assertEquals --line "$LINENO" "${TESTVAR-}" "" || return $?

  envFile="$tempDir/.env.local"
  __environment touch "$envFile" || return $?
  assertExitCode --line "$LINENO" 0 dotEnvConfigure || _environment "dotEnvConfigure failed with both .env" || return $?

  envFile="$tempDir/.env.$name"
  printf "%s\n" "$name=worked" >"$envFile"

  assertEquals --line "$LINENO" "$(export "$name"=none && environmentFileLoad "$envFile" && printf "%s\n" "${!name-}")" "worked" || return $?
  assertEquals --line "$LINENO" "$(export "$name"=none && environmentFileLoad --ignore TESTVAR "$envFile" && printf "%s\n" "${!name-}")" "none" || return $?
  assertNotExitCode --line "$LINENO" 0 environmentFileLoad --secure TESTVAR "$envFile" || return $?

  unset TESTVAR

  __environment muzzle popd || return $?
  __environment rm -rf "$tempDir" || return $?
}

testEnvironmentFileMake() {
  local v
  (
    set -eou pipefail

    export TESTING_ENV=chameleon
    export DSN=mysql://not@host/thing

    export DEPLOY_USER_HOSTS=none
    export BUILD_TARGET=app2.tar.gz
    export DEPLOYMENT=test-application-environment
    export APPLICATION_ID=aabbccdd

    [ ! -f .env ] || rm .env
    environmentFileApplicationMake TESTING_ENV DSN >.env || return $?

    if [ ! -f .env ]; then
      _environment "environmentFileApplicationMake did not generate a .env file" || return $?
    fi
    for v in TESTING_ENV APPLICATION_BUILD_DATE APPLICATION_VERSION DSN; do
      if ! grep -q "$v" .env; then
        _environment "$(printf -- "%s %s\n%s" "environmentFileApplicationMake > .env file does not contain" "$(consoleCode "$v")" "$(wrapLines "$(consoleCode)    " "$(consoleReset)" <.env)")" || return $?
      fi
    done
    consoleGreen application-environment.sh works AOK
    rm .env
  )
}

testEnvironmentVariables() {
  local e
  e=$(mktemp)
  export BUILD_TEST_UNIQUE=1
  if ! environmentVariables >"$e"; then
    consoleError environmentVariables failed
    return 1
  fi
  assertFileContains --line "$LINENO" "$e" BUILD_TEST_UNIQUE HOME PATH PWD TERM SHLVL || return $?
  wrapLines "environmentVariables: $(consoleCode)" "$(consoleReset)" <"$e"
  rm "$e"

  unset BUILD_TEST_UNIQUE
}

__testEnvironmentValueReadWriteData() {
  cat <<'EOF'
hello This is a test
world Earth
argumentIndex 0
EOF
}

testEnvironmentValueReadWrite() {
  local foo

  foo=$(__environment mktemp) || return $?

  __testEnvironmentValueReadWriteData | while read -r testName testValue; do
    __environment environmentValueWrite "$testName" "$testValue" >>"$foo" || return $?
    value=$(__environment environmentValueRead "$foo" "$testName" "*default*") || return $?
    assertEquals --line "$LINENO" "$testValue" "$value" "Read write value changed" || return $?
  done
}

testEnvironmentValueWriteArray() {
  local testArrayText testArray testArrays index envFile restoredValue item

  envFile=$(__environment mktemp) || return $?
  testArrays=(
    "1:2:3:4:5"
    "a:b:c:de"
    "ten:twenty"
    "-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-"
    "':'':''':'''':''''':'''''"
  )

  assertExitCode --stdout-match "NAME=()" 0 environmentValueWriteArray NAME || return $?
  assertEquals --line "$LINENO" "NAME=([0]=\"\")" "$(environmentValueWriteArray NAME "")" || return $?
  assertEquals --line "$LINENO" "NAME=([0]=\"One\" [1]=\"Two\")" "$(environmentValueWriteArray NAME "One" "Two")" || return $?

  consoleNameValue 20 envFile "$envFile"
  index=0
  declare -a restoredValue
  for testArrayText in "${testArrays[@]}"; do
    IFS=":" read -r -a testArray <<<"$testArrayText"
    assertGreaterThan --line "$LINENO" ${#testArray[@]} 1 || return $?
    environmentValueWrite "STRING$index" "${testArray[@]}" >>"$envFile"
    environmentValueWriteArray "ARRAY$index" "${testArray[@]}" >>"$envFile"
    dumpPipe envFile <"$envFile"
    restoredValue=() && while read -r item; do restoredValue+=("$item"); done < <(__environment environmentValueReadArray "$envFile" "ARRAY$index" || return $?)
    assertEquals --line "$LINENO" "${#testArray[*]}" "${#restoredValue[*]}" || return $?
    assertEquals --line "$LINENO" "${testArray[*]}" "${restoredValue[*]}" || return $?
    restoredValue=() && while read -r item; do restoredValue+=("$item"); done < <(__environment environmentValueReadArray "$envFile" "STRING$index" || return $?)
    assertEquals --line "$LINENO" "${testArray[*]}" "${restoredValue[*]}" || return $?
    index=$((index + 1))
  done
}

__testEnvironmentNameValidPassValues() {
  environmentVariables
  cat <<'EOF'
ABC_DEF
____FOOOBAR1231
_112312312312
EOF
}

__testEnvironmentNameValidFailValues() {
  cat <<'EOF'
"QUOTES"
'Single quotes'
Dash-is-my-buddy
 LEADING_SPACE_IS_NO_BUENO
1____DIGIT_FIRST_SCHLECT
_112312312312^_BAD_POW
THIS MAY NOT WORK
[THINGS]
.EMPTY
$WOW
EOF
}

testEnvironmentNameValid() {
  local testValue IFS
  IFS=""
  while read -r testValue; do
    assertNotExitCode --line "$LINENO" 0 environmentVariableNameValid "$testValue" || return $?
  done < <(__testEnvironmentNameValidFailValues)
  while read -r testValue; do
    assertExitCode --line "$LINENO" 0 environmentVariableNameValid "$testValue" || return $?
  done < <(__testEnvironmentNameValidPassValues)
}
