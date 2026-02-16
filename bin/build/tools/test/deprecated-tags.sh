#!/usr/bin/env bash
# IDENTICAL zeskBuildBashHeader 5
#
# deprecated-tags.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#

# Filters tests by tags
# Argument: includeTag ... - String. Optional. Tag(s) to include. Prefix a tag with `+` to force it AND previous tags.
# Argument: -- - Separator. Required. Delimits tags and exclusion tags. Prefix a tag with `+` to force it AND previous exclusion tags.
# Argument: excludeTag ...- String. Optional. Tag(s) to exclude.
# Argument: -- - Separator. Required. Delimits tags and exclusion tags.
# Argument: tests ... - String. Function. Test functions
__testSuiteFilterTags() {
  local handler="$1" && shift
  local current=() tags=() skipTags=() gotTags=false debugMode=false

  while [ $# -gt 0 ]; do
    case "$1" in
    --debug)
      debugMode=true
      ;;
    "--")
      if $gotTags; then
        skipTags=("${current[@]+"${current[@]}"}")
        shift
        break
      else
        gotTags=true
        tags=("${current[@]+"${current[@]}"}")
        current=()
      fi
      ;;
    *)
      current+=("$1")
      ;;
    esac
    shift
  done
  local lastSectionFile="" sectionFile
  local tempComment home filtersFile="/dev/null"

  home=$(catchReturn "$handler" buildHome) || return $?

  ! $debugMode || filtersFile="$home/${FUNCNAME[0]}.debug"

  ! $debugMode || printf "%s" "" >"$home/${FUNCNAME[0]}.debug"

  ! $debugMode || printf "%s %s\n" "Included: " "$(decorate each --count quote -- "${tags[@]+"${tags[@]}"}")" >>"$filtersFile"
  ! $debugMode || printf "%s %s\n" "Excluded: " "$(decorate each --count quote -- "${skipTags[@]+"${skipTags[@]}"}")" >>"$filtersFile"

  tempComment=$(fileTemporaryName "$handler") || return $?
  local clean=("$tempComment")

  while [ $# -gt 0 ]; do
    local item="$1"
    if [ "$item" != "${item#\#}" ]; then
      sectionFile="${item#\#}"
    else
      local tag testTags=() defaultKeepIt=true

      [ ${#tags[@]} -eq 0 ] || defaultKeepIt=false
      catchEnvironment "$handler" bashFunctionComment "$sectionFile" "$item" >"$tempComment" || returnClean $? "${clean[@]}" || return $?
      IFS=$'\n' read -r -d "" -a testTags < <(grepSafe "Tag:" <"$tempComment" | removeFields 1 | tr ' ' '\n' | printfOutputSuffix "\n") || :
      ! $debugMode || printf "%s\n" "$(date "+%F %T"): $item" >>"$filtersFile"
      if [ "${#testTags[@]}" -gt 0 ]; then
        ! $debugMode || printf "%s\n" "bashFunctionComment \"$sectionFile\" \"$item\" > tempFile" >>"$filtersFile"
        ! $debugMode || printf "%s: %s\n" "$(date "+%F %T")" "read -r -a testTags < <(grepSafe \"Tag:\" <\"tempFile\" | removeFields 1 | tr ' ' '\n' | printfOutputSuffix \"\n\") || :" >>"$filtersFile"
      fi
      if [ "${testTags[0]-}" = "Stack:" ]; then
        statusMessage --last decorate error "Failed in function $item"
        decorate code
        decorate each --count quote -- "${testTags[@]}" | decorate blue | printfOutputPrefix "%s" "$(decorate info "Match $item:")"
      fi
      local keepIt="$defaultKeepIt" keepNote="by default"
      local specificallyExcludedAlready=false
      [ "${#skipTags[@]}" -eq 0 ] || for tag in "${skipTags[@]}"; do
        local andTag=false
        if [ "${tag#+}" != "$tag" ]; then
          tag="${tag#+}"
          andTag=true
        fi
        [ "${#testTags[@]}" -eq 0 ] || if inArray "$tag" "${testTags[@]}"; then
          keepIt=false
          specificallyExcludedAlready=true
          keepNote="** excluded by tag $tag **"
        elif $andTag; then
          keepIt="$defaultKeepIt"
          keepNote="** excluded AND $tag missing **"
        fi
      done
      if ! $specificallyExcludedAlready; then
        [ ${#tags[@]} -eq 0 ] || for tag in "${tags[@]}"; do
          local andTag=false
          if [ "${tag#+}" != "$tag" ]; then
            tag="${tag#+}"
            andTag=true
          fi
          if inArray "$tag" "${testTags[@]}"; then
            keepIt=true
            keepNote="** with tag $tag **"
          elif $andTag; then
            keepIt=false
            keepNote="** and $tag removed **"
          fi
        done
      fi
      if $keepIt; then
        ! $debugMode || printf "%s\n" "+ $item kept $keepNote Mine: ($(decorate each --count quote -- "${testTags[@]+"${testTags[@]}"}")) Keep: ($(decorate each --count quote -- "${tags[@]+"${tags[@]}"}"))" >>"$filtersFile"
      else
        ! $debugMode || printf "%s\n" "- $item excluded $keepNote Mine: ($(decorate each --count quote -- "${testTags[@]+"${testTags[@]}"}")) Skip: ($(decorate each --count quote -- "${skipTags[@]+"${skipTags[@]}"}"))" >>"$filtersFile"
      fi
      if $keepIt; then
        if [ "$lastSectionFile" != "$sectionFile" ]; then
          printf "#%s\n" "$sectionFile"
          lastSectionFile="$sectionFile"
        fi
        printf "%s\n" "$item"
      fi
    fi
    shift
  done
  catchEnvironment "$handler" rm -f "${clean[@]}" || return $?
}
