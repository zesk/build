#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Extract and build the bin/build/documentation/ cache
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --all - Flag. Optional. Do everything regardless of cache state.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
buildUsageCompile() {
  local handler="_${FUNCNAME[0]}"

  local cleanFlag=false quickFlag=true gitActions=true

  # turn off aliases
  shopt -u expand_aliases

  decorateInitialized || decorate info --
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --clean) cleanFlag=true ;;
    --skip-git) gitActions=false ;;
    --all) quickFlag=false ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  __buildUsageLoad "$handler" || return $?

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local docPath="$home/bin/build/documentation"
  if $cleanFlag; then
    catchReturn "$handler" statusMessage decorate info "Cleaning $docPath" || return $?
    [ ! -d "$docPath" ] || catchEnvironment "$handler" find "$docPath" -type f -name '*.sh' ! -path '*/.*/*' -delete || return $?
    return 0
  fi

  local start && start=$(timingStart)

  catchReturn "$handler" muzzle directoryRequire "$docPath" || return $?
  local tempFunctions actualTotalFunctions totalFunctions

  tempFunctions=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempFunctions")
  catchReturn "$handler" buildFunctions >"$tempFunctions" || returnClean $? "${clean[@]}" || return $?
  totalFunctions=$(catchReturn "$handler" fileLineCount "$tempFunctions") || returnClean $? "${clean[@]}" || return $?
  actualTotalFunctions=$totalFunctions
  if $quickFlag; then
    if __buildUsageIsComplete "$handler" "$docPath" "$tempFunctions"; then
      local allModificationTimes="$tempFunctions.all"
      clean+=("$allModificationTimes")
      {
        catchReturn "$handler" fileModificationTimes "$home/bin/build/tools/" -name '*.sh' || return $?
        catchReturn "$handler" fileModificationTimes "$docPath" -name '*.sh' || return $?
      } | catchReturn "$handler" sort -rn >"$allModificationTimes" || returnClean $? "${clean[@]}" || return $?
      # dumpPipe --lines 10000 "ALL" <"$allModificationTimes"
      local filePath
      while read -r filePath; do
        # If prefixed with a docPath, then skip it
        [ "${filePath#"$docPath"}" = "$filePath" ] || continue
        grep "$docPath" | removeFields 1 | cut -d . -f 1 | cut "-c$((2 + ${#docPath}))-" >"$tempFunctions"
        break
      done < <(removeFields 1 <"$allModificationTimes")
      catchEnvironment "$handler" rm -f "$allModificationTimes" || return $?
      totalFunctions=$(catchReturn "$handler" fileLineCount "$tempFunctions") || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" statusMessage decorate info "Optimized function count to check is $totalFunctions (Actual is $actualTotalFunctions)" || return $?
    else
      catchReturn "$handler" statusMessage decorate info "Total function count to compute is $totalFunctions" || return $?
    fi
  else
    catchReturn "$handler" statusMessage decorate info "Total function count to compute is $totalFunctions" || return $?
  fi
  local finished=false
  local index=0
  while ! $finished; do
    index=$((index + 1))
    local prefix="#$index/$totalFunctions -"
    local fun && read -r fun || finished=true
    [ -n "$fun" ] || continue
    statusMessage timing --name "$prefix $fun" __buildUsageCompileFunction "$handler" "$docPath" "$fun" "" "$prefix" || return $?
  done <"$tempFunctions" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
  if $gitActions; then
    local deprecatedFiles=()
    local fun && while read -r fun; do
      local target="$home/bin/build/documentation/$fun.sh"
      if [ -f "$target" ]; then
        deprecatedFiles+=("$target")
      fi
    done < <(buildDeprecatedFunctions)
    [ "${#deprecatedFiles[@]}" -eq 0 ] || catchEnvironment "$handler" git rm "${deprecatedFiles[@]}" || return $?
    catchEnvironment "$handler" git add "$home/bin/build/documentation/"*.sh || return $?
  fi
  catchReturn "$handler" statusMessage --last timingReport "$start" "$totalFunctions completed in" || return $?
}
_buildUsageCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildUsageLoad() {
  local handler="$1" && shift

  catchReturn "$handler" testTools || return $?
}

