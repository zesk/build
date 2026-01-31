#!/usr/bin/env bash
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__bashPromptModule_TermColors() {
  local handler="$1" && shift

  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0

  local home
  home=$(catchReturn "$handler" buildHome) || return 0

  local debug=false
  ! buildDebugEnabled term-colors || debug=true

  local schemeFile dd=()
  ! $debug || dd+=("--debug")

  local savedState savedModified=""
  savedState=$(catchReturn "$handler" buildEnvironmentGet BUILD_TERM_COLORS_STATE) || return $?
  if [ -n "$savedState" ]; then
    local savedHome savedModified
    savedHome="${savedState%|*}"
    savedModified="${savedState##*|}"
    ! $debug || statusMessage decorate info "BUILD_TERM_COLORS_STATE=$savedState -> $savedHome ($savedModified)"
    if [ "$savedHome" != "$home" ]; then
      ! $debug || statusMessage decorate info "Saved home changed for term colors: $savedHome (saved) != $home (current)"
      savedState=""
    fi
  else
    ! $debug || statusMessage decorate info "BUILD_TERM_COLORS_STATE is blank"
  fi

  # Deprecated files
  for schemeFile in "$home/.term-colors.conf" "$home/etc/term-colors.conf" "$home/.iterm2-colors.conf" "$home/etc/iterm2-colors.conf"; do
    ! $debug || statusMessage decorate info "Looking at $(decorate file "$schemeFile")"
    if [ ! -f "$schemeFile" ]; then
      ! $debug || statusMessage decorate info "$(decorate file "$schemeFile") does not exist"
      continue
    fi
    local modified
    modified=$(catchReturn "$handler" fileModificationTime "$schemeFile") || return $?
    if ! isInteger "$savedModified" || [ "$modified" -gt "$savedModified" ]; then
      ! $debug || statusMessage decorate info "Applying colors from $(decorate file "$schemeFile") ... "
      if catchReturn "$handler" colorScheme "${dd[@]+"${dd[@]}"}" <"$schemeFile" || return $?; then
        export BUILD_TERM_COLORS_STATE
        BUILD_TERM_COLORS_STATE="$home|$modified"
        ! $debug || statusMessage decorate info "BUILD_TERM_COLORS_STATE=$home|$modified"
        break
      fi
    else
      ! $debug || statusMessage decorate info "$schemeFile modified ($modified) before $savedModified"
    fi
  done
}
