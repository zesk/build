#!/bin/bash
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#

set -eou pipefail

# shellcheck source=/dev/null
if ! source "$(dirname "${BASH_SOURCE[0]}")/build/tools.sh"; then
  printf "%s: %d\n" "tools.sh failed" $? 1>&2
  exit 1
fi

#
# Usage: {fn} cacheDirectory envFile
# Argument: cacheDirectory - Required. Directory. Cache directory.
# Argument: envFile - Required. File. Environment file used as base environment for all template generation.
#
buildDocumentation_UpdateUnlinked() {
  local argument cacheDirectory envFile unlinkedFunctions template total
  local usage

  usage="_${FUNCNAME[0]}"

  cacheDirectory=
  envFile=
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      *)
        if [ -z "$cacheDirectory" ]; then
          cacheDirectory=$(usageArgumentDirectory "$usage" "cacheDirectory" "$argument") || return $?
        elif [ -z "$envFile" ]; then
          envFile=$(usageArgumentFile "$usage" "envFile" "$argument") || return $?
        else
          __failArgument "$usage" "Unknown argument \"$argument\"" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shift $argument failed" || return $?
  done
  [ -n "$envFile" ] || __failArgument "$usage" "Missing argument" || return $?

  unlinkedFunctions=$(mktemp) || __failEnvironment "$usage" mktemp || return $?
  template="./docs/_templates/tools/todo.md"
  documentationIndex_SetUnlinkedDocumentationPath "$cacheDirectory" "./docs/tools/todo.md" | IFS="" awk '{ print "{" $1 "}" }' >"$unlinkedFunctions" || __failEnvironment "$usage" "Unable to documentationIndex_SetUnlinkedDocumentationPath" || return $?
  (
    set -a
    # shellcheck source=/dev/null
    source "$envFile" || __failEnvironment "$usage" "source $envFile" || return $?
    title="Missing functions" content="$(cat "./docs/_templates/__todo.md")"$'\n'$'\n'"$(sort <"$unlinkedFunctions")" mapEnvironment <"./docs/_templates/__main1.md" >"$template.$$"
  ) || return $?
  total=$(wc -l <"$unlinkedFunctions" | trimSpacePipe)
  if [ -f "$template" ] && diff -q "$template" "$template.$$"; then
    statusMessage consoleInfo "Not updating $template - unchanged $total unlinked $(plural "$total" function functions)"
    __usageEnvironment "$usage" rm -f "$template.$$" || return $?
  else
    __usageEnvironment "$usage" mv -f "$template.$$" "$template" || return $?
    statusMessage consoleInfo "Updated $template with $total unlinked $(plural "$total" function functions)"
  fi
  rm -f "$unlinkedFunctions" || :
}
_buildDocumentation_UpdateUnlinked() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Just merge into docs branch
#
buildDocumentation_MergeWithDocsBranch() {
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
_buildDocumentation_MergeWithDocsBranch() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Just merge into docs branch
#
buildDocumentation_Recommit() {
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
_buildDocumentation_Recommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_buildDocumentationGenerateEnvironment() {
  envFile=$(mktemp) || __failEnvironment "$usage" "mktemp failed" || return $?
  {
    __dumpNameValue summary "{fn}"
    __dumpNameValue vendor "$BUILD_COMPANY"
    __dumpNameValue BUILD_COMPANY "$BUILD_COMPANY"
    __dumpNameValue vendorLink "$BUILD_COMPANY_LINK"
    __dumpNameValue BUILD_COMPANY_LINK "$BUILD_COMPANY_LINK"

    __dumpNameValue year "$(date +%Y)"
  } >>"$envFile" || __failEnvironment "$usage" "Saving to $envFile failed" || return $?
  printf "%s\n" "$envFile"
}

#
# Documentation configuration
#
_buildDocumentationPaths() {
  cat <<EOF
tools __function.md
hooks __hook.md
bin __binary.md
EOF
}

# fn: {base}
# Build documentation for build system.
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
# Artifact: `cacheDirectory` may be created even on non-zero exit code
# Exit Code: 0 - Success
# Exit Code: 1 - Issue with environment
# Exit Code: 2 - Argument error
buildDocumentationBuild() {
  local cacheDirectory theDirectory start docArgs indexArgs=()
  local functionLinkPattern fileLinkPattern documentTemplate templateDirectory
  local start envFile exitCode
  local usage

  usage="_${FUNCNAME[0]}"

  export BUILD_COLORS_MODE
  BUILD_COLORS_MODE=$(consoleConfigureColorMode) || :

  if ! which pcregrep >/dev/null; then
    __usageEnvironment "$usage" aptInstall pcregrep || return $?
  fi

  exitCode=0
  start=$(beginTiming) || __failEnvironment "$usage" beginTiming || return $?

  __usageEnvironment "$usage" buildEnvironmentLoad BUILD_COMPANY BUILD_COMPANY_LINK || return $?

  cacheDirectory="$(buildCacheDirectory)" && cacheDirectory=$(requireDirectory "$cacheDirectory") || __failEnvironment "$usage" "Create $cacheDirectory failed" || return $?

  # Default option settings
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "Blank argument" || return $?
    case "$argument" in
      --git)
        buildDocumentation_MergeWithDocsBranch
        return $?
        ;;
      --commit)
        buildDocumentation_Recommit
        return $?
        ;;
      --clean)
        indexArgs+=("$argument")
        ;;
      --unlinked)
        documentationIndex_ShowUnlinked "$cacheDirectory" || exitCode=$?
        return $exitCode
        ;;
      --unlinked-update)
        envFile=$(_buildDocumentationGenerateEnvironment) || return $?
        buildDocumentation_UpdateUnlinked "$cacheDirectory" "$envFile" || exitCode=$?
        rm -f "$envFile" || :
        printf "\n" || :
        return $exitCode
        ;;
      --force)
        if ! inArray "$argument" "${docArgs[@]}"; then
          docArgs+=("$argument")
        fi
        ;;
      --help)
        "$usage" 0
        return 0
        ;;
      *)
        __failArgument "$usage" "Unknown argument $argument" || return $?
        ;;
    esac
    shift
  done
  cacheDirectory=$(requireDirectory "$cacheDirectory") || __failEnvironment "$usage" "Unable to create $cacheDirectory" || return $?

  #
  # Generate or update indexes
  #
  __usageEnvironment "$usage" documentationIndex_Generate "${indexArgs[@]+${indexArgs[@]}}" ./bin/ "$cacheDirectory" || return $?

  #
  # Update indexes with function -> documentationPath
  #
  templateDirectory=./docs/_templates
  find "$templateDirectory" -type f -name '*.md' ! -path '*/__*' | while read -r documentTemplate; do
    __usageEnvironment "$usage" documentationIndex_LinkDocumentationPaths "$cacheDirectory" "$documentTemplate" "./docs${documentTemplate#"$templateDirectory"}" || return $?
  done
  clearLine || :
  reportTiming "$start" "Indexes completed in" || :

  #
  # Build docs
  #

  # Update unlinked document
  envFile=$(_buildDocumentationGenerateEnvironment) || return $?
  __usageEnvironment "$usage" buildDocumentation_UpdateUnlinked "$cacheDirectory" "$envFile" || return $?
  clearLine || :

  docArgs=()
  docArgs+=(--env "$envFile")

  while read -r theDirectory theTemplate; do
    __usageEnvironment "$usage" documentationTemplateDirectoryCompile "${docArgs[@]}" \
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

buildDocumentationBuild "$@"
