#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# maker.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__documentationMake() {
  local handler="$1" && shift

  local source="" target="" aa=() templates=() verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
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
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "$source" ] || throwArgument "$handler" "--source is required" || return $?
  [ -n "$target" ] || throwArgument "$handler" "--target is required" || return $?

  local logs=("$target/make-not-found.txt" "$target/make-found.txt" "$target/make-all.txt")

  local path && path="$(catchReturn "$handler" buildEnvironmentGet BUILD_DOCUMENTATION_PATH)" || return $?
  [ -z "$path" ] || path="${path%:}:"
  path="$path$(listJoin ":" "${templates[@]+"${templates[@]}"}")"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  catchReturn "$handler" muzzle directoryRequire "$target" || return $?
  catchReturn "$handler" find "$target" -name 'make-*.txt' -type f -delete || return $?
  catchReturn "$handler" printf "%s\n" "pwd=$(pwd)" "BUILD_DOCUMENTATION_PATH=$path" "__DOCUMENTATION_MAKE_PATH=$target" | catchReturn "$handler" muzzle tee "${logs[@]}" || return $?
  __DOCUMENTATION_MAKE_PATH="$target" BUILD_HOME="$home" BUILD_DOCUMENTATION_PATH="$path" __documentationMaker "$handler" "${aa[@]+"${aa[@]}"}" "$source" "$target" __documentationMakeHandler || return $?

  # catchReturn "$handler" fileUniqueLines "${logs[@]}" || return $?
}

__documentationMakeHandler() {
  local handler="returnMessage"
  local file="$1" && shift
  local token="$1" && shift
  local offset="$1" && shift
  local total="$1" && shift

  export BUILD_HOME __DOCUMENTATION_MAKE_PATH
  [ -n "${BUILD_HOME-}" ] || throwEnvironment "$handler" "BUILD_HOME is blank?" || return $?
  [ -n "${__DOCUMENTATION_MAKE_PATH-}" ] || throwEnvironment "$handler" "__DOCUMENTATION_MAKE_PATH is blank?" || return $?
  local allFile="$__DOCUMENTATION_MAKE_PATH/make-all.txt"
  local logFile="$__DOCUMENTATION_MAKE_PATH/make-not-found.txt" suffix=""
  local targetFile && if targetFile=$(__documentationFile "${BUILD_HOME-}" "$token"); then
    # catchReturn "$handler" cat "$targetFile" || return $?
    logFile="$__DOCUMENTATION_MAKE_PATH/make-found.txt"
    suffix=" -> $targetFile"
  fi
  catchReturn "$handler" printf "%s %s %s %s%s\n" "$file" "$token" "$offset" "$total" "$suffix" | catchReturn "$handler" tee -a "$allFile" >>"$logFile" || return $?
  return 1
}

