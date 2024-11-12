#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

testUrlParse() {
  local parsed u url user name password host port path error scheme

  __testSection testUrlParse

  u=foo://user:hard-to-type@identity:4232/dbname

  if ! parsed="$(urlParse "$u")"; then
    decorate error "Failed to parse $u"
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
  decorate success testUrlParse OK || return $?

}

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

testUrlValid() {
  __validUrls | while read -r url; do
    assertExitCode --line "$LINENO" 0 urlValid "$url" || return $?
  done
}

testUrlFilter() {
  local home output

  home=$(__environment buildHome) || return $?
  output=$(__environment mktemp) || return $?
  urlFilter "$home/test/example/urlFilter.source.html" | dumpPipe "urlFilter Results"
  urlFilter "$home/test/example/urlFilter.source.html" >"$output"
  assertExitCode --line "$LINENO" 0 diff "$output" "$home/test/example/urlFilter.output.txt" || return $?
}

testUrlOpen() {
  local url
  export BUILD_URL_BINARY

  url="https://www.example.com/"
  BUILD_URL_BINARY="echo"
  assertEquals --line "$LINENO" "$(urlOpen "$url")" "$url" || return $?
  assertEquals --line "$LINENO" "$(urlOpen --ignore '*bad*url*' "$url")" "$url" || return $?
  assertEquals --line "$LINENO" "1" "$(urlOpen "$url" "$url" | wc -l | trimSpace)" || return $?
  assertEquals --line "$LINENO" "2" "$(urlOpen --wait "$url" "$url" | wc -l | trimSpace)" || return $?

  assertNotExitCode --stderr-match 'Invalid URL' --stderr-match 'bad-url' --line "$LINENO" 0 urlOpen "bad-url" || return $?
  assertExitCode --line "$LINENO" 0 urlOpen --ignore "bad-url" || return $?

  unset BUILD_URL_BINARY
}
