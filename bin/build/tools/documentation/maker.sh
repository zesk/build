#!/usr/bin/env bash
#
# documentation-index.sh
#
# Generate an index of our bash functions for faster documentation generation.
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

__documentationMake() {
  local handler="$1" && shift

  local source="" target="" aa=() templates=() verboseFlag=false

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
    --template) shift && templates+=("$(validate "$handler" Directory "$argument" "${1-}")") || return $? ;;
    --source) shift && source="$(validate "$handler" Directory "$argument" "${1-}")" || return $? ;;
    --target) shift && target="$(validate "$handler" FileDirectory "$argument" "${1-}")" || return $? ;;
    --verbose) aa+=("$argument") && verboseFlag=true ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "$source" ] || throwArgument "$handler" "--source is required" || return $?
  [ -n "$target" ] || throwArgument "$handler" "--target is required" || return $?

  export __DOCUMENTATION_LOG_PREFIX
  local missingLog="$target/tokens.txt" || return $?
  local foundLog="$target/replaced.txt" || return $?

  local path && path="$(catchReturn "$handler" buildEnvironmentGet BUILD_DOCUMENTATION_PATH)" || return $?
  [ -z "$path" ] || path="${path%:}:"
  path="$path$(listJoin ":" "${templates[@]+"${templates[@]}"}")"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  printf -- "" | muzzle tee "$foundLog" "$missingLog"
  __DOCUMENTATION_MAKE_PATH="$target" BUILD_HOME="$home" BUILD_DOCUMENTATION_PATH="$path" __documentationMaker "$handler" "${aa[@]+"${aa[@]}"}" "$source" "$target" __documentationMakeHandler || return $?

  catchReturn "$handler" fileUniqueLines "$missingLog" "$foundLog" || return $?
}

__documentationMakeHandler() {
  local handler="returnMessage"
  export BUILD_HOME __DOCUMENTATION_MAKE_PATH
  [ -n "${BUILD_HOME-}" ] || throwEnvironment "$handler" "BUILD_HOME is blank?" || return $?
  [ -n "${__DOCUMENTATION_MAKE_PATH-}" ] || throwEnvironment "$handler" "__DOCUMENTATION_MAKE_PATH is blank?" || return $?
  if muzzle __documentationFile "${BUILD_HOME-}" "$1"; then
    printf "%s\n" "$1" >>"$__DOCUMENTATION_MAKE_PATH/replaced.txt"
    return 1
  fi
  printf "%s\n" "$1" >>"$__DOCUMENTATION_MAKE_PATH/tokens.txt"
  return 1
}

# Argument: token offset total
__documentationMakerMapper() {
  local nextMapper=()
  while [ $# -gt 0 ]; do if [ "$1" = "--" ]; then shift && break; fi && nextMapper+=("$1") && shift; done
  [ $# -ge 3 ] || throwArgument "$handler" "Missing arguments? $# $*" || return $?
  local fileName="$1" && shift
  local original="$1" tokenName="${1//://}" && shift
  local offset="$1" && shift
  local total="$1" && shift
  local returnCode=0
  case "$tokenName" in
  "!skip") return 141 ;;
  esac
  case "$tokenName" in *[^_[:alnum:]/-]*) printf -- "{%s}" "$original" && return 0 ;; esac
  # printf "%s\n" "TOKEN: $tokenName" 1>&2
  if [ "${#nextMapper[@]}" -gt 0 ]; then
    "${nextMapper[@]}" "$fileName" "$tokenName" "$offset" "$total" || returnCode=$?
    [ "$returnCode" -eq 1 ] || return $returnCode
  fi
  export BUILD_HOME && local template && if template=$(__documentationFile "${BUILD_HOME-}" "$tokenName"); then
    # Remove everything but slashes
    local rel="${fileName//[^\/]/}"
    # Length is number of dot-dots to the root
    rel=$(textRepeat "${#rel}" "../")
    # printf "DUMPING %s\n" "$template" 1>&2
    # Trims trailing newline automatically
    rel="$rel" mapEnvironment <"$template"
  else
    return 1
  fi
}

