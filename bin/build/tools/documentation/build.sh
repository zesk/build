#!/usr/bin/env bash
#
# documentationBuild
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
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
  local cacheDirectory start docArgs indexArgs=()
  local functionLinkPattern fileLinkPattern documentationTemplate
  local start envFile verbose
  local company companyLink home applicationName
  local templatePath sourcePaths targetPath actionFlag unlinkedTemplate unlinkedTarget seeFunction seeFile seePrefix
  local pageTemplate functionTemplate cleanFlag=false

  export BUILD_COLORS_MODE BUILD_COMPANY BUILD_COMPANY_LINK BUILD_HOME APPLICATION_NAME APPLICATION_CODE

  BUILD_COLORS_MODE=$(consoleConfigureColorMode) || :

  __usageEnvironment "$usage" buildEnvironmentLoad APPLICATION_CODE APPLICATION_NAME BUILD_COMPANY BUILD_COMPANY_LINK || return $?

  home=$(__usageEnvironment "$usage" buildHome) || return $?
  __usageEnvironment "$usage" packageWhich pcregrep pcregrep || return $?

  start=$(beginTiming) || __failEnvironment "$usage" beginTiming || return $?

  cacheDirectory="$(__usageEnvironment "$usage" buildCacheDirectory ".${FUNCNAME[0]}/${APPLICATION_CODE-default}/")" || return $?
  cacheDirectory=$(__usageEnvironment "$usage" requireDirectory "$cacheDirectory") || return $?
  seeFunction=$(__usageEnvironment "$usage" documentationTemplate seeFunction) || return $?
  seeFile=$(__usageEnvironment "$usage" documentationTemplate seeFile) || return $?
  seePrefix="./docs"

  company=${BUILD_COMPANY-}
  companyLink=${BUILD_COMPANY_LINK-}
  applicationName="${APPLICATION_NAME-}"
  sourcePaths=()
  targetPath=
  actionFlag=
  unlinkedTemplate=
  unlinkedTarget=
  actionFlag=
  verbose=false
  pageTemplate=
  functionTemplate=
  # Default option settings
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
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
      --template)
        [ -z "$templatePath" ] || __failArgument "$usage" "$argument already supplied" || return $?
        shift
        templatePath=$(usageArgumentRealDirectory "$usage" "$argument" "${1-}")
        ;;
      --page-template)
        [ -z "$pageTemplate" ] || __failArgument "$usage" "$argument already supplied" || return $?
        shift
        pageTemplate=$(usageArgumentFile "$usage" "$argument" "${1-}")
        ;;
      --function-template)
        [ -z "$functionTemplate" ] || __failArgument "$usage" "$argument already supplied" || return $?
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
        [ -z "$actionFlag" ] || __failArgument "$usage" "$argument and $actionFlag are mutually exclusive" || return $?
        actionFlag="$argument"
        ;;
      --force)
        if ! inArray "$argument" "${docArgs[@]}"; then
          docArgs+=("$argument")
        fi
        ;;
      --verbose)
        verbose=true
        ;;
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        __failArgument "$usage" "unknown argument $(decorate value "$argument")" || return $?
        ;;
    esac
    shift
  done

  if $cleanFlag; then
    __usageEnvironment "$usage" rm -rf "$cacheDirectory" || return $?
    reportTiming "$start" "Emptied documentation cache in" || :
    return 0
  fi
  cacheDirectory=$(requireDirectory "$cacheDirectory") || __failEnvironment "$usage" "Unable to create $cacheDirectory" || return $?

  [ -n "$functionTemplate" ] || __failArgument "$usage" "--function-template required" || return $?
  [ -n "$pageTemplate" ] || __failArgument "$usage" "--page-template required" || return $?
  [ -n "$targetPath" ] || __failArgument "$usage" "--target required" || return $?
  [ 0 -lt "${#sourcePaths[@]}" ] || __failArgument "$usage" "--source required" || return $?

  if [ "$actionFlag" = "--unlinked-update" ]; then
    for argument in unlinkedTemplate unlinkedTarget; do
      [ -n "${!argument-}" ] || __failArgument "$usage" "$argument is required for $actionFlag" || return $?
    done
  fi

  #
  # Generate or update indexes
  #
  for sourcePath in "${sourcePaths[@]}"; do
    __usageEnvironment "$usage" documentationIndex_Generate "${indexArgs[@]+${indexArgs[@]}}" "$sourcePath" "$cacheDirectory" || return $?
  done

  #
  # Update indexes with function -> documentationPath
  #
  find "$templatePath" -type f -name '*.md' ! -path '*/__*' | while read -r documentationTemplate; do
    __usageEnvironment "$usage" documentationIndex_LinkDocumentationPaths "$cacheDirectory" "$documentationTemplate" "$targetPath${documentationTemplate#"$templatePath"}" || return $?
  done
  statusMessage --last reportTiming "$start" "Indexes completed in" || :

  #
  # Build docs
  #

  if [ -n "$unlinkedTemplate" ]; then
    [ -n "$unlinkedTarget" ] || __failArgument "$usage" "--unlinked-target required with --unlinked-template" || return $?
    ! $verbose || decorate info "Update unlinked document $unlinkedTarget"
    envFile=$(_buildDocumentationGenerateEnvironment "$company" "$companyLink" "$applicationName") || return $?
    __usageEnvironment "$usage" _documentationTemplateUpdateUnlinked "$cacheDirectory" "$envFile" "$unlinkedTemplate" "$unlinkedTarget" "$pageTemplate" || return $?
    if [ "$actionFlag" = "--unlinked-update" ]; then
      printf "\n"
      return 0
    fi
  else
    ! $verbose || decorate warning "No --unlinked-template supplied"
  fi

  __usageEnvironment "$usage" documentationTemplateDirectoryCompile --env-file "$envFile" "$cacheDirectory" "$templatePath" "$functionTemplate" "$targetPath" || _clean $? "$envFile" || return $?

  #
  # {SEE:foo} gets linked in final documentation where it exists (rewrites file currently)
  #
  (
    __usageEnvironment "$usage" buildEnvironmentLoad BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN || return $?
    functionLinkPattern=${BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN-}
    # Remove line
    fileLinkPattern=${functionLinkPattern%%#.*}
    __usageEnvironment "$usage" documentationIndex_SeeLinker "$cacheDirectory" "$seePrefix" "$seeFunction" "$functionLinkPattern" "$seeFile" "$fileLinkPattern" || return $?
  ) || return $?
  reportTiming "$start" "Completed in" || :
}
_documentationBuild() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
