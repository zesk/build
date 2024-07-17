#!/usr/bin/env bash
#
# Checking identical
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

# Usage: {fn} --extension extension0 --prefix prefix0  [ --cd directory ] [ --extension extension1 ... ] [ --prefix prefix1 ... ]
# Argument: --extension extension - Required. String. One or more extensions to search for in the current directory.
# Argument: --prefix prefix - Required. String. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
# Argument: --exclude pattern - Optional. String. One or more patterns of paths to exclude. Similar to pattern used in `find`.
# Argument: --cd directory - Optional. Directory. Change to this directory before running. Defaults to current directory.
# Argument: --repair directory - Optional. Directory. Any files in onr or more directories can be used to repair other files.
# Argument: --help - Optional. Flag. This help.
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
  local this argument usage me
  local rootDir findArgs prefixes exitCode tempDirectory resultsFile prefixIndex prefix
  local totalLines lineNumber token count parsed tokenFile countFile searchFile
  local identicalLine binary matchFile repairSource repairSources isBadFile
  local tokenLineCount tokenFileName compareFile badFiles singles foundSingles
  local excludes searchFileList debug extensionText
  local failureCode

  failureCode="$(_code identical)"
  this="${FUNCNAME[0]}"
  usage="_$this"
  me="$(basename "${BASH_SOURCE[0]}")"

  binary=
  rootDir=.
  singles=()
  findArgs=()
  badFiles=()
  prefixes=()
  excludes=()
  repairSources=()
  debug=false
  extensionText=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --help)
        "$usage" 0
        return 0
        ;;
      --debug)
        debug=true
        ;;
      --cd)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        rootDir=$1
        [ -d "$rootDir" ] || __failArgument "$usage" "--cd \"$1\" is not a directory" || return $?
        ;;
      --repair)
        shift
        repairSource=$(usageArgumentRealDirectory "$usage" "repairSource" "${1-}") || return $?
        repairSources+=("$repairSource")
        ;;
      --extension)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        findArgs+=("-name" "*.$1")
        extensionText="$extensionText .$1"
        ;;
      --exec)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        binary="$1"
        isCallable "$binary" || __failArgument "$usage" "$(consoleLabel "$argument") \"$(consoleValue "$binary")\" is not callable" || return $?
        ;;
      --single)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        singles+=("$1")
        ;;
      --prefix)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        prefixes+=("$1")
        ;;
      --exclude)
        shift || __failArgument "$usage" "missing $(consoleLabel "$argument") argument" || return $?
        [ -n "$1" ] || __failArgument "$usage" "Empty $(consoleCode "$argument") argument" || return $?
        excludes+=(! -path "$1")
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleCode "$argument")" || return $?
  done

  [ ${#findArgs[@]} -gt 0 ] || __failArgument "$usage" "Need to specify at least one --extension" || return $?
  [ ${#prefixes[@]} -gt 0 ] || __failArgument "$usage" "Need to specify at least one prefix (Try --prefix '# IDENTICAL')" || return $?

  tempDirectory="$(mktemp -d -t "$me.XXXXXXXX")" || __failEnvironment "$usage" "mktemp -d -t" || return $?
  resultsFile=$(mktemp) || __failEnvironment "$usage" mktemp || return $?
  rootDir=$(realPath "$rootDir") || __failEnvironment realPath "$rootDir" || return $?
  ! $debug || printf "COMMAND: %s\n" __identicalCheckGenerateSearchFiles "${repairSources[@]+"${repairSources[@]}"}" -- "$rootDir" "${findArgs[@]}" ! -path "*/.*" "${excludes[@]+${excludes[@]}}"
  searchFileList="$(__identicalCheckGenerateSearchFiles "${repairSources[@]+"${repairSources[@]}"}" -- "$rootDir" "${findArgs[@]}" ! -path "*/.*" "${excludes[@]+${excludes[@]}}")" || __failEnvironment "$usage" "Unable to generate file list" || return $?

  if [ ! -s "$searchFileList" ]; then
    __failEnvironment "$usage" "No files found in $rootDir with${extensionText}" || return $?
  fi
  ! $debug || dumpPipe "searchFileList" <"$searchFileList" || return $?
  prefixIndex=0
  for prefix in "${prefixes[@]}"; do
    while IFS= read -r searchFile; do
      if [ "$(basename "$searchFile")" = "$me" ]; then
        # We are exceptional ;)
        continue
      fi
      [ -d "$tempDirectory/$prefixIndex" ] || mkdir "$tempDirectory/$prefixIndex"
      totalLines=$(($(wc -l <"$searchFile") + 0))
      while read -r identicalLine; do
        statusMessage consoleInfo "#$((prefixIndex + 1)): Processing $searchFile:$(consoleCode "$identicalLine") ... "
        # DEBUG # consoleBoldRed "$identicalLine" # DEBUG
        if ! parsed=$(__identicalLineParse "$searchFile" "$prefix" "$identicalLine"); then
          badFiles+=("$searchFile")
          continue
        fi
        read -r lineNumber token count < <(printf "%s\n" "$parsed") || :
        if ! count=$(__identicalLineCount "$count" "$((totalLines - lineNumber))") && ! __failEnvironment "$usage" "\"$identicalLine\" invalid count: $count"; then
          badFiles+=("$searchFile")
          continue
        fi
        tokenFile="$tempDirectory/$prefixIndex/$token"
        countFile="$tempDirectory/$prefixIndex/$count@$token.match"
        isBadFile=false
        if [ -f "$tokenFile" ]; then
          tokenLineCount=$(head -1 "$tokenFile")
          tokenFileName=$(tail -1 "$tokenFile")
          if [ ! -f "$countFile" ]; then
            # __usageEnvironment "$usage" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "$count" >"$countFile" || return $?
            printf "%s%s: %s\n" "$(clearLine)" "$(consoleInfo "$token")" "$(consoleError "Token counts do not match:")" 1>&2
            printf "    %s has %s specified\n" "$(consoleCode "$tokenFileName")" "$(consoleSuccess "$tokenLineCount")" 1>&2
            printf "    %s has %s specified\n" "$(consoleCode "$searchFile")" "$(consoleError "$count")" 1>&2
            isBadFile=true
            touch "$countFile.compare" || :
            touch "$tempDirectory/$prefixIndex/$tokenLineCount@$token.match.compare" || :
          elif ! isUnsignedInteger "$count"; then
            __usageEnvironment "$usage" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "1" >"$countFile" || return $?
            badFiles+=("$searchFile")
            printf "%s\n" "$(consoleCode "$searchFile:$lineNumber") - not integers: $(consoleValue "$identicalLine")"
          else
            compareFile="${countFile}.compare"
            # Extract our section of the file. Matching is done, use line numbers and math to extract exact section
            # 10 lines in file, line 1 means: tail -n 10
            # 10 lines in file, line 9 means: tail -n 2
            # 10 lines in file, line 10 means: tail -n 1
            __usageEnvironment "$usage" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "$count" >"$compareFile" || return $?
            if [ "$(grep -c "$prefix" "$compareFile")" -gt 0 ]; then
              dumpPipe compareFile <"$compareFile"
              badFiles+=("$searchFile")
              {
                clearLine
                printf "%s: %s\n< %s\n%s" "$(consoleInfo "$token")" "$(consoleWarning "Identical sections overlap:")" "$(consoleSuccess "$searchFile")" "$(consoleCode)" || :
                grep "$prefix" "$compareFile" | wrapLines "$(consoleCode)    " "$(consoleReset)" || :
                consoleReset || :
              } 1>&2
            fi
            if ! diff -b -q "$countFile" "${countFile}.compare" >/dev/null; then
              printf "%s%s: %s\n< %s\n> %s%s\n" "$(clearLine)" "$(consoleInfo "$token")" "$(consoleError "Token code changed ($count):")" "$(consoleSuccess "$tokenFileName")" "$(consoleWarning "$searchFile")" "$(consoleCode)" 1>&2
              diff "$countFile" "${countFile}.compare" | wrapLines "$(consoleSubtle "diff:") $(consoleCode)" "$(consoleReset)" 1>&2
              isBadFile=true
            else
              statusMessage consoleSuccess "Verified $searchFile, lines $lineNumber-$((lineNumber + tokenLineCount))"
            fi
          fi
          if $isBadFile; then
            if [ ${#repairSources[@]} -gt 0 ]; then
              statusMessage consoleWarning "Repairing $token in $(consoleCode "$searchFile") from \"$(consoleValue "$tokenFileName")\""
              if ! __identicalCheckRepair "$prefix" "$token" "$tokenFileName" "$searchFile" "${repairSources[@]}"; then
                badFiles+=("$tokenFileName")
                badFiles+=("$searchFile")
                consoleError "$(clearLine)Unable to repair $(consoleValue "$token") in $(consoleCode "$searchFile")" 1>&2
              else
                isBadFile=false
                statusMessage consoleSuccess "Repaired $(consoleValue "$token") in $(consoleCode "$searchFile")"
              fi
            else
              badFiles+=("$tokenFileName")
              badFiles+=("$searchFile")
            fi
          fi
        else
          printf "%s\n%s\n" "$count" "$searchFile" >"$tokenFile"
          __usageEnvironment "$usage" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "$count" >"$countFile" || return $?
          statusMessage consoleInfo "$(printf "Found %d %s for %s (in %s)" "$count" "$(plural "$count" line lines)" "$(consoleCode "$token")" "$(consoleValue "$searchFile")")"
        fi
      done < <(grep -n "$prefix" <"$searchFile" || :)
    done <"$searchFileList"
    prefixIndex=$((prefixIndex + 1))
  done
  exitCode=0
  if [ ${#badFiles[@]} -gt 0 ]; then
    exitCode=$failureCode
    if [ -n "$binary" ]; then
      "$binary" "${badFiles[@]}"
    fi
  fi
  clearLine
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
        exitCode=$failureCode
      fi
    fi
  done < <(find "$tempDirectory" -type f -name '*.match' || :)
  for token in "${singles[@]+"${singles[@]}"}"; do
    if ! inArray "$token" "${foundSingles[@]+"${foundSingles[@]}"}"; then
      printf "%s: %s\n" "$(consoleWarning "Multiple instance of --single token found:")" "$(consoleError "$token")"
    fi
  done
  rm -rf "$tempDirectory" || :
  if [ $(($(wc -l <"$resultsFile") + 0)) -ne 0 ]; then
    exitCode=$failureCode
  fi
  cat "$resultsFile" 1>&2 || :
  rm -rf "$resultsFile" || :
  clearLine || :
  return "$exitCode"
}
_identicalCheck() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} repairSource ... -- findArgs ...
__identicalCheckGenerateSearchFiles() {
  local searchFileList orderedList ignorePatterns repairSources

  repairSources=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      break
    fi
    [ -n "$1" ] || _argument "Blank repairSource?" || return $?
    repairSources+=("${1%/}/")
    shift
  done
  searchFileList=$(mktemp) || _environment "mktemp" || return $?
  orderedList="$searchFileList.ordered"
  if ! find "$@" >"$searchFileList"; then
    rm -rf "$searchFileList" || :
    _environment "No files found" || return $?
  fi
  if [ ${#repairSources[@]} -gt 0 ]; then
    __environment touch "$orderedList" || return $?
    ignorePatterns=()
    for repairSource in "${repairSources[@]}"; do
      grep -e "$(quoteGrepPattern "$repairSource")" <"$searchFileList" >>"$orderedList"
      ignorePatterns+=(-e "$(quoteGrepPattern "$repairSource")")
    done
    grep -v "${ignorePatterns[@]}" <"$searchFileList" >>"$orderedList" || :
    rm -rf "$searchFileList"
    printf "%s\n" "$orderedList"
  else
    printf "%s\n" "$searchFileList"
  fi
}

# Usage: {fn} searchFile lineNumber totalLines count
# Generate the match file given the search file
__identicalCheckMatchFile() {
  local searchFile="$1" totalLines="$2" lineNumber="$3" count="$4"
  tail -n $((totalLines - lineNumber)) <"$searchFile" | head -n "$count"
}

#
# Identical check for shell files
#
# Usage: {fn} [ --repair repairSource ] [ --help ] [ --interactive ] [ --check checkDirectory ] ...
# Argument: --singles singlesFiles - Optional. File. One or more files which contain a list of allowed `IDENTICAL` singles, one per line.
# Argument: --single singleToken - Optional. String. One or more tokens which cam be singles.
# Argument: --repair directory - Optional. Directory. Any files in onr or more directories can be used to repair other files.
# Argument: --help - Flag. Optional. I need somebody.
# Argument: --interactive - Flag. Optional. Interactive mode on fixing errors.
# Argument: ... - Optional. Additional arguments are passed directly to `identicalCheck`.
identicalCheckShell() {
  local usage="_${FUNCNAME[0]}"
  local argument single singleFile aa

  export BUILD_HOME
  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_HOME || return $?

  aa=()
  singles=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --singles)
        shift
        singleFile=$(usageArgumentFile "$usage" singlesFile "${1-}") || return $?
        while read -r single; do
          single="${single#"${single%%[![:space:]]*}"}"
          single="${single%"${single##*[![:space:]]}"}"
          if [ "${single###}" = "${single}" ]; then
            aa+=(--single "$single")
          fi
        done <"$singleFile"
        ;;
      --interactive)
        aa+=("$argument")
        ;;
      --repair | --single | --exec | --prefix | --exclude | --extension)
        shift
        aa+=("$argument" "${1-}")
        ;;
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        break
        ;;
    esac
    shift || :
  done
  __usageEnvironment "$usage" identicalCheck "${aa[@]+"${aa[@]}"}" --prefix '# ''IDENTICAL' --extension sh "$@" || return $?
}
_identicalCheckShell() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
