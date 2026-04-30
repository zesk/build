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

__buildDocumentationBuildDirectory() {
  local handler="$1" && shift
  local home="$1" && shift
  local start && start=$(timingStart) && statusMessage decorate notice "Copying ..."

  local documentationSource="$home/documentation/source"
  local templateHome="$home/documentation/template"
  local source="$documentationSource/tools"
  local target="$home/documentation/.docs/tools"

  catchReturn "$handler" cp -f "$home/etc/"*.svg "$home/etc/"*.png "$documentationSource/images/" || return $?
  catchReturn "$handler" muzzle rm -rf "$home/documentation/.docs" || return $?
  catchReturn "$handler" statusMessage timing --name "Copied documentation" cp -rf "$documentationSource" "$home/documentation/.docs" || return $?

  local functionTemplate && functionTemplate="$(catchReturn "$handler" documentationTemplate "function")" || return $?

  local aa=()

  # Our source code lookup is here
  aa+=(--source "$home/bin")

  # Output generated files here
  aa+=(--target "$target")

  # Directory of files to convert
  aa+=(--template "$source")

  # Functions not documented in the documentation use
  # `--unlinked-source` and `--unlinked-target` and `--unlinked-template`
  aa+=(--unlinked-source "$source")
  aa+=(--unlinked-template "$source/todo.md" --unlinked-target "$target/todo.md")

  # Template generation
  aa+=(
    "--function-template" "$functionTemplate"
    "--page-template" "$templateHome/__main.md"
  )
  # See stuff
  aa+=(--see-prefix "./documentation/.docs")
  # Env stuff
  aa+=(--see-environment-link "/env/index.md")

  # All functions
  local allTarget="$source/all.md"
  catchEnvironment "$handler" cp "$templateHome/all.md" "$allTarget" || return $?
  catchReturn "$handler" cp "$templateHome/todo.md" "$source/todo.md" || return $?

  printf "\n" >>"$allTarget"

  local fun && while read -r fun; do
    local seeFile && if seeFile=$(__documentationFile "$home" "SEE/$fun"); then
      decorate wrap "- " "" <"$seeFile" | rel="../" mapEnvironment
    else
      printf -- "- {SEE:%s} %s\n" "$fun" "<!-- later -->"
    fi
  done < <(buildFunctions | sort -u) >>"$allTarget"

  #  ┌───────────────────────────────────────────────────────────────────────────────────────────────────┐
  #  │      _                                       _        _   _             ____        _ _     _     │
  #  │   __| | ___   ___ _   _ _ __ ___   ___ _ __ | |_ __ _| |_(_) ___  _ __ | __ ) _   _(_) | __| |    │
  #  │  / _` |/ _ \ / __| | | | '_ ` _ \ / _ \ '_ \| __/ _` | __| |/ _ \| '_ \|  _ \| | | | | |/ _` |    │
  #  │ | (_| | (_) | (__| |_| | | | | | |  __/ | | | || (_| | |_| | (_) | | | | |_) | |_| | | | (_| |    │
  #  │  \__,_|\___/ \___|\__,_|_| |_| |_|\___|_| |_|\__\__,_|\__|_|\___/|_| |_|____/ \__,_|_|_|\__,_|    │
  #  │                                                                                                   │
  #  └───────────────────────────────────────────────────────────────────────────────────────────────────┘
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
  local handler="$1" home="$2"
  local source="$home/documentation/template/release.md"
  local target="$home/documentation/.docs/release/index.md"
  local currentNotes && currentNotes=$(catchReturn "$handler" releaseNotes --application "$home") || return $?
  catchReturn "$handler" muzzle fileDirectoryRequire "$target" || return $?
  __buildDocumentationBuildContent "$handler" "$(dirname "$currentNotes")" <"$source" >"$target"
  statusMessage --last decorate info "Wrote $(decorate file "$target")"
}

__buildDocumentationBuildContent() {
  local handler="$1" notesPath="$2"
  local recentNotes=10 index

  local content && content=$(
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
  ) || return $?
  timestamp="${timestamp-}" version="${version-}" content="$content" mapEnvironment content version timestamp
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
# Argument: --see-update - Flag. `SEE:` token updates
# Argument: --index-update - Flag. Update documentation indexes.`
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

  local version && version=$(catchReturn "$handler" hookVersionCurrent) || return $?
  local timestamp && timestamp="$(catchReturn "$handler" date -u "+%F %T") UTC" || return $?

  # Greeting
  catchReturn "$handler" buildEnvironmentLoad APPLICATION_NAME || return $?
  statusMessage consoleHeadingLine . "$(decorate info "${APPLICATION_NAME} documentation started on $(decorate value "$(date +"%F %T")")") "

  if $verboseFlag; then
    decorate pair "Update Templates" "$updateTemplates"
    decorate pair "Update Derived" "$updateDerived"
    decorate pair "Update Reference" "$updateReference"
    decorate pair "Make Documentation" "$makeDocumentation"
  fi

  local targetHome="$home/documentation/.docs"
  local documentationSource="$home/documentation/source"
  local templateHome="$home/documentation/template"

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
    local example && example="$(decorate wrap "    " <"$home/bin/build/tools/example.sh")" || throwEnvironment "$handler" "generating example" || return $?

    local targetEnv="$home/documentation/source/env/index.md"
    targetEnv=$(catchReturn "$handler" fileDirectoryRequire "$targetEnv") || return $?
    ea=(--verbose
      --template-path "$home/documentation/template"
      --source "$templateHome/env-index.md"
      --source-path "$home/bin/build/env"
      --target "$targetEnv"
      "${ea[@]+"${ea[@]}"}")
    catchReturn "$handler" documentationBuildEnvironment "${ea[@]+"${ea[@]}"}" || return $?

    statusMessage --last decorate notice "Updating release page ..."
    example="$example" version="$version" timestamp="$timestamp" __buildDocumentationBuildRelease "$handler" "$home" || return $?
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
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
