#!/usr/bin/env bash
#
# documentation.sh
#
# Tools to help with documentation of shell scripts. Very simple mechanism to extract
# documentation from code. Note that bash makes a terrible template engine, but
# having no language dependencies outweighs the negatives.
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

usageDocument() {
  __usageDocumentComplex "$@"
}

# fn: usageDocument
# Summary: Universal error handler for functions (with formatting)
#
# Actual function is called `{functionName}`.
#
# Argument: functionDefinitionFile - Required. File. The file in which the function is defined. If you don't know, use `bashDocumentation_FindFunctionDefinitions` or `bashDocumentation_FindFunctionDefinition`.
# Argument: functionName - Required. String. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
# Argument: exitCode - Required. Integer. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
# Argument: message - Optional. String. A message.
#
# Generates console usage output for a script using documentation tools parsed from the comment of the function identified.
#
# Simplifies documentation and keeps it with the code.
#
# Environment: *BUILD_DEBUG* - Add `fast-usage` to make this quicker when you do not care about usage/failure.
# BUILD_DEBUG: fast-usage - `usageDocumentComplex` does not output formatted help for performance reasons
__usageDocumentComplex() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  [ $# -ge 2 ] || __throwArgument "$handler" "Expected 2 arguments, got $#:$(printf -- " \"%s\"" "$@")" || return $?

  local functionDefinitionFile="${1-}" functionName="${2-}"
  shift 2 || __throwArgument "$handler" "Missing arguments" || return $?

  local home returnCode="${1-NONE}"

  home=$(__catch "$handler" buildHome) || return $?

  shift 2>/dev/null || :

  if [ ! -f "$functionDefinitionFile" ]; then
    local tryFile="$home/$functionDefinitionFile"
    if [ ! -f "$tryFile" ]; then
      export PWD
      __catchArgument "$handler" "functionDefinitionFile $functionDefinitionFile (PWD: ${PWD-}) (Build home: \"$home\") not found" || return $?
    fi
    functionDefinitionFile="$tryFile"
  fi
  [ -n "$functionName" ] || __throwArgument "$handler" "functionName is blank" || return $?

  if [ "$returnCode" = "NONE" ]; then
    decorate error "NO EXIT CODE" 1>&2
    returnCode=1
  fi

  __catchArgument "$handler" isInteger "$returnCode" || __catchArgument "$handler" "$(debuggingStack)" || return $?

  local color="success"
  case "$returnCode" in
  0 | 2)
    if buildDebugEnabled "fast-usage"; then
      if [ "$returnCode" -ne 0 ]; then
        exec 1>&2
        color="warning"
      fi
      printf -- "%s%s %s\n" "$(decorate value "[$returnCode]")" "$(decorate code " $functionName ")" "$(decorate "$color" -- "$@")"
      return "$returnCode"
    fi
    ;;
  *)
    if [ "$returnCode" -ne 0 ]; then
      exec 1>&2 && color="error"
    fi
    printf -- "%s%s %s\n" "$(decorate value "[$returnCode]")" "$(decorate code " $functionName ")" "$(decorate "$color" -- "$@")"
    return "$returnCode"
    ;;
  esac

  local variablesFile
  variablesFile=$(fileTemporaryName "$handler") || return $?
  if ! bashDocumentation_Extract "$functionDefinitionFile" "$functionName" >"$variablesFile"; then
    dumpPipe "variablesFile" <"$variablesFile"
    __throwArgument "$handler" "Unable to extract \"$functionName\" from \"$functionDefinitionFile\"" || returnClean $? "$variablesFile" || return $?
  fi
  (
    local description="" argument="" base exit_code="" environment="" stdin="" stdout="" example="" build_debug="" __handler="$handler"

    declare -r __handler variablesFile
    set -a
    base="$(basename "$functionDefinitionFile")"
    # shellcheck source=/dev/null
    __catchEnvironment "$__handler" source "$variablesFile" || returnClean $? "$variablesFile" || return $?
    # Some variables MAY BE OVERWRITTEN ABOVE .e.g. `__handler`
    __catchEnvironment "$__handler" rm -f "$variablesFile" || return $?
    set +a

    : "$exit_code $environment $stdin $stdout $example are referenced here and with \${!variable} below"
    : "$build_debug"

    [ "$returnCode" -eq 0 ] || exec 1>&2 && color="error"
    local bashDebug=false
    if isBashDebug; then
      bashDebug=true
      # Hides a lot of unnecessary tracing
      __buildDebugDisable
    fi
    __catch "$__handler" bashRecursionDebug || return $?
    local variable prefix label done=false suffix=""
    while ! $done; do
      IFS="|" read -r variable prefix label || done=true
      [ -n "$variable" ] || continue
      local value="${!variable}"
      if [ -n "$value" ]; then
        local formatted
        formatted="$(printf "\n\n%s\n%s\n" "$label:" "$(decorate wrap "$prefix" "" <<<"$(trimSpace "$value")")")"
        suffix="$suffix$formatted"
      fi
    done < <(__usageDocumentComplexSections)
    description=$(trimTail <<<"$description")
    __usageTemplate "$fn" "$(printf "%s\n" "$argument" | sed 's/ - /^/1')" "^" "$description$suffix" "$returnCode" "$@" | identical=IDENTICAL functionName="$functionName" fn="$fn" mapEnvironment
    if $bashDebug; then
      __buildDebugEnable
    fi
    __catch "$__handler" bashRecursionDebug --end || return $?
  ) || returnClean $? "$variablesFile" || return $?
  return "$returnCode"
}
___usageDocumentComplex() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

