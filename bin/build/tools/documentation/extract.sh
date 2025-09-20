#!/usr/bin/env bash
#
# Documentation
#
# Copyright &copy; 2025 Market Acumen, Inc.

__bashDocumentation_Extract() {
  local handler="$1" && shift
  local definitionFile fn

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  definitionFile=$(usageArgumentFile "$handler" "definitionFile" "${1-}") && shift || return $?
  fn=$(usageArgumentString "$handler" "fn" "${1-}") && shift || return $?

  set +o pipefail

  local home tempDoc docMap base clean=()

  home=$(__catch "$handler" buildHome) || return $?
  base="$(__catchEnvironment "$handler" basename "$definitionFile")" || return $?
  tempDoc=$(fileTemporaryName "$handler") || return $?
  docMap="$tempDoc.map"

  clean+=("$tempDoc" "$docMap")
  # Hides 'unused' messages so shellcheck should succeed
  printf '%s\n' '# shellcheck disable=SC2034'

  __catch "$handler" __dumpNameValue "applicationHome" "$home" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
  __catch "$handler" __dumpNameValue "applicationFile" "${definitionFile#"${home%/}"/}" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
  __catch "$handler" __dumpNameValue "file" "$definitionFile" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
  __catch "$handler" __dumpNameValue "base" "$base" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
  # just docMap
  __catch "$handler" __dumpNameValue "fn" "$fn" >>"$docMap" || returnClean $? "${clean[@]}" || return $?

  #
  # Search for our function and then capture all of the lines BEFORE it
  # which have a `#` character and then stop capture at the next blank line
  #
  __catch "$handler" bashFunctionComment "$definitionFile" "$fn" >"$tempDoc" || returnClean $? "${clean[@]}" || return $?

  local desc=() lastName="" values=() foundNames=() lastName=""
  local dumper line
  while IFS= read -r line; do
    local name="${line%%:*}" value
    if [ "$name" = "$line" ] || [ "${line%%:}" != "$line" ] || [ "${line##:}" != "$line" ]; then
      # no colon or ends with colon *or* starts with :
      # strip starting colon (end colon STAYS)
      value="${line##:}"
      if [ "${#desc[@]}" -gt 0 ] || [ "$(trimSpace "$value")" != "" ]; then
        desc+=("$value")
      fi
    else
      value="${line#*:}"
      value="${value# }"
      name="$(lowercase "$(printf '%s' "$name" | sed 's/[^A-Za-z0-9]/_/g')")"
      if [ "$name" = "description" ]; then
        if [ "$(trimSpace "$value")" != "" ]; then
          desc+=("$value")
        fi
        continue
      fi
      if [ -n "$lastName" ] && [ "$lastName" != "$name" ]; then
        if ! inArray "$lastName" "${foundNames[@]+${foundNames[@]}}"; then
          foundNames+=("$lastName")
          dumper=__dumpNameValue
        else
          dumper=__dumpNameValueAppend
        fi
        __catch "$handler" "$dumper" "$lastName" "${values[@]}" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
        values=()
      fi
      if inArray "$name" fn; then
        value="$(mapValue "$docMap" "$value")"
      fi
      values+=("$value")
      lastName="$name"
    fi
  done <"$tempDoc"

  if [ "${#values[@]}" -gt 0 ]; then
    if ! inArray "$lastName" "${foundNames[@]+"${foundNames[@]}"}"; then
      foundNames+=("$lastName")
      dumper=__dumpNameValue
    else
      dumper=__dumpNameValueAppend
    fi
    __catch "$handler" "$dumper" "$lastName" "${values[@]}" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
  fi
  __catch "$handler" rm -f "${clean[@]}" || return $?

  if [ "${#desc[@]}" -gt 0 ]; then
    __dumpNameValue "description" "${desc[@]}"
    printf "%s %s\n" "# Found Names:" "$(printf "%s " "${foundNames[@]+"${foundNames[@]}"}")"
    if ! inArray "summary" "${foundNames[@]+"${foundNames[@]}"}"; then
      local summary
      summary="$(trimWords 10 "${desc[0]}")"
      [ -n "$summary" ] || summary="undocumented"
      __dumpNameValue "summary" "$summary"
    fi
  elif inArray "summary" "${foundNames[@]+${foundNames[@]}}"; then
    __dumpAliasedValue description summary
  else
    __dumpNameValue "description" "No documentation for \`$fn\`."
    __dumpNameValue "summary" "undocumented"
  fi
  if ! inArray "exitCode" "${foundNames[@]+"${foundNames[@]}"}"; then
    __dumpNameValue "exitCode" '0 - Success' '1 - Environment error' '2 - Argument error' "" ""
  fi
  if ! inArray "fn" "${foundNames[@]+"${foundNames[@]}"}"; then
    __dumpNameValue "fn" "$fn"
  fi
  # Trims trailing space from `fn`
  printf '%s\n' "fn=\"\${fn%\$'\n'}\""
  if ! inArray "argument" "${foundNames[@]+${foundNames[@]}}"; then
    __dumpNameValue "argument" "none"
    __dumpAliasedValue "handler" "fn"
  else
    if ! inArray "handler" "${foundNames[@]+"${foundNames[@]}"}"; then
      __dumpAliasedValue handler argument
      printf "%s\n" "export handler; handler=\"\$fn\$(__bashDocumentationDefaultArguments \"\$handler\")\""
    fi
  fi
  __dumpNameValue "foundNames" "${foundNames[*]-}"

  printf "# DocMap: %s\n" "$docMap"
  printf "%s %s\n" "# Found Names:" "$(printf "%s " "${foundNames[@]+"${foundNames[@]}"}")"
}
