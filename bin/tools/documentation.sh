#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__documentationTemplateFormatter_linkMaker() {
  local eof=false && while ! $eof; do
    local tokens=() && IFS=" " read -d $'\n' -r -a tokens || eof=true
    [ "${#tokens[@]}" -eq 0 ] || local token && for token in "${tokens[@]}"; do
      # shellcheck disable=SC2059
      printf -- "$@" "$token" "$(stringLowercase "$token")"
    done
  done
}

_documentationTemplateFormatter_builtin() {
  __documentationTemplateFormatter_linkMaker "[\`%s\`]({rel}guide/builtin.md#%s)\n"
}

_documentationTemplateFormatter_executable() {
  __documentationTemplateFormatter_linkMaker "[\`%s\`]({rel}guide/command.md#%s)\n"
}

__buildDocumentationCleanDirectory() {
  local handler="$1" && shift
  local home="$1" && shift
  catchEnvironment "$handler" rm -rf "$home/documentation/.docs" "$home/documentation/.site" "$home/documentation/.template" "$home/documentation/mkdocs.yml" || return $?
}

# Build the build documentation
# Argument: --clean - Flag. Clean caches.
# Argument: --verbose - Flag. Talk pretty.
# See: documentationBuild
buildDocumentationBuild() {
  local handler="_${FUNCNAME[0]}"
  local start

  start=$(timingStart) || return $?

  export APPLICATION_NAME

  local vv=()
  local cleanFlag=false verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --clean) cleanFlag=true ;;
    --verbose) vv+=("$argument") && verboseFlag=true ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  # --clean
  if $cleanFlag; then
    ! $verboseFlag || __buildDocumentationStatus info "Cleaning documentation ... "
    # Clean env cache
    catchReturn "$handler" documentationEnvironmentMake --clean || return $?
    # Clean reference cache
    __buildDocumentationCleanDirectory "$handler" "$home" || return $?
    return 0
  fi

  catchReturn "$handler" pcregrepInstall || return $?

  local templateSource && __buildDocumentationPath_templateSource "$home"

  bashDocumentationDefaults --handler "$handler" --target "$templateSource" || return $?

  local applicationName && applicationName=$(catchReturn "$handler" cat "$templateSource/applicationName.md") || return $?
  statusMessage --last consoleHeadingLine . "$(decorate info "$applicationName documentation started on $(decorate value "$(date +"%F %T")")") "

  local indexHome="$home/documentation/template/index"
  local documentationSource="$home/documentation/source"
  local documentationTarget="$home/documentation/.docs"
  local templateCompiled && __buildDocumentationPath_templateCompiled "$home"

  # Ensure we have our target
  catchEnvironment "$handler" muzzle directoryRequire "$documentationTarget" "$templateCompiled" "$indexHome" || return $?

  __buildDocumentationStatus notice "Copying assets ..."
  local item && for item in js images; do
    catchReturn "$handler" rm -rf "$documentationTarget/$item" || return $?
    catchReturn "$handler" cp -R "$documentationSource/$item" "$documentationTarget/$item" || return $?
  done
  __buildDocumentationStatus notice "Updating document templates ..."
  statusMessage --last timing --name "Updated document templates in" documentationIdenticalRepair --fingerprint "$documentationSource" "$home/documentation/template" || return $?

  __buildDocumentationStatus info "Updating all ..."
  local start && start=$(timingStart)
  bashDocumentationAllFunctions < <(buildFunctions) >"$templateSource/allFunctionList.md" || return $?
  BUILD_ENVIRONMENT_DIRS="$home/bin/build/env" bashDocumentationAllEnvironment >"$templateSource/allEnvironmentList.md"
  local ff && for ff in "$documentationSource/tools/"*.md; do
    local title && title=$(grep -m 1 '^# ' "$ff" | textRemoveFields 1) || return $?
    printf -- "- [%s]({rel}tools/%s)\n" "$title" "${ff##*/}"
  done | sort -d >"$templateSource/allToolGroupList.md"
  statusMessage --last timingReport "$start" "Updated all in"

  catchReturn "$handler" buildDocumentationEnvironment "${vv[@]+"${vv[@]}"}" || return $?

  __buildDocumentationStatus info "Updating example ..."
  {
    catchReturn "$handler" printf "%s\n" "<!-- {!skip} -->" "" || return $?
    statusMessage --last timing --name "Updated example" catchReturn "$handler" sed 's/^/    /g' <"$home/bin/build/tools/example.sh" || return $?
  } >"$templateSource/example.md" || return $?

  __buildDocumentationStatus info "Building missing ..."
  statusMessage --last timing --name "Built missing in" bashDocumentationMissing --handler "$handler" --index "$home/documentation/template/index" --source "$home/bin" --documentation "$home/documentation/source" --target "$templateSource"
  # __buildDocumentationBuildMissing "$handler" "$home" "$templateSource" || return $?

  catchReturn "$handler" buildDocumentationTemplates || return $?

  __buildDocumentationStatus info "Copying common files around ..."
  statusMessage --last timing --name "Copied common files around in" __buildBuildUpdateMarkdown "$handler" "$home" || return $?

  # Make source
  __buildDocumentationStatus notice "Making source ..."
  statusMessage --last timing --name "Made source" documentationMake "${vv[@]+"${vv[@]}"}" --template "$templateSource" --source "$documentationSource" --target "$documentationTarget" || return $?

  __buildDocumentationStatus notice "Running mkdocs ..."
  statusMessage --last timing --name "mkdocs ran in" catchReturn "$handler" buildDocumentationMkdocs || return $?

  statusMessage --last consoleHeadingLine '•' "$(timingReport "$start" "$(basename "${BASH_SOURCE[0]}") completed in")"
}
_buildDocumentationBuild() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildDocumentationPath_templateSource() {
  templateSource="$1/documentation/template/docs"
}

__buildDocumentationPath_templateCompiled() {
  templateCompiled="$1/documentation/.template"
}

__buildDocumentationStatus() {
  local style="$1" && shift
  (hookRunOptional process-title "Documentation"$'\n'"$*" &)
  statusMessage decorate "$style" "$*"
}
buildDocumentationTemplates() {
  local handler="_${FUNCNAME[0]}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local templateSource && __buildDocumentationPath_templateSource "$home"
  local templateCompiled && __buildDocumentationPath_templateCompiled "$home"

  # Make templates
  __buildDocumentationStatus notice "Making templates ..."
  statusMessage --last timing --name "Made templates in" documentationMake "$@" --template "$templateSource" --source "$templateSource" --target "$templateCompiled" || return $?
}
_buildDocumentationTemplates() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildDocumentationEnvironment() {
  local handler="_${FUNCNAME[0]}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local templateSource="$home/documentation/template/docs"

  __buildDocumentationStatus info "Updating environment page ..."
  statusMessage --last timing --name "Updated environment page in" documentationEnvironmentMake "$@" --template "$home/documentation/template/env" --source "$home/bin/build/env" --target "$templateSource" || return $?
}
_buildDocumentationEnvironment() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

buildDocumentationMkdocs() {
  local handler="_${FUNCNAME[0]}"

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local templateCompiled="$home/documentation/.template"
  local versionFile="$templateCompiled/version.md"

  version="$(cat "$versionFile")" documentationMkdocs --handler "$handler" --path "$home/documentation" --package mkdocs-material >/dev/null || return $?
}
_buildDocumentationMkdocs() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
