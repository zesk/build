#!/usr/bin/env bash
#
# github-tests.sh
#
# Git tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__testGithubURLParseData() {
  cat <<EOF
  https://github.com/project/repo project/repo
  https://github.com/another/thing/tree/master/bash another/thing
EOF
}

testGithubURLParse() {
  while read -r url expected; do
    assertEquals --line "$LINENO" "$expected" "$(githubURLParse "$url")" || return $?
  done < <(__testGithubURLParseData)
}
