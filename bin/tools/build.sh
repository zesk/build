#!/usr/bin/env bash
#
# Build Build
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#

# Summary: Build step check
# Category: Zesk Build Deployment
# Run at the start of build steps to check that the environment exists and dump it, optionally using a build flag
# passed as the first argument.
# Check if `.build.env` exists and dump the environment if `true` passed
# Return Code: 1 - `.build.env` is missing
# Return Code: 0 - All is well
# Argument: dumpEnv - Boolean. Optional. When `true` dumps the environment.
buildStepInitialize() {
  local handler="_${FUNCNAME[0]}"
  local home && home=$(catchReturn "$handler" buildHome) || return $?

  if ! decorateInitialized; then
    statusMessage decorate info "Color mode is " && catchReturn "$handler" consoleConfigureDecorate || return $?
  fi

  printf "Host: %s, Load: %s\n%s\n" "$(decorate success "$(networkNameFull)")" "$(decorate orange "$(cpuLoadAverage | head -n 1)")" "$("$home/bin/build/tools.sh" timing --name "Speed:" "$home/bin/build/tools.sh" muzzle timing timingStart)"

  if [ "${1-}" = "--first" ]; then
    shift
  else
    local buildEnv="$home/.build.env"
    [ -f "$buildEnv" ] || throwEnvironment "$handler" "No build environment? $(decorate file "$buildEnv")"
    catchReturn "$handler" environmentFileLoad "$buildEnv" || return $?
  fi
  __buildBuildShowSettings
  [ "${BUILD_TEST_DUMP_ENVIRONMENT-}" != "true" ] || catchReturn "$handler" dumpEnvironment || return $?
}
_buildStepInitialize() {
  true || buildStepInitialize --help
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__buildDebugColors() {
  printf -- "BUILD_COLORS=\"%s\"\n" "${BUILD_COLORS-}"
  printf -- "tput colors %s" "$(tput colors 2>&1 || :)"
  if consoleHasColors; then
    decorate success "Has colors"
  else
    decorate error "No colors ${BUILD_COLORS-¢}"
  fi
  decorate pair "TERM" "${TERM-¢}"
  decorate pair "DISPLAY" "${DISPLAY-}"
  decorate pair "BUILD_COLORS" "${BUILD_COLORS-}"

}

__buildBuildJSONUpdate() {
  local handler="$1" && shift
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  local jsonFile && jsonFile="$home/$(catchReturn "$handler" buildEnvironmentGet APPLICATION_JSON)" || return $?

  [ -f "$jsonFile" ] || catchEnvironment "$handler" printf "{}" >"$jsonFile" || return $?
  local version && version="$(catchReturn "$handler" hookRun version-current)" || return $?
  local id && id="$(catchReturn "$handler" hookRun application-id)" || return $?
  catchEnvironment "$handler" jsonFileSet "$jsonFile" ".version" "$version" || return $?
  catchEnvironment "$handler" jsonFileSet "$jsonFile" ".id" "$id" || return $?
  catchEnvironment "$handler" muzzle git add "$jsonFile" || return $?
  printf "%s\n" "$jsonFile"
}

__buildBuildShowSettings() {
  local home && home=$(catchReturn "$handler" buildHome) || return $?

  consoleLine "."
  decorate pair Branch "${BITBUCKET_BRANCH-}"
  decorate pair Deployment "${BITBUCKET_DEPLOYMENT_ENVIRONMENT-}"
  decorate pair Workspace "${BITBUCKET_WORKSPACE-}"
  decorate pair "CPUs" "$(cpuCount)"
  decorate pair Fingerprint "$(fingerprint --check)" || decorate error "Fingerprint mismatched - this may take a while" || :
  hookRun application-files | xargs -n 1 sha1sum | sort -k 2 >"$home/.application-files.log"
  decorate pair "# Application Files" "$(fileLineCount "$home/.application-files.log")"
  consoleLine "."
}

__buildStatus() {
  local icon="🛠️" style="$1" && shift
  local message="$*"
  [ -n "$message" ] || throwArgument "$handler" "blank message in ${FUNCNAME[0]} <- ${FUNCNAME[1]}" || return $?
  catchReturn "$handler" hookRunOptional process-title "$icon $message" || return $?
  local ee=() && case "$style" in error | warning) ee=(--last) ;; esac
  catchReturn "$handler" statusMessage "${ee[@]+"${ee[@]}"}" decorate "$style" "$message" || return $?
}

