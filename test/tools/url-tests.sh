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
  local parsed u url user name password host port path error scheme

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
  assertEquals "$error" "" || return $?
  assertEquals "$scheme" "foo" || return $?

  u=mysql://user:hard-to-type@identity/dbname

  eval "$(urlParse "$u")" || return $?

  assertEquals "$url" "$u" || return $?
  assertEquals "$user" user || return $?
  assertEquals "$name" dbname || return $?
  assertEquals "$host" identity || return $?
  assertEquals "$port" "" || return $?
  assertEquals "$password" hard-to-type || return $?
  assertEquals "$error" "" || return $?
  assertEquals "$scheme" "mysql" || return $?
  consoleSuccess testUrlParse OK || return $?

}

tests+=(testGitUrlParse)
testGitUrlParse() {
  local parsed u url user name password host port path error scheme

  u="https://github.com/zesk/build.git"

  eval "$(urlParse "$u")" || return $?

  assertEquals "$url" "$u" "url" || return $?
  assertEquals "$user" "" "user" || return $?
  assertEquals "$name" "zesk/build.git" "name" || return $?
  assertEquals "$path" /zesk/build.git || return $?
  assertEquals "$host" github.com "host" || return $?
  assertEquals "$port" "" "port" || return $?
  assertEquals "$password" "" "password" || return $?
  assertEquals "$error" "" || return $?
  assertEquals "$scheme" "https" || return $?
}

__validUrls() {
  cat <<EOF
https://law.stackexchange.com/questions/104010/could-an-investor-sue-the-ceo-or-company-for-not-delivering-on-promised-technolo
https://www.example.com/
ftp://user:password@domain.com/path/to/pirate.mov
mysqli://user:secret@dbhost/moneymaker
EOF
}

tests+=(testUrlValid)
testUrlValid() {
  __validUrls | while read -r url; do
    assertExitCode --line "$LINENO" 0 urlValid "$url" || return $?
  done
}
