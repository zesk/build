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

  local cacheDirectory="" sourceFile="" functionTemplate="" targetFile=""
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
    --verbose)
      verboseFlag=true
      ;;
    --force)
      forceFlag=true
      ;;
    *)
      # Load arguments one-by-one
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory=$(usageArgumentDirectory "$handler" cacheDirectory "$argument") || return $?
      elif [ -z "$sourceFile" ]; then
        sourceFile="$(usageArgumentFile "$handler" sourceFile "$argument")" || return $?
      elif [ -z "$functionTemplate" ]; then
        functionTemplate="$(usageArgumentFile "$handler" functionTemplate "$argument")" || return $?
      elif [ -z "$targetFile" ]; then
        targetFile="$(usageArgumentFileDirectory "$handler" targetFile "$argument")" || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  [ -n "$cacheDirectory" ] || __throwArgument "$handler" "Missing cacheDirectory" || return $?
  [ -n "$sourceFile" ] || __throwArgument "$handler" "Missing sourceFile" || return $?
  [ -n "$functionTemplate" ] || __throwArgument "$handler" "Missing functionTemplate" || return $?
  [ -n "$targetFile" ] || __throwArgument "$handler" "Missing targetFile" || return $?

  # Validate arguments
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

  if ! mapTokens <"$mappedDocumentTemplate" >"$documentTokensFile"; then
    __throwEnvironment "$handler" "mapTokens failed" || returnClean $? "${clean[@]}" return $?
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
      printf "%s (mapped) -> %s %s" "$(decorate warning "$sourceFile")" "$(decorate success "$targetFile")" "$(decorate error "(no tokens found)")"
      __catchEnvironment "$handler" cp "$mappedDocumentTemplate" "$targetFile" || returnClean $? "${clean[@]}" || return $?
    fi
  else
    local checkTokens=() tokenName checkFiles=()
    while read -r tokenName; do
      if inArray "$tokenName" "${checkTokens[@]+"${checkTokens[@]}"}"; then
        continue
      fi
      case "$tokenName" in [^[:alpha:]_]* | *[^[:alnum:]_]]*) continue ;; esac
      checkTokens+=("$tokenName")
      local sourceCodeFile
      if ! sourceCodeFile=$(__documentationIndex_Lookup --source "$cacheDirectory" "$tokenName"); then
        decorate warning "Function definition not found $(decorate code "$tokenName")"
        continue
      fi
      checkFiles+=("$sourceCodeFile")
    done <"$documentTokensFile"

    if $forceFlag || fileIsEmpty "$targetFile" || ! fileIsNewest "$targetFile" "${checkFiles[@]+"${checkFiles[@]}"}" "$sourceFile"; then
      message="Generated"
      compiledFunctionEnv=$(fileTemporaryName "$handler") || return $?
      # subshell to hide environment tokens
      for tokenName in "${checkTokens[@]}"; do
        compiledFunctionTarget="$compiledTemplateCache/$tokenName"
        local sourceCodeFile
        if ! sourceCodeFile=$(__documentationIndex_Lookup --source "$cacheDirectory" "$tokenName"); then
          __catchEnvironment "$handler" printf "%s\n" "Function not found: $tokenName" >"$compiledFunctionTarget" || returnClean $? "${clean[@]}" || return $?
          continue
        fi
        if ! $forceFlag && [ -f "$compiledFunctionTarget" ] && fileIsNewest "$compiledFunctionTarget" "$sourceCodeFile" "$functionTemplate"; then
          statusMessage decorate info "Skip $tokenName and use cache"
        else
          {
            __catch "$handler" documentationTemplateFunctionCompile "${envFileArgs[@]+${envFileArgs[@]}}" "$cacheDirectory" "$tokenName" "$functionTemplate" | trimTail || returnClean $? "${clean[@]}" || return $?
            printf "\n"
          } >"$compiledFunctionTarget" || returnClean $? "${clean[@]}" || return $?
        fi
        environmentValueWrite "$tokenName" "$(cat "$compiledFunctionTarget")" >>"$compiledFunctionEnv"
      done

      IFS=$'\n' read -r -d '' -a tokenNames <"$documentTokensFile"
      statusMessage decorate success "Writing $targetFile using $sourceFile (mapped) ..."
      (
        set -a
        #shellcheck source=/dev/null
        source "$compiledFunctionEnv" || __throwEnvironment "$handler" "source $compiledFunctionEnv compiled for $targetFile" || return $?
        mapEnvironment "${tokenNames[@]}" <"$mappedDocumentTemplate" >"$targetFile"
      ) || __throwEnvironment "$handler" "mapEnvironment $tokenName" || returnClean $? "${clean[@]}" || return $?
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
    --env-file) shift && envFiles+=("$(usageArgumentFile "$handler" "envFile" "$1")") || return $? ;;
    *)
      # Load arguments one-by-one
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory=$(usageArgumentDirectory "$handler" cacheDirectory "$argument") || return $?
      elif [ -z "$functionName" ]; then
        functionName="$(usageArgumentString "$handler" functionName "$argument")" || return $?
      elif [ -z "$functionTemplate" ]; then
        functionTemplate="$(usageArgumentFile "$handler" functionTemplate "$argument")" || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  echo "${BASH_SOURCE[0]}:$LINENO"
  # Validate arguments
  for argument in cacheDirectory functionName functionTemplate; do
    [ -n "${!argument}" ] || __throwArgument "$handler" "Requires argument $argument (#${#__saved[@]}: $(decorate each code -- "${__saved[@]}"))" || return $?
  done

  echo "${BASH_SOURCE[0]}:$LINENO"
  local settingsFile
  settingsFile=$(__catch "$handler" __documentationIndex_Lookup "$cacheDirectory" "$functionName") || return $?

  echo "${BASH_SOURCE[0]}:$LINENO"
  __catch "$handler" __echo _bashDocumentation_Template "$functionTemplate" "${envFiles[@]+"${envFiles[@]}"}" "$settingsFile" || return $?
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
      shift
      passArgs+=("$argument" "${1-}")
      ;;
    *)
      if [ -z "$cacheDirectory" ]; then
        cacheDirectory=$(usageArgumentDirectory "$handler" "cacheDirectory" "$argument") || return $?
      elif [ -z "$templateDirectory" ]; then
        templateDirectory=$(usageArgumentDirectory "$handler" "templateDirectory" "$argument") || return $?
      elif [ -z "$functionTemplate" ]; then
        functionTemplate=$(usageArgumentRealFile "$handler" "functionTemplate" "$argument") || return $?
      elif [ -z "$targetDirectory" ]; then
        targetDirectory=$(usageArgumentDirectory "$handler" "targetDirectory" "$argument") || return $?
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

  local argument
  for argument in cacheDirectory templateDirectory functionTemplate targetDirectory; do
    [ -n "${!argument}" ] || __throwArgument "$handler" "Need $argument (#${#__saved[@]}: $(decorate each code -- "${__saved[@]}"))" || return $?
  done

  if $verboseFlag; then
    statusMessage --last decorate pair cacheDirectory "$cacheDirectory"
    decorate pair templateDirectory "$templateDirectory"
    decorate pair functionTemplate "$functionTemplate"
    decorate pair targetDirectory "$targetDirectory"
  fi

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
