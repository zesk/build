#!/usr/bin/env bash
#
# systemd Support
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/ops/sysvinit.md
# Test: o ./test/ops/sysvinit-tests.sh

# Install a script to run upon initialization.
# Usage: {fn} script
# Argument: binary - Required. String. Binary to install at startup.
sysvInitScriptInstall() {
  local handler="_${FUNCNAME[0]}"

  local initHome=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local baseName target
      if [ -z "$initHome" ]; then
        initHome=$(__sysvInitScriptInitHome "$handler") || return $?
      fi
      baseName=$(catchArgument "$handler" basename "$argument") || return $?
      target="$initHome/$baseName"
      [ -x "$argument" ] || throwArgument "$handler" "Not executable: $argument" || return $?
      if [ -f "$target" ]; then
        if diff -q "$1" "$target" >/dev/null; then
          statusMessage decorate success "reinstalling script: $(decorate code "$baseName")"
        else
          throwEnvironment "$handler" "$(decorate code "$target") already exists - remove first" || return $?
        fi
      else
        statusMessage decorate success "installing script: $(decorate code "$baseName")"
      fi
      catchEnvironment "$handler" cp -f "$argument" "$target" || return $?
      statusMessage decorate warning "Updating mode of $(decorate code "$baseName") ..."
      catchEnvironment "$handler" chmod +x "$target" || return $?
      statusMessage decorate warning "rc.d defaults $(decorate code "$baseName") ..."
      catchEnvironment "$handler" update-rc.d "$baseName" defaults || return $?
      statusMessage --last printf -- "%s %s\n" "$(decorate code "$baseName")" "$(decorate success "installed successfully")"
      ;;
    esac
    shift
  done
}
_sysvInitScriptInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove an initialization script
# Usage: {fn} script ...
# Argument: binary - Required. String. Basename of installed
sysvInitScriptUninstall() {
  local handler="_${FUNCNAME[0]}"

  local initHome=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      local baseName target
      if [ -z "$initHome" ]; then
        initHome=$(__sysvInitScriptInitHome "$handler") || return $?
      fi
      baseName=$(catchArgument "$handler" basename "$argument") || return $?
      target="$initHome/$baseName"
      if [ -f "$target" ]; then
        update-rc.d -f "$baseName" remove || throwEnvironment "$handler" "update-rc.d $baseName remove failed" || return $?
        catchEnvironment "$handler" rm -f "$target" || return $?
        printf "%s %s\n" "$(decorate code "$baseName")" "$(decorate success "removed successfully")"
      else
        printf "%s %s\n" "$(decorate code "$baseName")" "$(decorate warning "not installed")"
      fi
      ;;
    esac
    shift
  done
}
_sysvInitScriptUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch the home directory and make sure it exists
__sysvInitScriptInitHome() {
  local handler="$1" initHome=/etc/init.d
  [ -d "$initHome" ] || throwEnvironment "$handler" "sysvInit directory does not exist $(decorate code "$initHome")" || return $?
  printf "%s\n" "$initHome"
}
