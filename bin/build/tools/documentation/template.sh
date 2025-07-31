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
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local templatePath repairArgs=() failCount=0
  templatePath=$(usageArgumentDirectory "$handler" "templatePath" "${1-}") && shift || return $?

  while [ $# -gt 0 ]; do
    repairArgs+=("--repair" "$1")
    shift
  done
  while ! identicalCheck "${repairArgs[@]}" --ignore-singles --extension md --prefix '<!-- TEMPLATE' --cd "$templatePath"; do
    failCount=$((failCount + 1))
    if [ $failCount -gt 4 ]; then
      __catchEnvironment "$handler" "identicalCheck --repair failed" || return $?
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
  local handler="_${FUNCNAME[0]}"
  local cacheDirectory envFile template target unlinkedFunctions todoTemplate template total clean content

  clean=()
  cacheDirectory=$(usageArgumentDirectory "$handler" "cacheDirectory" "${1-}") || return $?
  envFile=$(usageArgumentFile "$handler" "envFile" "${2-}") || return $?
  template=$(usageArgumentFile "$handler" "template" "${3-}") || return $?
  target=$(usageArgumentFileDirectory "$handler" "target" "${4-}") || return $?
  # Not used I guess
  muzzle usageArgumentFile "$handler" "pageTemplate" "${5-}" || return $?
  todoTemplate=$(__catch "$handler" documentationTemplate "${6-todo}") || return $?

  unlinkedFunctions=$(fileTemporaryName "$handler") || return $?
  clean+=("$unlinkedFunctions")
  __catch "$handler" documentationIndex_SetUnlinkedDocumentationPath "$cacheDirectory" "$target" | IFS="" awk '{ print "{" $1 "}" }' >"$unlinkedFunctions" || returnClean $? "${clean[@]}" || return $?
  total=$(__catch "$handler" fileLineCount "$unlinkedFunctions") || return $?

  # Subshell hide globals
  (
    content="$(sort <"$unlinkedFunctions")"
    content=$content total=$total mapEnvironment content total <"$todoTemplate" >"$template.$$"
  ) || returnClean $? "${clean[@]}" || return $?

  __catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  if [ -f "$template" ] && diff -q "$template" "$template.$$" >/dev/null; then
    statusMessage decorate info "Not updating $template - unchanged $total unlinked $(plural "$total" function functions)"
    __catchEnvironment "$handler" rm -f "$template.$$" || return $?
  else
    __catchEnvironment "$handler" mv -f "$template.$$" "$template" || return $?
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
  local handler="_${FUNCNAME[0]}"

  branch=$(__catchEnvironment "$handler" gitCurrentBranch) || return $?
  if [ "$branch" = "$docsBranch" ]; then
    __throwEnvironment "$handler" "Already on docs branch" || return $?
  fi
  __catchEnvironment "$handler" git checkout "$docsBranch" || return $?
  __catchEnvironment "$handler" git merge -m "${FUNCNAME[0]}" "$branch" || return $?
  __catchEnvironment "$handler" git push || return $?
  __catchEnvironment "$handler" git checkout "$branch" || return $?
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
  local handler

  handler="_${FUNCNAME[0]}"

  branch=$(gitCurrentBranch) || __throwEnvironment "$handler" gitCurrentBranch || return $?
  if [ "$branch" = "docs" ]; then
    __throwEnvironment "$handler" "Already on docs branch" || return $?
  fi
  if gitRepositoryChanged; then
    statusMessage decorate warning "Committing to branch $branch ..."
    __catchEnvironment "$handler" git commit -m "Updated docs in pipeline on $(date +"%F %T")" -a || return $?
    statusMessage decorate info "Pushing branch $branch ..."
    __catchEnvironment "$handler" git push || return $?
    statusMessage decorate success "Documentation committed"
  else
    decorate info "Branch $branch is unchanged"
  fi
}
__buildDocumentation_Recommit() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

_buildDocumentationGenerateEnvironment() {
  local handler="$1" && shift
  export APPLICATION_NAME
  buildEnvironmentLoad APPLICATION_NAME || :
  envFile=$(fileTemporaryName "$handler") || return $?
  {
    __dumpNameValue summary "{fn}"
    __dumpNameValue vendor "$1"
    __dumpNameValue APPLICATION_NAME "$3"
    __dumpNameValue BUILD_COMPANY "$1"
    __dumpNameValue vendorLink "$2"
    __dumpNameValue BUILD_COMPANY_LINK "$2"

    __dumpNameValue year "$(date +%Y)"
  } >>"$envFile" || __throwEnvironment "$handler" "Saving to $envFile failed" || return $?
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
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || __help --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  local cacheDirectory

  cacheDirectory="$(__catch "$handler" buildCacheDirectory)" || return $?
  cacheDirectory=$(__catch "$handler" directoryRequire "$cacheDirectory") || return $?

  __catch "$handler" documentationIndex_ShowUnlinked "$cacheDirectory" || return $?
}
_documentationUnlinked() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
