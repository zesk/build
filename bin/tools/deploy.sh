#!/usr/bin/env bash
#
# Deploy Zesk Build
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

#
# Deploy Zesk Build
#
# Argument: --debug - Flag. Debug TERM info.
# Argument: --documentation - Flag. Deploy the documentation.
# Argument: --no-documentation - Flag. Do not deploy the documentation. (Default)
# Argument: --release - Flag. Push the release to GitHub.
# Argument: --no-release - Flag. Do not push the release to GitHub.
# Argument: --debug - Flag. Debug TERM info.
__buildDeploy() {
  local handler="_${FUNCNAME[0]}"

  local debugFlag=false makeDocumentation=false makeRelease=false

  export BUILD_COLORS

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --documentation) makeDocumentation=true ;;
    --no-documentation) makeDocumentation=false ;;
    --no-release) makeRelease=false ;;
    --release) makeRelease=true ;;
    --debug) debugFlag=true ;;
    --env-file)
      shift
      muzzle usageArgumentLoadEnvironmentFile "$handler" "$argument" "${1-}" || return $?
      decorate info "Loaded environment file $(decorate file "$1")" || return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  __catch "$handler" packageInstall || return $?

  local name
  name=$(__catch "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?
  currentVersion="$(__catch "$handler" hookRun version-current)" || return $?
  [ -n "$currentVersion" ] || __throwEnvironment "$handler" "Blank version-current" || return $?
  bigText "Deploy $name $currentVersion" | decorate success
  dumpEnvironment

  local start
  start=$(timingStart)

  ! $debugFlag || __buildDebugColors

  if $makeDocumentation; then
    ! $debugFlag || statusMessage decorate info "Installing AWS ..."
    __catch "$handler" awsInstall || return $?
  fi
  local target cloudFrontID
  target=$(buildEnvironmentGet "DOCUMENTATION_S3_PREFIX") || return $?
  cloudFrontID=$(buildEnvironmentGet "DOCUMENTATION_CLOUDFRONT_ID") || return $?

  local home
  home=$(__catch "$handler" buildHome) || return $?

  local appId notes

  statusMessage decorate info "Collecting application version and ID ..." || :
  appId=$(hookRun application-id) || __throwEnvironment "$handler" "hookRun application-id" || return $?

  [ -n "$appId" ] || __throwEnvironment "$handler" "No application ID (blank?)" || return $?

  notes=$(releaseNotes) || __throwEnvironment "$handler" "releaseNotes" || return $?
  [ -f "$notes" ] || __throwEnvironment "$handler" "$notes does not exist" || return $?

  local name
  name=$(buildEnvironmentGet APPLICATION_NAME)
  statusMessage --last decorate pair "Application Name" "$name" || :
  statusMessage --last decorate pair "Application ID" "$appId" || :
  statusMessage --last decorate pair "Application Version" "$currentVersion" || :
  bigText "$currentVersion" | decorate magenta | decorate wrap "$(decorate green "$name    🛠️️ ")" "$(decorate green " ⚒️ ")"

  if $makeDocumentation; then
    local rootShow rootPath="$home/documentation/site"
    rootShow=$(decorate file "$rootPath")

    if [ -z "$target" ]; then
      __throwEnvironment "$handler" "No DOCUMENTATION_S3_PREFIX but --documentation supplied" || return $?
    fi
    if [ ! -d "$rootPath" ]; then
      __throwEnvironment "$handler" "$rootShow does not exist but --documentation supplied" || return $?
    fi

    # Validate for later (possibly every time in the future)
    [ -n "$target" ] || __throwEnvironment "$handler" "DOCUMENTATION_S3_PREFIX is blank" || return $?
    [ "$target" != "${target#s3://}" ] || __throwEnvironment "$handler" "DOCUMENTATION_S3_PREFIX=$(decorate code "$target") is NOT a S3 URL" || return $?
    [ -n "$cloudFrontID" ] || __throwEnvironment "$handler" "DOCUMENTATION_CLOUDFRONT_ID is blank" || return $?

    ! $debugFlag || statusMessage decorate warning "Publishing documentation to $target ..."

    # Ideally do this in a way which is more transactional with the release version
    ! $debugFlag || statusMessage decorate warning "Syncing documentation to $target ..."
    __catchEnvironment "$handler" aws s3 sync --delete "$rootPath" "$target" || return $?
    ! $debugFlag || statusMessage decorate warning "Creating invalidation for $(decorate code "$cloudFrontID") ..."
    __catchEnvironment "$handler" aws cloudfront create-invalidation --distribution-id "$cloudFrontID" --paths '/*' || return $?
  fi

  if $makeRelease; then
    statusMessage --last decorate info "Deploying a new release ... " || :

    statusMessage decorate info "Fetching deep copy of repository for release ..." || :
    __catchEnvironment "$handler" git fetch --unshallow || return $?

    if ! githubRelease "$notes" "$currentVersion" "$appId"; then
      local exitCode=$?
      decorate warning "FAILED - Deleting tagged version ... " || :
      gitTagDelete "$currentVersion" || decorate error "gitTagDelete $currentVersion ALSO failed but continuing ..." || :
      __throwEnvironment "$handler" "githubRelease FAILED with $exitCode" || return $?
    fi
  fi
  timingReport "$start" "Release completed in" || :
}
___buildDeploy() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
