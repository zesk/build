#!/usr/bin/env bash
#
# systemd Support
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/ops/sysvinit.md
# Test: o ./test/ops/sysvinit-tests.sh

errorEnvironment=1

errorArgument=2

# Install a script to run upon initialization.
# Usage: {fn} script
# Argument: binary - Required. String. Binary to install at startup.
sysvInitScript() {
  local initHome=/etc/init.d baseName exitCode

  if [ ! -d "$initHome" ]; then
    _sysvInitScript "$errorEnvironment" "sysvInit directory does not exist $(consoleCode "$initHome")" || return $?
  fi
  while [ $# -gt 0 ]; do
    if [ ! -x "$1" ]; then
      _sysvInitScript "$errorArgument" "Not executable: $1" || return $?
    fi
    if ! baseName=$(basename "$1") || [ -z "$baseName" ]; then
      _sysvInitScript "$errorArgument" "No basename: $1" || return $?
    fi
    target="$initHome/$baseName"
    if [ -f "$target" ]; then
      if diff -q "$1" "$target"; then
        statusMessage consoleSucess "sysvInit already installed: $(consoleCode "$baseName")"
      else
        _sysvInitScript "$errorEnvironment" "File already exists $(consoleCode "$target")" || return $?
      fi
    else
      statusMessage consoleSucess "installing script: $(consoleCode "$baseName")"
      if ! cp "$1" "$target"; then
        _sysvInitScript "$errorEnvironment" "cp $1 $target failed - permissions error" || return $?
      fi
    fi
    statusMessage consoleWarning "Updating mode of $(consoleCode "$baseName") ..."
    if ! chmod +x "$target"; then
      _sysvInitScript "$errorEnvironment" "chmod +x $target failed - permissions error" || return $?
    fi
    statusMessage consoleWarning "rc.d defaults $(consoleCode "$baseName") ..."
    if ! update-rc.d "$baseName" defaults; then
      exitCode=$?
      _sysvInitScript "$errorEnvironment" "update-rc.d $baseName defaults failed" || return "$exitCode"
    fi
    clearLine
    printf "%s %s\n" "$(consoleSucess "sysvInit installed successfully:")" "$(consoleCode "$baseName")"
    shift
  done
}
_sysvInitScript() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
