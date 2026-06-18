#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# notify-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

testNotifyURL() {

  mockEnvironmentStart BUILD_DEBUG ""
  # Errors
  NOTIFY_URL="https://www.example.com/" assertExitCode --stderr-match "Message is required" 2 notifyURL || return $?
  NOTIFY_URL="https://www.example.com/" assertExitCode --stderr-match "blank #1/1" 2 notifyURL "" || return $?
  NOTIFY_URL="" assertExitCode --stderr-match "NOTIFY_URL is required" 2 notifyURL "Message" || return $?

  mockEnvironmentStop BUILD_DEBUG
}
