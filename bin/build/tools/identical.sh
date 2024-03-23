#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# IDENTICAL errorArgument 1
errorArgument=2

errorFailures=100

# Usage: {fn} --extension extension0 --prefix prefix0  [ --cd directory ] [ --extension extension1 ... ] [ --prefix prefix1 ... ]
# Argument: --extension extension - Required. One or more extensions to search for in the current directory.
# Argument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
# Argument: --exclude pattern - Optional. One or more patterns of paths to exclude. Similar to pattern used in `find`.
# Argument: --cd directory - Optional. Change to this directory before running. Defaults to current directory.
# Argument: --help - Optional. This help.
#
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success, everything matches
# Exit Code: 100 - Failures
#
# When, for whatever reason, you need code to match between files, add a comment in the form:
#
#     # IDENTICAL tokenName n
#
# Where `tokenName` is unique to your project, `n` is the number of lines to match. All found sets of lines in this form
# must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout.
#
# The command to then check would be:
#
#     {fn} --extension sh --prefix '# IDENTICAL'
#
# This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet
# should remain identical.
#
# Failures are considered:
#
# - Partial success, but warnings occurred with an invalid number in a file
# - Two code instances with the same token were found which were not identical
# - Two code instances with the same token were found which have different line counts
#
# This is best used as a pre-commit check, for example. Wink.
#
identicalCheck() {
  local arg usage me
  local rootDir findArgs prefixes exitCode tempDirectory resultsFile prefixIndex prefix
  local totalLines lineNumber token count line0 line1 tokenFile countFile searchFile
  local tokenLineCount tokenFileName compareFile badFiles singles foundSingles
  local excludes
  usage="_${FUNCNAME[0]}"
  me="$(basename "${BASH_SOURCE[0]}")"

  binary=
  rootDir=.
  singles=()
  findArgs=()
  badFiles=()
  prefixes=()
  excludes=()
  while [ $# -gt 0 ]; do
    arg="$1"
    [ -n "$arg" ] || __usageArgument "$usage" "Blank argument" || return $?
    shift || __usageArgument "$usage" "Missing $arg" || return $?
    [ -n "$1" ] || __usageArgument "$usage" "Blank $arg" || return $?
    case "$arg" in
      --help)
        "$usage" 0
        return 0
        ;;
      --cd)
        rootDir=$1
        if [ ! -d "$rootDir" ]; then
          "$usage" "$errorArgument" "--cd \"$1\" is not a directory"
          return $?
        fi
        ;;
      --extension)
        findArgs+=("-name" "*.$1")
        ;;
      --exec)
        binary="$1"
        isCallable "$binary" || __usageArgument "$usage" "$arg \"$binary\" is not callable" || return $?
        ;;
      --single)
        singles+=("$1")
        ;;
      --prefix)
        prefixes+=("$1")
        ;;
      --exclude)
        shift || __failArgument "$usage" "No $arg argument" || return $?
        [ -n "$1" ] || __failArgument "$usage" "Empty $arg argument" || return $?
        excludes+=(! -path "$1")
        ;;
    esac
    shift || __usageArgument "$usage" "shift failed" || return $?
  done

  if [ ${#findArgs[@]} -eq 0 ]; then
    "$usage" "$errorArgument" "--extension not specified" $errorArgument "Need to specify at least one extension"
    return $?
  fi
  if [ ${#prefixes[@]} -eq 0 ]; then
    "$usage" "$errorArgument" "--extension not specified" $errorArgument "Need to specify at least one prefix (Try --prefix '# IDENTICAL')"
    return $?
  fi

  tempDirectory="$(mktemp -d -t "$me.XXXXXXXX")"
  resultsFile=$(mktemp)
  while IFS= read -r searchFile; do
    if [ "$(basename "$searchFile")" = "$me" ]; then
      # We are exceptional ;)
      continue
    fi
    prefixIndex=0
    for prefix in "${prefixes[@]}"; do
      [ -d "$tempDirectory/$prefixIndex" ] || mkdir "$tempDirectory/$prefixIndex"
      totalLines=$(wc -l <"$searchFile")
      while read -r identicalLine; do
        # DEBUG # consoleBoldRed "$identicalLine" # DEBUG
        lineNumber=${identicalLine%%:*}
        lineNumber=$((lineNumber + 1))
        identicalLine=${identicalLine#*:}
        identicalLine="$(trimSpace "${identicalLine##*"$prefix"}")"
        token=${identicalLine%% *}
        count=${identicalLine#* }
        line0=${count% [0-9]*}
        line1=${count#[0-9]* }
        tokenFile="$tempDirectory/$prefixIndex/$token"
        if ! isInteger "$line0" || ! isInteger "$line1"; then
          printf "%s\n%s\n" "$count" "$searchFile" >"$tokenFile"
          clearLine 1>&2
          printf "%s %s in %s\n" "$(consoleWarning -n "Count is not a number")" "$(consoleCode "$count")" "$(consoleError "$searchFile")" 1>&2
          badFiles+=("$searchFile")
          continue
        fi
        if [ "$line0" != "$count" ] || [ "$line1" != "$count" ]; then
          if [ "$line0" -ge "$line1" ]; then
            printf "%s in %s\n\n > %s\n" "$(consoleWarning -n "Count range is out of order")" "$(consoleError "$searchFile")" "$(consoleCode "$identicalLine")" 1>&2
            badFiles+=("$searchFile")
            continue
          fi
          count=$((line1 - line0))
        fi
        countFile="$tempDirectory/$prefixIndex/$count@$token.match"
        if [ -f "$tokenFile" ]; then
          tokenLineCount=$(head -1 "$tokenFile")
          tokenFileName=$(tail -1 "$tokenFile")
          if [ ! -f "$countFile" ]; then
            badFiles+=("$tokenFileName")
            badFiles+=("$searchFile")
            clearLine 1>&2
            printf "%s: %s\n" "$(consoleInfo "$token")" "$(consoleError -n "Token counts do not match:")" 1>&2
            printf "    %s has %s specified\n" "$(consoleCode -n "$tokenFileName")" "$(consoleSuccess -n "$tokenLineCount")" 1>&2
            printf "    %s has %s specified\n" "$(consoleCode -n "$searchFile")" "$(consoleError -n "$count")" 1>&2
          else
            compareFile="${countFile}.compare"
            # Extract our section of the file. Matching is done, use line numbers and math to extract exact section
            # 10 lines in file, line 1 means: tail -n 10
            # 10 lines in file, line 9 means: tail -n 2
            # 10 lines in file, line 10 means: tail -n 1
            tail -n $((totalLines - lineNumber + 1)) "$searchFile" | head -n "$count" >"$compareFile"
            if [ "$(grep -c "$prefix" "$compareFile")" -gt 0 ]; then
              badFiles+=("$searchFile")
              clearLine 1>&2
              printf "%s: %s\n< %s%s\n" "$(consoleInfo "$token")" "$(consoleError -n "Identical sections overlap:")" "$(consoleSuccess "$searchFile")" "$(consoleCode)" 1>&2
              wrapLines "$(consoleCode)    " "$(consoleReset)" <"$compareFile" 1>&2
              consoleReset 1>&2
              break
            elif ! diff -b -q "$countFile" "${countFile}.compare" >/dev/null; then
              badFiles+=("$tokenFileName")
              badFiles+=("$searchFile")
              clearLine 1>&2
              printf "%s: %s\n< %s\n> %s%s\n" "$(consoleInfo "$token")" "$(consoleError -n "Token code changed ($count):")" "$(consoleSuccess "$tokenFileName")" "$(consoleWarning "$searchFile")" "$(consoleCode)" 1>&2
              diff "$countFile" "${countFile}.compare" | wrapLines "$(consoleSubtle "diff:") $(consoleCode)" "$(consoleReset)" 1>&2
              break
            else
              statusMessage consoleSuccess "Verified $searchFile, lines $lineNumber-$((lineNumber + tokenLineCount))"
            fi
          fi
        else
          printf "%s\n%s\n" "$count" "$searchFile" >"$tokenFile"
          tail -n $((totalLines - lineNumber + 1)) "$searchFile" | head -n "$count" >"$countFile"
          statusMessage consoleInfo "$(printf "Found %d %s for %s (in %s)" "$count" "$(plural "$count" line lines)" "$(consoleCode "$token")" "$(consoleValue "$searchFile")")"
        fi
      done < <(grep -n "$prefix" "$searchFile") || :
      prefixIndex=$((prefixIndex + 1))
    done
  done < <(find "$rootDir" "${findArgs[@]}" ! -path "*/.*" "${excludes[@]+${excludes[@]}}" | sort) 2>"$resultsFile"

  if [ -n "$binary" ] && [ ${#badFiles[@]} -gt 0 ]; then
    "$binary" "${badFiles[@]}"
  fi
  clearLine
  exitCode=0
  foundSingles=()
  while read -r matchFile; do
    if [ ! -f "$matchFile.compare" ]; then
      tokenFile="$(dirname "$matchFile")"
      token="$(basename "$matchFile")"
      token="${token%%.match}"
      token="${token#*@}"
      tokenFile="$tokenFile/$token"
      tokenFile="$(tail -n 1 "$tokenFile")"
      if inArray "$token" "${singles[@]+"${singles[@]}"}"; then
        printf "%s: %s in %s\n" "$(consoleSuccess "Single instance of token ok:")" "$(consoleCode "$token")" "$(consoleInfo "$tokenFile")"
        foundSingles+=("$token")
      else
        printf "%s: %s in %s\n" "$(consoleWarning "Single instance of token found:")" "$(consoleError "$token")" "$(consoleInfo "$tokenFile")" >>"$resultsFile"
        if [ -n "$binary" ]; then
          "$binary" "$tokenFile"
        fi
        exitCode=$errorFailures
      fi
    fi
  done < <(find "$tempDirectory" -type f -name '*.match')
  for token in "${singles[@]+"${singles[@]}"}"; do
    if ! inArray "$token" "${foundSingles[@]+"${foundSingles[@]}"}"; then
      printf "%s: %s in %s\n" "$(consoleWarning "Single instance of token NOT found:")" "$(consoleError "$token")" "$(consoleInfo "$tokenFile")"
    fi
  done
  # DEBUG # echo "tempDirectory: $tempDirectory STOPPING"
  # return 99 # DEBUG
  rm -rf "$tempDirectory"
  if [ "$(wc -l <"$resultsFile")" -ne 0 ]; then
    exitCode=$errorFailures
  fi
  cat "$resultsFile" 1>&2
  rm "$resultsFile"
  clearLine
  return "$exitCode"
}
_identicalCheck() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  return $?
}
