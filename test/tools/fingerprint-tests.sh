#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testFingerprint() {
  BUILD_DEBUG="" assertExitCode --stdout-match "with application fingerprint" 0 fingerprint --help || return $?
}
