#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__buildDocumentationIsComplete() {
  local docPath="$1" && shift
  local tempFunctions="$1" && shift
  local finished && while ! $finished; do
    local fun && read -r fun || finished=true
    if [ -z "$fun" ] || ! isFunction "_$fun"; then continue; fi
    if [ ! -f "$docPath/$fun.sh" ]; then
      statusMessage decorate notice "$(decorate file "$docPath/$fun.sh") not found"
      return 1
    fi
  done <"$tempFunctions"
}

# Extract and build the bin/build/documentation/ cache
# Argument: --clean - Flag. Optional.
# Argument: --quick - Flag. Optional. Do quick updates to minimize time to generate new files.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional.Display this help.
buildDocumentationExtractionUpdate() {
  local handler="_${FUNCNAME[0]}"

  local cleanFlag=false quickFlag=false

  bashDebugInterruptFile

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --clean) cleanFlag=true ;;
    --quick) quickFlag=true ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  local docPath="$home/bin/build/documentation/"
  if $cleanFlag; then
    statusMessage decorate info "Cleaning $docPath"
    [ ! -d "$docPath" ] || catchEnvironment "$handler" find "$docPath" -type f -name '*.sh' ! -path '*/.*/*' -delete || return $?
  fi

  catchReturn "$handler" muzzle directoryRequire "$docPath" || return $?

  local tempFunctions totalFunctions

  tempFunctions=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempFunctions")
  catchReturn "$handler" buildFunctions >"$tempFunctions" || returnClean $? "${clean[@]}" || return $?
  totalFunctions=$(catchReturn "$handler" fileLineCount "$tempFunctions") || returnClean $? "${clean[@]}" || return $?
  if $quickFlag; then
    if ! __buildDocumentationIsComplete "$docPath" "$tempFunctions"; then
      local docToolsOldest toolsNewest toolsNewestTime

      toolsNewest=$(catchReturn "$handler" directoryNewestFile "$home/bin/build/tools") || returnClean $? "${clean[@]}" || return $?
      docToolsOldest=$(catchReturn "$handler" directoryOldestFile "$docPath") || returnClean $? "${clean[@]}" || return $?

      # `FILE1 -ot FILE2` - `FILE1` is older than `FILE2`
      if [ "$toolsNewest" -ot "$docToolsOldest" ]; then
        statusMessage --last decorate info "Everything is up to date."
        catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
        return 0
      fi
      toolsNewestTime=$(catchReturn "$handler" fileModificationTime "$toolsNewest") || returnClean $? "${clean[@]}" || return $?
      statusMessage decorate notice "$(decorate file "$toolsNewest") modified more recently than $(decorate file "$docToolsOldest")" || :

      catchEnvironment "$handler" printf -- "" >"$tempFunctions" || returnClean $? "${clean[@]}" || return $?
      local index=0

      while read -r modificationTime filePath; do
        index=$((index + 1))
        local fn="${filePath##*/}"
        fn="${fn%.sh}"
        # If a tool doc file was modified BEFORE the most recent TOOLS file (regardless) then we regenerate it
        if [ "$modificationTime" -lt "$toolsNewestTime" ]; then
          catchEnvironment "$handler" printf -- "%s\n" "$fn" >>"$tempFunctions" || return $?
        else
          statusMessage decorate info "Stopped at $fn (#$index) ... ($(dateFromTimestamp --local "$modificationTime") > $(dateFromTimestamp --local "$toolsNewestTime") - $(decorate file "$toolsNewest"))" || :
          break
        fi
      done < <(catchEnvironment "$handler" fileModificationTimes "$docPath" | sort -rn) || returnClean $? "${clean[@]}" || return $?
      totalFunctions=$(catchReturn "$handler" fileLineCount "$tempFunctions") || returnClean $? "${clean[@]}" || return $?
      statusMessage decorate info "Quick function count to compute is $totalFunctions" || :
    fi
  else
    statusMessage decorate info "Total function count to compute is $totalFunctions" || :
  fi
  local finished=false
  local index=0
  while ! $finished; do
    index=$((index + 1))
    local fun helpFun
    read -r fun || finished=true
    [ -n "$fun" ] || continue
    helpFun="_$fun"
    if ! isFunction "$helpFun"; then
      statusMessage decorate warning "No help for $fun ($helpFun not defined)" || :
      continue
    fi
    __buildDocumentationExtractionUpdateFunction "$handler" "$fun" "#$index/$totalFunctions -" || returnClean $? "${clean[@]}" || return $?
  done <"$tempFunctions" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
}
_buildDocumentationExtractionUpdate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Extract and build the bin/build/documentation/ cache
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional.Display this help.
# Argument: function - String. Required. Function to extract
# Argument: prefix ... - String. Optional. Prefix the status line with this text.
__buildDocumentationExtractionUpdateFunction() {
  local handler="$1" && shift
  local fun
  fun=$(validate "$handler" Function "function" "${1-}") && shift || return $?
  local prefix="$*" && set --
  [ -z "$prefix" ] || prefix="${prefix% } "
  local helpFun="_$fun"
  local prettyFun
  prettyFun=$(decorate code "$fun")
  if ! isFunction "$helpFun"; then
    statusMessage decorate warning "${prefix}No help for $prettyFun ($(decorate error "$helpFun") not defined)" || :
    return 0
  fi
  BUILD_DEBUG="documentation-cache" statusMessage timing --name "${prefix}$prettyFun" muzzle "$helpFun" 0 || returnClean $? "${clean[@]}" || return $?
}

