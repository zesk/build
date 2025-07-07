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
# Exit Code: 0 - Success
# Exit Code: 1 - Issue with environment
# Exit Code: 2 - Argument error
documentationBuildEnvironment() {
  local usage="_${FUNCNAME[0]}"

  local cleanFlag=false forceFlag=false verboseFlag=false

  set -eou pipefail

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
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
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  envSource="$home/bin/build/env"
  lineTemplate="$home/documentation/template/env-line.md"
  moreTemplate="$home/documentation/template/env-more.md"
  source="$home/documentation/source/env/index.md"
  target="$home/documentation/docs/env"
  cacheDirectory=$(__catchEnvironment "$usage" documentationBuildCache .environmentVariables) || return $?

  if "$cleanFlag"; then
    __catchEnvironment "$usage" find "$cacheDirectory" -type f -exec rm -f {} \; || return $?
    return 0
  fi
  __catchEnvironment "$usage" muzzle directoryRequire "$target" || return $?
  __catchEnvironment "$usage" cat "$source" >"$target/index.md" || return $?
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
    __catchEnvironment "$usage" touch "$cacheDirectory/categories" || return $?
  fi

  while IFS="" read -r item; do categories+=("$item"); done <"$cacheDirectory/categories"

  statusMessage decorate info "Iterating through env files ..."
  __catchEnvironment "$usage" cp "$cacheDirectory/categories" "$cacheDirectory/categories.unsorted" || return $?
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
    lines=$(printf "%s\n" "$description" | __catchEnvironment "$usage" fileLineCount) || return $?

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
      __catchEnvironment "$usage" printf "%s\n" "$categoryName" >>"$cacheDirectory/categories.unsorted" || return $?
      categories+=("$categoryName")
    fi
    __catchEnvironment "$usage" printf "%s\n" "$name" >>"$cacheDirectory/category.$categoryFileName" || return $?

    description=$shortDesc category="$categoryName" more="$more" type="$type" mapEnvironment <"$lineTemplate" >"$envTarget"
    if [ -n "$more" ]; then
      category="$categoryName" type="$type" mapEnvironment <"$moreTemplate" >"$moreTarget"
    fi
    printf "%s\n" "$name" >>"$cacheDirectory/mores"
  done < <(find "$home/bin/build/env" -maxdepth 1 -name "*.sh")
  __catchEnvironment "$usage" sort -u <"$cacheDirectory/categories.unsorted" >"$cacheDirectory/categories" || return $?
  __catchEnvironment "$usage" rm -rf "$cacheDirectory/categories.unsorted" || return $?

  local targetFile

  targetFile="$target/index.md"
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
_documentationBuildEnvironment() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
