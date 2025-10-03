#!/usr/bin/env bash
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

__deployMigrateDirectoryToLink() {
  local handler="$1" && shift
  local start

  start=$(timingStart) || :
  local deployHome="" applicationPath=""
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$deployHome" ]; then
        deployHome="$(usageArgumentDirectory "$handler" "deployHome" "$1")" || return $?
      elif [ -z "$applicationPath" ]; then
        applicationPath="$(usageArgumentDirectory "$handler" "applicationPath" "$1")" || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      shift || __throwArgument "$handler" "shift after $argument failed" || return $?
      ;;
    esac
  done

  local tempAppLink appVersion
  appVersion=$(deployApplicationVersion "$applicationPath") || __throwEnvironment "$handler" "No application deployment version" || return $?
  if [ -L "$applicationPath" ]; then
    printf "%s %s %s\n" "$(decorate code "$applicationPath")" "$(decorate success "is already a link to")" "$(decorate red "$appVersion")"
    return 0
  fi
  deployHasVersion "$deployHome" "$appVersion" || __throwEnvironment "$handler" "Application version $appVersion not found in $deployHome" || return $?

  [ ! -d "$deployHome/$appVersion/app" ] || __throwEnvironment "$handler" "Old app directory $deployHome/$appVersion/app exists, stopping" || return $?
  hookRunOptional --application "$applicationPath" maintenance on || __throwEnvironment "$handler" "Unable to enable maintenance" || return $?
  tempAppLink="$applicationPath.$$.${FUNCNAME[0]}"
  # Create a temporary link to ensure it works
  if ! deployLink "$tempAppLink" "$deployHome/$appVersion/app"; then
    if ! hookRunOptional maintenance off; then
      decorate error "Maintenance off FAILED, system may be unstable" 1>&2
    fi
    __throwEnvironment "$handler" "deployLink failed" || return $?
  fi
  # Now move our folder and the link to where the folder was in one fell swoop
  # or mv -hf
  __catchEnvironment "$handler" mv -f "$applicationPath" "$deployHome/$appVersion/app" || __throwEnvironment "$handler" "Unable to move live application from $applicationPath to $deployHome/$appVersion/app" || return $?

  if ! __catchEnvironment "$handler" mv -f "$tempAppLink" "$applicationPath"; then
    # Like really? Like really? Something is likely F U B A R
    if ! __catchEnvironment "$handler" mv -f "$deployHome/$appVersion/app" "$applicationPath"; then
      decorate error "Unable to move BACK $deployHome/$appVersion/app $applicationPath - system is UNSTABLE" 1>&2
    else
      decorate success "Successfully recovered application to $applicationPath - stable"
    fi
    __throwEnvironment "$handler" "Unable to move live link $tempAppLink -> $applicationPath" || return $?
  fi
  if ! hookRunOptional --application "$applicationPath" maintenance off; then
    decorate error "Maintenance ON FAILED, system may be unstable" 1>&2
  fi
  {
    decorate success "Successfully migrated:"
    decorate pair 20 "Link:" "$applicationPath"
    decorate pair 20 "Installed:" "$deployHome/$appVersion/app"
    # Move directory, then re-link
  }
  timingReport "$start" "Completed in"
}
