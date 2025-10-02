#!/usr/bin/env bash
#
# Different OS (platforms) tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__buildTestPlatformOutput() {
  local image="$1" && shift
  local exitCode="$1" && shift
  local elapsed="$1" && shift

  local color=success verb="succeeded"
  if [ "$success" != true ]; then
    color="error" && verb="failed"
  fi
  bigText "Test: $image" | decorate "$color"
  printf "%s %s %s\n" "$(decorate "$color" "$image")" "$verb" "$(decorate magenta "$(timingFormat "$elapsed") seconds")"
}

buildTestPlatforms() {
  local handler="_${FUNCNAME[0]}"

  local testHome
  testHome="$(__catch "$handler" buildHome)" || return $?

  local safeTestFiles
  local platforms="$testHome/etc/platform.txt"
  [ -f "$platforms" ] || __throwArgument "$handler" "Missing test directory" || return $?

  __buildTestRequirements "$handler" || return $?

  local lastRunPlatform="$testHome/.last-run-platform" lastImage="" returnCode=0

  safeTestFiles=$(buildCacheDirectory "${FUNCNAME[0]}") || return $?
  local name clean=("$safeTestFiles")
  name=$(__catch "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?

  if [ -f "$lastRunPlatform" ]; then
    local image success elapsed
    while read -r image exitCode elapsed; do
      __buildTestPlatformOutput "$image" "$exitCode" "$elapsed"
      [ "$exitCode" != "0" ] || [ -n "$lastImage" ] || lastImage="$image"
    done <"$lastRunPlatform"
  fi
  local image exitCode=0

  while read -r image; do
    local pathName="${image//[^[:alnum:]]/_}"

    __catch "$handler" directoryRequire "$safeTestFiles/$pathName" || return $?
    for f in "bin" "test" "etc" "documentation"; do
      statusMessage decorate info "Copying $(decorate code "$name") [$f] to $(decorate file "$safeTestFiles/$pathName/$f")"
      __catchEnvironment "$handler" cp -R "$testHome/$f" "$safeTestFiles/$pathName/$f" || return $?
    done

    if [ -n "$lastImage" ]; then
      if [ "$image" = "$lastImage" ]; then
        lastImage=""
      fi
      continue
    fi
    bigText "Test: $image" | decorate subtle

    local start exitCode=0 elapsed
    start=$(timingStart)
    __echo dockerLocalContainer --local "$safeTestFiles/$pathName" --path "/var/buildTest" --verbose --handler "$handler" --image "$image" "/var/buildTest/bin/test.sh" -c "$@" || exitCode=$?
    elapsed=$(($(timingStart) - start))
    __buildTestPlatformOutput "$image" "$exitCode" "$elapsed"
    [ $exitCode -eq 0 ] || returnCode=$exitCode
    [ $returnCode -eq 0 ] || printf "%s %s %s\n" "$image" "$exitCode" "$elapsed" >>"$lastRunPlatform"
  done <"$platforms"

  [ $returnCode -ne 0 ] || __catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  return $returnCode
}
_buildTestPlatforms() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
