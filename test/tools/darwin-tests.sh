#!/usr/bin/env bash
#
# darwin-tests.sh
#
# Darwin tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testDarwinDialog() {
  if whichExists osascript; then
    # Only can test on Darwin, but not sure how to manage dialog interaction if at all
    assertExitCode --stdout-match osascript 0 darwinDialog --help || return $?
    assertNotExitCode --stderr-match 'not unsigned' 0 darwinDialog --choice A --choice B --default -1 || return $?
    assertNotExitCode --stderr-match 'out of range' 0 darwinDialog --choice A --choice B --default 2 || return $?
    assertNotExitCode --stderr-match 'blank' 0 darwinDialog --choice "" --choice B || return $?
    assertNotExitCode --stderr-match 'blank' 0 darwinDialog --choice "A" --choice "" || return $?
  else
    (
      decorate info "${FUNCNAME[0]} skipped, we are not on Darwin -> ${OSTYPE-}"
    ) || :
  fi
}

testDarwinSoundInstall() {
  local handler="returnMessage"
  if isDarwin; then
    local home

    home=$(catchReturn "$handler" buildHome) || return $?
    assertExitCode 0 darwinSoundInstall "$home/etc/zesk-build-notification.mp3" || return $?
    assertExitCode 0 darwinSoundInstall "$home/etc/zesk-build-failed.mp3" || return $?

    assertExitCode 0 darwinSoundValid zesk-build-notification || return $?
    assertExitCode 0 darwinSoundValid zesk-build-failed || return $?
    assertOutputContains zesk-build-notification darwinSoundNames || return $?
    assertOutputContains zesk-build-failed darwinSoundNames || return $?

    assertDirectoryExists "$(darwinSoundDirectory)" || return $?
  fi
}

testDarwinNotification() {
  if isDarwin; then
    assertExitCode 0 darwinNotification "${FUNCNAME[0]}" || return $?
  fi
}

