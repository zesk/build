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
# Argument: --skip file - Optional. Directory. Ignore this file for repairs.
# Argument: --ignore-singles - Optional. Flag. Skip the check to see if single entries exist.
# Argument: --no-map - Optional. Flag. Do not map __BASE__, __FILE__, __DIR__ tokens.
# Argument: --debug - Optional. Additional debugging information is output.
# Argument: --help - Optional. Flag. This help.
# Argument: --singles singlesFiles - Optional. File. One or more files which contain a list of allowed `IDENTICAL` singles, one per line.
# Argument: --single singleToken - Optional. String. One or more tokens which cam be singles.
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

  local mapFile=true debug=false rootDir="."
  local repairSources=() excludes=() prefixes=() singles=() binary="" ignoreSingles=false
  local findArgs=() extensionText="" skipFiles=()

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
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ ${#findArgs[@]} -gt 0 ] || __throwArgument "$usage" "Need to specify at least one --extension" || return $?
  [ ${#prefixes[@]} -gt 0 ] || __throwArgument "$usage" "Need to specify at least one prefix (Try --prefix '# IDENTICAL')" || return $?

  local start failureCode exitCode=0 clean=()

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?
  failureCode="$(_code identical)"

  rootDir=$(__catchEnvironment "$usage" realPath "$rootDir") || return $?
  local tempDirectory resultsFile searchFileList

  tempDirectory="$(fileTemporaryName "$usage" -d)" || return $?
  resultsFile=$(fileTemporaryName "$usage") || return $?
  searchFileList=$(fileTemporaryName "$usage") || return $?
  clean+=("$searchFileList")
  $debug || clean+=("$tempDirectory")

  __identicalCheckGenerateSearchFiles "$usage" "${repairSources[@]+"${repairSources[@]}"}" -- "$rootDir" "${findArgs[@]}" ! -path "*/.*/*" "${excludes[@]+${excludes[@]}}" >"$searchFileList" || _clean $? "${clean[@]}" || return $?
  if [ ! -s "$searchFileList" ]; then
    __throwEnvironment "$usage" "No files found in $(decorate file "$rootDir") with${extensionText}" || _clean $? "${clean[@]}" || return $?
  fi
  ! $debug || dumpPipe "searchFileList" <"$searchFileList" || _clean $? "${clean[@]}" || return $?

  local variable stateFile
  stateFile=$(fileTemporaryName "$usage") || _clean $? "${clean[@]}" || return $?

  # Write strings to state
  for variable in tempDirectory resultsFile rootDir failureCode searchFileList mapFile; do
    __catchEnvironment "$usage" environmentValueWrite "$variable" "${!variable}" >>"$stateFile" || _clean $? "${clean[@]}" || return $?
  done
  # Line exists here largely so $mapFile is "used"
  __catchEnvironment "$usage" environmentValueWrite "mapFile" "$mapFile" >>"$stateFile" || _clean $? "${clean[@]}" || return $?

  # Write array values to state
  __catchEnvironment "$usage" environmentValueWriteArray "repairSources" "${repairSources[@]+"${repairSources[@]}"}" >>"$stateFile" || _clean $? "${clean[@]}" || return $?
  __catchEnvironment "$usage" environmentValueWriteArray "prefixes" "${prefixes[@]+"${prefixes[@]}"}" >>"$stateFile" || _clean $? "${clean[@]}" || return $?
  __catchEnvironment "$usage" environmentValueWriteArray "skipFiles" "${skipFiles[@]+"${skipFiles[@]}"}" >>"$stateFile" || _clean $? "${clean[@]}" || return $?
  __catchEnvironment "$usage" environmentValueWriteArray "singles" "${singles[@]+"${singles[@]}"}" >>"$stateFile" || _clean $? "${clean[@]}" || return $?

  local prefix prefixIndex=0
  for prefix in "${prefixes[@]}"; do
    local __line=1
    while read -r searchFile; do
      [ -f "$searchFile" ] || __throwEnvironment "$usage" "Invalid searchFileList $searchFileList line $__line: $(decorate value "$searchFile")"
      realFile=$(__catchEnvironment "$usage" realPath "$searchFile") || _clean $? "${clean[@]}" || return $?
      if [ "${#skipFiles[@]}" -gt 0 ] && inArray "$realFile" "${skipFiles[@]}"; then
        statusMessage decorate notice "Skipping $(decorate file "$realFile")" || _clean $? "${clean[@]}" || return $?
        continue
      fi
      if ! _identicalCheckInsideLoop "$usage" "$stateFile" "$prefixIndex" "$prefix" "$realFile"; then
        exitCode="$failureCode"
      fi
      __line=$((__line + 1))
    done <"$searchFileList"
    prefixIndex=$((prefixIndex + 1))
  done

  if [ "$exitCode" -ne 0 ]; then
    local badFiles=() item
    while read -r item; do badFiles+=("$item"); done < <(__catchEnvironment "$usage" environmentValueReadArray "$stateFile" "badFiles") || return $?

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
  if [ $(($(wc -l <"$resultsFile") + 0)) -ne 0 ]; then
    exitCode=$failureCode
  fi
  isEmptyFile "$resultsFile" || cat "$resultsFile" 1>&2
  rm -rf "$resultsFile" "$searchFileList"
  statusMessage --last timingReport "$start" "Completed in"
  return "$exitCode"
}
_identicalCheck() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} usage repairSource ... -- directory findArgs ...
# stdout: list of files
__identicalCheckGenerateSearchFiles() {
  local usage="$1" searchFileList directory directories filter IFS

  shift # usage
  local repairSources=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      shift
      break
    fi
    repairSources+=("$(usageArgumentDirectory "$usage" repairSource "${1%/}/")")
    shift # repairSource
  done
  directory=$(usageArgumentDirectory "$usage" "directory" "${1-%/}") || return $?
  directories=("${repairSources[@]+"${repairSources[@]}"}" -- "$directory") && shift

  searchFileList=$(fileTemporaryName "$usage") || return $?
  local ignorePatterns=() startExclude=false
  for directory in "${directories[@]}"; do
    directory="${directory%/}"
    if [ "$directory" = "--" ]; then
      startExclude=true
      continue
    fi
    filter=("cat")
    if $startExclude && [ "${#ignorePatterns[@]}" -gt 0 ]; then
      filter=("grep" "-v" "${ignorePatterns[@]}")
    fi
    if ! find "$directory" "$@" | sort | "${filter[@]}" >>"$searchFileList"; then
      # decorate warning "No matching files found in $directory" 1>&2
      : Do nothing for now
    fi
    ignorePatterns+=(-e "$(quoteGrepPattern "$directory/")")
  done
  __catchEnvironment "$usage" cat "$searchFileList" || _clean "$?" "$searchFileList" || return $?
  __catchEnvironment "$usage" rm -rf "$searchFileList" || return $?
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
# Looks for up to three tokens in code:
#
# - `# ``IDENTICAL tokenName 1`
# - `# ``_IDENTICAL_ tokenName 1`, and
# - `# ``DOC TEMPLATE: tokenName 1`
#
# This allows for overlapping identical sections within templates with the intent:
#
# - `IDENTICAL` - used in most cases
# - `_IDENTICAL_` - used in templates which must be included in OTHER templates
# - `DOC TEMPLATE:` - used in documentation templates for functions - is handled by internal document generator
#
# Usage: {fn} [ --repair repairSource ] [ --help ] [ --interactive ] [ --check checkDirectory ] ...
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --singles singlesFiles - Optional. File. One or more files which contain a list of allowed `IDENTICAL` singles, one per line.
# Argument: --single singleToken - Optional. String. One or more tokens which cam be singles.
# Argument: --repair directory - Optional. Directory. Any files in onr or more directories can be used to repair other files.
# Argument: --internal - Flag. Optional. Do updates for `# _IDENTICAL_` and `# DOC TEMPLATE:` prefixes first.
# Argument: --interactive - Flag. Optional. Interactive mode on fixing errors.
# Argument: ... - Optional. Additional arguments are passed directly to `identicalCheck`.
identicalCheckShell() {
  local usage="_${FUNCNAME[0]}"
  local argument single singleFile aa=() pp=() addDefaultPrefixes=true

  singles=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
    --internal-only)
      pp=(--prefix '# ''DOC TEMPLATE:' --prefix '# ''_IDENTICAL_')
      addDefaultPrefixes=false
      ;;
    --internal)
      if [ "${#pp[@]}" -eq 0 ]; then
        # Ordering here matters so declare from inside scope to outside scope
        pp+=(--prefix '# ''DOC TEMPLATE:' --prefix '# ''_IDENTICAL_')
      fi
      ;;
    --interactive)
      aa+=("$argument")
      ;;
    --repair | --single | --exec | --prefix | --exclude | --extension | --skip | --singles)
      shift
      aa+=("$argument" "${1-}")
      ;;
    # _IDENTICAL_ --help 4
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
  ! $addDefaultPrefixes || pp+=(--prefix '# ''IDENTICAL')
  __catchEnvironment "$usage" identicalCheck "${aa[@]+"${aa[@]}"}" "${pp[@]}" --extension sh "$@" || return $?
}
_identicalCheckShell() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