__documentationMaker() {
  local handler="$1" && shift
  local sourcePath="" targetPath="" mapper=() verboseFlag=false aa=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose) verboseFlag=true ;;
    --default) shift && aa+=("$argument" "${1-}") ;;
    *)
      if [ -z "$sourcePath" ]; then
        sourcePath=$(validate "$handler" Exists "sourcePath" "$argument") || return $?
      elif [ -z "$targetPath" ]; then
        [ "$argument" = "-" ] && targetPath="$argument" || targetPath=$(validate "$handler" FileDirectory "targetPath" "$argument") || return $?
      else
        mapper=("$@") && set -- && break
      fi
      ;;
    esac
    shift
  done
  [ -n "$targetPath" ] || targetPath="-"

  mapper=("${aa[@]+"${aa[@]}"}" __documentationMakerMapper "${mapper[@]+"${mapper[@]}"}" --)

  if [ -f "$sourcePath" ]; then
    local mapStart && mapStart=$(timingStart)
    ! $verboseFlag || statusMessage decorate info "Generating $(decorate file "$targetFile")" 1>&2
    local returnCode=0
    if [ "$targetPath" = "-" ]; then
      mapFunction --handler "$handler" "${mapper[@]}" "-" <"$sourcePath" || returnCode=$?
    else
      local targetName
      if [ -d "$targetPath" ]; then
        targetName=$(basename "$sourcePath")
        targetPath="${targetPath%/}/$targetName"
      else
        targetName=$(basename "$targetPath")
      fi
      targetPath=$(catchReturn "$handler" fileDirectoryRequire "$targetPath") || return $?
      mapFunction --handler "$handler" "${mapper[@]}" "$targetName" <"$sourcePath" >"$targetPath" || returnCode=$?
    fi
    case "$returnCode" in 120 | 130) return "$returnCode" ;; 141) catchReturn "$handler" cp "$sourceFile" "$targetFile" ;; esac
    ! $verboseFlag || statusMessage reportTiming "$mapStart" "Generated $(decorate file "$targetFile")" 1>&2
    return $returnCode
  elif [ "$targetPath" = "-" ]; then
    throwArgument "$handler" "Can not output directory to stdout (-)" || return $?
  fi
  # Directory of files to another directory of files
  targetPath=$(catchReturn "$handler" directoryRequire "$targetPath") || return $?
  local sourceFile && while read -r sourceFile; do
    local targetName="${sourceFile#"$sourcePath/"}"
    local targetFile="${targetPath%/}/${sourceFile#"$sourcePath/"}"
    targetFile=$(catchReturn "$handler" fileDirectoryRequire "$targetFile") || return $?
    local returnCode=0 && mapFunction --handler "$handler" "${mapper[@]}" "$targetName" <"$sourceFile" >"$targetFile" || returnCode=$?
    local errorString=""
    case "$returnCode" in
    0) ;;
    120 | 130) return "$returnCode" ;;
    141) catchReturn "$handler" cp "$sourceFile" "$targetFile" || return $? ;;
    *)
      errorString="$(decorate error "[ERROR $returnCode] <- ")"
      $verboseFlag || printf "%s%s\n" "$errorString" "$(decorate file "$sourceFile")" 1>&2
      ;;
    esac
    ! $verboseFlag || statusMessage decorate info "${errorString}Generated $(decorate file "$targetFile")"
  done < <(find "$sourcePath" -type f -name "*.md" ! -path '*/\.*/*' | sort)
}

__documentationFunctionCompile() {
  local handler="$1" && shift
  local aa=() fingerprint="" key && key="$(caller)" documentationSource=""

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
    --clean | --verbose) aa+=("$argument") ;;
    --source) shift && aa+=("$argument" "${1-}") ;;
    --documentation) shift && documentationSource=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --key) shift && key=$(validate "$handler" String "$argument" "${1-}") || return "$(convertValue $? 120 0)" ;;
    --fingerprint) fingerprint=$(validate "$handler" Fingerprint "$argument" "$key") || return "$(convertValue $? 120 0)" ;;
    --check)
      [ $# -eq 0 ] || throwArgument "$handler" "Extra arguments: $# $*" || return $?
      fingerprint --key "$key" --check
      return $?
      ;;
    *) break ;;
    esac
    shift
  done

  [ -z "$documentationSource" ] || aa+=(--derive bashDocumentationDeriveSee --source "$documentationSource" --)
  aa+=(--derive bashDocumentationDeriveFunction --)
  documentationFileCompile --handler "$handler" "${aa[@]+"${aa[@]}"}" "$@" || return $?

  [ -z "$fingerprint" ] || fingerprint --key "$key" --verbose
}

