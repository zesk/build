#!/usr/bin/env bash
#
# Line handler inside loop
#
# Copyright &copy; 2025 Market Acumen, Inc.

# Usage: {fn} handler stateFile prefixIndex prefix searchFile
# Argument: stateFile - File. Required. State file containing our variables.
# Argument: prefixIndex - UnsignedInteger. Required. Which prefix index we are processing.
# Argument: prefix - String. Required. Prefix we are are processing.
# Argument: searchFile - File. String. File we are searching
_identicalCheckInsideLoop() {
  local handler="$1" && shift

  local stateFile prefixIndex prefix searchFile

  # Arguments
  stateFile=$(usageArgumentFile "$handler" stateFile "${1-}") && shift || return $?
  prefixIndex=$(usageArgumentInteger "$handler" prefixIndex "${1-}") && shift || return $?
  prefix=$(usageArgumentString "$handler" prefix "${1-}") && shift || return $?
  searchFile=$(usageArgumentFile "$handler" searchFile "${1-}") && shift || return $?

  # State file
  local foundLines
  foundLines=$(fileTemporaryName "$handler") || return $?
  local clean=("$foundLines")
  # statusMessage --last decorate each code __identicalFindPrefixes "$handler" "$prefix" "<" "$searchFile"
  if ! __identicalFindPrefixes "$handler" "$prefix" <"$searchFile" >"$foundLines"; then
    __catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
    return 0
  fi

  local tempDirectory repairSources=() item tokens=()
  tempDirectory=$(__catch "$handler" environmentValueRead "$stateFile" tempDirectory) || returnClean $? "${clean[@]}" || return $?
  mapFile=$(__catch "$handler" environmentValueRead "$stateFile" mapFile) || returnClean $? "${clean[@]}" || return $?
  repairSources=() && while read -r item; do repairSources+=("$item"); done < <(__catch "$handler" environmentValueReadArray "$stateFile" "repairSources") || returnClean $? "${clean[@]}" || return $?
  tokens=() && while read -r item; do tokens+=("$item"); done < <(__catch "$handler" environmentValueReadArray "$stateFile" "tokens") || returnClean $? "${clean[@]}" || return $?

  __catchEnvironment "$handler" muzzle directoryRequire "$tempDirectory/$prefixIndex" || returnClean $? "${clean[@]}" || return $?

  local totalLines

  totalLines=$(($(__catch "$handler" fileLineCount "$searchFile") + 0)) || returnClean $? "${clean[@]}" || return $?

  statusMessage decorate info "#$((prefixIndex + 1)): Looking for \"$(decorate code "$prefix")\" Reading $(decorate file "$searchFile")"

  local identicalLine badFiles=()
  while read -r identicalLine; do
    local parsed lineNumber token count errorFile

    statusMessage decorate info "#$((prefixIndex + 1)): Processing $(decorate file "$searchFile"):$(decorate code "$identicalLine") ... "
    if ! parsed=$(__identicalLineParse "$handler" "$searchFile" "$prefix" "$identicalLine"); then
      continue
    fi
    IFS=' ' read -r lineNumber token count <<<"$(printf -- "%s\n" "$parsed")" || :
    [ ${#tokens[@]} -eq 0 ] || inArray "$token" "${tokens[@]}" || continue
    if ! count=$(__identicalLineCount "$count" "$((totalLines - lineNumber))") && ! __throwEnvironment "$handler" "\"$identicalLine\" invalid count: $count"; then
      continue
    fi
    errorFile="$tempDirectory/$prefixIndex/errors"
    clean+=("$errorFile")
    local tokenFileName
    tokenFileName=$(__identicalCheckInsideLoopLineHandler "$handler" "$prefix" "$mapFile" "$searchFile" "$totalLines" "$lineNumber" "$identicalLine" "$token" "$count" "$tempDirectory/$prefixIndex" 2>"$errorFile") || returnUndo $? cat "$errorFile" 1>&2 || returnClean $? "${clean[@]}" || return $?
    if [ -n "$tokenFileName" ]; then
      # Bad file
      if [ ${#repairSources[@]} -gt 0 ]; then
        statusMessage --last decorate warning "Repairing $token in $(decorate code "$(decorate file "$searchFile")") from \"$(decorate value "$(decorate file "$tokenFileName")")\" (${#repairSources[@]} repair $(plural ${#repairSources[@]} directory directories))"
        # statusMessage --last decorate each quote __identicalCheckRepair "$handler" "$prefix" "$token" "$tokenFileName" "$searchFile" "${repairSources[@]}"
        if ! __identicalCheckRepair "$handler" "$prefix" "$token" "$tokenFileName" "$searchFile" "${repairSources[@]}"; then
          badFiles+=("$tokenFileName")
          badFiles+=("$searchFile")
          {
            __catchEnvironment "$handler" cat "$errorFile" || returnClean $? "${clean[@]}" || return $?
            statusMessage --last decorate error "Unable to repair $(decorate value "$token") in $(decorate code "$searchFile")"
          } 1>&2
        else
          __catchEnvironment "$handler" cat "$errorFile" || returnClean $? "${clean[@]}" || return $?
          statusMessage decorate success "Repaired $(decorate value "$token") in $(decorate code "$searchFile")"
        fi
      else
        statusMessage decorate error "Added bad file $(decorate file "$tokenFileName") in $(decorate file "$searchFile")"
        badFiles+=("$tokenFileName")
        badFiles+=("$searchFile")
        __catchEnvironment "$handler" cat "$errorFile" 1>&2 || returnClean $? "${clean[@]}" || return $?
      fi
    else
      __catchEnvironment "$handler" cat "$errorFile" || returnClean $? "${clean[@]}" || return $?
    fi
  done <"$foundLines"
  __catchEnvironment "$handler" rm -f "${clean[@]}" || return $?

  [ ${#badFiles[@]} -eq 0 ] || environmentValueWriteArray "badFiles" "${badFiles[@]+"${badFiles[@]}"}" >>"$stateFile" || return $?
  [ ${#badFiles[@]} -eq 0 ]
}
