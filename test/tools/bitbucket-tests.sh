#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# bitbucket-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testBitbucketPRNewURL() {
  local handler="returnMessage"

  # Simple numbers
  assertExitCode --stderr-match "Org" --stderr-match "required" 2 bitbucketPRNewURL || return $?
  assertExitCode --stderr-match "Repository" --stderr-match "required" 2 bitbucketPRNewURL "company" || return $?
  assertExitCode --stdout-match "https://" --stdout-match "bitbucket.org" 0 bitbucketPRNewURL --source test "company" "repo" || return $?

  assertNotExitCode --stderr-match "not a git repository" 0 bitbucketPRNewURL "company" "repo" || return $?

  local home
  home=$(catchReturn "$handler" buildHome) || return $?
  catchEnvironment "$handler" muzzle pushd "$home" || return $?
  assertExitCode --stdout-match "https://" --stdout-match "bitbucket.org" 0 bitbucketPRNewURL "company" "repo" || return $?

  catchEnvironment "$handler" muzzle popd || return $?
}
