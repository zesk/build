#!/usr/bin/env bash
#
# identical-repair.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
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
  __buildIdenticalRepair() {
    local handler="_${FUNCNAME[0]}"
    local item aa home checkFlag=false doFingerprint=true

    local cleaned=()
    while [ $# -gt 0 ]; do
      local argument="$1"
      case "$1" in
      --check)
        checkFlag=true
        ;;
      --token)
        local token
        shift && token=$(usageArgumentString "$handler" "$argument" "${1-}") || return $?
        cleaned+=("$argument" "$token")
        doFingerprint=false
        ;;
      *)
        cleaned+=("$1")
        ;;
      esac
      shift
    done
    if $checkFlag && ! $doFingerprint; then
      throwArgument "$handler" "Invalid --check with --token" || return $?
    fi
    set -- "${cleaned[@]+"${cleaned[@]}"}"
    home=$(returnCatch "$handler" buildHome) || return $?
    catchEnvironment "$handler" muzzle cd "$home" || return $?
    local done=false aa=()
    while ! $done; do
      read -r item || done=true
      [ -z "$item" ] || aa+=(--singles "$item")
    done < <(find . -name 'singles.txt' -path '*/identical/*' ! -path "*/.*/*")
    done=false
    while ! $done; do
      read -r item || done=true
      [ -z "$item" ] || aa+=(--repair "$item")
    done < <(find "$home" -type d -name identical ! -path "*/.*/*")
    # bashDebugInterruptFile --error --interrupt
    local fingerprint="" jsonFile="" jqPath=""
    jsonFile="$home/$(returnCatch "$handler" buildEnvironmentGet APPLICATION_JSON)" || return $?
    [ -f "$jsonFile" ] || doFingerprint=false

    if $doFingerprint; then
      local prefix
      prefix=$(returnCatch "$handler" buildEnvironmentGet APPLICATION_JSON_PREFIX) || return $?
      prefix="${prefix#.}"
      prefix="${prefix%.}"

      local buildFingerprint argChecksum="default"
      [ $# -eq 0 ] || argChecksum="$*"
      local jqPath
      jqPath=$(returnCatch "$handler" jsonPath "$prefix" "identical" "\"$argChecksum\"") || return $?
      fingerprint=$(returnCatch "$handler" hookRun application-fingerprint) || return $?
      buildFingerprint="$(returnCatch "$handler" jsonFileGet "$jsonFile" "$jqPath")" || return $?
      if [ "$fingerprint" = "$buildFingerprint" ]; then
        if $checkFlag; then
          printf "%s\n" "$fingerprint"
        else
          decorate success "Fingerprint matches [$(decorate success "$fingerprint")] ... skipping."
        fi
        return 0
      else
        if $checkFlag; then
          printf "%s\n" "$fingerprint"
          return 1
        fi
        decorate info "Fingerprint mismatch [ $(decorate green "$fingerprint") != $(decorate subtle "$buildFingerprint") ]"
      fi
    elif $checkFlag; then
      returnCatch "$handler" hookRun application-fingerprint || return $?
      return 0
    fi
    set -eou pipefail
    returnCatch "$handler" identicalCheckShell "${aa[@]+"${aa[@]}"}" --exec contextOpen "$@" || return $?
    if $doFingerprint; then
      returnCatch "$handler" jsonFileSet "$jsonFile" "$jqPath" "$fingerprint" || return $?
      decorate success "Fingerprint updated."
    fi

  }
  ___buildIdenticalRepair() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __buildIdenticalRepair "$@"
fi
