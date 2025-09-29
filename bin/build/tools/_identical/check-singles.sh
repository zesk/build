#!/usr/bin/env bash
#
# Checking identical
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# In case you forgot, the directory in which this file is named `_identical` and *NOT* `identical`.
#
# This is to avoid having this match when doing `identicalRepair` - causes issues.
#
# Thanks for your consideration.
#

_identicalCheckSinglesChecker() {
  local handler="$1" stateFile && shift

  # Arguments
  stateFile=$(usageArgumentFile "$handler" stateFile "${1-}") && shift || return $?

  local tempDirectory singles=() item resultsFile identicalCode

  identicalCode=$(returnCode identical)
  # Fetch from state file
  tempDirectory=$(__catch "$handler" environmentValueRead "$stateFile" tempDirectory) || return $?
  resultsFile=$(__catch "$handler" environmentValueRead "$stateFile" resultsFile) || return $?
  while read -r item; do singles+=("$item"); done < <(__catch "$handler" environmentValueReadArray "$stateFile" "singles") || return $?

  local tokenFile targetFile matchFile exitCode=0 done=false
  local allSingles=() knownSingles=() knownSinglesReport=() lonelySingles=() lonelySinglesReport=() lonelySinglesFiles=()

  while ! $done; do
    local token
    read -r matchFile || done=true
    [ -n "$matchFile" ] || continue
    if [ ! -f "$matchFile.compare" ]; then
      tokenFile="$(dirname "$matchFile")"
      token="$(basename "$matchFile")"
      token="${token%%.match}"
      token="${token#*@}"
      tokenFile="$tokenFile/$token"
      local lineCount
      IFS=$'\n' read -d "" -r lineCount lineNumber targetFile <"$tokenFile"
      allSingles+=("$token")
      local linesNoun
      linesNoun=$(pluralWord "$lineCount" line)
      if inArray "$token" "${singles[@]+"${singles[@]}"}"; then
        knownSingles+=("$token")
        knownSinglesReport+=("$(printf -- "%s in %s" "$(decorate code "$token")" "$(decorate info "$(decorate file "$targetFile")")"):$lineNumber ($linesNoun)")
      else
        lonelySingles+=("$token")
        lonelySinglesFiles+=("$targetFile")
        lonelySinglesReport+=("$(printf -- "%s in %s" "$(decorate code "$token")" "$(decorate notice "$(decorate file "$targetFile")")"):$lineNumber ($linesNoun)")
        exitCode="$identicalCode"
      fi
    fi
  done < <(find "$tempDirectory" -type f -name '*.match' || :)

  if [ "${#lonelySinglesReport[@]}" -gt 0 ]; then
    statusMessage --last printf -- "%s:\n%s" "$(decorate warning "Single $(plural ${#lonelySinglesReport[@]} token)")" "$(printf -- "- %s\n" "${lonelySinglesReport[@]}")" >>"$resultsFile"
  elif [ "${#knownSinglesReport[@]}" -gt 0 ]; then
    statusMessage --last printf -- "%s:\n%s" "$(decorate notice "Single $(plural ${#knownSinglesReport[@]} token) (known)")" "$(printf -- "- %s\n" "${knownSinglesReport[@]}")"
  fi
  if [ -n "$binary" ] && [ "${#lonelySinglesFiles[@]}" -gt 0 ]; then
    "$binary" "${lonelySinglesFiles[@]}"
  fi
  __catch "$handler" environmentValueWriteArray "allSingles" "${allSingles[@]+"${allSingles[@]}"}" >>"$stateFile" || return $?
  __catch "$handler" environmentValueWriteArray "knownSingles" "${knownSingles[@]+"${knownSingles[@]}"}" >>"$stateFile" || return $?
  __catch "$handler" environmentValueWriteArray "lonelySingles" "${lonelySingles[@]+"${lonelySingles[@]}"}" >>"$stateFile" || return $?
  __catch "$handler" environmentValueWriteArray "lonelySinglesFiles" "${lonelySinglesFiles[@]+"${lonelySinglesFiles[@]}"}" >>"$stateFile" || return $?

  for token in "${singles[@]+"${singles[@]}"}"; do
    if ! inArray "$token" "${knownSingles[@]+"${knownSingles[@]}"}"; then
      while read -r tokenFile; do
        tokenFile="$(tail -n 1 "$tokenFile")"
        printf -- "%s: %s %s\n" "$(decorate warning "Multiple instance of --single token found:")" "$(decorate error "$token")" "$(decorate info "$(decorate file "$tokenFile")")"
      done < <(find "$tempDirectory" -name "$token" -type f)
    fi
  done
  return "$exitCode"
}
