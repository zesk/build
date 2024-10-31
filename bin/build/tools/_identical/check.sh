#!/usr/bin/env bash
#
# Checking identical
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# In case you forgot, the directory in which this file is named `_identical` and *NOT* `identical`.
#
# This is to avoid having this match when doing `identicalRepair` - causes issues.
#
# Thanks for your consideration.

# Usage: {fn} --extension extension0 --prefix prefix0  [ --cd directory ] [ --extension extension1 ... ] [ --prefix prefix1 ... ]
# Argument: --extension extension - Required. String. One or more extensions to search for in the current directory.
# Argument: --prefix prefix - Required. String. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
# Argument: --exclude pattern - Optional. String. One or more patterns of paths to exclude. Similar to pattern used in `find`.
# Argument: --cd directory - Optional. Directory. Change to this directory before running. Defaults to current directory.
# Argument: --repair directory - Optional. Directory. Any files in onr or more directories can be used to repair other files.
# Argument: --ignore-singles - Optional. Flag. Skip the check to see if single entries exist.
# Argument: --no-map - Optional. Flag. Do not map __BASE__, __FILE__, __DIR__ tokens.
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
# Mapping also automatically handles file names and paths, so `__FILE__` maps to path to a file relative to the project root.
#
# Failures are considered:
#
# - Partial success, but warnings occurred with an invalid number in a file
# - Two code instances with the same token were found which were not identical
# - Two code instances with the same token were found which have different line counts
#
# This is best used as a pre-commit check, for example. Wink!
identicalCheck() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local usage me
  local rootDir findArgs prefixes exitCode tempDirectory resultsFile prefixIndex prefix quotedPrefix
  local totalLines lineNumber token count parsed tokenFile countFile searchFile
  local identicalLine binary matchFile repairSources isBadFile
  local tokenLineCount tokenFileName compareFile badFiles singles foundSingles
  local excludes searchFileList debug extensionText
  local failureCode mapFile ignoreSingles

  failureCode="$(_code identical)"
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
  mapFile=true
  ignoreSingles=false

  saved=("$@")
  nArguments=$#

  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --no-map)
        mapFile=false
        ;;
      --debug)
        debug=true
        ;;
      --cd)
        shift
        rootDir=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $?
        ;;
      --repair)
        shift
        repairSources+=("$(usageArgumentRealDirectory "$usage" "repairSource" "${1-}")") || return $?
        ;;
      --extension)
        shift
        findArgs+=("-name" "*.$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        extensionText="$extensionText .$1"
        ;;
      --exec)
        shift
        binary=$(usageArgumentCallable "$usage" "$argument" "$1") || return $?
        ;;
      --single)
        shift
        singles+=("$1")
        ;;
      --prefix)
        shift
        prefixes+=("$1")
        ;;
      --ignore-singles)
        ignoreSingles=true
        ;;
      --exclude)
        shift
        [ -n "$1" ] || __failArgument "$usage" "Empty $(decorate code "$argument") argument" || return $?
        excludes+=(! -path "$1")
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(decorate code "$argument")" || return $?
  done

  [ ${#findArgs[@]} -gt 0 ] || __failArgument "$usage" "Need to specify at least one --extension" || return $?
  [ ${#prefixes[@]} -gt 0 ] || __failArgument "$usage" "Need to specify at least one prefix (Try --prefix '# IDENTICAL')" || return $?

  tempDirectory="$(mktemp -d -t "$me.XXXXXXXX")" || __failEnvironment "$usage" "mktemp -d -t" || return $?
  resultsFile=$(__usageEnvironment "$usage" mktemp) || return $?
  searchFileList=$(__usageEnvironment "$usage" mktemp) || return $?
  rootDir=$(__usageEnvironment "$usage" realPath "$rootDir") || return $?
  __identicalCheckGenerateSearchFiles "$usage" "${repairSources[@]+"${repairSources[@]}"}" -- "$rootDir" "${findArgs[@]}" ! -path "*/.*/*" "${excludes[@]+${excludes[@]}}" >"$searchFileList" || _clean $? "$searchFileList" || return $?
  if [ ! -s "$searchFileList" ]; then
    __failEnvironment "$usage" "No files found in $rootDir with${extensionText}" || _clean $? "$searchFileList" || return $?
  fi
  ! $debug || dumpPipe "searchFileList" <"$searchFileList" || return $?
  prefixIndex=0
  for prefix in "${prefixes[@]}"; do
    quotedPrefix=$(quoteGrepPattern "$prefix")
    while IFS= read -r searchFile; do
      if [ "$(basename "$searchFile")" = "$me" ]; then
        # We are exceptional ;)
        continue
      fi
      [ -d "$tempDirectory/$prefixIndex" ] || mkdir "$tempDirectory/$prefixIndex"
      totalLines=$(($(wc -l <"$searchFile") + 0))
      while read -r identicalLine; do
        statusMessage decorate info "#$((prefixIndex + 1)): Processing $searchFile:$(decorate code "$identicalLine") ... "
        # DEBUG # decorate bold-red "$identicalLine" # DEBUG
        if ! parsed=$(__identicalLineParse "$searchFile" "$prefix" "$identicalLine"); then
          badFiles+=("$searchFile")
          continue
        fi
        IFS=' ' read -r lineNumber token count <<<"$(printf -- "%s\n" "$parsed")" || :
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
            printf "%s%s: %s\n" "$(clearLine)" "$(decorate info "$token")" "$(decorate error "Token counts do not match:")" 1>&2
            printf "    %s has %s specified\n" "$(decorate code "$tokenFileName")" "$(decorate success "$tokenLineCount")" 1>&2
            printf "    %s has %s specified\n" "$(decorate code "$searchFile")" "$(decorate error "$count")" 1>&2
            isBadFile=true
            touch "$countFile.compare" || :
            touch "$tempDirectory/$prefixIndex/$tokenLineCount@$token.match.compare" || :
          elif ! isUnsignedInteger "$count"; then
            __usageEnvironment "$usage" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "1" >"$countFile" || return $?
            badFiles+=("$searchFile")
            printf "%s\n" "$(decorate code "$searchFile:$lineNumber") - not integers: $(decorate value "$identicalLine")"
          else
            compareFile="${countFile}.compare"
            # statusMessage decorate info "compareFile $compareFile"
            # Extract our section of the file. Matching is done, use line numbers and math to extract exact section
            # 10 lines in file, line 1 means: tail -n 10
            # 10 lines in file, line 9 means: tail -n 2
            # 10 lines in file, line 10 means: tail -n 1
            __usageEnvironment "$usage" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "$count" >"$compareFile" || return $?
            if [ "$(grep -c -e "$quotedPrefix" "$compareFile")" -gt 0 ]; then
              dumpPipe compareFile <"$compareFile"
              badFiles+=("$searchFile")
              {
                clearLine
                printf "%s: %s\n< %s\n%s" "$(decorate info "$token")" "$(decorate warning "Identical sections overlap:")" "$(decorate success "$searchFile")" "$(decorate code)" || :
                grep -e "$quotedPrefix" "$compareFile" | wrapLines "$(decorate code)    " "$(consoleReset)" || :
                consoleReset || :
              } 1>&2
            elif $mapFile; then
              _identicalMapAttributesFilter "$usage" "$searchFile" <"$countFile" >"$countFile.mapped" || return $?
              countFile="$countFile.mapped"
            fi
            if ! diff -b -q "$countFile" "$compareFile" >/dev/null; then
              printf "%s%s: %s\n< %s\n> %s%s\n" "$(clearLine)" "$(decorate info "$token")" "$(decorate error "Token code changed ($count): ($countFile)")" "$(decorate success "$tokenFileName")" "$(decorate warning "$searchFile")" "$(decorate code)" 1>&2
              diff "$countFile" "$compareFile" | wrapLines "$(decorate subtle "diff:") $(decorate code)" "$(consoleReset)" || : 1>&2
              isBadFile=true
            else
              statusMessage decorate success "Verified $searchFile, lines $lineNumber-$((lineNumber + tokenLineCount))"
            fi
            if $mapFile; then
              rm -rf "$countFile" || return $?
            fi
          fi
          if $isBadFile; then
            if [ ${#repairSources[@]} -gt 0 ]; then
              statusMessage decorate warning "Repairing $token in $(decorate code "$searchFile") from \"$(decorate value "$tokenFileName")\""
              if ! __identicalCheckRepair "$prefix" "$token" "$tokenFileName" "$searchFile" "${repairSources[@]}" 1>&2; then
                badFiles+=("$tokenFileName")
                badFiles+=("$searchFile")
                decorate error "$(clearLine)Unable to repair $(decorate value "$token") in $(decorate code "$searchFile")" 1>&2
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
          printf "%s\n%s\n" "$count" "$searchFile" >"$tokenFile"
          __usageEnvironment "$usage" __identicalCheckMatchFile "$searchFile" "$totalLines" "$lineNumber" "$count" >"$countFile" || return $?
          if [ "$token" = "" ]; then
            dumpPipe "token countFile $token $countFile" <"$countFile" 1>&2
          fi
          statusMessage decorate info "$(printf "Found %d %s for %s (in %s)" "$count" "$(plural "$count" line lines)" "$(decorate code "$token")" "$(decorate value "$searchFile")")"
        fi
      done < <(grep -n -e "$quotedPrefix" <"$searchFile" || :)
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

  #
  # Singles checks
  #
  if ! $ignoreSingles; then
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
          printf "%s: %s in %s\n" "$(decorate success "Single instance of token ok:")" "$(decorate code "$token")" "$(decorate info "$tokenFile")"
          foundSingles+=("$token")
        else
          printf "%s: %s in %s\n" "$(decorate warning "Single instance of token found:")" "$(decorate error "$token")" "$(decorate info "$tokenFile")" >>"$resultsFile"
          if [ -n "$binary" ]; then
            "$binary" "$tokenFile"
          fi
          exitCode=$failureCode
        fi
      fi
    done < <(find "$tempDirectory" -type f -name '*.match' || :)
    for token in "${singles[@]+"${singles[@]}"}"; do
      if ! inArray "$token" "${foundSingles[@]+"${foundSingles[@]}"}"; then
        while read -r tokenFile; do
          tokenFile="$(tail -n 1 "$tokenFile")"
          printf "%s: %s %s\n" "$(decorate warning "Multiple instance of --single token found:")" "$(decorate error "$token")" "$(decorate info "$tokenFile")"
        done < <(find "$tempDirectory" -name "$token" -type f)
      fi
    done
  fi

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

# Usage: {fn} usage repairSource ... -- directory findArgs ...
# stdout: list of files
__identicalCheckGenerateSearchFiles() {
  local usage="$1" searchFileList ignorePatterns repairSources directory directories filter IFS

  shift # usage
  repairSources=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      shift
      break
    fi
    repairSources+=("$(usageArgumentDirectory "$usage" repairSource "${1%/}/")")
    shift # repairSource
  done
  directory=$(usageArgumentDirectory "$usage" "directory" "${1-%/}") || return $?
  directories=("${repairSources[@]+"${repairSources[@]}"}" "$directory") && shift

  searchFileList=$(__usageEnvironment "$usage" mktemp) || return $?
  ignorePatterns=()
  for directory in "${directories[@]}"; do
    directory="${directory%/}"
    filter=("cat")
    if [ "${#ignorePatterns[@]}" -gt 0 ]; then
      filter=("grep" "-v" "${ignorePatterns[@]}")
    fi
    if ! find "$directory" "$@" | "${filter[@]}" >>"$searchFileList"; then
      # decorate warning "No matching files found in $directory" 1>&2
      : Do nothing for now
    fi
    ignorePatterns+=(-e "$(quoteGrepPattern "$directory")")
  done
  __usageEnvironment "$usage" cat "$searchFileList" || _clean "$?" "$searchFileList" || return $?
  __usageEnvironment "$usage" rm -rf "$searchFileList" || return $?
}

# Usage: {fn} searchFile lineNumber totalLines count
# Generate the match file given the search file
# TODO: This returns error 1 inside a container, so forced return 0. KMD 2024-09-16
# Should not likely have return 0 but this avoids the error
# The errors in question is
# 1. #1: Processing /opt/atlassian/bitbucketci/agent/build/OMNI/domains.tf:9:  # IDENTICAL domainSuffix 6 ... __identicalCheckMatchFile "/opt/atlassian/bitbucketci/agent/build/OMNI/domains.tf" "320" "9" "6" (->  1 )
# 1. /opt/atlassian/bitbucketci/agent/build/bin/build/tools.sh "identicalCheck" "--ignore-singles" "--repair" "./bin/infrastructure/identical" "--repair" "/opt/atlassian/bitbucketci/agent/build/etc/identical" "--extension" "tf" "--prefix" "# IDENTICAL" "./GLOBAL" "./infrastructure" "./modules" (->  1 )
# 1. maiIdentical "" (->  1 )
# File contains 320 lines, so
# > tail -n $((320 - 9)) /opt/atlassian/bitbucketci/agent/build/OMNI/domains.tf | head -n 6
# Works AOK anywhere else. So maybe mounted file system error in Docker?
__identicalCheckMatchFile() {
  local searchFile="$1" totalLines="$2" lineNumber="$3" count="$4"
  tail -n $((totalLines - lineNumber)) <"$searchFile" | head -n "$count"
  return 0
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
  aa+=(--prefix '# ''IDENTICAL' )
  aa+=(--prefix '# ''DOC TEMPLATE:' )
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
      # IDENTICAL --help 4
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
