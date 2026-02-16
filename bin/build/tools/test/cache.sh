#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# tools.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__testSuiteCacheInitialize() {
  local handler="$1" && shift
  local testCacheDirectory="$1" && shift
  local testsCache="$1" && shift

  # Note this uses the FILE path, not the file contents
  local cacheMarker && cacheMarker=$(shaPipe <<<"$testsCache") || return $?
  if [ ! -f "$testCacheDirectory/.loaded.$cacheMarker" ]; then
    catchReturn "$handler" tar zxf --cd "$testCacheDirectory" "$testsCache" || return $?
    catchReturn "$handler" find "$testCacheDirectory/" -type f -name ".loaded.*" -delete || return $?
    catchReturn "$handler" touch "$testCacheDirectory/.loaded.$cacheMarker" || return $?
  fi
}

__testSuiteCacheGenerate() {
  local handler="$1" && shift
  local testCacheDirectory="$1" && shift
  local testsCache="$1" && shift

  # Note this uses the FILE path, not the file contents
  local cacheMarker && cacheMarker=$(shaPipe <<<"$testsCache") || return $?
  catchReturn "$handler" muzzle pushd "$testCacheDirectory" || return $?
  local undo=(muzzle popd)
  catchReturn "$handler" tarCreate "$testsCache" -T - < <(find . -type f ! -path '*/\.*/*') || returnUndo $? "${undo[@]}" || return $?
  catchReturn "$handler" "${undo[@]}" || return $?
  catchReturn "$handler" touch "$testCacheDirectory/.loaded.$cacheMarker" || return $?
}
