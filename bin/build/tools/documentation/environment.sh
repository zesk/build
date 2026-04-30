#!/usr/bin/env bash
#
# documentationBuildEnvironment
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

__documentationEnvironmentFileParse() {
  local handler="$1" && shift

  local envFile
  envFile=$(validate "$handler" File "environmentFile" "${1-}") || return $?

  local description descriptionLineCount category type shortDesc

  description=$(sed -n '/^[[:space:]]*#/!q; p' "$envFile" | grep -v -e '^#!\|\&copy;' | cut -c 3- | grep -v '^[[:alpha:]][[:alnum:]]*: ')
  descriptionLineCount=$(printf "%s\n" "$description" | catchReturn "$handler" fileLineCount) || return $?

  category="$(grep -m 1 -e "^[[:space:]]*#[[:space:]]*Category:" "$envFile" | cut -f 2 -d ":" | textTrim)"
  [ -n "$category" ] || category="Uncategorized"
  type="$(grep -m 1 -e "^[[:space:]]*#[[:space:]]*Type:" "$envFile" | cut -f 2 -d ":" | textTrim)"

  if [ "$descriptionLineCount" -le 2 ]; then
    shortDesc="${description//$'\n'/ }"
  else
    shortDesc="$(printf "%s\n" "$description" | head -n 1)"
  fi

  environmentValueWrite description "$description"
  environmentValueWrite descriptionLineCount "$descriptionLineCount"
  environmentValueWrite category "$category"
  environmentValueWrite categoryId "$(stringLowercase "${category// /-}")"
  environmentValueWrite type "$type"
  environmentValueWrite summary "$shortDesc"
}

__documentationBuildEnvironment() {
  local handler="$1" && shift

  local cleanFlag=false forceFlag=false verboseFlag=false
  local templatePath="" sources=() target="" source="" seeLink="/env/"

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
    --source-path) shift && sources+=("$(validate "$handler" Directory "$argument" "${1-}")") || return $? ;;
    --source) shift && source="$(validate "$handler" File "$argument" "${1-}")" || return $? ;;
    --target) shift && target="$(validate "$handler" FileDirectory "$argument" "${1-}")" || return $? ;;
    --template-path) shift && templatePath=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --link) shift && seeLink=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local ee=() && while read -r envFile; do ee+=("$envFile"); done < <(local source && for source in "${sources[@]}"; do find "$source" -maxdepth 1 -type f -name "*.sh"; done)

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  local cacheDirectory && cacheDirectory=$(__documentationFile "$home" "env/base" true) || return $?
  cacheDirectory=$(catchReturn "$handler" directoryRequire "${cacheDirectory%/*}") || return $?
  if "$cleanFlag"; then
    [ ! -d "$cacheDirectory" ] || catchEnvironment "$handler" find "$cacheDirectory" -type f \( -name '*.md' -or -name '*.sh' -or -name '*.txt' \) -delete || return $?
    [ "${#ee[@]}" -eq 0 ] || for envFile in "${ee[@]}"; do
      local name="${envFile##*/}" && name="${name%.sh}"
      local seeTarget && seeTarget=$(catchReturn "$handler" __documentationFile "$home" "SEE/$name" true) || return $?
      [ ! -f "$seeTarget" ] || catchReturn "$handler" rm -rf "$seeTarget" || return $?
    done
    catchReturn "$handler" rm -rf "$home/documentation/source/env/index.md" || return $?
    return 0
  fi

  home=$(catchReturn "$handler" buildHome) || return $?

  local argument && for argument in source target templatePath; do
    [ -n "${!argument-}" ] || throwArgument "$handler" "$argument is blank" || return $?
  done
  [ "${#sources[@]}" -gt 0 ] || throwArgument "$handler" "--source-path is required" || return $?

  local targetDirectory && targetDirectory=$(catchEnvironment "$handler" dirname "$target") || return $?

  local lineTemplate="$templatePath/env-line.md"
  local moreTemplate="$templatePath/env-more.md"
  local seeTemplate="$templatePath/env-see.md"
  local moreHeader="$templatePath/env-more-header.md"
  local moreFooter="$templatePath/env-more-footer.md"

  for argument in lineTemplate moreTemplate moreHeader moreFooter; do
    argument="${!argument}"
    [ -f "$argument" ] || throwEnvironment "$handler" "$argument template is missing" || return $?
  done
  local envFile categories=() categoriesFile="$cacheDirectory/categories.txt"
  local clean=("$categoriesUnsortedFile")

  if ! $forceFlag && [ -f "$categoriesFile" ]; then
    local newestEnvSource="" newestEnvTarget=""
    local envSource
    for envSource in "${sources[@]}"; do
      envSource=$(directoryNewestFile "$envSource" --find -type f -name '*.sh') || :
      [ -n "$envSource" ] || continue
      if [ -z "$newestEnvSource" ]; then
        newestEnvSource="$envSource"
      else
        newestEnvSource=$(fileNewest "$envSource" "$newestEnvSource")
      fi
    done
    newestEnvTarget=$(directoryNewestFile "$targetDirectory" --find -type f -name '*.md')
    if [ "$categoriesFile" -nt "$newestEnvSource" ] && [ "$newestEnvTarget" -nt "$newestEnvSource" ]; then
      ! $verboseFlag || statusMessage decorate info "No changes to environment files." || returnClean $? "${clean[@]}" || return $?
      return 0
    fi
  else
    catchEnvironment "$handler" touch "$categoriesFile" || return $?
  fi

  while IFS="" read -r item; do categories+=("$item"); done <"$categoriesFile"

  if [ -f "$target" ] && ! $forceFlag; then
    local ff=("$lineTemplate" "$moreTemplate" "$moreHeader" "$moreFooter")
    if fileIsNewest "$target" "$source" "${ff[@]}" "${ee[@]+"${ee[@]}"}"; then
      statusMessage decorate notice "Environment document $(decorate file "$target") is up to date."
      return 0
    fi
  fi
  catchReturn "$handler" cp "$source" "$target" || return $?

  statusMessage decorate info "Iterating through env files ..."

  local categoriesUnsortedFile="$cacheDirectory/categories.$$.txt"
  catchEnvironment "$handler" cp "$categoriesFile" "$categoriesUnsortedFile" || return $?

  local moreDirectory && moreDirectory=$(catchReturn "$handler" directoryRequire "$cacheDirectory/more") || return $?

  [ "${#ee[@]}" -eq 0 ] || for envFile in "${ee[@]}"; do
    local undo=(set +a)
    local name="${envFile##*/}" && name="${name%.sh}"
    local envTarget="$cacheDirectory/$name.md"
    local seeTarget && seeTarget=$(__documentationFile "$home" "SEE/$name" true) || return $?
    local moreTarget="$moreDirectory/$name.md"
    local nameMarker="${name// /_}" && nameMarker=$(stringLowercase "$nameMarker")
    local settings="$cacheDirectory/$name.sh"
    if [ ! -f "$settings" ] || ! fileIsNewest "$settings" "$envFile" "$lineTemplate" "$moreTemplate" "$seeTemplate"; then
      set -a # UNDO ok
      if ! $forceFlag && [ -f "$envTarget" ] && fileIsNewest "$envTarget" "$envFile" "$lineTemplate" "$moreTemplate"; then
        statusMessage decorate notice "Cached $(decorate file "$envFile") ..."
        catchReturn "$handler" touch "$settings" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
        continue
      else
        statusMessage decorate info "Generated $(decorate file "$envFile") ..."
      fi
      __documentationEnvironmentFileParse "$handler" "$envFile" >"$settings" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
    else
      statusMessage decorate notice "Cached $(decorate file "$settings") ..."
    fi

    local description="" type="" category="" summary="" descriptionLineCount=""
    # shellcheck source=/dev/null
    catchEnvironment "$handler" source "$settings" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?

    categoryFileName="${category// /_}"

    local more=""
    if isInteger "$descriptionLineCount" || [ "$descriptionLineCount" -le 2 ]; then
      more="[notes](#$nameMarker)"
    fi
    if [ "${#categories[@]}" -eq 0 ] || ! inArray "$category" "${categories[@]}"; then
      catchEnvironment "$handler" printf "%s\n" "$category" >>"$categoriesUnsortedFile" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
      categories+=("$category")
    fi
    local categoryId="${category// /_}" && categoryId=$(stringLowercase "$categoryId")
    local categoryFile="$cacheDirectory/category.$categoryFileName"
    inArray "$categoryFile" "${clean[@]}" || clean+=("$categoryFile")
    catchEnvironment "$handler" printf "%s\n" "$name" >>"$categoryFile" || returnUndo $? set +a || returnClean $? "${clean[@]}" || return $?

    catchReturn "$handler" muzzle fileDirectoryRequire "$seeTarget" || return $?
    categoryId="$categoryId" nameMarker="$nameMarker" link="$seeLink" name="$name" description="$summary" category="$category" more="$more" type="$type" mapEnvironment <"$seeTemplate" >"$seeTarget" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
    categoryId="$categoryId" nameMarker="$nameMarker" link="$seeLink" name="$name" description="$summary" category="$category" more="$more" type="$type" mapEnvironment <"$lineTemplate" >"$envTarget" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
    if [ -n "$more" ]; then
      categoryId="$categoryId" nameMarker="$nameMarker" link="$seeLink" name="$name" description="$summary" category="$category" type="$type" more="" mapEnvironment <"$moreTemplate" >"$moreTarget" || returnClean $? "${clean[@]}" || returnUndo $? "${undo[@]}" || return $?
    fi
  done
  set +a

  catchEnvironment "$handler" sort -u <"$categoriesUnsortedFile" >"$categoriesFile" || returnClean $? "${clean[@]}" || return $?

  catchEnvironment "$handler" rm -rf "$categoriesUnsortedFile" || returnClean $? "${clean[@]}" || return $?

  if ! fileEndsWithNewline "$target"; then
    printf "\n\n" >>"$target"
  fi
  local category && while IFS="" read -r category; do
    categoryFileName="${category// /_}"
    statusMessage decorate info "Processing $(basename "$category") ..."
    local name
    if [ -f "$cacheDirectory/category.$categoryFileName" ]; then
      printf "%s\n" "## $category" "" >>"$target"
      while IFS="" read -r name; do
        printf "%s\n" "$(cat "$cacheDirectory/$name.md")" >>"$target"
      done < <(sort -u "$cacheDirectory/category.$categoryFileName")
      printf "\n" >>"$target"
    fi
  done <"$categoriesFile"

  # More!
  local moreDocument="$cacheDirectory/more.md"
  catchReturn "$handler" rm -f >"$moreDocument" || return $?

  local heading=false
  local name && while IFS="" read -r name; do
    if ! $heading; then
      cat "$moreHeader" >>"$moreDocument"
      heading=true
    fi
    printf "\n" >>"$moreDocument"
    cat "$name" >>"$moreDocument"
  done < <(find "$moreDirectory" -type f -name '*.md' | sort -u)
  if "$heading"; then
    cat "$moreFooter" >>"$moreDocument"
  fi
  cat "$moreDocument" >>"$target"
  catchReturn "$handler" rm -f "${clean[@]}" || return $?
}
