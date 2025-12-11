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

__identicalCheck() {
  local handler="$1" && shift

  local mapFile=true debug=false rootDir="."
  local repairSources=() excludes=() prefixes=() singles=() binary="" ignoreSingles=false
  local findArgs=() extensionText="" skipFiles=() tokens=() tempDirectory=""
  local activeFilePatterns=() prefixPatterns=()

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
    --watch)
      catchReturn "$handler" identicalWatch "${__saved[@]}" && return $? || return $?
      ;;
    --no-map)
      mapFile=false
      ;;
    --debug)
      bashDebugInterruptFile --error --interrupt
      debug=true
      ;;
    --cd)
      shift
      rootDir=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $?
      ;;
    --repair)
      shift
      repairSources+=("$(usageArgumentRealDirectory "$handler" "repairSource" "${1-}")") || return $?
      ;;
    --extension)
      shift
      [ ${#findArgs[@]} -eq 0 ] || findArgs+=("-or")
      findArgs+=("-name" "*.$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      extensionText="$extensionText .$1"
      ;;
    --exec)
      shift
      binary=$(usageArgumentCallable "$handler" "$argument" "$1") || return $?
      ;;
    --skip)
      shift
      skipFiles+=("$(usageArgumentFile "$handler" "$argument" "${1-}")") || return $?
      ;;
    --singles)
      local singleFile
      shift
      singleFile=$(usageArgumentFile "$handler" singlesFile "${1-}") || return $?
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
      prefixPatterns+=("$(quoteGrepPattern "$1")") || return $?
      ;;
    --ignore-singles)
      ignoreSingles=true
      ;;
    --exclude)
      shift
      [ -n "$1" ] || throwArgument "$handler" "Empty $(decorate code "$argument") argument" || return $?
      excludes+=(! -path "$1")
      ;;
    --cache) shift && tempDirectory=$(usageArgumentDirectory "$handler" "$argument" "${1-}") || return $? ;;
    --token)
      shift
      local token
      token="$(usageArgumentString "$handler" "$argument" "${1-}")" || return $?
      tokens+=("$token")
      activeFilePatterns+=("$(quoteGrepPattern "$token")") || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ ${#findArgs[@]} -gt 0 ] || throwArgument "$handler" "Need to specify at least one --extension" || return $?
  [ ${#prefixes[@]} -gt 0 ] || throwArgument "$handler" "Need to specify at least one prefix (Try --prefix '# IDENTICAL')" || return $?

  local start failureCode exitCode=0 clean=()

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?
  failureCode="$(returnCode identical)"

  rootDir=$(catchEnvironment "$handler" realPath "$rootDir") || return $?
  local resultsFile searchFileList clean=()

  if [ -z "$tempDirectory" ]; then
    tempDirectory="$(fileTemporaryName "$handler" -d)" || return $?
    clean+=("$tempDirectory")
  fi
  local resultsFile="$tempDirectory/results" searchFileList="$tempDirectory/searchFileList"

  catchEnvironment "$handler" touch "$resultsFile" "$searchFileList" || return $?
  $debug || clean+=("$searchFileList")

  # ! $debug || decorate info "$LINENO: Generate search files"
  # ! $debug || decorate each quote __identicalCheckGenerateSearchFiles "$handler" "${repairSources[@]+"${repairSources[@]}"}" -- "$rootDir" "${findArgs[@]}" ! -path "*/.*/*" "${excludes[@]+${excludes[@]}}"
  __identicalCheckGenerateSearchFiles "$handler" "$rootDir" "${repairSources[@]+"${repairSources[@]}"}" -- \( "${findArgs[@]}" \) ! -path "*/.*/*" "${excludes[@]+${excludes[@]}}" >"$searchFileList" || returnClean $? "${clean[@]}" || return $?
  if [ ! -s "$searchFileList" ]; then
    throwEnvironment "$handler" "No files found in $(decorate file "$rootDir") with${extensionText}" || returnClean $? "${clean[@]}" || return $?
  fi
  clean+=("$searchFileList.smaller")
  [ "${#activeFilePatterns[@]}" -gt 0 ] || activeFilePatterns=("${prefixPatterns[@]}")
  if [ "${#activeFilePatterns[@]}" -gt 0 ]; then
    xargs grep -l -E "($(listJoin '|' "${activeFilePatterns[@]}"))" <"$searchFileList" >"$searchFileList.smaller" || returnClean $? "${clean[@]}" || return $?
    catchEnvironment "$handler" mv "$searchFileList.smaller" "$searchFileList" || returnClean $? "${clean[@]}" || return $?
  fi
  ! $debug || dumpPipe "searchFileList" <"$searchFileList" || returnClean $? "${clean[@]}" || return $?

  local variable stateFile
  stateFile=$(fileTemporaryName "$handler") || returnClean $? "${clean[@]}" || return $?
  clean+=("$stateFile")

  # Write strings to state
  for variable in tempDirectory resultsFile rootDir failureCode searchFileList mapFile; do
    catchReturn "$handler" environmentValueWrite "$variable" "${!variable}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
  done
  # Line exists here largely so $mapFile is "used"
  catchReturn "$handler" environmentValueWrite "mapFile" "$mapFile" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?

  # Write array values to state
  catchReturn "$handler" environmentValueWriteArray "repairSources" "${repairSources[@]+"${repairSources[@]}"}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" environmentValueWriteArray "prefixes" "${prefixes[@]+"${prefixes[@]}"}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" environmentValueWriteArray "skipFiles" "${skipFiles[@]+"${skipFiles[@]}"}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" environmentValueWriteArray "singles" "${singles[@]+"${singles[@]}"}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" environmentValueWriteArray "tokens" "${tokens[@]+"${tokens[@]}"}" >>"$stateFile" || returnClean $? "${clean[@]}" || return $?

  local __line=1 searchFile

  while read -r searchFile; do
    [ -f "$searchFile" ] || throwEnvironment "$handler" "Invalid searchFileList $searchFileList line $__line: $(decorate file "$searchFile")"
    if [ "${#skipFiles[@]}" -gt 0 ] && inArray "$searchFile" "${skipFiles[@]}"; then
      statusMessage decorate notice "Skipping $(decorate file "$searchFile")" || returnClean $? "${clean[@]}" || return $?
      continue
    fi
    ! $debug || statusMessage decorate each code _identicalCheckInsideLoop "$handler" "$stateFile" "$searchFile" "${prefixes[@]}"
    if ! _identicalCheckInsideLoop "$handler" "$debug" "$stateFile" "$searchFile" "${prefixes[@]}"; then
      exitCode="$failureCode"
    fi
    # searchFileList contains absolute paths from __identicalCheckGenerateSearchFiles
  done <"$searchFileList"

  if [ "$exitCode" -ne 0 ]; then
    local badFiles=() item
    while read -r item; do badFiles+=("$item"); done < <(catchReturn "$handler" environmentValueReadArray "$stateFile" "badFiles") || return $?

    if [ ${#badFiles[@]} -gt 0 ]; then
      exitCode=$failureCode
      if [ -n "$binary" ]; then
        catchEnvironment "$handler" "$binary" "${badFiles[@]}" || :
        statusMessage --last printf -- "%s %s %s %s" "$(decorate success "Sent")" "$(pluralWord ${#badFiles[@]} file)" "$(decorate success "to")" "$(decorate code "$binary")"
      fi
    fi
  fi

  #
  # Singles checks
  #
  if ! $ignoreSingles; then
    _identicalCheckSinglesChecker "$handler" "$stateFile" || exitCode=$?
  fi

  if $debug; then
    printf "%s %s\n" "$(decorate warning "Keeping directory")" "$(decorate file "$tempDirectory")"
  fi
  if [ $(($(fileLineCount "$resultsFile") + 0)) -ne 0 ]; then
    exitCode=$failureCode
  fi
  fileIsEmpty "$resultsFile" || cat "$resultsFile" 1>&2
  rm -rf "$resultsFile" "$searchFileList"
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  statusMessage --last timingReport "$start" "Completed in"
  return "$exitCode"
}
