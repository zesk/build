#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# coverage-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Leak: BASH_ARGC
# Leak: BASH_ARGV
testCoverageBasics() {
  local handler="returnMessage"

  local tempCoverage

  tempCoverage=$(fileTemporaryName "$handler") || return $?
  assertExitCode --stdout-match "Collecting coverage to" --stdout-match "Coverage completed" 0 bashCoverage --target "$tempCoverage" --verbose isInteger 2 || return $?

  assertFileExists "$tempCoverage" || return $?

  catchReturn "$handler" rm -f "$tempCoverage" || return $?
}

#
testCoverageNeedToUpdate() {
  local handler="returnMessage"
  local home

  home=$(catchReturn "$handler" buildHome) || return $?
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

# Tag: test-tags slow
testSlowTagsWorkCorrectly() {
  local handler="returnMessage"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  local ee=("PATH=$PATH" "HOME=$HOME")
  assertExitCode --stdout-match "testBuildFunctionsCoverage" --stdout-match "${FUNCNAME[0]}" 0 /usr/bin/env -i "${ee[@]}" "$home/bin/test.sh" --tag slow --list || return $?
  assertExitCode --stdout-match "${FUNCNAME[0]}" 0 /usr/bin/env -i "${ee[@]}" "$home/bin/test.sh" --tag test-tags --list || return $?
}

__deprecatedFunctions() {
  local handler="$1" home="$2"
  catchEnvironment "$handler" cut -f 1 -d '|' <"$home/bin/build/deprecated.txt" | grep -v '#' | trimSpace | grep -v ' ' | grep -v '/' | sort -u || return $?
}

# Tag: slow-30-seconds slow
testBuildFunctionsCoverage() {
  local handler="returnMessage"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  local deprecatedFunctions allTestFiles clean=()
  deprecatedFunctions=$(fileTemporaryName "$handler") || return $?
  allTestFiles=$(fileTemporaryName "$handler") || return $?
  clean+=("$deprecatedFunctions")
  clean+=("$allTestFiles")

  __deprecatedFunctions "$handler" "$home" >"$deprecatedFunctions" || return $?
  catchReturn "$handler" __deprecatedFunctionsSoon >>"$deprecatedFunctions" || return $?
  catchEnvironment "$handler" find "$home/test/tools" -type f -name '*.sh' -print0 >"$allTestFiles" || return $?

  local requireCoverageDate
  requireCoverageDate=$(buildEnvironmentGet BUILD_COVERAGE_REQUIRED_DATE) || return $?
  assertExitCode 0 dateValid "$requireCoverageDate" || return $?

  local function missing=()
  while read -r function; do
    if [ "${function#test}" != "$function" ]; then
      continue
    fi
    statusMessage decorate info "Looking at $function"
    local pattern
    pattern=$(quoteGrepPattern "$function")

    if grep -q -e "^$pattern\$" <"$deprecatedFunctions"; then
      statusMessage decorate subtle "Deprecated function: $(decorate code "$function")"
      continue
    fi
    local matchingTests foundCount=0

    # grep returns 1 when nothing matches

    matchingTests=$(xargs -0 grep -l -e "$pattern" <"$allTestFiles" 2>/dev/null || mapReturn $? 1 0 123 0 | trimBoth) || return $?
    [ -z "$matchingTests" ] || foundCount=$(catchReturn "$handler" fileLineCount <<<"$matchingTests") || return $?
    # statusMessage decorate error "Matches $foundCount: $matchingTests"

    if [ "$foundCount" -eq 0 ]; then
      missing+=("$function")
      statusMessage --last decorate warning "No references found for $(decorate code "$function")"
    else
      statusMessage decorate info "$foundCount $(plural "$foundCount" reference references) to $(decorate code "$function"): $(head -n 1 <<<"$matchingTests")"
    fi
  done < <(buildFunctions)
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
  if [ "$(date +%s)" -lt "$(dateToTimestamp "$requireCoverageDate")" ]; then
    [ "${#missing[@]}" -eq 0 ] || printf "%s %s\n%s\n" "$(decorate notice "This test will FAIL")" "$(decorate magenta "after $requireCoverageDate")" "$(printf "%s\n" "${missing[@]}" | decorate code | decorate wrap "- ")"
  else
    [ "${#missing[@]}" -eq 0 ] || throwEnvironment "$handler" "Functions require at least 1 test: ($(decorate magenta "after $requireCoverageDate")):"$'\n'"$(printf "%s\n" "${missing[@]}" | decorate code | decorate wrap "- ")"
  fi
}
__deprecatedFunctionsSoon() {
  decorate wrap "usage""Argument" <<EOF
ApplicationDirectory
ApplicationDirectoryList
ApplicationFile
Arguments
Array
Boolean
Callable
ColonDelimitedList
CommaDelimitedList
Date
DirectoryList
EmptyString
EnvironmentVariable
Executable
Exists
Flag
Function
Link
List
LoadEnvironmentFile
Missing
Number
RealDirectory
RealFile
RemoteDirectory
Secret
String
URL
EOF
}

# Tag: slow
# Tag: slow-non-critical
testBuildFunctionsHelpCoverage() {
  local handler="returnMessage"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  local deprecatedFunctions clean=()
  deprecatedFunctions=$(fileTemporaryName "$handler") || return $?

  clean+=("$deprecatedFunctions")

  __deprecatedFunctions "$handler" "$home" >"$deprecatedFunctions" || return $?

  local requireCoverageDate
  requireCoverageDate=$(buildEnvironmentGet BUILD_COVERAGE_REQUIRED_DATE) || return $?
  assertExitCode 0 dateValid "$requireCoverageDate" || return $?

  local coverageRequired=false

  [ "$(date +%s)" -lt "$(dateToTimestamp "$requireCoverageDate")" ] || coverageRequired=true

  local eof fun missing=() functions=() blanks=() helpless=()

  eof=false
  while ! $eof; do
    read -r fun || eof=true
    [ -z "$fun" ] || functions+=("$fun")
  done < <(buildFunctions && __dataBuildFunctionsWithBlankHelp | sort -u)

  eof=false
  while ! $eof; do
    read -r fun || eof=true
    [ -z "$fun" ] || blanks+=("$fun")
  done < <(__dataBuildFunctionsWithBlankHelp)

  eof=false
  while ! $eof; do
    read -r fun || eof=true
    # Remove stars
    fun="${fun//-/}"
    if [ -n "$fun" ]; then
      helpless+=("$fun")
      if inArray "$fun" "${blanks[@]}"; then
        throwEnvironment "$handler" "$fun is in without-help and blank-help lists, pick one" || return $?
      fi
      if ! inArray "$fun" "${functions[@]}"; then
        throwEnvironment "$handler" "$fun is no longer part of core" || return $?
      fi
    fi
  done <"$home/etc/helpless.txt"

  mockEnvironmentStart BUILD_DEBUG
  mockEnvironmentStart BUILD_COLORS
  mockEnvironmentStart TEST_TRACK_ASSERTIONS

  # BUILD_COLORS on vs off
  # ON:
  #   real	16m0.432s
  #   user	7m6.802s
  #   sys	  16m1.870s
  #
  # OFF:
  #   real	15m26.865s
  #   user	6m46.296s
  #   sys	  14m43.790s

  export BUILD_DEBUG
  export BUILD_COLORS
  export TEST_TRACK_ASSERTIONS
  BUILD_DEBUG=""
  BUILD_COLORS=false
  TEST_TRACK_ASSERTIONS=false

  local lastPassedCache lastPassed="" stopAfter=1000000

  lastPassedCache="$(catchReturn "$handler" buildCacheDirectory)/.${FUNCNAME[0]}.lastPassed" || return $?

  [ ! -f "$lastPassedCache" ] || lastPassed=""$(head -n 1 "$lastPassedCache")
  local missingFile stopped=false
  missingFile="$(buildHome)/.testBuildFunctionsHelpCoverage.log"

  [ -z "$lastPassed" ] || statusMessage --last decorate warning "Starting at $(decorate code "$lastPassed")"
  for fun in "${functions[@]}"; do
    if [ -n "$lastPassed" ]; then
      if [ "$fun" = "$lastPassed" ]; then
        lastPassed=""
      else
        continue
      fi
    fi
    if [ "${fun#test}" != "$fun" ] || [ "${fun#_}" != "$fun" ] || [ "${fun#usageArgument}" != "$fun" ]; then
      continue
    fi
    if grep -q -e "^$(quoteGrepPattern "$fun")$" "$deprecatedFunctions"; then
      statusMessage decorate subtle "Deprecated function: $(decorate code "$fun")"
    elif inArray "$fun" "${helpless[@]}"; then
      statusMessage decorate info "Function has no --help: $(decorate code "$fun")"
    else
      local helpCall=("$fun" --help)
      if inArray "$fun" "${blanks[@]}"; then
        helpCall=("$fun")
      fi
      if $coverageRequired; then
        assertExitCode --stdout-match "$fun" --stdout-match "Usage:" 0 "${helpCall[@]}" || return $?
      else
        statusMessage decorate info "Attempting $(decorate each code "${helpCall[@]}") ..."
        # "$fun" --help | dumpPipe "$fun --help"
        if ! assertExitCode --stdout-match "$fun" --stdout-match "Usage:" 0 "${helpCall[@]}"; then
          missing+=("$fun")
          catchEnvironment "$handler" printf "%s\n" "$fun" >>"$missingFile" || return $?
        else
          if [ "${#missing[@]}" -eq 0 ]; then
            catchEnvironment "$handler" printf "%s\n" "$fun" >"$lastPassedCache" || return $?
          fi
        fi
      fi
    fi
    stopAfter=$((stopAfter - 1))
    if [ $stopAfter -le 0 ]; then
      stopped=true
      break
    fi
  done
  ! $stopped || statusMessage --last decorate warning "Stopped at $(decorate code "$fun")"
  [ "${#missing[@]}" -gt 0 ] || clean+=("$missingFile")
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?

  mockEnvironmentStop BUILD_DEBUG
  mockEnvironmentStop TEST_TRACK_ASSERTIONS
  mockEnvironmentStop BUILD_COLORS

  statusMessage decorate info "Exiting ${FUNCNAME[0]}..."
  [ "${#missing[@]}" -gt 0 ] || $stopped || catchEnvironment "$handler" rm -f "$lastPassedCache" || return $?
  if ! $coverageRequired; then
    [ "${#missing[@]}" -eq 0 ] || printf "%s %s\n%s\n" "$(decorate notice "Functions require --help support. This test will FAIL")" "$(decorate magenta "after $requireCoverageDate")" "$(printf "%s\n" "${missing[@]}" | decorate code | decorate wrap "- ")"
  fi
}

__dataBuildFunctionsWithBlankHelp() {
  cat <<EOF
__help
inArray
jsonPath
quoteGrepPattern
escapeDoubleQuotes
escapeSingleQuotes
escapeQuotes
replaceFirstPattern
printfOutputSuffix
printfOutputPrefix
quoteGrepPattern
sedReplacePattern
parseBoolean
newlineHide
realPath
isPlain
EOF
}

# Tag: slow slow-non-critical
testBuildFunctionsHelpOnly() {
  local handler="returnMessage"
  local fun
  export BUILD_DEBUG
  export BUILD_COLORS
  export TEST_TRACK_ASSERTIONS

  mockEnvironmentStart BUILD_DEBUG
  mockEnvironmentStart BUILD_COLORS
  mockEnvironmentStart TEST_TRACK_ASSERTIONS

  BUILD_DEBUG="fast-usage"
  BUILD_COLORS=false
  TEST_TRACK_ASSERTIONS=false

  while read -r fun; do
    assertExitCode --stderr-match "Only argument allowed is \"--help\"" 2 "$fun" "--never" || return $?
  done < <(__dataBuildFunctionsHelpIsTheOnlyOption)

  mockEnvironmentStop BUILD_DEBUG
  mockEnvironmentStop TEST_TRACK_ASSERTIONS
  mockEnvironmentStop BUILD_COLORS

}

__dataBuildFunctionsHelpIsTheOnlyOption() {
  cat <<EOF
isiTerm2
buildHome
bashDebuggerEnable
bashDebuggerDisable
awsHasEnvironment
awsProfilesList
bashBuiltins
bashStripComments
isBitBucketPipeline
brewInstall
hasConsoleAnimation
colorSampleCodes
colorSampleStyles
colorSampleSemanticStyles
isTTYAvailable
consoleColumns
consoleRows
markdownToConsole
cursorGet
daemontoolsInstall
daemontoolsIsRunning
daemontoolsHome
daemontoolsExecute
daemontoolsProcessIds
isDarwin
darwinSoundDirectory
darwinSoundNames
buildDebugStop
isBashDebug
isErrorExit
bashDebuggerEnable
bashDebuggerDisable
hasColors
decorations
deployPackageName
deprecatedIgnore
developerUndo
dockerComposeIsRunning
dockerComposeCommandList
dockerPlatformDefault
dumpDockerTestFile
insideDocker
dockerListContext
environmentNames
environmentLines
environmentSecureVariables
environmentApplicationVariables
gitInsideHook
gitRemoteHosts
gitCommitHash
gitCurrentBranch
gitHasAnyRefs
gitHookTypes
gitPreCommitCleanup
hostnameFull
bashDebuggerDisable
isiTerm2
iTerm2Aliases
iTerm2ColorNames
iTerm2ColorTypes
mariadbInstall
mariadbUninstall
mariadbDumpClean
markdownRemoveUnfinishedSections
markdownFormatList
nodePackageManagerInstall
nodePackageManagerUninstall
npmUninstall
pathCleanDuplicates
JSON
loadAverage
packageManagerDefault
phpComposerInstall
phpInstall
phpUninstall
phpLog
phpIniFile
ipLookup
rsyncInstall
buildHome
trimBoth
trimHead
trimTail
singleBlankLines
stripAnsi
randomString
timingStart
validateTypeList
xdebugInstall
xdebugEnable
xdebugDisable
EOF
}
