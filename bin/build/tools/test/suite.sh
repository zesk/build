#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# suite.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__testSuiteCacheDirectory() {
  local handler="$1" && shift
  catchReturn "$handler" buildCacheDirectory "testSuite/$(buildEnvironmentGet APPLICATION_CODE)" || return $?
}

# Compile tests into a cache structure which makes it easy to search after built
__testSuiteTestsProcess() {
  local handler="$1" && shift
  local cacheDirectory="$1" && shift
  local beQuiet="$1" && shift

  cacheDirectory=$(catchEnvironment "$handler" directoryRequire "$cacheDirectory") || return $?
  local manifestFile="$cacheDirectory/manifest" manifestNewFile="$cacheDirectory/manifest.current.$$"

  local prettyPaths=() paths=() && while [ $# -gt 0 ]; do
    local path && path="$(validate "$handler" Directory testPath "$1")" || return $?
    paths+=("$path")
    prettyPaths+=("$(decorate file "$path")")
    shift
  done
  local clean=("$manifestNewFile")
  __testSuitesNames "$handler" "${paths[@]}" | xargs -n 1 sha1sum | sort -u >"$manifestNewFile" || returnClean $? "${clean[@]}" || return $?
  if [ -f "$manifestFile" ] && filesAreIdentical "$manifestFile" "$manifestNewFile"; then
    $beQuiet || statusMessage decorate info "Test suite cache is up to date: ${prettyPaths[*]}" || returnClean $? "${clean[@]}" || return $?
    catchReturn "$handler" rm -f "${clean[@]}" || return $?
    return 0
  fi
  local stats=()
  catchReturn "$handler" find "$cacheDirectory" -maxdepth 1 -mindepth 1 -type d -exec touch "{}/.processMarker" \; || return $?
  while read -r checksum filename; do
    local prettyFile && prettyFile=$(decorate file "$filename")
    local suiteName && suiteName=$(__testSuitePathToCode "$filename")
    local statsStart && statsStart=$(timingStart)
    if [ ! -d "$cacheDirectory/$checksum" ]; then
      $beQuiet || statusMessage decorate info "Processing tests in $prettyFile" || returnClean $? "${clean[@]}" || return $?
      __testSuiteTestFileProcess "$handler" "$suiteName" "$cacheDirectory" "$checksum" "$filename" || returnClean $? "${clean[@]}" || return $?
    else
      $beQuiet || statusMessage decorate info "Updating tests in $prettyFile" || returnClean $? "${clean[@]}" || return $?
      __testSuiteTestFileUpdate "$handler" "$suiteName" "$cacheDirectory" "$checksum" "$filename" || returnClean $? "${clean[@]}" || return $?
    fi
    stats+=("$(timingElapsed "$statsStart")")
    catchReturn "$handler" rm -f "$cacheDirectory/$checksum/.processMarker" || returnClean $? "${clean[@]}" || return $?
  done < <(sort -k 2 "$manifestNewFile") || returnClean $? "${clean[@]}" || return $?
  (
    environmentLoad < <(__stats "${stats[@]}")
    statusMessage decorate info "Loaded {count} files in {total} milliseconds, slowest {max} ms, average {average} ms." | mapEnvironment
  )
  # Delete any directory which still has a .processMarker
  # shellcheck disable=SC2038
  catchEnvironment "$handler" find "$cacheDirectory" -type f -name ".processMarker" -exec dirname {} \; | catchEnvironment "$handler" xargs rm -rf || return $?

  clean+=("$cacheDirectory/testFinder.$$")
  catchReturn "$handler" find "$cacheDirectory" -type f -name "*-testFinder" | cut -c "$((${#cacheDirectory} + 2))-" | sort -t / -k 2 | decorate wrap "$cacheDirectory/" | xargs cat >"$cacheDirectory/testFinder" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" find "$cacheDirectory" -type f -name ".current" -delete || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" find "$cacheDirectory" -type f -name "tag.*" -exec basename {} \; | sort -u | cut -f 2 -d . >"$cacheDirectory/tags" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" mv -f "$manifestNewFile" "$manifestFile" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" rm -rf "${clean[@]}" || return $?
  catchReturn "$handler" find "$cacheDirectory" -type f -name "manifest.current.*" -delete || return $?
}

__testSuiteTestFileUpdate() {
  local handler="$1" && shift
  local suiteName="$1" && shift
  local cacheDirectory="$1" && shift
  local checksum="$1" && shift
  local filename="$1" && shift

  local testFileCache && testFileCache="$cacheDirectory/$checksum"

  # decorate error __testSuiteTestFileUpdate "$suiteName" "$filename" 1>&2
  local testFinder="$testFileCache/$suiteName-testFinder"
  if [ ! -f "$testFinder" ]; then
    __testSuiteTestFileProcess "$handler" "$suiteName" "$cacheDirectory" "$checksum" "$filename" || return $?
  fi
}

__stats() {
  local mm=() count=0 total=0

  [ -z "$prefix" ] || prefix="${prefix% } "
  while [ $# -gt 0 ]; do
    if [ ${#mm[@]} -eq 0 ]; then
      mm=("$1" "$1")
    else
      [ "$1" -gt "${mm[0]}" ] || mm[0]="$1"
      [ "$1" -lt "${mm[1]}" ] || mm[1]="$1"
    fi
    total=$((total + ${1}))
    count=$((count + 1))
    shift
  done
  local average=$((total / count))
  printf "%s\n" "min=${mm[0]}" "max=${mm[1]}" "total=$total" "count=$count" "average=$average"
}

#
# Process foo-tests.sh - and generate a cache directory for the test file
#
__testSuiteTestFileProcess() {
  local handler="$1" && shift
  local suiteName="$1" && shift
  local cacheDirectory="$1" && shift
  local checksum="$1" && shift
  local filename="$1" && shift

  local home && home="$(catchReturn "$handler" buildHome)/" || return $?

  local testFileCache && testFileCache=$(catchReturn "$handler" directoryRequire "$cacheDirectory/$checksum") || return $?
  local clean=("$testFileCache")
  local testFinder="$testFileCache/$suiteName-testFinder"
  local testFinderTemp="$testFinder.$$"
  clean+=("$testFinderTemp")
  local testFunction && while read -r testFunction; do
    __testSuiteTestFunctionProcess "$handler" "$testFileCache/$testFunction" "$filename" "$testFunction" "$suiteName" "$home" >>"$testFinderTemp" || returnClean $? "${clean[@]}" || return $?
  done < <(__testLoad "$handler" "$filename")
  __testSuiteOrdering "$handler" --cache "$cacheDirectory" < <(catchReturn "$handler" sort -u "$testFinderTemp") >"$testFinder" || throwEnvironment "$handler" "Ordering failed $?" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -f "$testFinderTemp" || return $?
}

#
# Process foo-tests.sh testFunctionName - and generate a cache directory for the test function
#
__testSuiteTestFunctionProcess() {
  local handler="$1" && shift
  local functionCache="$1" && shift
  local filename="$1" && shift
  local testFunction="$1" && shift
  local suiteName="$1" && shift
  local home="$1" && shift

  local functionCache && functionCache=$(catchReturn "$handler" directoryRequire "$functionCache") || return $?
  # local settingsFile="$functionCache/settings"
  local commentFile="$functionCache/comment"
  local clean=("$commentFile")
  catchReturn "$handler" bashFunctionComment "$filename" "$testFunction" >"$commentFile" || returnClean $? "${clean[@]}" || return $?
  local tags=() && IFS=' ' read -r -d $'\n' -a tags < <(bashCommentVariable --insensitive "Tag" <"$commentFile" | tr ' ' $'\n' | sort -u | tr $'\n' ' ' | printfOutputSuffix "\n")
  # catchReturn "$handler" environmentValueWrite testFile "${filename#"$home"}" >>"$settingsFile" || return $?
  catchReturn "$handler" find "$functionCache" -type f -name 'tag.*' -delete || return $?
  if [ "${#tags[@]}" -gt 0 ]; then
    # catchReturn "$handler" environmentValueWriteArray tags "${tags[@]}" >>"$settingsFile" || return $?
    local tag && for tag in "${tags[@]}"; do
      catchReturn "$handler" touch "$functionCache/tag.$tag" || return $?
    done
  fi
  local name value after=() before=() values=() && while IFS=":" read -r name value; do
    name=$(stringLowercase "${name//-/_}") || return $?
    value="${value# }"
    # catchReturn "$handler" environmentValueWrite "$name" "${value# }" >>"$settingsFile" || return $?
    case "$name" in
    before) IFS=" " read -r -d $'\n' -a values <<<"$value" && before+=("${values[@]+"${values[@]}"}") || return $? ;;
    after) IFS=" " read -r -d $'\n' -a values <<<"$value" && after+=("${values[@]+"${values[@]}"}") || return $? ;;
    esac
  done < <(bashCommentVariable --insensitive --prefix "Test-" <"$commentFile")
  local suffix=""
  [ "${#tags[@]}" -eq 0 ] || suffix="$suffix$(printf " tag=%s" "${tags[@]+"${tags[@]}"}")"
  [ "${#before[@]}" -eq 0 ] || suffix="$suffix$(printf " before=%s" "${before[@]+"${before[@]}"}")"
  [ "${#after[@]}" -eq 0 ] || suffix="$suffix$(printf " after=%s" "${after[@]+"${after[@]}"}")"
  printf -- "%s suite=%s %s %s\n" "$testFunction" "$suiteName" "${filename#"$home"}" "$suffix"
}
