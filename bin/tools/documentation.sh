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
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --clean) cleanFlag=true ;;
    --verbose) vv+=("$argument") && verboseFlag=true ;;
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

  local versionFile="$templateCompiled/version.md"

  # Make source
  statusMessage decorate notice "Making source ..."
  version="$(cat "$versionFile")" statusMessage timing --name "documentationMake source" documentationMake "${vv[@]+"${vv[@]}"}" --template "$templateSource" --source "$documentationSource" --target "$documentationTarget" || return $?
  documentationMkdocs --handler "$handler" --path "./documentation" --package mkdocs-material || return $?

  statusMessage --last consoleHeadingLine '•' timingReport "$start" "$(basename "${BASH_SOURCE[0]}") completed in"
}
_buildDocumentationBuild() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
