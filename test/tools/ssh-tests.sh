#!/usr/bin/env bash
#
# ssh-tests.sh
#
# SSH tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testSSHAddKnownHosts() {
  local handler="returnMessage"
  local tempHome
  local sampleDomainA sampleDomainB

  mockEnvironmentStart HOME

  export HOME

  tempHome="$(fileTemporaryName "$handler" -d)" || return $?

  HOME="$tempHome"

  sampleDomainA=github.com
  sampleDomainB=bitbucket.org

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?

  assertExitCode --stderr-match "Need at least one host" 2 sshKnownHostAdd || return $?

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?

  assertExitCode 0 sshKnownHostAdd "$sampleDomainA" || return $?

  assertDirectoryExists "$tempHome/.ssh" || return $?
  assertFileExists "$tempHome/.ssh/known_hosts" || return $?

  assertFileContains "$tempHome/.ssh/known_hosts" "$sampleDomainA" || return $?
  assertFileDoesNotContain "$tempHome/.ssh/known_hosts" "$sampleDomainB" || return $?

  assertExitCode 0 sshKnownHostAdd "$sampleDomainB" || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" "$sampleDomainA" || return $?
  assertFileContains "$tempHome/.ssh/known_hosts" "$sampleDomainB" || return $?

  catchReturn "$handler" rm -rf "$tempHome" || return $?

  mockEnvironmentStop HOME

  return 0
}

testSSHRemoveKnownHosts() {
  local handler="returnMessage"
  local tempHome debugFlag=false

  mockEnvironmentStart HOME

  export HOME

  tempHome="$(fileTemporaryName "$handler" -d)" || return $?

  HOME="$tempHome"

  local sampleDomainA sampleDomainB sampleDomainC
  sampleDomainA=github.com
  sampleDomainB=bitbucket.org
  sampleDomainC=marketacumen.com

  local authFile
  authFile=$(sshKnownHostsFile) || return $?

  assertDirectoryDoesNotExist "$tempHome/.ssh" || return $?

  assertExitCode --stderr-match "Need at least one host" 2 sshKnownHostRemove || return $?

  assertExitCode 0 sshKnownHostAdd "$sampleDomainA" "$sampleDomainB" "$sampleDomainC" || return $?
  ! $debugFlag || dumpPipe "Added ALL domains" <"$authFile"

  assertDirectoryExists "$tempHome/.ssh" || return $?
  assertFileExists "$authFile" || return $?
  assertFileContains "$authFile" "$sampleDomainA" "$sampleDomainB" "$sampleDomainC" || return $?

  assertExitCode 0 sshKnownHostRemove "$sampleDomainB" || return $?
  ! $debugFlag || dumpPipe "Removed $sampleDomainB" <"$authFile"

  assertFileContains "$authFile" "$sampleDomainA" "$sampleDomainC" || return $?
  assertFileDoesNotContain "$authFile" "$sampleDomainB" || return $?

  assertExitCode 0 sshKnownHostRemove "$sampleDomainA" || return $?
  ! $debugFlag || dumpPipe "Removed $sampleDomainA" <"$authFile"
  assertFileContains "$authFile" "$sampleDomainC" || return $?
  assertFileDoesNotContain "$authFile" "$sampleDomainA" "$sampleDomainB" || return $?

  assertExitCode 0 sshKnownHostRemove "$sampleDomainC" || return $?
  ! $debugFlag || dumpPipe "Removed $sampleDomainC" <"$authFile"
  assertFileDoesNotContain "$authFile" "$sampleDomainA" "$sampleDomainB" "$sampleDomainC" || return $?

  mockEnvironmentStop HOME

  catchReturn "$handler" rm -rf "$tempHome" || return $?

  return 0

}
