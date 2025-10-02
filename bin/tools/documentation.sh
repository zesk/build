#!/usr/bin/env bash
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#

__buildDocumentationBuildDirectory() {
  local handler="$1" && shift
  local home="$1" && shift
  local aa=() target
  local start

  start=$(timingStart)
  statusMessage decorate notice "Filling in missing files ..."

  # Fill in any missing files
  local prefix="$home/documentation/source"
  while read -r markdownFile; do
    target="$home/documentation/.docs${markdownFile#"$prefix"}"
    __catchEnvironment "$handler" muzzle fileDirectoryRequire "$target" || return $?
    if [ ! -f "$target" ]; then
      __catchEnvironment "$handler" cp "$markdownFile" "$target" || return $?
    fi
  done < <(find "$prefix" -name '*.md' ! -path '*/tools/*')

  source="$home/documentation/source/tools"
  target="$home/documentation/.docs/tools"

  __catchEnvironment "$handler" muzzle directoryRequire "$target" || return $?
  statusMessage --last timingReport "$start" "Filled in missing files in"

  start=$(timingStart)
  statusMessage decorate notice "Creating skeleton file structure ..."
  local markdownFile
  while read -r markdownFile; do
    markdownFile=${markdownFile#"$source"}
    markdownFile="${target}/${markdownFile#/}"
    if [ ! -f "$markdownFile" ]; then
      __catchEnvironment "$handler" muzzle fileDirectoryRequire "$markdownFile" || return $?
      __catchEnvironment "$handler" touch "$markdownFile" || return $?
    fi
  done < <(find "$source" -type f -name '*.md' ! -path "*/.*/*")
  statusMessage --last timingReport "$start" "Created skeleton file structure in"

  functionTemplate="$(__catch "$handler" documentationTemplate "function")" || return $?

  aa+=(--source "$home/bin")
  aa+=(--template "$source")
  aa+=(--unlinked-template "$home/documentation/source/tools/todo.md" --unlinked-target "$home/documentation/.docs/tools/todo.md")
  aa+=("--function-template" "$functionTemplate" --page-template "$home/documentation/template/__main.md")
  aa+=(--see-prefix "./documentation/.docs")
  aa+=(--target "$target")

  __catch "$handler" documentationBuild "${aa[@]}" "$@" || return $?
}

__buildDocumentationCleanDirectory() {
  local handler="$1" && shift
  local home="$1" && shift

  aa+=(--source "$home/bin")
  aa+=(--target "$target")

  __catch "$handler" documentationBuild "${aa[@]}" "--clean" "$@" || return $?
}

__buildDocumentationBuildRelease() {
  local handler="$1" home="$2" release currentNotes notesPath
  local target="$home/documentation/.docs/release/index.md"
  local recentNotes=10 index

  currentNotes=$(__catch "$handler" releaseNotes --application "$home") || return $?

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
  version="$version" __catch "$handler" mapEnvironment <"$source" >"$target" || return $?
}

# Argument: pass - Boolean. true if version should be a variable, false if it should be set to a value
__checkVersionVariable() {
  local handler="$1" pass="$2" line="$3"

  local home
  home=$(__catch "$handler" buildHome) || return $?
  checkFile="$home/documentation/.docs/index.md"
  if [ -f "$checkFile" ]; then
    local title
    title=$(basename "$checkFile")
    if grep -q '{version}' <"$checkFile"; then
      [ "$pass" = false ] || __throwEnvironment "$handler" "Version is not a variable ($pass) and should be (line $line)" || returnUndo $? dumpPipe --lines 3 "$title" <"$checkFile" || return $?
    else
      [ "$pass" = true ] || __throwEnvironment "$handler" "Version is a {variable} ($pass) and should NOT be (line $line)" || returnUndo $? dumpPipe --lines 3 "$title" <"$checkFile" || return $?
    fi
  else
    [ "$pass" = false ] || __throwEnvironment "$handler" "$(decorate file "$checkFile") is missing and should exist (line $line)" || return $?
  fi
}

# Build the build documentation
# fn: {base}
# Argument: --none - Flag. Turn off all updates.
# Argument: --templates-only - Flag. Just template identical updates.
# Argument: --templates - Flag. Enable template updates.
# Argument: --no-templates - Flag. Disable template updates.
# Argument: --derived - Flag. Enable derived files updates.
# Argument: --no-derived - Flag. Disable derived files updates.
# Argument: --derived-only - Flag. Just derived files only.
# Argument: --reference - Flag. Enable reference file updates.
# Argument: --no-reference - Flag. Disable reference file updates.
# Argument: --reference-only - Flag. Reference file updates.
# Argument: --mkdocs - Flag. Enable documentation generation.
# Argument: --no-mkdocs - Flag. Disable documentation generation.
# Argument: --mkdocs-only - Flag. Documentation generation only.
# Argument: --clean - Flag. Clean caches.
# Argument: --verbose - Flag. Clean caches.
# Argument: --filter filters ... - DashDashDelimitedArguments. Arguments to filter which reference files are updated.
# Argument: --force - Flag. Force building of everything.
# See: documentationBuild
buildDocumentationBuild() {
  local handler="_${FUNCNAME[0]}"
  local start

  start=$(timingStart) || return $?

  export APPLICATION_NAME

  local da=() ea=() vv=()
  local cleanFlag=false updateDerived=true updateTemplates=false updateReference=true makeDocumentation=true
  local verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --none) updateDerived=false && updateTemplates=false && updateReference=false && makeDocumentation=false ;;
    --all) updateDerived=true && updateTemplates=true && updateReference=true && makeDocumentation=true ;;
    --templates) updateTemplates=true ;;
    --no-templates) updateTemplates=false ;;
    --templates-only) updateDerived=false && updateTemplates="true" && updateReference=false && makeDocumentation=false ;;
    --derived) updateDerived=true ;;
    --no-derived) updateDerived=false ;;
    --derived-only) updateDerived="true" && updateTemplates=false && updateReference=false && makeDocumentation=false ;;
    --reference) updateReference=true ;;
    --no-reference) updateReference=false ;;
    --reference-only) updateDerived=false && updateTemplates=false && updateReference="true" && makeDocumentation=false ;;
    --mkdocs) makeDocumentation=true ;;
    --no-mkdocs) makeDocumentation=false ;;
    --mkdocs-only) updateDerived=false && updateTemplates=false && updateReference=false && makeDocumentation="true" ;;
    --clean) cleanFlag=true ;;
    --verbose) da+=("$argument") && vv+=("$argument") && ea+=("$argument") && verboseFlag=true ;;
    --filter) da+=("$argument") && while [ $# -gt 0 ] && [ "$1" != "--" ]; do da+=("$1") && shift; done ;;
    --force) da+=("$argument") && ea+=("$argument") ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  # --clean
  if $cleanFlag; then
    ! $verboseFlag || statusMessage decorate info "Cleaning documentation ... "
    # Clean env cache
    __catch "$handler" documentationBuildEnvironment --clean || return $?
    # Clean reference cache
    __buildDocumentationCleanDirectory "$handler" "$home" "${vv[@]+"${vv[@]}"}" || return $?
    __checkVersionVariable "$handler" true "$LINENO" || return $?
    return 0
  fi

  local version
  version=$(hookVersionCurrent)
  local timestamp
  timestamp="$(date -u "+%F %T") UTC"

  # Greeting
  __catch "$handler" buildEnvironmentLoad APPLICATION_NAME || return $?
  statusMessage lineFill . "$(decorate info "${APPLICATION_NAME} documentation started on $(decorate value "$(date +"%F %T")")") "
  home=$(__catch "$handler" buildHome) || return $?

  if $verboseFlag; then
    decorate pair "Update Templates" "$updateTemplates"
    decorate pair "Update Derived" "$updateDerived"
    decorate pair "Update Reference" "$updateReference"
    decorate pair "Make Documentation" "$makeDocumentation"
  fi

  local targetHome="$home/documentation/.docs"

  # Ensure we have our target
  __catchEnvironment "$handler" muzzle directoryRequire "$targetHome" || return $?

  if ! __checkVersionVariable "$handler" false "$LINENO" 2>/dev/null; then
    ! $verboseFlag || statusMessage decorate warning "Removing index.md which has incorrect version, derived is automatic"
    __catchEnvironment "$handler" rm -f "$targetHome/index.md" || return $?
    updateDerived=true
  fi

  # Templates should be up-to-date if making documentation
  if ! $updateTemplates && $makeDocumentation; then
    local newestTemplate newestDocs
    newestTemplate=$(directoryNewestFile "$home/documentation/template")
    newestDocs=$(directoryNewestFile "$home/documentation/source")
    if [ -z "$newestDocs" ] || fileIsNewest "$newestTemplate" "$newestDocs"; then
      updateTemplates=true
      ! $verboseFlag || statusMessage decorate info "Templates were changed, update templates is now automatic"
    fi
  fi

  __checkVersionVariable "$handler" false "$LINENO" || return $?

  if $updateTemplates; then
    statusMessage --last decorate notice "Updating document templates ..."
    documentationTemplateUpdate "$home/documentation/source" "$home/documentation/template" || return $?
  fi

  if $updateDerived; then
    local file

    statusMessage --last decorate notice "Updating release page ..."
    __buildDocumentationBuildRelease "$handler" "$home" || return $?

    __checkVersionVariable "$handler" false "$LINENO" || return $?

    local sourceHome="$home/documentation/source"

    while IFS="" read -r file; do
      file=${file#"$sourceHome"}
      statusMessage decorate notice "Copying $file ..."
      __catchEnvironment "$handler" muzzle fileDirectoryRequire "$targetHome/$file" || return $?
      cp -f "$sourceHome/$file" "$targetHome/$file" || return $?
    done < <(
      find "$sourceHome" -type f -name "*.md" ! -path "*/tools/*" ! -path "*/env/*" -print0 | xargs -0 grep -v -l '{[A-Za-z][^]!\[}]*}'
    )

    # Mappable files
    while IFS="" read -r file; do
      file=${file#"$sourceHome"}
      statusMessage decorate notice "Updating $file ..."
      __catchEnvironment "$handler" muzzle fileDirectoryRequire "$targetHome/$file" || return $?
      timestamp="$timestamp" version="$version" __catch "$handler" mapEnvironment <"$sourceHome/$file" >"$targetHome/$file" || return $?
    done < <(
      find "$sourceHome" -type f -name "*.md" ! -path "*/tools/*" ! -path "*/env/*" -print0 | xargs -0 grep -l '{[A-Za-z][^]!\[}]*}'
    )
    __checkVersionVariable "$handler" true "$LINENO" || return $?

    # Coding
    local example

    example="$(decorate wrap "    " <"$home/bin/build/tools/example.sh")" || __throwEnvironment "$handler" "generating example" || return $?
    example="$example" __catch "$handler" mapEnvironment <"$home/documentation/source/guide/coding.md" >"$home/documentation/.docs/guide/coding.md" || return $?

    statusMessage --last decorate notice "Updating env/index.md ..."
    __catch "$handler" documentationBuildEnvironment --verbose "${ea[@]+"${ea[@]}"}" || return $?

    __checkVersionVariable "$handler" true "$LINENO" || return $?
  fi

  if "$updateReference"; then
    statusMessage --last decorate notice "Building Bash documentation and reference ..."
    __buildDocumentationBuildDirectory "$handler" "$home" "$@" "${da[@]+"${da[@]}"}" || return $?

    __checkVersionVariable "$handler" true "$LINENO"
  fi

  if "$makeDocumentation"; then
    if ! whichExists mkdocs; then

      statusMessage --last decorate notice "Installing python and mkdocs ..."
      __catchEnvironmentQuiet "$handler" - pythonInstall || return $?

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
        __catchEnvironmentQuiet "$handler" - python -m venv "$home/.venv" || return $?
      fi
      __catchEnvironment "$handler" source "$home/.venv/bin/activate" || return $?
      if ! pythonPackageInstalled mkdocs; then
        __catchEnvironmentQuiet "$handler" - python -m pip install mkdocs mkdocs-material || return $?
        whichExists mkdocs || __throwEnvironment "$handler" "mkdocs not found after installation?" || return $?
      fi
    else

      __catchEnvironment "$handler" source "$home/.venv/bin/activate" || return $?
    fi

    __catchEnvironment "$handler" muzzle pushd "./documentation" || return $?
    statusMessage --last decorate notice "Updating mkdocs.yml ..."

    __checkVersionVariable "$handler" true "$LINENO" || return $?

    timestamp="$timestamp" version="$version" __mkdocsConfiguration "$handler" || return $?
    __checkVersionVariable "$handler" true "$LINENO" || return $?
    tempLog=$(fileTemporaryName "$handler") || return $?
    __catchEnvironmentQuiet "$handler" "$tempLog" python -m mkdocs build || returnUndo $? dumpPipe "mkdocs log" <"$tempLog" || returnClean $? "$tempLog" || return $?
    __catchEnvironment "$handler" rm -f "$tempLog" || return $?
    __checkVersionVariable "$handler" true "$LINENO" || return $?
    __catchEnvironment "$handler" muzzle popd || return $?
  fi

  statusMessage --last timingReport "$start" "$(basename "${BASH_SOURCE[0]}") completed in"
}
_buildDocumentationBuild() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
