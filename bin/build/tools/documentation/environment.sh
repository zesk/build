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
  local templatePath="" sources=() documentation="" target="" source=""

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
    --documentation) shift && documentation=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --template-path) shift && templatePath=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  cacheDirectory=$(catchReturn "$handler" documentationBuildCache envDocs) || return $?

  if "$cleanFlag"; then
    [ ! -d "$cacheDirectory" ] || catchEnvironment "$handler" find "$cacheDirectory" -type f -exec rm -f {} \; || return $?
    return 0
  fi

  home=$(catchReturn "$handler" buildHome) || return $?

  [ -n "$documentation" ] || documentation="$home/documentation/source"
  [ -d "$documentation" ] || throwArgument "$handler" "Not a directory: $documentation" || return $?

  local argument
  for argument in source target templatePath; do
    [ -n "${!argument-}" ] || throwArgument "$handler" "$argument is blank" || return $?
  done
  [ "${#sources[@]}" -gt 0 ] || throwArgument "$handler" "--source-path is required" || return $?

  local targetDirectory
  targetDirectory=$(catchEnvironment "$handler" dirname "$target") || return $?

  local lineTemplate="$templatePath/env-line.md"
  local moreTemplate="$templatePath/env-more.md"
  local moreHeader="$templatePath/env-more-header.md"
  local moreFooter="$templatePath/env-more-footer.md"

  for argument in lineTemplate moreTemplate moreHeader moreFooter; do
    argument="${!argument}"
    [ -f "$argument" ] || throwEnvironment "$handler" "$argument template is missing" || return $?
  done
  local envFile categories=()

  if ! $forceFlag && [ -f "$cacheDirectory/categories" ]; then
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
    if [ "$cacheDirectory/categories" -nt "$newestEnvSource" ] && [ "$newestEnvTarget" -nt "$newestEnvSource" ]; then
      ! $verboseFlag || statusMessage decorate info "No changes to environment files." || return $?
      return 0
    fi
  else
    catchEnvironment "$handler" touch "$cacheDirectory/categories" || return $?
  fi

  while IFS="" read -r item; do categories+=("$item"); done <"$cacheDirectory/categories"

  local ee=() && while read -r envFile; do ee+=("$envFile"); done < <(local source && for source in "${sources[@]}"; do find "$source" -maxdepth 1 -type f -name "*.sh"; done)

  if [ -f "$target" ] && ! $forceFlag; then
    local ff=("$lineTemplate" "$moreTemplate" "$moreHeader" "$moreFooter")
    if fileIsNewest "$target" "$source" "${ff[@]}" "${ee[@]+"${ee[@]}"}"; then
      statusMessage decorate notice "Environment document $(decorate file "$target") is up to date."
      return 0
    fi
  fi
  catchReturn "$handler" cp "$source" "$target" || return $?

  statusMessage decorate info "Iterating through env files ..."
  catchEnvironment "$handler" cp "$cacheDirectory/categories" "$cacheDirectory/categories.unsorted" || return $?
  local settings
  settings="$cacheDirectory/.settings.$$"

  [ "${#ee[@]}" -eq 0 ] || for envFile in "${ee[@]}"; do
    local envTarget name="${envFile##*/}"

    set -a # UNDO ok
    name="${name%.sh}"
    envTarget="$cacheDirectory/$name"
    moreTarget="$cacheDirectory/more.$name"
    if ! $forceFlag && [ -f "$envTarget" ] && fileIsNewest "$envTarget" "$envFile" "$lineTemplate" "$moreTemplate"; then
      statusMessage decorate notice "Cached $(basename "$envFile") ..."
      continue
    else
      statusMessage decorate info "Generated $(basename "$envFile") ..."
    fi

    __documentationEnvironmentFileParse "$handler" "$envFile" >"$settings" || return $?

    local description="" type="" category="" summary="" descriptionLineCount=""
    # shellcheck source=/dev/null
    catchEnvironment "$handler" source "$settings" || return $?

    categoryFileName="${category// /_}"

    if ! isInteger "$descriptionLineCount" || [ "$descriptionLineCount" -le 2 ]; then
      more=""
    else
      more="[notes](#$name)"
    fi

    if [ "${#categories[@]}" -eq 0 ] || ! inArray "$category" "${categories[@]}"; then
      catchEnvironment "$handler" printf "%s\n" "$category" >>"$cacheDirectory/categories.unsorted" || returnUndo $? set +a || return $?
      categories+=("$category")
    fi
    catchEnvironment "$handler" printf "%s\n" "$name" >>"$cacheDirectory/category.$categoryFileName" || returnUndo $? set +a || return $?

    description=$summary category="$category" more="$more" type="$type" mapEnvironment <"$lineTemplate" >"$envTarget" || returnUndo $? set +a || return $?
    if [ -n "$more" ]; then
      category="$category" type="$type" mapEnvironment <"$moreTemplate" >"$moreTarget" || returnUndo $? set +a || return $?
    fi
    printf "%s\n" "$name" >>"$cacheDirectory/mores"
  done
  set +a

  catchEnvironment "$handler" sort -u <"$cacheDirectory/categories.unsorted" >"$cacheDirectory/categories" || return $?
  catchEnvironment "$handler" rm -rf "$cacheDirectory/categories.unsorted" || return $?

  if ! fileEndsWithNewline "$target"; then
    printf "\n\n" >>"$target"
  fi
  local category
  while IFS="" read -r category; do
    categoryFileName="${category// /_}"
    statusMessage decorate info "Processing $(basename "$category") ..."
    local name
    if [ -f "$cacheDirectory/category.$categoryFileName" ]; then
      printf "%s\n" "## $category" "" >>"$target"
      while IFS="" read -r name; do
        printf "%s\n" "$(cat "$cacheDirectory/$name")" >>"$target"
      done < <(sort -u "$cacheDirectory/category.$categoryFileName")
      printf "\n" >>"$target"
    fi
  done <"$cacheDirectory/categories"

  local heading=false name
  while IFS="" read -r name; do
    if [ -f "$cacheDirectory/more.$name" ]; then
      if ! $heading; then
        cat "$moreHeader" >>"$target"
        heading=true
      fi
      printf "\n" >>"$target"
      cat "$cacheDirectory/more.$name" >>"$target"
    fi
  done < <(sort -u "$cacheDirectory/mores")
  if "$heading"; then
    cat "$moreFooter" >>"$target"
  fi
}
