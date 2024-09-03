#!/usr/bin/env bash
#
# mariadb-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testMariaDump() {
  local matches

  matches=(
    --stdout-match "--user"
    --stdout-match "--add-drop-table"
    --stdout-match "--password"
    --stdout-match "--host"
    --stdout-match "99"
    --stdout-match "secret"
    --stdout-match "example.com"
  )
  assertExitCode --line "$LINENO" "${matches[@]}" 0 mariadbDump --echo --user john --password secret --port 99 --host example.com || return $?
}
