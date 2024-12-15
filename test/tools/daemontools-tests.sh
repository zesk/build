#!/usr/bin/env bash
#
# daemontools-tests.sh
#
# daemontools tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testDaemontools() {
  local logPath start waitFor logWaitFor

  assertExitCode --line "$LINENO" --stderr-match 2024-03-21 --stderr-match "not production" 0 daemontoolsInstall || return $?

  if ! daemontoolsIsRunning; then
    decorate info "Running daemontools manually"
    assertExitCode --line "$LINENO" 0 daemontoolsExecute || return $?
  fi

  if [ -d "/etc/service/lemon" ]; then
    decorate error "Lemon service installed - removing"
    assertExitCode --line "$LINENO" --leak DAEMONTOOLS_HOME 0 daemontoolsRemoveService lemon || return $?
  fi

  echo "${BASH_SOURCE[0]}:$LINENO" 1>&2
  assertExitCode --line "$LINENO" 0 daemontoolsIsRunning || return $?
  echo "${BASH_SOURCE[0]}:$LINENO" 1>&2

  logPath=$(__environment buildCacheDirectory "${FUNCNAME[0]}") || return $?
  decorate info "logPath is $logPath"
  __environment requireDirectory "$logPath" >/dev/null || return $?
  echo "${BASH_SOURCE[0]}:$LINENO" 1>&2

  daemontoolsInstallService --log "$logPath" "./test/example/lemon.sh" || return $?
  assertExitCode --leak DAEMONTOOLS_HOME --line "$LINENO" 0 daemontoolsInstallService --log "$logPath" "./test/example/lemon.sh" || return $?
  echo "${BASH_SOURCE[0]}:$LINENO" 1>&2

  assertFileExists --line "$LINENO" "/etc/service/lemon/run" || return $?
  assertFileExists --line "$LINENO" "/etc/service/lemon/log/run" || return $?
  echo "${BASH_SOURCE[0]}:$LINENO" 1>&2

  assertDirectoryExists --line "$LINENO" "/etc/service/lemon/supervise" || return $?
  assertDirectoryExists --line "$LINENO" "/etc/service/lemon/log/supervise" || return $?
  echo "${BASH_SOURCE[0]}:$LINENO" 1>&2

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
  ls -la "$logPath/lemon"
  sleep 4
  assertFileContains --line "$LINENO" "$logPath/lemon/current" "lemon.sh" || return $?

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
