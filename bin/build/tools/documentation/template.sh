#!/usr/bin/env bash
#
# documentation/template.sh
#
# Building documentation
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

# Map template files using our identical functionality
# Usage: {fn} templatePath repairPath
__documentationTemplateUpdate() {
  local handler="$1" && shift
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
      catchEnvironment "$handler" "identicalCheck --repair failed" || return $?
    fi
  done
}

#
# Usage: {fn} cacheDirectory envFile unlinkedTemplateFile unlinkedTarget pageTemplateFile [ todoTemplateCode ]
# Argument: cacheDirectory - Required. Directory. Cache directory.
# Argument: envFile - Required. File. Environment file used as base environment for all template generation.
# Argument: template - Required. File. Final template file.
# - Argument: pageTemplate - Required. File. Environment file used as base environment for all template generation.
# Argument: todoTemplateCode - Optional. File. Template code for template.
#
__documentationTemplateUpdateUnlinked() {
  local handler="_${FUNCNAME[0]}"
  local cacheDirectory envFile template unlinkedFunctions todoTemplate template total clean content

  clean=()
  cacheDirectory=$(usageArgumentDirectory "$handler" "cacheDirectory" "${1-}") || return $?
  envFile=$(usageArgumentFile "$handler" "envFile" "${2-}") || return $?
  template=$(usageArgumentFile "$handler" "template" "${3-}") || return $?

  # Not used I guess
  muzzle usageArgumentFile "$handler" "pageTemplate" "${5-}" || return $?
  todoTemplate=$(catchReturn "$handler" documentationTemplate "${6-todo}") || return $?

  unlinkedFunctions=$(fileTemporaryName "$handler") || return $?
  clean+=("$unlinkedFunctions")
  catchReturn "$handler" _documentationIndexUnlinkedFunctions "$cacheDirectory" | grepSafe -v '^_' | decorate wrap "{" "}" >"$unlinkedFunctions" || returnClean $? "${clean[@]}" || return $?
  total=$(catchReturn "$handler" fileLineCount "$unlinkedFunctions") || return $?

  # Subshell hide globals
  (
    if [ "$total" -lt 40 ]; then
      content="$(sort <"$unlinkedFunctions")"
    else
      content="- *ERROR* found more than $total unlinked - something is wrong"
    fi
    content=$content total=$total mapEnvironment content total <"$todoTemplate" >"$template.$$"
  ) || returnClean $? "${clean[@]}" || return $?

  catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?

  if [ -f "$template" ] && diff -q "$template" "$template.$$" >/dev/null; then
    statusMessage decorate info "Not updating $template - unchanged $total unlinked $(plural "$total" function functions)"
    catchEnvironment "$handler" rm -f "$template.$$" || return $?
  else
    catchEnvironment "$handler" mv -f "$template.$$" "$template" || return $?
    statusMessage decorate info "Updated $(decorate file "$template") with $total unlinked $(plural "$total" function functions)"
  fi
}
___documentationTemplateUpdateUnlinked() {
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

  branch=$(catchEnvironment "$handler" gitCurrentBranch) || return $?
  if [ "$branch" = "$docsBranch" ]; then
    throwEnvironment "$handler" "Already on docs branch" || return $?
  fi
  catchEnvironment "$handler" git checkout "$docsBranch" || return $?
  catchEnvironment "$handler" git merge -m "${FUNCNAME[0]}" "$branch" || return $?
  catchEnvironment "$handler" git push || return $?
  catchEnvironment "$handler" git checkout "$branch" || return $?
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

  branch=$(gitCurrentBranch) || throwEnvironment "$handler" gitCurrentBranch || return $?
  if [ "$branch" = "docs" ]; then
    throwEnvironment "$handler" "Already on docs branch" || return $?
  fi
  if gitRepositoryChanged; then
    statusMessage decorate warning "Committing to branch $branch ..."
    catchEnvironment "$handler" git commit -m "Updated docs in pipeline on $(date +"%F %T")" -a || return $?
    statusMessage decorate info "Pushing branch $branch ..."
    catchEnvironment "$handler" git push || return $?
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
    __dumpNameValue version "$(hookRun version-current)"
    __dumpNameValue summary "{fn}"
    __dumpNameValue vendor "$1"
    __dumpNameValue APPLICATION_NAME "$3"
    __dumpNameValue BUILD_COMPANY "$1"
    __dumpNameValue vendorLink "$2"
    __dumpNameValue BUILD_COMPANY_LINK "$2"

    __dumpNameValue year "$(date +%Y)"
  } >>"$envFile" || throwEnvironment "$handler" "Saving to $envFile failed" || return $?
  printf "%s\n" "$envFile"
}

# List unlinked functions in documentation index
__documentationUnlinked() {
  local handler="$1" && shift

  local dd=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --debug) dd+=("$argument") ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local cacheDirectory

  cacheDirectory="$(catchReturn "$handler" documentationBuildCache)" || return $?

  catchReturn "$handler" _documentationIndexUnlinkedFunctions "$cacheDirectory" "${dd[@]+"${dd[@]}"}" || return $?
}

# See: bashDocumentFunction
# Document a function and generate a function template (markdown). To custom format any
# of the fields in this, write functions in the form `_bashDocumentationFormatter_${name}Format` such that
# name matches the variable name (lowercase alphanumeric characters and underscores).
#
# Filter functions should modify the input/output pipe; an example can be found in `{applicationFile}` by looking at
# sample function `_bashDocumentationFormatter_exit_code`.
#
# See: _bashDocumentationFormatter_exit_code
# Usage: {fn} template [ settingsFile ...
# Argument: template - Required. A markdown template to use to map values. Post-processed with `markdownRemoveUnfinishedSections`
# Argument: settingsFile - Required. Settings file to be loaded.
# Return Code: 0 - Success
# Return Code: 1 - Template file not found
# Short description: Simple bash function documentation
#
_bashDocumentation_Template() {
  local saved=("$@")
  local handler="$1" && shift
  local template="$1" && shift

  [ -f "$template" ] || throwArgument "$handler" "Template $template not found" || return $?
  # monitor off - not sure why here but let's leave it for now - KMD 2025-12
  set +m
  (
    # subshell this does not affect anything except these commands
    set -a # UNDO not required - subshell
    while [ $# -gt 0 ]; do
      local envFile="$1"
      [ -f "$envFile" ] || throwArgument "$handler" "Settings file $envFile not found" || return $?
      # shellcheck source=/dev/null
      source "$envFile" || throwEnvironment "$handler" "SOURCE $envFile Failed: $(dumpPipe "Template envFile failed" <"$envFile")" || return $?
      shift
    done
    while read -r token; do
      local value="${!token-}"
      if [ -n "$value" ]; then
        formatter="_bashDocumentationFormatter_${token}"
        if isFunction "$formatter"; then
          declare "$token"="$(printf "%s\n" "${!token}" | "$formatter")"
        fi
      fi
    done < <(mapTokens <"$template" | sort -u)
    mapEnvironment <"$template" | grepSafe -E -v '^shellcheck|# shellcheck' | markdownRemoveUnfinishedSections || :
  ) || throwEnvironment "$handler" "${FUNCNAME[0]} failed: ${saved[*]}" || return $?
}

# Formats arguments for markdown
__bashDocumentationDefaultArguments() {
  printf "%s\n" "$*" | sed 's/ - /^/1' | __documentationFormatArguments '^' '' ''
}
