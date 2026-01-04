#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
#
#    ▌      ▜
#  ▞▀▌▞▀▖▛▀▖▐ ▞▀▖▌ ▌
#  ▌ ▌▛▀ ▙▄▘▐ ▌ ▌▚▄▌
#  ▝▀▘▝▀▘▌   ▘▝▀ ▗▄▘
#
# Docs: o ./documentation/source/tools/deploy.md
# Test: o ./test/tools/deploy-tests.sh

__deployApplication() {
  local handler="$1" && shift

  # Arguments

  # --first --revert
  local exitCode=0 firstFlag=false revertFlag=false
  local message=""

  # Arguments in order
  local deployHome="" applicationId="" applicationPath="" verboseFlag=false targetPackage="" requiredArgs=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --verbose)
      verboseFlag=true
      ;;
    --message)
      shift
      [ -n "${1-}" ] || throwArgument "blank $argument argument" || return $?
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
      deployHome=$(usageArgumentDirectory "$handler" deployHome "${1-}") || return $?
      ;;
    --id)
      shift
      [ -n "${1-}" ] || throwArgument "blank $argument argument" || return $?
      applicationId="$1"
      ;;
    --application)
      shift
      applicationPath=$(usageArgumentFileDirectory "$handler" applicationPath "${1-}") || return $?
      ;;
    --target)
      shift
      [ -n "${1-}" ] || throwArgument "blank $argument argument" || return $?
      targetPackage="$1"
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  [ -n "$targetPackage" ] || targetPackage="$(deployPackageName)" || throwArgument "$handler" "No package name" || return $?
  if $revertFlag; then
    requiredArgs+=(applicationId)
  fi

  # Check arguments are non-blank and actually supplied
  requiredArgs+=(deployHome applicationPath)
  local name
  for name in "${requiredArgs[@]}"; do
    [ -n "${!name}" ] || throwArgument "$handler" "$name is required" || return $?
  done

  local currentApplicationId=""
  if [ -d "$applicationPath" ]; then
    if ! currentApplicationId="$(deployApplicationVersion "$applicationPath")" || [ -z "$currentApplicationId" ]; then
      if ! $firstFlag; then
        throwEnvironment "$handler" "Can not fetch version from $applicationPath,  need --first" || return $?
      fi
      currentApplicationId=
    fi
  fi

  if $revertFlag; then
    #
    # If reverting, check the application ID (if supplied) is correct otherwise fail
    #
    local newApplicationId
    newApplicationId=$(deployPreviousVersion "$deployHome" "$currentApplicationId") || throwEnvironment "$handler" "--revert can not find previous version of $currentApplicationId ($deployHome)" || return $?

    if [ -n "$applicationId" ] && [ "$applicationId" != "$currentApplicationId" ]; then
      throwArgument "$handler" "--id $applicationId does not match ID \"$currentApplicationId\" of $applicationPath" || return $?
    fi
    applicationId="$newApplicationId"
    printf "%s %s %s %s\n" "$(decorate info "Reverting from")" "$(decorate orange "$currentApplicationId")" "$(decorate info "->")" "$(decorate green "$applicationId")"
  fi

  #
  # Arguments are all parsed by here
  #
  local targetPackageFullPath="$deployHome/$applicationId/$targetPackage"
  [ -f "$targetPackageFullPath" ] || throwArgument "$handler" "deployApplication: Missing target file $targetPackageFullPath" || return $?

  #
  # Generates deployHome/{newVersion}/app and deletes on failure
  #
  # START _unwindDeploy
  #
  # `_unwindDeploy` after this guarantees this and always exits non-zero
  #
  local deployedApplicationPath="$deployHome/$applicationId/app"
  local unwindArgs=("$handler" "$applicationPath" "$deployedApplicationPath")

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
  local newApplicationId
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
        if ! hookRun --application "$applicationPath" maintenance --message "$message" on; then
          _unwindDeploy "${unwindArgs[@]}" "Turning maintenance on in $applicationPath failed" || return $?
        fi
      else
        printf "%s\n" "$(decorate info "No maintenance hook")"
      fi
      if hasHook --application "$applicationPath" deploy-shutdown; then
        printf "%s %s\n" "$(decorate warning "Running hook")" "$(decorate green "$(decorate code " deploy-shutdown ")")"
        if ! hookRun --application "$applicationPath" deploy-shutdown; then
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
    if ! hookRun --application "$deployedApplicationPath" deploy-start; then
      _unwindDeploy "${unwindArgs[@]}" "Running hook deploy-start failed" || return $?
    fi
  else
    ! $verboseFlag || statusMessage --last decorate info "No deploy-start hook"
  fi

  if hasHook --application "$deployedApplicationPath" deploy-activate; then
    printf "%s %s\n" "$(decorate warning "Running hook")" "$(decorate green "$(decorate code " deploy-activate ")")" || :
    if ! hookRun --application "$deployedApplicationPath" deploy-activate "$applicationPath"; then
      _unwindDeploy "${unwindArgs[@]}" "hookRun deploy-activate failed" || return $?
    fi
  else
    printf "%s %s -> %s\n" "$(decorate success "Activating application")" "$(decorate code " $applicationPath ")" "$(decorate green "$applicationId")" || :
    if ! deployLink "$applicationPath" "$deployedApplicationPath"; then
      _unwindDeploy "${unwindArgs[@]}" "deployLink $applicationPath $deployedApplicationPath failed" || return $?
    fi
  fi
  # STOP _unwindDeploy

  if ! hookRunOptional --application "$applicationPath" deploy-finish; then
    throwEnvironment "$handler" "Deploy finish failed" || exitCode=$?
  fi
  if ! hookRunOptional --application "$applicationPath" maintenance off; then
    throwEnvironment "$handler" "maintenance off failed" || exitCode=$?
  fi
  if [ $exitCode -eq 0 ]; then
    decorate success "Completed"
  else
    printf "%s %s\n" "$(decorate error "Exiting with code")" "$(decorate code "$exitCode")"
  fi
  return "$exitCode"
}
_unwindDeploy() {
  local handler="$1" && shift
  local applicationPath="$1" deployedApplicationPath="${2-}" && shift 2

  if ! hookRunOptional --application "$applicationPath" maintenance off; then
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
  throwEnvironment "$handler" "$@" || return $?
}
