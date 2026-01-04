#!/usr/bin/env bash
#
# Different OS (platforms) tests
#
# Copyright &copy; 2026 Market Acumen, Inc.
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

# Run Zesk Build tests on multiple platforms
# Argument: --env-file envFile - Optional. File. Environment file to load - can handle any format.
buildTestPlatforms() {
  local handler="_${FUNCNAME[0]}"

  local ee=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --env-file)
      # shift here never fails as [ #$ -gt 0 ]
      shift && ee+=("$(usageArgumentRealFile "$handler" "$argument" "${1-}")") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  decorate error ENV FILES "${ee[@]}"
  printf "\n"

  local testHome
  testHome="$(catchReturn "$handler" buildHome)" || return $?

  local safeTestFiles
  local platforms="$testHome/etc/platform.txt"
  [ -f "$platforms" ] || throwArgument "$handler" "Missing test directory" || return $?

  __buildTestRequirements "$handler" || return $?

  local lastRunPlatform="$testHome/.last-run-platform" returnCode=0
  local currentRunPlatform="$lastRunPlatform.current"

  safeTestFiles=$(buildCacheDirectory "${FUNCNAME[0]}") || return $?
  local name
  name=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?

  local passedImages=()
  printf "" >"$currentRunPlatform"
  if [ -f "$lastRunPlatform" ]; then
    local image success elapsed
    while read -r image exitCode elapsed; do
      __buildTestPlatformOutput "$image" "$exitCode" "$elapsed"
      if [ "$exitCode" = "0" ]; then
        printf "%s %s %s\n" "$image" "$exitCode" "$elapsed" >>"$currentRunPlatform"
        passedImages+=("$image")
      fi
    done <"$lastRunPlatform"
  fi
  local image exitCode=0

  local interrupt
  interrupt=$(returnCode interrupt)
  while read -r image; do
    local pathName="${image//[^[:alnum:]]/_}"
    if [ "${#passedImages[@]}" -gt 0 ] && inArray "$image" "${passedImages[@]}"; then
      decorate info "Already passed $(decorate code "$image") ... skipping"
      continue
    fi
    catchReturn "$handler" directoryRequire "$safeTestFiles/$pathName" || return $?
    local f
    for f in "bin" "test" "etc" "documentation"; do
      statusMessage decorate info "Copying $(decorate code "$name") [$f] to $(decorate file "$safeTestFiles/$pathName/$f")"
      [ ! -d "$safeTestFiles/$pathName/$f" ] || catchEnvironment "$handler" rm -rf "$safeTestFiles/$pathName/$f" || return $?
      catchEnvironment "$handler" cp -R "$testHome/$f" "$safeTestFiles/$pathName/$f" || return $?
    done
    local testEnv="$safeTestFiles/$pathName/.test.env"
    catchEnvironment "$handler" printf "" >"$testEnv" || return $?
    [ "${#ee[@]}" -eq 0 ] || for f in "${ee[@]}"; do
      catchEnvironment "$handler" cat "$f" >>"$testEnv" || return $?
    done
    bigText "Test: $image" | decorate subtle

    local start exitCode=0 elapsed logFile="$safeTestFiles/$pathName.log"
    start=$(timingStart)
    decorate info "Logging to $(decorate file "$logFile") ..."
    executeEcho dockerLocalContainer --local "$safeTestFiles/$pathName" --path "/var/buildTest" --verbose --handler "$handler" --image "$image" "/var/buildTest/bin/test.sh" --env-file "/var/buildTest/.test.env" -c "$@" | tee "$logFile" || exitCode=$?
    if [ "$exitCode" -eq "$interrupt" ]; then
      returnCode=$interrupt
      break
    fi
    elapsed=$(($(timingStart) - start))
    __buildTestPlatformOutput "$image" "$exitCode" "$elapsed"
    [ "$exitCode" -eq 0 ] || returnCode=$exitCode
    printf "%s %s %s\n" "$image" "$exitCode" "$elapsed" >>"$currentRunPlatform"
  done <"$platforms"
  catchEnvironment "$handler" mv "$currentRunPlatform" "$lastRunPlatform" || return $?
  # [ $returnCode -ne 0 ] || catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  return "$returnCode"
}
_buildTestPlatforms() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