__usageDocumentComplexSections() {
  cat <<'EOF'
exit_code|- |Exit codes
environment|- |Environment variables
stdin||Reads from `stdin`
stdout||Writes to `stdout`
example||Example
build_debug|- |`BUILD_DEBUG` settings
EOF
}

# IDENTICAL usageDocumentSimple 33

# Output a simple error message for a function
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: source - File. Required. File where documentation exists.
# Argument: function - String. Required. Function to document.
# Argument: returnCode - UnsignedInteger. Required. Exit code to return.
# Argument: message ... - Optional. String. Message to display to the user.
# Requires: bashFunctionComment decorate read printf exitString __help usageDocument
usageDocumentSimple() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local source="${1-}" functionName="${2-}" returnCode="${3-}" color helpColor="info" icon="❌" line prefix="" finished=false skip=false && shift 3

  case "$returnCode" in 0) icon="🏆" && color="info" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="bold-red" ;; *) color="orange" ;; esac
  [ "$returnCode" -eq 0 ] || exec 1>&2
  $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(exitString "$returnCode")")" "$(decorate "$color" "$*")"
  if [ ! -f "$source" ]; then
    export BUILD_HOME
    [ -d "${BUILD_HOME-}" ] || _argument "Unable to locate $source (${PWD-})" || return $?
    source="$BUILD_HOME/$source"
    [ -f "$source" ] || _argument "Unable to locate $source (${PWD-})" || return $?
  fi
  while ! $finished; do
    IFS='' read -r line || finished=true
    printf "%s%s\n" "$prefix" "$(decorate "$helpColor" "$line")"
    prefix=""
  done < <(bashFunctionComment "$source" "$functionName" | sed "s/{fn}/$functionName/g")
  return "$returnCode"
}
_usageDocumentSimple() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Convert a template file to a documentation file using templates
#
# Usage: {fn} [ --env-file envFile ] cacheDirectory documentTemplate functionTemplate templateFile targetFile
# Argument: --env-file envFile - Optional. File. One (or more) environment files used to map `documentTemplate` prior to scanning, as defaults prior to each function generation, and after file generation.
# Argument: cacheDirectory - Required. Cache directory where the indexes live.
# Argument: documentTemplate - Required. The document template containing functions to define
# Argument: functionTemplate - Required. The template for individual functions defined in the `documentTemplate`.
# Argument: targetFile - Required. Target file to generate
# Convert a template which contains bash functions into full-fledged documentation.
#
# The process:
#
# 1. `documentTemplate` is scanned for tokens which are assumed to represent Bash functions
# 1. `functionTemplate` is used to generate the documentation for each function
# 1. Functions are looked up in `cacheDirectory` using indexing functions and
# 1. Template used to generate documentation and compiled to `targetFile`
#
# `cacheDirectory` is required - build an index using `documentationIndexIndex` prior to using this.
#
# See: documentationIndex_Lookup
# See: documentationIndexIndex
# Exit Code: 0 - If success
# Exit Code: 1 - Issue with file generation
# Exit Code: 2 - Argument error
# Requires: __catchEnvironment timingStart __throwArgument usageArgumentFile usageArgumentDirectory usageArgumentFileDirectory
# Requires: basename decorate statusMessage fileTemporaryName rm grep cut source mapTokens returnClean
# Requires: mapEnvironment shaPipe printf
documentationTemplateCompile() {
  local handler="_${FUNCNAME[0]}"

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
      if ! settingsFile=$(documentationIndex_Lookup --source "$cacheDirectory" "$tokenName"); then
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
        if ! settingsFile=$(documentationIndex_Lookup --source "$cacheDirectory" "$tokenName"); then
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
_documentationTemplateCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Generate a function documentation block using `functionTemplate` for `functionName`
#
#
# Requires function indexes to be generated in `cacheDirectory`.
#
# Generate documentation for a single function.
#
# Template is output to stdout.
#
# Exit Code: 0 - If success
# Exit Code: 1 - Issue with file generation
# Exit Code: 2 - Argument error
# Argument: --env-file envFile - Optional. File. One (or more) environment files used during map of `functionTemplate`
# Argument: cacheDirectory - Required. Cache directory where the indexes live.
# Argument: functionName - Required. The function name to document.
# Argument: functionTemplate - Required. The template for individual functions.
# Usage: {fn} [ --env-file envFile ] cacheDirectory functionName functionTemplate
documentationTemplateFunctionCompile() {
  local handler="_${FUNCNAME[0]}"

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
  settingsFile=$(documentationIndex_Lookup "$cacheDirectory" "$functionName") || __throwEnvironment "$handler" "Unable to find \"$functionName\" (using index \"$cacheDirectory\")" || return $?

  __catchEnvironment "$handler" _bashDocumentation_Template "$functionTemplate" "${envFiles[@]+"${envFiles[@]}"}" "$settingsFile" || return $?
}
_documentationTemplateFunctionCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} cacheDirectory documentDirectory functionTemplate targetDirectory
# Argument: --filter filterArgs ... --  - Arguments. Optional. Passed to `find` and allows filtering list.
# Argument: --force - Flag. Optional. Force generation of files.
# Argument: --verbose - Flag. Optional. Output more messages.
# Argument: cacheDirectory - Required. The directory where function index exists and additional cache files can be stored.
# Argument: documentDirectory - Required. Directory containing documentation templates
# Argument: templateFile - Required. Function template file to generate documentation for functions
# Argument: targetDirectory - Required. Directory to create generated documentation
# Summary: Convert a directory of templates into documentation for Bash functions
# Convert a directory of templates for bash functions into full-fledged documentation.
#
# The process:
#
# 1. `documentDirectory` is scanned for files which look like `*.md`
# 1. `{fn}` is called for each one
#
# If the `cacheDirectory` is supplied, it's used to store values and hashes of the various files to avoid having
# to regenerate each time.
#
# See: documentationTemplateCompile
# Exit Code: 0 - If success
# Exit Code: 1 - Any template file failed to generate for any reason
# Exit Code: 2 - Argument error
#
documentationTemplateDirectoryCompile() {
  local handler="_${FUNCNAME[0]}"

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

# Document a function and generate a function template (markdown)
#
# Usage: bashDocumentFunction file function template
# Argument: file - Required. File in which the function is defined
# Argument: function - Required. The function name which is defined in `file`
# Argument: template - Required. A markdown template to use to map values.
# Exit code: 0 - Success
# Exit code: 1 - Template file not found
# Short description: Simple bash function documentation
# Deprecated: 2023-01-18
# See: _bashDocumentation_Template
# See: bashDocumentFunction
# See: repeat
# Requires: __throwArgument fileTemporaryName __catchEnvironment bashDocumentation_Extract __dumpNameValue  _bashDocumentation_Template rm
bashDocumentFunction() {
  local handler="_${FUNCNAME[0]}"

  local file="" fn="" template=""
  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || __throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      if [ -z "$file" ]; then
        file=$(usageArgumentFile "$handler" "file" "$argument") || return $?
      elif [ -z "$fn" ]; then
        fn=$(usageArgumentString "$handler" "fn" "$argument") || return $?
      elif [ -z "$template" ]; then
        template=$(usageArgumentFile "$handler" "template" "$argument") || return $?
      else
        # _IDENTICAL_ argumentUnknownHandler 1
        __throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      fi
      ;;
    esac
    shift
  done

  local envFile

  envFile=$(fileTemporaryName "$handler") || return $?
  __catchEnvironment "$handler" printf "%s\n%s\n" "#!/usr/bin/env bash" "%s\n" "set -eou pipefail" >>"$envFile" || return $?
  if ! bashDocumentation_Extract "$file" "$fn" >>"$envFile"; then
    __dumpNameValue "error" "$fn was not found" >>"$envFile"
  fi

  local exitCode
  _bashDocumentation_Template "$template" "$envFile"
  exitCode=$?
  __catchEnvironment "$handler" rm -rf "$envFile" || return $?
  return $exitCode
}
_bashDocumentFunction() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# See: bashDocumentFunction
# Document a function and generate a function template (markdown). To custom format any
# of the fields in this, write functions in the form `_bashDocumentationFormatter_${name}Format` such that
# name matches the variable name (lowercase alphanumeric characters and underscores).
#
# Filter functions should modify the input/output pipe; an example can be found in `{applicationFile}` by looking at
# sample function `_bashDocumentationFormatter_exit_code`.
#
# See: _bashDocumentationFormatter_exit_code
# Usage: {fn} template [ settingsFile ...
# Argument: template - Required. A markdown template to use to map values. Post-processed with `markdown_removeUnfinishedSections`
# Argument: settingsFile - Required. Settings file to be loaded.
# Exit code: 0 - Success
# Exit code: 1 - Template file not found
# Short description: Simple bash function documentation
#
_bashDocumentation_Template() {
  local template="$1" envFile
  [ -f "$template" ] || _argument "Template $template not found" || return $?
  shift || :
  set +m
  (
    # subshell this does not affect anything except these commands
    set -aeou pipefail
    while [ $# -gt 0 ]; do
      envFile="$1"
      [ -f "$envFile" ] || _argument "Settings file $envFile not found" || return $?
      # shellcheck source=/dev/null
      source "$envFile" || _environment "$envFile Failed: $(dumpPipe "Template envFile failed" <"$envFile")" || return $?
      shift
    done
    # Format our values
    while read -r envVar; do
      formatter="_bashDocumentationFormatter_${envVar}"
      if isFunction "$formatter"; then
        declare "$envVar"="$(printf "%s\n" "${!envVar}" | "$formatter")"
      fi
    done < <(environmentVariables)
    # shellcheck source=/dev/null
    mapEnvironment <"$template" | grep -E -v '^shellcheck|# shellcheck' | markdown_removeUnfinishedSections || return $?
  ) 2>/dev/null || _environment "$template failed" || return $?
}

#
# Utility to export multi-line values as Bash variables
#
# Usage: __dumpNameValue name [ value0 value1 ... ]
# Argument: `name` - Shell value to output
# Argument: `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner
#
__dumpNameValue() {
  __dumpNameValuePrefix "" "$@"
}

#
# Export value appending existing value
#
# Usage: __dumpNameValueAppend name [ value0 value1 ... ]
# Argument: `name` - Shell value to output
# Argument: `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner
#
__dumpNameValueAppend() {
  local varName="$1"
  shift
  __dumpNameValuePrefixLocal "" "APPEND_$varName" "$@"
  # shellcheck disable=SC2016
  printf -- '%s="${%s}${APPEND_%s}"; unset APPEND_%s;\n' "$varName" "$varName" "$varName" "$varName"
}

#
# Usage: __dumpNameValuePrefix prefix name [ value0 value1 ... ]
# Argument: `prefix` - Literal string value to prefix each text line with
# Argument: `name` - Shell value to output
# Argument: `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner
#
__dumpNameValuePrefixLocal() {
  local prefix="${1}" varName="${2}"
  printf -- "IFS='' read -r -d '' '%s' <<'%s' || :\n" "$varName" "EOF" # Single quote means no interpolation
  shift 2
  while [ $# -gt 0 ]; do
    printf -- "%s%s\n" "$prefix" "$1"
    shift
  done
  printf -- "%s\n" "EOF"
}

#
# Usage: __dumpNameValuePrefix prefix name [ value0 value1 ... ]
# Argument: `prefix` - Literal string value to prefix each text line with
# Argument: `name` - Shell value to output
# Argument: `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner
#
__dumpNameValuePrefix() {
  local varName="${2}"
  printf -- "export '%s'; " "$varName"
  __dumpNameValuePrefixLocal "$@"
}

# This basically just does `a=${b}` in the output
#
# Summary: Assign one value to another in bash
# Usage: __dumpAliasedValue variable alias
# Argument: `variable` - shell variable to set
# Argument: `alias` - The shell variable to assign to `variable`
#
__dumpAliasedValue() {
  # SC2016 -- expressions do not expand in single quotes, yes, we know
  # shellcheck disable=SC2016
  printf -- 'export "%s"="%s%s%s"\n' "$1" '${' "$2" '}'
}

#
# Uses `bashDocumentation_FindFunctionDefinitions` to locate bash function, then
# extracts the comments preceding the function definition and converts it
# into a set of name/value pairs.
#
# A few special values are generated/computed:
#
# - `description` - Any line in the comment which is not in variable is appended to the field `description`
# - `fn` - The function name (no parenthesis or anything)
# - `base` - The basename of the file
# - `file` - The relative path name of the file from the application root
# - `summary` - Defaults to first ten words of `description`
# - `exit_code` - Defaults to `0 - Always succeeds`
# - `reviewed`  - Defaults to `Never`
# - `environment"  - Defaults to `No environment dependencies or modifications.`
#
# Otherwise the assumed variables (in addition to above) to define functions are:
#
# - `argument` - Individual arguments
# - `usage` - Canonical usage example (code)
# - `example` - An example of usage (code, many)
# - `depends` - Any dependencies (list)
#
# Summary: Generate a set of name/value pairs to document bash functions
# Argument: definitionFile - File. Required. File in which function is defined
# Argument: function - String. Required. Function defined in `file`
bashDocumentation_Extract() {
  local handler="_${FUNCNAME[0]}"
  local definitionFile fn

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  definitionFile=$(usageArgumentFile "$handler" "definitionFile" "${1-}") && shift || return $?
  fn=$(usageArgumentString "$handler" "fn" "${1-}") && shift || return $?

  set +o pipefail

  local home tempDoc docMap base clean=()

  home=$(__catch "$handler" buildHome) || return $?
  base="$(__catchEnvironment "$handler" basename "$definitionFile")" || return $?
  tempDoc=$(fileTemporaryName "$handler") || return $?
  docMap="$tempDoc.map"

  clean+=("$tempDoc" "$docMap")
  # Hides 'unused' messages so shellcheck should succeed
  printf '%s\n' '# shellcheck disable=SC2034'

  __catch "$handler" __dumpNameValue "applicationHome" "$home" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
  __catch "$handler" __dumpNameValue "applicationFile" "${definitionFile#"${home%/}"/}" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
  __catch "$handler" __dumpNameValue "file" "$definitionFile" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
  __catch "$handler" __dumpNameValue "base" "$base" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
  # just docMap
  __catch "$handler" __dumpNameValue "fn" "$fn" >>"$docMap" || returnClean $? "${clean[@]}" || return $?

  #
  # Search for our function and then capture all of the lines BEFORE it
  # which have a `#` character and then stop capture at the next blank line
  #
  __catch "$handler" bashFunctionComment "$definitionFile" "$fn" >"$tempDoc" || returnClean $? "${clean[@]}" || return $?

  local desc=() lastName="" values=() foundNames=() lastName=""
  local dumper line
  while IFS= read -r line; do
    local name="${line%%:*}" value
    if [ "$name" = "$line" ] || [ "${line%%:}" != "$line" ] || [ "${line##:}" != "$line" ]; then
      # no colon or ends with colon *or* starts with :
      # strip starting colon (end colon STAYS)
      value="${line##:}"
      if [ "${#desc[@]}" -gt 0 ] || [ "$(trimSpace "$value")" != "" ]; then
        desc+=("$value")
      fi
    else
      value="${line#*:}"
      value="${value# }"
      name="$(lowercase "$(printf '%s' "$name" | sed 's/[^A-Za-z0-9]/_/g')")"
      if [ "$name" = "description" ]; then
        if [ "$(trimSpace "$value")" != "" ]; then
          desc+=("$value")
        fi
        continue
      fi
      if [ -n "$lastName" ] && [ "$lastName" != "$name" ]; then
        if ! inArray "$lastName" "${foundNames[@]+${foundNames[@]}}"; then
          foundNames+=("$lastName")
          dumper=__dumpNameValue
        else
          dumper=__dumpNameValueAppend
        fi
        __catch "$handler" "$dumper" "$lastName" "${values[@]}" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
        values=()
      fi
      if inArray "$name" fn; then
        value="$(mapValue "$docMap" "$value")"
      fi
      values+=("$value")
      lastName="$name"
    fi
  done <"$tempDoc"

  if [ "${#values[@]}" -gt 0 ]; then
    if ! inArray "$lastName" "${foundNames[@]+"${foundNames[@]}"}"; then
      foundNames+=("$lastName")
      dumper=__dumpNameValue
    else
      dumper=__dumpNameValueAppend
    fi
    __catch "$handler" "$dumper" "$lastName" "${values[@]}" | tee -a "$docMap" || returnClean $? "${clean[@]}" || return $?
  fi
  __catch "$handler" rm -f "${clean[@]}" || return $?

  if [ "${#desc[@]}" -gt 0 ]; then
    __dumpNameValue "description" "${desc[@]}"
    printf "%s %s\n" "# Found Names:" "$(printf "%s " "${foundNames[@]+"${foundNames[@]}"}")"
    if ! inArray "summary" "${foundNames[@]+"${foundNames[@]}"}"; then
      local summary
      summary="$(trimWords 10 "${desc[0]}")"
      [ -n "$summary" ] || summary="undocumented"
      __dumpNameValue "summary" "$summary"
    fi
  elif inArray "summary" "${foundNames[@]+${foundNames[@]}}"; then
    __dumpAliasedValue description summary
  else
    __dumpNameValue "description" "No documentation for \`$fn\`."
    __dumpNameValue "summary" "undocumented"
  fi
  if ! inArray "exitCode" "${foundNames[@]+"${foundNames[@]}"}"; then
    __dumpNameValue "exitCode" '0 - Success' '1 - Environment error' '2 - Argument error' "" ""
  fi
  if ! inArray "fn" "${foundNames[@]+"${foundNames[@]}"}"; then
    __dumpNameValue "fn" "$fn"
  fi
  # Trims trailing space from `fn`
  printf '%s\n' "fn=\"\${fn%\$'\n'}\""
  if ! inArray "argument" "${foundNames[@]+${foundNames[@]}}"; then
    __dumpNameValue "argument" "none"
    __dumpAliasedValue "handler" "fn"
  else
    if ! inArray "handler" "${foundNames[@]+"${foundNames[@]}"}"; then
      __dumpAliasedValue handler argument
      printf "%s\n" "export handler; handler=\"\$fn\$(__bashDocumentationDefaultArguments \"\$handler\")\""
    fi
  fi
  __dumpNameValue "foundNames" "${foundNames[*]-}"

  printf "# DocMap: %s\n" "$docMap"
  printf "%s %s\n" "# Found Names:" "$(printf "%s " "${foundNames[@]+"${foundNames[@]}"}")"
}
_bashDocumentation_Extract() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Formats arguments for markdown
__bashDocumentationDefaultArguments() {
  printf "%s\n" "$*" | sed 's/ - /^/1' | usageFormatArguments '^' '' ''
}

#
# Finds one ore more function definition and outputs the file or files in which a
# function definition is found. Searches solely `.sh` files. (Bash or sh scripts)
#
# Note this function succeeds if it finds all occurrences of each function, but
# may output partial results with a failure.
#
# Usage: bashDocumentation_FindFunctionDefinitions directory fnName0 [ fnName1... ]
# Argument: `directory` - The directory to search
# Argument: `fnName0` - A function to find the file in which it is defined
# Argument: `fnName1...` - Additional functions are found are output as well
# Exit Code: 0 - if one or more function definitions are found
# Exit Code: 1 - if no function definitions are found
# Environment: Generates a temporary file which is removed
# Example:     bashDocumentation_FindFunctionDefinitions . bashDocumentation_FindFunctionDefinitions
# Example:     ./bin/build/tools/autodoc.sh
# Platform: `stat` is not cross-platform
# Summary: Find where a function is defined in a directory of shell scripts
#
bashDocumentation_FindFunctionDefinitions() {
  local handler="_${FUNCNAME[0]}"

  local directory

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  directory=$(usageArgumentDirectory "$handler" "directory" "${1-}") && shift || return $?

  local foundCount=0 phraseCount=${#@}
  while [ "$#" -gt 0 ]; do
    local fn=$1 file escaped
    escaped=$(quoteGrepPattern "$fn")
    local functionPattern="^$escaped\(\) \{|^function $escaped \{"
    while read -r file; do
      if grep -E -q -e "$functionPattern" "$file"; then
        printf "%s\n" "$file"
        foundCount=$((foundCount + 1))
      fi
    done < <(find "$directory" -type f -name '*.sh' ! -path "*/.*/*")
    shift
  done
  [ "$phraseCount" -eq "$foundCount" ]
}
_bashDocumentation_FindFunctionDefinitions() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Finds a function definition and outputs the file in which it is found
# Searches solely `.sh` files. (Bash or sh scripts)
#
# Succeeds IFF only one version of a function is found.
#
# Usage: bashDocumentation_FindFunctionDefinition directory fn
# Argument: `directory` - The directory to search
# Argument: `fn` - A function to find the file in which it is defined
# Exit Code: 0 - if one or more function definitions are found
# Exit Code: 1 - if no function definitions are found
# Environment: Generates a temporary file which is removed
# Example:     bashDocumentation_FindFunctionDefinition . handler
# Summary: Find single location where a function is defined in a directory of shell scripts
# See: bashDocumentation_FindFunctionDefinitions
bashDocumentation_FindFunctionDefinition() {
  local handler="_${FUNCNAME[0]}"
  local directory fn

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  directory=$(usageArgumentDirectory "$handler" "directory" "${1-}") && shift || return $?
  fn=$(usageArgumentString "$handler" "fn" "${1-}") && shift || return $?

  local definitionFile
  definitionFile=$(__catch "$handler" bashDocumentation_FindFunctionDefinitions "$directory" "$fn" | head -n 1) || return $?
  if [ -z "$definitionFile" ]; then
    __throwEnvironment "$handler" "No files found for $fn in $directory" || return $?
  fi
  printf "%s\n" "$definitionFile"
}
_bashDocumentation_FindFunctionDefinition() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Format code blocks (does markdown_FormatList)
#
_bashDocumentationFormatter_exit_code() {
  markdown_FormatList
}

#
# Format usage blocks (indents as a code block)
#
_bashDocumentationFormatter_usage() {
  decorate wrap "    "
}

# #
# # Format example blocks (indents as a code block)
# #
# _bashDocumentationFormatter_exampleFormat() {
#     markdown_FormatList
# }
_bashDocumentationFormatter_output() {
  decorate wrap "    "
}

#
# Format argument blocks (does markdown_FormatList)
#
_bashDocumentationFormatter_argument() {
  markdown_FormatList
}

#
# Format depends blocks (indents as a code block)
#
_bashDocumentationFormatter_depends() {
  decorate wrap "    "
}

#
# Format see block
#
_bashDocumentationFormatter_see() {
  local seeItem seeItems
  while IFS=" " read -r -a seeItems; do
    for seeItem in "${seeItems[@]+${seeItems[@]}}"; do
      seeItem="$(trimSpace "$seeItem")"
      if [ -n "$seeItem" ]; then
        printf "{SEE:%s}\n" "$seeItem"
      fi
    done
  done
}
