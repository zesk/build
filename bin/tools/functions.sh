#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Extract and build the documentation settings cache and generate derived files
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)
# Argument: --all - Flag. Optional. Do everything regardless of cache state.
# Argument: --fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.
buildFunctionsDerivedCompile() {
  local handler="_${FUNCNAME[0]}"
  local dd=() fingerprint=""

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
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --clean | --git | --all) dd+=("$argument") ;;
    --fingerprint) fingerprint=$(validate "$handler" Fingerprint fingerprintFlag "buildFunctions") || return "$(convertValue $? 120 0)" ;;
    --check)
      [ $# -eq 0 ] || throwArgument "$handler" "Extra arguments: $# $*" || return $?
      fingerprint --key "buildFunctions" --check
      return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  dd+=(--derive buildFunctionSeeTemplate --)
  dd+=(--derive buildFunctionMarkdownDocumentation --)
  catchReturn "$handler" buildFunctionsCompile "${dd[@]+"${dd[@]}"}" "$@" || return $?

  [ -z "$fingerprint" ] || fingerprint --key "buildFunctions" --verbose
}
_buildFunctionsDerivedCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Extract and build the documentation settings cache
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)
# Argument: --all - Flag. Optional. Do everything regardless of cache state.
# Argument: --derive command ... -- - CommandList. Optional. Run this command on each changed settings file to generate derived files.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
buildFunctionsCompile() {
  local handler="_${FUNCNAME[0]}"

  local cleanFlag=false quickFlag=true gitActions=false dd=()

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
    --git) gitActions=true ;;
    --all) quickFlag=false ;;
    --derive) dd+=("--") && shift && while [ $# -gt 0 ]; do
      [ "$1" != "--" ] || break
      dd+=("$1") && shift
    done ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  __buildFunctionsLoad "$handler" || return $?

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local docPath="$home/bin/build/documentation"
  if $cleanFlag; then
    catchReturn "$handler" statusMessage decorate info "Cleaning $docPath" || return $?
    [ ! -d "$docPath" ] || catchEnvironment "$handler" find "$docPath" -type f \( -name '*.sh' -or -name '*.md' \) ! -path '*/.*/*' -delete || return $?
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
    catchEnvironment "$handler" find "$docPath" -type f -name '*.sh' -empty -delete || return $?
    if __buildFunctionsIsComplete "$handler" "$docPath" "$tempFunctions" "${dd[@]+"${dd[@]}"}"; then
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
        grep "$docPath" | textRemoveFields 1 | cut -d . -f 1 | cut "-c$((2 + ${#docPath}))-" >"$tempFunctions"
        break
      done < <(textRemoveFields 1 <"$allModificationTimes")
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
  # turn off aliases
  local undo=(shopt -s expand_aliases)
  shopt -u expand_aliases || :
  while ! $finished; do
    index=$((index + 1))
    local prefix="#$index/$totalFunctions -"
    local fun && read -r fun || finished=true
    [ -n "$fun" ] || continue
    (
      statusMessage timing --name "$prefix $fun" __buildFunctionsCompileFunction "$handler" "$docPath" "$fun" "" "$prefix" "${dd[@]+"${dd[@]}"}" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
    ) || return $?
  done <"$tempFunctions" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
  shopt -s expand_aliases || :
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
  if $gitActions; then
    buildFunctionsRemoveDeprecated --dry-run --handler "$handler" || return $?
    buildFunctionsRemoveDeprecated --handler "$handler" || return $?
    find "$home/bin/build/documentation/" -type f \( -name '*.sh' -or -name '*.md' \) -print0 | xargs -0 git add || return $?
  fi
  catchReturn "$handler" statusMessage --last timingReport "$start" "$totalFunctions completed in" || return $?
}
_buildFunctionsCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildFunctionsRemoveDeprecated() {
  local handler="_${FUNCNAME[0]}"

  local dryRun=false

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
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --dry-run) dryRun=true ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local deprecatedFiles=()
  local fun && while read -r fun; do
    export BUILD_DOCUMENTATION_PATH
    local paths && IFS=":" read -r -d $'\n' -a paths <<<"${BUILD_DOCUMENTATION_PATH-"bin/build/documentation"}"
    local path && for path in "${paths[@]}"; do
      local extension && for extension in sh md; do
        local target="$home/$path/$fun.$extension"
        if [ -f "$target" ]; then
          deprecatedFiles+=("$target")
        fi
      done
    done
  done < <(catchReturn "$handler" buildDeprecatedFunctions) || return $?
  if $dryRun; then
    [ "${#deprecatedFiles[@]}" -eq 0 ] && statusMessage --last printf -- "%s\n" "# No deprecated files." || printf -- "git rm -f %s\n" "${deprecatedFiles[@]}" || return $?
  else
    [ "${#deprecatedFiles[@]}" -eq 0 ] || local f && for f in "${deprecatedFiles[@]}"; do
      catchEnvironment "$handler" git rm -f "$f" 2>/dev/null || catchReturn "$handler" rm -f "$f" || return $?
    done
  fi
}
_buildFunctionsRemoveDeprecated() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildFunctionsLoad() {
  local handler="$1" && shift

  : # Do nothing currently
}

