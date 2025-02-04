#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testSSHAddKnownHosts() {
  local tempHome
  local output
  local sampleDomainA sampleDomainB

  __mockValue HOME

  export HOME

  tempHome="$(mktemp -d)" || return $?

  HOME="$tempHome"

  sampleDomainA=github.com
  sampleDomainB=bitbucket.org
  output=$(mktemp) || return $?

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?

  sshAddKnownHost >"$output" 2>&1 || return $?
  assertZeroFileSize "$output" || return $?

  assertDirectoryExists "$tempHome/.ssh" || return $?
  assertFileExists "$tempHome/.ssh/known_hosts" || return $?
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" $sampleDomainA || return $?
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" $sampleDomainB || return $?

  sshAddKnownHost "$sampleDomainA" >"$output" 2>&1 || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" $sampleDomainA || return $?
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" $sampleDomainB || return $?
  assertZeroFileSize "$output" || return $?

  sshAddKnownHost "$sampleDomainB" >"$output" 2>&1 || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" $sampleDomainA || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" $sampleDomainB || return $?
  assertZeroFileSize "$output" || return $?

  __mockValue HOME "" --end

  return 0
}
