#!/usr/bin/env bash
#
# mariadb-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__justEcho() {
  printf -- "%s\n" "$*"
}
testMariadbConnect() {
  local testString

  testString=$(mariadbConnect --binary __justEcho "mysql://user:password@host/dbname") || return $?
  assertContains --line "$LINENO" "-u user" "$testString" || return $?
  assertContains --line "$LINENO" "-p""password" "$testString" || return $?
  assertContains --line "$LINENO" "-h host" "$testString" || return $?
  assertContains --line "$LINENO" " dbname" "$testString" || return $?
  assertNotContains --line "$LINENO" " --port=3306" "$testString" || return $?
  testString=$(mariadbConnect --binary __justEcho "mysqli://user:password@remote:9876/better-app") || return $?
  assertContains --line "$LINENO" "-u user" "$testString" || return $?
  assertContains --line "$LINENO" "-p""password" "$testString" || return $?
  assertContains --line "$LINENO" "-h remote" "$testString" || return $?
  assertContains --line "$LINENO" " better-app" "$testString" || return $?
  assertContains --line "$LINENO" " --port=9876" "$testString" || return $?
  testString=$(mariadbConnect --print "mysqli://user:password@remote:9876/better-app") || return $?
  assertContains --line "$LINENO" "mariadb " "$testString" || return $?
}

testMariaDBDump() {
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
  # assertExitCode 0 mariadbInstall || return $?
  assertExitCode --leak MARIADB_BINARY_DUMP --line "$LINENO" "${matches[@]}" 0 mariadbDump --binary echo --print --user john --password secret --port 99 --host example.com || return $?

  unset MARIADB_BINARY_DUMP
}

# Tag: package-install
testMariaDBInstallation() {
  __checkFunctionInstallsAndUninstallsBinary mariadb mariadbInstall mariadbUninstall || return $?
}

testMariaDBDumpClean() {
  local usage="_return"
  local home

  home=$(__catch "$usage" buildHome) || return $?

  local sql

  sql="$home/test/example/mariadb-dump.sql"
  assertFileContains "$sql" "sandbox" "!999999" || return $?
  assertExitCode --stdout-no-match "sandbox" --stdout-no-match ""!999999"" 0 mariadbDumpClean <"$sql" || return $?
}