__buildDocumentationBuildDirectory() {
  local handler="$1" && shift
  local home="$1" && shift
  local aa=() target
  local start

  start=$(timingStart)
  statusMessage decorate notice "Filling in missing files ..."

  # Fill in any missing files
  local documentationSource="$home/documentation/source"
  while read -r markdownFile; do
    target="$home/documentation/.docs${markdownFile#"$documentationSource"}"
    catchEnvironment "$handler" muzzle fileDirectoryRequire "$target" || return $?
    if [ ! -f "$target" ]; then
      catchEnvironment "$handler" cp "$markdownFile" "$target" || return $?
    fi
  done < <(find "$documentationSource" -name '*.md' ! -path '*/tools/*')

  source="$documentationSource/tools"
  target="$home/documentation/.docs/tools"

  catchEnvironment "$handler" muzzle directoryRequire "$target" || return $?
  statusMessage --last timingReport "$start" "Filled in missing files in"

  start=$(timingStart)
  statusMessage decorate notice "Creating skeleton file structure ..."
  local markdownFile
  while read -r markdownFile; do
    markdownFile=${markdownFile#"$source"}
    markdownFile="${target}/${markdownFile#/}"
    if [ ! -f "$markdownFile" ]; then
      catchEnvironment "$handler" muzzle fileDirectoryRequire "$markdownFile" || return $?
      catchEnvironment "$handler" touch "$markdownFile" || return $?
    fi
  done < <(find "$source" -type f -name '*.md' ! -path "*/.*/*")
  statusMessage --last timingReport "$start" "Created skeleton file structure in"

  functionTemplate="$(catchReturn "$handler" documentationTemplate "function")" || return $?

  aa+=(--source "$home/bin")
  aa+=(--target "$target")

  aa+=(--template "$source")
  aa+=(--unlinked-source "$documentationSource")
  aa+=(--unlinked-template "$source/todo.md" --unlinked-target "$target/todo.md")
  aa+=("--function-template" "$functionTemplate" --page-template "$home/documentation/template/__main.md")
  aa+=(--see-prefix "./documentation/.docs")
  aa+=(--see-environment-link "/env/index.md")

  # All functions
  local target=$home/documentation/source/tools/all.md
  catchEnvironment "$handler" cp "$home/documentation/source/templates/all.md" "$target" || return $?
  printf "\n" >>"$target"
  buildFunctions | sort -u | decorate wrap '- {SEE:' '}' >>"$target"

  catchReturn "$handler" documentationBuild "${aa[@]}" "$@" || return $?
}

__buildDocumentationCleanDirectory() {
  local handler="$1" && shift
  local home="$1" && shift
  local target="$home/documentation/.docs"

  aa+=(--source "$home/bin")

  catchReturn "$handler" muzzle directoryRequire "$target" || return $?
  catchReturn "$handler" documentationBuild "${aa[@]}" "--clean" "$@" || return $?

  catchEnvironment "$handler" rm -rf "$target" || return $?
}

__buildDocumentationBuildRelease() {
  local handler="$1" home="$2" release currentNotes notesPath
  local target="$home/documentation/.docs/release/index.md"
  local recentNotes=10 index

  currentNotes=$(catchReturn "$handler" releaseNotes --application "$home") || return $?

  catchReturn "$handler" muzzle fileDirectoryRequire "$target" || return $?

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
# Argument: --see-update - Flag. Documentation generation only.
# Argument: --index-update - Flag. Documentation generation only.
# Argument: --docs-update - Flag. Documentation generation only.
# Argument: --env-update - Flag. Just update env document.
# Argument: --clean - Flag. Clean caches.
# Argument: --verbose - Flag. Clean caches.
# Argument: --filter filters ... - DashDashDelimitedArguments. Arguments to filter which reference files are updated.
# Argument: --force - Flag. Force building of everything.
# Argument: --debug - Flag. Debugging output enabled.
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
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
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
    --debug) da+=(--debug) ;;
    --see-update | --index-update | --docs-update | --env-update) da+=("$argument") && updateReference=true ;;
    --verbose) da+=("$argument") && vv+=("$argument") && ea+=("$argument") && verboseFlag=true ;;
    --filter) da+=("$argument") && while [ $# -gt 0 ] && [ "$1" != "--" ]; do da+=("$1") && shift; done ;;
    --force) da+=("$argument") && ea+=("$argument") ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  # --clean
  if $cleanFlag; then
    ! $verboseFlag || statusMessage decorate info "Cleaning documentation ... "
    # Clean env cache
    catchReturn "$handler" documentationBuildEnvironment --clean || return $?
    # Clean reference cache
    __buildDocumentationCleanDirectory "$handler" "$home" "${vv[@]+"${vv[@]}"}" || return $?
    return 0
  fi

  local version
  version=$(hookVersionCurrent)
  local timestamp
  timestamp="$(date -u "+%F %T") UTC"

  # Greeting
  catchReturn "$handler" buildEnvironmentLoad APPLICATION_NAME || return $?
  statusMessage lineFill . "$(decorate info "${APPLICATION_NAME} documentation started on $(decorate value "$(date +"%F %T")")") "

  if $verboseFlag; then
    decorate pair "Update Templates" "$updateTemplates"
    decorate pair "Update Derived" "$updateDerived"
    decorate pair "Update Reference" "$updateReference"
    decorate pair "Make Documentation" "$makeDocumentation"
  fi

  local targetHome="$home/documentation/.docs"
  local documentationSource="$home/documentation/source"

  # Ensure we have our target
  catchEnvironment "$handler" muzzle directoryRequire "$targetHome" || return $?

  # Templates should be up-to-date if making documentation
  if ! $updateTemplates && $makeDocumentation; then

    local newestTemplate newestDocs
    newestTemplate=$(directoryNewestFile "$home/documentation/template")
    newestDocs=$(directoryNewestFile "$documentationSource")
    if [ -z "$newestDocs" ] || fileIsNewest "$newestTemplate" "$newestDocs"; then
      updateTemplates=true
      ! $verboseFlag || statusMessage decorate info "Templates were changed, update templates is now automatic"
    fi
  fi

  if $updateTemplates; then
    statusMessage --last decorate notice "Updating document templates ..."
    documentationTemplateUpdate "$documentationSource" "$home/documentation/template" || return $?
  fi

  if $updateDerived; then
    local file

    statusMessage --last decorate notice "Updating release page ..."
    __buildDocumentationBuildRelease "$handler" "$home" || return $?

    statusMessage --last decorate notice "Copying all non-tools ..."
    while IFS="" read -r file; do
      file=${file#"$documentationSource"}
      statusMessage decorate notice "Copying $file ..."
      catchEnvironment "$handler" muzzle fileDirectoryRequire "$targetHome/$file" || return $?
      cp -f "$documentationSource/$file" "$targetHome/$file" || return $?
    done < <(
      find "$documentationSource" -type f -name "*.md" ! -path "*/tools/*" ! -path "*/env/*" -print0 | xargs -0 grep -v -l '{[A-Za-z][^]!\[}]*}' || :
    )

    local example

    example="$(decorate wrap "    " <"$home/bin/build/tools/example.sh")" || throwEnvironment "$handler" "generating example" || return $?

    # Mappable files
    statusMessage --last decorate notice "Mapping non-tools ..."
    while IFS="" read -r file; do
      file=${file#"$documentationSource"}
      statusMessage decorate notice "Updating $file ..."
      catchEnvironment "$handler" muzzle fileDirectoryRequire "$targetHome/$file" || return $?
      example="$example" timestamp="$timestamp" version="$version" catchReturn "$handler" mapEnvironment <"$documentationSource/$file" >"$targetHome/$file" || return $?
    done < <(
      find "$documentationSource" -type f -name "*.md" ! -path "*/tools/*" ! -path "*/env/*" -print0 | xargs -0 grep -l '{[A-Za-z][^]!\[}]*}' || :
    )
    statusMessage --last decorate notice "Updating environment variables document ..."

    local targetEnv="$home/documentation/.docs/env/index.md"
    catchReturn "$handler" fileDirectoryRequire "$targetEnv" || return $?
    catchReturn "$handler" cp "$home/documentation/source/env/index.md" "$targetEnv" || return $?
    ea=(--verbose
      --source "$home/bin/build/env"
      --template-path "$home/documentation/template"
      --target "$targetEnv"
      "${ea[@]+"${ea[@]}"}")
    catchReturn "$handler" documentationBuildEnvironment "${ea[@]+"${ea[@]}"}" || return $?
  fi

  if "$updateReference"; then
    statusMessage --last decorate notice "Building Bash documentation and reference ..."
    __buildDocumentationBuildDirectory "$handler" "$home" "$@" "${da[@]+"${da[@]}"}" || return $?
  fi

  if "$makeDocumentation"; then
    timestamp="$timestamp" version="$version" documentationMkdocs --handler "$handler" --path "./documentation" --package mkdocs-material || return $?
  fi

  statusMessage --last timingReport "$start" "$(basename "${BASH_SOURCE[0]}") completed in"
}
_buildDocumentationBuild() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
