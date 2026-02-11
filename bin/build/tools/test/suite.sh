#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# suite.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__testSuiteTestsProcess() {
  local handler="$1" && shift
  local cacheDirectory="$1" && shift

  local manifestFile="$cacheDirectory/manifest" manifestNewFile="$cacheDirectory/manifest.current.$$"

  catchReturn "$handler" find "$cacheDirectory" -name ".current" -delete || return $?
  local prettyPaths=() paths=() && while [ $# -gt 0 ]; do
    local path && path="$(validate "$handler" Directory testPath "$1")" || return $?
    paths+=("$path")
    prettyPaths+=("$(decorate file "$path")")
    shift
  done
  local clean=("$manifestNewFile")
  __testSuitesNames "${paths[@]}" | xargs -n 1 sha1sum | sort -u >"$manifestNewFile" || returnClean "${clean[@]}" || return $?
  if [ -f "$manifestFile" ] && filesAreIdentical "$manifestFile" "$manifestNewFile"; then
    statusMessage decorate info "Test suite cache is up to date: ${prettyPaths[*]}" || returnClean "${clean[@]}" || return $?
    catchReturn "$handler" rm -f "${clean[@]}" || return $?
    return 0
  fi

  while read -r checksum filename; do
    local prettyFile && prettyFile=$(decorate file "$filename")
    if [ ! -d "$cacheDirectory/$checksum" ]; then
      statusMessage decorate info "Creating cache for $prettyFile" || returnClean "${clean[@]}" || return $?
      __testSuiteTestFileProcess "$handler" "$cacheDirectory/$checksum" "$checksum" "$filename" || returnClean "${clean[@]}" || return $?
    else
      statusMessage decorate info "Up to date $prettyFile" || returnClean "${clean[@]}" || return $?
    fi
    catchReturn "$handler" touch "$cacheDirectory/$checksum/.current" || returnClean "${clean[@]}" || return $?
  done <"$manifestNewFile" || returnClean "${clean[@]}" || return $?

  if [ -f "$manifestFile" ]; then
    while read -r checksum filename; do
      if [ -d "$cacheDirectory/$checksum" ] && [ ! -f "$cacheDirectory/$checksum/.current" ]; then
        local testFile && testFile=$(
          local testFile="" && catchReturn "$handler" source "$cacheDirectory/$checksum/settings" || return $?
          printf "%s\n" "$testFile"
        )
        statusMessage decorate info "Removing old cache for $testFile" || returnClean "${clean[@]}" || return $?
        catchReturn "$handler" rm -rf "$cacheDirectory/$checksum" || returnClean "${clean[@]}" || return $?
      fi
    done <"$manifestFile"
  fi
  catchReturn "$handler" find "$cacheDirectory" -name ".current" -delete || returnClean "${clean[@]}" || return $?
  catchReturn "$handler" mv -f "$manifestNewFile" "$manifestFile" || return $?
}

__testSuiteTestFileProcess() {
  local handler="$1" && shift
  local testFileCache="$1" && shift
  local filename="$1" && shift

  local home && home="$(catchReturn "$handler" buildHome)/" || return $?

  catchReturn "$handler" directoryRequire "$testFileCache" || return $?
  local clean=("$testFileCache")
  local testFunction && while read -r testFunction; do
    __testSuiteTestFunctionProcess "$handler" "$testFileCache/$testFunction" "$filename" "$testFunction" "$home" || returnClean $? "${clean[@]}" || return $?
  done < <(__testLoad "$handler" "$filename")
}

__testSuiteTestFunctionProcess() {
  local handler="$1" && shift
  local functionCache="$1" && shift
  local filename="$1" && shift
  local testFunction="$1" && shift
  local home="$1" && shift

  local functionCache && functionCache=$(catchReturn "$handler" directoryRequire "$functionCache") || return $?
  local settingsFile="$functionCache/settings"
  local commentFile="$functionCache/comment"
  local clean=("$commentFile")
  catchReturn "$handler" bashFunctionComment "$filename" "$testFunction" >"$commentFile" || returnClean $? "${clean[@]}" || return $?
  local tags=() && IFS=' ' read -r -d $'\n' -a tags < <(bashCommentVariable "Tag" <"$commentFile" && bashCommentVariable "tag" <"$commentFile" | tr ' ' $'\n' | sort -u | tr $'\n' ' ' | printfOutputSuffix "\n")
  catchReturn "$handler" enviromentValueWrite testFile "${filename#"$home"}" >>"$settingsFile" || return $?
  catchReturn "$handler" enviromentValueWriteArray tags "${tags[@]}" >>"$settingsFile" || return $?
  catchReturn "$handler" find "$testFileCache" -type f -name 'tag.*' -delete || return $?
  local tag && for tag in "${tags[@]}"; do
    catchReturn "$handler" touch "$testFileCache/tag.$tag" || return $?
  done
  local name value && while IFS=":" read -r name value; do
    environmentValueWrite "$name" "${value# }" >>"$settingsFile"
  done < <(bashCommentVariable --prefix "Test-" <<<"$commentFile")
}
