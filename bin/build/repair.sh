#!/usr/bin/env bash
#
# repair.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# shellcheck source=/dev/null
if source "$(dirname "${BASH_SOURCE[0]}")/tools.sh"; then

  # Repair identical sections of the project using common semantics:
  #
  # - Search for `singles.txt` in directories with the name `identical` to find singles to be excluded
  # - Use any `identical` directory found as a repair source
  # - Store application fingerprint for caching
  #
  # Files which fail will be opened using `contextOpen`.
  #
  # See `identicalCheckShell` for additional arguments and handler.
  # See: identicalCheckShell
  # fn: {base}
  __buildIdenticalRepair() {
    local handler="_${FUNCNAME[0]}"
    local item aa=() home fingerprint=""

    local cleaned=()
    while [ $# -gt 0 ]; do
      local argument="$1"
      case "$1" in
      --fingerprint) fingerprint=$(validate "$handler" Fingerprint fingerprintFlag "repair") || return "$(convertValue $? 120 0)" ;;
      --check)
        [ $# -eq 0 ] || throwArgument "$handler" "Extra arguments: $# $*" || return $?
        fingerprint --check --key "repair"
        return $?
        ;;
      --token) local token && shift && token=$(validate "$handler" string "$argument" "${1-}") && cleaned+=("$argument" "$token") || return $? ;;
      --internal) cleaned+=("$1") ;;
      *) cleaned+=("$1") ;;
      esac
      shift
    done
    if [ "$(buildEnvironmentGet --quiet APPLICATION_CODE)" != "build.zesk.com" ]; then
      aa+=(--exclude "bin/build/tools" --exclude "bin/build/documentation")
    fi
    set -- "${cleaned[@]+"${cleaned[@]}"}"
    home=$(catchReturn "$handler" buildHome) || return $?
    catchReturn "$handler" muzzle pushd "$home" || return $?
    local finished=false && while ! $finished; do
      read -r item || finished=true
      [ -z "$item" ] || aa+=(--singles "$item")
    done < <(find . -name 'singles.txt' -path '*/identical/*' ! -path "*/.*/*")

    finished=false && while ! $finished; do
      read -r item || finished=true
      [ -z "$item" ] || aa+=(--repair "$item")
    done < <(find "$home" -type d -name identical ! -path "*/.*/*")

    set -eou pipefail
    catchReturn "$handler" identicalCheckShell "${aa[@]+"${aa[@]}"}" --exec contextOpen "$@" || return $?

    [ -z "$fingerprint" ] || fingerprint --cached "$fingerprint" --verbose --key "repair"
  }
  ___buildIdenticalRepair() {
    # __IDENTICAL__ bashDocumentation 1
    bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __buildIdenticalRepair "$@"
fi
