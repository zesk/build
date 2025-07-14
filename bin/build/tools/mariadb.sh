#!/usr/bin/env bash
#
# MariaDB tools
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# bin: mariadb
# Docs: ./documentation/source/tools/mariadb.md
# Test: ./test/tools/mariadb-tests.sh

# Install `mariadb`
#
# If this fails it will output the installation log.
#
# Usage: mariadbInstall [ package ]
# Usage: {fn} [ package ... ]
# Argument: package - Additional packages to install
# Summary: Install `mariadb`
# When this tool succeeds the `mariadb` binary is available in the local operating system.
# Environment: - `BUILD_NPM_VERSION` - String. Default to `latest`. Used to install `npm -i npm@$BUILD_NPM_VERSION` on install.
# Exit Code: 1 - If installation fails
# Exit Code: 0 - If installation succeeds
# Binary: mariadb-client.sh
#
mariadbInstall() {
  local usage="_${FUNCNAME[0]}"
  __catchEnvironment "$usage" packageGroupInstall mariadb || return $?
}
_mariadbInstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Uninstall mariadb
mariadbUninstall() {
  local usage="_${FUNCNAME[0]}"
  __catchEnvironment "$usage" packageGroupUninstall mariadb || return $?
}
_mariadbUninstall() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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

  export MARIADB_BINARY_DUMP
  [ -n "$binary" ] || binary=$(buildEnvironmentGet MARIADB_BINARY_DUMP) || return $?
  [ -n "$binary" ] || binary=$(packageDefault mysqldump)
  [ -n "$binary" ] || __throwArgument "$usage" "--binary not supplied and MARIADB_BINARY_DUMP is blank - at least one is required (MARIADB_BINARY_DUMP=${MARIADB_BINARY_DUMP-})" || return $?

  whichExists "$binary" || __catchEnvironment "$usage" "$binary not found in PATH: $PATH" || return $?
  options+=(--add-drop-table -c)

  if $printFlag; then
    printf "%s\n" "$binary ${options[*]-}"
  else
    "$binary" "${options[@]}" | mariadbDumpClean
  fi
}
_mariadbDump() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Clean mariadb dumps of the dreaded
# Code: /*!999999\- enable the sandbox mode */
# stdin: mariadbDump
# stdout: mariadbDump (cleaned)
# See: https://mariadb.org/mariadb-dump-file-compatibility-change/
mariadbDumpClean() {
  # Without LC_CTYPE and LAND it outputs the error:
  # - 'sed: RE error: illegal byte sequence' when encountering unicode byte sequences in a text stream
  LC_CTYPE=C LANG=C sed '/^\/\*M!999999/d'
}

# Connect to a mariadb-type database using a URL
#
# Argument: dsn - URL. Database to connect to. All arguments after this are passed to `binary`.
# Argument: binary - Callable. Executable to connect to the database.
# Argument: --print - Flag. Optional. Just print the statement instead of running it.
# Environment: MARIADB_BINARY_CONNECT
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

  export MARIADB_BINARY_CONNECT

  [ -n "$binary" ] || binary=$(buildEnvironmentGet MARIADB_BINARY_CONNECT) || return $?
  [ -n "$binary" ] || binary=$(packageDefault mysql)
  [ -n "$binary" ] || __throwArgument "$usage" "--binary not supplied and MARIADB_BINARY_CONNECT is blank - at least one is required (MARIADB_BINARY_CONNECT=${MARIADB_BINARY_CONNECT-})" || return $?
  $printFlag || isCallable "$binary" || __throwArgument "$usage" "binary $binary is not executable (MARIADB_BINARY_CONNECT=${MARIADB_BINARY_CONNECT-})" || return $?

  [ -n "$dsn" ] || __throwArgument "$usage" "dsn required" || return $?

  local url="" path="" name="" user="" password="" host="" port="" error=""
  # eval OK - urlParse
  eval "$(urlParse "$dsn")"
  [ -z "$error" ] || __throwEnvironment "DSN Parsing failed: $error" || return $?
  isPositiveInteger "$port" || port=3306
  : "$url $path $error"
  [ -n "$user" ] && [ -n "$password" ] && [ -n "$name" ] && [ -n "$host" ] || __throwArgument "$usage" "Unable to parse DSN: dsn=(${#dsn} chars)" "name=$name" "host=$host" "user=$user" "password=(${#password} chars)" || return $?
  local aa=(-u "$user" "-p$password" -h "$host")
  if [ $port != 3306 ]; then
    # Excluding port with localhost connects via socket so only include if non-standard
    aa+=("--port=$port")
  fi
  aa+=("$name" "$@")
  if $printFlag; then
    printf "%s %s\n" "$binary" "${aa[*]}"
  else
    "$binary" "${aa[@]}"
  fi
}
_mariadbConnect() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Darwin: macports Notes
#
#
# sudo -u _mysql /opt/local/lib/mariadb-11.4/bin/mariadb-install-db
#
# You can start the MariaDB daemon with:
# cd '/opt/local' ; /opt/local/lib/mariadb-11.4/bin/mariadbd-safe --datadir='/opt/local/var/db/mariadb-11.4'

#
#  Installing MariaDB/MySQL system tables in '/opt/local/var/db/mariadb-11.4' ...
#  OK
#
#  To start mariadbd at boot time you have to copy
#  support-files/mariadb.service to the right place for your system
#
#
#  Two all-privilege accounts were created.
#  One is root@localhost, it has no password, but you need to
#  be system 'root' user to connect. Use, for example, sudo mysql
#  The second is _mysql@localhost, it has no password either, but
#  you need to be the system '_mysql' user to connect.
#  After connecting you can set the password, if you would need to be
#  able to connect as any of these users with a password and without sudo
#
#  See the MariaDB Knowledgebase at https://mariadb.com/kb
#
#  You can start the MariaDB daemon with:
#  cd '/opt/local' ; /opt/local/lib/mariadb-11.4/bin/mariadbd-safe --datadir='/opt/local/var/db/mariadb-11.4'
#
#  You can test the MariaDB daemon with mariadb-test-run.pl
#  cd '/opt/local/share/mariadb-11.4/mysql-test' ; perl mariadb-test-run.pl
#
#  Please report any problems at https://mariadb.org/jira
#
#  The latest information about MariaDB is available at https://mariadb.org/.
#
#  Consider joining MariaDB's strong and vibrant community:
#  https://mariadb.org/get-involved/
#
