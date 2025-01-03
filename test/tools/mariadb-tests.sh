#!/usr/bin/env bash
#
# mariadb-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
  # assertExitCode --line "$LINENO" 0 mariadbInstall || return $?
  assertExitCode --leak MARIADB_BINARY_DUMP --line "$LINENO" "${matches[@]}" 0 mariadbDump --binary echo --echo --user john --password secret --port 99 --host example.com || return $?

  unset MARIADB_BINARY_DUMP
}

testMariaDBInstallation() {
  __checkFunctionInstallsAndUninstallsBinary mariadb mariadbInstall mariadbUninstall || return $?
}
