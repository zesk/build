#!/usr/bin/env bash
#
# environment-tests.sh
#
# Environment tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testEnvironmentAddFile() {
  local handler="returnMessage"

  assertFileDoesNotExist "$home/bin/env/FOOBAR.sh" || return $?
  assertExitCode 0 environmentAddFile FOOBAR || return $?
  assertFileExists "$home/bin/env/FOOBAR.sh" || return $?
  returnCatch "$handler" rm -f "$home/bin/env/FOOBAR.sh" || return $?
}

testDotEnvConfigure() {
  local tempDir tempEnv magic
  export TESTENVWORKS TESTENVLOCALWORKS

  magic=$(randomString)
  tempDir="$(returnCatch "$handler" buildCacheDirectory)/$$.dotEnvConfig" || return $?

  returnCatch "$handler" directoryRequire "$tempDir" || return $?
  catchEnvironment "$handler" muzzle pushd "$tempDir" || return $?
  assertNotExitCode --stderr-match "is not file" 0 environmentFileLoad .env --optional .env.local || return $?

  tempEnv="$tempDir/.env"

  catchEnvironment "$handler" touch "$tempEnv" || return $?
  returnCatch "$handler" environmentValueWrite TESTENVWORKS "$magic" >>"$tempEnv" || return $?

  assertEquals "" "${TESTENVWORKS-}" || return $?
  assertEquals "" "${TESTENVLOCALWORKS-}" || return $?

  assertExitCode --leak TESTENVWORKS 0 environmentFileLoad .env --optional .env.local || return $?
  environmentFileLoad .env --optional .env.local || return $?

  # Support no files
  assertExitCode 0 environmentFileLoad --optional .env.local.Never .env.whatever.local || return $?

  assertEquals "$magic" "${TESTENVWORKS-}" || return $?

  assertEquals "" "${TESTENVLOCALWORKS-}" || return $?

  returnCatch "$handler" environmentValueWrite TESTENVLOCALWORKS "$magic" >>"$tempEnv" || return $?
  returnCatch "$handler" environmentValueWrite TESTENVWORKS "NEW-$magic" >>"$tempEnv" || return $?
  catchEnvironment "$handler" touch "$tempDir/.env.local" || return $?

  environmentFileLoad .env --optional .env.local || return $?
  assertExitCode 0 environmentFileLoad .env --optional .env.local || return $?

  assertEquals "NEW-$magic" "${TESTENVWORKS-}" || return $?
  assertEquals "$magic" "${TESTENVLOCALWORKS-}" || return $?

  catchEnvironment "$handler" muzzle popd || return $?
  catchEnvironment "$handler" rm -rf "$tempDir" || return $?

  unset TESTENVWORKS TESTENVLOCALWORKS
}

