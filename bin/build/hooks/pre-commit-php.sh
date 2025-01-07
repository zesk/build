#!/usr/bin/env bash
#
# Part of build system integration with git
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

# IDENTICAL zesk-build-hook-header 3
# shellcheck source=/dev/null
set -eou pipefail
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

  # IDENTICAL argument-case-header 5
  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --read-only)
        readOnly=true
        ;;
      *)
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done

  statusMessage --last printf -- "%s %s (%s)\n" "$(decorate info "[pre-commit]")" "$(decorate code ".php")" "$(decorate label "PHP Hypertext Processor")"
  __usageEnvironment "$usage" gitPreCommitListExtension php | wrapLines "- $(decorate bold-blue)" "$(decorate reset)"

  local mode

  mode=$(_choose "$readOnly" 0440 0640)
  statusMessage decorate info ".php script mode -> $(decorate code "$mode")"
  __usageEnvironment "$usage" find "$home" -type f -name '*.php' ! -path '*/bin/*' ! -path '*/.*/*' ! -path '*/vendor/*' -exec chmod -v "$mode" {} \; || return $?
  mode=$(_choose "$readOnly" 0550 0750)
  statusMessage decorate info ".php bin mode -> $(decorate code "$mode")"
  __usageEnvironment "$usage" find "$home" -type f -name '*.php' -path '*/bin/*' ! -path '*/.*/*' ! -path '*/vendor/*' -exec chmod -v "$mode" {} \; || return $?

  local home
  home=$(__usageEnvironment "$usage" buildHome) || return $?

  if [ ! -d "$home/vendor" ]; then
    statusMessage --last decorate warning "PHP commit - no vendor directory - no fixer"
    return $?
  fi

  local file changed=()
  while read -r file; do changed+=("$file"); done < <(gitPreCommitListExtension php)
  if [ ! -x "$home/vendor/bin/php-cs-fixer" ]; then
    statusMessage --last decorate error "Missing binary"
    __failEnvironment "$usage" "No php-cs-fixer found" || return $?
  fi
  if [ ! -f "$home/.php-cs-fixer.php" ]; then
    statusMessage --last decorate error "Missing configuration"
    __failEnvironment "$usage" "No .php-cs-fixer.php found" || return $?
  fi
  statusMessage decorate success "Fixing PHP"

  local fixResults

  fixResults=$(__usageEnvironment "$usage" mktemp) || return $?

  "$home/vendor/bin/php-cs-fixer" fix --config "$home/.php-cs-fixer.php" "${changed[@]}" >"$fixResults" 2>&1 || __failEnvironment "$usage" "php-cs-fixer failed: $(cat "$fixResults")" || _clean $? "$fixResults" || return $?
  if grep -q 'not fixed' "$fixResults"; then
    statusMessage --last decorate error "some files not fixed"
    dumpPipe --lines 100 'not fixed' <"$fixResults"
    rm -rf "$fixResults" || :L
    __failEnvironment "$usage" "PHP files failed" || return $?
  fi
  statusMessage --last decorate success "PHP fixer ran"
  rm -f "$fixResults" || :

}
___hookPreCommitPHP() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__hookPreCommitPHP "$@"
