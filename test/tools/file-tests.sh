#!/usr/bin/env bash
#
# os-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testBasicFileStuff() {
  local testDir
  local testFile

  testDir=$(__environment mktemp -d) || return $?

  testFile="$testDir/$(randomString).$$"
  __environment touch "$testFile" || return $?
  assertExitCode 0 modificationTime "$testFile" || return $?
  assertExitCode 0 modificationSeconds "$testFile" || return $?
}

_assertBetterType() {
  assertEquals --line "$1" "$2" "$(betterType "$3")" "$2 != betterType $3 $(decorate red "=> $(betterType "$3")")" || return $?
}

testBetterType() {
  _assertBetterType "$LINENO" "builtin" return || return $?
  _assertBetterType "$LINENO" "builtin" . || return $?
  _assertBetterType "$LINENO" "function" testBetterType || return $?
  _assertBetterType "$LINENO" "file" "${BASH_SOURCE[0]}" || return $?
  _assertBetterType "$LINENO" "directory" ../. || return $?
  _assertBetterType "$LINENO" "unknown" fairElections || return $?

  local d
  d=$(mktemp -d) || return $?
  requireDirectory "$d/food" >/dev/null || return $?
  ln -s "$d/food" "$d/food-link" || return $?

  touch "$d/goof" || return $?
  ln -s "$d/no-goof" "$d/no-goof-link" || return $?
  ln -s "$d/goof" "$d/goof-link" || return $?

  _assertBetterType "$LINENO" "directory" "$d/food" || return $?
  _assertBetterType "$LINENO" "link-directory" "$d/food-link" || return $?
  _assertBetterType "$LINENO" "file" "$d/goof" || return $?
  _assertBetterType "$LINENO" "link-unknown" "$d/no-goof-link" || return $?
  _assertBetterType "$LINENO" "link-file" "$d/goof-link" || return $?

  rm -rf "$d" || return $?
}

_invertMatches() {
  local output
  while [ $# -gt 0 ]; do
    case "$1" in
      --stdout-match)
        output="--stdout-no-match"
        ;;
      --stdout-no-match)
        output="--stdout-match"
        ;;
      *)
        output="$1"
        ;;
    esac
    printf "%s\n" "$output"
    shift
  done
}

