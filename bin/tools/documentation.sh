#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

_documentationTemplateFormatter_builtin() {
  local eof=false && while ! $eof; do
    local tokens=() && IFS=" " read -d $'\n' -r -a tokens || eof=true
    [ "${#tokens[@]}" -eq 0 ] || local token && for token in "${tokens[@]}"; do
      printf -- "[\`%s\`]({rel}/guide/builtin.md#%s)\n" "$token" "$(stringLowercase "$token")"
    done
  done
}

#__buildDocumentationBuildDirectory() {
#  local handler="$1" && shift
#  local home="$1" && shift
#  local start && start=$(timingStart) && statusMessage decorate notice "Copying ..."
#
#  local documentationSource="$home/documentation/source"
#  local templateSource="$home/documentation/template"
#  local source="$documentationSource/tools"
#  local target="$home/documentation/.docs/tools"
#
#  catchReturn "$handler" cp -f "$home/etc/"*.svg "$home/etc/"*.png "$documentationSource/images/" || return $?
#  catchReturn "$handler" muzzle rm -rf "$home/documentation/.docs" || return $?
#  catchReturn "$handler" statusMessage timing --name "Copied documentation" cp -rf "$documentationSource" "$home/documentation/.docs" || return $?
#
#  local functionTemplate && functionTemplate="$(catchReturn "$handler" documentationTemplate "function")" || return $?
#
#  local aa=()
#
#  # Our source code lookup is here
#  aa+=(--source "$home/bin")
#
#  # Output generated files here
#  aa+=(--target "$target")
#
#  # Directory of files to convert
#  aa+=(--template "$source")
#
#  # Functions not documented in the documentation use
#  # `--unlinked-source` and `--unlinked-target` and `--unlinked-template`
#  aa+=(--unlinked-source "$source")
#  aa+=(--unlinked-template "$source/todo.md" --unlinked-target "$target/todo.md")
#
#  # Template generation
#  aa+=(
#    "--function-template" "$functionTemplate"
#    "--page-template" "$templateSource/__main.md"
#  )
#  # See stuff
#  aa+=(--see-prefix "./documentation/.docs")
#  # Env stuff
#  aa+=(--see-environment-link "/env/index.md")
#
#  # All functions
#  local allTarget="$source/all.md"
#  catchEnvironment "$handler" cp "$templateSource/all.md" "$allTarget" || return $?
#  catchReturn "$handler" cp "$templateSource/todo.md" "$source/todo.md" || return $?
#
#  printf "\n" >>"$allTarget"
#
#  local fun && while read -r fun; do
#    local seeFile && if seeFile=$(__documentationFile "$home" "SEE/$fun"); then
#      decorate wrap "- " "" <"$seeFile" | rel="../" mapEnvironment
#    else
#      printf -- "- {SEE:%s} %s\n" "$fun" "<!-- later -->"
#    fi
#  done < <(buildFunctions | sort -u) >>"$allTarget"
#
#  #  ┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
#  #  │      _                                       _        _   _             ____        _ _     _     │
#  #  │   __| | ___   ___ _   _ _ __ ___   ___ _ __ | |_ __ _| |_(_) ___  _ __ | __ ) _   _(_) | __| |    │
#  #  │  / _` |/ _ \ / __| | | | '_ ` _ \ / _ \ '_ \| __/ _` | __| |/ _ \| '_ \|  _ \| | | | | |/ _` |    │
#  #  │ | (_| | (_) | (__| |_| | | | | | |  __/ | | | || (_| | |_| | (_) | | | | |_) | |_| | | | (_| |    │
#  #  │  \__,_|\___/ \___|\__,_|_| |_| |_|\___|_| |_|\__\__,_|\__|_|\___/|_| |_|____/ \__,_|_|_|\__,_|    │
#  #  │                                                                                                   │
#  #  └───────────────────────────────────────────────────────────────────────────────────────────────────┘
#  catchReturn "$handler" documentationBuild "${aa[@]}" "$@" || return $?
#}

__buildDocumentationCleanDirectory() {
  local handler="$1" && shift
  local home="$1" && shift
  catchEnvironment "$handler" rm -rf "$home/documentation/.docs" "$home/documentation/.site" "$home/documentation/.template" || return $?
}

