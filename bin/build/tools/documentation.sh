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
  usageDocumentComplex "$@"
}

# Summary: Universal error handler for functions
# Usage: usageDocument functionDefinitionFile functionName exitCode [ message ... ]
# Argument: functionDefinitionFile - Required. File. The file in which the function is defined. If you don't know, use `bashDocumentation_FindFunctionDefinitions` or `bashDocumentation_FindFunctionDefinition`.
# Argument: functionName - Required. String. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
# Argument: exitCode - Required. Integer. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
# Argument: message - Optional. String. A message.
#
# Generates console usage output for a script using documentation tools parsed from the comment of the function identified.
#
# Simplifies documentation and keeps it with the code.
#
# BUILD_DEBUG: fast-usage - `usageDocumentComplex` does not output formatted help for performance reasons
usageDocumentComplex() {
  local usage="_${FUNCNAME[0]}"

  local functionDefinitionFile="$1" functionName="$2" exitCode="${3-NONE}" home

  home=$(__catchEnvironment "$usage" buildHome) || return $?

  [ $# -ge 2 ] || __throwArgument "$usage" "Expected 2 arguments, got $#:$(printf -- " \"%s\"" "$@")" || return $?

  shift 3 || __throwArgument "$usage" "Missing arguments" || return $?

  if [ ! -f "$functionDefinitionFile" ]; then
    local tryFile="$home/$functionDefinitionFile"
    if [ ! -f "$tryFile" ]; then
      export PWD
      __catchArgument "$usage" "functionDefinitionFile $functionDefinitionFile (PWD: ${PWD-}) (Build home: \"$home\") not found" || return $?
    fi
    functionDefinitionFile="$tryFile"
  fi
  [ -n "$functionName" ] || __throwArgument "$usage" "functionName is blank" || return $?

  if [ "$exitCode" = "NONE" ]; then
    decorate error "NO EXIT CODE" 1>&2
    exitCode=1
  fi
  __catchArgument "$usage" isInteger "$exitCode" || __catchArgument "$usage" "$(debuggingStack)" || return $?

  local color="success"
  case "$exitCode" in
    0 | 2)
      if buildDebugEnabled "fast-usage"; then
        [ "$exitCode" -eq 0 ] || exec 1>&2 && color="warning"
        printf -- "%s%s %s\n" "$(decorate value "[$exitCode]")" "$(decorate code " $functionName ")" "$(decorate "$color" "$@")"
        return "$exitCode"
      fi
      ;;
    *)
      [ "$exitCode" -eq 0 ] || exec 1>&2 && color="error"
      printf -- "%s%s %s\n" "$(decorate value "[$exitCode]")" "$(decorate code " $functionName ")" "$(decorate "$color" "$@")"
      return "$exitCode"
      ;;
  esac

  local variablesFile
  variablesFile=$(fileTemporaryName "$usage") || return $?
  if ! bashDocumentation_Extract "$functionDefinitionFile" "$functionName" >"$variablesFile"; then
    dumpPipe "variablesFile" <"$variablesFile"
    __throwArgument "$usage" "Unable to extract \"$functionName\" from \"$functionDefinitionFile\"" || _clean $? "$variablesFile" || return $?
  fi
  (
    local description="" argument="" base exit_code=""

    set -a
    base="$(basename "$functionDefinitionFile")"
    # shellcheck source=/dev/null
    source "$variablesFile"
    set +a

    [ "$exitCode" -eq 0 ] || exec 1>&2 && color="error"
    local bashDebug=false
    if isBashDebug; then
      bashDebug=true
      # Hides a lot of unnecessary tracing
      __buildDebugDisable
    fi
    bashRecursionDebug
    if [ -n "$exit_code" ]; then
      local formatted
      formatted="$(printf "%s\n%s\n" "Exit codes:" "$(decorate wrap "- " "" <<<"$(trimSpace "$exit_code")")")"
      description="$(trimTail <<<"$description")"$'\n'$'\n'"$formatted"
    fi
    usageTemplate "$(mapEnvironment <<<"$fn")" "$(printf "%s\n" "$argument" | sed 's/ - /^/1')" "^" "$description" "$exitCode" "$@"
    if $bashDebug; then
      __buildDebugEnable
    fi
    bashRecursionDebug --end
  )
  return "$exitCode"
}
_usageDocumentComplex() {
  # _IDENTICAL_ usageDocumentSimple 1
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# IDENTICAL usageDocumentSimple 19

# Output a simple error message for a function
# Argument: source - File. Required. File where documentation exists.
# Argument: function - String. Required. Function to document.
# Argument: returnCode - UnsignedInteger. Required. Exit code to return.
# Argument: message ... - Optional. String. Message to display to the user.
# Requires: bashFunctionComment decorate read printf exitString
usageDocumentSimple() {
  local source="${1-}" functionName="${2-}" exitCode="${3-}" color helpColor="info" icon="❌" line prefix="" skip=false && shift 3

  case "$exitCode" in 0) icon="🏆" && color="info" && [ $# -ne 0 ] || skip=true ;; 1) color="error" ;; 2) color="bold-red" ;; *) color="orange" ;; esac
  [ $# -eq 0 ] || [ "$exitCode" -ne 0 ]
  $skip || printf -- "%s [%s] %s\n" "$icon" "$(decorate "code" "$(exitString "$exitCode")")" "$(decorate "$color" "$*")"
  while read -r line; do
    printf "%s%s\n" "$prefix" "$(decorate "$helpColor" "$line")"
    prefix=""
  done < <(bashFunctionComment "$source" "$functionName")
  return "$exitCode"
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
# Requires: basename decorate statusMessage fileTemporaryName rm grep cut source mapTokens _clean
# Requires: mapEnvironment shaPipe printf
documentationTemplateCompile() {
  local usage="_${FUNCNAME[0]}"

  local cacheDirectory="" documentTemplate="" functionTemplate="" targetFile=""
  local start mappedDocumentTemplate checkFiles forceFlag
  local compiledFunctionTarget tokenNames message
  local targetDirectory settingsFile base envFiles envFileArgs envFile
  local tokenName documentTokensFile envChecksum envChecksumCache compiledTemplateCache

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

  forceFlag=false
  envFiles=()
  envFileArgs=()
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
      --env-file)
        shift
        envFile=$(usageArgumentFile "$usage" "envFile" "$1") || return $?
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
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # Validate arguments
  cacheDirectory=$(usageArgumentDirectory "$usage" cacheDirectory "$cacheDirectory") || return $?
  documentTemplate="$(usageArgumentFile "$usage" documentTemplate "$documentTemplate")" || return $?
  functionTemplate="$(usageArgumentFile "$usage" functionTemplate "$functionTemplate")" || return $?
  targetFile="$(usageArgumentFileDirectory "$usage" targetFile "$targetFile")" || return $?

  # echo cacheDirectory="$cacheDirectory"
  # echo documentTemplate="$documentTemplate"
  # echo functionTemplate="$functionTemplate"
  # echo targetFile="$targetFile"

  base="$(basename "$targetFile")" || __throwArgument "$usage" basename "$targetFile" || return $?
  base="${base%%.md}"
  statusMessage decorate info "Generating $(decorate code "$base") $(decorate info "...")"

  local clean=()
  documentTokensFile=$(fileTemporaryName "$usage") || return $?
  clean+=("$documentTokensFile")

  mappedDocumentTemplate=$(fileTemporaryName "$usage") || _clean $? "${clean[@]}" return $?

  clean+=("$mappedDocumentTemplate")

  if ! envChecksum=$(
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
    __throwEnvironment "$usage" "mapTokens failed" || _clean $? "${clean[@]}" return $?
  fi
  if ! mapTokens <"$mappedDocumentTemplate" >"$documentTokensFile"; then
    __throwEnvironment "$usage" "mapTokens failed" || _clean $? "${clean[@]}" return $?
  fi
  #
  # Look at source file for each function
  #
  if ! envChecksumCache=$(requireDirectory "$cacheDirectory/envChecksum"); then
    __throwEnvironment "$usage" "create $cacheDirectory/envChecksum failed" || _clean $? "${clean[@]}" || return $?
  fi
  envChecksumCache="$envChecksumCache/$envChecksum"
  if [ ! -f "$envChecksumCache" ]; then
    touch "$envChecksumCache"
  fi
  compiledTemplateCache=$(__catchEnvironment "$usage" requireDirectory "$cacheDirectory/compiledTemplateCache") || _clean $? "${clean[@]}" || return $?
  # Environment change will affect this template
  # Function template change will affect this template

  # As well, document template change will affect this template
  if [ $(($(wc -l <"$documentTokensFile") + 0)) -eq 0 ]; then
    if [ ! -f "$targetFile" ] || ! diff -q "$mappedDocumentTemplate" "$targetFile" >/dev/null; then
      printf "%s (mapped) -> %s %s" "$(decorate warning "$documentTemplate")" "$(decorate success "$targetFile")" "$(decorate error "(no tokens found)")"
      __catchEnvironment "$usage" cp "$mappedDocumentTemplate" "$targetFile" || _clean $? "${clean[@]}" || return $?
    fi
  else
    local checkTokens=()
    checkFiles=()
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
    if $forceFlag || isEmptyFile "$targetFile" || ! isNewestFile "$targetFile" "${checkFiles[@]+"${checkFiles[@]}"}" "$documentTemplate"; then
      message="Generated"
      compiledFunctionEnv=$(fileTemporaryName "$usage") || return $?
      # subshell to hide environment tokens
      while read -r tokenName; do
        compiledFunctionTarget="$compiledTemplateCache/$tokenName"
        if ! settingsFile=$(documentationIndex_Lookup --source "$cacheDirectory" "$tokenName"); then
          __catchEnvironment "$usage" printf "%s\n" "Function not found: $tokenName" >"$compiledFunctionTarget" || _clean $? "${clean[@]}" || return $?
          continue
        fi
        if ! $forceFlag && [ -f "$compiledFunctionTarget" ] && isNewestFile "$compiledFunctionTarget" "$settingsFile" "$envChecksumCache" "$functionTemplate"; then
          statusMessage decorate info "Skip $tokenName and use cache"
        else
          __catchEnvironment "$usage" documentationTemplateFunctionCompile "${envFileArgs[@]+${envFileArgs[@]}}" "$cacheDirectory" "$tokenName" "$functionTemplate" | trimTail >"$compiledFunctionTarget" || _clean $? "${clean[@]}" || return $?
          __catchEnvironment "$usage" printf "\n" >>"$compiledFunctionTarget" || _clean $? "${clean[@]}" || return $?
        fi
        environmentValueWrite "$tokenName" "$(cat "$compiledFunctionTarget")" >>"$compiledFunctionEnv"
      done <"$documentTokensFile"

      IFS=$'\n' read -r -d '' -a tokenNames <"$documentTokensFile"
      statusMessage decorate success "Writing $targetFile using $documentTemplate (mapped) ..."
      (
        set -a
        #shellcheck source=/dev/null
        source "$compiledFunctionEnv" || __throwEnvironment "$usage" "source $compiledFunctionEnv compiled for $targetFile" || return $?
        mapEnvironment "${tokenNames[@]}" <"$mappedDocumentTemplate" >"$targetFile"
      ) || __throwEnvironment "$usage" "mapEnvironment $tokenName" || _clean $? "${clean[@]}" || return $?
      __catchEnvironment "$usage" cp "$compiledFunctionEnv" "$envChecksumCache" || return $?
    else
      message="Cached"
    fi
  fi
  __catchEnvironment "$usage" rm -rf "${clean[@]}" || return $?
  statusMessage decorate info "$(timingReport "$start" "$message" "$targetFile" in)"
}
_documentationTemplateCompile() {
  usageDocument "${BASH_SOURCE[0]}" "documentationTemplateCompile" "$@"
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
  local usage="_${FUNCNAME[0]}"

  local cacheDirectory="" functionName="" functionTemplate="" envFiles=()

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
      --env-file)
        shift
        envFile=$(usageArgumentFile "$usage" "envFile" "$1") || return $?
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
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local settingsFile

  # Validate arguments
  cacheDirectory=$(usageArgumentDirectory "$usage" cacheDirectory "$cacheDirectory") || return $?
  functionName="$(usageArgumentString "$usage" functionName "$functionName")" || return $?
  functionTemplate="$(usageArgumentFile "$usage" functionTemplate "$functionTemplate")" || return $?
  settingsFile=$(documentationIndex_Lookup "$cacheDirectory" "$functionName") || __throwEnvironment "$usage" "Unable to find \"$functionName\" (using index \"$cacheDirectory\")" || return $?

  __catchEnvironment "$usage" _bashDocumentation_Template "$functionTemplate" "${envFiles[@]+"${envFiles[@]}"}" "$settingsFile" || return $?
}
_documentationTemplateFunctionCompile() {
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
  local usage="_${FUNCNAME[0]}"

  local cacheDirectory="" templateDirectory="" functionTemplate="" targetDirectory=""
  local passArgs=() filterArgs=()
  local verboseFlag=false

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
        shift || __throwArgument "$usage" "missing $argument argument" || return $?
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
          # _IDENTICAL_ argumentUnknown 1
          __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
        fi
        ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  # IDENTICAL startBeginTiming 1
  start=$(timingStart) || return $?

  local cacheDirectory templateDirectory functionTemplate targetDirectory

  cacheDirectory=$(usageArgumentDirectory "$usage" "cacheDirectory" "$cacheDirectory") || return $?
  templateDirectory=$(usageArgumentDirectory "$usage" "templateDirectory" "$templateDirectory") || return $?
  functionTemplate=$(usageArgumentFile "$usage" "functionTemplate" "$functionTemplate") || return $?
  targetDirectory=$(usageArgumentDirectory "$usage" "targetDirectory" "$targetDirectory") || return $?

  ! $verboseFlag || decorate pair cacheDirectory "$cacheDirectory"
  ! $verboseFlag || decorate pair templateDirectory "$templateDirectory"
  ! $verboseFlag || decorate pair functionTemplate "$functionTemplate"
  ! $verboseFlag || decorate pair targetDirectory "$targetDirectory"

  local exitCode=0 fileCount=0 templateFile=""
  while read -r templateFile; do
    local base="${templateFile#"$templateDirectory/"}"
    [ "$base" != "$templateFile" ] || __throwEnvironment "$usage" "templateFile $(decorate file "$templateFile") is not within $(decorate file "$templateDirectory")" || return $?
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
  local usage="_${FUNCNAME[0]}"
  local envFile file=$1 fn=$2 template=$3 home exitCode

  [ -f "$template" ] || __throwArgument "$usage" "$template is not a file" || return $?
  envFile=$(fileTemporaryName "$usage") || return $?
  __catchEnvironment "$usage" printf "%s\n%s\n" "#!/usr/bin/env bash" "%s\n" "set -eou pipefail" >>"$envFile" || return $?
  if ! bashDocumentation_Extract "$file" "$fn" >>"$envFile"; then
    __dumpNameValue "error" "$fn was not found" >>"$envFile"
  fi
  _bashDocumentation_Template "$template" "$envFile"
  exitCode=$?
  __catchEnvironment "$usage" rm -rf "$envFile" || return $?
  return $exitCode
}
_bashDocumentFunction() {
  # _IDENTICAL_ usageDocument 1
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
# - `reviewed"  - Defaults to `Never`
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
# Usage: {fn} definitionFile function
# Argument: `definitionFile` - File in which function is defined
# Argument: `function` - Function defined in `file`
#
bashDocumentation_Extract() {
  local usage="_${FUNCNAME[0]}"
  local definitionFile="$1" fn="$2" definitionFile
  local home tempDoc docMap base

  [ -f "$definitionFile" ] || __throwArgument "$usage" "$definitionFile is not a file" || return $?
  [ -n "$fn" ] || __throwArgument "function name is blank" || return $?

  set +o pipefail

  home=$(__catchEnvironment "$usage" buildHome) || return $?
  base="$(__catchEnvironment "$usage" basename "$definitionFile")" || return $?
  tempDoc=$(fileTemporaryName "$usage") || return $?
  docMap=$(fileTemporaryName "$usage") || return $?

  # Hides 'unused' messages so shellcheck should succeed
  printf '%s\n' '# shellcheck disable=SC2034'

  __dumpNameValue "applicationHome" "$home" | tee -a "$docMap"
  __dumpNameValue "applicationFile" "${definitionFile#"${home%/}"/}" | tee -a "$docMap"
  __dumpNameValue "file" "$definitionFile" | tee -a "$docMap"
  __dumpNameValue "base" "$base" | tee -a "$docMap"
  __dumpNameValue "fn" "$fn" >>"$docMap" # just docMap

  #
  # Search for our function and then capture all of the lines BEFORE it
  # which have a `#` character and then stop capture at the next blank line
  #
  __catchEnvironment "$usage" bashFunctionComment "$definitionFile" "$fn" >"$tempDoc" || return $?

  local desc=() lastName="" values=() foundNames=() lastName="" dumper line
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
        "$dumper" "$lastName" "${values[@]}" | tee -a "$docMap"
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
    "$dumper" "$lastName" "${values[@]}" | tee -a "$docMap"
  fi
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
  if ! inArray "exit_code" "${foundNames[@]+"${foundNames[@]}"}"; then
    __dumpNameValue "exit_code" '0 - Success' '1 - Environment error' '2 - Argument error' "" ""
  fi
  if ! inArray "fn" "${foundNames[@]+"${foundNames[@]}"}"; then
    __dumpNameValue "fn" "$fn"
  fi
  # Trims trailing space from `fn`
  printf '%s\n' "fn=\"\${fn%\$'\n'}\""
  if ! inArray "argument" "${foundNames[@]+${foundNames[@]}}"; then
    __dumpNameValue "argument" "No arguments."
    __dumpAliasedValue "usage" "fn"
  else
    if ! inArray "usage" "${foundNames[@]+"${foundNames[@]}"}"; then
      __dumpAliasedValue usage argument
      printf "%s\n" "export usage; usage=\"\$fn\$(__bashDocumentationDefaultArguments \"\$usage\")\""
    fi
  fi
  __dumpNameValue "foundNames" "${foundNames[*]-}"

  printf "# DocMap: %s\n" "$docMap"
  printf "%s %s\n" "# Found Names:" "$(printf "%s " "${foundNames[@]+"${foundNames[@]}"}")"
}
_bashDocumentation_Extract() {
  # _IDENTICAL_ usageDocumentSimple 1
  usageDocumentSimple "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  local directory="${1%%/}"
  local functionPattern fn linesOutput phraseCount f

  shift
  phraseCount=${#@}
  foundOne=$(mktemp)
  while [ "$#" -gt 0 ]; do
    fn=$1
    functionPattern="^$fn\(\) \{|^function $fn \{"
    find "$directory" -type f -name '*.sh' ! -path "*/.*/*" | while read -r f; do
      if grep -E -q "$functionPattern" "$f"; then
        printf "%s\n" "$f"
      fi
    done
    shift
  done | tee "$foundOne"
  linesOutput=$(wc -l <"$foundOne")
  [ "$phraseCount" -eq "$linesOutput" ]
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
# Example:     bashDocumentation_FindFunctionDefinition . usage
# Summary: Find single location where a function is defined in a directory of shell scripts
# See: bashDocumentation_FindFunctionDefinitions
bashDocumentation_FindFunctionDefinition() {
  local definitionFiles directory="${1%%/}" fn="$2"

  [ -d "$directory" ] || _argument "$directory is not a directory" || return $?
  [ -n "$fn" ] || _argument "Need a function to find is not a directory" || return $?

  definitionFiles=$(mktemp)
  if ! bashDocumentation_FindFunctionDefinitions "$directory" "$fn" >"$definitionFiles"; then
    rm "$definitionFiles"
    _environment "$fn not found in $directory" || return $?
  fi
  definitionFile="$(head -1 "$definitionFiles")"
  rm "$definitionFiles"
  if [ -z "$definitionFile" ]; then
    _environment "No files found for $fn in $directory" || return $?
  fi
  printf %s "$definitionFile"
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
  done || :
}
