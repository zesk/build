#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
declare -a tests

tests+=(testSSHAddKnownHosts)
testSSHAddKnownHosts() {
  local tempHome originalHome

  # shellcheck source=/dev/null
  source "./bin/build/env/HOME.sh"

  originalHome="$HOME"
  tempHome="$(mktemp -d)"
  HOME="$tempHome"

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?
  sshAddKnownHost || return $?
  assertDirectoryExists "$tempHome/.ssh" || return $?
  assertFileExists "$tempHome/.ssh/known_hosts" || return $?
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" github.com
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" marketacumen.com

  sshAddKnownHost github.com || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" github.com
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" marketacumen.com

  sshAddKnownHost marketacumen.com || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" github.com
  assertFileContains "$tempHome/.ssh/known_hosts" marketacumen.com

  HOME="$originalHome"

  return 0
}
