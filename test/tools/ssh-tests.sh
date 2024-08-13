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
  local output
  local sampleDomainA sampleDomainB

  export HOME

  __environment buildEnvironmentLoad HOME || return $?

  originalHome="$HOME"
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

  HOME="$originalHome"

  unset BUILD_DEBUG

  return 0
}
