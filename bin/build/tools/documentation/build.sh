#!/usr/bin/env bash
#
# documentationBuild
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/documentation.md
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
  local cacheDirectory start indexArgs=()
  local functionLinkPattern fileLinkPattern documentationTemplate
  local home

  export BUILD_COLORS_MODE BUILD_COMPANY BUILD_COMPANY_LINK BUILD_HOME APPLICATION_NAME APPLICATION_CODE

  BUILD_COLORS_MODE=$(consoleConfigureColorMode) || :

  __catchEnvironment "$usage" buildEnvironmentLoad APPLICATION_CODE APPLICATION_NAME BUILD_COMPANY BUILD_COMPANY_LINK || return $?

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  __catchEnvironment "$usage" packageWhich pcregrep pcregrep || return $?

  local start
  start=$(beginTiming) || __throwEnvironment "$usage" beginTiming || return $?

  local seeFunction seeFile seePrefix

  cacheDirectory="$(__catchEnvironment "$usage" buildCacheDirectory ".${FUNCNAME[0]}/${APPLICATION_CODE-default}/")" || return $?
  cacheDirectory=$(__catchEnvironment "$usage" requireDirectory "$cacheDirectory") || return $?
  seeFunction=$(__catchEnvironment "$usage" documentationTemplate seeFunction) || return $?
  seeFile=$(__catchEnvironment "$usage" documentationTemplate seeFile) || return $?
  seePrefix="./docs"

  local company=${BUILD_COMPANY-} companyLink=${BUILD_COMPANY_LINK-} applicationName="${APPLICATION_NAME-}"
  local sourcePaths=() cleanFlag=false
  local targetPath="" actionFlag="" unlinkedTemplate="" unlinkedTarget="" actionFlag="" verbose=false pageTemplate=""
  local docArgs=() templatePath="" company="" applicationName="" functionTemplate=""

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
        company=$(usageArgumentString "$usage" "$argument" "${1-}")
        ;;
      --name)
        shift
        applicationName=$(usageArgumentString "$usage" "$argument" "${1-}")
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
        templatePath=$(usageArgumentRealDirectory "$usage" "$argument" "${1-}")
        ;;
      --page-template)
        [ -z "$pageTemplate" ] || __throwArgument "$usage" "$argument already supplied" || return $?
        shift
        pageTemplate=$(usageArgumentFile "$usage" "$argument" "${1-}")
        ;;
      --function-template)
        [ -z "$functionTemplate" ] || __throwArgument "$usage" "$argument already supplied" || return $?
        shift
        functionTemplate=$(usageArgumentFile "$usage" "$argument" "${1-}")
        ;;
      --source)
        shift
        sourcePaths+=("$(usageArgumentRealDirectory "$usage" "$argument" "${1-}")")
        ;;
      --target)
        shift
        targetPath="$(usageArgumentDirectory "$usage" "$argument" "${1-}")"
        targetPath="${targetPath#"$home"/}"
        ;;
      --company-link)
        shift
        companyLink=$(usageArgumentString "$usage" "$argument" "${1-}")
        ;;
      --unlinked-template)
        shift
        unlinkedTemplate=$(usageArgumentFile "$usage" "$argument" "${1-}")
        ;;
      --unlinked-target)
        shift
        unlinkedTarget=$(usageArgumentFileDirectory "$usage" "$argument" "${1-}")
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
  bashDebugInterruptFile
  if $cleanFlag; then
    __catchEnvironment "$usage" rm -rf "$cacheDirectory" || return $?
    reportTiming "$start" "Emptied documentation cache in" || :
    return 0
  fi
  cacheDirectory=$(requireDirectory "$cacheDirectory") || __throwEnvironment "$usage" "Unable to create $cacheDirectory" || return $?

  [ -n "$functionTemplate" ] || __throwArgument "$usage" "--function-template required" || return $?
  [ -n "$pageTemplate" ] || __throwArgument "$usage" "--page-template required" || return $?
  [ -n "$targetPath" ] || __throwArgument "$usage" "--target required" || return $?
  [ 0 -lt "${#sourcePaths[@]}" ] || __throwArgument "$usage" "--source required" || return $?

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
    __catchEnvironment "$usage" documentationIndex_Generate "${indexArgs[@]+${indexArgs[@]}}" "$sourcePath" "$cacheDirectory" || return $?
  done

  #
  # Update indexes with function -> documentationPath
  #
  find "$templatePath" -type f -name '*.md' ! -path '*/__*' | while read -r documentationTemplate; do
    __catchEnvironment "$usage" documentationIndex_LinkDocumentationPaths "$cacheDirectory" "$documentationTemplate" "$targetPath${documentationTemplate#"$templatePath"}" || return $?
  done
  statusMessage --last reportTiming "$start" "Indexes completed in" || :

  #
  # Build docs
  #
  local clean=()

  if [ -n "$unlinkedTemplate" ]; then
    [ -n "$unlinkedTarget" ] || __throwArgument "$usage" "--unlinked-target required with --unlinked-template" || return $?
    ! $verbose || decorate info "Update unlinked document $unlinkedTarget"
    local envFile
    envFile=$(_buildDocumentationGenerateEnvironment "$company" "$companyLink" "$applicationName") || return $?
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

  __catchEnvironment "$usage" __echo documentationTemplateDirectoryCompile "${docArgs[@]+"${docArgs[@]}"}" "$cacheDirectory" "$templatePath" "$functionTemplate" "$targetPath" || _clean $? "${clean[@]+"${clean[@]}"}" || return $?
  [ ${#clean[@]} -eq 0 ] || __catchEnvironment "$usage" rm -rf "${clean[@]}" || return $?
  clean=()

  #
  # {SEE:foo} gets linked in final documentation where it exists (rewrites file currently)
  #
  (
    __catchEnvironment "$usage" buildEnvironmentLoad BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN || return $?
    functionLinkPattern=${BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN-}
    # Remove line
    fileLinkPattern=${functionLinkPattern%%#.*}
    __catchEnvironment "$usage" documentationIndex_SeeLinker "$cacheDirectory" "$seePrefix" "$seeFunction" "$functionLinkPattern" "$seeFile" "$fileLinkPattern" || return $?
  ) || return $?
  message=$(__catchEnvironment "$usage" reportTiming "$start" "in") || return $?
  hookRunOptional documentation-complete "$message" || return $?
}
_documentationBuild() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__documentationBuild() {
  hookRunOptional documentation-error "$@" || :
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Argument: suffix - String. Optional. Directory suffix - created if does not exist.
documentationBuildCache() {
  local code
  code=$(buildEnvironmentGet "APPLICATION_CODE") || return $?
  buildCacheDirectory ".documentationBuild/${code-default}/${1-}"
}
_documentationBuildCache() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
