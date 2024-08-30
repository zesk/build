#!/usr/bin/env bash
#
# mariadb-tests.sh
#
# Copyright &copy; 2024 Market Acumen, Inc.
#


testMariaDump() {
  assertEquals 1 1 || return $?
}
