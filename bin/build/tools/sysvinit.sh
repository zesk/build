#!/usr/bin/env bash
#
# systemd Support
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/ops/sysvinit.md
# Test: o ./test/ops/sysvinit-tests.sh

# Install a script to run upon initialization.
# Usage: {fn} script
# Argument: binary - Required. String. Binary to install at startup.
sysvInitScriptInstall() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local initHome baseName target

  initHome=$(__sysvInitScriptInitHome "$usage") || return $?
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        baseName=$(__usageArgument "$usage" basename "$argument") || return $?
        target="$initHome/$baseName"
        [ -x "$argument" ] || __failArgument "$usage" "Not executable: $argument" || return $?
        if [ -f "$target" ]; then
          if diff -q "$1" "$target" >/dev/null; then
            statusMessage consoleSuccess "reinstalling script: $(consoleCode "$baseName")"
          else
            __failEnvironment "$usage" "$(consoleCode "$target") already exists - remove first" || return $?
          fi
        else
          statusMessage consoleSuccess "installing script: $(consoleCode "$baseName")"
        fi
        __usageEnvironment "$usage" cp -f "$argument" "$target" || return $?
        statusMessage consoleWarning "Updating mode of $(consoleCode "$baseName") ..."
        __usageEnvironment "$usage" chmod +x "$target" || return $?
        statusMessage consoleWarning "rc.d defaults $(consoleCode "$baseName") ..."
        __usageEnvironment "$usage" update-rc.d "$baseName" defaults || return $?
        clearLine
        printf "%s %s\n" "$(consoleCode "$baseName")" "$(consoleSuccess "installed successfully")"
        ;;
    esac
    shift
  done
}
_sysvInitScriptInstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove an initialization script
# Usage: {fn} script ...
# Argument: binary - Required. String. Basename of installed
sysvInitScriptUninstall() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex
  local initHome baseName target

  initHome=$(__sysvInitScriptInitHome "$usage") || return $?
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      *)
        baseName=$(__usageArgument "$usage" basename "$argument") || return $?
        target="$initHome/$baseName"
        if [ -f "$target" ]; then
          update-rc.d -f "$baseName" remove || __failEnvironment "$usage" "update-rc.d $baseName remove failed" || return $?
          __usageEnvironment "$usage" rm -f "$target" || return $?
          printf "%s %s\n" "$(consoleCode "$baseName")" "$(consoleSuccess "removed successfully")"
        else
          printf "%s %s\n" "$(consoleCode "$baseName")" "$(consoleWarning "not installed")"
        fi
        ;;
    esac
    shift
  done
}
_sysvInitScriptUninstall() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Fetch the home directory and make sure it exists
__sysvInitScriptInitHome() {
  local usage="$1" initHome=/etc/init.d
  [ -d "$initHome" ] || __failEnvironment "$usage" "sysvInit directory does not exist $(consoleCode "$initHome")" || return $?
  printf "%s\n" "$initHome"
}
