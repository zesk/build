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
    local item aa home checkFlag=false

    local cleaned=()
    while [ $# -gt 0 ]; do
      if [ "$1" = "--check" ]; then
        checkFlag=true
      else
        cleaned+=("$1")
      fi
      shift
    done
    set -- "${cleaned[@]+"${cleaned[@]}"}"
    home=$(__catch "$handler" buildHome) || return $?
    __catchEnvironment "$handler" muzzle cd "$home" || return $?
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
    local fingerprint="" jsonFile=""
    jsonFile="$home/$(__catch "$handler" buildEnvironmentGet APPLICATION_JSON)" || return $?
    if [ -f "$jsonFile" ]; then
      local buildFingerprint argChecksum="default"
      [ $# -eq 0 ] || argChecksum="$*"
      fingerprint=$(__catch "$handler" hookRun application-fingerprint) || return $?
      buildFingerprint="$(jq -r "{ identical: {} } + . | .identical.\"$argChecksum\"" <"$home/bin/build/build.json")"
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
      __catch "$handler" hookRun application-fingerprint || return $?
      return 0
    fi
    set -eou pipefail
    __catch "$handler" identicalCheckShell "${aa[@]+"${aa[@]}"}" --exec contextOpen "$@" || return $?
    __catchEnvironment "$handler" jq "{ identical: {} } + . | .identical.\"$argChecksum\" = \"$fingerprint\"" <"$jsonFile" >"$jsonFile.new" || returnClean $? "$jsonFile.new" || return $?
    __catchEnvironment "$handler" mv -f "$jsonFile.new" "$jsonFile" || returnClean $? "$jsonFile.new" || return $?
    decorate success "Fingerprint updated."

  }
  ___buildIdenticalRepair() {
    # __IDENTICAL__ usageDocument 1
    usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
  }

  __buildIdenticalRepair "$@"
fi
