#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__buildFunctionsDerived() {
  local handler="$1" && shift
  local sourceFile="$1" && shift

  local runner=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      [ "${#runner[@]}" -eq 0 ] || catchReturn "$handler" "${runner[@]}" "$sourceFile" && runner=() || return $?
    else
      runner+=("$1")
    fi
    shift
  done
  [ "${#runner[@]}" -eq 0 ] || catchReturn "$handler" "${runner[@]}" "$sourceFile" || return $?
}

__buildFunctionsCheckDerived() {
  local handler="$1" && shift
  local sourceFile="$1" && shift

  local profile="$1" && shift

  local runner=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "--" ]; then
      if [ "${#runner[@]}" -gt 0 ]; then
        local ca=() ra=()
        ! $profile || ca=(timing --name "${runner[0]}-check") && ra=(timing --name "${runner[0]}")
        "${ca[@]+"${ca[@]}"}" "${runner[@]}" --check "$sourceFile" || catchReturn "$handler" "${ra[@]+"${ra[@]}"}" "${runner[@]}" "$sourceFile" || return $?
        runner=()
      fi
    else
      runner+=("$1")
    fi
    shift
  done
  if [ "${#runner[@]}" -gt 0 ]; then
    local ca=() ra=()
    ! $profile || ca=(timing --name "${runner[0]}-check") && ra=(timing --name "${runner[0]}")
    "${ca[@]+"${ca[@]}"}" "${runner[@]}" --check "$sourceFile" || catchReturn "$handler" "${ra[@]+"${ra[@]}"}" "${runner[@]}" "$sourceFile" || return $?
    runner=()
  fi
}

# Generate `{fn}.md`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --check - Flag. Optional. Check to see if an update is needed
buildFunctionMarkdownDocumentation() {
  local handler="_${FUNCNAME[0]}"

  local settingsFile="" checkFlag=false
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --check) checkFlag=true ;;
    *) settingsFile=$(validate "$handler" File "settingsFile" "$argument") && shift && break || return $? ;;
    esac
    shift
  done
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument: $*" || return $?

  local fn && fn=$(environmentValueRead "$settingsFile" fn) || return $?
  local sourceFile && sourceFile=$(environmentValueRead "$settingsFile" sourceFile) || return $?
  local targetFile && targetFile="$(dirname "$settingsFile")/${fn}.md"
  local template && template=$(catchReturn "$handler" documentationTemplate function) || return $?
  if $checkFlag; then
    if [ -f "$targetFile" ] && fileIsNewest "$targetFile" "$settingsFile" "$template" "$sourceFile"; then
      catchReturn "$handler" touch "$targetFile" || return $?
      return 0
    fi
    return 1
  fi
  catchReturn "$handler" bashDocumentationMarkdown "$fn" >"$targetFile" || return $?
}

# Generate `SEE_{fn}.md`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --check - Flag. Optional. Check to see if an update is needed
buildFunctionSeeTemplate() {
  local handler="_${FUNCNAME[0]}"

  local settingsFile="" checkFlag=false
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --check) checkFlag=true ;;
    *) settingsFile=$(validate "$handler" File "settingsFile" "$argument") && shift && break || return $? ;;
    esac
    shift
  done
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument: $*" || return $?

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local fn && fn=$(environmentValueRead "$settingsFile" fn) || return $?
  local documentationPath
  if ! documentationPath=$(environmentValueRead "$settingsFile" documentationPath); then
    if ! documentationPath=$(directoryChange "$home" find "documentation/source/tools" -type f -name '*.md' -print0 | xargs -0 grep -l "{$fn}" | sort | head -n 1); then
      decorate warning "No documentationPath found for $fn" || :
    else
      environmentValueWrite "documentationPath" "$documentationPath" >>"$settingsFile"
    fi
  fi
  local targetFile && targetFile="$(dirname "$settingsFile")/SEE_${fn}.md"
  local template && template=$(catchReturn "$handler" documentationTemplate seeFunction) || return $?
  if $checkFlag; then
    if [ -f "$targetFile" ] && [ -f "$documentationPath" ] && fileIsNewest "$targetFile" "$settingsFile" "$template" "$sourceFile" "$documentationPath"; then
      catchReturn "$handler" touch "$targetFile" || return $?
      return 0
    fi
    return 1
  fi
  (
    catchReturn "$handler" buildEnvironmentLoad BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN || return $?
    local functionLinkPattern=${BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN-}
    catchReturn "$handler" environmentFileLoad "$settingsFile" || return $?
    local sourceLink && sourceLink="$(catchReturn "$handler" mapEnvironment <<<"$functionLinkPattern")" || return $?
    sourceLink="$sourceLink" catchReturn "$handler" mapEnvironment <"$template" >>"$targetFile" || return $?
  ) || return $?
}
_buildFunctionSeeTemplate() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
