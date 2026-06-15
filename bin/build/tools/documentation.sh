#!/usr/bin/env bash
#
# documentation.sh
#
# Tools to help with documentation of shell scripts. Very simple mechanism to extract
# documentation from code. Note that bash makes a terrible template engine, but
# having no language dependencies outweighs the negatives.
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

#       _                                       _        _   _
#    __| | ___   ___ _   _ _ __ ___   ___ _ __ | |_ __ _| |_(_) ___  _ __
#   / _` |/ _ \ / __| | | | '_ ` _ \ / _ \ '_ \| __/ _` | __| |/ _ \| '_ \
#  | (_| | (_) | (__| |_| | | | | | |  __/ | | | || (_| | |_| | (_) | | | |
#   \__,_|\___/ \___|\__,_|_| |_| |_|\___|_| |_|\__\__,_|\__|_|\___/|_| |_|
#

__documentationLoader() {
  __buildFunctionLoader __bashDocumentationExtract documentation "$@" || return $?
}

# Summary: Extract documentation from bash comments
# Extract documentation variables from a comment stripped of the `# ` prefixes.
#
# Usage: {fn} [ --generate ] [ --no-cache | --cache ] [ --help ] handler function sourceFile
#
# A few special values are generated/computed:
#
# - `description` - Any line in the comment which is not in variable is appended to the field `description`
# - `fn` - The function name (no parenthesis or anything)
# - `base` - The basename of the file
# - `file` - The relative path name of the file from the application root
# - `summary` - Defaults to first ten words of `description`
# - `exit_code` - Defaults to standard value
# - `reviewed`  - No default
# - `environment"  - No default
# - `usage` - Computed based on arguments
#
# Otherwise the assumed variables (in addition to above) to define functions are:
#
# - `argument` - Individual arguments
# - `example` - An example of usage (code, many)
# - `depends` - Any dependencies (list)
#
# Summary: Generate a set of name/value pairs to document bash entities
# Argument: fn - String. Required. Name of `fn`
# Argument: sourceFile - File. Required.
# Argument: sourceLine - PositiveInteger. Optional.
# Argument: --generate - Flag. Optional. Generate cached files.
# Argument: --no-cache - Flag. Optional. Skip any attempt to cache anything.
# Argument: --cache - Flag. Optional. Force use of cache.
# Argument: --function - Flag. Optional. Function derivations `return_code` `fn` `lowerFn` `fnMarker` `argument` `usage`
# Argument: --environment - Flag. Optional. Environment variable derivations `env` `envMarker`
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# stdin: Pipe stripped comments to extract information
# BUILD_DEBUG: usage-cache-skip - Skip caching by default (override with `--cache`)
bashDocumentationExtract() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashDocumentationExtract() {
  # __IDENTICAL__ bashSimpleDocumentation 1
  bashSimpleDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Make documentation for Bash functions
#
# Must faster than `documentationBuild` and intended to replace it.
#
# Uses cached files at `BUILD_DOCUMENTATION_PATH`, assumes documentation cache structure:
#
# - `$docHome/functionName.md` - Markdown documentation
# - `$docHome/SEE/functionName.md` - Markdown documentation for `{SEE:functionName}`
# - `$docHome/functionName.sh` - `functionName` settings
# - `$docHome/env/environmentName.md` - Markdown documentation for `environmentName` environment variable
# - `$docHome/env/environmentName.sh` - `environmentName` environment variable settings
# - `$docHome/env/more/environmentName.md` - Additional Markdown documentation for `environmentName` environment variable
# - `$docHome/SEE/environmentName.md` - See link to `environmentName`
#
# Argument: --clean - Flag. Optional. Erase the cache before starting.
#
# Argument: --template templateDirectory - Directory. Required. Location of additional documentation template files to generate documentation.
# Argument: --source sourceDirectory - Directory. Required. Location of documentation source markdown.
# Argument: --target targetDirectory - Directory. Required. Location of documentation build target.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 0 - Success
# Return Code: 1 - Issue with environment
# Return Code: 2 - Argument error
documentationMake() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationMake() {
  case "${1-}" in 0 | 2 | "") ;; *) hookRunOptional documentation-error "$@" || : ;; esac
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List unlinked functions in documentation index
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
documentationUnlinked() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationUnlinked() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get an internal template name
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
documentationTemplate() {
  [ "${1-}" != "--help" ] || helpArgument "_${FUNCNAME[0]}" "$@" || return 0
  local source="${BASH_SOURCE[0]%.sh}"
  local template="$source/__${1-}.md"

  [ -f "$template" ] || returnArgument "No template \"${1-}\" at $template" || return $?
  printf "%s\n" "$template"
}
_documentationTemplate() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Build documentation files for environment variables
#
# Build documentation for `./bin/env` (or `bin/build/env`) directory.
#
# Creates a cache at `documentationCache`
#
# Environment template files used:
#
# - `line.md`
# - `see.md`
# - `more.md`
# - `more-header.md`
# - `more-footer.md`
#
# Variables applied to the environment template files:
#
# - `link` `name` `description` `category` `more` `type` `markerName`
#
# Documentation Files generated:
#
# - `ENV_NAME.md` - Documentation page for `ENV_NAME`
# - `SEE/ENV_NAME.md` - `{SEE:ENV_NAME}` content
# - `env/ENV_NAME.sh` - Settings extracted from environment file.
# - `env/ENV_NAME.md` - Documentation line for `ENV_NAME`
# - `env/more/ENV_NAME.md` - Documentation more for `ENV_NAME`. Only created if needed.
#
# Documentation settings extracted:
#
# - `name` - `String`. Display environment name.
# - `description` - `String`. Text description of the environment variable, many lines long and can include detailed example and markup.
# - `descriptionLineCount` - `PositiveInteger`. Number of lines in the description.
# - `summary` - `String`. Short description of the environment variable.
# - `category` - `String`. Main category for this environment variable.
# - `categoryId` - `String`. Category converted to stringLowercase and spaces replaced with underscores.
# - `type` - `Type`. Data type for this environment variable.
#
# Where `ENV_NAME` matches the found environment source file without the `.sh`.
#
# Target templates created:
#
# - `categories.txt`
# - `environmentCategoryList.md`
# - `environmentCategoryTotal.md`
# - `environmentMore.md`
#
# Argument: --source sourcePath - Directory. Optional. Path to source environment files (`*.sh` files). Defaults to `$(buildHome)/bin/env` if not specified.
# Argument: --template templatePath - Directory. Optional. Path for environment template files.
# Argument: --target targetPath - Directory. Optional. Path for generated documentation files.
# Argument: --clean - Flag. Optional. Delete any generated files amd exit.
# Argument: --force - Flag. Optional. Force generation of files regardless of cache status.
# Argument: --verbose - Flag. Optional. Be chatty.
# Argument: --link linkURI - String. Optional. Sets the `link` variable in templates. Defaults to `/env/`.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Environment: BUILD_DOCUMENTATION_PATH
#
# Return Code: 0 - Success
# Return Code: 1 - Issue with environment
# Return Code: 2 - Argument error
documentationEnvironmentMake() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationEnvironmentMake() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Convert an environment comment to environment variables
# Argument: environmentFile - EnvironmentFile. Required. File to convert to a settings file.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
documentationEnvironmentFileParse() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationEnvironmentFileParse() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the default cache directory for the documentation
# Argument: suffix - String. Optional. Directory suffix - created if does not exist.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
documentationCache() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local code && code=$(catchReturn "$handler" buildEnvironmentGet "APPLICATION_CODE") || return $?
  local suffix=".documentation/${code-default}/${1-}"

  if [ -n "${DOCUMENTATION_SHM-}" ] && booleanParse "${DOCUMENTATION_SHM-}"; then
    local shmDir="/dev/shm"
    [ -d "$shmDir" ] || throwEnvironment "$handler" "DOCUMENTATION_SHM enabled but no $shmDir"
    directoryRequire "$shmDir/$suffix"
  else
    catchReturn "$handler" buildCacheDirectory "$suffix" || return $?
  fi
}
_documentationCache() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Map template files using our identical functionality
# Argument: templatePath - Directory. Required. Path to the templates to repair.
# Argument: repairPath ... - Directory. Required. One or more directories containing IDENTICAL sources for repair.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
documentationIdenticalRepair() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationIdenticalRepair() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Generate a function documentation block using `functionTemplate` for `functionName`
#
# Requires function indexes to be generated in the documentation cache.
#
# Generate documentation for a single function.
#
# Template is output to stdout.
#
# Return Code: 0 - If success
# Return Code: 1 - Issue with file generation
# Return Code: 2 - Argument error
# Argument: --env-file envFile - File. Optional. One (or more) environment files used during map of `functionTemplate`
# Argument: functionName - Required. The function name to document.
# Argument: functionTemplate - Required. The template for individual functions.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
documentationTemplateFunctionCompile() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationTemplateFunctionCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Formats arguments for markdown
# Used in documentation caches
__bashDocumentationDefaultArguments() {
  printf "%s\n" "$*" | sed 's/ - /^/1' | __documentationFormatArguments '^' '' ''
}

