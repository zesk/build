#!/usr/bin/env bash
#
# environment-tests.sh
#
# Environment tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testDotEnvConfigure() {
  local tempDir tempEnv magic
  export TESTENVWORKS TESTENVLOCALWORKS

  magic=$(randomString)
  tempDir="$(__environment buildCacheDirectory)/$$.dotEnvConfig" || return $?

  __environment mkdir -p "$tempDir" || return $?
  __environment muzzle pushd "$tempDir" || return $?
  decorate info "$(pwd)"
  assertNotExitCode --stderr-match "is not file" 0 environmentFileLoad .env --optional .env.local || return $?

  tempEnv="$tempDir/.env"
  __environment touch "$tempEnv" || return $?
  __environment environmentValueWrite TESTENVWORKS "$magic" >>"$tempEnv" || return $?

  assertEquals "" "${TESTENVWORKS-}" || return $?
  assertEquals "" "${TESTENVLOCALWORKS-}" || return $?

  assertExitCode --leak TESTENVWORKS 0 environmentFileLoad .env --optional .env.local "$tempDir" || return $?
  environmentFileLoad .env --optional .env.local "$tempDir" || return $?

  # Support no files
  assertExitCode 0 environmentFileLoad --optional .env.local.Never .env.whatever.local || return $?

  assertEquals "$magic" "${TESTENVWORKS-}" || return $?

  assertEquals "" "${TESTENVLOCALWORKS-}" || return $?

  __environment environmentValueWrite TESTENVLOCALWORKS "$magic" >>"$tempEnv" || return $?
  __environment environmentValueWrite TESTENVWORKS "NEW-$magic" >>"$tempEnv" || return $?
  __environment touch "$tempDir/.env.local" || return $?

  #echo "PWD is $(pwd)"
  #environmentFileLoad --debug .env --optional .env.local || return $?
  assertExitCode 0 environmentFileLoad .env --optional .env.local || return $?

  assertEquals "NEW-$magic" "${TESTENVWORKS-}" || return $?
  assertEquals "$magic" "${TESTENVLOCALWORKS-}" || return $?

  __environment muzzle popd || return $?
  __environment rm -rf "$tempDir" || return $?

  unset TESTENVWORKS TESTENVLOCALWORKS
}

testEnvironmentFileLoad() {
  local tempDir envFile name=TESTVAR

  export "${name?}"

  set -eou pipefail

  __mockValue BUILD_DEBUG

  assertExitCode --stderr-match "Requires at least one environmentFile" --stderr-match "Safely load an environment file" 2 environmentFileLoad || return $?

  __mockValue BUILD_DEBUG "" --end

  tempDir="$(__environment buildCacheDirectory)/$$.${FUNCNAME[0]}" || return $?

  __environment mkdir -p "$tempDir" || return $?
  [ -d "$tempDir" ] || _environment "Creating $tempDir failed" || return $?

  __environment muzzle pushd "$tempDir" || return $?
  [ -d "$tempDir" ] || _environment "$tempDir disappeared" || return $?

  envFile="$tempDir/.env"

  assertNotExitCode --stderr-match "is not file" 0 environmentFileLoad "$envFile" || return $?

  [ -d "$tempDir" ] || _environment "$tempDir disappeared" || return $?
  __environment touch "$envFile" || return $?
  assertExitCode 0 environmentFileLoad "$envFile" || return $?
  assertEquals "${TESTVAR-}" "" || return $?

  envFile="$tempDir/.env.local"
  assertExitCode 0 environmentFileLoad --optional .env.local || _environment "environmentFileLoad --optional .env.local failed" || return $?

  [ -d "$tempDir" ] || _environment "$tempDir disappeared" || return $?
  __environment touch "$envFile" || return $?
  assertExitCode 0 environmentFileLoad .env --optional .env.local || _environment "environmentFileLoad .env --optional .env.local failed with both .env" || return $?

  envFile="$tempDir/.env.$name"
  printf "%s\n" "$name=worked" >"$envFile"

  assertEquals "$(export "$name"=none && environmentFileLoad "$envFile" && printf "%s\n" "${!name-}")" "worked" || return $?
  assertEquals "$(export "$name"=none && environmentFileLoad --ignore TESTVAR "$envFile" && printf "%s\n" "${!name-}")" "none" || return $?
  assertNotExitCode --stderr-match "secure value" 0 environmentFileLoad --secure TESTVAR "$envFile" || return $?

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
        _environment "$(printf -- "%s %s\n%s" "environmentFileApplicationMake > .env file does not contain" "$(decorate code "$v")" "$(wrapLines "$(decorate code)    " "$(decorate reset)" <.env)")" || return $?
      fi
    done
    decorate green application-environment.sh works AOK
    rm .env
  )
}