testEnvironmentFileLoad() {
  local tempDir envFile name=TESTVAR

  export "${name?}"

  set -eou pipefail

  mockEnvironmentStart BUILD_DEBUG

  assertExitCode --stderr-match "Requires at least one environmentFile" --stderr-match "Safely load an environment file" 2 environmentFileLoad || return $?

  mockEnvironmentStop BUILD_DEBUG

  tempDir="$(returnCatch "$handler" buildCacheDirectory)/$$.${FUNCNAME[0]}" || return $?

  catchEnvironment "$handler" mkdir -p "$tempDir" || return $?
  [ -d "$tempDir" ] || returnEnvironment "Creating $tempDir failed" || return $?

  catchEnvironment "$handler" muzzle pushd "$tempDir" || return $?
  [ -d "$tempDir" ] || returnEnvironment "$tempDir disappeared" || return $?

  envFile="$tempDir/.env"

  assertNotExitCode --stderr-match "is not file" 0 environmentFileLoad "$envFile" || return $?

  [ -d "$tempDir" ] || returnEnvironment "$tempDir disappeared" || return $?
  catchEnvironment "$handler" touch "$envFile" || return $?
  assertExitCode 0 environmentFileLoad "$envFile" || return $?
  assertEquals "${TESTVAR-}" "" || return $?

  envFile="$tempDir/.env.local"
  assertExitCode 0 environmentFileLoad --optional .env.local || returnEnvironment "environmentFileLoad --optional .env.local failed" || return $?

  [ -d "$tempDir" ] || returnEnvironment "$tempDir disappeared" || return $?
  catchEnvironment "$handler" touch "$envFile" || return $?
  assertExitCode 0 environmentFileLoad .env --optional .env.local || returnEnvironment "environmentFileLoad .env --optional .env.local failed with both .env" || return $?

  envFile="$tempDir/.env.$name"
  printf "%s\n" "$name=worked" >"$envFile"

  assertEquals "$(export "$name"=none && environmentFileLoad "$envFile" && printf "%s\n" "${!name-}")" "worked" || return $?
  assertEquals "$(export "$name"=none && environmentFileLoad --ignore TESTVAR "$envFile" && printf "%s\n" "${!name-}")" "none" || return $?
  assertNotExitCode --stderr-match "secure value" 0 environmentFileLoad --secure TESTVAR "$envFile" || return $?

  unset TESTVAR

  catchEnvironment "$handler" muzzle popd || return $?
  catchEnvironment "$handler" rm -rf "$tempDir" || return $?
}

testEnvironmentFileMake() {
  local v
  local handler="returnMessage"

  local home
  home=$(returnCatch "$handler" buildHome) || return $?

  catchEnvironment muzzle pushd "$home" || return $?
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
      returnEnvironment "environmentFileApplicationMake did not generate a .env file" || return $?
    fi
    for v in TESTING_ENV APPLICATION_BUILD_DATE APPLICATION_VERSION DSN; do
      if ! grep -q "$v" .env; then
        returnEnvironment "$(printf -- "%s %s\n%s" "environmentFileApplicationMake > .env file does not contain" "$(decorate code "$v")" "$(decorate code <.env | decorate wrap "    ")")" || return $?
      fi
    done
    decorate green application-environment.sh works AOK
    rm .env
  )
  catchEnvironment muzzle popd || return $?
}

testEnvironmentVariables() {
  local e
  local handler="returnMessage"

  e=$(fileTemporaryName "$handler") || return $?

  export BUILD_TEST_UNIQUE=1
  if ! environmentVariables >"$e"; then
    decorate error environmentVariables failed
    return 1
  fi
  assertFileContains "$e" BUILD_TEST_UNIQUE HOME PATH PWD TERM SHLVL || return $?
  printf "%s\n%s" "environmentVariables:" "$(decorate code <"$e")"
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
  local handler="returnMessage"

  foo=$(fileTemporaryName "$handler") || return $?

  __testEnvironmentValueReadWriteData | while read -r testName testValue; do
    returnCatch "$handler" environmentValueWrite "$testName" "$testValue" >>"$foo" || return $?
    value=$(returnCatch "$handler" environmentValueRead "$foo" "$testName" "*default*") || return $?
    assertEquals "$testValue" "$value" "Read write value changed" || return $?
  done

  returnCatch "$handler" rm "$foo" || return $?
}

