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

# Usage: {fn} usage stateFile prefixIndex prefix searchFile
_identicalCheckInsideLoop() {
  local usage="$1" && shift

  local stateFile prefixIndex prefix searchFile

  # Arguments
  stateFile=$(usageArgumentFile "$usage" stateFile "${1-}") && shift || return $?
  prefixIndex=$(usageArgumentInteger "$usage" prefixIndex "${1-}") && shift || return $?
  prefix=$(usageArgumentString "$usage" prefix "${1-}") && shift || return $?
  searchFile=$(usageArgumentString "$usage" searchFile "${1-}") && shift || return $?

  # State file
  local tempDirectory repairSources=() item
  tempDirectory=$(__catchEnvironment "$usage" environmentValueRead "$stateFile" tempDirectory) || return $?
  mapFile=$(__catchEnvironment "$usage" environmentValueRead "$stateFile" mapFile) || return $?
  repairSources=() && while read -r item; do repairSources+=("$item"); done < <(__catchEnvironment "$usage" environmentValueReadArray "$stateFile" "repairSources") || return $?

  local quotedPrefix
  quotedPrefix="^[[:space:]]*$(quoteGrepPattern "$prefix")"

  __catchEnvironment "$usage" muzzle requireDirectory "$tempDirectory/$prefixIndex" || return $?

  local totalLines identicalLine badFiles=()

  totalLines=$(($(wc -l <"$searchFile") + 0))
  while read -r identicalLine; do
    local parsed tokenFile countFile lineNumber token count
    statusMessage decorate info "#$((prefixIndex + 1)): Processing $(decorate file "$searchFile"):$(decorate code "$identicalLine") ... "
    # DEBUG # decorate bold-red "$identicalLine" # DEBUG
    if ! parsed=$(__identicalLineParse "$searchFile" "$prefix" "$identicalLine"); then
      badFiles+=("$searchFile")
      continue
    fi
    IFS=' ' read -r lineNumber token count <<<"$(printf -- "%s\n" "$parsed")" || :
    if ! count=$(__identicalLineCount "$count" "$((totalLines - lineNumber))") && ! __throwEnvironment "$usage" "\"$identicalLine\" invalid count: $count"; then
      badFiles+=("$searchFile")
      continue
    fi

    local tokenFile="$tempDirectory/$prefixIndex/$token" countFile="$tempDirectory/$prefixIndex/$count@$token.match" isBadFile=false
    if [ -f "$tokenFile" ]; then
      local tokenLineCount tokenLineCount

      tokenLineCount=$(head -1 "$tokenFile")
      tokenFileName=$(tail -1 "$tokenFile")
      if [ ! -f "$countFile" ]; then
        statusMessage printf -- "%s: %s\n" "$(decorate info "$token")" "$(decorate error "Token counts do not match:")" 1>&2
        printf -- "    %s has %s specified\n" "$(decorate code "$(decorate file "$tokenFileName")")" "$(decorate success "$tokenLineCount")" 1>&2
        printf -- "    %s has %s specified\n" "$(decorate code "$(decorate file "$searchFile")")" "$(decorate error "$count")" 1>&2
        isBadFile=true
        touch "$countFile.compare" || :
        touch "$tempDirectory/$prefixIndex/$tokenLineCount@$token.match.compare" || :
      elif ! isUnsignedInteger "$count"; then
        __catchEnvironment "$usage" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "1" >"$countFile" || return $?
        badFiles+=("$searchFile")
        printf -- "%s\n" "$(decorate code "$searchFile:$lineNumber") - not integers: $(decorate value "$identicalLine")"
      else
        local compareFile="${countFile}.compare"
        # statusMessage decorate info "compareFile $compareFile"
        # Extract our section of the file. Matching is done, use line numbers and math to extract exact section
        # 10 lines in file, line 1 means: tail -n 10
        # 10 lines in file, line 9 means: tail -n 2
        # 10 lines in file, line 10 means: tail -n 1
        __catchEnvironment "$usage" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "$count" >"$compareFile" || return $?
        if [ "$(grep -c -e "$quotedPrefix" "$compareFile")" -gt 0 ]; then
          dumpPipe compareFile <"$compareFile"
          badFiles+=("$searchFile")
          {
            statusMessage --last printf -- "%s: %s\n< %s\n%s" "$(decorate info "$token")" "$(decorate warning "Identical sections overlap:")" "$(decorate success "$(decorate file "$searchFile")")" "$(decorate code)" || :
            grep -e "$quotedPrefix" "$compareFile" | wrapLines "$(decorate code)    " "$(decorate reset)" || :
            statusMessage --first decorate reset
          } 1>&2
        elif $mapFile; then
          _identicalMapAttributesFilter "$usage" "$searchFile" <"$countFile" >"$countFile.mapped" || return $?
          countFile="$countFile.mapped"
        fi
        if ! diff -b -q "$countFile" "$compareFile" >/dev/null; then
          statusMessage --last printf -- "%s%s: %s\n< %s\n> %s%s\n" "$(decorate info "$token")" "$(decorate error "Token code changed ($count): ($countFile)")" "$(decorate success "$(decorate file "$tokenFileName")")" "$(decorate warning "$(decorate file "$searchFile")")" "$(decorate code)" 1>&2
          diff "$countFile" "$compareFile" | wrapLines "$(decorate subtle "diff:") $(decorate code)" "$(decorate reset)" || : 1>&2
          isBadFile=true
        else
          statusMessage printf -- "%s %s in %s, lines %d-%d" "$(decorate success "Verified")" "$(decorate code "$token")" "$(decorate file "$searchFile")" "$lineNumber" "$((lineNumber + tokenLineCount))"
        fi
        if $mapFile; then
          rm -rf "$countFile" || return $?
        fi
      fi
      if $isBadFile; then
        if [ ${#repairSources[@]} -gt 0 ]; then
          # statusMessage --last decorate info repairSources "${#repairSources[@]}" "${repairSources[@]+"${repairSources[@]}"}"
          statusMessage --last decorate warning "Repairing $token in $(decorate code "$(decorate file "$searchFile")") from \"$(decorate value "$(decorate file "$tokenFileName")")\" (${#repairSources[@]} repair $(plural ${#repairSources[@]} directory directories))"
          if ! __identicalCheckRepair "$prefix" "$token" "$tokenFileName" "$searchFile" "${repairSources[@]}" 1>&2; then
            badFiles+=("$tokenFileName")
            badFiles+=("$searchFile")
            statusMessage --last decorate error "Unable to repair $(decorate value "$token") in $(decorate code "$searchFile")" 1>&2
          else
            isBadFile=false
            statusMessage decorate success "Repaired $(decorate value "$token") in $(decorate code "$searchFile")"
          fi
        else
          badFiles+=("$tokenFileName")
          badFiles+=("$searchFile")
        fi
      fi
    else
      printf -- "%s\n%d\n%s\n" "$count" "$lineNumber" "$searchFile" >"$tokenFile"
      __catchEnvironment "$usage" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "$count" >"$countFile" || return $?
      if [ "$token" = "" ]; then
        dumpPipe "token countFile $token $countFile" <"$countFile" 1>&2
      fi
      statusMessage decorate info "$(printf -- "Found %d %s for %s (in %s)" "$count" "$(plural "$count" line lines)" "$(decorate code "$token")" "$(decorate value "$(decorate file "$searchFile")")")"
    fi
  done < <(grep -n -e "$quotedPrefix" <"$searchFile" || :)
  [ ${#badFiles[@]} -eq 0 ] || environmentValueWriteArray "badFiles" "${badFiles[@]+"${badFiles[@]}"}" >>"$stateFile" || return $?
  [ ${#badFiles[@]} -eq 0 ]
}

# Usage: {fn}
__identicalCheckRepair() {
  local prefix="$1" token="$2" fileA="$3" fileB="$4"
  local checkPath

  fileA=$(realPath "$fileA") || _argument "realPath fileA $fileA" || return $?
  fileB=$(realPath "$fileB") || _argument "realPath fileB $fileB" || return $?
  shift 4 || _argument "Unable to shift 4 in ${FUNCNAME[0]}" || return $?
  while [ $# -gt 0 ]; do
    checkPath="$1"
    statusMessage decorate info "Checking path $checkPath ..."
    if [ "${fileA#"$checkPath"}" != "$fileA" ]; then
      statusMessage decorate info Repairing "$fileB" with "$fileA"
      identicalRepair --prefix "$prefix" --token "$token" "$fileA" "$fileB" || return $?
      return $?
    elif [ "${fileB#"$checkPath"}" != "$fileB" ]; then
      statusMessage decorate info Repairing "$fileA" with "$fileB"
      identicalRepair --prefix "$prefix" --token "$token" "$fileB" "$fileA" || return $?
      return $?
    fi
    shift
  done
  _environment "No repair found between $fileA and $fileB" || return $?
}

_identicalCheckSinglesChecker() {
  local usage="$1" stateFile && shift

  # Arguments
  stateFile=$(usageArgumentFile "$usage" stateFile "${1-}") && shift || return $?

  local tempDirectory singles=() item resultsFile identicalCode

  identicalCode=$(_code identical)
  # Fetch from state file
  tempDirectory=$(__catchEnvironment "$usage" environmentValueRead "$stateFile" tempDirectory) || return $?
  resultsFile=$(__catchEnvironment "$usage" environmentValueRead "$stateFile" resultsFile) || return $?
  while read -r item; do singles+=("$item"); done < <(__catchEnvironment "$usage" environmentValueReadArray "$stateFile" "singles") || return $?

  local tokenFile targetFile matchFile exitCode=0
  local allSingles=() knownSingles=() knownSinglesReport=() lonelySingles=() lonelySinglesReport=() lonelySinglesFiles=()

  while read -r matchFile; do
    if [ ! -f "$matchFile.compare" ]; then
      tokenFile="$(dirname "$matchFile")"
      token="$(basename "$matchFile")"
      token="${token%%.match}"
      token="${token#*@}"
      tokenFile="$tokenFile/$token"
      IFS=$'\n' read -d"" -r lineNumber targetFile < <(tail -n 2 "$tokenFile")
      allSingles+=("$token")
      if inArray "$token" "${singles[@]+"${singles[@]}"}"; then
        knownSingles+=("$token")
        knownSinglesReport+=("$(printf -- "%s in %s" "$(decorate code "$token")" "$(decorate info "$(decorate file "$targetFile")")"):$lineNumber")
      else
        lonelySingles+=("$token")
        lonelySinglesFiles+=("$targetFile")
        lonelySinglesReport+=("$(printf -- "%s in %s" "$(decorate code "$token")" "$(decorate notice "$(decorate file "$targetFile")")"):$lineNumber")
        exitCode="$identicalCode"
      fi
    fi
  done < <(find "$tempDirectory" -type f -name '*.match' || :)

  if [ "${#lonelySinglesReport[@]}" -gt 0 ]; then
    statusMessage --last printf -- "%s:\n%s" "$(decorate warning "Single $(plural ${#lonelySinglesReport[@]} token tokens)")" "$(printf -- "- %s\n" "${lonelySinglesReport[@]}")" >>"$resultsFile"
  elif [ "${#knownSinglesReport[@]}" -gt 0 ]; then
    statusMessage --last printf -- "%s:\n%s" "$(decorate notice "Single $(plural ${#knownSinglesReport[@]} token tokens) (known)")" "$(printf -- "- %s\n" "${knownSinglesReport[@]}")"
  fi
  if [ -n "$binary" ] && [ "${#lonelySinglesFiles[@]}" -gt 0 ]; then
    "$binary" "${lonelySinglesFiles[@]}"
  fi
  __catchEnvironment "$usage" environmentValueWriteArray "allSingles" "${allSingles[@]+"${allSingles[@]}"}" >>"$stateFile" || return $?
  __catchEnvironment "$usage" environmentValueWriteArray "knownSingles" "${knownSingles[@]+"${knownSingles[@]}"}" >>"$stateFile" || return $?
  __catchEnvironment "$usage" environmentValueWriteArray "lonelySingles" "${lonelySingles[@]+"${lonelySingles[@]}"}" >>"$stateFile" || return $?
  __catchEnvironment "$usage" environmentValueWriteArray "lonelySinglesFiles" "${lonelySinglesFiles[@]+"${lonelySinglesFiles[@]}"}" >>"$stateFile" || return $?

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
