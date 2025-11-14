#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testBitbucketPRNewURL() {
  # Simple numbers
  assertExitCode --stderr-match "Org" --stderr-match "required" 2 bitbucketPRNewURL || return $?
  assertExitCode --stderr-match "Repository" --stderr-match "required" 2 bitbucketPRNewURL "company" || return $?
  assertExitCode --stdout-match "https://" --stdout-match "bitbucket.org" 0 bitbucketPRNewURL "company" "repo" || return $?
}