# Extract and build the bin/build/documentation/ cache
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: handler - Function. Required.
# Argument: docPath - Directory. Required.
# Argument: function - String. Required. Function to extract
# Argument: sourceFile - File|EmptyString. Required. Source file or blank if not known.
# Argument: prefix ... - String. Optional. Prefix the status line with this text.
__buildUsageCompileFunction() {
  export BUILD_DEBUG
  local flag=",usage-profile," flags=",${BUILD_DEBUG-},"

  # IDENTICAL profileFunctionHead 4
  # ********************************************************************************************************************
  local __profile="false" __profile0="" __profileNext __profileUsed=0 __profileLabel="arguments (#$__count)" __profilePrefix="Profile-${FUNCNAME[0]}: "
  if [ -n "$flags" ] && [ "${flags#*"$flag"}" != "$flags" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
  # ********************************************************************************************************************

  local handler="$1" && shift
  local docPath="$1" && shift

  local fun && fun=$(validate "$handler" Function "function" "${1-}") && shift || return $?
  local sourceHash="" sourceFile="${1-}" && shift || return $?
  local prefix="$*" && set -- && [ -z "$prefix" ] || prefix="${prefix% } "
  local prettyFun && prettyFun=$(catchReturn "$handler" decorate code "$fun") || return $?

  __profilePrefix="${__profilePrefix}[$fun] "
  local documentationSettingsFile="$docPath/$fun.sh"
  if [ -z "$sourceFile" ] && [ -f "$documentationSettingsFile" ]; then
    __profileLabel="settings exists"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************

    IFS=" " read -r -d $'\n' sourceHash sourceFile < <(
      export sourceFile=""
      export sourceHash="none"
      # shellcheck source=/dev/null
      source "$documentationSettingsFile" || :
      printf -- "%s %s\n" "$sourceHash" "$sourceFile" || :
    ) || :
    if [ -z "$sourceFile" ]; then
      statusMessage decorate error "Corrupt $documentationSettingsFile (sourceFile) - removing"
      catchEnvironment "$handler" rm -f "$documentationSettingsFile" || return $?
      __profileLabel="settings sourceFile missing"
    elif [ -z "$sourceHash" ]; then
      statusMessage decorate error "Corrupt $documentationSettingsFile (sourceHash) - removing"
      catchEnvironment "$handler" rm -f "$documentationSettingsFile" || return $?
      __profileLabel="settings sourceHash missing"
    else
      __profileLabel="Settings source non-empty"
    fi
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************
  fi

  if [ -z "$sourceFile" ]; then
    __profileLabel="blank source"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************
    sourceFile=$(__bashDocumentation_FindFunctionDefinitions "$(buildHome)/bin/build/tools" "$fun") || return $?
    local sourcesFound && sourcesFound=$(catchReturn "$handler" printf "%s\n" "$sourceFile" | fileLineCount) || return $?
    if [ "$sourcesFound" -gt 1 ]; then
      throwEnvironment "$handler" "${prefix} Multiple sources found for $prettyFun (x$sourcesFound): ${sourceFile//$'\n'/, }" || return $?
    fi
    [ -f "$sourceFile" ] || throwEnvironment "$handler" "${prefix} No source found for $prettyFun" || return $?

    __profileLabel="find function source"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************
  fi

  if [ -n "$sourceHash" ]; then
    local computedHash && computedHash=$(catchEnvironment "$handler" shaPipe <"$sourceFile") || return $?

    if [ "$computedHash" = "$sourceHash" ]; then
      __profileLabel="cache match - no action"
      # IDENTICAL profileFunctionTail 7
      # ********************************************************************************************************************
      if [ "$__profile" != "false" ]; then
        __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2
        printf -- "Line %d: %s%d %s (%d + %d) %s + %s %d%%\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile0))" '*TOTAL*' "$((__profileNext - __profile0 - __profileUsed))" "$__profileUsed" 'us' 'them' "$(((100 * __profileUsed) / (__profileNext - __profile0)))" 1>&2
      fi
      # ********************************************************************************************************************
      catchEnvironment "$handler" touch "$documentationSettingsFile" || return $?
      return 0
    fi
  fi

  local tempComment && tempComment=$(fileTemporaryName "$handler") || return $?
  local tempHelp="$tempComment.help"
  clean+=("$tempComment" "$tempHelp")

  __profileLabel="arguments"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************
  catchReturn "$handler" bashFunctionComment "$sourceFile" "$fun" >"$tempComment" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" rm -f "$documentationSettingsFile" || return $?
  __profileLabel="bashFunctionComment"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************
  catchReturn "$handler" muzzle bashDocumentationExtract --generate "$fun" "$sourceFile" <"$tempComment" || returnClean $? "${clean[@]}" || return $?

  __profileLabel="bashDocumentationExtract"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************
  if [ ! -f "$documentationSettingsFile" ]; then
    throwEnvironment "$handler" "${prefix}: bashDocumentationExtract $fun $sourceFile did not generate $documentationSettingsFile" || returnClean $? "${clean[@]}" || return $?
  else
    local init && init=$(timingStart)
    catchReturn "$handler" decorateThemelessMode || return $?
    fn="" BUILD_DEBUG="" BUILD_COLORS=true catchEnvironment "$handler" usageDocument "$sourceFile" "$fun" 0 >"$tempHelp" || returnClean $? "${clean[@]}" || returnUndo $? decorateThemelessMode --end || return $?
    catchReturn "$handler" decorateThemelessMode --end || returnClean $? "${clean[@]}" || return $?
    {
      local replace helpCode && helpCode="$(escapeBash <"$tempHelp")"
      replace="'\$'\e''"
      helpCode=${helpCode//$'\e'/"$replace"}
      replace="'\$'\n''"
      helpCode=${helpCode//$'\n'/"$replace"}
      catchEnvironment "$handler" printf "%s\n%s=%s\n" "# shellcheck disable=SC2016" "helpConsole" "$helpCode" || returnClean $? "${clean[@]}" || return $?

      helpCode="$(decorateThemed <"$tempHelp" | consoleToPlain | escapeBash)"
      replace="'\$'\n''"
      helpCode=${helpCode//$'\n'/"$replace"}
      catchEnvironment "$handler" printf "%s\n%s=%s\n" "# shellcheck disable=SC2016" "helpPlain" "$helpCode" || returnClean $? "${clean[@]}" || return $?
    } >>"$documentationSettingsFile" || returnClean $? "${clean[@]}" || return $?
    if buildDebugEnabled "usage-compile"; then
      dumpPipe "Help for $fun" <"$tempHelp" 1>&2
      dumpPipe "Settings for $fun" <"$documentationSettingsFile" 1>&2
    fi
    catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
    catchEnvironment "$handler" printf "%s\n" "# elapsed $(timingFormat "$(timingElapsed "$init")")" >>"$documentationSettingsFile" || return $?

    __profileLabel="decorateThemeless"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************
  fi

  # IDENTICAL profileFunctionTail 7
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then
    __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2
    printf -- "Line %d: %s%d %s (%d + %d) %s + %s %d%%\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile0))" '*TOTAL*' "$((__profileNext - __profile0 - __profileUsed))" "$__profileUsed" 'us' 'them' "$(((100 * __profileUsed) / (__profileNext - __profile0)))" 1>&2
  fi
  # ********************************************************************************************************************

  return 0
}

# Is everything up to date?
# Argument: handler - Function. Required.
# Argument: docPath - Directory. Required.
# Argument: tempFunctions - File. Required. File containing list of function names
__buildUsageIsComplete() {
  local handler="$handler" && shift
  local docPath="$1" && shift
  local tempFunctions="$1" && shift
  local missing=() finished=false && while ! $finished; do
    local fun && read -r fun || finished=true
    if [ -z "$fun" ] || ! isFunction "_$fun"; then continue; fi
    if [ ! -f "$docPath/$fun.sh" ]; then
      missing+=("$fun")
    fi
  done <"$tempFunctions"
  finished=false && while ! $finished; do
    local file fun && read -r file || finished=true
    [ -n "$file" ] || continue
    fun="${file##*/}" && fun="${fun%.sh}"
    if ! isFunction "$fun"; then
      catchReturn "$handler" statusMessage --last decorate error "File $(decorate file "$file") has no matching function $(decorate code "$fun") anymore" || return $?
    fi
  done < <(find "$docPath" -type f -name '*.sh')
  local index=0 fun
  [ "${#missing[@]}" -eq 0 ] || for fun in "${missing[@]}"; do
    index=$((index + 1))
    catchReturn "$handler" statusMessage decorate warning "Loading missing: $fun" || return $?
    __buildUsageCompileFunction "$handler" "$docPath" "$fun" "" "Missing #$index/${#missing[@]}" || return $?
  done
  catchReturn "$handler" statusMessage decorate info "No functions missing" || return $?
}
