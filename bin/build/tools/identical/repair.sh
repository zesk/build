#!/usr/bin/env bash
#
# Repairing identical
#
# Copyright &copy; 2024 Market Acumen, Inc.
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
  local argument arguments
  local source destination token stdout prefix
  local identicalLine grepPattern parsed
  local currentLineNumber count lineNumber targetFile sourceText totalLines isEOF

  # shellcheck disable=SC2059
  arguments="$(printf "\"$(consoleCode %s)\" " "$@")"
  source=
  destination=
  token=
  prefix=
  stdout=false
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --prefix)
        [ -z "$prefix" ] || __failArgument "$usage" "single $argument only:" "$arguments" || return $?
        shift
        prefix="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
        ;;
      --token)
        [ -z "$token" ] || __failArgument "$usage" "single $argument only:" "$arguments" || return $?
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
          __failArgument "$usage" "unknown argument: $(consoleValue "$argument")" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "missing argument $(consoleLabel "$argument")" || return $?
  done

  [ -n "$prefix" ] || __failArgument "$usage" "missing --prefix" || return $?
  [ -n "$token" ] || __failArgument "$usage" "missing --token" || return $?
  [ -n "$source" ] || __failArgument "$usage" "missing source" || return $?
  [ -n "$destination" ] || __failArgument "$usage" "missing destination" || return $?

  grepPattern="$(quoteGrepPattern "$prefix $token")"
  identicalLine="$(grep -m 1 -n -e "$grepPattern" <"$source")" || __failArgument "$usage" "\"$prefix $token\" not found in source $(consoleCode "$source")" || return $?
  [ $(($(grep -c -e "$grepPattern" <"$destination") + 0)) -gt 0 ] || __failArgument "$usage" "\"$prefix $token\" not found in destination $(consoleCode "$destination")" || return $?
  # totalLines is *source* lines
  totalLines="$(($(wc -l <"$source") + 0))"
  parsed=$(__identicalLineParse "$source" "$prefix" "$identicalLine") || __failArgument "$usage" "$source" return $?
  read -r lineNumber token count < <(printf "%s\n" "$parsed") || :
  count=$(__identicalLineCount "$count" "$((totalLines - lineNumber))") || __failEnvironment "$usage" "\"$identicalLine\" invalid count: $count" || return $?

  if ! isUnsignedInteger "$count"; then
    __failEnvironment "$usage" "$(consoleCode "$source") not an integer: \"$(consoleValue "$identicalLine")\"" || return $?
  fi
  sourceText=$(__usageEnvironment "$usage" mktemp) || return $?

  # Include header but map EOF to count on the first line
  __usageEnvironment "$usage" __identicalCheckMatchFile "$source" "$totalLines" "$((lineNumber - 1))" 1 | sed -e "s/[[:space:]]EOF\$/ $count/g" -e "s/[[:space:]]EOF[[:space:]]/ $count /g" >"$sourceText" || return $?
  __usageEnvironment "$usage" __identicalCheckMatchFile "$source" "$totalLines" "$lineNumber" "$count" >>"$sourceText" || return $?

  if ! $stdout; then
    targetFile=$(__usageEnvironment "$usage" mktemp) || return $?
    exec 3>"$targetFile"
  else
    exec 3>&1
  fi
  currentLineNumber=0
  # totalLines is *$destination* lines
  totalLines=$(wc -l <"$destination")
  while read -r identicalLine; do
    isEOF=false
    parsed=$(__usageArgument "$usage" __identicalLineParse "$destination" "$prefix" "$identicalLine") || return $?
    read -r lineNumber token count < <(printf "%s\n" "$parsed") || :
    if [ "$count" = "EOF" ]; then
      isEOF=true
    fi
    count=$(__identicalLineCount "$count" "$((totalLines - lineNumber))") || __failEnvironment "$usage" "\"$identicalLine\" invalid count: $count" || return $?
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
  if ! $stdout; then
    __usageEnvironment "$usage" cp -f "$targetFile" "$destination" || return $?
    rm -f "$targetFile" || :
  fi
}
_identicalRepair() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn}
__identicalCheckRepair() {
  local prefix="$1" token="$2" fileA="$3" fileB="$4"
  local checkPath

  statusMessage consoleInfo "realPath $fileA"
  fileA=$(realPath "$fileA") || _argument "realPath fileA $fileA" || return $?
  statusMessage consoleInfo "realPath $fileB"
  fileB=$(realPath "$fileB") || _argument "realPath fileB $fileB" || return $?
  statusMessage consoleInfo "Shifting ..."
  shift && shift && shift && shift
  while [ $# -gt 0 ]; do
    checkPath="$1"
    statusMessage consoleInfo "Checking path $checkPath ..."
    if [ "${fileA#"$checkPath"}" != "$fileA" ]; then
      statusMessage consoleInfo Repairing "$fileB" with "$fileA"
      identicalRepair --prefix "$prefix" --token "$token" "$fileA" "$fileB" || return $?
      return $?
    elif [ "${fileB#"$checkPath"}" != "$fileB" ]; then
      statusMessage consoleInfo Repairing "$fileA" with "$fileB"
      identicalRepair --prefix "$prefix" --token "$token" "$fileB" "$fileA" || return $?
      return $?
    fi
    shift
  done
  _environment "No repair found between $fileA and $fileB" || return $?
}
