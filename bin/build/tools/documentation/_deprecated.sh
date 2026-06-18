#!/usr/bin/env bash
#
# documentationBuild
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

__documentationSeeTokenTemplates() {
  local handler="$1" && shift
  local cacheDirectory="$1" && shift

  local templateCache
  templateCache=$(catchReturn "$handler" directoryRequire "$cacheDirectory/see/templates") || return $?
  local type file
  while [ $# -gt 1 ]; do
    type="$(validate "$handler" String "type" "$1")" || return $?
    file="$(validate "$handler" File "file" "${2-}")" || return $?
    link="$(validate "$handler" String "link" "${3-}")" || return $?
    catchEnvironment "$handler" cp "$file" "$templateCache/$type" || return $?
    printf "%s\n" "$link" >"$templateCache/$type.link" || return $?
    shift 3
  done
}

__documentationSeeTokenGenerate() {
  local handler="$1" && shift
  local cacheDirectory="$1" && shift
  local matchingToken="$1" && shift
  local tokenCache

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  tokenCache=$(catchReturn "$handler" directoryRequire "$cacheDirectory/see/tokens") || return $?
  if [ "$matchingToken" != "${matchingToken//../}" ]; then
    throwEnvironment "$handler" "Token contains invalid characters: $matchingToken" || return $?
  fi
  local matchingTokenFile="${matchingToken//[^A-Za-z0-9]/_}"
  local tokenCacheFile="$tokenCache/$matchingTokenFile"
  local checkFile="$tokenCacheFile.check"
  if [ -f "$tokenCacheFile" ]; then
    local checkFiles=()
    IFS=$'\n' read -r -d '' -a checkFiles <"$checkFile" || :
    [ "${#checkFiles[@]}" -gt 0 ] || throwEnvironment "$handler" "$matchingToken.check contains no files" || return $?
    if fileIsNewest "$tokenCacheFile" "${checkFiles[@]}"; then
      catchEnvironment "$handler" cat "$tokenCacheFile" || return $?
      return 0
    fi
  fi

  local templateCache
  templateCache=$(catchReturn "$handler" directoryRequire "$cacheDirectory/see/templates") || return $?
  local linkPatternFile="$tokenCacheFile.settings"

  {
    local settingsFile linkPattern templateFile linkType="unknown"
    if [ "${matchingToken}" = "${matchingToken%.*}" ] && settingsFile=$(__documentationIndexLookup "$handler" --settings "$matchingToken"); then
      linkType="function"
      cat "$settingsFile"
      catchEnvironment "$handler" printf -- "%s\n" "$settingsFile" >>"$checkFile" || return $?
      __dumpSimpleValue "line" "$(__documentationIndexLookup "$handler" --line "$matchingToken")"
    elif settingsFile=$(__documentationIndexLookup "$handler" --file "$matchingToken"); then
      settingsFile="$(printf -- "%s\n" "$settingsFile" | sort | head -n 1)" || return $?
      __dumpSimpleValue "file" "$settingsFile"
      if stringBegins "$settingsFile" "bin/build/env" "bin/env"; then
        catchEnvironment "$handler" printf -- "%s\n" "$home/$settingsFile" >>"$checkFile" || return $?
        linkType="environment"
        local variable lowerVariable
        variable="$(basename "$settingsFile")"
        variable="${variable%.sh}"
        lowerVariable=$(stringLowercase "$variable")
        __dumpSimpleValue "variable" "$variable"
        __dumpSimpleValue "lowerVariable" "$lowerVariable"
        __dumpSimpleValue "line" ""
        __documentationEnvironmentFileParse "$handler" "$settingsFile" || return $?
      else
        catchEnvironment "$handler" printf -- "%s\n" "$settingsFile" >>"$checkFile" || return $?
        __dumpSimpleValue "line" ""
        linkType="file"
      fi
    fi
    linkPattern=""
    templateFile=""
    if [ -f "$templateCache/$linkType" ]; then
      linkPattern=$(catchEnvironment "$handler" head -n 1 "$templateCache/$linkType.link") || return $?
      __dumpSimpleValue "link" "$linkPattern"
      templateFile="$templateCache/$linkType"
    fi
    __dumpSimpleValue "linkType" "$linkType"
    __dumpSimpleValue "fn" "$matchingToken"
    __dumpSimpleValue "lowerFn" "$(stringLowercase "$matchingToken")"
  } >"$linkPatternFile"

  local vv=(
    fn lowerFn usage applicationHome applicationFile file line
    base return_code description example argument linkType summary
    sourceLink documentationPath build_debug variable lowerVariable link type
  )
  (
    export sourceLink documentationPath
    local __save_handler__="$handler"
    set -a # UNDO ok
    # shellcheck source=/dev/null
    source "$linkPatternFile"
    set +a
    handler="$__save_handler__"
    sourceLink="$(catchReturn "$handler" mapEnvironment "${vv[@]}" <<<"$linkPattern")" || return $?
    documentationPath="$(__documentationIndexLookup "$handler" --documentation "$matchingToken" | head -n 1 || :)"
    if [ -n "$documentationPath" ]; then
      documentationPath="${documentationPath#"$home"}"
      documentationPath="${documentationPath#/}"
      documentationPath="${documentationPath#"$documentationSource"}"
      documentationPath="${documentationPath#/}"
    else
      documentationPath="#not-found-$matchingToken"
    fi
    if [ -z "$templateFile" ]; then
      printf "%s\n" "$matchingToken - (not found)"
    else
      catchReturn "$handler" mapEnvironment "${vv[@]}" <"$templateFile" | tee "$tokenCacheFile" || return $?
    fi
  ) || return $?
}

# DEPRECATED: 2025-04
__documentationBuild() {
  local handler="$1" && shift

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local company="" applicationName="" docArgs=() companyLink="" applicationName=""

  local sourcePaths=() cleanFlag=false
  local targetPath="" actionFlag="" actionFlag="" verbose=false pageTemplate=""
  local indexArgs=() templatePath="" company="" applicationName="" functionTemplate="" seePrefix="-"

  local unlinkedSources=() unlinkedTemplate="" unlinkedTarget="" dd=()
  local seeEnvironmentLink=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) dd+=(--debug) ;;
    --commit) _buildDocumentation_Recommit && return $? || return $? ;;
    --company) shift && company=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --name) shift && applicationName=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --filter) docArgs+=("$argument") && shift && while [ $# -gt 0 ] && [ "$1" != "--" ]; do docArgs+=("$1") && shift; done && docArgs+=("--") ;;
    --template)
      [ -z "$templatePath" ] || throwArgument "$handler" "$argument already supplied" || return $?
      shift && templatePath=$(validate "$handler" RealDirectory "$argument" "${1-}") || return $?
      ;;
    --page-template)
      [ -z "$pageTemplate" ] || throwArgument "$handler" "$argument already supplied" || return $?
      shift && pageTemplate=$(validate "$handler" File "$argument" "${1-}") || return $?
      ;;
    --function-template)
      [ -z "$functionTemplate" ] || throwArgument "$handler" "$argument already supplied" || return $?
      shift && functionTemplate=$(validate "$handler" File "$argument" "${1-}") || return $?
      ;;
    --source) shift && sourcePaths+=("$(validate "$handler" RealDirectory "$argument" "${1-}")") || return $? ;;
    --target) shift && targetPath="$(validate "$handler" Directory "$argument" "${1-}")" && targetPath="${targetPath#"$home"/}" || return $? ;;
    --company-link) shift && companyLink=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --unlinked-source) shift && unlinkedSources+=("$(validate "$handler" Directory "$argument" "${1-}")") || return $? ;;
    --unlinked-template) shift && unlinkedTemplate=$(validate "$handler" File "$argument" "${1-}") || return $? ;;
    --unlinked-target) shift && unlinkedTarget=$(validate "$handler" FileDirectory "$argument" "${1-}") || return $? ;;
    --clean) indexArgs+=("$argument") && cleanFlag=true ;;
    --see-prefix) shift && seePrefix="${1-}" ;;
    --see-environment-link) shift && seeEnvironmentLink=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --force) docArgs+=("$argument") ;;
    --see-update | --unlinked-update | --index-update | --docs-update)
      [ -z "$actionFlag" ] || throwArgument "$handler" "$argument and $actionFlag are mutually exclusive" || return $?
      actionFlag="$argument"
      ;;
    --verbose)
      verbose=true
      if [ ${#docArgs[@]} -eq 0 ] || ! inArray "$argument" "${docArgs[@]}"; then
        docArgs+=("$argument")
        indexArgs+=("$argument")
      fi
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  export BUILD_COMPANY BUILD_COMPANY_LINK BUILD_HOME APPLICATION_NAME APPLICATION_CODE

  catchReturn "$handler" buildEnvironmentLoad APPLICATION_CODE APPLICATION_NAME BUILD_COMPANY BUILD_COMPANY_LINK || return $?

  #
  # --clean actually does not require much to run so just handle that first
  #
  local cacheDirectory

  cacheDirectory="$(catchReturn "$handler" documentationCache)" || return $?
  if $cleanFlag; then
    catchEnvironment "$handler" rm -rf "$cacheDirectory" || return $?
    [ ! -d "$targetPath" ] || catchEnvironment "$handler" rm -rf "$targetPath" || return $?
    ! $verbose || timingReport "$start" "Emptied documentation cache in" || :
    return 0
  fi

  bashDebugInterruptFile

  #
  # Defaults
  #

  [ -n "$companyLink" ] || companyLink="${BUILD_COMPANY_LINK-}"
  [ -n "$applicationName" ] || applicationName="${APPLICATION_NAME-}"
  [ "$seePrefix" != '-' ] || seePrefix="./docs"

  #
  # Check requirements
  #
  [ -n "$companyLink" ] || throwArgument "$handler" "Need --company-link" || return $?
  [ -n "$applicationName" ] || throwArgument "$handler" "Need --name" || return $?
  [ -n "$functionTemplate" ] || throwArgument "$handler" "--function-template required" || return $?
  [ -n "$pageTemplate" ] || throwArgument "$handler" "--page-template required" || return $?
  [ -n "$targetPath" ] || throwArgument "$handler" "--target required" || return $?
  [ 0 -lt "${#sourcePaths[@]}" ] || throwArgument "$handler" "--source required" || return $?

  local start
  start=$(timingStart) || throwEnvironment "$handler" timingStart || return $?

  catchReturn "$handler" __pcregrepInstall || return $?

  if [ "$actionFlag" = "--unlinked-update" ]; then
    for argument in unlinkedTemplate unlinkedTarget; do
      [ -n "${!argument-}" ] || throwArgument "$handler" "$argument is required for $actionFlag" || return $?
    done
  fi
  if [ -n "$unlinkedTemplate" ]; then
    [ -n "$unlinkedTarget" ] || throwArgument "$handler" "--unlinked-target required with --unlinked-template" || return $?
  fi

  #
  # Generate or update indexes
  #
  if [ "$actionFlag" = "--index-update" ] || [ -z "$actionFlag" ]; then
    local elapsed
    elapsed=$(timingStart)
    statusMessage decorate info "Generating source indexes ..."
    __documentationIndexGenerate "$handler" "${indexArgs[@]+${indexArgs[@]}}" "${sourcePaths[@]}" || return $?
    statusMessage --last timingReport "$elapsed" "Indexes took"
    statusMessage timingReport "$start" "Elapsed so far"
  fi

  local clean=()
  local envFile
  envFile=$(fileTemporaryName "$handler") || return $?
  clean+=("$envFile")
  _buildDocumentationGenerateEnvironment "$handler" "$company" "$companyLink" "$applicationName" >"$envFile" || returnClean $? "${clean[@]}" || return $?

  local unlinkedSource="$envFile.unlinkedTemplate"
  if [ -f "$unlinkedTemplate" ]; then
    # First copy
    clean+=("$unlinkedSource")
    catchReturn "$handler" mapEnvironment <"$unlinkedTemplate" >"$unlinkedSource" || returnClean $? "${clean[@]}" || return $?

    if [ "$actionFlag" = "--index-update" ] || [ -z "$actionFlag" ]; then
      if [ "${#unlinkedSources[@]}" -gt 0 ]; then
        # Create or update indexes
        elapsed=$(timingStart)
        statusMessage decorate info "Generating documentation index ..."
        catchReturn "$handler" __documentationIndexDocumentation "$handler" "$cacheDirectory" "${unlinkedSources[@]}" || returnClean $? "${clean[@]}" || return $?
        statusMessage --last timingReport "$elapsed" "Generated documentation index in" || :
      fi
    fi
  fi

  if [ "$actionFlag" = "--docs-update" ] || [ -z "$actionFlag" ]; then
    elapsed=$(timingStart)
    statusMessage decorate info "Compiling templates into documentation source ..."
    __documentationTemplateDirectoryCompile "$handler" "${docArgs[@]+"${docArgs[@]}"}" "$cacheDirectory" "$templatePath" "$functionTemplate" "$targetPath" || returnClean $? "${clean[@]}" || return $?
    statusMessage --last timingReport "$elapsed" "Compiling templates into documentation source took"

  fi
  if [ -n "$unlinkedTarget" ]; then
    if [ "$actionFlag" = "--unlinked-update" ] || [ -z "$actionFlag" ]; then
      ! $verbose || decorate info "Update unlinked document $unlinkedTarget"

      elapsed=$(timingStart)
      statusMessage decorate info "Updating unlinked ..."
      catchReturn "$handler" __documentationIdenticalRepairUnlinked "$cacheDirectory" "$envFile" "$unlinkedTarget" "$unlinkedSource" || returnClean $? "${clean[@]}" || return $?
      statusMessage --last timingReport "$elapsed" "Updated unlinked index in" || :
      catchReturn "$handler" environmentFileLoad "$envFile" --execute __documentationTemplateFileCompile "$handler" "${docArgs[@]+"${docArgs[@]}"}" "$cacheDirectory" "$unlinkedTemplate" "$functionTemplate" "$unlinkedTarget" || returnClean $? "${clean[@]}" || return $?
      if [ "$actionFlag" = "--unlinked-update" ]; then
        printf "\n"
        catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
        return 0
      fi
    fi
  else
    ! $verbose || decorate warning "No --unlinked-template supplied"
  fi

  #
  # {SEE:foo} gets linked in final documentation where it exists (rewrites file currently)
  #
  if [ "$actionFlag" = "--see-update" ] || [ -z "$actionFlag" ]; then
    (
      local functionLinkPattern fileLinkPattern
      catchReturn "$handler" buildEnvironmentLoad BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN || return $?
      functionLinkPattern=${BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN-}
      # Remove line
      fileLinkPattern=${functionLinkPattern%%#.*}

      local seeFunction seeFile seeEnvironment

      seeFunction=$(catchReturn "$handler" documentationTemplate seeFunction) || return $?
      seeFile=$(catchReturn "$handler" documentationTemplate seeFile) || return $?
      seeEnvironment=$(catchReturn "$handler" documentationTemplate seeEnvironment) || return $?

      # Set up templates
      __documentationSeeTokenTemplates "$handler" "$cacheDirectory" \
        "function" "$seeFunction" "$functionLinkPattern" \
        "file" "$seeFile" "$fileLinkPattern" \
        "environment" "$seeEnvironment" "${seeEnvironmentLink#/}" || return $?

      catchReturn "$handler" __documentationIndexSeeLinker "${dd[@]+"${dd[@]}"}" "$cacheDirectory" "${unlinkedSources[0]}" "$seePrefix" || return $?
    ) || returnClean $? "${clean[@]}" || return $?
  fi

  [ "${#clean[@]}" -eq 0 ] || catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  local message

  message=$(catchReturn "$handler" timingReport "$start" "in") || returnClean $? "${clean[@]}" || return $?

  hookRunOptional documentation-complete "$message" || return $?
}

__documentationTemplateFileCompile() {
  local handler="$1" && shift

  local start

  # IDENTICAL startBeginTiming 1
  local start && start=$(timingStart) || return $?

  local cacheDirectory="" sourceFile="" functionTemplate="" targetFile=""
  local forceFlag=false envFiles=() verboseFlag=false

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
    --force) forceFlag=true ;;
    *)
      # Load arguments one-by-one
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory=$(validate "$handler" Directory cacheDirectory "$argument") || return $?
      elif [ -z "$sourceFile" ]; then
        sourceFile="$(validate "$handler" File sourceFile "$argument")" || return $?
      elif [ -z "$functionTemplate" ]; then
        functionTemplate="$(validate "$handler" File functionTemplate "$argument")" || return $?
      elif [ -z "$targetFile" ]; then
        targetFile="$(validate "$handler" FileDirectory targetFile "$argument")" || return $?
      else
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$cacheDirectory" ] || throwArgument "$handler" "Missing cacheDirectory" || return $?
  [ -n "$sourceFile" ] || throwArgument "$handler" "Missing sourceFile" || return $?
  [ -n "$functionTemplate" ] || throwArgument "$handler" "Missing functionTemplate" || return $?
  [ -n "$targetFile" ] || throwArgument "$handler" "Missing targetFile" || return $?

  # Validate arguments
  local base && base="$(basename "$targetFile")" || throwArgument "$handler" basename "$targetFile" || return $?
  base="${base%%.md}"

  local documentTokensFile && documentTokensFile=$(fileTemporaryName "$handler") || return $?
  local clean=("$documentTokensFile")

  local mappedDocumentTemplate && mappedDocumentTemplate=$(fileTemporaryName "$handler") || returnClean $? "${clean[@]}" || return $?
  clean+=("$mappedDocumentTemplate")

  catchReturn "$handler" mapEnvironment <"$sourceFile" >"$mappedDocumentTemplate" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" mapTokens <"$mappedDocumentTemplate" >"$documentTokensFile" || returnClean $? "${clean[@]}" || return $?

  local tokenCount && tokenCount=$(fileLineCount "$documentTokensFile")

  statusMessage decorate info "Generating $(decorate code "$base") ($(decorate info "$(localePluralWord "$tokenCount" token)) ...")"

  # Environment change will affect this template

  # Function template change will affect this template

  local message="No message"
  # As well, document template change will affect this template
  if [ "$tokenCount" -eq 0 ]; then
    message="Empty document"
    if [ ! -f "$targetFile" ] || ! filesAreIdentical "$mappedDocumentTemplate" "$targetFile" >/dev/null; then
      printf "%s (mapped) -> %s %s" "$(decorate warning "$sourceFile")" "$(decorate success "$targetFile")" "$(decorate error "(no tokens found)")"
      catchEnvironment "$handler" cp "$mappedDocumentTemplate" "$targetFile" || returnClean $? "${clean[@]}" || return $?
    fi
  else
    local foundTokens=() findTokens=() checkFiles=() specialTokens=() settingsFiles=() settingsFile
    local home && home=$(catchReturn "$handler" buildHome) || return $?

    local fullTokenName && while read -r fullTokenName; do
      local tokenName && tokenName=$(basename "${fullTokenName//://}")
      if ! environmentVariableNameValid "$tokenName"; then
        specialTokens+=("$tokenName")
        continue
      fi
      if inArray "$fullTokenName" "${foundTokens[@]+"${foundTokens[@]}"}"; then
        continue
      fi
      local compiledFunctionTarget && compiledFunctionTarget="$(__documentationFile "$home" "$fullTokenName" true)"
      [ -f "$compiledFunctionTarget" ] || forceFlag=true
      if settingsFile=$(__functionSettings "$home" "$tokenName"); then
        settingsFiles+=("$tokenName" "$settingsFile")
        foundTokens+=("$fullTokenName")
        checkFiles+=("$settingsFile")
      else
        local sourceCodeFile && if ! sourceCodeFile=$(__documentationIndexLookup "$handler" --source "$tokenName"); then
          decorate warning "Function definition not found $(decorate code "$tokenName")"
          continue
        fi
        foundTokens+=("$fullTokenName")
        findTokens+=("$tokenName" "$sourceCodeFile")
        checkFiles+=("$sourceCodeFile")
      fi
    done <"$documentTokensFile"

    if $forceFlag || fileIsEmpty "$targetFile" || ! fileIsNewest "$targetFile" "${checkFiles[@]+"${checkFiles[@]}"}" "$sourceFile"; then
      message="Generated"
      compiledFunctionEnv=$(fileTemporaryName "$handler") || return $?
      clean+=("$compiledFunctionEnv")
      if [ "${#settingsFiles[@]}" -gt 0 ]; then
        set -- "${settingsFiles[@]}"
        while [ $# -gt 1 ]; do
          tokenName="$1" settingsFile="$2" && shift 2
          local compiledFunctionTarget && compiledFunctionTarget="$(__documentationFile "$home" "$tokenName" true)"
          __documentationTemplateSettingsCompile "$handler" "$settingsFile" "$functionTemplate" | textTrimTail | printfOutputSuffix "\n" >"$compiledFunctionTarget" || returnClean $? "${clean[@]}" || returnMessage $? "$LINENO:${BASH_SOURCE[0]}" "$settingsFile" "$functionTemplate" || return $?
          environmentValueWrite "$tokenName" "$(cat "$compiledFunctionTarget")" >>"$compiledFunctionEnv" || returnClean $? "${clean[@]}" || return $?
        done
      fi
      if [ "${#findTokens[@]}" -gt 0 ]; then
        set -- "${findTokens[@]}"
        while [ $# -gt 1 ]; do
          tokenName="$1" sourceCodeFile="$2" && shift 2
          local compiledFunctionTarget && compiledFunctionTarget="$(__documentationFile "$home" "$tokenName" true)"
          if ! $forceFlag && [ -f "$compiledFunctionTarget" ] && fileIsNewest "$compiledFunctionTarget" "$sourceCodeFile" "$functionTemplate"; then
            statusMessage decorate info "Skip $tokenName and use cache"
            catchReturn "$handler" touch "$compiledFunctionTarget" || return $?
          else
            __documentationTemplateFunctionCompile "$handler" "$tokenName" "$functionTemplate" | textTrimTail | printfOutputSuffix "\n" >"$compiledFunctionTarget" || returnClean $? "${clean[@]}" || returnMessage $? "$LINENO:${BASH_SOURCE[0]}" || return $?
          fi
          environmentValueWrite "$tokenName" "$(cat "$compiledFunctionTarget")" >>"$compiledFunctionEnv" || returnClean $? "${clean[@]}" || returnMessage $? "$LINENO:${BASH_SOURCE[0]}" || return $?
        done
      fi
      IFS=$'\n' read -r -d '' -a tokenNames <"$documentTokensFile" || :
      statusMessage decorate success "Writing $targetFile using $sourceFile (mapped) ..."
      # subshell to hide environment tokens
      (
        set -a # UNDO ok
        #shellcheck source=/dev/null
        source "$compiledFunctionEnv" || throwEnvironment "$handler" "source $compiledFunctionEnv compiled for $targetFile" || return $?
        mapEnvironment "${tokenNames[@]}" <"$mappedDocumentTemplate" >"$targetFile" || returnClean $? "${clean[@]}" || returnMessage $? "$LINENO:${BASH_SOURCE[0]}" || return $?
        set +a # UNDO here
      ) || throwEnvironment "$handler" "mapEnvironment $tokenName" || returnClean $? "${clean[@]}" || return $?
    else
      message="Cached"
    fi
  fi
  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  statusMessage decorate info "$(timingReport "$start" "$message" "$targetFile" in)"
}

__documentationTemplateFunctionCompile() {
  local handler="$1" && shift

  local functionName="" functionTemplate="" envFiles=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --env-file) shift && envFiles+=("$(validate "$handler" File "envFile" "${1-}")") || return $? ;;
    *)
      # Load arguments one-by-one
      if [ -z "$functionName" ]; then
        functionName="$(validate "$handler" String functionName "$argument")" || return $?
      elif [ -z "$functionTemplate" ]; then
        functionTemplate="$(validate "$handler" File functionTemplate "$argument")" || return $?
      else
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  # Validate arguments
  local argument && for argument in functionName functionTemplate; do
    [ -n "${!argument}" ] || throwArgument "$handler" "Requires argument $argument (#${#__saved[@]}: $(decorate each code -- "${__saved[@]}"))" || return $?
  done

  local settingsFile && settingsFile=$(catchReturn "$handler" __documentationIndexLookup "$handler" "$functionName") || return $?
  __documentationTemplateCompile "$handler" "$functionTemplate" "${envFiles[@]+"${envFiles[@]}"}" "$settingsFile" || return $?
}