__documentationMaker() {
  local handler="$1" && shift
  local sourcePath="" targetPath="" mapper=() verboseFlag=false aa=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose) verboseFlag=true ;;
    --default) shift && aa+=("$argument" "${1-}") ;;
    *)
      if [ -z "$sourcePath" ]; then
        [ "$argument" = "-" ] && sourcePath="$argument" || sourcePath=$(validate "$handler" Exists "sourcePath" "$argument") || return $?
      elif [ -z "$targetPath" ]; then
        [ "$argument" = "-" ] && targetPath="$argument" || targetPath=$(validate "$handler" FileDirectory "targetPath" "$argument") || return $?
      else
        mapper=("$@") && set -- && break
      fi
      ;;
    esac
    shift
  done
  [ -n "$sourcePath" ] || sourcePath="-"
  [ -n "$targetPath" ] || targetPath="-"

  mapper=("${aa[@]+"${aa[@]}"}" __documentationMakerMapper "${mapper[@]+"${mapper[@]}"}" --)

  local fileGenerator=() mapStart && mapStart=$(timingStart)
  local clean=()
  if [ "$sourcePath" = "-" ] || [ -f "$sourcePath" ]; then
    local savedInput && savedInput=$(fileTemporaryName "$handler") || return $?
    clean+=("$savedInput")
    catchReturn "$handler" cat >"$savedInput" || returnClean $? "${clean[@]}" || return $?
    fileGenerator=(printf "%s\n" "$savedInput")
    sourceFile=stdin
  elif [ "$targetPath" != "-" ]; then
    targetPath=$(catchReturn "$handler" directoryRequire "$targetPath") || return $?
    fileGenerator=(find "$sourcePath" -type f -name "*.md" ! -path '*/\.*/*')
  fi
  local targetFile sourceFile && while read -r sourceFile; do
    if [ "$targetPath" = "-" ]; then
      returnCode=0
      ! $verboseFlag || statusMessage decorate info "Generating $(decorate file "$sourceFile") to stdout" 1>&2
      mapFunction --handler "$handler" "${mapper[@]}" "-" <"$sourceFile" || returnCode=$?
      if [ "$returnCode" = 141 ]; then
        catchReturn "$handler" cat "$sourceFile" && returnCode=0 || returnCode=$?
      fi
      returnClean "$returnCode" "${clean[@]}" || return $?
    else
      local targetName="${sourceFile#"$sourcePath/"}"
      targetFile="${targetPath%/}/$targetName"
      targetFile=$(catchReturn "$handler" fileDirectoryRequire "$targetFile") || return $?
      local returnCode=0 && mapFunction --handler "$handler" "${mapper[@]}" "$targetName" <"$sourceFile" >"$targetFile" || returnCode=$?
    fi
    # ! $verboseFlag || echo "mapFunction --handler" "$handler" "${mapper[@]}" "$targetName" "<$sourceFile" ">${targetFile} (${#targetFile}), \"$targetName\" ${#targetName} targetPath=$targetPath ${#targetPath}" 1>&2
    local errorString="" verbString="Generated"
    case "$returnCode" in
    0) ;;
    120 | 130) return "$returnCode" ;;
    141) catchReturn "$handler" cp "$sourceFile" "$targetFile" && verbString="Copied" || return $? ;;
    *)
      errorString="$(decorate error "[ERROR $returnCode] <- ")"
      $verboseFlag || printf "%s%s\n" "$errorString" "$(decorate file "$sourceFile")" 1>&2
      ;;
    esac
    ! $verboseFlag || statusMessage timingReport "$mapStart" "${errorString}(.) $verbString $(decorate file "$targetFile")" 1>&2
  done < <("${fileGenerator[@]}" | sort)
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
  export __DOCUMENTATION_MAKE_PATH
  [ ! -d "$__DOCUMENTATION_MAKE_PATH" ] || printf "%s %s %s %s\n" "$fileName" "$original" "$offset" "$total" >>"$__DOCUMENTATION_MAKE_PATH/make-maker.txt" || return $?
  case "$tokenName" in
  '"'*'"')
    [ ! -d "$__DOCUMENTATION_MAKE_PATH" ] || printf "%s %s %s %s\n" "$fileName" "$original" "$offset" "$total" >>"$__DOCUMENTATION_MAKE_PATH/make-maker-quoted.txt" || return $?
    catchReturn "$handler" printf -- "{%s}" "$original" || return $?
    return 0
    ;;
  "!skip")
    [ ! -d "$__DOCUMENTATION_MAKE_PATH" ] || printf "%s %s %s %s\n" "$fileName" "$original" "$offset" "$total" >>"$__DOCUMENTATION_MAKE_PATH/make-maker-skip.txt" || return $?
    return 141
    ;;
  *[!:_[:alnum:]/-]*)
    [ ! -d "$__DOCUMENTATION_MAKE_PATH" ] || printf "%s %s %s %s\n" "$fileName" "$original" "$offset" "$total" >>"$__DOCUMENTATION_MAKE_PATH/make-maker-mismatch.txt" || return $?
    catchReturn "$handler" printf -- "{NOT-%s}" "$original" || return $?
    return 0
    ;;
  esac
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