__documentationFileCompile() {
  local handler="$1" && shift

  local cleanFlag=false aa=() functions=() verboseFlag=false sourcePath=""

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
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --verbose) verboseFlag=true ;;
    --clean) cleanFlag=true ;;
    --source) shift && sourcePath=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --derive) aa+=("--") && shift && while [ $# -gt 0 ]; do
      [ "$1" != "--" ] || break
      aa+=("$1") && shift
    done ;;
    *) functions=("$@") && break ;;
    esac
    shift
  done

  [ -n "$sourcePath" ] || throwArgument "$handler" "--source is required" || return $?

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  if $cleanFlag; then
    local total=0
    if [ "${#functions[@]}" -gt 0 ]; then
      local fun && for fun in "${functions[@]}"; do
        local path && for path in "" "env/" "SEE/" "env/more/"; do
          local extension && for extension in "sh" "md"; do
            local target
            target=$(__documentationFile "$home" "$path$fun" false "$extension") || continue
            ! $verboseFlag || statusMessage decorate info "Removing $target" || return $?
            catchReturn "$handler" rm -f "$target" || return $?
            ((total++))
          done
        done
      done
    else
      local docPath && docPath="$(dirname "$(__documentationFile "$home" "test" true)")" || return $?
      catchReturn "$handler" statusMessage decorate info "Cleaning $docPath" || return $?
      if [ -d "$docPath" ]; then
        local finder=(find "$docPath" -type f \( -name '*.sh' -or -name '*.md' \) ! -path '*/.*/*')
        total=$("${finder[@]}" | fileLineCount) || return $?
        catchEnvironment "$handler" "${finder[@]}" -delete || return $?
      fi
    fi
    ! $verboseFlag || statusMessage decorate info "Deleted $(localePluralWord "$total" file)" || return $?
    return 0
  fi

  local start && start=$(timingStart)

  local docPath && docPath="$(dirname "$(__documentationFile "$home" "test" true)")" || return $?
  catchReturn "$handler" muzzle directoryRequire "$docPath" || return $?

  local tempFunctions && tempFunctions=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempFunctions")
  ([ "${#functions[@]}" -gt 0 ] && printf "%s\n" "${functions[@]}" || catchReturn "$handler" cat) >"$tempFunctions" || returnClean $? "${clean[@]}" || return $?
  local totalFunctions && totalFunctions=$(catchReturn "$handler" fileLineCount "$tempFunctions") || returnClean $? "${clean[@]}" || return $?

  local undo=(-- shopt -s expand_aliases -- muzzle popd)
  # turn off aliases
  shopt -u expand_aliases || :
  catchReturn "$handler" muzzle pushd "$home" || return $?
  local finished=false index=0 && while ! $finished; do
    index=$((index + 1))
    local prefix="#$index/$totalFunctions -"
    local fun && read -r fun || finished=true
    [ -n "$fun" ] || continue
    bashFunctionNameValid "$fun" || continue
    (
      statusMessage timing --name "$prefix $fun" __documentationFileCompileFunction "$handler" "$docPath" "$sourcePath" "$fun" "" "$prefix" "${aa[@]+"${aa[@]}"}" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
    ) || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
  done <"$tempFunctions" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
  shopt -s expand_aliases || :
  catchReturn "$handler" rm -f "${clean[@]}" || return $?
  catchReturn "$handler" muzzle popd || return $?
  catchReturn "$handler" statusMessage --last timingReport "$start" "$totalFunctions completed in" || return $?
}