__buildDocumentationBuildMissing() {
  local handler="$1" && shift
  local home="$1" && shift
  local templateSource="$1" && shift

  statusMessage decorate info "Generating documentation index ..."
  local start && start=$(timingStart) || return $?
  local indexHome && indexHome=$(catchReturn "$handler" directoryRequire "$home/documentation/template/index") || return $?
  catchReturn "$handler" documentationIndexGenerate --target "$indexHome" "$home/bin/tools" || return $?
  catchReturn "$handler" documentationIndexDocumentation --target "$indexHome" "$home/documentation/source" || return $?
  statusMessage timingReport "$start" "Documentation index generated"
  local tempMissing="$templateSource/missingFunctions.$$"
  local clean=("$tempMissing")
  documentationIndexUnlinkedFunctions "$indexHome" | grepSafe -v '^_' | sort >"$tempMissing" || returnClean $? "${clean[@]}" || return $?
  fileLineCount <"$tempMissing" >"$templateSource/missingFunctionTotal.md" || returnClean $? "${clean[@]}" || return $?
  sed 's/.*/{&}\n/g' <"$tempMissing" >"$templateSource/missingFunctionList.md" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" rm -rf "$tempMissing" || return $?
}

__buildDocumentationBuildReleaseNotes() {
  local handler="$1" && shift
  local home="$1" && shift
  local currentNotes && currentNotes=$(catchReturn "$handler" releaseNotes --application "$home") || return $?
  __buildDocumentationBuildReleaseNotesContent "$handler" "$(dirname "$currentNotes")" || return $?
}

