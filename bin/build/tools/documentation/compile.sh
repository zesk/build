#!/usr/bin/env bash
#
# Implementation:
#
# - `documentationTemplateCompile`
# - `documentationTemplateDirectoryCompile`
# - `documentationTemplateFunctionCompile`
#
# Copyright &copy; 2025 Market Acumen, Inc.

__documentationTemplateCompile() {
  local handler="$1" && shift

  local start

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

  local cacheDirectory="" documentTemplate="" functionTemplate="" targetFile=""
  local forceFlag=false envFiles=() envFileArgs=() verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --env-file)
      shift
      local envFile
      envFile=$(usageArgumentFile "$handler" "envFile" "$1") || return $?
      envFiles+=("$envFile")
      envFileArgs+=("$argument" "$envFile")
      ;;
    --verbose)
      verboseFlag=true
      ;;
    --force)
      forceFlag=true
      ;;
    *)
      # Load arguments one-by-one
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory=$1
      elif [ -z "$documentTemplate" ]; then
        documentTemplate=$1
      elif [ -z "$functionTemplate" ]; then
        functionTemplate=$1
      elif [ -z "$targetFile" ]; then
        targetFile=$1
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  # Validate arguments
  cacheDirectory=$(usageArgumentDirectory "$handler" cacheDirectory "$cacheDirectory") || return $?
  documentTemplate="$(usageArgumentFile "$handler" documentTemplate "$documentTemplate")" || return $?
  functionTemplate="$(usageArgumentFile "$handler" functionTemplate "$functionTemplate")" || return $?
  targetFile="$(usageArgumentFileDirectory "$handler" targetFile "$targetFile")" || return $?

  local base

  base="$(basename "$targetFile")" || __throwArgument "$handler" basename "$targetFile" || return $?
  base="${base%%.md}"
  statusMessage decorate info "Generating $(decorate code "$base") $(decorate info "...")"

  local clean=() documentTokensFile
  documentTokensFile=$(fileTemporaryName "$handler") || return $?
  clean+=("$documentTokensFile")

  local mappedDocumentTemplate
  mappedDocumentTemplate=$(fileTemporaryName "$handler") || returnClean $? "${clean[@]}" return $?

  clean+=("$mappedDocumentTemplate")

  local envChecksum
  if ! envChecksum=$(
    local title
    set -a
    [ ! -f "$targetFile" ] || title="$(grep -E '^# ' -m 1 <"$targetFile" | cut -c 3-)"
    title="${title:-notitle}"
    for envFile in "${envFiles[@]+${envFiles[@]}}"; do
      # shellcheck source=/dev/null
      source "$envFile"
    done
    mapEnvironment <"$documentTemplate" >"$mappedDocumentTemplate"
    if [ ${#envFiles[@]} -gt 0 ]; then
      shaPipe "${envFiles[@]}" | shaPipe
    else
      printf %s 'no-environment'
    fi
  ); then
    __throwEnvironment "$handler" "mapTokens failed" || returnClean $? "${clean[@]}" return $?
  fi
  if ! mapTokens <"$mappedDocumentTemplate" >"$documentTokensFile"; then
    __throwEnvironment "$handler" "mapTokens failed" || returnClean $? "${clean[@]}" return $?
  fi
  #
  # Look at source file for each function
  #
  local envChecksumCache
  if ! envChecksumCache=$(directoryRequire "$cacheDirectory/envChecksum"); then
    __throwEnvironment "$handler" "create $cacheDirectory/envChecksum failed" || returnClean $? "${clean[@]}" || return $?
  fi
  envChecksumCache="$envChecksumCache/$envChecksum"
  if [ ! -f "$envChecksumCache" ]; then
    touch "$envChecksumCache"
  fi

  local compiledTemplateCache
  compiledTemplateCache=$(__catch "$handler" directoryRequire "$cacheDirectory/compiledTemplateCache") || returnClean $? "${clean[@]}" || return $?
  # Environment change will affect this template
  # Function template change will affect this template

  local message="No message"
  # As well, document template change will affect this template
  local tempCount
  tempCount=$(__catch "$handler" fileLineCount "$documentTokensFile") || return $?
  if [ "$tempCount" -eq 0 ]; then
    message="Empty document"
    if [ ! -f "$targetFile" ] || ! diff -q "$mappedDocumentTemplate" "$targetFile" >/dev/null; then
      printf "%s (mapped) -> %s %s" "$(decorate warning "$documentTemplate")" "$(decorate success "$targetFile")" "$(decorate error "(no tokens found)")"
      __catchEnvironment "$handler" cp "$mappedDocumentTemplate" "$targetFile" || returnClean $? "${clean[@]}" || return $?
    fi
  else
    local checkTokens=() tokenName checkFiles=()
    while read -r tokenName; do
      if inArray "$tokenName" "${checkTokens[@]+"${checkTokens[@]}"}"; then
        continue
      fi
      checkTokens+=("$tokenName")
      if ! settingsFile=$(__documentationIndex_Lookup --source "$cacheDirectory" "$tokenName"); then
        continue
      fi
      if [ "${#checkFiles[@]}" -eq 0 ] || ! inArray "$settingsFile" "${checkFiles[@]}"; then
        # Source file of any token in the documentTemplate change will affect this template
        checkFiles+=("$settingsFile")
      fi
    done <"$documentTokensFile"

    if $forceFlag || fileIsEmpty "$targetFile" || ! fileIsNewest "$targetFile" "${checkFiles[@]+"${checkFiles[@]}"}" "$documentTemplate"; then
      message="Generated"
      compiledFunctionEnv=$(fileTemporaryName "$handler") || return $?
      # subshell to hide environment tokens
      while read -r tokenName; do
        compiledFunctionTarget="$compiledTemplateCache/$tokenName"
        if ! settingsFile=$(__documentationIndex_Lookup --source "$cacheDirectory" "$tokenName"); then
          __catchEnvironment "$handler" printf "%s\n" "Function not found: $tokenName" >"$compiledFunctionTarget" || returnClean $? "${clean[@]}" || return $?
          continue
        fi
        if ! $forceFlag && [ -f "$compiledFunctionTarget" ] && fileIsNewest "$compiledFunctionTarget" "$settingsFile" "$envChecksumCache" "$functionTemplate"; then
          statusMessage decorate info "Skip $tokenName and use cache"
        else
          __catch "$handler" documentationTemplateFunctionCompile "${envFileArgs[@]+${envFileArgs[@]}}" "$cacheDirectory" "$tokenName" "$functionTemplate" | trimTail >"$compiledFunctionTarget" || returnClean $? "${clean[@]}" || return $?
          __catchEnvironment "$handler" printf "\n" >>"$compiledFunctionTarget" || returnClean $? "${clean[@]}" || return $?
        fi
        environmentValueWrite "$tokenName" "$(cat "$compiledFunctionTarget")" >>"$compiledFunctionEnv"
      done <"$documentTokensFile"

      IFS=$'\n' read -r -d '' -a tokenNames <"$documentTokensFile"
      statusMessage decorate success "Writing $targetFile using $documentTemplate (mapped) ..."
      (
        set -a
        #shellcheck source=/dev/null
        source "$compiledFunctionEnv" || __throwEnvironment "$handler" "source $compiledFunctionEnv compiled for $targetFile" || return $?
        mapEnvironment "${tokenNames[@]}" <"$mappedDocumentTemplate" >"$targetFile"
      ) || __throwEnvironment "$handler" "mapEnvironment $tokenName" || returnClean $? "${clean[@]}" || return $?
      __catchEnvironment "$handler" cp "$compiledFunctionEnv" "$envChecksumCache" || return $?
    else
      message="Cached"
    fi
  fi
  __catchEnvironment "$handler" rm -rf "${clean[@]}" || return $?
  statusMessage decorate info "$(timingReport "$start" "$message" "$targetFile" in)"
}

__documentationTemplateFunctionCompile() {
  local handler="$1" && shift

  local cacheDirectory="" functionName="" functionTemplate="" envFiles=()

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --env-file)
      shift
      envFile=$(usageArgumentFile "$handler" "envFile" "$1") || return $?
      envFiles+=("$envFile")
      ;;
    *)
      # Load arguments one-by-one
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory=$1
      elif [ -z "$functionName" ]; then
        functionName=$1
      elif [ -z "$functionTemplate" ]; then
        functionTemplate=$1
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  local settingsFile

  # Validate arguments
  cacheDirectory=$(usageArgumentDirectory "$handler" cacheDirectory "$cacheDirectory") || return $?
  functionName="$(usageArgumentString "$handler" functionName "$functionName")" || return $?
  functionTemplate="$(usageArgumentFile "$handler" functionTemplate "$functionTemplate")" || return $?
  settingsFile=$(__documentationIndex_Lookup "$cacheDirectory" "$functionName") || __throwEnvironment "$handler" "Unable to find \"$functionName\" (using index \"$cacheDirectory\")" || return $?

  __catchEnvironment "$handler" _bashDocumentation_Template "$functionTemplate" "${envFiles[@]+"${envFiles[@]}"}" "$settingsFile" || return $?
}
_documentationTemplateFunctionCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__documentationTemplateDirectoryCompile() {
  local handler="$1" && shift

  local cacheDirectory="" templateDirectory="" functionTemplate="" targetDirectory=""
  local passArgs=() filterArgs=()
  local verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --force)
      passArgs+=("$argument")
      ;;
    --verbose)
      verboseFlag=true
      passArgs+=("$argument")
      ;;
    --filter)
      shift
      while [ $# -gt 0 ] && [ "$1" != "--" ]; do filterArgs+=("$1") && shift; done
      ;;
    --env-file)
      passArgs+=("$argument")
      shift || __throwArgument "$handler" "missing $argument argument" || return $?
      passArgs+=("$1")
      ;;
    *)
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory="$1"
      elif [ -z "$templateDirectory" ]; then
        templateDirectory="$1"
      elif [ -z "$functionTemplate" ]; then
        functionTemplate="$1"
      elif [ -z "$targetDirectory" ]; then
        targetDirectory="$1"
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

  local cacheDirectory templateDirectory functionTemplate targetDirectory

  cacheDirectory=$(usageArgumentDirectory "$handler" "cacheDirectory" "$cacheDirectory") || return $?
  templateDirectory=$(usageArgumentDirectory "$handler" "templateDirectory" "$templateDirectory") || return $?
  functionTemplate=$(usageArgumentFile "$handler" "functionTemplate" "$functionTemplate") || return $?
  targetDirectory=$(usageArgumentDirectory "$handler" "targetDirectory" "$targetDirectory") || return $?

  ! $verboseFlag || decorate pair cacheDirectory "$cacheDirectory"
  ! $verboseFlag || decorate pair templateDirectory "$templateDirectory"
  ! $verboseFlag || decorate pair functionTemplate "$functionTemplate"
  ! $verboseFlag || decorate pair targetDirectory "$targetDirectory"

  local exitCode=0 fileCount=0 templateFile=""
  while read -r templateFile; do
    local base="${templateFile#"$templateDirectory/"}"
    [ "$base" != "$templateFile" ] || __throwEnvironment "$handler" "templateFile $(decorate file "$templateFile") is not within $(decorate file "$templateDirectory")" || return $?
    local targetFile="$targetDirectory/$base"
    ! $verboseFlag || statusMessage decorate info Compiling "$templateFile"
    if ! documentationTemplateCompile "${passArgs[@]+${passArgs[@]}}" "$cacheDirectory" "$templateFile" "$functionTemplate" "$targetFile"; then
      decorate error "Failed to generate $targetFile" 1>&2
      exitCode=1
      break
    fi
    fileCount=$((fileCount + 1))
  done < <(find "$templateDirectory" -type f -name '*.md' ! -path "*/.*/*" ! -name '_*' "${filterArgs[@]+"${filterArgs[@]}"}")
  statusMessage --last timingReport "$start" "Completed generation of $fileCount $(plural $fileCount file files) in $(decorate info "$targetDirectory") "
  return $exitCode
}
_documentationTemplateDirectoryCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
