#!/usr/bin/env bash
#
# os-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testBasicFileStuff() {
  local testDir
  local testFile
  local handler="_return"

  testDir=$(fileTemporaryName "$handler" -d) || return $?

  testFile="$testDir/$(randomString).$$"
  __environment touch "$testFile" || return $?
  assertExitCode 0 fileModificationTime "$testFile" || return $?
  assertExitCode 0 fileModificationSeconds "$testFile" || return $?

  __catch "$handler" rm -rf "$testDir" || return $?
}

_assertBetterType() {
  assertEquals --line "$1" "$2" "$(fileType "$3")" "$2 != fileType $3 $(decorate red "=> $(fileType "$3")")" || return $?
}

testBetterType() {
  local handler="_return"

  _assertBetterType "$LINENO" "builtin" return || return $?
  _assertBetterType "$LINENO" "builtin" . || return $?
  _assertBetterType "$LINENO" "function" testBetterType || return $?
  _assertBetterType "$LINENO" "file" "${BASH_SOURCE[0]}" || return $?
  _assertBetterType "$LINENO" "directory" ../. || return $?
  _assertBetterType "$LINENO" "unknown" fairElections || return $?

  local d
  d=$(fileTemporaryName "$handler" -d) || return $?

  __catch "$handler" directoryRequire "$d/food" >/dev/null || return $?
  __catchEnvironment "$handler" ln -s "$d/food" "$d/food-link" || return $?

  __catchEnvironment "$handler" touch "$d/goof" || return $?
  __catchEnvironment "$handler" ln -s "$d/no-goof" "$d/no-goof-link" || return $?
  __catchEnvironment "$handler" ln -s "$d/goof" "$d/goof-link" || return $?

  _assertBetterType "$LINENO" "directory" "$d/food" || return $?
  _assertBetterType "$LINENO" "link-directory" "$d/food-link" || return $?
  _assertBetterType "$LINENO" "file" "$d/goof" || return $?
  _assertBetterType "$LINENO" "link-unknown" "$d/no-goof-link" || return $?
  _assertBetterType "$LINENO" "link-file" "$d/goof-link" || return $?

  __catchEnvironment "$handler" rm -rf "$d" || return $?
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
  local handler="_return"
  local home matchFiles match matches invertedMatches ex pattern neverMatches

  ex=()
  matchFiles=$(fileTemporaryName "$handler") || return $?
  home=$(__catch "$handler" buildHome) || return $?

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

  assertExitCode "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

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

  assertExitCode "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

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

  assertExitCode "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

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

  assertExitCode "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

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

  assertExitCode "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

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

  assertExitCode "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

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

  assertNotExitCode "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertNotExitCode "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?

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

  assertExitCode "${matches[@]}" 0 fileMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
  assertExitCode "${invertedMatches[@]}" 0 fileNotMatches "$pattern" -- "${ex[@]+"${ex[@]}"}" -- - <"$matchFiles" || return $?
}

testLinkCreate() {
  local home target

  home=$(__environment buildHome) || return $?

  find "$home/bin/build/" -maxdepth 1 -name 'wacky.*' -exec rm {} \; || :

  target="wacky.$$"
  assertFileDoesNotExist --line "$LINENO" "$home/bin/build/$target" || return $?
  assertExitCode 0 linkCreate --help || return $?
  assertExitCode 0 linkCreate "$home/bin/build/tools.sh" "$target" || return $?
  assertExitCode 0 test -L "$home/bin/build/$target" || return $?
  assertExitCode 0 "$home/bin/build/$target" linkCreate "$home/bin/build/tools.sh" "$target.ALT" || return $?
  assertExitCode 0 test -L "$home/bin/build/$target.ALT" || return $?
  assertExitCode 0 "$home/bin/build/$target.ALT" linkCreate "$home/bin/build/tools.sh" "$target.FINAL" || return $?
  assertExitCode 0 test -L "$home/bin/build/$target.FINAL" || return $?
  assertNotExitCode --stderr-match "Can not link to another link" --line "$LINENO" 0 "$home/bin/build/$target.ALT" linkCreate "$home/bin/build/$target.FINAL" "$target.NoLinkyLinks" || return $?
  assertExitCode 0 test -L "$home/bin/build/$target.FINAL" || return $?
  assertEquals "$(find "$home/bin/build" -name "wacky.*" | fileLineCount)" "3" || return $?
  __environment rm -rf "$home/bin/build/$target*" || return $?
}

testFileLineCount() {
  local usage="_return"
  local temp

  temp=$(fileTemporaryName "$usage") || return $?

  assertEquals 0 "$(fileLineCount "$temp")" || return $?
  assertEquals 0 "$(fileLineCount <"$temp")" || return $?

  __catchEnvironment "$usage" printf "%s\n" "$(randomString)" >>"$temp" || return $?

  assertEquals 1 "$(fileLineCount "$temp")" || return $?
  assertEquals 1 "$(fileLineCount <"$temp")" || return $?

  local total=1 i r

  for i in 1 2 3 4 5; do
    r=$((RANDOM % 10))
    total=$((total + r))
    while [ "$r" -gt 0 ]; do
      __catchEnvironment "$usage" printf "%d: %s\n" "$i" "$(randomString)" >>"$temp" || return $?
      r=$((r - 1))
    done
    assertEquals "$total" "$(fileLineCount "$temp")" || return $?
    assertEquals "$total" "$(fileLineCount <"$temp")" || return $?
  done

  __catchEnvironment "$usage" rm "$temp" || return $?
}
