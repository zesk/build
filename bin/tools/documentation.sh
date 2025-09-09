#!/usr/bin/env bash
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#

__buildDocumentationBuildDirectory() {
  local handler="$1" && shift
  local home="$1" && shift
  local aa=() target

  local prefix="$home/documentation/source"
  while read -r markdownFile; do
    target="$home/documentation/.docs${markdownFile#"$prefix"}"
    __catchEnvironment "$handler" muzzle fileDirectoryRequire "$target" || return $?
    __catchEnvironment "$handler" cp "$markdownFile" "$target" || return $?
  done < <(find "$prefix" -name '*.md' ! -path '*/tools/*')

  source="$home/documentation/source/tools"
  target="$home/documentation/.docs/tools"

  __catchEnvironment "$handler" muzzle directoryRequire "$target" || return $?

  local markdownFile
  while read -r markdownFile; do
    markdownFile=${markdownFile#"$source"}
    markdownFile="${target}/${markdownFile#/}"
    if [ ! -f "$markdownFile" ]; then
      __catchEnvironment "$handler" muzzle fileDirectoryRequire "$markdownFile" || return $?
      __catchEnvironment "$handler" touch "$markdownFile" || return $?
    fi
  done < <(find "$source" -type f -name '*.md' ! -path "*/.*/*")

  functionTemplate="$(__catch "$handler" documentationTemplate "function")" || return $?

  aa+=(--source "$home/bin")
  aa+=(--template "$source")
  aa+=(--unlinked-template "$home/documentation/source/tools/todo.md" --unlinked-target "$home/documentation/.docs/tools/todo.md")
  aa+=("--function-template" "$functionTemplate" --page-template "$home/documentation/template/__main.md")
  aa+=(--see-prefix "./documentation/.docs")
  aa+=(--target "$target")

  documentationBuild "${aa[@]}" "$@" || return $?
}

__buildDocumentationBuildRelease() {
  local handler="$1" home="$2" release currentNotes notesPath
  local target="$home/documentation/.docs/release/index.md"
  local recentNotes=10 index

  currentNotes=$(releaseNotes)

  __catch "$handler" muzzle fileDirectoryRequire "$target" || return $?

  printf -- "%s\n" "# Release Notes" "" >"$target"

  index=0
  notesPath=$(dirname "$currentNotes")
  while IFS="" read -r release; do
    local version=${release##*/}
    version="${version%.*}"
    if [ $index -lt $recentNotes ]; then
      printf "%s\n" "" "$(markdownIndentHeading <"$release")" >>"$target"
    elif [ $index -eq $recentNotes ]; then
      printf -- "%s\n" "" "# Past releases" "" >>"$target"
    fi
    if [ $index -ge $recentNotes ]; then
      printf -- "- [%s](%s)\n" "$version" "./$version.md" >>"$target"
    fi
    index=$((index + 1))
  done < <(find "$notesPath" -name "*.md" | versionSort -r)
}

__mkdocsConfiguration() {
  local handler="$1" token source="mkdocs.template.yml" target="mkdocs.yml"

  [ -f "$source" ] || __throwEnvironment "$handler" "missing $source" || return $?
  while IFS="" read -r token; do
    # skip lowercase
    [ "$token" != "$(lowercase "$token")" ] || continue
    __catch "$handler" buildEnvironmentLoad "$token" || return $?
    export "${token?}"
  done < <(mapTokens <"$source")
  __catch "$handler" mapEnvironment <"$source" >"$target" || return $?
}

# Build the build documentation
# fn: {base}
# Argument: --templates-only - Flag. Just template identical updates.
# Argument: --derived-only - Flag. Just derived files only.
# Argument: --reference-only - Flag. Just tools documentation.
# Argument: --clean - Flag. Clean caches.
# See: documentationBuild
buildDocumentationBuild() {
  local handler="_${FUNCNAME[0]}"
  local start

  start=$(timingStart) || return $?

  export APPLICATION_NAME

  local da=() ea=()
  local cleanFlag=false updateDerived=true updateTemplates=true updateReference=true makeDocumentation=true

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --templates-only)
      updateDerived=false
      updateTemplates="true"
      updateReference=false
      makeDocumentation=false
      ;;
    --derived-only)
      updateDerived="true"
      updateTemplates=false
      updateReference=false
      makeDocumentation=false
      ;;
    --reference-only)
      updateDerived=false
      updateTemplates=false
      updateReference="true"
      makeDocumentation=false
      ;;
    --mkdocs-only)
      updateDerived=false
      updateTemplates=false
      updateReference=false
      makeDocumentation="true"
      ;;
    --clean)
      cleanFlag=true
      ;;
    --verbose)
      da+=("$argument")
      ea+=("$argument")
      ;;
    --filter)
      da+=("$argument")
      while [ $# -gt 0 ] && [ "$1" != "--" ]; do da+=("$1") && shift; done
      ;;
    --force)
      da+=("$argument")
      ea+=("$argument")
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  # Greeting
  __catch "$handler" buildEnvironmentLoad APPLICATION_NAME || return $?
  statusMessage lineFill . "$(decorate info "${APPLICATION_NAME} documentation started on $(decorate value "$(date +"%F %T")")") "
  home=$(__catch "$handler" buildHome) || return $?

  # --clean
  if $cleanFlag; then
    # Clean env cache
    __catch "$handler" documentationBuildEnvironment --clean || return $?
    # Clean reference cache
    __buildDocumentationBuildDirectory "$handler" "$home" --clean || return $?
    return 0
  fi

  # Ensure we have our target
  __catchEnvironment "$handler" muzzle directoryRequire "$home/documentation/.docs" || return $?

  # Templates should be up-to-date if making documentation
  if ! $updateTemplates && $makeDocumentation; then
    local newestTemplate newestDocs
    newestTemplate=$(directoryNewestFile "$home/documentation/template")
    newestDocs=$(directoryNewestFile "$home/documentation/source")
    if fileIsNewest "$newestTemplate" "$newestDocs"; then
      updateTemplates=true
    fi
  fi

  if $updateTemplates; then
    statusMessage decorate notice "Updating document templates ..."
    documentationTemplateUpdate "$home/documentation/source" "$home/documentation/template" || return $?
  fi

  if $updateDerived; then
    local file

    statusMessage decorate notice "Updating release page ..."
    __buildDocumentationBuildRelease "$handler" "$home" || return $?

    statusMessage decorate notice "Updating mkdocs.yml ..."

    __catchEnvironment "$handler" muzzle pushd "./documentation" || return $?
    __mkdocsConfiguration "$handler" || return $?
    __catchEnvironment "$handler" muzzle popd || return $?

    local sourceHome="$home/documentation/source" targetHome="$home/documentation/.docs"
    while IFS="" read -r file; do
      file=${file#"$sourceHome"}
      statusMessage decorate notice "Updating $file ..."
      __catchEnvironment "$handler" muzzle fileDirectoryRequire "$targetHome/$file" || return $?
      __catchEnvironment "$handler" cp -f "$sourceHome/$file" "$targetHome/$file" || return $?
    done < <(
      find "$sourceHome" -type f -name "*.md" ! -path "*/tools/*" ! -path "*/env/*"
      printf "%s\n" "$sourceHome/tools/index.md"
    )
    version=$(hookVersionCurrent) timestamp="$(date -u "+%F %T") UTC" __catch "$handler" mapEnvironment <"$sourceHome/index.md" >"$targetHome/index.md" || return $?

    # Coding
    local example

    example="$(decorate wrap "    " <"$home/bin/build/tools/example.sh")" || __throwEnvironment "$handler" "generating example" || return $?
    example="$example" __catch "$handler" mapEnvironment <"$home/documentation/source/guide/coding.md" >"$home/documentation/.docs/guide/coding.md" || return $?

    statusMessage decorate notice "Updating env/index.md ..."
    __catch "$handler" documentationBuildEnvironment --verbose "${ea[@]+"${ea[@]}"}" || return $?
  fi

  if "$updateReference"; then
    __buildDocumentationBuildDirectory "$handler" "$home" "$@" "${da[@]+"${da[@]}"}" || return $?
  fi

  if "$makeDocumentation"; then
    if ! whichExists mkdocs; then
      __catchEnvironment "$handler" pythonInstall || return $?

      if [ ! -d "$home/.venv" ]; then
        if ! pythonPackageInstalled venv; then
          __catch "$handler" packageInstall python3-venv || return $?

          #  The virtual environment was not created successfully because ensurepip is not
          #  available.  On Debian/Ubuntu systems, you need to install the python3-venv
          #  package using the following command.
          #      apt install python3.10-venv
          #  You may need to use sudo with that command.  After installing the python3-venv
          #  package, recreate your virtual environment.
          #  Failing command: /opt/atlassian/pipelines/agent/build/.venv/bin/python
          #  [1] __buildDocumentationBuild  python -m venv /opt/atlassian/pipelines/agent/build/.venv
          #  [1] __buildBuild  /opt/atlassian/pipelines/agent/build/bin/documentation.sh

          # __catchEnvironment "$handler" pipWrapper install venv || return $?
        fi
        __catchEnvironment "$handler" python -m venv "$home/.venv" || return $?
      fi
      __catchEnvironment "$handler" source "$home/.venv/bin/activate" || return $?
      if ! pythonPackageInstalled mkdocs; then
        __catchEnvironment "$handler" python -m pip install mkdocs mkdocs-material || return $?
        whichExists mkdocs || __throwEnvironment "$handler" "mkdocs not found after installation?" || return $?
      fi
    else
      __catchEnvironment "$handler" source "$home/.venv/bin/activate" || return $?
    fi
    __catchEnvironment "$handler" muzzle pushd "./documentation" || return $?
    __mkdocsConfiguration "$handler" || return $?

    __catchEnvironment "$handler" python -m mkdocs build || return $?
    __catchEnvironment "$handler" muzzle popd || return $?
    __catchEnvironment "$handler" source "$home/.venv/bin/deactivate" || return $?
  fi

  statusMessage --last timingReport "$start" "$(basename "${BASH_SOURCE[0]}") completed in"
}
_buildDocumentationBuild() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Parses input stream and generates an argument documentation list
# Input is in the format with "{argument}{delimiter}{description}{newline}" and generates a list of arguments (optionally decorated) color-coded based
# on whether the word "require" appears in the description.
# INTERNAL: This is solely used internally but should be accessible globally as it is used here and in `usage`
# handler: __documentationFormatArguments delimiter
# Argument: delimiter - Required. String. The character to separate name value pairs in the input
__documentationFormatArguments() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  [ $# -le 3 ] || __throwArgument "$handler" "Requires 3 or fewer arguments" || return $?

  local separatorChar="${1-" "}" optionalDecoration="${2-blue}" requiredDecoration="${3-bold-magenta}"

  local lineTokens=() lastLine=false
  while true; do
    if ! IFS="$separatorChar" read -r -a lineTokens; then
      lastLine=true
    fi
    if [ ${#lineTokens[@]} -gt 0 ]; then
      local __value="${lineTokens[0]}"

      # printf "lineTokens-0: %s\n" "${lineTokens[@]}"
      unset "lineTokens[0]"
      # printf "lineTokens-1: %s\n" "${lineTokens[@]}"
      lineTokens=("${lineTokens[@]+${lineTokens[@]}}")
      local __description
      # printf "lineTokens-2: %s\n" "${lineTokens[@]}"
      __description=$(lowercase "${lineTokens[*]-}")
      # Looks for `Required.` in the description
      if [ "${__description%*required.*}" = "$__description" ]; then
        __value="[ $__value ]"
        [ -z "$optionalDecoration" ] || __value="$(decorate "$optionalDecoration" "$__value")"
      else
        [ -z "$requiredDecoration" ] || __value="$(decorate "$requiredDecoration" "$__value")"
      fi
      printf " %s" "$__value"
    fi
    if $lastLine; then
      break
    fi
  done
}
___documentationFormatArguments() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
