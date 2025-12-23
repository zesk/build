#!/usr/bin/env bash
#
# documentationBuild
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

__documentationBuild() {
  local handler="$1" && shift

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

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
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) dd=(--debug) ;;
    --git)
      _buildDocumentation_MergeWithDocsBranch
      return $?
      ;;
    --commit)
      _buildDocumentation_Recommit
      return $?
      ;;
    --company)
      shift
      company=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --name)
      shift
      applicationName=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --filter)
      docArgs+=("$argument")
      shift
      while [ $# -gt 0 ] && [ "$1" != "--" ]; do docArgs+=("$1") && shift; done
      docArgs+=("--")
      ;;
    --template)
      [ -z "$templatePath" ] || throwArgument "$handler" "$argument already supplied" || return $?
      shift
      templatePath=$(usageArgumentRealDirectory "$handler" "$argument" "${1-}") || return $?
      ;;
    --page-template)
      [ -z "$pageTemplate" ] || throwArgument "$handler" "$argument already supplied" || return $?
      shift
      pageTemplate=$(usageArgumentFile "$handler" "$argument" "${1-}") || return $?
      ;;
    --function-template)
      [ -z "$functionTemplate" ] || throwArgument "$handler" "$argument already supplied" || return $?
      shift
      functionTemplate=$(usageArgumentFile "$handler" "$argument" "${1-}") || return $?
      ;;
    --source)
      shift
      sourcePaths+=("$(usageArgumentRealDirectory "$handler" "$argument" "${1-}")") || return $?
      ;;
    --target)
      shift
      targetPath="$(usageArgumentDirectory "$handler" "$argument" "${1-}")" || return $?
      targetPath="${targetPath#"$home"/}"
      ;;
    --company-link)
      shift
      companyLink=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --unlinked-source)
      shift
      unlinkedSources+=("$(usageArgumentDirectory "$handler" "$argument" "${1-}")") || return $?
      ;;
    --unlinked-template)
      shift
      unlinkedTemplate=$(usageArgumentFile "$handler" "$argument" "${1-}") || return $?
      ;;
    --unlinked-target)
      shift
      unlinkedTarget=$(usageArgumentFileDirectory "$handler" "$argument" "${1-}") || return $?
      ;;
    --clean)
      indexArgs+=("$argument")
      cleanFlag=true
      ;;
    --see-prefix)
      shift
      seePrefix="${1-}"
      ;;
    --see-environment-link)
      shift
      seeEnvironmentLink=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
      ;;
    --force)
      if [ ${#docArgs[@]} -eq 0 ] || ! inArray "$argument" "${docArgs[@]}"; then
        docArgs+=("$argument")
      fi
      ;;
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
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  export BUILD_COLORS_MODE BUILD_COMPANY BUILD_COMPANY_LINK BUILD_HOME APPLICATION_NAME APPLICATION_CODE

  BUILD_COLORS_MODE=$(consoleConfigureColorMode) || :

  catchReturn "$handler" buildEnvironmentLoad APPLICATION_CODE APPLICATION_NAME BUILD_COMPANY BUILD_COMPANY_LINK || return $?

  #
  # --clean actually does not require much to run so just handle that first
  #
  local cacheDirectory

  cacheDirectory="$(catchReturn "$handler" documentationBuildCache)" || return $?
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
    catchReturn "$handler" _documentationIndexGenerate "${indexArgs[@]+${indexArgs[@]}}" "${sourcePaths[@]}" || return $?
    statusMessage --last timingReport "$elapsed" "Indexes took"
    statusMessage timingReport "$start" "Elapsed so far"
  fi

  local clean=()
  local envFile
  envFile=$(fileTemporaryName "$handler") || return $?
  clean+=("$envFile")
  _buildDocumentationGenerateEnvironment "$handler" "$company" "$companyLink" "$applicationName" >"$envFile" || returnClean $? "${clean[@]}" || return $?

  if [ -f "$unlinkedTemplate" ]; then
    if [ "$actionFlag" = "--index-update" ] || [ -z "$actionFlag" ]; then
      # First copy
      catchReturn "$handler" mapEnvironment <"$unlinkedTemplate" >"$unlinkedTarget" || returnClean $? "${clean[@]}" || return $?

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
  if [ -n "$unlinkedTemplate" ]; then
    if [ "$actionFlag" = "--unlinked-update" ] || [ -z "$actionFlag" ]; then
      ! $verbose || decorate info "Update unlinked document $unlinkedTarget"

      elapsed=$(timingStart)
      statusMessage decorate info "Updating unlinked ..."
      catchReturn "$handler" __documentationTemplateUpdateUnlinked "$cacheDirectory" "$envFile" "$unlinkedTemplate" "$unlinkedTarget" "$pageTemplate" || returnClean $? "${clean[@]}" || return $?
      statusMessage --last timingReport "$elapsed" "Updated unlinked index in" || :
      catchReturn "$handler" environmentFileLoad "$envFile" --execute documentationTemplateCompile "${docArgs[@]+"${docArgs[@]}"}" "$cacheDirectory" "$unlinkedTemplate" "$functionTemplate" "$unlinkedTarget" || returnClean $? "${clean[@]}" || return $?
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