testFileMatches() {
  local home matchFiles match matches invertedMatches ex pattern neverMatches

  ex=()
  matchFiles=$(__environment mktemp) || return $?
  home=$(__environment buildHome) || return $?

  __environment find "$home/test/matches" -type f >"$matchFiles" || return $?

  # dumpPipe "match file list" <"$matchFiles"
  # zulu simple
  pattern="zulu"
  ex=()
  matches=(
    --stdout-match "/a.txt"
    --stdout-match "/aa.txt"
    --stdout-match "/bb.txt"
    --stdout-no-match "/b.txt"
    --stdout-no-match "/ab.txt"
    --stdout-no-match "/ba.txt"
  )
  invertedMatches=() && while read -r match; do invertedMatches+=("$match"); done < <(_invertMatches "${matches[@]}")

  assertExitCode --line "$LINENO" "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode --line "$LINENO" "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

  # zulu exceptions
  pattern="zulu"
  ex=(b.txt)
  matches=(
    --stdout-match "/a.txt"
    --stdout-match "/aa.txt"
    --stdout-no-match "/ba.txt"
  )
  invertedMatches=() && while read -r match; do invertedMatches+=("$match"); done < <(_invertMatches "${matches[@]}")
  # exception never matches i
  neverMatches=(--stdout-no-match "/bb.txt" --stdout-no-match "/b.txt" --stdout-no-match "/ab.txt")
  matches+=("${neverMatches[@]}")
  invertedMatches+=("${neverMatches[@]}")

  assertExitCode --line "$LINENO" "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode --line "$LINENO" "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

  # zulu beginning of line
  pattern="^zulu"
  ex=()
  matches=(
    --stdout-match "/a.txt"
    --stdout-no-match "/aa.txt"
    --stdout-match "/bb.txt"
    --stdout-no-match "/b.txt"
    --stdout-no-match "/ab.txt"
    --stdout-no-match "/ba.txt"
  )
  invertedMatches=() && while read -r match; do invertedMatches+=("$match"); done < <(_invertMatches "${matches[@]}")

  assertExitCode --line "$LINENO" "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode --line "$LINENO" "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

  # zulu EOL
  pattern="zulu$"
  ex=()
  matches=(
    --stdout-match "/a.txt"
    --stdout-match "/aa.txt"
    --stdout-no-match "/bb.txt"
    --stdout-no-match "/b.txt"
    --stdout-no-match "/ab.txt"
    --stdout-no-match "/ba.txt"
  )
  invertedMatches=() && while read -r match; do invertedMatches+=("$match"); done < <(_invertMatches "${matches[@]}")

  assertExitCode --line "$LINENO" "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode --line "$LINENO" "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

  # Devops
  pattern="Devops"
  ex=()
  matches=(
    --stdout-no-match "/a.txt"
    --stdout-no-match "/aa.txt"
    --stdout-no-match "/bb.txt"
    --stdout-match "/b.txt"
    --stdout-no-match "/ab.txt"
    --stdout-match "/ba.txt"
  )
  invertedMatches=() && while read -r match; do invertedMatches+=("$match"); done < <(_invertMatches "${matches[@]}")

  assertExitCode --line "$LINENO" "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode --line "$LINENO" "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

  # Fancier RE
  pattern='set ["]\?-x'
  ex=()
  matches=(
    --stdout-match "/a.txt"
    --stdout-no-match "/aa.txt"
    --stdout-match "/bb.txt"
    --stdout-no-match "/b.txt"
    --stdout-no-match "/ab.txt"
    --stdout-match "/ba.txt"
  )
  invertedMatches=() && while read -r match; do invertedMatches+=("$match"); done < <(_invertMatches "${matches[@]}")

  assertExitCode --line "$LINENO" "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode --line "$LINENO" "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

  # Exclude everything
  pattern='.'
  ex=(txt)
  matches=(
    --stdout-no-match "/a.txt"
    --stdout-no-match "/aa.txt"
    --stdout-no-match "/bb.txt"
    --stdout-no-match "/b.txt"
    --stdout-no-match "/ab.txt"
    --stdout-no-match "/ba.txt"
  )
  invertedMatches=("${matches[@]}")

  assertNotExitCode --line "$LINENO" "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertNotExitCode --line "$LINENO" "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

  # Include everything (blank files are skipped)
  pattern='.'
  ex=()
  matches=(
    --stdout-match "/a.txt"
    --stdout-match "/aa.txt"
    --stdout-match "/bb.txt"
    --stdout-match "/b.txt"
    --stdout-no-match "/ab.txt"
    --stdout-match "/ba.txt"
  )
  invertedMatches=() && while read -r match; do invertedMatches+=("$match"); done < <(_invertMatches "${matches[@]}")

  assertExitCode --line "$LINENO" "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode --line "$LINENO" "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
}

testLinkCreate() {
  local home target

  home=$(__environment buildHome) || return $?

  target="wacky.$$"
  assertFileDoesNotExist --line "$LINENO" "$home/bin/build/$target" || return $?
  assertExitCode --line "$LINENO" 0 linkCreate --help || return $?
  assertExitCode --line "$LINENO" 0 linkCreate "$home/bin/build/tools.sh" "$target" || return $?
  assertExitCode --line "$LINENO" 0 test -L "$home/bin/build/$target" || return $?
  assertExitCode --line "$LINENO" 0 "$home/bin/build/$target" linkCreate "$home/bin/build/tools.sh" "$target.ALT" || return $?
  assertExitCode --line "$LINENO" 0 test -L "$home/bin/build/$target.ALT" || return $?
  assertExitCode --line "$LINENO" 0 "$home/bin/build/$target.ALT" linkCreate "$home/bin/build/tools.sh" "$target.FINAL" || return $?
  assertExitCode --line "$LINENO" 0 test -L "$home/bin/build/$target.FINAL" || return $?
  assertEquals --line "$LINENO" "$((0 + $(find "$home/bin/build" -name "wacky.*" | wc -l)))" "3" || return $?
  __environment rm -rf "$home/bin/build/$target*" || return $?
}