__documentationTemplateDirectoryCompile() {
  local handler="$1" && shift

  local cacheDirectory="" templateDirectory="" functionTemplate="" targetDirectory=""
  local passArgs=() filterArgs=()
  local verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --force) passArgs+=("$argument") ;;
    --verbose) verboseFlag=true && passArgs+=("$argument") ;;
    --filter) shift && while [ $# -gt 0 ] && [ "$1" != "--" ]; do filterArgs+=("$1") && shift; done ;;
    --env-file) shift && passArgs+=("$argument" "${1-}") ;;
    *)
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory=$(validate "$handler" Directory "cacheDirectory" "$argument") || return $?
      elif [ -z "$templateDirectory" ]; then
        templateDirectory=$(validate "$handler" Directory "templateDirectory" "$argument") || return $?
      elif [ -z "$functionTemplate" ]; then
        functionTemplate=$(validate "$handler" RealFile "functionTemplate" "$argument") || return $?
      elif [ -z "$targetDirectory" ]; then
        targetDirectory=$(validate "$handler" Directory "targetDirectory" "$argument") || return $?
      else
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  # IDENTICAL startBeginTiming 1
  local start && start=$(timingStart) || return $?

  local argument && for argument in cacheDirectory templateDirectory functionTemplate targetDirectory; do
    [ -n "${!argument}" ] || throwArgument "$handler" "Need $argument (#${#__saved[@]}: $(decorate each code -- "${__saved[@]}"))" || return $?
  done

  if $verboseFlag; then
    statusMessage --last decorate pair cacheDirectory "$cacheDirectory"
    decorate pair templateDirectory "$templateDirectory"
    decorate pair functionTemplate "$functionTemplate"
    decorate pair targetDirectory "$targetDirectory"
  fi

  local exitCode=0 fileCount=0
  local templateFile="" && while read -r templateFile; do
    local base="${templateFile#"$templateDirectory/"}"
    [ "$base" != "$templateFile" ] || throwEnvironment "$handler" "templateFile $(decorate file "$templateFile") is not within $(decorate file "$templateDirectory")" || return $?
    local targetFile="$targetDirectory/$base"
    ! $verboseFlag || statusMessage decorate info Compiling "$templateFile"
    if ! documentationTemplateFileCompile "${passArgs[@]+${passArgs[@]}}" "$cacheDirectory" "$templateFile" "$functionTemplate" "$targetFile"; then
      decorate error "Failed to generate $targetFile" 1>&2
      exitCode=1
      break
    fi
    fileCount=$((fileCount + 1))
  done < <(find "$templateDirectory" -type f -name '*.md' ! -path "*/.*/*" ! -name '_*' "${filterArgs[@]+"${filterArgs[@]}"}")
  statusMessage --last timingReport "$start" "Completed generation of $fileCount $(localePlural $fileCount file files) in $(decorate info "$targetDirectory") "
  return $exitCode
}

__documentationTemplateSettingsCompile() {
  local handler="$1" && shift

  local settingsFile="" functionTemplate="" envFiles=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --env-file) shift && envFiles+=("$(validate "$handler" File "envFile" "${1-}")") || return $? ;;
    *)
      # Load arguments one-by-one
      if [ -z "$settingsFile" ]; then
        settingsFile="$(validate "$handler" File settingsFile "$argument")" || return $?
      elif [ -z "$functionTemplate" ]; then
        functionTemplate="$(validate "$handler" File functionTemplate "$argument")" || return $?
      else
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  # Validate arguments
  local argument
  for argument in settingsFile functionTemplate; do
    [ -n "${!argument}" ] || throwArgument "$handler" "Requires argument $argument (#${#__saved[@]}: $(decorate each code -- "${__saved[@]}"))" || return $?
  done

  __documentationTemplateCompile "$handler" "$functionTemplate" "${envFiles[@]+"${envFiles[@]}"}" "$settingsFile" || return $?
}
