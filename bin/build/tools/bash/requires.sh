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
__bashGetRequires() {
  local handler="$1" && shift

  local files=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      files+=("$(usageArgumentFile "$handler" "checkFile" "${1-}")") || return $?
      ;;
    esac
    shift
  done

  while read -r matchLine; do
    local tokens
    matchLine="${matchLine#*Requires:}"
    matchLine=${matchLine# }
    read -r -a tokens <<<"$matchLine"
    printf "%s\n" "${tokens[@]}"
  done < <(grep -e '[[:space:]]*#[[:space:]]*Requires:[[:space:]]*' "${files[@]+"${files[@]}"}" | trimSpace) | sort -u
}

__bashCheckRequires() {
  local handler="$1" && shift

  local requireFlag=false reportFlag=false unusedFlag=false ignorePrefixes=() files=() ignore=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --ignore)
      shift
      ignore+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
      ;;
    --ignore-prefix)
      shift
      ignorePrefixes+=("$(usageArgumentString "$handler" "$argument" "${1-}")") || return $?
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
      files+=("$(usageArgumentFile "$handler" "checkFile" "${1-}")") || return $?
      ;;
    esac
    shift
  done

  ! $requireFlag || [ "${#files[@]}" -gt 0 ] || throwArgument "$handler" "No files supplied but at least one is required" || return $?
  [ "${#files[@]}" -gt 0 ] || return 0

  local requirements

  requirements=$(fileTemporaryName "$handler")

  cat "${files[@]}" | catchEnvironment "$handler" bashGetRequires >"$requirements" || returnClean $? "$requirements" || return $?

  local functionName binaries=() total=0 defined=() missing=() required=() ignored=()
  while read -r functionName; do
    [ -n "$functionName" ] || continue
    if [ "${#ignorePrefixes[@]}" -gt 0 ] && beginsWith "$functionName" "${ignorePrefixes[@]}"; then
      ignored+=("$functionName")
    elif [ "${#ignore[@]}" -gt 0 ] && inArray "$functionName" "${ignore[@]}"; then
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
  catchEnvironment "$handler" rm -rf "$requirements" || return $?

  local external=() used=() tempUnused=() unused=() handlers=()
  if "$unusedFlag"; then
    while read -r functionName; do
      [ -n "$functionName" ] || continue
      if [ "${#ignorePrefixes[@]}" -gt 0 ] && beginsWith "$functionName" "${ignorePrefixes[@]}"; then
        ignored+=("$functionName")
      elif [ "${#ignore[@]}" -gt 0 ] && inArray "$functionName" "${ignore[@]}"; then
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

  ! $requireFlag || [ "$total" -gt 0 ] || throwEnvironment "$handler" "No requirements used" || return $?

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
        printf -- "- %s %s\n" "$functionName" "$(bashShowUsage --check "$functionName" "${files[@]}" && printf -- "%d" 0 || printf -- "%d" $?)"
      done
    fi
  fi
  if [ ${#missing[@]} -gt 0 ]; then
    throwEnvironment "$handler" "Not defined: $(decorate each code "${missing[@]}")" || return $?
  fi
  if [ ${#unused[@]} -gt 0 ]; then
    throwEnvironment "$handler" "Unused: $(decorate each code "${unused[@]}")" || return $?
  fi
}

__bashCheckReport() {
  local label="$1" color="$2" && shift 2
  [ $# -eq 0 ] || printf "%s [%s]\n%s\n" "$(decorate "$color" "$label"):" "$(decorate value "$#")" "$(printf -- "- %s\n" "$@")"
  [ $# -ne 0 ] || printf "%s [%s]\n" "$(decorate "$color" "$label"):" "$(decorate red "NONE")"
}
