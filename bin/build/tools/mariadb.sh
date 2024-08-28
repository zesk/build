#!/usr/bin/env bash
#
# MariaDB tools
#
# Copyright &copy; 2024 Market Acumen, Inc.
#
# bin: mariadb
# Docs: ./docs/_templates/tools/mariadb.md
# Test: ./test/tools/mariadb-tests.sh

mariadbDump() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local options binary

  binary=mariadbdump
  saved=("$@")
  nArguments=$#
  while [ $# -gt 0 ]; do
    argumentIndex=$((nArguments - $# + 1))
    argument="$(usageArgumentString "$usage" "argument #$argumentIndex (Arguments: $(_command "${usage#_}" "${saved[@]}"))" "$1")" || return $?
    case "$argument" in
      # IDENTICAL --help 4
      --help)
        "$usage" 0
        return $?
        ;;
      --binary)
        shift
        binary=$(usageArgumentExecutable "$usage" "$argument" "${1-}") || return $?
        ;;
      --lock)
        options+=(--lock-tables)
        ;;
      --user)
        shift
        options+=("--user=$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --password)
        shift
        options+=("--password=$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      --port)
        shift
        options+=("--port=$(usageArgumentInteger "$usage" "$argument" "${1-}")") || return $?
        ;;
      --host)
        shift
        options+=("--host=$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
        ;;
      *)
        # IDENTICAL argumentUnknown 1
        __failArgument "$usage" "unknown argument #$argumentIndex: $argument (Arguments: $(_command "${saved[@]}"))" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing argument #$argumentIndex: $argument (Arguments: $(_command "${usage#_}" "${saved[@]}"))" || return $?
  done
  whichExists "$binary" || __usageEnvironment "$usage" "$binary not found in PATH: $PATH" || return $?
  options+=(--add-drop-table -c)

  "$binary" "${options[@]}"
}