# fn: bin/build.sh
# Build Zesk Build
#
# Argument: --debug - Flag. Debug TERM info.
# Argument: --documentation - Flag. Build the documentation.
# Argument: --no-documentation - Flag. Do not build the documentation. (Default)
# Argument: --commit - Flag. Commit any changes found.
# Argument: --no-commit - Flag. Do not commit any changes found, but leave the local repository modified. (Default)
# Argument: --debug - Flag. Debug TERM info.
__buildBuild() {
  local handler="_${FUNCNAME[0]}"

  local debugFlag=false makeDocumentation=false commitChanges=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --documentation)
      makeDocumentation=true
      ;;
    --no-documentation)
      makeDocumentation=false
      ;;
    --env-file)
      shift
      muzzle validate "$handler" LoadEnvironmentFile "$argument" "${1-}" || return $?
      decorate info "Loaded environment file $(decorate file "$1")" || return $?
      ;;
    --commit)
      commitChanges=true
      ;;
    --no-commit)
      commitChanges=false
      ;;
    --debug)
      __buildDebugColors
      debugFlag=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local start && start=$(timingStart)
  (
    __buildStatus success "🛠️ Building"

    ! $debugFlag || __buildStatus info "Installing dependencies ..."
    catchReturn "$handler" packageInstall || return $?
    catchReturn "$handler" packageGroupInstall pcregrep || return $?

    local home && home=$(catchReturn "$handler" buildHome) || return $?

    catchReturn "$handler" decorate big "$(buildEnvironmentGet APPLICATION_NAME) $(hookVersionCurrent)" || return $?
    consoleLine "#"

    ! $debugFlag || __buildStatus warning "Running deprecated ..."
    "$home/bin/build/deprecated.sh" --fingerprint || throwEnvironment "$handler" "Deprecated failed" || return $?

    ! $debugFlag || __buildStatus warning "Running identical ..."
    "$home/bin/build/repair.sh" --internal --fingerprint || throwEnvironment "$handler" "Identical repair failed" || return $?

    ! $debugFlag || __buildStatus warning "Running function build ..."
    buildFunctionsCompile --fingerprint || throwEnvironment "$handler" "Build Functions derived compile repair failed" || return $?

    ! $debugFlag || __buildStatus info "Updating markdown ..."
    if ! __buildBuildUpdateMarkdown "$handler" "$home"; then
      catchEnvironment "$handler" "Can not update the Markdown files" || return $?
    fi

    if $makeDocumentation; then
      local rootPath="$home/documentation/.site"
      local rootShow && rootShow=$(decorate file "$rootPath")
      local path && for path in "$rootPath" "$home/documentation/.docs"; do
        if [ -d "$path" ]; then
          ! $debugFlag || __buildStatus warning "Removing $path for build" || return $?
          catchEnvironment "$handler" rm -rf "$path" || return $?
        fi
      done
      ! $debugFlag || __buildStatus warning "Building documentation ..."
      catchEnvironment "$handler" "$home/bin/documentation.sh" || return $?

      [ -d "$rootPath" ] || throwEnvironment "$handler" "Documentation failed to create $rootShow" || return $?

    fi

    if $commitChanges && gitRepositoryChanged; then
      ! $debugFlag || __buildStatus info "Repository changed, committing ..."
      printf -- "%s\n" "CHANGES:" || :
      gitShowChanges | decorate code | decorate wrap "    "
      {
        ! git commit -m "Build version $(hookRun version-current)" -a && git push origin
      } || __buildStatus error "Commit or push failed. Continuing."
    elif gitRepositoryChanged; then
      ! $debugFlag || __buildStatus warning "Local repository changed."
    fi
    envFile="$home/.build.env"
    environmentOutput >"$envFile"
    decorate info "Wrote $(decorate file "$envFile") $(localePluralWord "$(fileSize "$envFile")" byte)" || return $?
  ) || return $?
  __buildStatus success "$(timingReport "$start" "Built successfully in")"
}
___buildBuild() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
