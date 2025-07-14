#!/usr/bin/env bash
#
# bash requires functions
#
# Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: ./documentation/source/tools/bash.md
# Test: ./test/tools/bash-tests.sh

# Usage: {fn} script ...
# Argument: script - File. Required. Bash script to fetch requires tokens from.
# Gets a list of the `Requires:` comments in a bash file
# Returns a unique list of tokens
bashGetRequires() {
  local usage="_${FUNCNAME[0]}"

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
    *)
      files+=("$(usageArgumentFile "$usage" "checkFile" "${1-}")") || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local requirements

  while read -r matchLine; do
    local tokens
    matchLine="${matchLine#*Requires:}"
    matchLine=${matchLine# }
    read -r -a tokens <<<"$matchLine"
    printf "%s\n" "${tokens[@]}"
  done < <(grep -e '[[:space:]]*#[[:space:]]*Requires:[[:space:]]*' "${files[@]+"${files[@]}"}" | trimSpace) | sort -u
}
_bashGetRequires() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} script
# Checks a bash script to ensure all requirements are met, outputs a list of unmet requirements
# Scans a bash script for lines which look like:
#
# Requires: token1 token2
#
# Each requirement token is:
#
# - a bash function which MUST be defined
# - a shell script (executable) which must be present
#
# If all requirements are met, exit status of 0.
# If any requirements are not met, exit status of 1 and a list of unmet requirements are listed
#
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: --ignore-prefix prefix. String. Optional. Ignore function names which match the prefix and do not check them.
# Argument: --report - Flag. Optional. Output a report of various functions and usage after processing is complete.
# Argument: --require - Flag. Optional. Requires at least one or more requirements to be listed and met to pass
# Argument: --unused - Flag. Optional. Check for unused functions and report on them.
bashCheckRequires() {
  local usage="_${FUNCNAME[0]}"

  local requireFlag=false reportFlag=false unusedFlag=false ignorePrefixes=() files=()

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
    --ignore-prefix)
      shift
      ignorePrefixes+=("$(usageArgumentString "$usage" "$argument" "${1-}")") || return $?
      ;;
    --report)
      reportFlag=true
      ;;
    --unused)
      unusedFlag=true
      ;;
    --require)
      requireFlag=true
      ;;
    *)
      files+=("$(usageArgumentFile "$usage" "checkFile" "${1-}")") || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  ! $requireFlag || [ "${#files[@]}" -gt 0 ] || __throwArgument "$usage" "No files supplied but at least one is required" || return $?
  [ "${#files[@]}" -gt 0 ] || return 0

  local requirements

  requirements=$(fileTemporaryName "$usage")

  cat "${files[@]}" | __catchEnvironment "$usage" bashGetRequires >"$requirements" || returnClean $? "$requirements" || return $?

  local functionName binaries=() total=0 defined=() missing=() required=() ignored=()
  while read -r functionName; do
    [ -n "$functionName" ] || continue
    if [ "${#ignorePrefixes[@]}" -gt 0 ] && beginsWith "$functionName" "${ignorePrefixes[@]}"; then
      ignored+=("$functionName")
    else
      total=$((total + 1))
      if ! bashFunctionDefined "$functionName" "${files[@]}"; then
        if whichExists "$functionName" || [ "$(type -t "$functionName")" = "builtin" ]; then
          binaries+=("$functionName")
        else
          missing+=("$functionName")
        fi
      else
        defined+=("$functionName")
      fi
      required+=("$functionName")
    fi
  done <"$requirements"
  __catchEnvironment "$usage" rm -rf "$requirements" || return $?

  local external=() used=() tempUnused=() unused=() handlers=()
  if "$unusedFlag"; then
    while read -r functionName; do
      [ -n "$functionName" ] || continue
      if [ "${#ignorePrefixes[@]}" -gt 0 ] && beginsWith "$functionName" "${ignorePrefixes[@]}"; then
        ignored+=("$functionName")
      elif inArray "$functionName" "${defined[@]+"${defined[@]}"}"; then
        external+=("$functionName")
      else
        if bashShowUsage --check "$functionName" "${files[@]}"; then
          used+=("$functionName")
          defined+=("$functionName")
        else
          tempUnused+=("$functionName")
        fi
      fi
    done < <(bashListFunctions "${files[@]}")

    for functionName in "${tempUnused[@]+"${tempUnused[@]}"}"; do
      [ -n "$functionName" ] || continue
      local handlerFor
      handlerFor="${functionName#_}"
      if [ "$handlerFor" != "$functionName" ]; then
        if inArray "$handlerFor" "${defined[@]+"${defined[@]}"}"; then
          handlers+=("$functionName (for $handlerFor)")
          continue
        fi
      fi
      unused+=("$functionName")
    done
  fi

  ! $requireFlag || [ "$total" -gt 0 ] || __throwEnvironment "$usage" "No requirements used"

  if $reportFlag; then
    __bashCheckReport "Functions" green "${defined[@]+"${defined[@]}"}"
    __bashCheckReport "Binaries" magenta "${binaries[@]+"${binaries[@]}"}"
    __bashCheckReport "Missing" orange "${missing[@]+"${missing[@]}"}"
    __bashCheckReport "Ignored" subtle "${ignored[@]+"${ignored[@]}"}"
    if $unusedFlag; then
      __bashCheckReport "Used" green "${used[@]+"${used[@]}"}"
      __bashCheckReport "Handlers" info "${handlers[@]+"${handlers[@]}"}"
      __bashCheckReport "External" blue "${external[@]+"${external[@]}"}"
      __bashCheckReport "Unused" yellow "${unused[@]+"${unused[@]}"}"
      for functionName in "${unused[@]+"${unused[@]}"}"; do
        printf -- "- %s %s\n" "$functionName" "$(bashShowUsage --check "$functionName" "${files[@]}" && echo 0 || echo $?)"
      done
    fi
  fi
  if [ ${#missing[@]} -gt 0 ]; then
    __throwEnvironment "$usage" "Not defined: $(decorate each code "${missing[@]}")" || return $?
  fi
  if [ ${#unused[@]} -gt 0 ]; then
    __throwEnvironment "$usage" "Unused: $(decorate each code "${unused[@]}")" || return $?
  fi
}
_bashCheckRequires() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
__bashCheckReport() {
  local label="$1" color="$2" && shift 2
  [ $# -eq 0 ] || printf "%s [%s]\n%s\n" "$(decorate "$color" "$label"):" "$(decorate value "$#")" "$(printf -- "- %s\n" "$@")"
  [ $# -ne 0 ] || printf "%s [%s]\n" "$(decorate "$color" "$label"):" "$(decorate red "NONE")"
}
