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
  local usage="_${FUNCNAME[0]}"

  local debugFlag=false makeDocumentation=false makeRelease=false

  export BUILD_COLORS

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    --documentation)
      makeDocumentation=true
      ;;
    --release)
      makeRelease=true
      ;;
    --debug)
      __buildDebugColors
      debugFlag=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local start
  start=$(timingStart)

  ! $debugFlag || statusMessage decorate info "Installing AWS ..."
  __catch "$usage" awsInstall || return $?

  local target cloudFrontID
  target=$(buildEnvironmentGet "DOCUMENTATION_S3_PREFIX") || return $?
  cloudFrontID=$(buildEnvironmentGet "DOCUMENTATION_CLOUDFRONT_ID") || return $?

  local home
  home=$(__catch "$usage" buildHome) || return $?

  local appId notes

  statusMessage decorate info "Fetching deep copy of repository ..." || :
  __catchEnvironment "$usage" git fetch --unshallow || return $?

  statusMessage decorate info "Collecting application version and ID ..." || :
  currentVersion="$(hookRun version-current)" || __throwEnvironment "$usage" "hookRun version-current" || return $?
  appId=$(hookRun application-id) || __throwEnvironment "$usage" "hookRun application-id" || return $?

  [ -n "$currentVersion" ] || __throwEnvironment "$usage" "Blank version-current" || return $?
  [ -n "$appId" ] || __throwEnvironment "$usage" "No application ID (blank?)" || return $?

  notes=$(releaseNotes) || __throwEnvironment "$usage" "releaseNotes" || return $?
  [ -f "$notes" ] || __throwEnvironment "$usage" "$notes does not exist" || return $?

  bigText "$currentVersion" | decorate magenta | decorate wrap "$(decorate green "Zesk BUILD    🛠️️ ")" "$(decorate green " ⚒️ ")"
  decorate info "Deploying a new release ... " || :

  if $makeDocumentation; then
    local rootShow rootPath="$home/documentation/site"
    rootShow=$(decorate file "$rootPath")

    if [ -n "$target" ]; then
      __throwEnvironment "$usage" "No DOCUMENTATION_S3_PREFIX but --documentation supplied" || return $?
    fi
    if [ ! -d "$rootPath" ]; then
      __throwEnvironment "$usage" "$rootShow does not exist but --documentation supplied" || return $?
    fi

    # Validate for later (possibly every time in the future)
    [ -n "$target" ] || __throwEnvironment "$usage" "DOCUMENTATION_S3_PREFIX is blank" || return $?
    [ "$target" != "${target#s3://}" ] || __throwEnvironment "$usage" "DOCUMENTATION_S3_PREFIX=$(decorate code "$target") is NOT a S3 URL" || return $?
    [ -n "$cloudFrontID" ] || __throwEnvironment "$usage" "DOCUMENTATION_CLOUDFRONT_ID is blank" || return $?

    ! $debugFlag || statusMessage decorate warning "Publishing documentation to $target ..."

    # Ideally do this in a way which is more transactional with the release version
    ! $debugFlag || statusMessage decorate warning "Syncing documentation to $target ..."
    __catchEnvironment "$usage" aws s3 sync --delete "$rootPath" "$target" || return $?
    ! $debugFlag || statusMessage decorate warning "Creating invalidation for $(decorate code "$cloudFrontID") ..."
    __catchEnvironment "$usage" aws cloudfront create-invalidation --distribution-id "$cloudFrontID" --paths / || return $?
  fi

  if $makeRelease && ! githubRelease "$notes" "$currentVersion" "$appId"; then
    decorate warning "Deleting tagged version ... " || :
    gitTagDelete "$currentVersion" || decorate error "gitTagDelete $currentVersion ALSO failed but continuing ..." || :
    __throwEnvironment "$usage" "githubRelease" || return $?
  fi
  timingReport "$start" "Release completed in" || :
}
___buildDeploy() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

