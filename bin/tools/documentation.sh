#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Argument: handler - Function. Required.
# Argument: docPath - Directory. Required.
# Argument: tempFunctions - File. Required. File containing list of function names
__buildUsageIsComplete() {
  local handler="$handler" && shift
  local docPath="$1" && shift
  local tempFunctions="$1" && shift
  local missing=() finished=false && while ! $finished; do
    local fun && read -r fun || finished=true
    if [ -z "$fun" ] || ! isFunction "_$fun"; then continue; fi
    if [ ! -f "$docPath/$fun.sh" ]; then
      missing+=("$fun")
    fi
  done <"$tempFunctions"
  finished=false && while ! $finished; do
    local file fun && read -r file || finished=true
    [ -n "$file" ] || continue
    fun="${file##*/}" && fun="${fun%.sh}"
    if ! isFunction "$fun"; then
      catchReturn "$handler" statusMessage --last decorate error "File $(decorate file "$file") has no matching function $(decorate code "$fun") anymore" || return $?
    fi
  done < <(find "$docPath" -type f -name '*.sh')
  local index=0 fun
  [ "${#missing[@]}" -eq 0 ] || for fun in "${missing[@]}"; do
    index=$((index + 1))
    catchReturn "$handler" statusMessage decorate warning "Loading missing: $fun" || return $?
    __buildUsageCompileFunction "$handler" "$docPath" "$fun" "Missing #$index/${#missing[@]}" || return $?
  done
  catchReturn "$handler" statusMessage decorate info "No functions missing" || return $?
}

