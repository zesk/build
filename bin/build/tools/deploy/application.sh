#!/usr/bin/env bash
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
#
#    ▌      ▜
#  ▞▀▌▞▀▖▛▀▖▐ ▞▀▖▌ ▌
#  ▌ ▌▛▀ ▙▄▘▐ ▌ ▌▚▄▌
#  ▝▀▘▝▀▘▌   ▘▝▀ ▗▄▘
#
# Docs: o ./docs/_templates/tools/deploy.md
# Test: o ./test/tools/deploy-tests.sh

# Deploy an application from a deployment repository
#
#      ____             _
#     |  _ \  ___ _ __ | | ___  _   _
#     | | | |/ _ \ '_ \| |/ _ \| | | |
#     | |_| |  __/ |_) | | (_) | |_| |
#     |____/ \___| .__/|_|\___/ \__, |
#                |_|            |___/
#
# This acts on the local file system only but used in tandem with `deployment.sh` functions.
#
# Usage: {fn} deployHome applicationId applicationPath [ targetPackage ]
#
# Argument: --help - Optional. Flag. This help.
# Argument: --first - Optional. Flag. The first deployment has no prior version and can not be reverted.
# Argument: --revert - Optional. Flag. Means this is part of the undo process of a deployment.
# Argument: --home deployHome - Required. Directory. Path where the deployments database is on remote system.
# Argument: --id applicationId - Required. String. Should match `APPLICATION_ID` or `APPLICATION_TAG` in `.env` or `.deploy/`
# Argument: --application applicationPath - Required. String. Path on the remote system where the application is live
# Argument: --target targetPackage - Optional. Filename. Package name, defaults to `BUILD_TARGET`
# Argument: --message message - Optional. String. Message to display in the maintenance message on systems while upgrade is occurring.
# Environment: BUILD_TARGET APPLICATION_ID APPLICATION_TAG
# Example: {fn} --home /var/www/DEPLOY --id 10c2fab1 --application /var/www/apps/cool-app
# Use-Hook: maintenance
# Use-Hook: deploy-shutdown
# Use-Hook: deploy-activate deploy-start deploy-finish
# See: deployToRemote
#
deployApplication() {
  local usage="_${FUNCNAME[0]}"
  local firstFlag revertFlag
  local argument name
  local deployHome applicationPath deployedApplicationPath targetPackage targetPackageFullPath
  local newApplicationId applicationId currentApplicationId exitCode verboseFlag
  local unwindArgs requiredArgs
  local message

  exitCode=0
  # Arguments

  # --first
  firstFlag=false
  # --revert
  revertFlag=false
  message=

  # Arguments in order
  deployHome=
  applicationId=
  applicationPath=
  verboseFlag=false
  targetPackage=
  requiredArgs=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --verbose)
        verboseFlag=true
        ;;
      --message)
        shift
        [ -n "${1-}" ] || __failArgument "blank $argument argument" || return $?
        message="$1"
        ;;
      --first)
        firstFlag=true
        ;;
      --revert)
        revertFlag=true
        ;;
      --home)
        shift
        deployHome=$(usageArgumentDirectory "$usage" deployHome "${1-}") || return $?
        ;;
      --id)
        shift
        [ -n "${1-}" ] || __failArgument "blank $argument argument" || return $?
        applicationId="$1"
        ;;
      --application)
        shift
        applicationPath=$(usageArgumentFileDirectory "$usage" applicationPath "${1-}") || return $?
        ;;
      --target)
        shift
        [ -n "${1-}" ] || __failArgument "blank $argument argument" || return $?
        targetPackage="$1"
        ;;
      *)
        __failArgument "$usage" "unknown argument $(decorate value "$argument")" || return $?
        ;;
    esac
    shift || __failArgument "$usage" "shift argument $argument failed" || return $?
  done
  [ -n "$targetPackage" ] || targetPackage="$(deployPackageName)" || __failArgument "$usage" "No package name" || return $?
  if $revertFlag; then
    requiredArgs+=(applicationId)
  fi

  # Check arguments are non-blank and actually supplied
  requiredArgs+=(deployHome applicationPath)
  for name in "${requiredArgs[@]}"; do
    [ -n "${!name}" ] || __failArgument "$usage" "$name is required" || return $?
  done

  currentApplicationId=
  if [ -d "$applicationPath" ]; then
    if ! currentApplicationId="$(deployApplicationVersion "$applicationPath")" || [ -z "$currentApplicationId" ]; then
      if ! $firstFlag; then
        __failEnvironment "$usage" "Can not fetch version from $applicationPath,  need --first" || return $?
      fi
      currentApplicationId=
    fi
  fi

  if $revertFlag; then
    #
    # If reverting, check the application ID (if supplied) is correct otherwise fail
    #
    newApplicationId=$(deployPreviousVersion "$deployHome" "$currentApplicationId") || __failEnvironment "$usage" "--revert can not find previous version of $currentApplicationId ($deployHome)" || return $?

    if [ -n "$applicationId" ] && [ "$applicationId" != "$currentApplicationId" ]; then
      __failArgument "$usage" "--id $applicationId does not match ID \"$currentApplicationId\" of $applicationPath" || return $?
    fi
    applicationId="$newApplicationId"
    printf "%s %s %s %s\n" "$(decorate info "Reverting from")" "$(decorate orange "$currentApplicationId")" "$(decorate info "->")" "$(decorate green "$applicationId")"
  fi

  #
  # Arguments are all parsed by here
  #
  targetPackageFullPath="$deployHome/$applicationId/$targetPackage"
  [ -f "$targetPackageFullPath" ] || __failArgument "$usage" "deployApplication: Missing target file $targetPackageFullPath" || return $?

  #
  # Generates deployHome/{newVersion}/app and deletes on failure
  #
  # START _unwindDeploy
  #
  # `_unwindDeploy` after this guarantees this and always exits non-zero
  #
  deployedApplicationPath="$deployHome/$applicationId/app"
  unwindArgs=("$applicationPath" "$deployedApplicationPath")

  if [ -d "$deployedApplicationPath" ]; then
    if ! rm -rf "$deployedApplicationPath"; then
      _unwindDeploy "${unwindArgs[@]}" "rm $deployedApplicationPath failed" || return $?
    fi
  fi
  if ! mkdir "$deployedApplicationPath"; then
    _unwindDeploy "${unwindArgs[@]}" "mkdir $deployedApplicationPath failed" || return $?
  fi

  if ! tar -C "$deployedApplicationPath" -xzf "$targetPackageFullPath"; then
    _unwindDeploy "${unwindArgs[@]}" "tar -C \"$deployedApplicationPath\" -xzf \"$targetPackageFullPath\" failed" || return $?
  fi
  if ! newApplicationId=$(deployApplicationVersion "$deployedApplicationPath"); then
    _unwindDeploy "${unwindArgs[@]}" "deployApplicationVersion $deployedApplicationPath failed" || return $?
  fi

  if [ "$newApplicationId" != "$applicationId" ]; then
    _unwindDeploy "${unwindArgs[@]}" "Deployed version $newApplicationId != Requested $applicationId, tar file is likely incorrect" || return $?
  fi

  if ! $firstFlag; then
    if [ ! -d "$applicationPath" ]; then
      decorate warning "Application path $applicationPath does not exist but not --first" 1>&2
    else
      #
      # Old Application
      #
      if hasHook --application "$applicationPath" maintenance; then
        printf "%s %s\n" "$(decorate warning "Turning maintenance")" "$(decorate green "$(decorate code " ON ")")"
        if [ -z "$message" ]; then
          message="Upgrading to $newApplicationId"
        fi
        if ! runHook --application "$applicationPath" maintenance --message "$message" on; then
          _unwindDeploy "${unwindArgs[@]}" "Turning maintenance on in $applicationPath failed" || return $?
        fi
      else
        printf "%s\n" "$(decorate info "No maintenance hook")"
      fi
      if hasHook --application "$applicationPath" deploy-shutdown; then
        printf "%s %s\n" "$(decorate warning "Running hook")" "$(decorate green "$(decorate code " deploy-shutdown ")")"
        if ! runHook --application "$applicationPath" deploy-shutdown; then
          _unwindDeploy "${unwindArgs[@]}" "Running hook deploy-shutdown failed" || return $?
        fi
      else
        printf "%s\n" "$(decorate info "No deploy-shutdown hook")"
      fi
    fi
  fi

  #
  # Link
  #
  if [ -n "$currentApplicationId" ]; then
    if [ ! -f "$deployHome/$applicationId.previous" ] && [ ! -f "$deployHome/$currentApplicationId.next" ]; then
      printf "%s %s -> %s\n" "$(decorate info "Linking versions:")" "$(decorate orange "$currentApplicationId")" "$(decorate green "$applicationId")"
      # Linked list forward only
      if ! printf "%s" "$currentApplicationId" >"$deployHome/$applicationId.previous" ||
        ! printf "%s" "$applicationId" >"$deployHome/$currentApplicationId.next"; then
        rm -rf "$deployHome/$applicationId.previous" "$deployHome/$applicationId.next" || :
        _unwindDeploy "${unwindArgs[@]}" "Linking $deployHome/$applicationId failed" || return $?
      fi
    fi
  fi

  #
  # Link
  #
  # deployedApplicationPath is the new version of the application source code root
  printf "%s %s\n" "$(decorate info "Setting to version")" "$(decorate code "$applicationId")"
  if hasHook --application "$deployedApplicationPath" deploy-start; then
    printf "%s %s\n" "$(decorate warning "Running hook")" "$(decorate green "$(decorate code " deploy-start ")")"
    if ! runHook --application "$deployedApplicationPath" deploy-start; then
      _unwindDeploy "${unwindArgs[@]}" "Running hook deploy-start failed" || return $?
    fi
  else
    ! $verboseFlag || statusMessage --last decorate info "No deploy-start hook"
  fi

  if hasHook --application "$deployedApplicationPath" deploy-activate; then
    printf "%s %s\n" "$(decorate warning "Running hook")" "$(decorate green "$(decorate code " deploy-activate ")")" || :
    if ! runHook --application "$deployedApplicationPath" deploy-activate "$applicationPath"; then
      _unwindDeploy "${unwindArgs[@]}" "runHook deploy-activate failed" || return $?
    fi
  else
    printf "%s %s -> %s\n" "$(decorate success "Activating application")" "$(decorate code " $applicationPath ")" "$(decorate green "$applicationId")" || :
    if ! deployLink "$applicationPath" "$deployedApplicationPath"; then
      _unwindDeploy "${unwindArgs[@]}" "deployLink $applicationPath $deployedApplicationPath failed" || return $?
    fi
  fi
  # STOP _unwindDeploy

  if ! runOptionalHook --application "$applicationPath" deploy-finish; then
    __failEnvironment "$usage" "Deploy finish failed" || exitCode=$?
  fi
  if ! runOptionalHook --application "$applicationPath" maintenance off; then
    __failEnvironment "$usage" "maintenance off failed" || exitCode=$?
  fi
  if [ $exitCode -eq 0 ]; then
    decorate success "Completed"
  else
    printf "%s %s\n" "$(decorate error "Exiting with code")" "$(decorate code "$exitCode")"
  fi
  return "$exitCode"
}
_unwindDeploy() {
  local applicationPath="$1" deployedApplicationPath="${2-}"
  local usage="_deployApplication"

  shift || :
  shift || :
  if ! runOptionalHook --application "$applicationPath" maintenance off; then
    decorate error "Unable to enable maintenance - system is unstable" 1>&2
  else
    decorate success "Maintenance was enabled again"
  fi
  if [ -d "$deployedApplicationPath" ]; then
    printf "%s %s\n" "$(decorate error "Deleting")" "$(decorate code "$deployedApplicationPath")"
    rm -rf "$deployedApplicationPath" || decorate error "Delete $deployedApplicationPath failed" 1>&2
  else
    printf "%s %s %s\n" "$(decorate error "Unwind")" "$(decorate code "$deployedApplicationPath")" "$(decorate error "does not exist")"
  fi
  __failEnvironment "$usage" "$@"
}
_deployApplication() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
