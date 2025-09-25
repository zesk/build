#!/usr/bin/env bash
#
# documentationBuildEnvironment
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

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
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --clean)
      cleanFlag=true
      ;;
    --force)
      forceFlag=true
      ;;
    --verbose)
      verboseFlag=true
      ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  home=$(__catch "$handler" buildHome) || return $?
  envSource="$home/bin/build/env"
  lineTemplate="$home/documentation/template/env-line.md"
  moreTemplate="$home/documentation/template/env-more.md"
  source="$home/documentation/source/env/index.md"
  target="$home/documentation/.docs/env"
  cacheDirectory=$(__catch "$handler" documentationBuildCache .environmentVariables) || return $?

  if "$cleanFlag"; then
    __catchEnvironment "$handler" find "$cacheDirectory" -type f -exec rm -f {} \; || return $?
    return 0
  fi
  __catchEnvironment "$handler" muzzle directoryRequire "$target" || return $?
  __catchEnvironment "$handler" cat "$source" >"$target/index.md" || return $?
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
    __catchEnvironment "$handler" touch "$cacheDirectory/categories" || return $?
  fi

  while IFS="" read -r item; do categories+=("$item"); done <"$cacheDirectory/categories"

  statusMessage decorate info "Iterating through env files ..."
  __catchEnvironment "$handler" cp "$cacheDirectory/categories" "$cacheDirectory/categories.unsorted" || return $?
  while read -r envFile; do
    local envTarget name="${envFile##*/}"

    set -a
    name="${name%.sh}"
    envTarget="$cacheDirectory/$name"
    moreTarget="$cacheDirectory/more.$name"
    if ! $forceFlag && [ -f "$envTarget" ] && fileIsNewest "$envTarget" "$envFile" "$lineTemplate" "$moreTemplate"; then
      statusMessage decorate notice "Cached $(basename "$envFile") ..."
      continue
    else
      statusMessage decorate info "Generated $(basename "$envFile") ..."
    fi

    local description type lines more="" shortDesc
    description=$(sed -n '/^[[:space:]]*#/!q; p' "$envFile" | grep -v -e '^#!\|\&copy;' | cut -c 3- | grep -v '^[[:alpha:]][[:alnum:]]*: ')
    lines=$(printf "%s\n" "$description" | __catch "$handler" fileLineCount) || return $?

    local categoryName categoryFileName

    categoryName="$(grep -m 1 -e "^[[:space:]]*#[[:space:]]*Category:" "$envFile" | cut -f 2 -d ":" | trimSpace)"
    [ -n "$categoryName" ] || categoryName="Uncategorized"
    categoryFileName="${categoryName// /_}"

    type="$(grep -m 1 -e "^[[:space:]]*#[[:space:]]*Type:" "$envFile" | cut -f 2 -d ":" | trimSpace)"
    if [ "$lines" -le 2 ]; then
      shortDesc="${description//$'\n'/ }"
      more=""
    else
      more="[notes](#$name)"
      shortDesc="$(printf "%s\n" "$description" | head -n 1)"
    fi

    if [ "${#categories[@]}" -eq 0 ] || ! inArray "$categoryName" "${categories[@]}"; then
      __catchEnvironment "$handler" printf "%s\n" "$categoryName" >>"$cacheDirectory/categories.unsorted" || return $?
      categories+=("$categoryName")
    fi
    __catchEnvironment "$handler" printf "%s\n" "$name" >>"$cacheDirectory/category.$categoryFileName" || return $?

    description=$shortDesc category="$categoryName" more="$more" type="$type" mapEnvironment <"$lineTemplate" >"$envTarget"
    if [ -n "$more" ]; then
      category="$categoryName" type="$type" mapEnvironment <"$moreTemplate" >"$moreTarget"
    fi
    printf "%s\n" "$name" >>"$cacheDirectory/mores"
  done < <(find "$home/bin/build/env" -maxdepth 1 -name "*.sh")
  __catchEnvironment "$handler" sort -u <"$cacheDirectory/categories.unsorted" >"$cacheDirectory/categories" || return $?
  __catchEnvironment "$handler" rm -rf "$cacheDirectory/categories.unsorted" || return $?

  local targetFile

  targetFile="$target/index.md"

  if ! fileEndsWithNewline "$targetFile"; then
    printf "\n\n" >>"$targetFile"
  fi
  local categoryName
  while IFS="" read -r categoryName; do
    categoryFileName="${categoryName// /_}"
    statusMessage decorate info "Processing $(basename "$categoryName") ..."
    local name
    if [ -f "$cacheDirectory/category.$categoryFileName" ]; then
      printf "%s\n" "## $categoryName" "" >>"$targetFile"
      while IFS="" read -r name; do
        printf "%s\n" "$(cat "$cacheDirectory/$name")" >>"$targetFile"
      done < <(sort -u "$cacheDirectory/category.$categoryFileName")
      printf "\n" >>"$targetFile"
    fi
  done <"$cacheDirectory/categories"

  local name
  while IFS="" read -r name; do
    if [ -f "$cacheDirectory/more.$name" ]; then
      printf "\n" >>"$targetFile"
      cat "$cacheDirectory/more.$name" >>"$targetFile"
    fi
  done < <(sort -u "$cacheDirectory/mores")
}
