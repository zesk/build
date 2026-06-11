#!/usr/bin/env bash
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#

# Summary: mkdocs Utility
# Build documentation using `mkdocs` and a template.
# Argument: --path documentationPath - Directory. Optional. Directory where documentation root exists.
# Argument: --template yamlTemplate - File. Optional. Name of `mkdocs.yml` template file to generate final file. Default is `mkdocs.template.yml`.
# Argument: --package packageName - String. Optional. Install this python package when setting up `mkdocs`.
# Argument: --version version - String. Optional. Use this for current version of documentation; defaults to `hookVersionCurrent`
# Argument: --clean - Flag. Optional. Clean the python virtual environment first.
# See: hookVersionCurrent
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
documentationMkdocs() {
  local handler="_${FUNCNAME[0]}"

  local rootPath="" template="" packages=("mkdocs") pv=() version=""

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
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --template) shift && template=$(validate "$handler" File "$argument" "${1-}") || return $? ;;
    --package) shift && packages+=("$(validate "$handler" String "$argument" "${1-}")") || return $? ;;
    --version) shift && version="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --path) shift && rootPath="$(validate "$handler" Directory "$argument" "${1-}")" || return $? ;;
    --clean) pv+=("--clean") ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  [ -n "$version" ] || version=$(catchReturn "$handler" hookVersionCurrent) || return $?

  [ -n "$rootPath" ] || rootPath="$home"
  catchEnvironment "$handler" pythonVirtual "${pv[@]+"${pv[@]}"}" --application "$rootPath" "${packages[@]}" || return $?

  catchEnvironment "$handler" muzzle pushd "$rootPath" || return $?
  statusMessage --last decorate notice "Updating mkdocs.yml ..."

  version="$version" __mkdocsConfiguration "$handler" "$template" || returnUndo $? muzzle popd || return $?
  local tempLog && tempLog=$(fileTemporaryName "$handler") || returnUndo $? muzzle popd || return $?
  statusMessage --last decorate notice "Building with mkdocs ..."
  catchEnvironmentQuiet "$handler" "$tempLog" python -m mkdocs build || returnUndo $? dumpPipe "mkdocs log" <"$tempLog" || returnUndo $? muzzle popd || returnClean $? "$tempLog" || return $?
  catchEnvironment "$handler" rm -f "$tempLog" || returnUndo $? muzzle popd || return $?
  catchEnvironment "$handler" muzzle popd || return $?
}
_documentationMkdocs() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__mkdocsConfiguration() {
  local handler="${1-}" && shift
  local source="${1-}" && shift

  [ -n "$source" ] || source="mkdocs.template.yml"

  local target="mkdocs.yml"
  [ -f "$source" ] || throwEnvironment "$handler" "missing $source" || return $?

  (
    local token && while IFS="" read -r token; do
      # skip lowercase
      [ "$token" != "$(stringLowercase "$token")" ] || continue
      export "${token?}"
      catchReturn "$handler" buildEnvironmentLoad "$token" || return $?
    done < <(mapTokens <"$source")
    catchReturn "$handler" mapEnvironment <"$source" >"$target" || return $?
  ) || return $?
  if grep -q '{version}' "$target"; then
    dumpPipe "SOMETHING IS WRONG:" <"$target"
  fi
}
