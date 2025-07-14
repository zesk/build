#!/usr/bin/env bash
#
# Repairing identical
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# Usage: {fn} token source destination
# Repair an identical `token` in `destination` from `source`
# Argument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. `# IDENICAL`) (may specify more than one)
# Argument: token - String. Required. The token to repair.
# Argument: source - Required. File. The token file source. First occurrence is used.
# Argument: destination - Required. File. The token file to repair. Can be same as `source`.
# Argument: --stdout - Optional. Flag. Output changed file to `stdout`
identicalRepair() {
  local usage="_${FUNCNAME[0]}"

  # shellcheck disable=SC2059
  arguments="$(printf "\"$(decorate code %s)\" " "$@")"

  local source="" destination="" token="" prefix="" stdout=false fileMap=true
  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --no-map)
      fileMap=false
      ;;
    --prefix)
      [ -z "$prefix" ] || __throwArgument "$usage" "single $argument only:" "$arguments" || return $?
      shift
      prefix="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
      ;;
    --token)
      [ -z "$token" ] || __throwArgument "$usage" "single $argument only:" "$arguments" || return $?
      shift
      token="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
      ;;
    --stdout)
      stdout=true
      ;;
    *)
      if [ -z "$source" ]; then
        source=$(usageArgumentFile "$usage" "source" "$argument") || return $?
      elif [ -z "$destination" ]; then
        destination=$(usageArgumentFile "$usage" "destination" "$argument") || return $?
      else
        __throwArgument "$usage" "unknown argument: $(decorate value "$argument")" || return $?
      fi
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$prefix" ] || __throwArgument "$usage" "missing --prefix" || return $?
  [ -n "$token" ] || __throwArgument "$usage" "missing --token" || return $?
  [ -n "$source" ] || __throwArgument "$usage" "missing source" || return $?
  [ -n "$destination" ] || __throwArgument "$usage" "missing destination" || return $?

  local grepPattern identicalLine totalLines parsed count
  local lineNumber token count

  grepPattern="^[[:space:]]*$(quoteGrepPattern "$prefix $token")"
  identicalLine="$(grep -m 1 -n -e "$grepPattern" <"$source")" || __throwArgument "$usage" "\"$prefix $token\" not found in source $(decorate code "$source")" || return $?
  [ $(($(grep -c -e "$grepPattern" <"$destination") + 0)) -gt 0 ] || __throwArgument "$usage" "\"$prefix $token\" not found in destination $(decorate code "$destination")" || return $?
  # totalLines is *source* lines
  totalLines=$(__catchEnvironment "$usage" fileLineCount <"$source") || return $?
  parsed=$(__identicalLineParse "$source" "$prefix" "$identicalLine") || __throwArgument "$usage" "$source" return $?
  IFS=" " read -r lineNumber token count < <(printf -- "%s\n" "$parsed") || :
  count=$(__identicalLineCount "$count" "$((totalLines - lineNumber))") || __throwEnvironment "$usage" "\"$identicalLine\" invalid count: $count" || return $?

  if ! isUnsignedInteger "$count"; then
    __throwEnvironment "$usage" "$(decorate code "$source") not an integer: \"$(decorate value "$identicalLine")\"" || return $?
  fi

  local sourceText
  sourceText=$(fileTemporaryName "$usage") || return $?

  # Include header but map EOF to count on the first line
  __catchEnvironment "$usage" __identicalCheckMatchFile "$source" "$totalLines" "$((lineNumber - 1))" 1 | sed -e "s/[[:space:]]EOF\$/ $count/g" -e "s/[[:space:]]EOF[[:space:]]/ $count /g" >"$sourceText" || return $?
  __catchEnvironment "$usage" __identicalCheckMatchFile "$source" "$totalLines" "$lineNumber" "$count" >>"$sourceText" || return $?
  if $fileMap; then
    _identicalMapAttributesFile "$usage" "$sourceText" "$destination" || return $?
  fi
  if ! $stdout; then
    local targetFile
    targetFile=$(fileTemporaryName "$usage") || return $?
    exec 3>"$targetFile"
  else
    exec 3>&1
  fi
  local currentLineNumber=0 undo=("exec" "3>&-" --)

  # totalLines is *$destination* lines
  totalLines=$(__catchEnvironment "$usage" fileLineCount "$destination") || return $?
  while read -r identicalLine; do
    local isEOF=false
    parsed=$(__catchArgument "$usage" __identicalLineParse "$destination" "$prefix" "$identicalLine") || returnUndo $? "${undo[@]}" || return $?
    IFS=" " read -r lineNumber token count < <(printf -- "%s\n" "$parsed") || :
    if [ "$count" = "EOF" ]; then
      isEOF=true
    fi
    count=$(__identicalLineCount "$count" "$((totalLines - lineNumber))") || __throwEnvironment "$usage" "\"$identicalLine\" invalid count: $count" || returnUndo $? "${undo[@]}" || return $?
    if [ "$lineNumber" -gt 1 ]; then
      if [ "$currentLineNumber" -eq 0 ]; then
        head -n $((lineNumber - 1)) <"$destination" >&3
      else
        head -n $((lineNumber - 1)) <"$destination" | tail -n $((lineNumber - currentLineNumber)) >&3
      fi
    fi
    currentLineNumber=$((lineNumber + count + 1))
    cat "$sourceText" >&3
    if $isEOF; then
      currentLineNumber=$totalLines
      break
    fi
  done < <(grep -n -e "$grepPattern" <"$destination" || :)

  if [ "$currentLineNumber" -lt "$totalLines" ]; then
    tail -n $((totalLines - currentLineNumber + 1)) <"$destination" >&3
  fi
  exec 3>&-
  if ! $stdout; then
    __catchEnvironment "$usage" cp -f "$targetFile" "$destination" || return $?
    rm -f "$targetFile" || :
  fi
}
_identicalRepair() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
