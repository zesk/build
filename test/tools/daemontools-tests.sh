#!/usr/bin/env bash
#
# daemontools-tests.sh
#
# daemontools tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Argument: None
# Argument: Some
# Test-Platform: !alpine
# Test-Platform: linux
testDaemontools() {
  local logPath start waitFor logWaitFor

  assertExitCode --line "$LINENO" --stderr-match "not production" 0 daemontoolsInstall || return $?

  if ! daemontoolsIsRunning; then
    decorate info "Running daemontools manually"
    assertExitCode --line "$LINENO" 0 daemontoolsExecute || return $?
  fi

  if [ -d "/etc/service/lemon" ]; then
    decorate error "Lemon service installed - removing"
    assertExitCode --line "$LINENO" --leak DAEMONTOOLS_HOME 0 daemontoolsRemoveService lemon || return $?
  fi

  assertExitCode --line "$LINENO" 0 daemontoolsIsRunning || return $?

  logPath=$(__environment buildCacheDirectory "${FUNCNAME[0]}") || return $?
  decorate info "logPath is $logPath"
  __environment requireDirectory "$logPath" >/dev/null || return $?

  daemontoolsInstallService --log "$logPath" "./test/example/lemon.sh" || return $?
  assertExitCode --leak DAEMONTOOLS_HOME --line "$LINENO" 0 daemontoolsInstallService --log "$logPath" "./test/example/lemon.sh" || return $?

  assertFileExists --line "$LINENO" "/etc/service/lemon/run" || return $?
  assertFileExists --line "$LINENO" "/etc/service/lemon/log/run" || return $?

  assertDirectoryExists --line "$LINENO" "/etc/service/lemon/supervise" || return $?
  assertDirectoryExists --line "$LINENO" "/etc/service/lemon/log/supervise" || return $?

  waitFor=5
  start=$(date +%s)
  while [ ! -d "$logPath/lemon" ]; do
    find "$logPath" -type f | dumpPipe "$(date +%T) logPath: $(decorate code "$logPath")"
    find "/etc/service/" -type f | dumpPipe "/etc/service"
    assertExitCode 0 sleep 1 || return $?
    if [ $(($(date +%s) - start)) -gt "$waitFor" ]; then
      _environment "Log path lemon not created after $waitFor seconds" || return $?
    fi
  done

  assertDirectoryExists "$logPath/lemon" || return $?
  assertFileExists "$logPath/lemon/current" || return $?
  # I assume this is to give time to the background process
  sleep 4
  assertFileContains --line "$LINENO" "$logPath/lemon/current" "lemon.sh" || _undo $? ls -la "$logPath/lemon" || return $?

  assertOutputContains --line "$LINENO" " up " svstat /etc/service/lemon/ || return $?
  assertOutputContains --line "$LINENO" " seconds" svstat /etc/service/lemon/ || return $?

  if false; then
    logWaitFor=4
    statusMessage decorate info "Watching log file grow for $logWaitFor seconds"
    savedSize=$(fileSize "$logPath/lemon/current") || _environment "fileSize $logPath/lemon/current failed" || return $?
    sleep $logWaitFor
    assertGreaterThan --line "$LINENO" "$(fileSize "$logPath/lemon/current")" "$savedSize" || return $?

    assertExitCode --line "$LINENO" 0 daemontoolsRemoveService lemon || return $?

    statusMessage decorate info "Watching log file NOT grow for $logWaitFor seconds"
    savedSize=$(fileSize "$logPath/lemon/current") || _environment "fileSize $logPath/lemon/current failed" || return $?
    sleep $logWaitFor
    assertEquals --line "$LINENO" "$savedSize" "$(fileSize "$logPath/lemon/current")" || return $?
  fi

  unset DAEMONTOOLS_HOME
}
