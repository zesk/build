#!/usr/bin/env bash
#
# daemontools-tests.sh
#
# daemontools tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
set -eou pipefail

declare -a tests

tests+=(daemontoolsTests)

daemontoolsTests() {
  local logPath start waitFor logWaitFor

  assertExitCode --stderr-match 2024-03-21 --stderr-match "not production" 0 daemontoolsInstall || return $?

  if ! daemontoolsIsRunning; then
    consoleInfo "Running daemontools manually"
    assertExitCode 0 daemontoolsExecute || return $?
  fi

  assertExitCode 0 daemontoolsIsRunning || return $?

  logPath=$(mktemp -d)
  consoleInfo "logPath is $logPath"

  assertExitCode 0 daemontoolsInstallService --log "$logPath" "./test/example/lemon.sh" || return $?

  assertFileExists "/etc/service/lemon/run" || return $?
  assertFileExists "/etc/service/lemon/log/run" || return $?

  assertDirectoryExists "/etc/service/lemon/supervise" || return $?
  assertDirectoryExists "/etc/service/lemon/log/supervise" || return $?

  waitFor=5
  start=$(date +%s)
  while [ ! -d "$logPath/lemon" ]; do
    assertExitCode 0 sleep 1 || return $?
    if [ $(($(date +%s) - start)) -gt "$waitFor" ]; then
      _environment "Log path lemon not created after $waitFor seconds" || return $?
    fi
  done

  assertDirectoryExists "$logPath/lemon" || return $?
  assertFileExists "$logPath/lemon/current" || return $?
  assertFileContains "$logPath/lemon/current" "lemon.sh" || return $?

  assertOutputContains " up " svstat /etc/service/lemon/ || return $?
  assertOutputContains " seconds" svstat /etc/service/lemon/ || return $?

  if false; then
    logWaitFor=4
    statusMessage consoleInfo "Watching log file grow for $logWaitFor seconds"
    savedSize=$(fileSize "$logPath/lemon/current") || _environment "fileSize $logPath/lemon/current failed" || return $?
    sleep $logWaitFor
    assertGreaterThan "$(fileSize "$logPath/lemon/current")" "$savedSize" || return $?

    assertExitCode 0 daemontoolsRemoveService lemon || return $?

    statusMessage consoleInfo "Watching log file NOT grow for $logWaitFor seconds"
    savedSize=$(fileSize "$logPath/lemon/current") || _environment "fileSize $logPath/lemon/current failed" || return $?
    sleep $logWaitFor
    assertEquals "$savedSize" "$(fileSize "$logPath/lemon/current")" || return $?
  fi
}
