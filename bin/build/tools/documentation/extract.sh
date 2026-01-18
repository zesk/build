#!/usr/bin/env bash
#
# Documentation
#
# Copyright &copy; 2026 Market Acumen, Inc.

# Argument: handler - Required. Function.
# Argument: fn - String. Required.
__bashDocumentationSettingsHeader() {
  local handler="$1" && shift

  fn=$(validate "$handler" String "fn" "${1-}") && shift || return $?

  # Hides 'unused' messages so shellcheck should succeed
  printf '%s\n' '# shellcheck disable=SC2034'

  catchReturn "$handler" __dumpSimpleValue "fn" "$fn" || return $?
}

# Argument: handler - Required. Function.
# Argument: definitionFile - Required. File.
__bashDocumentationSettingsFileDetails() {
  local handler="$1" && shift

  local definitionFile lineNumber

  definitionFile=$(validate "$handler" RealFile "definitionFile" "${1-}") && shift || return $?
  local lineNumber="${2-}"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  local applicationFile="${definitionFile#"${home%/}"/}"
  catchReturn "$handler" __dumpSimpleValue "source" "$applicationFile" || return $?
  catchReturn "$handler" __dumpSimpleValue "applicationFile" "$applicationFile" || return $?
  catchReturn "$handler" __dumpSimpleValue "sourceModified" "$(fileModificationTime "$definitionFile")" || return $?
  catchReturn "$handler" __dumpSimpleValue "file" "$applicationFile" || return $?
  catchReturn "$handler" __dumpSimpleValue "base" "$(basename "$definitionFile")" || return $?
  [ -z "$lineNumber" ] || catchReturn "$handler" __dumpSimpleValue "sourceLine" "$lineNumber" || return $?
}

# Caching version - __bashDocumentationExtractDirect does the actual work
# Argument: handler - Function. Required.
# Argument: function - String. Required.
# Argument: sourceFile - File. Required.
__bashDocumentationExtract() {
  local __saved=("$@") __count=$#
  local handler="$1" && shift

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local fn source

  fn=$(validate "$handler" String "fn" "${1-}") && shift || return $?
  source=$(validate "$handler" File "source" "${1-}") && shift || return $?

  local capture=(cat)
  export BUILD_HOME
  local definitionFile="${BUILD_HOME:-/dev/null}/bin/build/documentation/$fn.sh"
  local extras=()
  if buildDebugEnabled "documentation-cache"; then
    extras+=("#!/usr/bin/env bash" "# Copyright &copy; $(date +%Y) $(catchReturn "$handler" buildEnvironmentGet BUILD_COMPANY)") || return $?
    extras+=("# Generated on $(todayDate)")
    local currentModified && currentModified=$(catchReturn "$handler" fileModificationTime "$source") || return $?
    if [ -f "$definitionFile" ] && [ "$source" -ot "$definitionFile" ]; then
      local sourceModified && sourceModified=$(environmentValueRead "$definitionFile" "sourceModified") || :
      if isInteger "$sourceModified" && [ "$sourceModified" -eq "$currentModified" ]; then
        catchEnvironment "$handler" touch "$definitionFile" || return $?
        return 0
      else
        decorate info "Secondary modification check failed: arg source=$source ($currentModified) cache source=$sourceModified ($((currentModified - sourceModified)) delta)" 1>&2
      fi
    fi
    catchEnvironment "$handler" muzzle fileDirectoryRequire "$definitionFile" || return $?
    catchEnvironment "$handler" touch "$definitionFile" || return $?
    catchEnvironment "$handler" chmod +x "$definitionFile" || return $?
    capture=(tee "$definitionFile")
  elif [ -x "$definitionFile" ] && [ "$definitionFile" -nt "$source" ]; then
    catchEnvironment "$handler" cat "$definitionFile" || return $?
    return 0
  fi
  bashRecursionDebug || return $?

  __bashDocumentationExtractDirect "$handler" "$fn" "$source" "${extras[@]}" "$@" | catchEnvironment "$handler" environmentCompile --keep-comments | catchEnvironment "$handler" "${capture[@]}" || return $?

  bashRecursionDebug --end || return $?
}