# Extract and build the bin/build/documentation/ cache
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --all - Flag. Optional. Do everything regardless of cache state.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
buildUsageCompile() {
  local handler="_${FUNCNAME[0]}"

  local cleanFlag=false quickFlag=true

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
    --all) quickFlag=false ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local docPath="$home/bin/build/documentation"
  if $cleanFlag; then
    catchReturn "$handler" statusMessage decorate info "Cleaning $docPath" || return $?
    [ ! -d "$docPath" ] || catchEnvironment "$handler" find "$docPath" -type f -name '*.sh' ! -path '*/.*/*' -delete || return $?
    return 0
  fi

  local start && start=$(timingStart)

  catchReturn "$handler" muzzle directoryRequire "$docPath" || return $?

  local tempFunctions actualTotalFunctions totalFunctions

  tempFunctions=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempFunctions")
  catchReturn "$handler" buildFunctions >"$tempFunctions" || returnClean $? "${clean[@]}" || return $?
  totalFunctions=$(catchReturn "$handler" fileLineCount "$tempFunctions") || returnClean $? "${clean[@]}" || return $?
  actualTotalFunctions=$totalFunctions
  if $quickFlag; then
    if __buildUsageIsComplete "$handler" "$docPath" "$tempFunctions"; then
      local allModificationTimes="$tempFunctions.all"
      clean+=("$allModificationTimes")
      {
        catchReturn "$handler" fileModificationTimes "$home/bin/build/tools/" -name '*.sh' || return $?
        catchReturn "$handler" fileModificationTimes "$docPath" -name '*.sh' || return $?
      } | catchReturn "$handler" sort -rn >"$allModificationTimes" || returnClean $? "${clean[@]}" || return $?

      local filePath
      while read -r filePath; do
        # If prefixed with a docPath, then skip it
        [ "${filePath#"$docPath"}" = "$filePath" ] || continue
        grep "$docPath" | removeFields 1 | cut -d . -f 1 | cut "-c$((2 + ${#docPath}))-" >"$tempFunctions"
        break
      done < <(removeFields 1 <"$allModificationTimes")
      catchEnvironment "$handler" rm -f "$tempFunctions.all" || return $?
      totalFunctions=$(catchReturn "$handler" fileLineCount "$tempFunctions") || returnClean $? "${clean[@]}" || return $?
      catchReturn "$handler" statusMessage decorate info "Optimized function count to check is $totalFunctions (Actual is $actualTotalFunctions)" || return $?
    else
      catchReturn "$handler" statusMessage decorate info "Total function count to compute is $totalFunctions" || return $?
    fi
  else
    catchReturn "$handler" statusMessage decorate info "Total function count to compute is $totalFunctions" || return $?
  fi
  local finished=false
  local index=0

  while ! $finished; do
    index=$((index + 1))
    local prefix="#$index/$totalFunctions -"
    local fun && read -r fun || finished=true
    [ -n "$fun" ] || continue
    local prettyFun && prettyFun="$(decorate code "$fun")"
    statusMessage timing --name "$prefix $prettyFun" __buildUsageCompileFunction "$handler" "$docPath" "$fun" "$prefix" || return $?
  done <"$tempFunctions" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?

  catchReturn "$handler" statusMessage --last timingReport "$start" "$totalFunctions completed in" || return $?
}
_buildUsageCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Extract and build the bin/build/documentation/ cache
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: handler - Function. Required.
# Argument: docPath - Directory. Required.
# Argument: function - String. Required. Function to extract
# Argument: prefix ... - String. Optional. Prefix the status line with this text.
__buildUsageCompileFunction() {
  local handler="$1" && shift
  local docPath="$1" && shift

  local fun && fun=$(validate "$handler" Function "function" "${1-}") && shift || return $?
  local documentationSettingsFile="$docPath/$fun.sh"
  local prefix="$*" && set -- && [ -z "$prefix" ] || prefix="${prefix% } "
  local prettyFun && prettyFun=$(catchReturn "$handler" decorate code "$fun") || return $?

  local sourceFile=""

  if [ -f "$documentationSettingsFile" ]; then
    sourceFile=$(
      # shellcheck source=/dev/null
      local sourceFile && source "$documentationSettingsFile" || : && printf "%s\n" "${sourceFile-}" || :
    ) || :
    if [ -z "$sourceFile" ]; then
      statusMessage --last decorate error "Corrupt $documentationSettingsFile - removing" || return $?
      catchEnvironment "$handler" rm -f "$documentationSettingsFile" || return $?
    fi
  fi
  if [ -z "$sourceFile" ]; then
    sourceFile=$(__bashDocumentation_FindFunctionDefinitions "$(buildHome)/bin/build/tools" "$fun") || return $?
    local sourcesFound && sourcesFound=$(catchReturn "$handler" printf "%s\n" "$sourceFile" | fileLineCount) || return $?
    if [ "$sourcesFound" -gt 1 ]; then
      throwEnvironment "$handler" "${prefix} Multiple sources found for $prettyFun (x$sourcesFound): ${sourceFile//$'\n'/, }" || return $?
    fi
    [ -f "$sourceFile" ] || throwEnvironment "$handler" "${prefix} No source found for $prettyFun" || return $?
  fi

  local tempComment="$docPath/$fun.$$.comment" tempHelp="$docPath/$fun.$$.help"
  clean+=("$tempComment" "$tempHelp")

  catchReturn "$handler" bashFunctionComment "$sourceFile" "$fun" >"$tempComment" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" rm -f "$documentationSettingsFile" || return $?
  catchReturn "$handler" muzzle bashDocumentationExtract --generate "$fun" "$sourceFile" <"$tempComment" || returnClean $? "${clean[@]}" || return $?
  if [ ! -f "$documentationSettingsFile" ]; then
    throwEnvironment "$handler" "${prefix}: bashDocumentationExtract $fun $sourceFile did not generate $documentationSettingsFile" || returnClean $? "${clean[@]}" || return $?
  else
    BUILD_DEBUG="" BUILD_COLORS=true catchEnvironment "$handler" usageDocument "$sourceFile" "$fun" 0 >"$tempHelp" || returnClean $? "${clean[@]}" || return $?
    {
      catchEnvironment "$handler" printf "%s\n%s=%s\n" "# shellcheck disable=SC2016" "helpConsole" "$(escapeBash <"$tempHelp")" || return $?
      catchEnvironment "$handler" printf "%s\n%s=%s\n" "# shellcheck disable=SC2016" "helpPlain" "$(escapeBash <"$tempHelp" | stripAnsi)" || return $?
    } >>"$documentationSettingsFile" || returnClean $? "${clean[@]}" || return $?
    if buildDebugEnabled "usage-compile"; then
      dumpPipe "Help for $fun" <"$tempHelp" 1>&2
      dumpPipe "Settings for $fun" <"$documentationSettingsFile" 1>&2
    fi
    catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
    catchEnvironment "$handler" touch "$documentationSettingsFile" || returnClean $? "${clean[@]}" || return $?
  fi
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
  catchReturn "$handler" buildUsageCompile --clean || return $?
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
    done < <(find "$documentationSource" -type f -name "*.md" ! -path "*/tools/*" ! -path "*/env/*" -print0 | xargs -0 grep -v -l '{[A-Za-z][^]!\[}]*}')

    local example

    example="$(decorate wrap "    " <"$home/bin/build/tools/example.sh")" || throwEnvironment "$handler" "generating example" || return $?

    # Mappable files
    statusMessage --last decorate notice "Mapping non-tools ..."
    while IFS="" read -r file; do
      file=${file#"$documentationSource"}
      statusMessage decorate notice "Updating $file ..."
      catchEnvironment "$handler" muzzle fileDirectoryRequire "$targetHome/$file" || return $?
      example="$example" timestamp="$timestamp" version="$version" catchReturn "$handler" mapEnvironment <"$documentationSource/$file" >"$targetHome/$file" || return $?
    done < <(find "$documentationSource" -type f -name "*.md" ! -path "*/tools/*" ! -path "*/env/*" -print0 | xargs -0 grep -l '{[A-Za-z][^]!\[}]*}')
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
