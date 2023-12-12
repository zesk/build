#!/usr/bin/env bash
#
# pipeline-tests.sh
#
# Pipeline tests
#
# Copyright &copy; 2023 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

declare -a tests

tests+=(testDotEnvConfigure)
testDotEnvConfigure() {
  local tempDir="$$.dotEnvConfig"
  mkdir "$tempDir"
  cd "$tempDir" || exit
  consoleInfo "$(pwd)"
  touch .env
  if ! dotEnvConfigure || [ -n "$(dotEnvConfigure)" ]; then
    consoleError "dotEnvConfigure failed with just .env"
    return "$errorEnvironment"
  fi
  touch .env.local
  if ! dotEnvConfigure || [ -n "$(dotEnvConfigure)" ]; then
    consoleError "dotEnvConfigure failed with both .env"
    return "$errorEnvironment"
  fi
  cd ..
  rm -rf "$tempDir"
  consoleSuccess dotEnvConfigure works AOK
}

tests+=(testHookSystem)
testHookSystem() {
  local testDir here randomApp randomDefault path

  testDir=$(mktemp -d)
  here=$(pwd)

  randomApp=$(randomString)
  randomDefault=$(randomString)

  cd "$testDir" || return $?
  mkdir -p "$testDir/bin/hooks"
  cp -R "$here/bin/build" "$testDir/bin/build"

  for f in test0.sh test1.sh noExtension; do
    path="$testDir/bin/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-$randomApp\"" >"$path"
    chmod +x "$path"
  done
  for f in nonZero.sh nonZeroNoExt; do
    path="$testDir/bin/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-\${BASH_SOURCE[0]}-$randomApp\"; exit 99" >"$path"
    chmod +x "$path"
  done
  for f in nonX.sh nonXNoExt; do
    path="$testDir/bin/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-\${BASH_SOURCE[0]}-$randomApp\"; exit 1" >"$path"
  done
  for f in test1.sh test2.sh; do
    path="$testDir/bin/build/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-\${BASH_SOURCE[0]}-$randomApp\"" >"$path"
    chmod +x "$path"
  done

  assertExitCode 0 hasHook test0
  assertExitCode 0 hasHook test1
  assertExitCode 0 hasHook test2
  assertExitCode 0 hasHook nonZero
  assertExitCode 0 hasHook nonZero
  assertExitCode 1 hasHook nonX
  assertExitCode 1 hasHook nonZeroNoExt
  assertExitCode 1 hasHook nonXNoExt
  assertExitCode 1 hasHook noExtension

  assertNotExitCode 0 hasHook test3

  assertExitCode 99 runHook nonZero
  assertExitCode 1 runHook nonX
  assertExitCode 1 runHook nonZeroNoExt
  assertExitCode 1 runHook nonXNoExt
  assertExitCode 1 runHook noExtension

  assertOutputContains "$randomApp" runHook test0
  assertOutputDoesNotContain "build/hooks" runHook test0
  assertOutputContains "$randomApp" runHook test1
  assertOutputDoesNotContain "build/hooks" runHook test1
  assertOutputContains "$randomDefault" runHook test2
  assertOutputContains "build/hooks" runHook test2
}

tests+=(testMakeEnvironment)
testMakeEnvironment() {
  local v
  export TESTING_ENV=chameleon
  export DSN=mysql://not@host/thing

  export DEPLOY_USER_HOSTS=none
  export BUILD_TARGET=app2.tar.gz
  export DEPLOYMENT=test-make-env
  export APPLICATION_CHECKSUM=aabbccdd

  [ -f .env ] && rm .env
  set -eou pipefail
  makeEnvironment TESTING_ENV DSN >.env

  if [ ! -f .env ]; then
    consoleError "make-env.sh did not generate a .env file"
    return "$errorEnvironment"
  fi
  for v in TESTING_ENV APPLICATION_BUILD_DATE APPLICATION_VERSION DSN; do
    if ! grep -q "$v" .env; then
      consoleError "makeEnvironment > .env file does not contain $v"
      prefixLines "$(consoleCode)    " <.env
      return "$errorEnvironment"
    fi
  done
  consoleGreen make-env.sh works AOK
  rm .env
}
