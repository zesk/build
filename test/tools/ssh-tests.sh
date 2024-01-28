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

  local sampleDomainA sampleDomainB

  # shellcheck source=/dev/null
  source "./bin/build/env/HOME.sh"

  originalHome="$HOME"
  tempHome="$(mktemp -d)"
  HOME="$tempHome"

  sampleDomainA=github.com
  sampleDomainB=bitbucket.org

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?
  sshAddKnownHost || return $?
  assertDirectoryExists "$tempHome/.ssh" || return $?
  assertFileExists "$tempHome/.ssh/known_hosts" || return $?
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" $sampleDomainA
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" $sampleDomainB

  sshAddKnownHost "$sampleDomainA" || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" $sampleDomainA
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" $sampleDomainB

  sshAddKnownHost "$sampleDomainB" || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" $sampleDomainA
  assertFileContains "$tempHome/.ssh/known_hosts" $sampleDomainB

  HOME="$originalHome"

  return 0
}
