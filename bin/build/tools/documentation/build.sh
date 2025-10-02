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
  home=$(__catch "$handler" buildHome) || return $?

  local company="" applicationName="" docArgs=() companyLink="" applicationName=""

  local sourcePaths=() cleanFlag=false
  local targetPath="" actionFlag="" unlinkedTemplate="" unlinkedTarget="" actionFlag="" verbose=false pageTemplate=""
  local indexArgs=() templatePath="" company="" applicationName="" functionTemplate="" seePrefix="-"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
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
      [ -z "$templatePath" ] || __throwArgument "$handler" "$argument already supplied" || return $?
      shift
      templatePath=$(usageArgumentRealDirectory "$handler" "$argument" "${1-}") || return $?
      ;;
    --page-template)
      [ -z "$pageTemplate" ] || __throwArgument "$handler" "$argument already supplied" || return $?
      shift
      pageTemplate=$(usageArgumentFile "$handler" "$argument" "${1-}") || return $?
      ;;
    --function-template)
      [ -z "$functionTemplate" ] || __throwArgument "$handler" "$argument already supplied" || return $?
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
    --unlinked-update)
      [ -z "$actionFlag" ] || __throwArgument "$handler" "$argument and $actionFlag are mutually exclusive" || return $?
      actionFlag="$argument"
      ;;
    --force)
      if [ ${#docArgs[@]} -eq 0 ] || ! inArray "$argument" "${docArgs[@]}"; then
        docArgs+=("$argument")
      fi
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
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  export BUILD_COLORS_MODE BUILD_COMPANY BUILD_COMPANY_LINK BUILD_HOME APPLICATION_NAME APPLICATION_CODE

  BUILD_COLORS_MODE=$(consoleConfigureColorMode) || :

  __catch "$handler" buildEnvironmentLoad APPLICATION_CODE APPLICATION_NAME BUILD_COMPANY BUILD_COMPANY_LINK || return $?

  #
  # --clean actually does not require much to run so just handle that first
  #
  local cacheDirectory

  cacheDirectory="$(__catch "$handler" documentationBuildCache)" || return $?
  if $cleanFlag; then
    __catchEnvironment "$handler" rm -rf "$cacheDirectory" || return $?
    [ ! -d "$targetPath" ] || __catchEnvironment "$handler" rm -rf "$targetPath" || return $?
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
  [ -n "$companyLink" ] || __throwArgument "$handler" "Need --company-link" || return $?
  [ -n "$applicationName" ] || __throwArgument "$handler" "Need --name" || return $?
  [ -n "$functionTemplate" ] || __throwArgument "$handler" "--function-template required" || return $?
  [ -n "$pageTemplate" ] || __throwArgument "$handler" "--page-template required" || return $?
  [ -n "$targetPath" ] || __throwArgument "$handler" "--target required" || return $?
  [ 0 -lt "${#sourcePaths[@]}" ] || __throwArgument "$handler" "--source required" || return $?

  local start
  start=$(timingStart) || __throwEnvironment "$handler" timingStart || return $?

  __catch "$handler" __pcregrepInstall || return $?

  local seeFunction seeFile seePrefix

  seeFunction=$(__catch "$handler" documentationTemplate seeFunction) || return $?
  seeFile=$(__catch "$handler" documentationTemplate seeFile) || return $?

  if [ "$actionFlag" = "--unlinked-update" ]; then
    for argument in unlinkedTemplate unlinkedTarget; do
      [ -n "${!argument-}" ] || __throwArgument "$handler" "$argument is required for $actionFlag" || return $?
    done
  fi
  if [ -n "$unlinkedTemplate" ]; then
    [ -n "$unlinkedTarget" ] || __throwArgument "$handler" "--unlinked-target required with --unlinked-template" || returnClean $? "${clean[@]}" || return $?
  fi

  #
  # Generate or update indexes
  #
  local elapsed
  elapsed=$(timingStart)
  statusMessage decorate info "Generating source indexes ..."
  __catch "$handler" _documentationIndex_Generate "${indexArgs[@]+${indexArgs[@]}}" "$cacheDirectory" "${sourcePaths[@]}" || return $?
  statusMessage --last timingReport "$elapsed" "Indexes took"
  statusMessage timingReport "$start" "Elapsed so far"

  local envFile clean=()
  envFile=$(fileTemporaryName "$handler") || return $?
  _buildDocumentationGenerateEnvironment "$handler" "$company" "$companyLink" "$applicationName" >"$envFile" || returnClean $? "$envFile" || return $?
  clean+=("$envFile")

  if [ -f "$unlinkedTemplate" ]; then
    # First copy
    __catchEnvironment "$handler" mapEnvironment <"$unlinkedTemplate" >"$unlinkedTarget" || return $?
  fi

  elapsed=$(timingStart)
  statusMessage decorate info "Compiling templates into documentation source ..."
  __catch "$handler" documentationTemplateDirectoryCompile "${docArgs[@]+"${docArgs[@]}"}" "$cacheDirectory" "$templatePath" "$functionTemplate" "$targetPath" || returnClean $? "${clean[@]}" || return $?
  statusMessage --last timingReport "$elapsed" "Compiling templates into documentation source took"

  # Create or update indexes
  elapsed=$(timingStart)
  statusMessage decorate info "Generating documentation index ..."
  __catch "$handler" _documentationIndex_DocumentationIndex "$cacheDirectory" "$targetPath" || returnClean $? "${clean[@]}" || return $?
  statusMessage --last timingReport "$elapsed" "Generated documentation index in" || :

  if [ -n "$unlinkedTemplate" ]; then
    ! $verbose || decorate info "Update unlinked document $unlinkedTarget"

    elapsed=$(timingStart)
    statusMessage decorate info "Updating unlinked ..."
    __catch "$handler" __documentationTemplateUpdateUnlinked "$cacheDirectory" "$envFile" "$unlinkedTemplate" "$unlinkedTarget" "$pageTemplate" || returnClean $? "${clean[@]}" || return $?
    statusMessage --last timingReport "$elapsed" "Updated unlinked index in" || :
    __catch "$handler" environmentFileLoad "$envFile" --execute documentationTemplateCompile "${docArgs[@]+"${docArgs[@]}"}" "$cacheDirectory" "$unlinkedTemplate" "$functionTemplate" "$unlinkedTarget" || returnClean $? "${clean[@]}" || return $?
    if [ "$actionFlag" = "--unlinked-update" ]; then
      printf "\n"
      __catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
      return 0
    fi
  else
    ! $verbose || decorate warning "No --unlinked-template supplied"
  fi

  #
  # {SEE:foo} gets linked in final documentation where it exists (rewrites file currently)
  #

  (
    local functionLinkPattern fileLinkPattern
    __catch "$handler" buildEnvironmentLoad BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN || return $?
    functionLinkPattern=${BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN-}
    # Remove line
    fileLinkPattern=${functionLinkPattern%%#.*}
    __catch "$handler" __documentationIndex_SeeLinker "$cacheDirectory" "$seePrefix" "$seeFunction" "$functionLinkPattern" "$seeFile" "$fileLinkPattern" || return $?
  ) || return $?
  message=$(__catch "$handler" timingReport "$start" "in") || return $?

  [ "${#clean[@]}" -eq 0 ] || __catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  hookRunOptional documentation-complete "$message" || return $?
}
