#!/usr/bin/env bash
#
# documentationBuild
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

# Build documentation for Bash functions
#
# Given that bash is not an ideal template language, caching is mandatory.
#
# Uses a cache at `buildCacheDirectory`
# See: buildCacheDirectory
#
# Argument: --git - Merge current branch in with `docs` branch
# Argument: --commit - Commit docs to non-docs branch
# Argument: --force - Force generation, ignore cache directives
# Argument: --unlinked - Show unlinked functions
# Argument: --unlinked-update - Update unlinked document file
# Argument: --clean - Erase the cache before starting.
# Argument: --help - I need somebody
# Argument: --company companyName - Optional. Company name (uses `BUILD_COMPANY` if not set)
# Argument: --company-link companyLink - Optional. Company name (uses `BUILD_COMPANY_LINK` if not set)
# Artifact: `cacheDirectory` may be created even on non-zero exit code
# Exit Code: 0 - Success
# Exit Code: 1 - Issue with environment
# Exit Code: 2 - Argument error
documentationBuild() {
  local usage="_${FUNCNAME[0]}"

  local home
  home=$(__catch "$usage" buildHome) || return $?

  local company="" applicationName="" docArgs=() companyLink="" applicationName=""

  local sourcePaths=() cleanFlag=false
  local targetPath="" actionFlag="" unlinkedTemplate="" unlinkedTarget="" actionFlag="" verbose=false pageTemplate=""
  local docArgs=() indexArgs=() templatePath="" company="" applicationName="" functionTemplate="" seePrefix="-"

  # Default option settings
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __throwArgument "$usage" "blank argument" || return $?
    case "$argument" in
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
      company=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --name)
      shift
      applicationName=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --filter)
      docArgs+=("$argument")
      shift
      while [ $# -gt 0 ] && [ "$1" != "--" ]; do docArgs+=("$1") && shift; done
      docArgs+=("--")
      ;;
    --template)
      [ -z "$templatePath" ] || __throwArgument "$usage" "$argument already supplied" || return $?
      shift
      templatePath=$(usageArgumentRealDirectory "$usage" "$argument" "${1-}") || return $?
      ;;
    --page-template)
      [ -z "$pageTemplate" ] || __throwArgument "$usage" "$argument already supplied" || return $?
      shift
      pageTemplate=$(usageArgumentFile "$usage" "$argument" "${1-}") || return $?
      ;;
    --function-template)
      [ -z "$functionTemplate" ] || __throwArgument "$usage" "$argument already supplied" || return $?
      shift
      functionTemplate=$(usageArgumentFile "$usage" "$argument" "${1-}") || return $?
      ;;
    --source)
      shift
      sourcePaths+=("$(usageArgumentRealDirectory "$usage" "$argument" "${1-}")") || return $?
      ;;
    --target)
      shift
      targetPath="$(usageArgumentDirectory "$usage" "$argument" "${1-}")" || return $?
      targetPath="${targetPath#"$home"/}"
      ;;
    --company-link)
      shift
      companyLink=$(usageArgumentString "$usage" "$argument" "${1-}") || return $?
      ;;
    --unlinked-template)
      shift
      unlinkedTemplate=$(usageArgumentFile "$usage" "$argument" "${1-}") || return $?
      ;;
    --unlinked-target)
      shift
      unlinkedTarget=$(usageArgumentFileDirectory "$usage" "$argument" "${1-}") || return $?
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
      [ -z "$actionFlag" ] || __throwArgument "$usage" "$argument and $actionFlag are mutually exclusive" || return $?
      actionFlag="$argument"
      ;;
    --force)
      if ! inArray "$argument" "${docArgs[@]}"; then
        docArgs+=("$argument")
        indexArgs+=("$argument")
      fi
      ;;
    --verbose)
      verbose=true
      if ! inArray "$argument" "${docArgs[@]}"; then
        docArgs+=("$argument")
        indexArgs+=("$argument")
      fi
      ;;
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    *)
      __throwArgument "$usage" "unknown argument $(decorate value "$argument")" || return $?
      ;;
    esac
    shift
  done

  #
  # --clean actually does not require much to run so just handle that first
  #
  local cacheDirectory

  cacheDirectory="$(__catch "$usage" buildCacheDirectory ".${FUNCNAME[0]}/${APPLICATION_CODE-default}/")" || return $?
  echo "$LINENO: cacheDirectory=$cacheDirectory "
  cacheDirectory=$(__catch "$usage" directoryRequire "$cacheDirectory") || return $?
  echo "$LINENO: cacheDirectory=$cacheDirectory "
  if $cleanFlag; then
    __catchEnvironment "$usage" rm -rf "$cacheDirectory" || return $?
    timingReport "$start" "Emptied documentation cache in" || :
    return 0
  fi

  bashDebugInterruptFile

  export BUILD_COLORS_MODE BUILD_COMPANY BUILD_COMPANY_LINK BUILD_HOME APPLICATION_NAME APPLICATION_CODE

  BUILD_COLORS_MODE=$(consoleConfigureColorMode) || :

  __catch "$usage" buildEnvironmentLoad APPLICATION_CODE APPLICATION_NAME BUILD_COMPANY BUILD_COMPANY_LINK || return $?

  #
  # Defaults
  #

  [ -n "$companyLink" ] || companyLink="${BUILD_COMPANY_LINK-}"
  [ -n "$applicationName" ] || applicationName="${APPLICATION_NAME-}"
  [ "$seePrefix" != '-' ] || seePrefix="./docs"

  #
  # Check requirements
  #
  [ -n "$companyLink" ] || __throwArgument "$usage" "Need --company-link" || return $?
  [ -n "$applicationName" ] || __throwArgument "$usage" "Need --name" || return $?
  [ -n "$functionTemplate" ] || __throwArgument "$usage" "--function-template required" || return $?
  [ -n "$pageTemplate" ] || __throwArgument "$usage" "--page-template required" || return $?
  [ -n "$targetPath" ] || __throwArgument "$usage" "--target required" || return $?
  [ 0 -lt "${#sourcePaths[@]}" ] || __throwArgument "$usage" "--source required" || return $?

  local start
  start=$(timingStart) || __throwEnvironment "$usage" timingStart || return $?

  __catch "$usage" __pcregrepInstall || return $?

  local seeFunction seeFile seePrefix

  seeFunction=$(__catch "$usage" documentationTemplate seeFunction) || return $?
  seeFile=$(__catch "$usage" documentationTemplate seeFile) || return $?

  if [ "$actionFlag" = "--unlinked-update" ]; then
    for argument in unlinkedTemplate unlinkedTarget; do
      [ -n "${!argument-}" ] || __throwArgument "$usage" "$argument is required for $actionFlag" || return $?
    done
  fi

  # At this point, everything is valid so we call our failure hook on failure
  usage="__${FUNCNAME[0]}"

  #
  # Generate or update indexes
  #
  for sourcePath in "${sourcePaths[@]}"; do
    __catch "$usage" documentationIndex_Generate "${indexArgs[@]+${indexArgs[@]}}" "$sourcePath" "$cacheDirectory" || return $?
  done

  #
  # Update indexes with function -> documentationPath
  #
  local template
  echo "$LINENO: cacheDirectory=$cacheDirectory "
  find "$templatePath" -type f -name '*.md' ! -path '*/__*' | while read -r template; do
    __catch "$usage" documentationIndex_LinkDocumentationPaths "$cacheDirectory" "$template" "$targetPath${template#"$templatePath"}" || return $?
  done
  statusMessage --last timingReport "$start" "Indexes completed in" || :

  #
  # Build docs
  #
  local clean=()

  if [ -n "$unlinkedTemplate" ]; then
    [ -n "$unlinkedTarget" ] || __throwArgument "$usage" "--unlinked-target required with --unlinked-template" || return $?
    ! $verbose || decorate info "Update unlinked document $unlinkedTarget"
    echo "$LINENO: cacheDirectory=$cacheDirectory "
    local envFile
    envFile=$(_buildDocumentationGenerateEnvironment "$company" "$companyLink" "$applicationName") || return $?
    echo "$LINENO: cacheDirectory=$cacheDirectory "
    __catchEnvironment "$usage" _documentationTemplateUpdateUnlinked "$cacheDirectory" "$envFile" "$unlinkedTemplate" "$unlinkedTarget" "$pageTemplate" || return $?
    docArgs+=(--env-file "$envFile")
    if [ "$actionFlag" = "--unlinked-update" ]; then
      __catchEnvironment rm -rf "$envFile" || return $?
      printf "\n"
      return 0
    fi
    clean+=("$envFile")
  else
    ! $verbose || decorate warning "No --unlinked-template supplied"
  fi

  __catch "$usage" documentationTemplateDirectoryCompile "${docArgs[@]+"${docArgs[@]}"}" "$cacheDirectory" "$templatePath" "$functionTemplate" "$targetPath" || returnClean $? "${clean[@]+"${clean[@]}"}" || return $?
  [ ${#clean[@]} -eq 0 ] || __catchEnvironment "$usage" rm -rf "${clean[@]}" || return $?
  clean=()

  #
  # {SEE:foo} gets linked in final documentation where it exists (rewrites file currently)
  #
  (
    local functionLinkPattern fileLinkPattern
    __catch "$usage" buildEnvironmentLoad BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN || return $?
    functionLinkPattern=${BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN-}
    # Remove line
    fileLinkPattern=${functionLinkPattern%%#.*}
    __catch "$usage" documentationIndex_SeeLinker "$cacheDirectory" "$seePrefix" "$seeFunction" "$functionLinkPattern" "$seeFile" "$fileLinkPattern" || return $?
  ) || return $?
  message=$(__catch "$usage" timingReport "$start" "in") || return $?
  hookRunOptional documentation-complete "$message" || return $?
}
_documentationBuild() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__documentationBuild() {
  hookRunOptional documentation-error "$@" || :
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the cache directory for the documentation
# Argument: suffix - String. Optional. Directory suffix - created if does not exist.
documentationBuildCache() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local code
  code=$(__catch "$usage" buildEnvironmentGet "APPLICATION_CODE") || return $?
  __catch "$usage" buildCacheDirectory ".documentationBuild/${code-default}/${1-}" || return $?
}
_documentationBuildCache() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