# Argument: handler - Function. Required.
# Argument: function - String. Required.
# Argument: sourceFile - File. Required.
# Argument: prefix ... - String. Optional. Output this prefix to the resulting file
__bashDocumentationExtractDirect() {
  local __saved=("$@") __count=$#
  local handler="$1" && shift
  local fn="$1" && shift
  local source="$1" && shift

  catchEnvironment "$handler" printf -- "%s\n" "$@" || return $?
  # subshell to hide exports
  local dumper line
  export fn base

  local mapNames=("fn") simpleNames=("fn")
  local desc=() lastName="" foundNames=() lastName="" values=()
  __bashDocumentationSettingsHeader "$handler" "$fn" || return $?
  # Read comment (stripped of #) from stdin
  while IFS= read -r line; do
    local name="${line%%:*}" value
    if ! environmentVariableNameValid "$name" || [ "$name" = "$line" ] || [ "${line%%:}" != "$line" ] || [ "${line##:}" != "$line" ]; then
      # no colon or ends with colon *or* starts with :
      # strip starting colon (end colon STAYS)
      value="${line##:}"
      if [ "${#desc[@]}" -gt 0 ] || [ "$(trimSpace "$value")" != "" ]; then
        desc+=("$value")
      fi
    else
      value="${line#*:}"
      value="${value# }"
      case "$name" in
      ":sourceFile") name="${name:1}" && source="$value" ;;
      ":sourceLine") name="${name:1}" ;;
      esac
      name="$(lowercase "$(printf '%s' "$name" | sed 's/[^A-Za-z0-9]/_/g')")" || return $?
      case "$name" in
      description)
        value="$(catchReturn "$handler" trimSpace "$value")" || return $?
        [ -z "$value" ] || desc+=("$value")
        continue
        ;;
      esac
      if [ -n "$lastName" ] && [ "$lastName" != "$name" ]; then
        if ! inArray "$lastName" "${foundNames[@]+${foundNames[@]}}"; then
          foundNames+=("$lastName")
          if inArray "$lastName" "${simpleNames[@]}"; then
            dumper=__dumpSimpleValue
          else
            dumper=__dumpNameValue
          fi
        else
          dumper=__dumpNameValueAppend
        fi
        catchReturn "$handler" "$dumper" "$lastName" "${values[@]}" || return $?
        values=()
      fi
      : "$fn"
      if [ "${value#*{}" != "$value" ]; then
        value="$(catchReturn "$handler" mapEnvironment "${mapNames[@]}" <<<"$value")" || return $?
      fi
      values+=("$value")
      lastName="$name"
    fi
  done
  if [ -f "$source" ]; then
    __bashDocumentationSettingsFileDetails "$handler" "$source" || return $?
  fi
  if [ "${#values[@]}" -gt 0 ]; then
    if ! inArray "$lastName" "${foundNames[@]+"${foundNames[@]}"}"; then
      foundNames+=("$lastName")
      if inArray "$lastName" "${simpleNames[@]}"; then
        dumper=__dumpSimpleValue
      else
        dumper=__dumpNameValue
      fi
    else
      dumper=__dumpNameValueAppend
    fi
    catchReturn "$handler" "$dumper" "$lastName" "${values[@]}" || return $?
  fi

  if [ "${#desc[@]}" -gt 0 ]; then
    catchReturn "$handler" __dumpNameValue "description" "${desc[@]}" || return $?
    if ! inArray "summary" "${foundNames[@]+"${foundNames[@]}"}"; then
      local summary
      summary="$(trimWords 10 "${desc[0]}")"
      [ -n "$summary" ] || summary="undocumented"
      catchReturn "$handler" __dumpSimpleValue "summary" "$summary" || return $?
    fi
  elif inArray "summary" "${foundNames[@]+${foundNames[@]}}"; then
    catchReturn "$handler" __dumpAliasedValue description summary || return $?
  else
    catchReturn "$handler" __dumpNameValue "description" "No documentation for \`$fn\`." || return $?
    catchReturn "$handler" __dumpSimpleValue "summary" "undocumented" || return $?
  fi
  if ! inArray "return_code" "${foundNames[@]+"${foundNames[@]}"}"; then
    catchReturn "$handler" __dumpNameValue "return_code" '0 - Success' '1 - Environment error' '2 - Argument error' || return $?
  fi
  if ! inArray "fn" "${foundNames[@]+"${foundNames[@]}"}"; then
    catchReturn "$handler" __dumpSimpleValue "fn" "$fn" || return $?
  fi
  if ! inArray "argument" "${foundNames[@]+${foundNames[@]}}"; then
    catchReturn "$handler" __dumpSimpleValue "argument" "none" || return $?
    if ! inArray "usage" "${foundNames[@]+"${foundNames[@]}"}"; then
      catchReturn "$handler" __dumpAliasedValue "usage" "fn" || return $?
    fi
  else
    if ! inArray "usage" "${foundNames[@]+"${foundNames[@]}"}"; then
      catchReturn "$handler" printf "%s\n" "export usage; usage=\"\$fn\$(__bashDocumentationDefaultArguments \"\$argument\")\"" || return $?
    fi
  fi

  catchReturn "$handler" __dumpArrayValue "foundNames" "${foundNames[@]+"${foundNames[@]}"}" || return $?
}
