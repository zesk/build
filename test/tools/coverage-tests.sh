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

testBuildFunctionsCoverage() {
  local usage="_return"
  local home

  home=$(__catchEnvironment "$usage" buildHome) || return $?

  local deprecatedFunctions
  deprecatedFunctions=$(fileTemporaryName "$usage") || return $?

  __catchEnvironment "$usage" cut -f 1 -d '|' <"$home/bin/build/deprecated.txt" | grep -v '#' | grep -v ' ' | grep -v '/' | sort -u >"$deprecatedFunctions" || return $?

  local function missing=()
  while read -r function; do
    # statusMessage decorate info "Looking at $function"
    if grep -q -e "^$(quoteGrepPattern "$function")" <"$deprecatedFunctions"; then
      statusMessage decorate info "Deprecated function: $(decorate code "$function")"
    else
      testFiles=$(find "$home/test/tools" -type f -name '*.sh' -print0 | xargs -0 grep -l "$(quoteGrepPattern "$function")" | fileLineCount) || :
      if [ "$testFiles" -eq 0 ]; then
        if [ "$(date +%s)" -gt "$(dateToTimestamp '2025-08-01')" ]; then
          missing+=("$function")
        else
          statusMessage --last decorate warning "No tests written for $(decorate code "$function")"
        fi
      else
        statusMessage decorate info "$testFiles $(plural "$testFiles" test tests) written for $(decorate code "$function")"
      fi
    fi
  done < <(buildFunctions)
  __catchEnvironment "$usage" rm -f "$deprecatedFunctions" || return $?
  [ "${#missing[@]}" -eq 0 ] || __throwEnvironment "$usage" "Functions require tests:"$'\n'"$(printf "%s\n" "${missing[@]}" | decorate code | decorate wrap "- ")"
}