__buildDocumentationBuildReleaseNotesContent() {
  local handler="$1" notesPath="$2"
  local recentNotes=10 index

  local index=0
  local release && while IFS="" read -r release; do
    local vv=${release##*/}
    vv="${vv%.*}"
    if [ "$index" -lt "$recentNotes" ]; then
      printf "%s\n" "" "$(markdownIndentHeading <"$release")"
    elif [ "$index" -eq "$recentNotes" ]; then
      # Between
      printf -- "%s\n" "" "# Past releases" ""
    fi
    if [ "$index" -ge "$recentNotes" ]; then
      printf -- "- [%s](%s)\n" "$vv" "./$vv.md"
    fi
    ((index++))
  done < <(find "$notesPath" -name "*.md" | textVersionSort -r)
}

# Build the build documentation
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
# Argument: --mkdocs - Flag. Enable `mkdocs` generation.
# Argument: --no-mkdocs - Flag. Disable `mkdocs` generation.
# Argument: --mkdocs-only - Flag. `mkdocs` generation only.
# Argument: --index-update - Flag. Update documentation indexes.`
# Argument: --docs-update - Flag. Documentation generation only.
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

  local da=() vv=()
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
    --verbose) da+=("$argument") && vv+=("$argument") && verboseFlag=true ;;
    --filter) da+=("$argument") && while [ $# -gt 0 ] && [ "$1" != "--" ]; do da+=("$1") && shift; done ;;
    --force) da+=("$argument") && ea+=("$argument") ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  # --clean
  if $cleanFlag; then
    ! $verboseFlag || statusMessage decorate info "Cleaning documentation ... "
    # Clean env cache
    catchReturn "$handler" documentationEnvironmentMake --clean || return $?
    # Clean reference cache
    __buildDocumentationCleanDirectory "$handler" "$home" || return $?
    return 0
  fi

  local version && version=$(catchReturn "$handler" hookVersionCurrent) || return $?
  local timestamp && timestamp="$(catchReturn "$handler" date -u "+%F %T") UTC" || return $?

  # Greeting
  local applicationName && applicationName=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
  statusMessage --last consoleHeadingLine . "$(decorate info "$applicationName documentation started on $(decorate value "$(date +"%F %T")")") "

  local documentationSource="$home/documentation/source"
  local documentationTarget="$home/documentation/.docs"
  local templateSource="$home/documentation/template/docs"
  local templateCompiled="$home/documentation/.template"

  # Ensure we have our target
  catchEnvironment "$handler" muzzle directoryRequire "$documentationTarget" "$templateCompiled" || return $?
  printf "%s" "$applicationName" >"$templateSource/applicationName.md"
  printf "%s" "$(buildEnvironmentGet APPLICATION_OWNER)" >"$templateSource/applicationOwner.md"
  printf "%s" "$(date +%Y)" >"$templateSource/year.md"
  printf "%s" "$version" >"$templateSource/version.md"
  printf "%s" "$timestamp" >"$templateSource/timestamp.md"

  # Templates should be up-to-date if making documentation
  if ! $updateTemplates && $makeDocumentation; then
    local newestTemplate && newestTemplate=$(directoryNewestFile "$home/documentation/template/identical")
    local newestDocs && newestDocs=$(directoryNewestFile "$documentationSource")
    if [ -z "$newestDocs" ] || fileIsNewest "$newestTemplate" "$newestDocs"; then
      updateTemplates=true
      ! $verboseFlag || statusMessage decorate info "Templates were changed, update templates is now automatic"
    fi
  fi
  if $verboseFlag; then
    statusMessage --last decorate pair "Update Templates" "$updateTemplates"
    decorate pair "Update Derived" "$updateDerived"
    decorate pair "Update Reference" "$updateReference"
    decorate pair "Make Documentation" "$makeDocumentation"
  fi

  if $updateTemplates; then
    statusMessage --last decorate notice "Updating document templates ..."
    documentationIdenticalRepair "$documentationSource" "$home/documentation/template" || return $?
  fi
  if $updateDerived; then
    statusMessage decorate info "Updating all ..."
    local seeHome="$home/bin/build/documentation/SEE"
    local fun && while read -r fun; do [ -f "$seeHome/$fun.md" ] && printf -- "%s\n" "$(cat "$seeHome/$fun.md")" || printf -- "%s\n" "{SEE:$fun}"; done < <(buildFunctions | sort) | sed 's/^/- &/g' >"$templateSource/allFunctionList.md" || return $?
    local env && while read -r env; do [ -f "$seeHome/$env.md" ] && cat "$seeHome/$env.md" | printfOutputSuffix "\n" || printf -- "%s\n" "{SEE:$env}"; done < <(BUILD_ENVIRONMENT_DIRS="$home/bin/build/env" buildEnvironmentNames | sort) | sed 's/^/- &/g' >"$templateSource/allEnvironmentList.md" || return $?

    statusMessage decorate info "Updating environmentPage ..."
    statusMessage --last timing --name "documentationEnvironmentMake" catchReturn "$handler" documentationEnvironmentMake "${vv[@]+"${vv[@]}"}" --template "$home/documentation/template/env" --source "$home/bin/build/env" --target "$templateSource" || return $?
    statusMessage decorate info "Updating example ..."
    catchReturn "$handler" sed 's/^/    /g' <"$home/bin/build/tools/example.sh" >"$templateSource/example.md" || return $?

    statusMessage --last decorate notice "Updating release page ..."
    local step && step=$(timingStart)
    catchReturn "$handler" releaseNotesMarkdown --title "# Past Releases" >"$templateSource/releaseNotes.md" || return $?
    statusMessage --last timingReport "$step" "Wrote $(decorate file "$templateSource/releaseNotes.md")"

    statusMessage --last timing --name "Building missing" __buildDocumentationBuildMissing "$handler" "$home" "$templateSource" || return $?

    # Make templates
    statusMessage decorate notice "Making templates ..."
    statusMessage timing --name "documentationMake templates" documentationMake "${vv[@]+"${vv[@]}"}" --template "$templateSource" --source "$templateSource" --target "$templateCompiled" || return $?
  fi

  if "$updateReference"; then
    statusMessage --last decorate notice "Building Bash documentation and reference ..."

    # Make source
    statusMessage decorate notice "Making source ..."
    statusMessage timing --name "documentationMake source" documentationMake "${vv[@]+"${vv[@]}"}" --template "$templateSource" --source "$documentationSource" --target "$documentationTarget" || return $?
  fi

  if "$makeDocumentation"; then
    timestamp="$timestamp" version="$version" documentationMkdocs --handler "$handler" --path "./documentation" --package mkdocs-material || return $?
  fi
  statusMessage --last consoleHeadingLine '$' timingReport "$start" "$(basename "${BASH_SOURCE[0]}") completed in"
}
_buildDocumentationBuild() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
