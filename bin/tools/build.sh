#!/usr/bin/env bash
#
# Build Build
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#

__buildDebugColors() {
  printf -- "BUILD_COLORS=\"%s\"\n" "${BUILD_COLORS-}"
  printf -- "tput colors %s" "$(tput colors 2>&1 || :)"
  if hasColors; then
    decorate success "Has colors"
  else
    decorate error "No colors ${BUILD_COLORS-¢}"
  fi
  decorate pair "TERM" "${TERM-¢}"
  decorate pair "DISPLAY" "${DISPLAY-}"
  decorate pair "BUILD_COLORS" "${BUILD_COLORS-}"

}

__buildMarker() {
  local handler="_return"
  local home

  home=$(__catch "$handler" buildHome) || return $?
  local jsonFile

  jsonFile="$home/$(__catch "$handler" buildEnvironmentGet APPLICATION_JSON)" || return $?

  [ -f "$jsonFile" ] || __catchEnvironment "$handler" printf "{}" >"$jsonFile" || return $?

  local version id
  version="$(__catch "$handler" hookRun version-current)" || return $?
  id="$(__catch "$handler" hookRun application-id)" || return $?
  __catchEnvironment "$handler" jsonFileSet "$jsonFile" ".version" "$version" || return $?
  __catchEnvironment "$handler" jsonFileSet "$jsonFile" ".id" "$id" || return $?
  __catchEnvironment "$handler" muzzle git add "$jsonFile" || return $?

  printf "%s\n" "$jsonFile"
}

#
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
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(usageArgumentFunction "$handler" "$argument" "${1-}") || return $? ;;
    --documentation)
      makeDocumentation=true
      ;;
    --no-documentation)
      makeDocumentation=false
      ;;
    --env-file)
      shift
      muzzle usageArgumentLoadEnvironmentFile "$handler" "$argument" "${1-}" || return $?
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
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local start
  start=$(timingStart)

  export BUILD_COLORS BUILD_COLORS_MODE

  [ -n "${BUILD_COLORS_MODE-}" ] || BUILD_COLORS_MODE=$(consoleConfigureColorMode) || :

  ! $debugFlag || statusMessage decorate info "Installing dependencies ..."
  __catch "$handler" packageInstall || return $?

  local home
  home=$(__catch "$handler" buildHome) || return $?

  local size

  if ! whichExists yq; then
    size=$(grep -E '(deployment|size):' bitbucket-pipelines.yml | grep -A 1 "${BITBUCKET_DEPLOYMENT_ENVIRONMENT-}" | grep 'size:' | awk '{ print $2 }') || :
  else
    size=$(yq ".. | select(has(\"deployment\") and .deployment == \"${BITBUCKET_DEPLOYMENT_ENVIRONMENT-}\") | .size" <"$home/bitbucket-pipelines.yml") || :
  fi
  [ -n "$size" ] || size="1x"

  __catch "$handler" bigText "$(buildEnvironmentGet APPLICATION_NAME) $(hookVersionCurrent)" || return $?
  echoBar "."
  decorate pair Branch "${BITBUCKET_BRANCH-}"
  decorate pair Deployment "${BITBUCKET_DEPLOYMENT_ENVIRONMENT-}"
  decorate pair Workspace "${BITBUCKET_WORKSPACE-}"
  decorate pair "Hardware Size" "${size}"
  echoBar "."
  dumpEnvironment
  echoBar "#"

  ! $debugFlag || statusMessage decorate info "Updating markdown ..."
  if ! "$home/bin/update-md.sh" --skip-commit; then
    __catchEnvironment "$handler" "Can not update the Markdown files" || return $?
  fi

  ! $debugFlag || statusMessage decorate warning "Running deprecated ..."
  "$home/bin/build/deprecated.sh" || __throwEnvironment "$handler" "Deprecated failed" || return $?

  ! $debugFlag || statusMessage decorate warning "Building fast files first time ..."
  __catch "$handler" "$home/bin/tools.sh" buildFastFiles || return $?

  ! $debugFlag || statusMessage decorate warning "Running identical ..."
  "$home/bin/build/identical-repair.sh" --internal || __throwEnvironment "$handler" "Identical repair failed" || return $?

  ! $debugFlag || statusMessage decorate warning "Building fast files ..."
  __catch "$handler" "$home/bin/tools.sh" buildFastFiles || return $?

  if $makeDocumentation; then
    local path rootShow rootPath="$home/documentation/site"
    rootShow=$(decorate file "$rootPath")
    for path in "$rootPath" "$home/documentation/.docs"; do
      if [ -d "$path" ]; then
        statusMessage decorate warning "Removing $path for build" || return $?
        __catchEnvironment "$handler" rm -rf "$path" || return $?
      fi
    done
    ! $debugFlag || statusMessage decorate warning "Building documentation ..."
    __catchEnvironment "$handler" "$home/bin/documentation.sh" || return $?
    [ -d "$rootPath" ] || __throwEnvironment "$handler" "Documentation failed to create $rootShow" || return $?
  fi

  if $commitChanges && gitRepositoryChanged; then
    ! $debugFlag || statusMessage decorate info "Repository changed, committing ..."
    printf -- "%s\n" "CHANGES:" || :
    gitShowChanges | decorate code | decorate wrap "    "
    {
      ! git commit -m "Build version $(hookRun version-current)" -a && git push origin
    } || statusMessage --last decorate error "Commit or push failed. Continuing."
  elif gitRepositoryChanged; then
    ! $debugFlag || statusMessage --last decorate warning "Local repository changed."
  fi
  statusMessage --last timingReport "$start" "Built successfully in"
}
___buildBuild() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
