#!/usr/bin/env bash
#
# documentation/template.sh
#
# Building documentation
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

# Map template files using our identical functionality
# Usage: {fn} templatePath repairPath
documentationTemplateUpdate() {
  local usage="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$usage" "$@" || return 0

  local templatePath repairArgs=() failCount=0
  templatePath=$(usageArgumentDirectory "$usage" "templatePath" "${1-}") && shift || return $?

  while [ $# -gt 0 ]; do
    repairArgs+=("--repair" "$1")
    shift
  done
  while ! identicalCheck "${repairArgs[@]}" --ignore-singles --extension md --prefix '<!-- TEMPLATE' --cd "$templatePath"; do
    failCount=$((failCount + 1))
    if [ $failCount -gt 4 ]; then
      __catchEnvironment "$usage" "identicalCheck --repair failed" || return $?
    fi
  done
}
_documentationTemplateUpdate() {
  # __IDENTICAL__ usageDocument 1
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
  todoTemplate=$(__catch "$usage" documentationTemplate "${6-todo}") || return $?

  unlinkedFunctions=$(fileTemporaryName "$usage") || return $?
  clean+=("$unlinkedFunctions")
  documentationIndex_SetUnlinkedDocumentationPath "$cacheDirectory" "$target" | IFS="" awk '{ print "{" $1 "}" }' >"$unlinkedFunctions" || __throwEnvironment "$usage" "Unable to documentationIndex_SetUnlinkedDocumentationPath" || returnClean $? "${clean[@]}" || return $?
  total=$(__catch "$usage" fileLineCount "$unlinkedFunctions") || return $?

  # Subshell hide globals
  (
    content="$(sort <"$unlinkedFunctions")"
    content=$content total=$total mapEnvironment content total <"$todoTemplate" >"$template.$$"
  ) || returnClean $? "${clean[@]}" || return $?

  __catchEnvironment "$usage" rm -rf "${clean[@]}" || return $?

  if [ -f "$template" ] && diff -q "$template" "$template.$$" >/dev/null; then
    statusMessage decorate info "Not updating $template - unchanged $total unlinked $(plural "$total" function functions)"
    __catchEnvironment "$usage" rm -f "$template.$$" || return $?
  else
    __catchEnvironment "$usage" mv -f "$template.$$" "$template" || return $?
    statusMessage decorate info "Updated $(decorate file "$template") with $total unlinked $(plural "$total" function functions)"
  fi
}
__documentationTemplateUpdateUnlinked() {
  # __IDENTICAL__ usageDocument 1
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

  branch=$(__catchEnvironment "$usage" gitCurrentBranch) || return $?
  if [ "$branch" = "$docsBranch" ]; then
    __throwEnvironment "$usage" "Already on docs branch" || return $?
  fi
  __catchEnvironment "$usage" git checkout "$docsBranch" || return $?
  __catchEnvironment "$usage" git merge -m "$this" "$branch" || return $?
  __catchEnvironment "$usage" git push || return $?
  __catchEnvironment "$usage" git checkout "$branch" || return $?
}
__buildDocumentation_MergeWithDocsBranch() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Just merge into docs branch
#
_buildDocumentation_Recommit() {
  local branch
  local usage

  usage="_${FUNCNAME[0]}"

  branch=$(gitCurrentBranch) || __throwEnvironment "$usage" gitCurrentBranch || return $?
  if [ "$branch" = "docs" ]; then
    __throwEnvironment "$usage" "Already on docs branch" || return $?
  fi
  if gitRepositoryChanged; then
    statusMessage decorate warning "Committing to branch $branch ..."
    __catchEnvironment "$usage" git commit -m "Updated docs in pipeline on $(date +"%F %T")" -a || return $?
    statusMessage decorate info "Pushing branch $branch ..."
    __catchEnvironment "$usage" git push || return $?
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
  envFile=$(mktemp) || __throwEnvironment "$usage" "mktemp failed" || return $?
  {
    __dumpNameValue summary "{fn}"
    __dumpNameValue vendor "$1"
    __dumpNameValue APPLICATION_NAME "$3"
    __dumpNameValue BUILD_COMPANY "$1"
    __dumpNameValue vendorLink "$2"
    __dumpNameValue BUILD_COMPANY_LINK "$2"

    __dumpNameValue year "$(date +%Y)"
  } >>"$envFile" || __throwEnvironment "$usage" "Saving to $envFile failed" || return $?
  printf "%s\n" "$envFile"
}

# Get an internal template name
documentationTemplate() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local source="${BASH_SOURCE[0]%/*}"
  local template="$source/__${1-}.md"

  [ -f "$template" ] || _argument "No template \"${1-}\" at $template" || return $?
  printf "%s\n" "$template"
}
_documentationTemplate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List unlinked functions in documentation index
documentationUnlinked() {
  local usage="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$usage" "$@" || return "$(convertValue $? 1 0)"

  local cacheDirectory

  cacheDirectory="$(__catch "$usage" buildCacheDirectory)" || return $?
  cacheDirectory=$(__catch "$usage" directoryRequire "$cacheDirectory") || return $?

  __catch "$usage" documentationIndex_ShowUnlinked "$cacheDirectory" || return $?
}
_documentationUnlinked() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