testEnvironmentValueWriteArray() {
  local testArrayText testArray testArrays index envFile restoredValue item
  local handler="returnMessage"

  envFile=$(fileTemporaryName "$handler") || return $?
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
    restoredValue=() && while read -r item; do restoredValue+=("$item"); done < <(returnCatch "$handler" environmentValueReadArray "$envFile" "ARRAY$index" || return $?)
    assertEquals "${#testArray[*]}" "${#restoredValue[*]}" || return $?
    assertEquals "${testArray[*]}" "${restoredValue[*]}" || return $?
    restoredValue=() && while read -r item; do restoredValue+=("$item"); done < <(returnCatch "$handler" environmentValueReadArray "$envFile" "STRING$index" || return $?)
    assertEquals "${testArray[*]}" "${restoredValue[*]}" || return $?
    index=$((index + 1))
  done

  returnCatch "$handler" rm -f "$envFile" || return $?
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
  local handler="returnMessage"

  envFile=$(fileTemporaryName "$handler") || return $?

  returnCatch "$handler" environmentValueWrite Greeting Hello >>"$envFile" || return $?
  returnCatch "$handler" environmentValueWrite Target World >>"$envFile" || return $?

  assertExitCode --stdout-match Hello 0 environmentValueRead "$envFile" Greeting || return $?

  assertExitCode 1 environmentValueRead "$envFile" Salutation || return $?
  assertExitCode 0 environmentValueRead "$envFile" Salutation "" || return $?
  assertExitCode --stdout-match "Bonjour" 0 environmentValueRead "$envFile" Salutation "Bonjour" || return $?

  assertExitCode --stdout-match World 0 environmentValueRead "$envFile" Target || return $?

  assertExitCode 1 environmentValueRead "$envFile" TARGET || return $?
  assertExitCode 0 environmentValueRead "$envFile" TARGET "" || return $?
  assertExitCode --stdout-match "Paris" 0 environmentValueRead "$envFile" TARGET "Paris" || return $?

  catchEnvironment "$handler" rm -rf "$envFile" || return $?
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

  returnCatch "$handler" environmentOutput >>"$envFile" || return $?

  assertFileContains "$envFile" ZESK_BUILD_ROCKS= || return $?
  assertFileDoesNotContain "$envFile" "FAIL" || return $?
  assertFileDoesNotContain "$envFile" "HIDE_THIS" || return $?
  assertExitCode 0 grep -e "^ZESK_BUILD_ROCKS=" "$envFile" || return $?
  local envName
  while read -r envName; do
    assertExitCode 0 grep -v -e "^$envName=" "$envFile" || return $?
  done < <(environmentSecureVariables)

  unset ZESK_BUILD_ROCKS __HIDE_THIS_STUFF _HIDE_THIS_STUFF

  catchEnvironment "$handler" rm -rf "$envFile" || return $?
}

testEnvironmentApacheCompile() {
  local handler="returnMessage"
  local envFile

  envFile="$(returnCatch "$handler" buildHome)/test/example/apache.env" || return $?

  local matches

  matches=(
    --stdout-match "APACHE_LOG_DIR="
    --stdout-match "APACHE_MODULES="
    --stdout-match "APACHE_CONFS="
  )
  assertExitCode "${matches[@]}" 0 environmentCompile "$envFile" || return $?
}

testEnvironmentCompile() {
  local handler="returnMessage"
  local envFile

  envFile=$(fileTemporaryName "$handler") || return $?

  catchEnvironment "$handler" printf "%s\n" "A=1" "B=2" "C=\$((A + B))" "HOME=secure" "_A=\$A" "_B=\$B" "_C=42" "USER=root" >"$envFile" || return $?

  local matches

  matches=(
    --stdout-match "A=\"1\""
    --stdout-match "B=\"2\""
    --stdout-match "C=\"3\""
    --stdout-no-match "HOME="
    --stdout-match "_A=\"1\""
    --stdout-match "_B=\"2\""
    --stdout-match "_C=\"42\""
    --stdout-no-match "USER="
  )
  assertExitCode "${matches[@]}" 0 environmentCompile --underscore "$envFile" || return $?

  matches=(
    --stdout-match "A=\"1\""
    --stdout-match "B=\"2\""
    --stdout-match "C=\"3\""
    --stdout-match "HOME=\"secure\""
    --stdout-match "_A=\"1\""
    --stdout-match "_B=\"2\""
    --stdout-match "_C=\"42\""
    --stdout-match "USER=\"root\""
  )
  assertExitCode "${matches[@]}" 0 environmentCompile --underscore --secure "$envFile" || return $?

  matches=(
    --stdout-match "A=\"1\""
    --stdout-match "B=\"2\""
    --stdout-match "C=\"3\""
    --stdout-match "HOME="
    --stdout-no-match "_A="
    --stdout-no-match "_B="
    --stdout-no-match "_C="
    --stdout-match "USER="
  )
  assertExitCode "${matches[@]}" 0 environmentCompile --secure "$envFile" || return $?
  matches=(
    --stdout-match "A=\"1\""
    --stdout-match "B=\"2\""
    --stdout-match "C=\"3\""
    --stdout-no-match "HOME="
    --stdout-no-match "_A="
    --stdout-no-match "_B="
    --stdout-no-match "_C="
    --stdout-no-match "USER="
  )
  assertExitCode "${matches[@]}" 0 environmentCompile "$envFile" || return $?

  catchEnvironment "$handler" rm -rf "$envFile" || return $?
}

