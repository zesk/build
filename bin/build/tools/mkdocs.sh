#!/usr/bin/env bash
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#

# Build documentation using mkdocs and a template
# Argument: --path documentationPath - Directory. Optional. Directory where documentation root exists.
# Argument: --template yamlTemplate - File. Optional. Name of mkdocs.yml template file to generate final file. Default is `mkdocs.template.yml`.
#
documentationMkdocs() {
  local handler="_${FUNCNAME[0]}"

  local rootPath="" template=""
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

  if ! whichExists mkdocs; then

    statusMessage --last decorate notice "Installing python and mkdocs ..."
    catchEnvironmentQuiet "$handler" - pythonInstall || return $?

    if [ ! -d "$rootPath/.venv" ]; then
      if ! pythonPackageInstalled venv; then
        catchReturn "$handler" packageInstall python3-venv || return $?
        #  The virtual environment was not created successfully because ensurepip is not
        #  available.  On Debian/Ubuntu systems, you need to install the python3-venv
        #  package using the following command.
        #      apt install python3.10-venv
        #  You may need to use sudo with that command.  After installing the python3-venv
        #  package, recreate your virtual environment.
        #  Failing command: /opt/atlassian/pipelines/agent/build/.venv/bin/python
        #  [1] __buildDocumentationBuild  python -m venv /opt/atlassian/pipelines/agent/build/.venv
        #  [1] __buildBuild  /opt/atlassian/pipelines/agent/build/bin/documentation.sh

        # catchEnvironment "$handler" pipWrapper install venv || return $?
      fi
      catchEnvironmentQuiet "$handler" - python -m venv "$rootPath/.venv" || return $?
      [ -d "$rootPath/.venv" ] || throwEnvironment "$handler" ".venv directory not created?" || return $?
    fi
    catchEnvironment "$handler" source "$rootPath/.venv/bin/activate" || return $?
    if ! pythonPackageInstalled mkdocs; then
      catchEnvironmentQuiet "$handler" - python -m pip install mkdocs mkdocs-material || return $?
      whichExists mkdocs || throwEnvironment "$handler" "mkdocs not found after installation?" || return $?
    fi
  else
    catchEnvironment "$handler" source "$rootPath/.venv/bin/activate" || return $?
  fi

  catchEnvironment "$handler" muzzle pushd "$rootPath" || return $?
  statusMessage --last decorate notice "Updating mkdocs.yml ..."

  __mkdocsConfiguration "$handler" "$template" || return $?
  tempLog=$(fileTemporaryName "$handler") || return $?
  statusMessage --last decorate notice "Building with mkdocs ..."
  catchEnvironmentQuiet "$handler" "$tempLog" python -m mkdocs build || returnUndo $? dumpPipe "mkdocs log" <"$tempLog" || returnClean $? "$tempLog" || return $?
  catchEnvironment "$handler" rm -f "$tempLog" || return $?
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