# Parses input stream and generates an argument documentation list
# Input is in the format with "{argument}{delimiter}{description}{newline}" and generates a list of arguments (optionally decorated) color-coded based
# on whether the word "require" appears in the description.
# INTERNAL: This is solely used internally but should be accessible globally as it is used here and in `usage`
# Argument: delimiter - String. Required. The character to separate name value pairs in the input
__documentationFormatArguments() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0

  [ $# -le 3 ] || throwArgument "$handler" "Requires 3 or fewer arguments" || return $?

  local separatorChar="${1-" "}" optionalDecoration="${2-blue}" requiredDecoration="${3-magenta}"

  local lineTokens=() lastLine=false
  while true; do
    if ! IFS="$separatorChar" read -r -a lineTokens; then
      lastLine=true
    fi
    if [ ${#lineTokens[@]} -gt 0 ]; then
      local __value="${lineTokens[0]}"

      # printf "lineTokens-0: %s\n" "${lineTokens[@]}"
      unset "lineTokens[0]"
      # printf "lineTokens-1: %s\n" "${lineTokens[@]}"
      lineTokens=("${lineTokens[@]+${lineTokens[@]}}")
      local __description
      # printf "lineTokens-2: %s\n" "${lineTokens[@]}"
      __description=$(stringLowercase "${lineTokens[*]-}")
      # Looks for `Required.` in the description
      if [ "${__description%*required.*}" = "$__description" ]; then
        __value="[ $__value ]"
        [ -z "$optionalDecoration" ] || __value="$(decorate "$optionalDecoration" "$__value")"
      else
        [ -z "$requiredDecoration" ] || __value="$(decorate BOLD "$requiredDecoration" "$__value")"
      fi
      printf " %s" "$__value"
    fi
    if $lastLine; then
      break
    fi
  done
}
___documentationFormatArguments() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Looks up information in the function index
##
# Argument: --settings - Flag. Optional. `matchText` is a function name. Outputs a file name containing function settings
# Argument: --comment - Flag. Optional. `matchText` is a function name. Outputs a file name containing function settings
# Argument: --source - Flag. Optional. `matchText` is a function name. Outputs the source code path to where the function is defined
# Argument: --line - Flag. Optional. `matchText` is a function name. Outputs the source code line where the function is defined
# Argument: --combined - Flag. Optional. `matchText` is a function name. Outputs the source code path and line where the function is defined as `path:line`
# Argument: --file - Flag. Optional. `matchText` is a file name. Find files which match this base file name.
# Argument: matchText - String. Token to look up in the index.
documentationIndexLookup() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationIndexLookup() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Generate the documentation index
# Indexes where functions are defined in documentation (e.g. `*.md` files - markdown files).
# Finds the appropriate token `{funcName}` and generates an index for linking or other purposes.
#
# Argument: --target targetDirectory - Directory. Optional. Directory where the index will be created. Uses `documentationCache` if not specified.
# Argument: documentationSource ... - Directory. OneOrMore. Documentation source path to find tokens and their definitions.
# Argument: --verbose - Flag. Optional. Extrapolate needlessly.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Return Code: 0 - If success
# Return Code: 1 - Issue with file generation
# Return Code: 2 - Argument error
documentationIndexDocumentation() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationIndexDocumentation() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Generate a function index for bash files.
#
# Argument: codePath ... - Directory. Required. OneOrMore. Path where code (`.sh` files) is stored (should remain identical between invocations)
# Argument: --target targetPath - Optional. Location to store the index file, called `code.index`.
# Argument: --verbose - Flag. Optional. Talk voluminously.
# See: __documentationIndexLookup
# Requires: __pcregrep
documentationIndexGenerate() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationIndexGenerate() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Finds one ore more function definition and outputs the file or files in which a
# function definition is found. Searches solely `.sh` files. (Bash or sh scripts)
#
# Note this function succeeds if it finds all occurrences of each function, but
# may output partial results with a failure.
#
# Argument: `directory` - Directory. Required. The directory to search
# Argument: `fnName0` - String. Required. A function to find the file in which it is defined
# Argument: `fnName1...` - String. Optional. Additional functions are found are output as well
# Return Code: 0 - if one or more function definitions are found
# Return Code: 1 - if no function definitions are found
# Example:     __bashDocumentation_FindFunctionDefinitions . __bashDocumentation_FindFunctionDefinitions
# Example:     ./bin/build/tools/autodoc.sh
# Platform: `stat` is not cross-platform
# Summary: Find where a function is defined in a directory of shell scripts
__bashDocumentation_FindFunctionDefinitions() {
  local handler="_${FUNCNAME[0]}"

  [ "${1-}" != "--help" ] || helpArgument "$handler" "$@" || return 0
  local directory && directory=$(validate "$handler" Directory "directory" "${1-}") && shift || return $?

  local foundCount=0 phraseCount=${#@}
  while [ "$#" -gt 0 ]; do
    local fn=$1 escaped
    escaped=$(quoteGrepPattern "$fn")
    local functionPattern="^$escaped\(\) \{|^function $escaped \{"
    if find "$directory" -type f -name '*.sh' ! -path "*/.*/*" -print0 | xargs -0 grep -l -E "$functionPattern"; then
      foundCount=$((foundCount + 1))
    fi
    shift
  done
  [ "$phraseCount" -eq "$foundCount" ]
}
___bashDocumentation_FindFunctionDefinitions() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List functions without documentation pages.
# Argument: indexPath - Directory. Required. Index path.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
documentationIndexUnlinkedFunctions() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationIndexUnlinkedFunctions() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Document an item and generate a template (markdown). To custom format any
# of the fields in this, write functions in the form `_documentationTemplateFormatter_${name}` such that
# name matches the variable name (lower case alphanumeric characters and underscores).
#
# Filter functions should modify the input/output pipe; an example can be found by looking at
# sample function `_documentationTemplateFormatter_return_code`.
#
# See: _documentationTemplateFormatter_return_code
# Argument: template - Required. A markdown template to use to map values. Post-processed with `markdownRemoveUnfinishedSections`
# Argument: settingsFile - Required. Settings file to be loaded.
# Return Code: 0 - Success
# Return Code: 1 - Template file not found
# Short description: Simple markdown documentation templates
documentationTemplateCompile() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationTemplateCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Generate documentation using source markdown and a mapping function.
#
# Argument: --verbose - Flag. Optional. Be wordy.
# Argument: --default defaultValue - EmptyString. Optional. Pass `--default` flag to `mapFunction`
# Argument: sourcePath - Exists. Required. File or directory to convert.
# Argument: targetPath - FileDirectory. Optional. Outputs to `stdout` if not specified, otherwise outputs mirror.
# Argument: mapFunction ... - Function. Optional. Mapping function to use, and any arguments.
# Return Code: 0 - Success
# Return Code: 1 - Template file not found
documentationMaker() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationMaker() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Extract and build the documentation settings cache and generate derived files
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --all | --stdin- Flag. Optional. Read function names from stdin for examination.
# Argument: --fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.
# Argument: --source - Directory. Required. Directory where functions are defined.
# Argument: --key fingerprintKey - String. Optional. Use this name to cache results in application JSON file if available.
# Argument: functionName ... - String. Optional. Specific functions to compile.
# stdin: Function. Name of functions, one per line to compile if `--all` is not specified.
documentationFunctionsCompile() {
  local handler="_${FUNCNAME[0]}" aa=() allFlag=false source="" target=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --all | --stdin) allFlag=true ;;
    --target) shift && target=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --source) shift && source=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    --key) shift && aa+=("$argument" "${1-}") ;;
    *) aa+=("$1") ;;
    esac
    shift
  done

  [ -n "$source" ] || throwArgument "$handler" "source is required" || return $?
  aa=(--handler "$handler" --source "$source" "${aa[@]+"${aa[@]}"}")
  if $allFlag; then
    # uses stdin
    documentationFunctionCompile "${aa[@]}" "$@" || return $?
  else
    [ -n "$target" ] || throwArgument "$target" "target is required unless you supply --all" || return $?

    local funFile && funFile=$(fileTemporaryName "$handler") || return $?
    local clean=("$funFile")
    # local sourceTimestamp _ && read -r sourceTimestamp _ < <(catchReturn "$handler" fileModifiedRecently "$source") || returnClean $? "${clean[@]}" || return $?
    local targetTimestamp && read -r targetTimestamp _ < <(catchReturn "$handler" fileModifiedRecently "$target") || returnClean $? "${clean[@]}" || return $?
    local changed=() && IFS=$'\n' read -r -d "" -a changed < <(fileModificationTimesAfter "$source" "$targetTimestamp" -name '*.sh' | textRemoveFields 1)
    if [ "${#changed[@]}" -gt 0 ]; then
      local changedFile && for changedFile in "${changed[@]}"; do
        bashListFunctions <"$changedFile" | grepSafe -v '^_' >>"$funFile"
      done
    fi
    local missingFunction && while read -r missingFunction; do
      ! muzzle __documentationFile "$home" "$missingFunction" || continue
      ! muzzle __documentationFile "SEE/$home" "$missingFunction" || continue
      printf "%s\n" "$missingFunction" >>"$funFile"
    done < <(buildFunctions)
    if fileIsEmpty "$funFile"; then
      statusMessage --last decorate success "Up to date."
      catchReturn "$handler" rm -f "${clean[@]}" || return $?
      return 0
    fi
    statusMessage decorate success "Filling in missing functions"
    documentationFunctionCompile "${aa[@]}" "$@" <"$funFile" || returnClean $? "${clean[@]}" || return $?
    catchReturn "$handler" rm -f "${clean[@]}" || return $?
  fi
}
_documentationFunctionsCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Build function documentation
# Extract and build the documentation settings cache and generate derived files:

# - `--documentation` is required for `SEE:` files
#
# Argument: --force - Flag. Optional. Create files regardless of cache status.
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --source codeSource - Directory. Required. Code source to find functions.
# Argument: --documentation documentationSource - Directory. Documentation source to find documentation links.
# Argument: --all - Flag. Optional. Check all functions.
# Argument: --fingerprint - Flag. Optional. Use fingerprint to ensure results are up to date.
# Argument: functionName ... - String. Optional. Specific functions to compile.
# stdin: functionName - File with function names one per line.
documentationFunctionCompile() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationFunctionCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Git add documentation files
# Just the first path.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
documentationFilesAdd() {
  local handler="_${FUNCNAME[0]}"

  [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return "$(convertValue $? 1 0)"

  local home && home=$(catchReturn "$handler" buildHome) || return $?
  local paths=() && IFS=":" read -r -a paths <<<"$(catchReturn "$handler" buildEnvironmentGet BUILD_DOCUMENTATION_PATH)" || return $?
  local path && for path in "${paths[@]}"; do
    pathIsAbsolute "$path" || path="$home/$path"
    if ! git check-ignore -q "$path"; then
      find "$path" -type f \( -name '*.sh' -or -name '*.md' \) -print0 | xargs -0 git add || return $?
    fi
    break
  done
}
_documentationFilesAdd() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Remove a function from the documentation cache
# Argument: --verbose - Flag. Optional. Use more words or phrases than absolutely essential.
# Argument: --dry-run - Flag. Optional. Do not do any thing, just say what would be done.
# Argument: --git - Flag. Remove from git.
# stdin: functionName - File with function names one per line.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
documentationFunctionRemove() {
  local handler="_${FUNCNAME[0]}"

  local dryRun=false verboseFlag=false gitRemove=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --verbose) verboseFlag=true ;;
    --dry-run) dryRun=true ;;
    --git) gitRemove=true ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local deprecatedFiles=()
  local fun && while read -r fun; do
    local extension && for extension in sh md; do
      local prefix && for prefix in "" "SEE/"; do
        ! $verboseFlag || statusMessage decorate info "Checking $prefix$fun.$extension"
        if path=$(__documentationFile "$home" "$prefix$fun" false "$extension"); then
          deprecatedFiles+=("$path")
        fi
      done
    done
  done
  if $dryRun; then
    [ "${#deprecatedFiles[@]}" -eq 0 ] && statusMessage --last printf -- "%s\n" "# No deprecated files." || printf -- "git rm -f %s\n" "${deprecatedFiles[@]}" || return $?
  else
    local f
    [ "${#deprecatedFiles[@]}" -eq 0 ] || for f in "${deprecatedFiles[@]}"; do
      ! $verboseFlag || decorate info "Remove \"$f\""
      ! $gitRemove || catchEnvironment "$handler" git rm -f "$f" 2>/dev/null || :
      catchReturn "$handler" rm -f "$f" || return $?
    done
  fi
}
_documentationFunctionRemove() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Extract and build the documentation settings cache
# Argument: --clean - Flag. Optional. Clean everything and then exit.
# Argument: --git - Flag. Optional. Do some handy `git` changes. (Adding/removing files)
# Argument: --all - Flag. Optional. Do everything regardless of cache state.
# Argument: --source sourcePath - Directory. Required. Find function source code definition in this directory.
# Argument: --derive command ... -- - CommandList. Optional. Run this command on each changed settings file to generate derived files.
# Argument: functionName ... - String. Optional. Specific functions to compile.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# stdin: functionName - File with function names one per line.
documentationFileCompile() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationFileCompile() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Generate markdown for a list of all functions
# Uses list of functions passed in `stdin`; using the `SEE` template.
# Output to `allFunctionList.md` typically.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# stdin: Function. Function names one per line.
bashDocumentationAllFunctions() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  local fun && while read -r fun; do
    local seeTemplate && seeTemplate=$(__documentationFile "$home" "SEE/$fun") || seeTemplate=""
    [ -n "$seeTemplate" ] && printf -- "%s\n" "$(cat "$seeTemplate")" || printf -- "%s\n" "{SEE:$fun}"
  done < <(sort) | sed 's/^/- &/g' || return $?
}
_bashDocumentationAllFunctions() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Generate markdown for a list of all functions
# Uses list of functions passed in `stdin`; using the `SEE` template.
# Output to `allEnvironmentList.md` typically.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# stdin: EnvironmentVariable. One per line.
bashDocumentationAllEnvironment() {
  local handler="_${FUNCNAME[0]}"
  [ $# -eq 0 ] || helpArgument --only "$handler" "$@" || return "$(convertValue $? 1 0)"
  local home && home=$(catchReturn "$handler" buildHome) || return $?
  local env && while read -r env; do
    local seeTemplate && seeTemplate=$(__documentationFile "$home" "SEE/$env") || seeTemplate=""
    [ -n "$seeTemplate" ] && printf -- "%s\n" "$(cat "$seeTemplate")" || printf -- "%s\n" "{SEE:$env}"
  done < <(buildEnvironmentNames | sort) | sed 's/^/- &/g' || return $?
}
_bashDocumentationAllEnvironment() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Generate base template files for Bash code documentation.
# Generates the following (with example content):
# - `applicationName.md` - `Zesk Build`
# - `applicationOwner.md` - `Market Acumen, Inc.`
# - `year.md` - `2026`
# - `version.md` - `v0.43.2`
# - `timestamp.md` - `1779910142`
# - `timestampString.md` - `2026-05-27 15:29:15`
# Argument: --target templateTarget - FileDirectory. Required. Create templates here.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# DOC TEMPLATE: --handler 1
# Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler.
# Failure is dirty; target directory may be modified even on failure.
bashDocumentationDefaults() {
  local handler="_${FUNCNAME[0]}"

  local templateTarget="" releaseTitle="# Past Releases"

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --target) shift && templateTarget="$(validate "$handler" FileDirectory "$argument" "${1-}")" || return $? ;;
    --release-title) shift && releaseTitle="$(validate "$handler" EmptyString "$argument" "${1-}")" || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "$templateTarget" ] || throwArgument "$handler" "--target is required" || return $?

  templateTarget=$(catchReturn "$handler" directoryRequire "$templateTarget") || return $?

  local applicationName && applicationName=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_NAME) || return $?

  local uriTarget && uriTarget=$(directoryRequire --handler "$handler" "$templateTarget/uri") || return $?
  catchReturn "$handler" printf "%s" "$applicationName" >"$templateTarget/applicationName.md" || return $?
  local owner && owner=$(catchReturn "$handler" buildEnvironmentGet APPLICATION_OWNER) || return $?
  catchReturn "$handler" printf "%s" "$owner" >"$templateTarget/applicationOwner.md" || return $?
  catchReturn "$handler" jq -Rr @uri <<<"$owner" >"$uriTarget/applicationOwner.md" || return $?
  catchReturn "$handler" jq -Rr @uri <<<"$applicationName" >"$uriTarget/applicationName.md" || return $?
  catchReturn "$handler" printf "%s" "$(date +%Y)" >"$templateTarget/year.md" || return $?
  catchReturn "$handler" hookVersionCurrent >"$templateTarget/version.md" || return $?
  catchReturn "$handler" date -u "+%s" >"$templateTarget/timestamp.md" || return $?
  catchReturn "$handler" printf "%s" "$(catchReturn "$handler" date -u "+%F %T") UTC" >"$templateTarget/timestampString.md" || return $?
  catchReturn "$handler" releaseNotesMarkdown --title "$releaseTitle" >"$templateTarget/releaseNotesPage.md" || return $?
}
_bashDocumentationDefaults() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Generate templates of functions missing from documentation
#
# Generates:
#
# - `missingFunctionTotal.md`
# - `missingFunctionList.md`
#
# in the target directory.
#
# Argument: --index indexPath - Directory. Required. Where to store documentation indexes for later use.
# Argument: --source sourcePath - Directory. Required. The source
# Argument: --target templateTarget - FileDirectory. Required. Create templates here.
bashDocumentationMissing() {
  local handler="_${FUNCNAME[0]}"

  local indexPath="" codeSourcePath="" documentationSourcePath="" templateTarget=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    # _IDENTICAL_ handlerHandler 1
    --handler) shift && handler=$(validate "$handler" Function "$argument" "${1-}") || return $? ;;
    --index) shift && indexPath="$(validate "$handler" Directory "$argument" "${1-}")" || return $? ;;
    --source) shift && codeSourcePath="$(validate "$handler" Directory "$argument" "${1-}")" || return $? ;;
    --documentation) shift && documentationSourcePath="$(validate "$handler" Directory "$argument" "${1-}")" || return $? ;;
    --target) shift && templateTarget="$(validate "$handler" FileDirectory "$argument" "${1-}")" || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
    shift
  done

  [ -n "$indexPath" ] || throwArgument "$handler" "--index is required" || return $?
  [ -n "$codeSourcePath" ] || throwArgument "$handler" "--source is required" || return $?
  [ -n "$documentationSourcePath" ] || throwArgument "$handler" "--documentation is required" || return $?
  [ -n "$templateTarget" ] || throwArgument "$handler" "--target is required" || return $?

  indexPath=$(catchReturn "$handler" directoryRequire "$indexPath") || return $?
  templateTarget=$(catchReturn "$handler" directoryRequire "$templateTarget") || return $?

  statusMessage decorate info "Generating documentation index ..."
  local start && start=$(timingStart) || return $?
  catchReturn "$handler" documentationIndexGenerate --target "$indexPath" "$codeSourcePath" || return $?
  catchReturn "$handler" documentationIndexDocumentation --target "$indexPath" "$documentationSourcePath" || return $?
  statusMessage --last timingReport "$start" "Documentation index generated"
  local tempMissing="$templateTarget/.missingFunctions.$$.md"
  local clean=("$tempMissing")
  documentationIndexUnlinkedFunctions "$indexPath" | grepSafe -v '^_' | sort >"$tempMissing" || returnClean $? "${clean[@]}" || return $?
  fileLineCount <"$tempMissing" >"$templateTarget/missingFunctionTotal.md" || returnClean $? "${clean[@]}" || return $?
  sed 's/.*/{&}\n/g' <"$tempMissing" >"$templateTarget/missingFunctionList.md" || returnClean $? "${clean[@]}" || return $?
  catchReturn "$handler" rm -rf "$tempMissing" || return $?
}
_bashDocumentationMissing() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Generate markdown documentation page
#
# Generate function derived files.
#
# File(s) are generated next to `settingsFile`.
#
# - `--check` checks to see if the file needs to be generated or updated. Returns 0 if up to date.
#
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --check - Flag. Optional. Check to see if an update is needed
# Argument: settingsFile - File. Required. Settings file for function to document.
bashDocumentationDeriveFunction() {
  local handler="_${FUNCNAME[0]}"

  local settingsFile="" checkFlag=false verboseFlag=false template=""

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --template) shift && template=$(validate "$handler" String "$argument" "${1-}") || return $? ;;
    --check) checkFlag=true ;;
    --verbose) verboseFlag=true ;;
    *) settingsFile=$(validate "$handler" File "settingsFile" "$argument") && shift && break || return $? ;;
    esac
    shift
  done
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument: $*" || return $?
  [ -n "$settingsFile" ] || throwArgument "$handler" "Missing settingsFile" || return $?

  local fn && fn=$(environmentValueRead "$settingsFile" fn) || return $?
  local targetFile && targetFile="$(dirname "$settingsFile")/${fn}.md"
  local template && [ -n "$template" ] || template=$(catchReturn "$handler" documentationTemplate function) || return $?
  if $checkFlag; then
    local sourceFile && sourceFile=$(environmentValueRead "$settingsFile" sourceFile) || return $?
    if [ -f "$targetFile" ] && fileIsNewest "$targetFile" "$settingsFile" "$template" "$sourceFile"; then
      catchReturn "$handler" touch "$targetFile" || return $?
      ! $verboseFlag || statusMessage decorate success "Checked fn $(decorate file "$targetFile")"
      return 0
    fi
    return 1
  fi
  catchReturn "$handler" bashDocumentationMarkdown --template "$template" "$fn" >"$targetFile" || return $?
  ! $verboseFlag || statusMessage decorate success "Created fn $(decorate file "$targetFile")"
}
_bashDocumentationDeriveFunction() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Generate SEE markdown content
# Generate `SEE/{fn}.md` - Derived file generator.
# File is next to `settingsFile`; `--check` checks to see if the file needs to be generated or updated.
# DOC TEMPLATE: --help 1
# Argument: --help - Flag. Optional. Display this help.
# Argument: --check - Flag. Optional. Check to see if an update is needed
# Argument: settingsFile - File. Required. Settings file for function to document.
bashDocumentationDeriveSee() {
  local handler="_${FUNCNAME[0]}"

  local settingsFile="" checkFlag=false template="" verboseFlag=false

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    --template) shift && template=$(validate "$handler" File "$argument" "${1-}") || return $? ;;
    --check) checkFlag=true ;;
    --verbose) verboseFlag=true ;;
    --source) shift && source=$(validate "$handler" Directory "$argument" "${1-}") || return $? ;;
    *) settingsFile=$(validate "$handler" File "settingsFile" "$argument") && shift && break || return $? ;;
    esac
    shift
  done
  [ $# -eq 0 ] || throwArgument "$handler" "Unknown argument: $*" || return $?

  local home && home=$(catchReturn "$handler" buildHome) || return $?

  local fn && fn=$(environmentValueRead "$settingsFile" fn) || return $?
  local documentationPath && if ! documentationPath=$(environmentValueRead "$settingsFile" documentationPath); then
    if ! documentationPath=$(directoryChange "$home" find "$source" -type f -name '*.md' -print0 | xargs -0 grep -l "{$fn}" | sort | head -n 1); then
      decorate warning "No documentationPath found for $fn" || :
    else
      documentationPath=${documentationPath#"$home/"}
      environmentValueWrite "documentationPath" "$documentationPath" >>"$settingsFile"
    fi
  fi
  local targetFile && targetFile="$(__documentationFile "$home" "SEE/$fn" true)"
  [ -n "$template" ] || template=$(catchReturn "$handler" documentationTemplate seeFunction) || return $?
  if $checkFlag; then
    if [ -f "$targetFile" ] && [ -f "$documentationPath" ] && fileIsNewest "$targetFile" "$settingsFile" "$template" "$sourceFile" "$documentationPath"; then
      catchReturn "$handler" touch "$targetFile" || return $?
      ! $verboseFlag || statusMessage decorate success "Checked SEE $(decorate file "$targetFile")"
      return 0
    fi
    return 1
  fi
  (
    catchReturn "$handler" buildEnvironmentLoad BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN || return $?
    local functionLinkPattern=${BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN-}
    catchReturn "$handler" environmentFileLoad "$settingsFile" || return $?
    documentationPath="${documentationPath#documentation/source/}"
    local sourceLink && sourceLink="$(catchReturn "$handler" mapEnvironment <<<"$functionLinkPattern")" || return $?
    catchReturn "$handler" muzzle fileDirectoryRequire --handler "$handler" "$targetFile" || return $?
    documentationPath="$documentationPath" sourceLink="$sourceLink" catchReturn "$handler" mapEnvironment <"$template" >"$targetFile" || return $?
    ! $verboseFlag || statusMessage decorate success "Wrote SEE $(decorate file "$targetFile")"
  ) || return $?
}
_bashDocumentationDeriveSee() {
  # __IDENTICAL__ bashDocumentation 1
  bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
