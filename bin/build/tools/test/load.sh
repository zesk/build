#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# load.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Load one or more test files and run the tests defined within
#
# Argument: filename ... - File. Required. Must be a valid shell file.
__testLoad() {
  local handler="$1" && shift

  export DEBUGGING_TEST_LOAD

  local __beforeFunctions && __beforeFunctions=$(fileTemporaryName "$handler") || return $?
  local __testFunctions && __testFunctions="$__beforeFunctions.after"
  local __errors && __errors="$__beforeFunctions.error"
  local __testFunctions && __testFunctions="$__beforeFunctions.after"
  local __tests=()
  while [ "$#" -gt 0 ]; do
    catchEnvironment "$handler" isExecutable "$1" || returnClean $? "$__beforeFunctions" "$__testFunctions" || return $?

    declare -pF | awk '{ print $3 }' | sort -u >"$__beforeFunctions"
    local tests=()
    set -a # UNDO ok
    # shellcheck source=/dev/null
    source "$1" >"$__errors" 2>&1 || throwEnvironment source "$1" || returnClean $? "$__beforeFunctions" "$__testFunctions" || returnUndo $? set +a || return $?
    fileIsEmpty "$__errors" || throwEnvironment "produced output: $(dumpPipe "source $1" <"$__errors")"
    set +a
    if [ "${#tests[@]}" -gt 0 ]; then
      local __test && for __test in "${tests[@]}"; do
        [ "$__test" = "${__test#"test"}" ] || decorate error "$1 - no longer need tests+=(\"$__test\")" 1>&2
      done
      __tests+=("${tests[@]}")
    fi
    local extraFunctions=()
    # diff outputs ("-" and "+") prefixes or ("< " and "> ")
    declare -pF | awk '{ print $3 }' | sort -u | muzzleReturn diff -U 0 "$__beforeFunctions" - | grep -e '^[-+][^+-]' | cut -c 2- | textTrim >"$__testFunctions" || :
    local __test && while read -r __test; do
      if [ "$__test" != "${__test#_}" ]; then
        extraFunctions+=("$__test")
        continue
      fi
      if [ "$__test" = "${__test#test}" ]; then
        decorate warning "Test function $(decorate code "$__test") found in test suites, start with $(decorate code "_") or $(decorate code "test")" 1>&2
        extraFunctions+=("$__test")
        continue
      fi
      ! inArray "$__test" "${__tests[@]+"${__tests[@]}"}" || {
        consoleLineFill
        decorate error "$1 - Duplicated: $(decorate code "$__test")"
      } 1>&2
      __tests+=("$__test")
    done <"$__testFunctions"
    shift
  done
  rm -rf "$__beforeFunctions" "$__testFunctions" || :
  [ "${#__tests[@]}" -gt 0 ] || return 0
  printf "%s\n" "${__tests[@]}"
}
