#!/bin/bash
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL __source 21

# Load a source file and run a command
# Argument: source - Required. File. Path to source relative to application root..
# Argument: relativeHome - Optional. Directory. Path to application root. Defaults to `..`
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: _return
# Security: source
# Exit Code: 253 - source failed to load (internal error)
# Exit Code: 0 - source loaded (and command succeeded)
# Exit Code: ? - All other codes are returned by the command itself
__source() {
  local here="${BASH_SOURCE[0]%/*}" e=253
  local source="$here/${2:-".."}/${1-}" && shift 2 || _return $e "missing source" || return $?
  [ -d "${source%/*}" ] || _return $e "${source%/*} is not a directory" || return $?
  [ -f "$source" ] && [ -x "$source" ] || _return $e "$source not an executable file" "$@" || return $?
  local a=("$@") && set --
  # shellcheck source=/dev/null
  source "$source" || _return $e source "$source" "$@" || return $?
  [ ${#a[@]} -gt 0 ] || return 0
  "${a[@]}" || return $?
}

# IDENTICAL __tools 8

# Load build tools and run command
# Argument: relativeHome - Required. Directory. Path to application root.
# Argument: command ... - Optional. Callable. A command to run and optional arguments.
# Requires: __source
__tools() {
  __source bin/build/tools.sh "$@"
}

# IDENTICAL _return 27

# Return passed in integer return code and output message to `stderr` (non-zero) or `stdout` (zero)
# Argument: exitCode - Required. UnsignedInteger. Exit code to return. Default is 1.
# Argument: message ... - Optional. String. Message to output
# Exit Code: exitCode
# Requires: isUnsignedInteger printf _return
_return() {
  local code="${1:-1}" && shift 2>/dev/null
  isUnsignedInteger "$code" || _return 2 "${FUNCNAME[1]-none}:${BASH_LINENO[1]-} -> ${FUNCNAME[0]} non-integer \"$code\"" "$@" || return $?
  [ "$code" -eq 0 ] && printf -- "✅ %s\n" "${*-§}" && return 0 || printf -- "❌ [%d] %s\n" "$code" "${*-§}" 1>&2
  return "$code"
}

# Test if an argument is an unsigned integer
# Source: https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
# Credits: F. Hauri - Give Up GitHub (isnum_Case)
# Original: is_uint
# Usage: {fn} argument ...
# Exit Code: 0 - if it is an unsigned integer
# Exit Code: 1 - if it is not an unsigned integer
# Requires: _return
isUnsignedInteger() {
  [ $# -eq 1 ] || _return 2 "Single argument only: $*" || return $?
  case "${1#+}" in '' | *[!0-9]*) return 1 ;; esac
}

# <-- END of IDENTICAL _return

__buildDocumentationBuildDirectory() {
  local usage="$1" home="$2" aa=() target
  shift 2

  local prefix="$home/documentation/source"
  while read -r markdownFile; do
    target="$home/documentation/docs${markdownFile#"$prefix"}"
    __catchEnvironment "$usage" muzzle fileDirectoryRequire "$target" || return $?
    __catchEnvironment "$usage" cp "$markdownFile" "$target" || return $?
  done < <(find "$prefix" -name '*.md' ! -path '*/tools/*')

  source="$home/documentation/source/tools"
  target="$home/documentation/docs/tools"

  __catchEnvironment "$usage" muzzle directoryRequire "$target" || return $?

  local markdownFile
  while read -r markdownFile; do
    markdownFile=${markdownFile#"$source"}
    markdownFile="${target}/${markdownFile#/}"
    if [ ! -f "$markdownFile" ]; then
      __catchEnvironment "$usage" muzzle fileDirectoryRequire "$markdownFile" || return $?
      __catchEnvironment "$usage" touch "$markdownFile" || return $?
    fi
  done < <(find "$source" -type f -name '*.md' ! -path "*/.*/*")

  functionTemplate="$(__catchEnvironment "$usage" documentationTemplate "function")" || return $?

  aa+=(--source "$home/bin")
  aa+=(--template "$source")
  aa+=(--unlinked-template "$home/documentation/source/tools/todo.md" --unlinked-target "$home/documentation/docs/tools/todo.md")
  aa+=("--function-template" "$functionTemplate" --page-template "$home/documentation/template/__main.md")
  aa+=(--see-prefix "./documentation/docs")
  aa+=(--target "$target")

  documentationBuild "${aa[@]}" "$@" || return $?
}

__buildDocumentationBuildRelease() {
  local usage="$1" home="$2" release currentNotes notesPath
  local target="$home/documentation/docs/release/index.md"
  local recentNotes=10 index

  currentNotes=$(releaseNotes)

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
  local usage="$1" token source="mkdocs.template.yml" target="mkdocs.yml"

  [ -f "$source" ] || __throwEnvironment "$usage" "missing $source" || return $?
  while IFS="" read -r token; do
    # skip lowercase
    [ "$token" != "$(lowercase "$token")" ] || continue
    __catchEnvironment "$usage" buildEnvironmentLoad "$token" || return $?
    export "${token?}"
  done < <(mapTokens <"$source")
  __catchEnvironment "$usage" mapEnvironment <"$source" >"$target" || return $?
}

# Build the build documentation
# fn: {base}
# Argument: --templates-only - Flag. Just template identical updates.
# Argument: --derived-only - Flag. Just derived files only.
# Argument: --reference-only - Flag. Just tools documentation.
# Argument: --clean - Flag. Clean caches.
# See: documentationBuild
__buildDocumentationBuild() {
  local usage="_${FUNCNAME[0]}"
  local here="${BASH_SOURCE[0]%/*}" home start

  start=$(timingStart) || return $?

  export APPLICATION_NAME

  local da=() ea=()
  local cleanFlag=false updateDerived=true updateTemplates=true updateReference=true makeDocumentation=true

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
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
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # Greeting
  __catchEnvironment "$usage" buildEnvironmentLoad APPLICATION_NAME || return $?
  statusMessage lineFill . "$(decorate info "${APPLICATION_NAME} documentation started on $(decorate value "$(date +"%F %T")")") "
  home=$(cd "$here/.." && pwd || _environment cd failed) || return $?

  # --clean
  if $cleanFlag; then
    # Clean env cache
    __catchEnvironment "$usage" documentationBuildEnvironment --clean || return $?
    # Clean reference cache
    __buildDocumentationBuildDirectory "$usage" "$home" --clean || return $?
    return 0
  fi

  # Ensure we have our target
  __catchEnvironment "$usage" muzzle directoryRequire "$home/documentation/docs" || return $?

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
    __buildDocumentationBuildRelease "$usage" "$home" || return $?

    statusMessage decorate notice "Updating mkdocs.yml ..."

    __catchEnvironment "$usage" muzzle pushd "./documentation" || return $?
    __mkdocsConfiguration "$usage" || return $?
    __catchEnvironment "$usage" muzzle popd || return $?

    local sourceHome="$home/documentation/source" targetHome="$home/documentation/docs"
    while IFS="" read -r file; do
      file=${file#"$sourceHome"}
      statusMessage decorate notice "Updating $file ..."
      __catchEnvironment "$usage" muzzle fileDirectoryRequire "$targetHome/$file" || return $?
      __catchEnvironment "$usage" cp -f "$sourceHome/$file" "$targetHome/$file" || return $?
    done < <(
      find "$sourceHome" -type f -name "*.md" ! -path "*/tools/*" ! -path "*/env/*"
      printf "%s\n" "$sourceHome/tools/index.md"
    )
    version=$(hookVersionCurrent) timestamp="$(date -u "+%F %T") UTC" __catchEnvironment "$usage" mapEnvironment <"$sourceHome/index.md" >"$targetHome/index.md" || return $?

    # Coding
    local example

    example="$(decorate wrap "    " <"$home/bin/build/tools/example.sh")" || __throwEnvironment "$usage" "generating example" || return $?
    example="$example" __catchEnvironment "$usage" mapEnvironment <"$home/documentation/source/guide/coding.md" >"$home/documentation/docs/guide/coding.md" || return $?

    statusMessage decorate notice "Updating env/index.md ..."
    __catchEnvironment "$usage" documentationBuildEnvironment --verbose "${ea[@]+"${ea[@]}"}" || return $?
  fi

  if "$updateReference"; then
    __catchEnvironment "$usage" __buildDocumentationBuildDirectory "$usage" "$home" "$@" "${da[@]+"${da[@]}"}" || return $?
  fi

  if "$makeDocumentation"; then
    if ! whichExists mkdocs; then
      __catchEnvironment "$usage" pythonInstall || return $?

      if [ ! -d "$home/.venv" ]; then
        whichExists mkdocs || __catchEnvironment "$usage" python -m pip install venv || return $?
        __catchEnvironment "$usage" python -m venv "$home/.venv" || return $?
      fi
      __catchEnvironment "$usage" "$home/.venv/bin/activate" || return $?
      whichExists mkdocs || __catchEnvironment "$usage" python -m pip install mkdocs || return $?
      whichExists mkdocs || __throwEnvironment "$usage" "mkdocs not found after installation?" || return $?
    fi
    __catchEnvironment "$usage" muzzle pushd "./documentation" || return $?
    __mkdocsConfiguration "$usage" || return $?

    __catchEnvironment "$usage" mkdocs build || return $?
    __catchEnvironment "$usage" muzzle popd || return $?
    __catchEnvironment "$usage" "$home/.venv/bin/deactivate" || return $?
  fi

  statusMessage --last timingReport "$start" "$(basename "${BASH_SOURCE[0]}") completed in"
}
___buildDocumentationBuild() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__tools .. __buildDocumentationBuild "$@"
