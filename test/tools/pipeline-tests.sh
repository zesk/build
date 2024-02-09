#!/usr/bin/env bash
#
# pipeline-tests.sh
#
# Pipeline tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

declare -a tests

tests+=(testDotEnvConfigure)
testDotEnvConfigure() {
  local tempDir="$$.dotEnvConfig"
  mkdir "$tempDir"
  cd "$tempDir" || return "$errorEnvironment"
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
  cd .. || return $?
  rm -rf "$tempDir" || return $?
  consoleSuccess dotEnvConfigure works AOK
}

tests+=(testHookSystem)
testHookSystem() {
  local testDir here randomApp randomDefault path

  if ! testDir=$(mktemp -d); then
    return 1
  fi
  if ! here=$(pwd); then
    return 1
  fi

  randomApp=$(randomString)
  randomDefault=$(randomString)

  cd "$testDir" || return $?
  mkdir -p "$testDir/bin/hooks"
  cp -R "$here/bin/build" "$testDir/bin/build"

  for f in test0.sh test1.sh noExtension; do
    path="$testDir/bin/hooks/$f"
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-\${BASH_SOURCE[0]}-$randomApp\"" >"$path"
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
    printf "%s\n%s" "#!/usr/bin/env bash" "echo \"$f-\${BASH_SOURCE[0]}-$randomDefault\"" >"$path"
    chmod +x "$path"
  done

  printf "%s %s\n" "$(consoleLabel "Current directory is")" "$(consoleValue "$(pwd)")"

  # Allowed hooks have .sh or no .sh but must be +x
  assertExitCode 0 hasHook test0 || return $?
  assertExitCode 0 hasHook test1 || return $?
  assertExitCode 0 hasHook test2 || return $?
  assertExitCode 0 hasHook nonZero || return $?
  assertExitCode 0 hasHook noExtension || return $?
  assertExitCode 0 hasHook nonZeroNoExt || return $?

  # If not -x, then ignored
  assertExitCode 1 hasHook nonX || return $?
  assertExitCode 1 hasHook nonXNoExt || return $?

  # No hook
  assertNotExitCode 0 hasHook test3 || return $?

  # Exit codes
  assertExitCode 0 runHook test0 || return $?
  assertExitCode 0 runHook test1 || return $?
  assertExitCode 0 runHook noExtension || return $?
  assertExitCode 99 runHook nonZero || return $?
  assertExitCode 99 runHook nonZeroNoExt || return $?
  assertExitCode 1 runHook nonX || return $?
  assertExitCode 1 runHook nonXNoExt || return $?
  assertExitCode 0 runHook test2 || return $?
  assertExitCode 1 runHook test3 || return $?

  assertOutputContains "$randomApp" runHook test0 || return $?
  assertOutputDoesNotContain "build/hooks" runHook test0 || return $?
  assertOutputContains "$randomApp" runHook test1 || return $?
  assertOutputDoesNotContain "build/hooks" runHook test1 || return $?
  assertOutputContains "$randomDefault" runHook test2 || return $?
  assertOutputContains "build/hooks" runHook test2 || return $?
}

tests+=(testMakeEnvironment)
testMakeEnvironment() {
  local v
  (
    set -eou pipefail

    export TESTING_ENV=chameleon
    export DSN=mysql://not@host/thing

    export DEPLOY_USER_HOSTS=none
    export BUILD_TARGET=app2.tar.gz
    export DEPLOYMENT=test-make-env
    export APPLICATION_ID=aabbccdd

    [ ! -f .env ] || rm .env
    makeEnvironment TESTING_ENV DSN >.env || return $?

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
  )
}
