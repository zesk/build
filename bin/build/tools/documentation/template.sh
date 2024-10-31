#!/usr/bin/env bash
#
# documentation/template.sh
#
# Building documentation
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

# Map template files using our identical functionality
# Usage: {fn} templatePath repairPath
documentationTemplateUpdate() {
  local templatePath="$1" repairArgs=() failCount

  shift
  while [ $# -gt 0 ]; do
    repairArgs+=("--repair" "$1")
    shift
  done
  failCount=0
  while ! identicalCheck "${repairArgs[@]}" --extension md --prefix '<!-- TEMPLATE' --cd "$templatePath"; do
    failCount=$((failCount + 1))
    if [ $failCount -gt 4 ]; then
      __usageEnvironment "$usage" "identicalCheck --repair failed" || return $?
    fi
  done
}
_documentationTemplateUpdate() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Usage: {fn} cacheDirectory envFile unlinkedTemplateFile unlinkedTarget pageTemplateFile [ todoTemplateCode ]
# Argument: cacheDirectory - Required. Directory. Cache directory.
# Argument: envFile - Required. File. Environment file used as base environment for all template generation.
# Argument: template - Required. File. Final template file.
# Argument: target - Required. FileDirectory. Path to documentationPath.
# - Argument: pageTemplate - Required. File. Environment file used as base environment for all template generation.
# Argument: todoTemplateCode - Optional. File. Template code for template.
#
_documentationTemplateUpdateUnlinked() {
  local usage="_${FUNCNAME[0]}"
  local cacheDirectory envFile template target unlinkedFunctions todoTemplate template total clean content

  clean=()
  cacheDirectory=$(usageArgumentDirectory "$usage" "cacheDirectory" "${1-}") || return $?
  envFile=$(usageArgumentFile "$usage" "envFile" "${2-}") || return $?
  template=$(usageArgumentFile "$usage" "template" "${3-}") || return $?
  target=$(usageArgumentFileDirectory "$usage" "target" "${4-}") || return $?
  pageTemplate=$(usageArgumentFile "$usage" "pageTemplate" "${5-}") || return $?
  todoTemplate=$(__usageEnvironment "$usage" documentationTemplate "${6-todo}") || return $?

  unlinkedFunctions=$(__usageEnvironment "$usage" mktemp) || return $?
  clean+=("$unlinkedFunctions")
  documentationIndex_SetUnlinkedDocumentationPath "$cacheDirectory" "$target" | IFS="" awk '{ print "{" $1 "}" }' >"$unlinkedFunctions" || __failEnvironment "$usage" "Unable to documentationIndex_SetUnlinkedDocumentationPath" || _clean $? "${clean[@]}" || return $?
  total=$(wc -l <"$unlinkedFunctions" | trimSpace)

  # Subshell hide globals
  (
    content="$(sort <"$unlinkedFunctions")"
    content=$content total=$total mapEnvironment content total <"$todoTemplate" >"$template.$$"
  ) || _clean $? "${clean[@]}" || return $?

  __usageEnvironment "$usage" rm -rf "${clean[@]}" || return $?

  if [ -f "$template" ] && diff -q "$template" "$template.$$" >/dev/null; then
    statusMessage decorate info "Not updating $template - unchanged $total unlinked $(plural "$total" function functions)"
    __usageEnvironment "$usage" rm -f "$template.$$" || return $?
  else
    __usageEnvironment "$usage" mv -f "$template.$$" "$template" || return $?
    statusMessage decorate info "Updated $template with $total unlinked $(plural "$total" function functions)"
  fi
}
__documentationTemplateUpdateUnlinked() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Just merge into docs branch
#
_buildDocumentation_MergeWithDocsBranch() {
  local branch
  local this="${FUNCNAME[0]}"
  local usage="_$this"

  branch=$(gitCurrentBranch) || __failEnvironment "$usage" gitCurrentBranch || return $?
  if [ "$branch" = "docs" ]; then
    __failEnvironment "$usage" "Already on docs branch" || return $?
  fi
  __usageEnvironment "$usage" git checkout docs || return $?
  __usageEnvironment "$usage" git merge -m "$this" "$branch" || return $?
  __usageEnvironment "$usage" git push || return $?
  __usageEnvironment "$usage" git checkout "$branch" || return $?
}
__buildDocumentation_MergeWithDocsBranch() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Just merge into docs branch
#
_buildDocumentation_Recommit() {
  local branch
  local usage

  usage="_${FUNCNAME[0]}"

  branch=$(gitCurrentBranch) || __failEnvironment "$usage" gitCurrentBranch || return $?
  if [ "$branch" = "docs" ]; then
    __failEnvironment "$usage" "Already on docs branch" || return $?
  fi
  if gitRepositoryChanged; then
    statusMessage decorate warning "Committing to branch $branch ..."
    __usageEnvironment "$usage" git commit -m "Updated docs in pipeline on $(date +"%F %T")" -a || return $?
    statusMessage decorate info "Pushing branch $branch ..."
    __usageEnvironment "$usage" git push || return $?
    statusMessage decorate success "Documentation committed"
  else
    decorate info "Branch $branch is unchanged"
  fi
}
__buildDocumentation_Recommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_buildDocumentationGenerateEnvironment() {
  export APPLICATION_NAME
  buildEnvironmentLoad APPLICATION_NAME || :
  envFile=$(mktemp) || __failEnvironment "$usage" "mktemp failed" || return $?
  {
    __dumpNameValue summary "{fn}"
    __dumpNameValue vendor "$1"
    __dumpNameValue APPLICATION_NAME "$3"
    __dumpNameValue BUILD_COMPANY "$1"
    __dumpNameValue vendorLink "$2"
    __dumpNameValue BUILD_COMPANY_LINK "$2"

    __dumpNameValue year "$(date +%Y)"
  } >>"$envFile" || __failEnvironment "$usage" "Saving to $envFile failed" || return $?
  printf "%s\n" "$envFile"
}

# Get an internal template name
documentationTemplate() {
  local source="${BASH_SOURCE[0]%/*}"
  local template="$source/__${1-}.md"

  [ -f "$template" ] || _argument "No template \"${1-}\" at $template" || return $?
  printf "%s\n" "$template"
}

# List unlinked functions in documentation index
documentationUnlinked() {
  local usage="_${FUNCNAME[0]}"
  local cacheDirectory

  cacheDirectory="$(__usageEnvironment "$usage" buildCacheDirectory)" || return $?
  cacheDirectory=$(__usageEnvironment "$usage" requireDirectory "$cacheDirectory") || return $?

  __usageEnvironment "$usage" documentationIndex_ShowUnlinked "$cacheDirectory" || return $?
}
_documentationUnlinked() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Build documentation for Bash functions
#
# Given that bash is not an ideal template language, caching is mandatory.
#
# Uses a cache at `buildCacheDirectory`
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
  clearLine || :
  reportTiming "$start" "Indexes completed in" || :

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
  clearLine || :

  __usageEnvironment "$usage" documentationTemplateDirectoryCompile --env "$envFile" "$cacheDirectory" "$templatePath" "$functionTemplate" "$targetPath" || _clean $? "$envFile" || return $?

  #
  # {SEE:foo} gets linked in final documentation where it exists (rewrites file currently)
  #
  (
    # shellcheck source=/dev/null
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
