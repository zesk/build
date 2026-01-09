#!/usr/bin/env bash
#
# text-tests.sh
#
# Text tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
__dataUrlSchemeDefaultPort() {
  cat <<EOF
80 http
443 https
3306 mysqli
3306 mysql+does+not+matter
5432 postgres
EOF
}
testUrlSchemeDefaultPort() {
  local expected scheme
  while read -r expected scheme; do
    assertEquals "$expected" "$(urlSchemeDefaultPort "$scheme")" || return $?
  done < <(__dataUrlSchemeDefaultPort)
}

# Tag: slow
testUrlParseItem() {
  local url=foo://user:hard-to-type@identity:4232/dbname

  assertEquals "$url" "$(urlParseItem "url" "$url")" || return $?
  assertEquals user "$(urlParseItem "user" "$url")" || return $?
  assertEquals /dbname "$(urlParseItem "path" "$url")" || return $?
  assertEquals dbname "$(urlParseItem "name" "$url")" || return $?
  assertEquals identity "$(urlParseItem "host" "$url")" || return $?
  assertEquals 4232 "$(urlParseItem "port" "$url")" || return $?
  assertEquals "" "$(urlParseItem "portDefault" "$url")" || return $?
  assertEquals hard-to-type "$(urlParseItem "password" "$url")" || return $?
  assertEquals "" "$(urlParseItem "error" "$url")" || return $?
  assertEquals "foo" "$(urlParseItem "scheme" "$url")" || return $?

  url="https://george:soma@identity:1984/orwell"

  assertEquals "$url" "$(urlParseItem "url" "$url")" || return $?
  assertEquals george "$(urlParseItem "user" "$url")" || return $?
  assertEquals /orwell "$(urlParseItem "path" "$url")" || return $?
  assertEquals orwell "$(urlParseItem "name" "$url")" || return $?
  assertEquals identity "$(urlParseItem "host" "$url")" || return $?
  assertEquals 1984 "$(urlParseItem "port" "$url")" || return $?
  assertEquals 443 "$(urlParseItem "portDefault" "$url")" || return $?
  assertEquals soma "$(urlParseItem "password" "$url")" || return $?
  assertEquals "" "$(urlParseItem "error" "$url")" || return $?
  assertEquals "https" "$(urlParseItem "scheme" "$url")" || return $?
}

# Tag: slow
testUrlParse() {
  local parsed u url user name password host port portDefault path error scheme

  __testSection testUrlParse

  u=foo://user:hard-to-type@identity:4232/dbname

  if ! parsed="$(urlParse "$u")"; then
    decorate error "Failed to parse $u"
    return 1
  fi
  # echo "$parsed"

  eval "$parsed" || return $?

  assertEquals "$url" "$u" || return $?
  assertEquals "$user" user || return $?
  assertEquals "$path" /dbname || return $?
  assertEquals "$name" dbname || return $?
  assertEquals "$host" identity || return $?
  assertEquals "$port" 4232 || return $?
  assertEquals "$portDefault" "" || return $?
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
  assertEquals "$portDefault" "3306" || return $?
  assertEquals "$password" hard-to-type || return $?
  assertEquals "$error" "" || return $?
  assertEquals "$scheme" "mysql" || return $?

  eval "$(urlParse --integer-port "$u")" || return $?
  assertEquals "$port" "3306" || return $?
  eval "$(urlParse "http://example.com/")" || return $?
  assertEquals "$port" "" || return $?
  eval "$(urlParse --integer-port "http://example.com/")" || return $?
  assertEquals "$port" "80" || return $?
  assertEquals "$portDefault" "80" || return $?
  eval "$(urlParse --integer-port "https://example.com/")" || return $?
  assertEquals "$port" "443" || return $?
  assertEquals "$portDefault" "443" || return $?

  # Valid but probably a bad idea
  eval "$(urlParse --integer-port "https://example.com:80/")" || return $?
  assertEquals "$port" "80" || return $?
  assertEquals "$portDefault" "443" || return $?
  eval "$(urlParse --integer-port "http://example.com:443/")" || return $?
  assertEquals "$port" "443" || return $?
  assertEquals "$portDefault" "80" || return $?
}

testGitUrlParse() {
  local parsed u url user name password host port path error scheme portDefault

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
    assertExitCode 0 urlValid "$url" || return $?
  done
}

testUrlFilter() {
  local handler="returnMessage"
  local home output source

  home=$(catchReturn "$handler" buildHome) || return $?
  output=$(fileTemporaryName "$handler") || return $?
  source="$home/test/example/urlFilter.source.html"
  urlFilter "$source" >"$output" || returnEnvironment "urlFilter $source failed" || return $?
  assertExitCode 0 diff "$output" "$home/test/example/urlFilter.output.txt" || returnUndo $? dumpPipe "urlFilter $source" <"$output" || returnUndo $? rm -rf "$output" || return $?

  catchReturn "$handler" rm -f "$output" || return $?
}

testUrlOpen() {
  local url
  export BUILD_URL_BINARY

  url="https://www.example.com/"
  BUILD_URL_BINARY="echo"
  assertEquals "$(urlOpen "$url")" "$url" || return $?
  assertEquals "$(urlOpen --ignore '*bad*url*' "$url")" "$url" || return $?
  assertEquals "1" "$(urlOpen "$url" "$url" | fileLineCount)" || return $?
  assertEquals "2" "$(urlOpen --wait "$url" "$url" | fileLineCount)" || return $?

  assertNotExitCode --stderr-match 'Invalid URL' --stderr-match 'bad-url' --line "$LINENO" 0 urlOpen "bad-url" || return $?
  assertExitCode 0 urlOpen --ignore "bad-url" || return $?

  unset BUILD_URL_BINARY
}

testFetch() {
  local handler="returnMessage"
  local targetFile

  assertExitCode 0 urlFetch --help || return $?

  targetFile=$(fileTemporaryName "$handler")
  assertFileExists "$targetFile" || return $?
  assertFileSize --line "$LINENO" 0 "$targetFile" || return $?
  assertExitCode 0 urlFetch 'https://example.com' "$targetFile" || return $?
  assertFileExists "$targetFile" || return $?
  assertNotFileSize --line "$LINENO" 0 "$targetFile" || return $?
  assertFileContains --line "$LINENO" "$targetFile" "https://" "iana.org/domains/example" || return $?
  catchEnvironment "$handler" rm -f "$targetFile" || return $?
}

testFetchTimeout() {
  assertExitCode 0 urlFetch --timeout 10 "https://marketacumen.com/slow.php?t=5" || return $?
  assertExitCode --stderr-ok 1 urlFetch --timeout 2 "https://marketacumen.com/slow.php?t=5" || return $?
}

testUrlToVariables() {
  local matches=(
    --stdout-match "DSN_USER=user"
    --stdout-match "DSN_HOST=localhost"
    --stdout-match "DSN_NAME=theDude"
    --stdout-match "DSN_PASSWORD=who-would-guess-this"
  )
  assertExitCode "${matches[@]}" 0 urlParse --uppercase --prefix DSN_ "https://user:who-would-guess-this@localhost/theDude" || return $?
  local matches=(
    --stdout-match "DSN_user=user"
    --stdout-match "DSN_host=localhost"
    --stdout-match "DSN_name=theDude"
    --stdout-match "DSN_password=who-would-guess-this"
  )
  assertExitCode "${matches[@]}" 0 urlParse --prefix DSN_ "https://user:who-would-guess-this@localhost/theDude" || return $?
}
