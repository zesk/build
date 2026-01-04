#!/usr/bin/env bash
#
# Line handler inside loop
#
# Copyright &copy; 2026 Market Acumen, Inc.

# Return Code: 1 - stderr - ERRORS
# Return Code: 0 - stderr - console output, stdout -> tokenFileName
__identicalCheckInsideLoopLineHandler() {
  local handler="$1" && shift
  local prefix="$1" && shift
  local mapFile="$1" && shift
  local searchFile="$1" && shift
  local totalLines="$1" && shift
  local lineNumber="$1" && shift
  local identicalLine="$1" && shift
  local token="$1" && shift
  local count="$1" && shift
  local tokenDirectory="$1" && shift

  local tokenFile="$tokenDirectory/$token"
  local countFile="$tokenDirectory/$count@$token.match"
  local isBadFile=false

  if [ ! -f "$tokenFile" ]; then
    printf -- "%s\n%d\n%s\n" "$count" "$lineNumber" "$searchFile" >"$tokenFile"
    catchReturn "$handler" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "$count" >"$countFile" || return $?
    if [ "$token" = "" ]; then
      dumpPipe "token countFile $token $countFile" <"$countFile" 1>&2
    fi
    statusMessage decorate info "$(printf -- "Found %s for %s (in %s)" "$(pluralWord "$count" line)" "$(decorate code "$token")" "$(decorate file "$searchFile")")" 1>&2
    return 0
  fi

  local tokenLineCount tokenLineCount

  tokenLineCount=$(head -n 1 "$tokenFile")
  tokenFileName=$(tail -n 1 "$tokenFile")
  [ "$tokenFileName" != "$searchFile" ] || mapFile=false

  if [ ! -f "$countFile" ]; then
    {
      statusMessage --last printf -- "%s: %s\n" "$(decorate info "$token")" "$(decorate error "Token counts do not match:")"
      printf -- "    [%s] specified in %s\n" "$(decorate success " $tokenLineCount ")" "$(decorate file "$tokenFileName")"
      printf -- "    [%s] specified in %s\n" "$(decorate error " $count ")" "$(decorate file "$searchFile")"
    } 1>&2
    isBadFile=true
    touch "$countFile.compare" || :
    touch "$tokenDirectory/$tokenLineCount@$token.match.compare" || :
  elif ! isUnsignedInteger "$count"; then
    catchReturn "$handler" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "1" >"$countFile" || return $?
    badFiles+=("$searchFile")
    printf -- "%s\n" "$(decorate code "$searchFile:$lineNumber") - not integers: $(decorate value "$identicalLine")"
  else
    local compareFile="${countFile}.compare"
    # Extract our section of the file. Matching is done, use line numbers and math to extract exact section
    # 10 lines in file, line 1 means: tail -n 10
    # 10 lines in file, line 9 means: tail -n 2
    # 10 lines in file, line 10 means: tail -n 1
    catchReturn "$handler" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "$count" >"$compareFile" || return $?
    if [ "$(identicalFindTokens --prefix "$prefix" "$compareFile" | fileLineCount)" != "0" ]; then
      dumpPipe compareFile <"$compareFile" 1>&2
      badFiles+=("$searchFile")
      {
        statusMessage --last printf -- "%s: %s\n< %s\n" "$(decorate info "$token")" "$(decorate warning "Identical sections overlap:")" "$(decorate success "$(decorate file "$searchFile")")"
        identicalFindTokens --prefix "$prefix" "$compareFile" | decorate code | decorate wrap "    "
        statusMessage --first decorate reset
      } 1>&2
      isBadFile=true
    elif $mapFile; then
      _identicalMapAttributesFilter "$handler" "$searchFile" <"$countFile" >"$countFile.mapped" || return $?
      countFile="$countFile.mapped"
    fi
    if ! diff -b -q "$countFile" "$compareFile" >/dev/null; then
      {
        statusMessage --last printf -- "[%s] %s\n< %s\n> %s%s\n" "$(decorate code "$token")" "$(decorate error "Token code changed ($count)")" "$(decorate success "$(decorate file "$tokenFileName")")" "$(decorate warning "$(decorate file "$searchFile")")"
        diff -b "$countFile" "$compareFile" | decorate code | decorate wrap "$(decorate subtle "diff: ")" || :
        if buildDebugEnabled identical-compare; then
          decorate wrap "<: " <"$countFile"
          decorate wrap ">: " <"$compareFile"
        fi
      } 1>&2
      isBadFile=true
    else
      statusMessage printf -- "%s %s in %s, lines %d-%d" "$(decorate success "Verified")" "$(decorate code "$token")" "$(decorate file "$searchFile")" "$lineNumber" "$((lineNumber + tokenLineCount))" 1>&2
    fi
    if $mapFile; then
      rm -rf "$countFile" || return $?
    fi
  fi
  if $isBadFile; then
    printf "%s\n" "$tokenFileName"
    return 0
  fi
}
