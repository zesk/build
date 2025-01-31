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
  local usage="_${FUNCNAME[0]}"

  local readOnly=false

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
      --read-only)
        readOnly=true
        ;;
      *)
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  statusMessage --last printf -- "%s %s (%s)\n" "$(decorate info "[pre-commit]")" "$(decorate code ".php")" "$(decorate label "PHP Hypertext Processor")"
  __catchEnvironment "$usage" gitPreCommitListExtension php | wrapLines "- $(decorate bold-blue)" "$(decorate reset)" || return $?

  local home
  home=$(__catchEnvironment "$usage" buildHome) || return $?

  local mode

  mode=$(_choose "$readOnly" 0440 0640)
  statusMessage decorate info ".php script mode -> $(decorate code "$mode")"
  __catchEnvironment "$usage" find "$home" -type f -name '*.php' ! -path '*/bin/*' ! -path '*/.*/*' ! -path '*/vendor/*' -exec chmod -v "$mode" {} \; || return $?
  mode=$(_choose "$readOnly" 0550 0750)
  statusMessage decorate info ".php bin mode -> $(decorate code "$mode")"
  __catchEnvironment "$usage" find "$home" -type f -name '*.php' -path '*/bin/*' ! -path '*/.*/*' ! -path '*/vendor/*' -exec chmod -v "$mode" {} \; || return $?

  if [ ! -d "$home/vendor" ]; then
    statusMessage --last decorate warning "PHP commit - no vendor directory - no fixer"
    return $?
  fi

  local file changed=()
  while read -r file; do changed+=("$file"); done < <(gitPreCommitListExtension php)
  if [ ! -x "$home/vendor/bin/php-cs-fixer" ]; then
    statusMessage --last decorate error "Missing binary"
    __throwEnvironment "$usage" "No php-cs-fixer found" || return $?
  fi
  if [ ! -f "$home/.php-cs-fixer.php" ]; then
    statusMessage --last decorate error "Missing configuration"
    __throwEnvironment "$usage" "No .php-cs-fixer.php found" || return $?
  fi
  statusMessage decorate success "Fixing PHP"

  local fixResults

  fixResults=$(fileTemporaryName "$usage") || return $?

  "$home/vendor/bin/php-cs-fixer" fix --config "$home/.php-cs-fixer.php" "${changed[@]}" >"$fixResults" 2>&1 || __throwEnvironment "$usage" "php-cs-fixer failed: $(cat "$fixResults")" || _clean $? "$fixResults" || return $?
  if grep -q 'not fixed' "$fixResults"; then
    statusMessage --last decorate error "some files not fixed"
    dumpPipe --lines 100 'not fixed' <"$fixResults"
    rm -rf "$fixResults" || :L
    __throwEnvironment "$usage" "PHP files failed" || return $?
  fi
  statusMessage --last decorate success "PHP fixer ran"
  rm -f "$fixResults" || :

}
___hookPreCommitPHP() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookPreCommitPHP "$@"
