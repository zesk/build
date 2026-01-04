#!/usr/bin/env bash
#
# Documentation
#
# Copyright &copy; 2026 Market Acumen, Inc.

# Argument: handler - Required. Function.
# Argument: fn - Required. String.
__bashDocumentationSettingsHeader() {
  local handler="$1" && shift

  fn=$(usageArgumentString "$handler" "fn" "${1-}") && shift || return $?

  # Hides 'unused' messages so shellcheck should succeed
  printf '%s\n' '# shellcheck disable=SC2034'

  catchReturn "$handler" __dumpSimpleValue "fn" "$fn" || return $?
}

# Argument: handler - Required. Function.
# Argument: definitionFile - Required. File.
__bashDocumentationSettingsFileDetails() {
  local handler="$1" && shift

  local sourceFile="$1" && shift
  local lineNumber="${2-}"

  local home
  home=$(catchReturn "$handler" buildHome) || return $?

  catchReturn "$handler" __dumpSimpleValue "applicationHome" "$home" || return $?
  definitionFile=$(usageArgumentFile "$handler" "definitionFile" "$sourceFile") && shift || return $?
  catchReturn "$handler" __dumpSimpleValue "applicationFile" "${definitionFile#"${home%/}"/}" || return $?
  catchReturn "$handler" __dumpSimpleValue "file" "$definitionFile" || return $?
  catchReturn "$handler" __dumpSimpleValue "base" "$(basename "$definitionFile")" || return $?
  [ -z "$lineNumber" ] || catchReturn "$handler" __dumpSimpleValue "sourceLine" "$lineNumber" || return $?
}

__bashDocumentationExtract() {
  local handler="$1" && shift
  local definitionFile fn

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  (
    # subshell to hide exports
    local dumper line
    export fn base

    fn=$(usageArgumentString "$handler" "fn" "${1-}") && shift || return $?
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
        ":sourceFile") name="${name:1}" && __bashDocumentationSettingsFileDetails "$handler" "$value" ;;
        ":sourceLine") name="${name:1}" ;;
        esac
        name="$(lowercase "$(printf '%s' "$name" | sed 's/[^A-Za-z0-9]/_/g')")"
        case "$name" in
        description)
          value="$(trimSpace "$value")"
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
          value="$(mapEnvironment "${mapNames[@]}" <<<"$value")"
        fi
        values+=("$value")
        lastName="$name"
      fi
    done
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
      __dumpNameValue "description" "${desc[@]}"
      if ! inArray "summary" "${foundNames[@]+"${foundNames[@]}"}"; then
        local summary
        summary="$(trimWords 10 "${desc[0]}")"
        [ -n "$summary" ] || summary="undocumented"
        __dumpSimpleValue "summary" "$summary"
      fi
    elif inArray "summary" "${foundNames[@]+${foundNames[@]}}"; then
      __dumpAliasedValue description summary
    else
      __dumpNameValue "description" "No documentation for \`$fn\`."
      __dumpSimpleValue "summary" "undocumented"
    fi
    if ! inArray "return_code" "${foundNames[@]+"${foundNames[@]}"}"; then
      __dumpNameValue "return_code" '0 - Success' '1 - Environment error' '2 - Argument error' "" ""
    fi
    if ! inArray "fn" "${foundNames[@]+"${foundNames[@]}"}"; then
      __dumpSimpleValue "fn" "$fn"
    fi
    if ! inArray "argument" "${foundNames[@]+${foundNames[@]}}"; then
      __dumpSimpleValue "argument" "none"
      if ! inArray "usage" "${foundNames[@]+"${foundNames[@]}"}"; then
        __dumpAliasedValue "usage" "fn"
      fi
    else
      if ! inArray "usage" "${foundNames[@]+"${foundNames[@]}"}"; then
        printf "%s\n" "export usage; usage=\"\$fn\$(__bashDocumentationDefaultArguments \"\$argument\")\""
      fi
    fi
    __dumpArrayValue "foundNames" "${foundNames[@]+"${foundNames[@]}"}"
  )
}
