#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# filter.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

__testSuiteTestsSearch() {
  local handler="$1" && shift
  local query=() postQuery=() notQuery=() debugFlag=false
  while [ $# -gt 0 ]; do
    local argument="$1"
    case "$1" in
    --debug) debugFlag=true ;;
    --suite)
      shift && item=$(validate "$handler" String "$argument" "$1") || return $?
      query+=("-i" "-e" "suite=$(quoteGrepPattern "$1")")
      ;;
    --tag)
      shift && item=$(validate "$handler" String "$argument" "$1") || return $?
      if [ "${item:0:1}" = "+" ]; then
        [ "${#postQuery[@]}" -eq 0 ] || postQuery+=("--")
        postQuery+=("-i" "-e" "tag=$(quoteGrepPattern "${item:1}")")
      else
        postQuery+=("-i" "-e" "tag=$(quoteGrepPattern "$item")")
      fi
      ;;
    --skip-tag)
      shift && item=$(validate "$handler" String "$argument" "$1") || return $?
      if [ "${item:0:1}" = "+" ]; then
        [ "${#notQuery[@]}" -eq 0 ] || notQuery+=("--")
        notQuery+=("-v" "-i" "-e" "tag=$(quoteGrepPattern "${item:1}")")
      else
        notQuery+=("-v" "-i" "-e" "tag=$(quoteGrepPattern "$item")")
      fi
      ;;
    *)
      item=$(validate "$handler" String "testNamePattern" "$1") || return $?
      query+=("-i" "-e" "$(quoteGrepPattern "$item")")
      ;;
    esac
    shift
  done
  local aa=("${query[@]+"${query[@]}"}" -- "${postQuery[@]+"${postQuery[@]}"}" -- "${notQuery[@]+"${notQuery[@]}"}")
  __testSuiteGrepChain "$debugFlag" "${aa[@]}"
  ! $debugFlag || decorate each quote __testSuiteGrepChain "${#aa[@]}" "${aa[@]}" 1>&2
}

__testSuiteGrepChain() {
  local debugFlag="$1" && shift
  local args=() invert=()
  while [ $# -gt 0 ]; do
    if [ "$1" = "-v" ]; then
      invert[0]="$1"
    elif [ "$1" = "-i" ]; then
      invert[1]="$1"
    elif [ "$1" = "--" ]; then
      shift
      if [ "${#args[@]}" -gt 0 ]; then
        if $debugFlag; then
          [ $# -eq 0 ] && decorate each code "${FUNCNAME[0]}" grepSafe "${invert[@]+"${invert[@]}"}" "${args[@]}" 1>&2 || decorate each code "${FUNCNAME[0]}" grepSafe "${invert[@]+"${invert[@]}"}" "${args[@]}" \| __testSuiteGrepChain "$@" 1>&2 || return $?
        fi
        [ $# -eq 0 ] && grepSafe "${invert[@]+"${invert[@]}"}" "${args[@]}" || grepSafe "${invert[@]+"${invert[@]}"}" "${args[@]}" | __testSuiteGrepChain "$debugFlag" "$@" || return $?
        args=()
      fi
      invert=()
    else
      args+=("$1")
    fi
    shift
  done
  if $debugFlag; then
    [ "${#args[@]}" -eq 0 ] && decorate each code "${FUNCNAME[0]}" cat 1>&2 || decorate each code "${FUNCNAME[0]}" grepSafe "${invert[@]+"${invert[@]}"}" "${args[@]}" 1>&2 || return $?
  fi
  [ "${#args[@]}" -eq 0 ] && cat || grepSafe "${invert[@]+"${invert[@]}"}" "${args[@]}" || return $?
}
