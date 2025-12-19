#!/usr/bin/env bash
#
# documentationBuildEnvironment
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

__documentationEnvironmentFileParse() {
  local handler="$1" && shift

  local envFile
  envFile=$(usageArgumentFile "$handler" "environmentFile" "${1-}") || return $?

  local description descriptionLineCount category type shortDesc

  description=$(sed -n '/^[[:space:]]*#/!q; p' "$envFile" | grep -v -e '^#!\|\&copy;' | cut -c 3- | grep -v '^[[:alpha:]][[:alnum:]]*: ')
  descriptionLineCount=$(printf "%s\n" "$description" | catchReturn "$handler" fileLineCount) || return $?

  category="$(grep -m 1 -e "^[[:space:]]*#[[:space:]]*Category:" "$envFile" | cut -f 2 -d ":" | trimSpace)"
  [ -n "$category" ] || categoryName="Uncategorized"
  type="$(grep -m 1 -e "^[[:space:]]*#[[:space:]]*Type:" "$envFile" | cut -f 2 -d ":" | trimSpace)"

  if [ "$descriptionLineCount" -le 2 ]; then
    shortDesc="${description//$'\n'/ }"
  else
    shortDesc="$(printf "%s\n" "$description" | head -n 1)"
  fi

  environmentValueWrite description "$description"
  environmentValueWrite descriptionLineCount "$descriptionLineCount"
  environmentValueWrite category "$category"
  environmentValueWrite type "$type"
  environmentValueWrite summary "$shortDesc"
}

# Build documentation for ./bin/env (or bin/build/env) directory.
#
# Creates a cache at `documentationBuildCache`
#
# See: documentationBuild
#
# Return Code: 0 - Success
# Return Code: 1 - Issue with environment
# Return Code: 2 - Argument error
__documentationBuildEnvironment() {
  local handler="$1" && shift

  local cleanFlag=false forceFlag=false verboseFlag=false

  set -eou pipefail

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
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  home=$(catchReturn "$handler" buildHome) || return $?
  envSource="$home/bin/build/env"
  lineTemplate="$home/documentation/template/env-line.md"
  moreTemplate="$home/documentation/template/env-more.md"
  source="$home/documentation/source/env/index.md"
  target="$home/documentation/.docs/env"
  cacheDirectory=$(catchReturn "$handler" documentationBuildCache envDocs) || return $?

  if "$cleanFlag"; then
    [ ! -d "$cacheDirectory" ] || catchEnvironment "$handler" find "$cacheDirectory" -type f -exec rm -f {} \; || return $?
    return 0
  fi
  catchEnvironment "$handler" muzzle directoryRequire "$target" || return $?
  catchEnvironment "$handler" cat "$source" >"$target/index.md" || return $?
  local envFile categories=()

  if ! $forceFlag && [ -f "$cacheDirectory/categories" ]; then
    local newestEnvSource newestEnvTarget
    newestEnvSource=$(directoryNewestFile "$envSource" --find -type f -name '*.sh')
    newestEnvTarget=$(directoryNewestFile "$target" --find -type f -name '*.md')
    if [ "$cacheDirectory/categories" -nt "$newestEnvSource" ] && [ "$newestEnvTarget" -nt "$newestEnvSource" ]; then
      ! $verboseFlag || statusMessage decorate info "No changes to environment files." || return $?
      return 0
    fi
  else
    catchEnvironment "$handler" touch "$cacheDirectory/categories" || return $?
  fi

  while IFS="" read -r item; do categories+=("$item"); done <"$cacheDirectory/categories"

  statusMessage decorate info "Iterating through env files ..."
  catchEnvironment "$handler" cp "$cacheDirectory/categories" "$cacheDirectory/categories.unsorted" || return $?
  local settings
  settings="$cacheDirectory/.settings.$$"

  while read -r envFile; do
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
  done < <(find "$home/bin/build/env" -maxdepth 1 -name "*.sh")
  set +a

  catchEnvironment "$handler" sort -u <"$cacheDirectory/categories.unsorted" >"$cacheDirectory/categories" || return $?
  catchEnvironment "$handler" rm -rf "$cacheDirectory/categories.unsorted" || return $?

  local targetFile

  targetFile="$target/index.md"

  if ! fileEndsWithNewline "$targetFile"; then
    printf "\n\n" >>"$targetFile"
  fi
  local category
  while IFS="" read -r categoryName; do
    categoryFileName="${categoryName// /_}"
    statusMessage decorate info "Processing $(basename "$category") ..."
    local name
    if [ -f "$cacheDirectory/category.$categoryFileName" ]; then
      printf "%s\n" "## $category" "" >>"$targetFile"
      while IFS="" read -r name; do
        printf "%s\n" "$(cat "$cacheDirectory/$name")" >>"$targetFile"
      done < <(sort -u "$cacheDirectory/category.$categoryFileName")
      printf "\n" >>"$targetFile"
    fi
  done <"$cacheDirectory/categories"

  local moreHeader="$home/documentation/template/env-more-header.md"
  local moreFooter="$home/documentation/template/env-more-footer.md"
  local heading=false name
  while IFS="" read -r name; do
    if [ -f "$cacheDirectory/more.$name" ]; then
      if ! $heading; then
        cat "$moreHeader" >>"$targetFile"
        heading=true
      fi
      printf "\n" >>"$targetFile"
      cat "$cacheDirectory/more.$name" >>"$targetFile"
    fi
  done < <(sort -u "$cacheDirectory/mores")
  if "$heading"; then
    cat "$moreFooter" >>"$targetFile"
  fi
}