__documentationFunctionCompile() {
  local handler="$1" && shift
  local aa=() fingerprint="" key && key="$(caller)" documentationSource=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --clean | --verbose | --force) aa+=("$argument") ;;
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

  local cleanFlag=false aa=() functions=() verboseFlag=false sourcePath="" forceFlag=false

  decorateInitialized || decorate info --
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --verbose) verboseFlag=true ;;
    --clean) cleanFlag=true ;;
    --force) forceFlag=true ;;
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
        local finder=(find "$docPath" -type f \( -name '*.sh' -or -name '*.md' \) ! -path '*/\.*/*')
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
      statusMessage timing --name "$prefix $fun" catchReturn "$handler" __documentationFileCompileFunction "$handler" "$docPath" "$sourcePath" "$fun" "" "$prefix" "$forceFlag" "${aa[@]+"${aa[@]}"}" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
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
# Argument: prefix - String. Optional. Prefix the status line with this text.
# Argument: force - Boolean. Optional. Force file generation without caching.
# Argument: derived  - .... Optional. Derived functions to run on new or modified files.
__documentationFileCompileFunction() {
  export BUILD_DEBUG
  local flag=",usage-profile," flags=",${BUILD_DEBUG-},"

  # IDENTICAL profileFunctionHead 4
  # ********************************************************************************************************************
  local __profile="false" __profile0="" __profileNext __profileUsed=0 __profileLabel="arguments (#$__count)" __profilePrefix="Profile-${FUNCNAME[0]}: "
  if [ -n "$flags" ] && [ "${flags#*"$flag"}" != "$flags" ]; then __profile=$(timingStart) && __profile0=$__profile; fi
  # ********************************************************************************************************************

  # # #
  # # # Load pre-validated arguments
  # # #

  local handler="$1" && shift
  local docPath="$1" && shift
  local sourcePaths && IFS=":" read -r -a sourcePaths <<<"${1-}" && shift

  local fun && fun=$(validate "$handler" String "function" "${1-}") && shift || return $?
  local sourceHash="" sourceFile="${1-}" && shift || throwArgument "$handler" "Missing sourceFile" || return $?
  local prefix="$1" && shift && [ -z "$prefix" ] || prefix="${prefix% } "
  local force="$1" && shift
  local derived=("$@") && set --

  local prettyFun && prettyFun=$(catchReturn "$handler" decorate code "$fun") || return $?

  __profilePrefix="${__profilePrefix}[$fun] "
  local documentationSettingsFile="$docPath/$fun.sh" seeFile="$docPath/SEE/$fun.md" mdFile="$docPath/$fun.md"
  local ff=("$documentationSettingsFile" "$seeFile" "$mdFile")

  # # #
  # # # Check the sourceHash to see if the file changed
  # # #

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

  # # #
  # # # Need a sourceFile or find it
  # # #

  if [ -z "$sourceFile" ]; then
    __profileLabel="blank source"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************

    [ "${#sourcePaths[@]}" -gt 0 ] || throwArgument "$handler" "Missing source paths to find $fun" || return $?
    local sourcePath && for sourcePath in "${sourcePaths[@]}"; do
      if sourceFile=$(catchReturn "$handler" __bashDocumentation_FindFunctionDefinitions "$sourcePath" "$fun"); then
        local sourcesFound && sourcesFound=$(catchReturn "$handler" printf "%s\n" "$sourceFile" | fileLineCount) || return $?
        if [ "$sourcesFound" -gt 1 ]; then
          local remainingFiles && remainingFiles=$(sed "1d" <<<"$sourceFile")
          sourceFile=$(catchReturn "$handler" head -n 1 <<<"$sourceFile") || return $?
          statusMessage --last decorate warning "${prefix} Multiple sources found for $prettyFun (x$sourcesFound), using $(decorate file "$sourceFile"):"$'\n'"Ignoring $(decorate orange "${remainingFiles//$'\n'/, }")"
        fi
      fi
    done
    [ -f "$sourceFile" ] || throwEnvironment "$handler" "${prefix} No source found for $prettyFun in ${sourcePaths[*]}" || return $?

    __profileLabel="find function source"
    # IDENTICAL profileFunctionMarker 3
    # ********************************************************************************************************************
    if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
    # ********************************************************************************************************************
  fi

  pathIsAbsolute "$sourceFile" || sourceFile="$home/$sourceFile"

  # # #
  # # # Validate sourceFile hash against known hash of current files
  # # #

  if ! $force && [ -n "$sourceHash" ]; then
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

  # # #
  # # # All cache checks are now completed, we are generating it, set up temp files
  # # #

  local tempComment && tempComment=$(fileTemporaryName "$handler") || return $?
  local tempHelp="$tempComment.help"
  clean+=("$tempComment" "$tempHelp")

  # # #
  # # # Extract the comment into $tempComment
  # # #

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

  # # #
  # # # bashDocumentationExtract into $documentationSettingsFile
  # # #

  (
    local nc=() && $force || nc=(--no-cache)
    catchReturn "$handler" bashDocumentationExtract "${nc[@]+"${nc[@]}"}" --function --generate "$fun" "$sourceFile" <"$tempComment" >"$documentationSettingsFile" || returnClean $? "${clean[@]}" || return $?
  ) || return $?

  __profileLabel="bashDocumentationExtract"
  # IDENTICAL profileFunctionMarker 3
  # ********************************************************************************************************************
  if [ "$__profile" != "false" ]; then __profileNext="$(timingStart)" && printf "Line %d: %s%d %s\n" "$LINENO" "$__profilePrefix" "$((__profileNext - __profile))" "$__profileLabel" 1>&2 && __profile=$__profileNext; fi
  # ********************************************************************************************************************

  # # #
  # # # Generate themeless help and plain text help
  # # #

  [ -f "$documentationSettingsFile" ] || throwEnvironment "$handler" "${prefix}: bashDocumentationExtract $fun $(decorate file "$sourceFile") did not generate $documentationSettingsFile"$'\n'"$(dumpPipe <"$tempComment")" || returnClean $? "${clean[@]}" || return $?

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

  # # #
  # # # Generate derived files (this is extensible)
  # # #

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
