#!/usr/bin/env bash
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#

# Build documentation using mkdocs and a template
# Argument: --path documentationPath - Directory. Optional. Directory where documentation root exists.
# Argument: --template yamlTemplate - File. Optional. Name of mkdocs.yml template file to generate final file. Default is `mkdocs.template.yml`.
#
documentationMkdocs() {
  local handler="_${FUNCNAME[0]}"

  local rootPath="" template="" packages=("mkdocs")

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --template) shift && template=$(usageArgumentFile "$handler" "$argument" "${1-}") || return $? ;;
    --package) shift && packages+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $? ;;
    --path) shift && rootPath="$(usageArgumentDirectory "$handler" "$argument" "${1-}")" || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  [ -n "$rootPath" ] || rootPath="$home"

  catchEnvironment "$handler" pythonVirtual --application "$rootPath" "${packages[@]}" || return $?

  catchEnvironment "$handler" muzzle pushd "$rootPath" || return $?
  statusMessage --last decorate notice "Updating mkdocs.yml ..."

  __mkdocsConfiguration "$handler" "$template" || returnUndo $? muzzle popd || return $?
  tempLog=$(fileTemporaryName "$handler") || returnUndo $? muzzle popd || return $?
  statusMessage --last decorate notice "Building with mkdocs ..."
  catchEnvironmentQuiet "$handler" "$tempLog" python -m mkdocs build || returnUndo $? dumpPipe "mkdocs log" <"$tempLog" || returnUndo $? muzzle popd || returnClean $? "$tempLog" || return $?
  catchEnvironment "$handler" rm -f "$tempLog" || returnUndo $? muzzle popd || return $?
  catchEnvironment "$handler" muzzle popd || return $?
}
_documentationMkdocs() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__mkdocsConfiguration() {
  local handler="${1-}" && shift
  local source="${1-}" && shift

  [ -n "$source" ] || source="mkdocs.template.yml"

  local target="mkdocs.yml"
  [ -f "$source" ] || throwEnvironment "$handler" "missing $source" || return $?

  while IFS="" read -r token; do
    # skip lowercase
    [ "$token" != "$(lowercase "$token")" ] || continue
    catchReturn "$handler" buildEnvironmentLoad "$token" || return $?
    export "${token?}"
  done < <(mapTokens <"$source")
  catchReturn "$handler" mapEnvironment <"$source" >"$target" || return $?
}
