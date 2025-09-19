#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testFingerprint() {
  assertEquals 0 fingerprint --help || return $?
}