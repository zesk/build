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

# Usage: {fn} --extension extension0 --prefix prefix0  [ --cd directory ] [ --extension extension1 ... ] [ --prefix prefix1 ... ]
# Argument: --extension extension - Required. String. One or more extensions to search for in the current directory.
# Argument: --prefix prefix - Required. String. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
# Argument: --exclude pattern - Optional. String. One or more patterns of paths to exclude. Similar to pattern used in `find`.
# Argument: --cd directory - Optional. Directory. Change to this directory before running. Defaults to current directory.
# Argument: --repair directory - Optional. Directory. Any files in onr or more directories can be used to repair other files.
# Argument: --token token - Optional. String. ONLY do this token. May be specified more than once.
# Argument: --skip file - Optional. Directory. Ignore this file for repairs.
# Argument: --ignore-singles - Optional. Flag. Skip the check to see if single entries exist.
# Argument: --no-map - Optional. Flag. Do not map __BASE__, __FILE__, __DIR__ tokens.
# Argument: --debug - Optional. Additional debugging information is output.
# Argument: --help - Optional. Flag. This help.
# Argument: --singles singlesFiles - Optional. File. One or more files which contain a list of allowed `{identical}` singles, one per line.
# Argument: --single singleToken - Optional. String. One or more tokens which cam be singles.
#
# Exit Code: 2 - Argument error
# Exit Code: 0 - Success, everything matches
# Exit Code: 100 - Failures
#
# When, for whatever reason, you need code to match between files, add a comment in the form:
#
#     # {identical} tokenName n
#
# Where `tokenName` is unique to your project, `n` is the number of lines to match. All found sets of lines in this form
# must match each other set of lines with the same prefix, otherwise errors and details about failures are printed to stdout.
#
# The command to then check would be:
#
#     {fn} --extension sh --prefix '# {identical}'
#
# This is largely useful for projects in which specific functions are replicated between scripts for code independence, yet
# should remain identical.
#
# Mapping also automatically handles file names and paths, so using the token `__FILE__` within your identical source
# will convert to the target file's application path.
#
# Failures are considered:
#
# - Partial success, but warnings occurred with an invalid number in a file
# - Two code instances with the same token were found which were not identical
# - Two code instances with the same token were found which have different line counts
#
# This is best used as a pre-commit check, for example.
# See: identicalWatch
identicalCheck() {
  local usage="_${FUNCNAME[0]}"

  local mapFile=true debug=false rootDir="."
  local repairSources=() excludes=() prefixes=() singles=() binary="" ignoreSingles=false
  local findArgs=() extensionText="" skipFiles=() tokens=() tempDirectory=""

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
    --watch)
      __catch "$usage" identicalWatch "${__saved[@]}" && return $? || return $?
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
    --skip)
      shift
      skipFiles+=("$(usageArgumentFile "$usage" "$argument" "${1-}")") || return $?
      ;;
    --singles)
      local singleFile
      shift
      singleFile=$(usageArgumentFile "$usage" singlesFile "${1-}") || return $?
      while read -r single; do
        single="${single#"${single%%[![:space:]]*}"}"
        single="${single%"${single##*[![:space:]]}"}"
        if [ "${single###}" = "${single}" ]; then
          singles+=("$single")
        fi
      done <"$singleFile"
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
      [ -n "$1" ] || __throwArgument "$usage" "Empty $(decorate code "$argument") argument" || return $?
      excludes+=(! -path "$1")
      ;;
    --cache) shift && tempDirectory=$(usageArgumentDirectory "$usage" "$argument" "${1-}") || return $? ;;
    --token)
      shift
      local token
      token="$(usageArgumentString "$usage" "$argument" "${1-}")" || return $?
      tokens+=("$token")
      escapedTokens+=("$(quoteGrepPattern "$token")") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ ${#findArgs[@]} -gt 0 ] || __throwArgument "$usage" "Need to specify at least one --extension" || return $?
  [ ${#prefixes[@]} -gt 0 ] || __throwArgument "$usage" "Need to specify at least one prefix (Try --prefix '# IDENTICAL')" || return $?

  local start failureCode exitCode=0 clean=()

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?
  failureCode="$(returnCode identical)"

  rootDir=$(__catchEnvironment "$usage" realPath "$rootDir") || return $?
  local resultsFile searchFileList clean=()

  if [ -z "$tempDirectory" ]; then
    tempDirectory="$(fileTemporaryName "$usage" -d)" || return $?
    clean+=("$tempDirectory")
  fi
  local resultsFile="$tempDirectory/results" searchFileList="$tempDirectory/searchFileList"
  $debug || clean+=("$searchFileList")
  $debug || clean+=("$tempDirectory")

  # ! $debug || decorate info "$LINENO: Generate search files"
  # ! $debug || decorate each quote __identicalCheckGenerateSearchFiles "$usage" "${repairSources[@]+"${repairSources[@]}"}" -- "$rootDir" "${findArgs[@]}" ! -path "*/.*/*" "${excludes[@]+${excludes[@]}}"
  __identicalCheckGenerateSearchFiles "$usage" "${repairSources[@]+"${repairSources[@]}"}" -- "$rootDir" "${findArgs[@]}" ! -path "*/.*/*" "${excludes[@]+${excludes[@]}}" >"$searchFileList" || returnClean $? "${clean[@]}" || return $?
  if [ ! -s "$searchFileList" ]; then
    __throwEnvironment "$usage" "No files found in $(decorate file "$rootDir") with${extensionText}" || returnClean $? "${clean[@]}" || return $?
  fi
  clean+=("$searchFileList.smaller")
  if [ "${#tokens[@]}" -gt 0 ]; then
    xargs grep -l -E "($(listJoin '|' "${escapedTokens[@]}"))" <"$searchFileList" >"$searchFileList.smaller" || returnClean $? "${clean[@]}" || return $?
    __catchEnvironment "$usage" mv "$searchFileList.smaller" "$searchFileList" || returnClean $? "${clean[@]}" || return $?
  fi
  ! $debug || dumpPipe "searchFileList" <"$searchFileList" || returnClean $? "${clean[@]}" || return $?

  local variable stateFile
  stateFile=$(fileTemporaryName "$usage") || returnClean $? "${clean[@]}" || return $?

  # Write strings to state
  for variable in tempDirectory resultsFile rootDir failureCode searchFileList mapFile; do
    __catch "$usage" environmentValueWrite "$variable" "${!variable}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
  done
  # Line exists here largely so $mapFile is "used"
  __catch "$usage" environmentValueWrite "mapFile" "$mapFile" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?

  # Write array values to state
  __catch "$usage" environmentValueWriteArray "repairSources" "${repairSources[@]+"${repairSources[@]}"}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
  __catch "$usage" environmentValueWriteArray "prefixes" "${prefixes[@]+"${prefixes[@]}"}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
  __catch "$usage" environmentValueWriteArray "skipFiles" "${skipFiles[@]+"${skipFiles[@]}"}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
  __catch "$usage" environmentValueWriteArray "singles" "${singles[@]+"${singles[@]}"}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
  __catch "$usage" environmentValueWriteArray "tokens" "${tokens[@]+"${tokens[@]}"}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?

  local prefix prefixIndex=0
  for prefix in "${prefixes[@]}"; do
    local __line=1 searchFile
    # ! $debug || decorate info "$LINENO: Processing prefix $prefix"

    while read -r searchFile; do
      local realFile
      [ -f "$searchFile" ] || __throwEnvironment "$usage" "Invalid searchFileList $searchFileList line $__line: $(decorate value "$searchFile")"
      realFile=$(__catchEnvironment "$usage" realPath "$searchFile") || returnClean $? "${clean[@]}" || return $?
      if [ "${#skipFiles[@]}" -gt 0 ] && inArray "$realFile" "${skipFiles[@]}"; then
        statusMessage decorate notice "Skipping $(decorate file "$realFile")" || returnClean $? "${clean[@]}" || return $?
        continue
      fi
      # ! $debug || decorate info "$LINENO: _identicalCheckInsideLoop"

      if ! _identicalCheckInsideLoop "$usage" "$stateFile" "$prefixIndex" "$prefix" "$realFile"; then
        exitCode="$failureCode"
      fi
      __line=$((__line + 1))
    done <"$searchFileList"
    prefixIndex=$((prefixIndex + 1))
  done

  if [ "$exitCode" -ne 0 ]; then
    local badFiles=() item
    while read -r item; do badFiles+=("$item"); done < <(__catch "$usage" environmentValueReadArray "$stateFile" "badFiles") || return $?

    if [ ${#badFiles[@]} -gt 0 ]; then
      exitCode=$failureCode
      if [ -n "$binary" ]; then
        __environment "$binary" "${badFiles[@]}" || :
        statusMessage --last printf -- "%s %s %s %s" "$(decorate success "Sent")" "${#badFiles[@]} $(plural ${#badFiles[@]} file files)" "$(decorate success "to")" "$(decorate code "$binary")"
      fi
    fi
  fi

  #
  # Singles checks
  #
  if ! $ignoreSingles; then
    _identicalCheckSinglesChecker "$usage" "$stateFile" || exitCode=$?
  fi

  __catchEnvironment "$usage" rm -rf "${clean[@]}" || return $?
  if $debug; then
    printf "%s %s\n" "$(decorate warning "Keeping directory")" "$(decorate file "$tempDirectory")"
  fi
  if [ $(($(fileLineCount "$resultsFile") + 0)) -ne 0 ]; then
    exitCode=$failureCode
  fi
  fileIsEmpty "$resultsFile" || cat "$resultsFile" 1>&2
  rm -rf "$resultsFile" "$searchFileList"
  statusMessage --last timingReport "$start" "Completed in"
  return "$exitCode"
}
_identicalCheck() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