# Extract and build the bin/build/documentation/ cache
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: handler - Function. Required.
# Argument: docPath - Directory. Required.
# Argument: sourcePath - Directory. Required. Directory to find function definitions if not found.
# Argument: function - String. Required. Function to extract
# Argument: sourceFile - File|EmptyString. Required. Source file or blank if not known.
# Argument: prefix ... - String. Optional. Prefix the status line with this text.
# Argument: derived  - .... Optional. Derived functions to run on new or modified files.
__documentationFileCompileFunction() {
  export BUILD_DEBUG
  local flag=",usage-profile," flags=",${BUILD_DEBUG-},"

  # IDENTICAL profileFunctionHead 4
  # ********************************************************************************************************************
  local __profile="false" __profile0="" __profileNext __profileUsed=0 __profileLabel="arguments (#$__count)" __profilePrefix="Profile-${FUNCNAME[0]}: "
  if [ -n "$flags" ] && [ "${flags#*"$flag"}" != "$flags" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
  # ********************************************************************************************************************

  local handler="$1" && shift
  local docPath="$1" && shift
  local sourcePath="$1" && shift

  local fun && fun=$(validate "$handler" String "function" "${1-}") && shift || return $?
  local sourceHash="" sourceFile="${1-}" && shift || return $?
  local prefix="$1" && shift && [ -z "$prefix" ] || prefix="${prefix% } "
  local derived=("$@") && set --

  local prettyFun && prettyFun=$(catchReturn "$handler" decorate code "$fun") || return $?

  __profilePrefix="${__profilePrefix}[$fun] "
  local documentationSettingsFile="$docPath/$fun.sh" seeFile="$docPath/SEE/$fun.md" mdFile="$docPath/$fun.md"
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

    [ -n "$sourcePath" ] || throwArgument "$handler" "Missing source path to find $fun" || return $?
    sourceFile=$(__bashDocumentation_FindFunctionDefinitions "$sourcePath" "$fun") || return $?
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

  pathIsAbsolute "$sourceFile" || sourceFile="$home/$sourceFile"

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
    catchReturn "$handler" bashDocumentationExtract --function --generate "$fun" "$sourceFile" <"$tempComment" >"$documentationSettingsFile" || returnClean $? "${clean[@]}" || return $?
  ) || return $?

  __profileLabel="bashDocumentationExtract"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************
  if [ ! -f "$documentationSettingsFile" ]; then
    throwEnvironment "$handler" "${prefix}: bashDocumentationExtract $fun $(decorate file "$sourceFile") did not generate $documentationSettingsFile"$'\n'"$(dumpPipe <"$tempComment")" || returnClean $? "${clean[@]}" || return $?
  else
    # local init && init=$(timingStart)
    catchReturn "$handler" decorateThemelessMode || return $?
    fn="" BUILD_DEBUG="usage-cache-skip" BUILD_COLORS=true catchReturn "$handler" bashDocumentation "$sourceFile" "$fun" 0 >"$tempHelp" || returnClean $? "${clean[@]}" || returnUndo $? decorateThemelessMode --end || return $?
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

__buildFunctionsDerived() {
  local handler="$1" && shift
  local sourceFile="$1" && shift

  local runner=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      [ "${#runner[@]}" -eq 0 ] || catchReturn "$handler" "${runner[@]}" "$sourceFile" && runner=() || return $?
    else
      runner+=("$1")
    fi
    shift
  done
  [ "${#runner[@]}" -eq 0 ] || catchReturn "$handler" "${runner[@]}" "$sourceFile" || return $?
}

__buildFunctionsCheckDerived() {
  local handler="$1" && shift
  local sourceFile="$1" && shift

  local profile="$1" && shift

  local runner=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      if [ "${#runner[@]}" -gt 0 ]; then
        local ca=() ra=()
        if $profile; then ca=(timing --name "${runner[0]}-check") && ra=(timing --name "${runner[0]}"); fi
        "${ca[@]+"${ca[@]}"}" "${runner[@]}" --check "$sourceFile" || catchReturn "$handler" "${ra[@]+"${ra[@]}"}" "${runner[@]}" "$sourceFile" || return $?
        runner=()
      fi
    else
      runner+=("$1")
    fi
    shift
  done
  if [ "${#runner[@]}" -gt 0 ]; then
    local ca=() ra=()
    if $profile; then ca=(timing --name "${runner[0]}-check") && ra=(timing --name "${runner[0]}"); fi
    "${ca[@]+"${ca[@]}"}" "${runner[@]}" --check "$sourceFile" || catchReturn "$handler" "${ra[@]+"${ra[@]}"}" "${runner[@]}" "$sourceFile" || return $?
    runner=()
  fi
}
