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

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0

  local envFile && envFile=$(validate "$handler" File "environmentFile" "${1-}") && shift || return $?

  local envName="${envFile##*/}" && envName="${envName%.*}"
  # $envFile is NOT read and written in this command
  # shellcheck disable=SC2094
  bashFirstComment <"$envFile" | grep -v '&copy;' | cut -c 3- | bashDocumentationExtract --no-cache --environment "$envName" "$envFile" 1 "$@" | environmentCompile --parse --keep-comments
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
  local templateFiles=() sources=() seeLink="env/" targetPath=""

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

  local ee=() && while read -r envFile; do ee+=("$envFile"); done < <(local source && for source in "${sources[@]}"; do find "$source" -maxdepth 1 -type f -name "*.sh" | sort; done)

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
  local categoryBucket && categoryBucket=$(fileTemporaryName "$handler" -d) || return $?
  local categoriesFile="$cacheDirectory/categories.txt"
  local categoriesUnsortedFile="$categoryBucket/categories.$$.txt"
  local settingsTempFile="$categoryBucket/settings.$$.env"

  local clean=("$categoryBucket")

  #
  # env/*.sh files
  #

  local moreDirectory && moreDirectory=$(catchReturn "$handler" directoryRequire "$cacheDirectory/more") || return $?

  local categories=()

  ! $verboseFlag || statusMessage decorate info "Iterating through env files (cacheDirectory=$cacheDirectory)..." 1>&2
  local newestTemplate && newestTemplate=$(fileNewest "$lineFile" "$moreFile" "$seeFile") || return $?
  local envCache && envCache=$(catchReturn "$handler" documentationCache "env-source") || return $?
  local undo=(set +a)
  [ "${#ee[@]}" -eq 0 ] || local envFile && for envFile in "${ee[@]}"; do
    local env="${envFile##*/}" && env="${env%.sh}"
    local envTarget="$cacheDirectory/$env.md"
    local seeTarget && seeTarget=$(__documentationFile "$home" "SEE/$env" true) || return $?
    local moreTarget="$moreDirectory/$env.md"
    local envMarker="${env// /_}" && envMarker=$(stringLowercase "$envMarker")
    local settings="$cacheDirectory/$env.sh"
    local skipGenerate=false
    if $forceFlag || [ ! -f "$settings" ] || ! fileIsNewest "$settings" "$envFile" "$newestTemplate"; then
      # ! $verboseFlag || statusMessage --last printf -- "WHY: forceFlag=%s settings=%s envTarget=%s newestFile=%s\n" "$forceFlag" "$([ -f "$settings" ] && printf exists || printf not-found)" "$([ -f "$envTarget" ] && printf "%s" "$envTarget" || printf not-found)" "$(fileNewest --ignore "$envTarget" "$settings" "$envFile" "$newestTemplate")" 1>&2
      local start && start=$(catchReturn "$handler" timingStart) || return $?
      ! $verboseFlag || statusMessage decorate notice "Generating $(decorate file "$settings") ..." 1>&2
      set -a # UNDO ok
      __documentationEnvironmentFileParse "$handler" "$envFile" >"$settings" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
      ! $verboseFlag || statusMessage --last timingReport "$start" "Generated $(decorate file "$settings") ..." 1>&2
    else
      ! $verboseFlag || statusMessage decorate notice "Cached $(decorate file "$settings") ..." 1>&2
      catchReturn "$handler" touch "$settings" || return $?
      if [ -f "$envTarget" ] && [ -f "$seeTarget" ] && fileIsNewest "$envTarget" "$settings" "$seeTarget"; then
        skipGenerate=true
        catchReturn "$handler" touch "$envTarget" || return $?
      fi
    fi

    local description="" type="" category="" summary="" descriptionLineCount="" name="" see="" sourceHash="" sourceFile=""

    # shellcheck source=/dev/null
    catchEnvironment "$handler" source "$settings" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?

    [ -n "$name" ] || name="$env"

    if [ -n "$category" ]; then
      local categoryFileName="${category// /_}"
      local categoryFile="$categoryBucket/category.$categoryFileName"
      catchEnvironment "$handler" printf "%s\n" "$env" >>"$categoryFile" || returnUndo $? set +a || returnClean $? "${clean[@]}" || return $?
      if [ "${#categories[@]}" -eq 0 ] || ! inArray "$category" "${categories[@]}"; then
        catchEnvironment "$handler" printf "%s\n" "$category" >>"$categoriesUnsortedFile" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
        categories+=("$category")
      fi
    fi

    : "$see"

    if ! $forceFlag && ! $skipGenerate && [ -n "$sourceFile" ] && [ -n "$sourceHash" ]; then
      sourceFile="$home/$sourceFile"
      local currentSourceHash && currentSourceHash=$(textSHA --cache "$envCache" "$sourceFile")
      [ "$currentSourceHash" != "$sourceHash" ] || skipGenerate=true
    fi

    local more=""
    if isInteger "$descriptionLineCount" && [ "$descriptionLineCount" -ge 2 ]; then
      more="[notes](#$envMarker)"
    fi

    if [ -f "$envTarget" ] && [ -f "$seeTarget" ] && ! $forceFlag && $skipGenerate; then
      ! $verboseFlag || statusMessage decorate notice "Skipping $env ..." 1>&2
    else
      local categoryMarker && categoryMarker=$(stringLowercase "$categoryFileName")
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
      ! $verboseFlag || statusMessage decorate notice "Generating $(decorate file "$seeTarget") ..." 1>&2
      envMarker="$categoryMarker" link="$seeLink" name="$name" env="$env" description="$description" summary="$summary" category="$category" more="$more" type="$type" mapEnvironment <"$seeFile" >"$seeTarget" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
      ! $verboseFlag || statusMessage decorate notice "Generating $(decorate file "$envTarget") ..." 1>&2
      envMarker="$categoryMarker" link="$seeLink" name="$name" env="$env" description="$description" summary="$summary" category="$category" more="$more" type="$type" mapEnvironment <"$lineFile" >"$envTarget" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
      if [ -n "$more" ]; then
        ! $verboseFlag || statusMessage decorate notice "Generating $(decorate file "$moreTarget") ..." 1>&2
        (documentationTemplateCompile "$moreFile" "$settingsTempFile" >"$moreTarget") || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
      fi
    fi
  done
  set +a

  catchEnvironment "$handler" sort -u <"$categoriesUnsortedFile" >"$categoriesFile" || returnClean $? "${clean[@]}" || return $?

  local category && while IFS="" read -r category; do
    categoryFileName="${category// /_}"
    ! $verboseFlag || statusMessage decorate info "Processing $(basename "$category") ..." 1>&2
    local name
    if [ -f "$categoryBucket/category.$categoryFileName" ]; then
      printf "%s\n" "## $category" ""
      while IFS="" read -r name; do
        printf "%s\n" "$(cat "$cacheDirectory/$name.md")"
      done < <(sort -u "$categoryBucket/category.$categoryFileName")
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
  catchReturn "$handler" rm -rf "${clean[@]}" || return $?
}