testEnvironmentVariables() {
  local e
  e=$(mktemp)
  export BUILD_TEST_UNIQUE=1
  if ! environmentVariables >"$e"; then
    decorate error environmentVariables failed
    return 1
  fi
  assertFileContains "$e" BUILD_TEST_UNIQUE HOME PATH PWD TERM SHLVL || return $?
  wrapLines "environmentVariables: $(decorate code)" "$(decorate reset)" <"$e"
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
    assertEquals "$testValue" "$value" "Read write value changed" || return $?
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
  assertEquals "NAME=([0]=\"\")" "$(environmentValueWriteArray NAME "")" || return $?
  assertEquals "NAME=([0]=\"One\" [1]=\"Two\")" "$(environmentValueWriteArray NAME "One" "Two")" || return $?

  decorate pair 20 envFile "$envFile"
  index=0
  declare -a restoredValue
  for testArrayText in "${testArrays[@]}"; do
    IFS=":" read -r -a testArray <<<"$testArrayText"
    assertGreaterThan ${#testArray[@]} 1 || return $?
    environmentValueWrite "STRING$index" "${testArray[@]}" >>"$envFile"
    environmentValueWriteArray "ARRAY$index" "${testArray[@]}" >>"$envFile"
    # dumpPipe envFile <"$envFile"
    restoredValue=() && while read -r item; do restoredValue+=("$item"); done < <(__environment environmentValueReadArray "$envFile" "ARRAY$index" || return $?)
    assertEquals "${#testArray[*]}" "${#restoredValue[*]}" || return $?
    assertEquals "${testArray[*]}" "${restoredValue[*]}" || return $?
    restoredValue=() && while read -r item; do restoredValue+=("$item"); done < <(__environment environmentValueReadArray "$envFile" "STRING$index" || return $?)
    assertEquals "${testArray[*]}" "${restoredValue[*]}" || return $?
    index=$((index + 1))
  done
}

__testEnvironmentNameValidPassValues() {
  cat <<'EOF'
AWS_SECRET_ACCESS_KEY
BUILD_HOME
CI
KUBERNETES_PORT
PWD
__CFBundleIdentifier
__TEST_SUITE_CLEAN_EXIT
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
  local testValue

  while IFS="" read -r testValue; do
    assertNotExitCode 0 environmentVariableNameValid "$testValue" || return $?
  done < <(__testEnvironmentNameValidFailValues)
  while IFS="" read -r testValue; do
    assertExitCode 0 environmentVariableNameValid "$testValue" || return $?
  done < <(__testEnvironmentNameValidPassValues)
}

testEnvironmentValueReadDefault() {
  local envFile

  envFile=$(__environment mktemp) || return $?

  __environment environmentValueWrite Greeting Hello >>"$envFile" || return $?
  __environment environmentValueWrite Target World >>"$envFile" || return $?

  assertExitCode --stdout-match Hello 0 environmentValueRead "$envFile" Greeting || return $?

  assertExitCode 1 environmentValueRead "$envFile" Salutation || return $?
  assertExitCode 0 environmentValueRead "$envFile" Salutation "" || return $?
  assertExitCode --stdout-match "Bonjour" 0 environmentValueRead "$envFile" Salutation "Bonjour" || return $?

  assertExitCode --stdout-match World 0 environmentValueRead "$envFile" Target || return $?

  assertExitCode --stderr-ok 1 environmentValueRead "$envFile" TARGET || return $?
  assertExitCode 0 environmentValueRead "$envFile" TARGET "" || return $?
  assertExitCode --stdout-match "Paris" 0 environmentValueRead "$envFile" TARGET "Paris" || return $?

  __environment rm -rf "$envFile" || return $?
}

testEnvironmentOutput() {
  local envFile

  envFile=$(fileTemporaryName "_return") || return $?

  export ZESK_BUILD_ROCKS
  export __HIDE_THIS_STUFF
  export _HIDE_THIS_STUFF

  ZESK_BUILD_ROCKS="$(date)"
  __HIDE_THIS_STUFF=FAIL
  _HIDE_THIS_STUFF=FAIL

  __environment environmentOutput >>"$envFile" || return $?

  assertFileContains "$envFile" ZESK_BUILD_ROCKS= || return $?
  assertFileDoesNotContain "$envFile" "FAIL" || return $?
  assertFileDoesNotContain "$envFile" "HIDE_THIS" || return $?
  assertExitCode 0 grep -e "^ZESK_BUILD_ROCKS=" "$envFile" || return $?
  while read -r envName; do
    assertExitCode 0 grep -v -e "^$envName=" "$envFile" || return $?
  done < <(environmentSecureVariables)

  unset ZESK_BUILD_ROCKS __HIDE_THIS_STUFF _HIDE_THIS_STUFF

  __environment rm -rf "$envFile" || return $?
}
