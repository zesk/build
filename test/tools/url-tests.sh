#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

declare -a tests

tests+=(testUrlParse)
testUrlParse() {
  local parsed u url user name password host port path

  testSection testUrlParse

  u=foo://user:hard-to-type@identity:4232/dbname

  if ! parsed="$(urlParse "$u")"; then
    consoleError "Failed to parse $u"
    return 1
  fi
  echo "$parsed"

  eval "$parsed" || return $?

  assertEquals "$url" "$u" || return $?
  assertEquals "$user" user || return $?
  assertEquals "$path" /dbname || return $?
  assertEquals "$name" dbname || return $?
  assertEquals "$host" identity || return $?
  assertEquals "$port" 4232 || return $?
  assertEquals "$password" hard-to-type || return $?

  u=mysql://user:hard-to-type@identity/dbname

  eval "$(urlParse "$u")" || return $?

  assertEquals "$url" "$u" || return $?
  assertEquals "$user" user || return $?
  assertEquals "$name" dbname || return $?
  assertEquals "$host" identity || return $?
  assertEquals "$port" "" || return $?
  assertEquals "$password" hard-to-type || return $?
  consoleSuccess testUrlParse OK || return $?
}

tests+=(testGitUrlParse)
testGitUrlParse() {
  local u url user name password host port path

  u="https://github.com/zesk/build.git"

  eval "$(urlParse "$u")" || return $?

  assertEquals "$url" "$u" "url" || return $?
  assertEquals "$user" "" "user" || return $?
  assertEquals "$name" "zesk/build.git" "name" || return $?
  assertEquals "$path" /zesk/build.git || return $?
  assertEquals "$host" github.com "host" || return $?
  assertEquals "$port" "" "port" || return $?
  assertEquals "$password" "" "password" || return $?
}
