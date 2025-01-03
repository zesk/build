#!/usr/bin/env bash
#
# documentation/template.sh
#
# Building documentation
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
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
  # Not used I guess
  muzzle usageArgumentFile "$usage" "pageTemplate" "${5-}" || return $?
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
    statusMessage decorate info "Updated $(decorate file "$template") with $total unlinked $(plural "$total" function functions)"
  fi
}
__documentationTemplateUpdateUnlinked() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Just merge into docs branch
#
_buildDocumentation_MergeWithDocsBranch() {
  local docsBranch="${1-docs}"
  local branch
  local this="${FUNCNAME[0]}"
  local usage="_$this"

  branch=$(__usageEnvironment "$usage" gitCurrentBranch) || return $?
  if [ "$branch" = "$docsBranch" ]; then
    __failEnvironment "$usage" "Already on docs branch" || return $?
  fi
  __usageEnvironment "$usage" git checkout "$docsBranch" || return $?
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
