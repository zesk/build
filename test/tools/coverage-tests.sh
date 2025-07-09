#!/usr/bin/env bash
#
# coverage-tests.sh
#
# Coverage tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Leak: BASH_ARGC
# Leak: BASH_ARGV
testCoverageBasics() {
  assertExitCode --dump --stdout-match "Collecting coverage to" --stdout-match "Coverage completed" 0 bashCoverage --verbose isInteger 2 || return $?
}

#
testCoverageNeedToUpdate() {
  local home

  home=$(__environment buildHome) || return $?
  # THIS FAILS - INFINITE LOOP
  # assertExitCode --dump --stdout-match "Target is" --stdout-match "Coverage completed" 0 bashCoverage "$home/bin/build/tools.sh" isInteger 2 || return $?
  assertEquals "$home" "$home" || return $?
}

testCoverageReportThing() {
  local codes expected template

  codes=$(printf "%s\n" "return" "1")

  template="$(__bashCoverageReportTemplate "not-covered.html")"
  expected='&nbsp;&nbsp;[&nbsp;$#&nbsp;-gt&nbsp;0&nbsp;]&nbsp;||&nbsp;<em>return</em>&nbsp;<em>1</em>'
  assertEquals "$(__bashCoveragePartialLine '  [ $# -gt 0 ] || return 1' "$codes" "$template")" "$expected" || return $?

  codes=$(printf "%s\n" '[ $# -gt 0 ]')
  expected='&nbsp;&nbsp;<em>[&nbsp;$#&nbsp;-gt&nbsp;0&nbsp;]</em>&nbsp;||&nbsp;return&nbsp;1'
  assertEquals "$(__bashCoveragePartialLine '  [ $# -gt 0 ] || return 1' "$codes" "$template")" "$expected" || return $?
}

# Tag: slow-30-seconds slow
testBuildFunctionsCoverage() {
  local usage="_return"

  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  local deprecatedFunctions allTestFiles clean=()
  deprecatedFunctions=$(fileTemporaryName "$usage") || return $?
  allTestFiles=$(fileTemporaryName "$usage") || return $?
  clean+=("$deprecatedFunctions")
  clean+=("$allTestFiles")

  __catchEnvironment "$usage" cut -f 1 -d '|' <"$home/bin/build/deprecated.txt" | grep -v '#' | grep -v ' ' | grep -v '/' | sort -u >"$deprecatedFunctions" || return $?
  __catchEnvironment "$usage" find "$home/test/tools" -type f -name '*.sh' -print0 >"$allTestFiles" || return $?

  local requireCoverageDate
  requireCoverageDate=$(buildEnvironmentGet BUILD_COVERAGE_REQUIRED_DATE) || return $?
  assertExitCode 0 dateValid "$requireCoverageDate" || return $?

  local function missing=()
  while read -r function; do
    # statusMessage decorate info "Looking at $function"
    if grep -q -e "^$(quoteGrepPattern "$function")$" <"$deprecatedFunctions"; then
      statusMessage decorate subtle "Deprecated function: $(decorate code "$function")"
    else
      local matchingTests foundCount

      # grep returns 1 when nothing matches
      matchingTests=$(xargs -r -0 grep -l "$(quoteGrepPattern "$function")" <"$allTestFiles" || mapReturn $? 1 0) || return $?
      foundCount=$(__catchEnvironment "$usage" fileLineCount <<<"$matchingTests") || return $?

      if [ "$foundCount" -eq 0 ]; then
        missing+=("$function")
        statusMessage --last decorate warning "No references found for $(decorate code "$function")"
      else
        statusMessage decorate info "$foundCount $(plural "$foundCount" reference references) to $(decorate code "$function")"
      fi
    fi
  done < <(buildFunctions)
  __catchEnvironment "$usage" rm -f "${clean[@]}" || return $?
  if [ "$(date +%s)" -lt "$(dateToTimestamp "$requireCoverageDate")" ]; then
    [ "${#missing[@]}" -eq 0 ] || printf "%s %s\n%s\n" "$(decorate notice "This test will FAIL")" "$(decorate magenta "after $requireCoverageDate")" "$(printf "%s\n" "${missing[@]}" | decorate code | decorate wrap "- ")"
  else
    [ "${#missing[@]}" -eq 0 ] || __throwEnvironment "$usage" "Functions require at least 1 test: ($(decorate magenta "after $requireCoverageDate")):"$'\n'"$(printf "%s\n" "${missing[@]}" | decorate code | decorate wrap "- ")"
  fi
}
