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

__buildDocumentationCleanDirectory() {
  local handler="$1" && shift
  local home="$1" && shift
  catchEnvironment "$handler" rm -rf "$home/documentation/.docs" "$home/documentation/.site" "$home/documentation/.template" || return $?
}

# Build the build documentation
# Argument: --none - Flag. Turn off all updates.
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
  local cleanFlag=false verboseFlag=false

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
    --debug) da+=(--debug) ;;
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

  local templateSource="$home/documentation/template/docs"

  bashDocumentationDefaults --handler "$handler" --target "$templateSource" || return $?

  local applicationName && applicationName=$(catchReturn "$handler" cat "$templateSource/applicationName.md") || return $?
  statusMessage --last consoleHeadingLine . "$(decorate info "$applicationName documentation started on $(decorate value "$(date +"%F %T")")") "

  local indexHome="$home/documentation/template/index"
  local documentationSource="$home/documentation/source"
  local documentationTarget="$home/documentation/.docs"
  local templateCompiled="$home/documentation/.template"

  # Ensure we have our target
  catchEnvironment "$handler" muzzle directoryRequire "$documentationTarget" "$templateCompiled" "$indexHome" || return $?

  statusMessage --last decorate notice "Updating document templates ..."
  documentationIdenticalRepair --fingerprint "$documentationSource" "$home/documentation/template" || return $?

  statusMessage decorate info "Updating all ..."
  bashDocumentationAllFunctions < <(buildFunctions) >"$templateSource/allFunctionList.md" || return $?
  BUILD_ENVIRONMENT_DIRS="$home/bin/build/env" bashDocumentationAllEnvironment >"$templateSource/allEnvironmentList.md"

  statusMessage decorate info "Updating environmentPage ..."
  statusMessage --last timing --name "documentationEnvironmentMake" catchReturn "$handler" documentationEnvironmentMake "${vv[@]+"${vv[@]}"}" --template "$home/documentation/template/env" --source "$home/bin/build/env" --target "$templateSource" || return $?

  statusMessage decorate info "Updating example ..."
  catchReturn "$handler" sed 's/^/    /g' <"$home/bin/build/tools/example.sh" >"$templateSource/example.md" || return $?

  statusMessage --last timing --name "Building missing" bashDocumentationMissing --handler "$handler" --index "$home/documentation/template/index" --source "$home/bin" --documentation "$home/documentation/source" --target "$templateSource"
  # __buildDocumentationBuildMissing "$handler" "$home" "$templateSource" || return $?

  # Make templates
  statusMessage decorate notice "Making templates ..."
  statusMessage timing --name "documentationMake templates" documentationMake "${vv[@]+"${vv[@]}"}" --template "$templateSource" --source "$templateSource" --target "$templateCompiled" || return $?
  statusMessage --last decorate notice "Building Bash documentation and reference ..."

  # Make source
  statusMessage decorate notice "Making source ..."
  statusMessage timing --name "documentationMake source" documentationMake "${vv[@]+"${vv[@]}"}" --template "$templateSource" --source "$documentationSource" --target "$documentationTarget" || return $?
  documentationMkdocs --handler "$handler" --path "./documentation" --package mkdocs-material || return $?

  statusMessage --last consoleHeadingLine '•' timingReport "$start" "$(basename "${BASH_SOURCE[0]}") completed in"
}
_buildDocumentationBuild() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
