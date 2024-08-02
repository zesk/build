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
_documentationTemplatesUpdate() {
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
      _environment "identicalCheck --repair failed" || return $?
    fi
  done
}

#
# Usage: {fn} cacheDirectory envFile
# Argument: cacheDirectory - Required. Directory. Cache directory.
# Argument: envFile - Required. File. Environment file used as base environment for all template generation.
#
_buildDocumentation_UpdateUnlinked() {
  local argument cacheDirectory envFile unlinkedFunctions template total
  local usage

  usage="_${FUNCNAME[0]}"

  cacheDirectory=
  envFile=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      *)
        if [ -z "$cacheDirectory" ]; then
          cacheDirectory=$(usageArgumentDirectory "$usage" "cacheDirectory" "$argument") || return $?
        elif [ -z "$envFile" ]; then
          envFile=$(usageArgumentFile "$usage" "envFile" "$argument") || return $?
        else
          __failArgument "$usage" "unknown argument $(consoleCode "$argument")" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $(consoleCode "$argument")" || return $?
  done
  [ -n "$envFile" ] || __failArgument "$usage" "missing envFile" || return $?

  unlinkedFunctions=$(mktemp) || __failEnvironment "$usage" mktemp || return $?
  template="./docs/_templates/tools/todo.md"
  documentationIndex_SetUnlinkedDocumentationPath "$cacheDirectory" "./docs/tools/todo.md" | IFS="" awk '{ print "{" $1 "}" }' >"$unlinkedFunctions" || __failEnvironment "$usage" "Unable to documentationIndex_SetUnlinkedDocumentationPath" || return $?
  (
    content="$(cat "./docs/_templates/__todo.md")"$'\n'$'\n'"$(sort <"$unlinkedFunctions")" mapEnvironment content <"./docs/_templates/__main1.md" >"$template.$$"
  ) || return $?
  total=$(wc -l <"$unlinkedFunctions" | trimSpace)
  if [ -f "$template" ] && diff -q "$template" "$template.$$" >/dev/null; then
    statusMessage consoleInfo "Not updating $template - unchanged $total unlinked $(plural "$total" function functions)"
    __usageEnvironment "$usage" rm -f "$template.$$" || return $?
  else
    __usageEnvironment "$usage" mv -f "$template.$$" "$template" || return $?
    statusMessage consoleInfo "Updated $template with $total unlinked $(plural "$total" function functions)"
  fi
  rm -f "$unlinkedFunctions" || :
}
__buildDocumentation_UpdateUnlinked() {
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
    statusMessage consoleWarning "Committing to branch $branch ..."
    __usageEnvironment "$usage" git commit -m "Updated docs in pipeline on $(date +"%F %T")" -a || return $?
    statusMessage consoleInfo "Pushing branch $branch ..."
    __usageEnvironment "$usage" git push || return $?
    statusMessage consoleSuccess "Documentation committed"
  else
    consoleInfo "Branch $branch is unchanged"
  fi
}
__buildDocumentation_Recommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_buildDocumentationGenerateEnvironment() {
  envFile=$(mktemp) || __failEnvironment "$usage" "mktemp failed" || return $?
  {
    __dumpNameValue summary "{fn}"
    __dumpNameValue vendor "$1"
    __dumpNameValue BUILD_COMPANY "$1"
    __dumpNameValue vendorLink "$2"
    __dumpNameValue BUILD_COMPANY_LINK "$2"

    __dumpNameValue year "$(date +%Y)"
  } >>"$envFile" || __failEnvironment "$usage" "Saving to $envFile failed" || return $?
  printf "%s\n" "$envFile"
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
  local cacheDirectory theDirectory start docArgs indexArgs=()
  local functionLinkPattern fileLinkPattern documentTemplate
  local start envFile exitCode
  local company companyLink home
  local templatePath repairPaths sourcePaths targetPath

  export BUILD_COLORS_MODE BUILD_COMPANY BUILD_COMPANY_LINK BUILD_HOME

  BUILD_COLORS_MODE=$(consoleConfigureColorMode) || :

  home=$(__usageEnvironment "$usage" buildHome) || return $?
  __usageEnvironment "$usage" whichApt pcregrep pcregrep || return $?

  exitCode=0
  start=$(beginTiming) || __failEnvironment "$usage" beginTiming || return $?

  cacheDirectory="$(__usageEnvironment "$usage" buildCacheDirectory)" || return $?
  cacheDirectory=$(__usageEnvironment "$usage" requireDirectory "$cacheDirectory") || return $?

  buildEnvironmentLoad BUILD_COMPANY BUILD_COMPANY_LINK || :
  repairPaths=()
  sourcePaths=()
  targetPath=
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
      --template)
        [ -z "$templatePath" ] || __failArgument "$usage" "$argument already supplied" || return $?
        shift
        templatePath=$(usageArgumentRealPath "$usage" "$argument" "${1-}")
        ;;
      --repair)
        shift
        repairPaths+=("$(usageArgumentRealPath "$usage" "$argument" "${1-}")")
        ;;
      --source)
        shift
        sourcePaths+=("$(usageArgumentRealPath "$usage" "$argument" "${1-}")")
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
      --clean)
        indexArgs+=("$argument")
        ;;
      --unlinked)
        documentationIndex_ShowUnlinked "$cacheDirectory" || exitCode=$?
        return $exitCode
        ;;
      --unlinked-update)
        envFile=$(_buildDocumentationGenerateEnvironment "$company" "$companyLink") || return $?
        _buildDocumentation_UpdateUnlinked "$cacheDirectory" "$envFile" || exitCode=$?
        rm -f "$envFile" || :
        printf "\n" || :
        return $exitCode
        ;;
      --force)
        if ! inArray "$argument" "${docArgs[@]}"; then
          docArgs+=("$argument")
        fi
        ;;
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        __failArgument "$usage" "unknown argument $(consoleValue "$argument")" || return $?
        ;;
    esac
    shift
  done
  cacheDirectory=$(requireDirectory "$cacheDirectory") || __failEnvironment "$usage" "Unable to create $cacheDirectory" || return $?

  [ -n "$targetPath" ] || __failArgument "$usage" "--target required" || return $?
  [ 0 -lt "${#sourcePaths[@]}" ] || __failArgument "$usage" "--source required" || return $?

  if [ "${#repairPaths[@]}" -gt 0 ]; then
    __usageEnvironment "$usage" _documentationTemplatesUpdate "$templatePath" "${repairPaths[@]}" || return $?
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
  find "$templatePath" -type f -name '*.md' ! -path '*/__*' | while read -r documentTemplate; do
    __usageEnvironment "$usage" documentationIndex_LinkDocumentationPaths "$cacheDirectory" "$documentTemplate" "$targetPath${documentTemplate#"$templatePath"}" || return $?
  done
  clearLine || :
  reportTiming "$start" "Indexes completed in" || :

  #
  # Build docs
  #

  # Update unlinked document
  envFile=$(_buildDocumentationGenerateEnvironment "$company" "$companyLink") || return $?
  __usageEnvironment "$usage" _buildDocumentation_UpdateUnlinked "$cacheDirectory" "$envFile" || return $?
  clearLine || :

  docArgs=()
  docArgs+=(--env "$envFile")

  while read -r theDirectory theTemplate; do
    __usageEnvironment "$usage" documentationtemplatePathCompile "${docArgs[@]}" \
      "$cacheDirectory" "./docs/_templates/$theDirectory/" "./docs/_templates/$theTemplate" "./docs/$theDirectory/" || exitCode=$? && rm -f "$envFile" && return $exitCode
  done < <(_buildDocumentationPaths)

  #
  # {SEE:foo} gets linked in final documentation where it exists (rewrites file currently)
  #
  (
    # shellcheck source=/dev/null
    __usageEnvironment "$usage" buildEnvironmentLoad BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN || return $?
    functionLinkPattern=${BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN-}
    # Remove line
    fileLinkPattern=${functionLinkPattern%%#.*}
    __usageEnvironment "$usage" documentationIndex_SeeLinker "$cacheDirectory" "./docs" ./docs/_templates/__seeFunction.md "$functionLinkPattern" ./docs/_templates/__seeFile.md "$fileLinkPattern" || return $?
  ) || return $?
  reportTiming "$start" "Completed in" || :
}
_buildDocumentationBuild() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
