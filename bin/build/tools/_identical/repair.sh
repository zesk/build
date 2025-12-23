#!/usr/bin/env bash
#
# Repairing identical
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__identicalRepair() {
  local handler="$1" && shift
  local arguments

  # shellcheck disable=SC2059
  arguments="$(printf "\"$(decorate code %s)\" " "$@")"

  local source="" destination="" token="" prefix="" stdout=false fileMap=true

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
    --no-map)
      fileMap=false
      ;;
    --prefix)
      [ -z "$prefix" ] || throwArgument "$handler" "single $argument only:" "$arguments" || return $?
      shift
      prefix="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --token)
      [ -z "$token" ] || throwArgument "$handler" "single $argument only:" "$arguments" || return $?
      shift
      token="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      ;;
    --stdout)
      stdout=true
      ;;
    *)
      if [ -z "$source" ]; then
        source=$(usageArgumentFile "$handler" "source" "$argument") || return $?
      elif [ -z "$destination" ]; then
        destination=$(usageArgumentFile "$handler" "destination" "$argument") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$prefix" ] || throwArgument "$handler" "missing --prefix" || return $?
  [ -n "$token" ] || throwArgument "$handler" "missing --token" || return $?
  [ -n "$source" ] || throwArgument "$handler" "missing source" || return $?
  [ -n "$destination" ] || throwArgument "$handler" "missing destination" || return $?

  local grepPattern identicalLine totalLines parsed count
  local lineNumber token count

  grepPattern="^[[:space:]]*$(quoteGrepPattern "$prefix $token")"
  identicalLine="$(grep -m 1 -n -e "$grepPattern" <"$source")" || throwArgument "$handler" "\"$prefix $token\" not found in source $(decorate code "$source")" || return $?
  [ $(($(grep -c -e "$grepPattern" <"$destination") + 0)) -gt 0 ] || throwArgument "$handler" "\"$prefix $token\" not found in destination $(decorate code "$destination")" || return $?
  # totalLines is *source* lines
  totalLines=$(catchReturn "$handler" fileLineCount <"$source") || return $?
  parsed=$(__identicalLineParse "$handler" "$source" "$prefix" "$identicalLine") || return $?
  IFS=" " read -r lineNumber token count < <(printf -- "%s\n" "$parsed") || :
  count=$(__identicalLineCount "$count" "$((totalLines - lineNumber))") || throwEnvironment "$handler" "\"$identicalLine\" invalid count: $count" || return $?

  if ! isUnsignedInteger "$count"; then
    throwEnvironment "$handler" "$(decorate code "$source") not an integer: \"$(decorate value "$identicalLine")\"" || return $?
  fi

  local sourceText clean=()
  sourceText=$(fileTemporaryName "$handler") || return $?
  clean+=("$sourceText")

  # Include header but map EOF to count on the first line
  catchReturn "$handler" __identicalCheckMatchFile "$source" "$totalLines" "$((lineNumber - 1))" 1 | sed -e "s/[[:space:]]EOF\$/ $count/g" -e "s/[[:space:]]EOF[[:space:]]/ $count /g" >"$sourceText" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" __identicalCheckMatchFile "$source" "$totalLines" "$lineNumber" "$count" >>"$sourceText" || returnClean $? "${clean[@]}" || return $?
  if $fileMap; then
    _identicalMapAttributesFile "$handler" "$sourceText" "$destination" || returnClean $? "${clean[@]}" || return $?
  fi
  if ! $stdout; then
    local targetFile
    targetFile=$(fileTemporaryName "$handler") || returnClean $? "${clean[@]}" || return $?
    clean+=("$targetFile")
    exec 3>"$targetFile"
  else
    exec 3>&1
  fi
  local currentLineNumber=0

  # totalLines is *$destination* lines
  totalLines=$(catchReturn "$handler" fileLineCount --newline "$destination") || returnClean $? "${clean[@]}" || return $?
  local finished=false
  while ! $finished; do
    read -r identicalLine || finished=true
    [ -n "$identicalLine" ] || continue
    local isEOF=false
    parsed=$(__identicalLineParse "$handler" "$destination" "$prefix" "$identicalLine") || ! exec 3>&- || returnClean $? "${clean[@]}" || return $?
    IFS=" " read -r lineNumber token count < <(printf -- "%s\n" "$parsed") || :
    if [ "$count" = "EOF" ]; then
      isEOF=true
    fi
    count=$(__identicalLineCount "$count" "$((totalLines - lineNumber))") || throwEnvironment "$handler" "\"$identicalLine\" invalid count: $count" || ! exec 3>&- || returnClean $? "${clean[@]}" || return $?
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

  if [ "$currentLineNumber" -le "$totalLines" ] && ! $isEOF; then
    tail -n $((totalLines - currentLineNumber + 1)) <"$destination" >&3
  fi
  exec 3>&-
  if ! $stdout; then
    catchEnvironment "$handler" cp -f "$targetFile" "$destination" || returnClean $? "${clean[@]}" || return $?
  fi
  returnClean 0 "${clean[@]}" || return $?
}
