#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
set -eou pipefail
# shellcheck source=/dev/null
source "${BASH_SOURCE[0]%/*}/../tools.sh"

#
# The `git-pre-commit` hook self-installs as a `git` pre-commit hook in your project and will
# overwrite any existing `pre-commit` hook.
#
# It will:
# 1. Updates the help file templates
# 2. Checks all shell files for errors
# fn: {base}
__hookPreCommitPHP() {
  local handler="_${FUNCNAME[0]}"

  local readOnly=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || returnThrowArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --read-only)
      readOnly=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      returnThrowArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local start

  start=$(timingStart)

  statusMessage --last printf -- "%s %s (%s)\n" "$(decorate info "[pre-commit]")" "$(decorate code ".php")" "$(decorate label "PHP Hypertext Processor")"
  catchEnvironment "$handler" gitPreCommitListExtension php | decorate bold-blue | decorate wrap "- " || return $?

  local home mode

  home=$(returnCatch "$handler" buildHome) || return $?
  mode=$(booleanChoose "$readOnly" 0440 0640)

  statusMessage --last decorate info ".php script mode -> $(decorate code "$mode")"
  catchEnvironment "$handler" find "$home" -type f -name '*.php' ! -path '*/bin/*' ! -path '*/.*/*' ! -path '*/vendor/*' -exec chmod -v "$mode" {} \; || return $?
  mode=$(booleanChoose "$readOnly" 0550 0750)
  statusMessage --last decorate info ".php bin mode -> $(decorate code "$mode")"
  catchEnvironment "$handler" find "$home" -type f -name '*.php' -path '*/bin/*' ! -path '*/.*/*' ! -path '*/vendor/*' -exec chmod -v "$mode" {} \; || return $?

  if [ ! -d "$home/vendor" ]; then
    statusMessage --last decorate warning "PHP commit - no vendor directory - no fixer"
    return $?
  fi

  local done=false file changed=()
  while ! $done; do
    read -r file || done=true
    [ -z "$file" ] || changed+=("$file")
  done < <(gitPreCommitListExtension php)
  if [ ! -x "$home/vendor/bin/php-cs-fixer" ]; then
    statusMessage --last decorate error "Missing binary"
    returnThrowEnvironment "$handler" "No php-cs-fixer found" || return $?
  fi
  if [ ! -f "$home/.php-cs-fixer.php" ]; then
    statusMessage --last decorate error "Missing configuration"
    returnThrowEnvironment "$handler" "No .php-cs-fixer.php found" || return $?
  fi
  statusMessage decorate success "Fixing PHP"

  local fixResults

  fixResults=$(fileTemporaryName "$handler") || return $?

  "$home/vendor/bin/php-cs-fixer" fix --config "$home/.php-cs-fixer.php" "${changed[@]}" >"$fixResults" 2>&1 || returnThrowEnvironment "$handler" "php-cs-fixer failed: $(cat "$fixResults")" || returnClean $? "$fixResults" || return $?
  if grep -q 'not fixed' "$fixResults"; then
    statusMessage --last decorate error "some files not fixed"
    dumpPipe --lines 100 'not fixed' <"$fixResults"
    rm -rf "$fixResults" || :L
    returnThrowEnvironment "$handler" "PHP files failed" || return $?
  fi
  statusMessage decorate success "PHP fixer ran"
  statusMessage decorate success "PHP fixer ran"
  catchEnvironment "$handler" rm -f "$fixResults" || return $?

  if [ -f "$home/composer.json" ]; then
    statusMessage decorate info "Updating version ..."
    phpComposerSetVersion
  fi

  statusMessage --last timingReport "$start" "PHP pre-commit finished in"
}
___hookPreCommitPHP() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookPreCommitPHP "$@"
