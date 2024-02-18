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
  local initHome=/etc/init.d baseName exitCode removeFlag

  removeFlag=
  if [ ! -d "$initHome" ]; then
    _sysvInitScript "$errorEnvironment" "sysvInit directory does not exist $(consoleCode "$initHome")" || return $?
  fi
  while [ $# -gt 0 ]; do
    if [ -z "$1" ]; then
      _sysvInitScript "$errorArgument" "Blank argument" || return $?
    fi
    case "$1" in
      --remove)
        removeFlag=1
        ;;
      --add)
        removeFlag=
        ;;
      *)
        if ! baseName=$(basename "$1") || [ -z "$baseName" ]; then
          _sysvInitScript "$errorArgument" "No basename: $1" || return $?
        fi
        target="$initHome/$baseName"
        if test "$removeFlag"; then
          if [ -f "$target" ]; then
            if ! update-rc.d -f "$baseName" remove; then
              exitCode=$?
              _sysvInitScript "$errorEnvironment" "update-rc.d $baseName remove failed" || return "$exitCode"
            fi
            if ! rm "$target"; then
              _sysvInitScript "$errorEnvironment" "Can not remove $target" || return "$?"
            fi
            printf "%s %s\n" "$(consoleSuccess "sysvInit removed")" "$(consoleCode "$baseName")"
          else
            printf "%s %s\n" "$(consoleCode "$baseName")" "$(consoleWarning "not installed")"
            return 0
          fi
        else
          if [ ! -x "$1" ]; then
            _sysvInitScript "$errorArgument" "Not executable: $1" || return $?
          fi
          if [ -f "$target" ]; then
            if diff -q "$1" "$target"; then
              statusMessage consoleSuccess "reinstalling script: $(consoleCode "$baseName")"
            else
              _sysvInitScript "$errorEnvironment" "File already exists $(consoleCode "$target")" || return $?
            fi
          else
            statusMessage consoleSuccess "installing script: $(consoleCode "$baseName")"
          fi
          if ! cp "$1" "$target"; then
            _sysvInitScript "$errorEnvironment" "cp $1 $target failed - permissions error" || return $?
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
          printf "%s %s\n" "$(consoleSuccess "sysvInit installed successfully")" "$(consoleCode "$baseName")"
        fi
        ;;
    esac
    shift
  done
}
_sysvInitScript() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
