#!/usr/bin/env bash
#
# MariaDB tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# bin: mariadb
# Docs: ./documentation/source/tools/mariadb.md
# Test: ./test/tools/mariadb-tests.sh

# Dump a MariaDB database to raw SQL
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --print - Optional. Flag. Show the command.
# Argument: --binary - Optional. Executable. The binary to use to do the dump. Defaults to `MARIADB_BINARY_DUMP`.
# Argument: --lock - Optional. Flag. Lock the database during dump
# Argument: --password password - Optional. String. Password to connect
# Argument: --user user - Optional. String. User to connect
# Argument: --host host - Optional. String. Host to connect
# Argument: --port port - Optional. Integer. Port to connect
mariadbDump() {
  local usage="_${FUNCNAME[0]}"

  local options=() printFlag=false binary

  export MARIADB_BINARY_DUMP

  __catchEnvironment "$usage" buildEnvironmentLoad MARIADB_BINARY_DUMP || return $?

  binary="${MARIADB_BINARY_DUMP-}"
  [ -n "$binary" ] || binary=mariadbdump

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
      --print)
        printFlag=true
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
        # _IDENTICAL_ argumentUnknown 1
        __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done
  whichExists "$binary" || __catchEnvironment "$usage" "$binary not found in PATH: $PATH" || return $?
  options+=(--add-drop-table -c)

  if $printFlag; then
    printf "%s\n" "$binary ${options[*]-}"
  else
    "$binary" "${options[@]}"
  fi
}
_mariadbDump() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Connect to a mariadb-type database using a URL
#
# Argument: dsn - URL. Database to connect to. All arguments after this are passed to `binary`.
# Argument: binary - Callable. Executable to connect to the database.
# Argument: --print - Flag. Optional. Just print the statement instead of running it.
mariadbConnect() {
  local usage="_${FUNCNAME[0]}"
  local dsn="" binary="" printFlag=false

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
      --binary)
        shift
        binary=$(usageArgumentCallable "$usage" "$argument" "${1-}") || return $?
        ;;
      --print)
        printFlag=true
        ;;
      *)
        urlValid "$argument" || __throwArgument "dsn is not valid: ${#argument} chars" || return $?
        dsn="$argument"
        shift
        break
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  [ -n "$dsn" ] || __throwArgument "$usage" "dsn required" || return $?

  local url="" path="" name="" user="" password="" host="" port="" error=""
  # eval OK - urlParse
  eval "$(urlParse "$dsn")"
  [ -z "$error" ] || __throwEnvironment "DSN Parsing failed: $error" || return $?
  isPositiveInteger "$port" || port=3306
  : "$url $path $error"
  [ -n "$user" ] && [ -n "$password" ] && [ -n "$name" ] && [ -n "$host" ] || __throwArgument "$usage" "Unable to parse DSN: dsn=(${#dsn} chars)" "name=$name" "host=$host" "user=$user" "password=(${#password} chars)" || return $?
  local aa=(-u "$user" "-p$password" "--port=$port" -h "$host" "$name" "$@")
  if $printFlag; then
    printf "%s %s\n" "$binary" "${aa[*]}"
  else
    "$binary" "${aa[@]}"
  fi
}
_mariadbConnect() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
