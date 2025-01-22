#!/usr/bin/env bash
#
# systemd Support
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/ops/sysvinit.md
# Test: o ./test/ops/sysvinit-tests.sh

# Install a script to run upon initialization.
# Usage: {fn} script
# Argument: binary - Required. String. Binary to install at startup.
sysvInitScriptInstall() {
  local usage="_${FUNCNAME[0]}"

  local initHome

  initHome=$(__sysvInitScriptInitHome "$usage") || return $?
  # IDENTICAL argument-case-header 5
  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument="$1" argumentIndex=$((nArguments - $# + 1))
    [ -n "$argument" ] || __failArgument "$usage" "blank #$argumentIndex/$nArguments: $(decorate each code "${saved[@]}")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        local baseName target
        baseName=$(__usageArgument "$usage" basename "$argument") || return $?
        target="$initHome/$baseName"
        [ -x "$argument" ] || __failArgument "$usage" "Not executable: $argument" || return $?
        if [ -f "$target" ]; then
          if diff -q "$1" "$target" >/dev/null; then
            statusMessage decorate success "reinstalling script: $(decorate code "$baseName")"
          else
            __failEnvironment "$usage" "$(decorate code "$target") already exists - remove first" || return $?
          fi
        else
          statusMessage decorate success "installing script: $(decorate code "$baseName")"
        fi
        __usageEnvironment "$usage" cp -f "$argument" "$target" || return $?
        statusMessage decorate warning "Updating mode of $(decorate code "$baseName") ..."
        __usageEnvironment "$usage" chmod +x "$target" || return $?
        statusMessage decorate warning "rc.d defaults $(decorate code "$baseName") ..."
        __usageEnvironment "$usage" update-rc.d "$baseName" defaults || return $?
        statusMessage --last printf -- "%s %s\n" "$(decorate code "$baseName")" "$(decorate success "installed successfully")"
        ;;
    esac
    shift
  done
}
_sysvInitScriptInstall() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove an initialization script
# Usage: {fn} script ...
# Argument: binary - Required. String. Basename of installed
sysvInitScriptUninstall() {
  local usage="_${FUNCNAME[0]}"

  local initHome

  initHome=$(__sysvInitScriptInitHome "$usage") || return $?

  # IDENTICAL argument-case-header 5
  local saved=("$@") nArguments=$#
  while [ $# -gt 0 ]; do
    local argument="$1" argumentIndex=$((nArguments - $# + 1))
    [ -n "$argument" ] || __failArgument "$usage" "blank #$argumentIndex/$nArguments: $(decorate each code "${saved[@]}")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        local baseName target
        baseName=$(__usageArgument "$usage" basename "$argument") || return $?
        target="$initHome/$baseName"
        if [ -f "$target" ]; then
          update-rc.d -f "$baseName" remove || __failEnvironment "$usage" "update-rc.d $baseName remove failed" || return $?
          __usageEnvironment "$usage" rm -f "$target" || return $?
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
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch the home directory and make sure it exists
__sysvInitScriptInitHome() {
  local usage="$1" initHome=/etc/init.d
  [ -d "$initHome" ] || __failEnvironment "$usage" "sysvInit directory does not exist $(decorate code "$initHome")" || return $?
  printf "%s\n" "$initHome"
}