# Extract and build the bin/build/documentation/ cache
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: handler - Function. Required.
# Argument: docPath - Directory. Required.
# Argument: function - String. Required. Function to extract
# Argument: sourceFile - File|EmptyString. Required. Source file or blank if not known.
# Argument: prefix ... - String. Optional. Prefix the status line with this text.
# Argument: derived  - .... Optional. Derived functions to run on new or modified files.
__buildFunctionsCompileFunction() {
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
  local prefix="$1" && shift && [ -z "$prefix" ] || prefix="${prefix% } "
  local derived=("$@") && set --

  local prettyFun && prettyFun=$(catchReturn "$handler" decorate code "$fun") || return $?

  __profilePrefix="${__profilePrefix}[$fun] "
  local documentationSettingsFile="$docPath/$fun.sh" seeFile="$docPath/SEE_$fun.md" mdFile="$docPath/$fun.md"
  local ff=("$documentationSettingsFile" "$seeFile" "$mdFile")

  if [ -z "$sourceFile" ] && [ -f "$documentationSettingsFile" ]; then
    __profileLabel="settings exists"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************

    IFS=" " read -r -d $'\n' sourceHash sourceFile < <(
      local sourceFile="" sourceHash="none"
      catchReturn "$handler" source "$documentationSettingsFile" || :
      printf -- "%s %s\n" "$sourceHash" "$sourceFile" || :
    ) || :
    if [ -z "$sourceFile" ]; then
      statusMessage decorate error "Corrupt $documentationSettingsFile (sourceFile) - removing"
      catchEnvironment "$handler" rm -f "${ff[@]}" || return $?
      __profileLabel="settings sourceFile missing"
    elif [ -z "$sourceHash" ] || [ "$sourceHash" = "none" ]; then
      statusMessage decorate error "Corrupt $documentationSettingsFile (sourceHash) - removing"
      catchEnvironment "$handler" rm -f "${ff[@]}" || return $?
      __profileLabel="settings sourceHash missing"
    else
      __profileLabel="Settings source non-empty"
    fi
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************
  fi

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  if [ -z "$sourceFile" ]; then
    __profileLabel="blank source"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************
    sourceFile=$(__bashDocumentation_FindFunctionDefinitions "$home/bin/build/tools" "$fun") || return $?
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
    local computedHash && computedHash=$(catchEnvironment "$handler" textSHA <"$sourceFile") || return $?

    if [ "$computedHash" = "$sourceHash" ]; then
      __profileLabel="cache match - no action"
      # IDENTICAL profileFunctionMarker 3
      # ********************************************************************************************************************
      if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
      # ********************************************************************************************************************
      [ "${#derived[@]}" -eq 0 ] || __buildFunctionsCheckDerived "$handler" "$documentationSettingsFile" "$([ "$__profile" != "false" ] && printf true || printf false)" "${derived[@]}" || throwEnvironment "$handler" "Derived failed" || :

      __profileLabel="derived-check"
      # IDENTICAL profileFunctionTail 6
      # ********************************************************************************************************************
      if [ "$__profile" != "false" ]; then
        __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2
        printf -- "Line %d: %s%d %s (%d + %d) %s + %s %d%%\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile0))" '*TOTAL*' "$((__profileNext - __profile0 - __profileUsed))" "$__profileUsed" 'us' 'them' "$(((100 * __profileUsed) / (__profileNext - __profile0)))" 1>&2
      fi
      # ********************************************************************************************************************
      catchReturn "$handler" touch "$documentationSettingsFile" || return $?
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
  catchReturn "$handler" rm -f "${ff[@]}" || return $?
  __profileLabel="bashFunctionComment"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************
  (
    catchReturn "$handler" muzzle bashDocumentationExtract --generate "$fun" "$sourceFile" <"$tempComment" || returnClean $? "${clean[@]}" || return $?
  ) || return $?

  __profileLabel="bashDocumentationExtract"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************
  if [ ! -f "$documentationSettingsFile" ]; then
    throwEnvironment "$handler" "${prefix}: bashDocumentationExtract $fun $sourceFile did not generate $documentationSettingsFile" || returnClean $? "${clean[@]}" || return $?
  else
    # local init && init=$(timingStart)
    catchReturn "$handler" decorateThemelessMode || return $?
    fn="" BUILD_DEBUG="" BUILD_COLORS=true catchReturn "$handler" bashDocumentation "$sourceFile" "$fun" 0 >"$tempHelp" || returnClean $? "${clean[@]}" || returnUndo $? decorateThemelessMode --end || return $?
    catchReturn "$handler" decorateThemelessMode --end || returnClean $? "${clean[@]}" || return $?
    {
      local replace helpCode && helpCode="$(escapeBash <"$tempHelp")"
      replace="'\$'\e''"
      helpCode=${helpCode//$'\e'/"$replace"}
      replace="'\$'\n''"
      helpCode=${helpCode//$'\n'/"$replace"}
      catchEnvironment "$handler" printf "%s\n%s=%s\n" "# shellcheck disable=SC2016" "helpConsole" "$helpCode" || returnClean $? "${clean[@]}" || return $?

      helpCode="$(decorateThemed <"$tempHelp" | consoleToPlain | escapeBash)" || throwEnvironment "$handler" "Theme failed" || returnClean $? "${clean[@]}" || return $?
      replace="'\$'\n''"
      helpCode=${helpCode//$'\n'/"$replace"}
      catchEnvironment "$handler" printf "%s\n%s=%s\n" "# shellcheck disable=SC2016" "helpPlain" "$helpCode" || returnClean $? "${clean[@]}" || return $?
    } >>"$documentationSettingsFile" || returnClean $? "${clean[@]}" || return $?
    if buildDebugEnabled "usage-compile"; then
      dumpPipe "Help for $fun" <"$tempHelp" 1>&2
      dumpPipe "Settings for $fun" <"$documentationSettingsFile" 1>&2
    fi
    catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
    # catchEnvironment "$handler" printf "%s\n" "# elapsed $(timingFormat "$(timingElapsed "$init")")" >>"$documentationSettingsFile" || return $?

    __profileLabel="decorateThemeless"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************
  fi

  __profileLabel="derived"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  [ "${#derived[@]}" -eq 0 ] || __buildFunctionsDerived "$handler" "$documentationSettingsFile" "${derived[@]}" || throwEnvironment "$handler" "Derived failed" || :

  # IDENTICAL profileFunctionTail 6
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
__buildFunctionsIsComplete() {
  local handler="$handler" && shift
  local docPath="$1" && shift
  local tempFunctions="$1" && shift

  local missing=() finished=false && while ! $finished; do
    local fun && read -r fun || finished=true
    [ -n "$fun" ] || continue
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
    (
      __buildFunctionsCompileFunction "$handler" "$docPath" "$fun" "" "Missing #$index/${#missing[@]}" "$@" || return $?
    ) || return $?
  done
  catchReturn "$handler" statusMessage decorate info "No functions missing" || return $?
}
