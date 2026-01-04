#!/usr/bin/env bash
#
# github-tests.sh
#
# Git tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__testGithubURLParseData() {
  cat <<EOF
  https://github.com/project/repo project/repo
  https://github.com/another/thing/tree/master/bash another/thing
EOF
}

testGithubURLParse() {
  local url expected
  while read -r url expected; do
    assertEquals "$expected" "$(githubURLParse "$url")" || return $?
  done < <(__testGithubURLParseData)
}

# Tag: remote-dependency
# The URL fetch from GitHub has failed and `.url` returns `{}` in some cases - assume it's a temporary outage
# Maybe try twice?
testGithubStuff() {
  local handler="returnMessage"
  local temp

  temp=$(fileTemporaryName "$handler") || return $?

  catchEnvironment "$handler" githubProjectJSON zesk/build >"$temp" || returnClean $? "$temp" || return $?

  local url
  url=$(jsonFileGet "$temp" .url) || returnClean $? "$temp" || return $?
  dumpPipe "GitHub JSON" <"$temp"
  assertContains "https://api.github.com/repos/zesk/build/" "$url" || returnClean $? "$temp" || return $?

  catchEnvironment "$handler" rm -f "$temp" || return $?

  local publishDate
  publishDate=$(catchEnvironment "$handler" githubPublishDate zesk/build) || return $?

  assertExitCode 0 dateValid "$publishDate" || return $?

  local latest current earliest

  #  githubLatest
  latest=$(catchEnvironment "$handler" githubLatestRelease zesk/build) || return $?

  current=$(catchEnvironment "$handler" hookVersionCurrent) || return $?

  earliest=$(printf "%s\n" "$latest" "$current" | versionSort | head -n 1) || return $?

  assertEquals "$earliest" "$latest" || return $?
}

# githubRelease is tested in deploy.sh
