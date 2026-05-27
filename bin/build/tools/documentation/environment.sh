#!/usr/bin/env bash
#
# documentationEnvironmentMake
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

__documentationEnvironmentFileParse() {
  local handler="$1" && shift

  local envFile && envFile=$(validate "$handler" File "environmentFile" "${1-}") && shift || return $?

  local envName="${envFile##*/}" && envName="${envName%.*}"
  # $envFile is NOT read and written in this command
  # shellcheck disable=SC2094
  bashFirstComment <"$envFile" | sed 1d | grep -v '&copy;' | cut -c 3- | bashDocumentationExtract --no-cache --environment "$envName" "$envFile" 1 "$@" | environmentCompile --parse --keep-comments
}

__documentationTemplateFile() {
  local code="$1" && shift
  while [ $# -gt 0 ]; do
    local item="$1/$code.md"
    if [ -f "$item" ]; then printf -- "%s\n" "$item" && return 0; fi
    shift
  done
  return 1
}

__documentationEnvironmentMake() {
  local handler="$1" && shift

  local cleanFlag=false forceFlag=false
  local verboseFlag=false
  local templateFiles=() sources=() seeLink="/env/" targetPath=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --clean) cleanFlag=true ;;
    --force) forceFlag=true ;;
    --verbose) verboseFlag=true ;;
    --source) shift && sources+=("$(validate "$handler" Directory "$argument" "${1-}")") || return $? ;;
    --template) shift && templateFiles+=("$(validate "$handler" Directory "$argument" "${1-}")") || return $? ;;
    --target) shift && targetPath=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --link) shift && seeLink=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done
  local start && start=$(timingStart)

  local ee=() && while read -r envFile; do ee+=("$envFile"); done < <(local source && for source in "${sources[@]}"; do find "$source" -maxdepth 1 -type f -name "*.sh"; done)

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  local cacheDirectory && cacheDirectory=$(__documentationFile "$home" "env/base" true) || return $?

  cacheDirectory=$(catchReturn "$handler" directoryRequire "${cacheDirectory%/*}") || return $?
  ! $verboseFlag || statusMessage --last decorate pair "cacheDirectory" "$cacheDirectory" 1>&2
  if "$cleanFlag"; then
    [ ! -d "$cacheDirectory" ] || catchEnvironment "$handler" find "$cacheDirectory" -type f \( -name '*.md' -or -name '*.sh' -or -name '*.txt' \) -delete || return $?
    [ "${#ee[@]}" -eq 0 ] || for envFile in "${ee[@]}"; do
      local name="${envFile##*/}" && name="${name%.sh}"
      local seeTarget && seeTarget=$(catchReturn "$handler" __documentationFile "$home" "SEE/$name" true) || return $?
      [ ! -f "$seeTarget" ] || catchReturn "$handler" rm -rf "$seeTarget" || return $?
    done
    ! $verboseFlag || statusMessage --last decorate pair "Cleaned" "$(timingReport "$start")" 1>&2
    return 0
  fi

  [ "${#templateFiles[@]}" -gt 0 ] || throwArgument "$handler" "--template is required" || return $?
  [ "${#sources[@]}" -gt 0 ] || throwArgument "$handler" "--source is required" || return $?

  local lineFile && lineFile=$(catchReturn "$handler" __documentationTemplateFile "line" "${templateFiles[@]}") || return $?
  local moreFile && moreFile=$(catchReturn "$handler" __documentationTemplateFile "more" "${templateFiles[@]}") || return $?
  local seeFile && seeFile=$(catchReturn "$handler" __documentationTemplateFile "see" "${templateFiles[@]}") || return $?

  #
  # categories.txt
  #

  local categoriesFile="$cacheDirectory/categories.txt"
  local categoriesUnsortedFile="$cacheDirectory/categories.$$.txt"
  local settingsTempFile="$cacheDirectory/settings.$$.env"

  local clean=("$categoriesUnsortedFile" "$settingsTempFile")

  #
  # env/*.sh files
  #

  local moreDirectory && moreDirectory=$(catchReturn "$handler" directoryRequire "$cacheDirectory/more") || return $?

  local categories=()
  catchReturn "$handler" rm -f "$cacheDirectory/category."* || return $?

  ! $verboseFlag || statusMessage decorate info "Iterating through env files ..." 1>&2
  [ "${#ee[@]}" -eq 0 ] || local envFile && for envFile in "${ee[@]}"; do
    local undo=(set +a)
    local env="${envFile##*/}" && env="${env%.sh}"
    local envTarget="$cacheDirectory/$env.md"
    local seeTarget && seeTarget=$(__documentationFile "$home" "SEE/$env" true) || return $?
    local moreTarget="$moreDirectory/$env.md"
    local envMarker="${env// /_}" && envMarker=$(stringLowercase "$envMarker")
    local settings="$cacheDirectory/$env.sh"
    if $forceFlag || [ ! -f "$settings" ] || ! fileIsNewest "$settings" "$envFile" "$lineFile" "$moreFile" "$seeFile"; then
      set -a # UNDO ok
      if ! $forceFlag && [ -f "$envTarget" ] && fileIsNewest "$envTarget" "$envFile" "$lineFile" "$moreFile"; then
        ! $verboseFlag || statusMessage decorate notice "Cached $(decorate file "$envFile") ..." 1>&2
        catchReturn "$handler" touch "$settings" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
        continue
      else
        ! $verboseFlag || statusMessage decorate info "Generated $(decorate file "$settings") from $(decorate file "$envFile") ..." 1>&2
      fi
      __documentationEnvironmentFileParse "$handler" "$envFile" >"$settings" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
    else
      ! $verboseFlag || statusMessage decorate notice "Cached $(decorate file "$settings") ..." 1>&2
    fi

    local description="" type="" category="" summary="" descriptionLineCount="" name="" see=""

    # shellcheck source=/dev/null
    catchEnvironment "$handler" source "$settings" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?

    : "$see"

    [ -n "$name" ] || name="$env"
    local more=""
    if isInteger "$descriptionLineCount" && [ "$descriptionLineCount" -ge 2 ]; then
      more="[notes](#$envMarker)"
    fi
    if [ "${#categories[@]}" -eq 0 ] || ! inArray "$category" "${categories[@]}"; then
      catchEnvironment "$handler" printf "%s\n" "$category" >>"$categoriesUnsortedFile" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
      categories+=("$category")
    fi
    local categoryFileName="${category// /_}"
    local categoryMarker && categoryMarker=$(stringLowercase "$categoryFileName")
    local categoryFile="$cacheDirectory/category.$categoryFileName"
    inArray "$categoryFile" "${clean[@]}" || clean+=("$categoryFile")
    catchEnvironment "$handler" printf "%s\n" "$env" >>"$categoryFile" || returnUndo $? set +a || returnClean $? "${clean[@]}" || return $?

    catchReturn "$handler" muzzle fileDirectoryRequire "$seeTarget" || return $?
    local tokens=(
      "$(environmentValueWrite name "$name")"
      "$(environmentValueWrite env "$env")"
      envMarker="$envMarker"
      categoryMarker="$categoryMarker"
      link="$seeLink"
      "$(environmentValueWrite description "$description")"
      "$(environmentValueWrite more "$more")"
      "$(environmentValueWrite summary "$summary")"
      "$(environmentValueWrite category "$category")"
      type="$type"
    )
    printf -- "%s\n" "${tokens[@]}" >"$settingsTempFile"
    envMarker="$categoryMarker" link="$seeLink" name="$name" env="$env" description="$description" summary="$summary" category="$category" more="$more" type="$type" mapEnvironment <"$seeFile" >"$seeTarget" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
    envMarker="$categoryMarker" link="$seeLink" name="$name" env="$env" description="$description" summary="$summary" category="$category" more="$more" type="$type" mapEnvironment <"$lineFile" >"$envTarget" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
    if [ -n "$more" ]; then
      (documentationTemplateCompile "$moreFile" "$settingsTempFile" >"$moreTarget") || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
    fi
  done
  set +a

  catchEnvironment "$handler" sort -u <"$categoriesUnsortedFile" >"$categoriesFile" || returnClean $? "${clean[@]}" || return $?
  catchEnvironment "$handler" rm -rf "$categoriesUnsortedFile" || returnClean $? "${clean[@]}" || return $?

  local category && while IFS="" read -r category; do
    categoryFileName="${category// /_}"
    ! $verboseFlag || statusMessage decorate info "Processing $(basename "$category") ..." 1>&2
    local name
    if [ -f "$cacheDirectory/category.$categoryFileName" ]; then
      printf "%s\n" "## $category" ""
      while IFS="" read -r name; do
        printf "%s\n" "$(cat "$cacheDirectory/$name.md")"
      done < <(sort -u "$cacheDirectory/category.$categoryFileName")
      printf "\n"
    fi
  done <"$categoriesFile" >"$targetPath/environmentCategoryList.md" || return $?
  ! $verboseFlag || decorate info "Wrote $(decorate file "$targetPath/environmentCategoryList.md")" 1>&2
  fileLineCount <"$categoriesFile" >"$targetPath/environmentCategoryTotal.md" || return $?
  ! $verboseFlag || decorate info "Wrote $(decorate file "$targetPath/environmentCategoryTotal.md")" 1>&2
  # More!
  local moreDocument="$targetPath/environmentMore.md"
  catchReturn "$handler" printf -- "" >"$moreDocument" || return $?
  local name && while IFS="" read -r name; do
    printf "\n" >>"$moreDocument"
    cat "$name" >>"$moreDocument"
  done < <(find "$moreDirectory" -type f -name '*.md' | sort)
  ! $verboseFlag || decorate info "Wrote $(decorate file "$targetPath/environmentMore.md")" 1>&2
  catchReturn "$handler" rm -f "${clean[@]}" || return $?
}