# Test-Plumber: false
testEnvironmentClean() {
  local handler="returnMessage"

  local saveEnv

  #
  # Preserve environment locally here for this test
  #

  saveEnv=$(fileTemporaryName "$handler") || return $?

  returnCatch "$handler" environmentOutput --underscore --secure >"$saveEnv" || return $?

  local item keepers=(A B C DEE EEE FFF GGG) removed=()

  export A B C DEE EEE FFF GGG

  A=1
  B=2
  C=3
  DEE=4
  EEE="Hello"
  FFF=(1 2 3)
  GGG=("Hello" "World")
  PS1=FOOBAR

  # environmentClean "${keepers[@]}" || return $?

  assertExitCode --skip-plumber 0 environmentClean "${keepers[@]}" || return $?

  for item in "${keepers[@]}"; do
    assertStringNotEmpty --display "$item is EMPTY?" "${!item-}" || return $?
  done

  keepers=(A DEE FFF GGG)
  removed=(B C EEE)

  assertExitCode --skip-plumber 0 environmentClean "${keepers[@]}" || return $?

  for item in "${keepers[@]}" PATH HOME; do
    assertStringNotEmpty --display "$item is EMPTY?" "${!item-}" || return $?
  done
  for item in "${removed[@]}"; do
    assertStringEmpty --display "$item is NOT empty: ${!item-}" "${!item-}" || return $?
  done
  removed+=("${keepers[@]}")
  keepers=()

  assertExitCode --skip-plumber 0 environmentClean || return $?

  for item in "${removed[@]}"; do
    assertStringEmpty --display "$item is NOT empty: ${!item-}" "${!item-}" || return $?
  done

  # Restore deleted environment
  set -a
  # shellcheck source=/dev/null
  source "$saveEnv"
  set +a

  returnCatch "$handler" rm -f "$saveEnv" || return $?
}

__testEchoEnv() {
  printf "%s" "[${!1-}]"
}

testEnvironmentFileLoadExecute() {
  local handler="returnMessage"

  mockEnvironmentStart TEST_THING

  local clean=() testEnv

  testEnv=$(fileTemporaryName "$handler") || return $?
  clean+=("$testEnv")

  returnCatch "$handler" environmentValueWrite HELLO World >>"$testEnv" || return $?

  export TEST_THING=Transient
  assertEquals "[Transient]" "$(environmentFileLoad "$testEnv" --execute __testEchoEnv TEST_THING)" || return $?
  assertEquals "[World]" "$(environmentFileLoad "$testEnv" --execute __testEchoEnv HELLO)" || return $?
  returnCatch "$handler" environmentValueWrite TEST_THING Winner >>"$testEnv" || return $?
  assertEquals "[Winner]" "$(environmentFileLoad "$testEnv" --execute __testEchoEnv TEST_THING)" || return $?
  assertEquals "[World]" "$(environmentFileLoad "$testEnv" --execute __testEchoEnv HELLO)" || return $?

  assertEquals "" "${HELLO-}" || return $?
  assertEquals "Transient" "$TEST_THING" || return $?

  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  mockEnvironmentStop TEST_THING
}
