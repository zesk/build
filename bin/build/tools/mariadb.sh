#!/usr/bin/env bash
#
# MariaDB tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# bin: mariadb
# Docs: ./docs/_templates/tools/mariadb.md
# Test: ./test/tools/mariadb-tests.sh

# Dump a MariaDB database to raw SQL
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --echo - Optional. Flag. Show the command.
# Argument: --binary - Optional. Executable. The binary to use to do the dump. Defaults to `MARIADB_BINARY_DUMP`.
# Argument: --lock - Optional. Flag. Lock the database during dump
# Argument: --password password - Optional. String. Password to connect
# Argument: --user user - Optional. String. User to connect
# Argument: --host host - Optional. String. Host to connect
# Argument: --port port - Optional. Integer. Port to connect
mariadbDump() {
  local usage="_${FUNCNAME[0]}"
  local argument nArguments argumentIndex saved
  local options binary echoFlag=false

  export MARIADB_BINARY_DUMP

  __usageEnvironment "$usage" buildEnvironmentLoad MARIADB_BINARY_DUMP || return $?

  binary="${MARIADB_BINARY_DUMP-}"
  [ -n "$binary" ] || binary=mariadbdump
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
      --echo)
        echoFlag=true
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
        __failArgument "$usage" "unknown #$argumentIndex/$nArguments: $argument $(decorate each code "${saved[@]}")" || return $?
        ;;
    esac
    # IDENTICAL argument-esac-shift 1
    shift || __failArgument "$usage" "missing #$argumentIndex/$nArguments: $argument $(decorate each code "${saved[@]}")" || return $?
  done
  whichExists "$binary" || __usageEnvironment "$usage" "$binary not found in PATH: $PATH" || return $?
  options+=(--add-drop-table -c)

  if $echoFlag; then
    printf "%s\n" "$binary ${options[*]-}"
  else
    "$binary" "${options[@]}"
  fi
}
_mariadbDump() {
  # IDENTICAL usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
