#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# notify.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Summary: Send a notification by submitting data to a URL
# Argument: --tags tagList - CommaDelimitedList. Optional. Tags for notification. e.g. `warning,production`
# Argument: --priority priority - String. Optional. Priority of the notification. `low`, or `high`
# Argument: --title title - String. Optional. Title of the notification.
# Argument: --response responseHandler - Function. Optional. Use this handler to parse the result and output a response ID.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Environment: NOTIFY_URL
# Environment: NOTIFY_URL_AUTHORIZATION
notifyURL() {
  local handler="_${FUNCNAME[0]}"

  local title="" priority="" tags="" message="" method="PUT" url="" urlAuth=""
  local hh=(urlFetch)

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
    --title) shift && title="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --priority) shift && priority="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --tags) shift && tags="$(validate "$handler" CommaDelimitedList "$argument" "${1-}")" || return $? ;;
    --url) shift && url="$(validate "$handler" URL "$argument" "${1-}")" || return $? ;;
    --authorization) shift && urlAuth="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --method) shift && method="$(validate "$handler" String "$argument" "${1-}")" || return $? ;;
    --debug) hh=(executeEcho urlFetch --debug) || : ;;
    -*)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    *) message="$*" && break ;;
    esac
    shift
  done

  [ -n "$message" ] || throwArgument "$handler" "Message is required" || return $?
  [ -n "$url" ] || url=$(buildEnvironmentGet --quiet NOTIFY_URL) || return $?
  [ -n "$url" ] || throwArgument "$handler" "--url or NOTIFY_URL is required" || return $?
  [ -n "$urlAuth" ] || urlAuth=$(buildEnvironmentGet --quiet NOTIFY_URL_AUTHORIZATION) || return $?

  hh+=(--data "$message")
  [ -z "$title" ] || hh+=(--header "Title: $title")
  [ -z "$priority" ] || hh+=(--header "Priority: $priority")
  [ -z "$tags" ] || hh+=(--header "Tags: $tags")
  [ -z "$urlAuth" ] || hh+=(--header "Authorization: Bearer $urlAuth")
  [ -z "$method" ] || hh+=(--method "$method")

  catchReturn "$handler" "${hh[@]}" "$url" || return $?
}
_notifyURL() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
