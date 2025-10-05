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

__documentationLoader() {
  __functionLoader __bashDocumentationExtract documentation "$@" || return $?
}

# Extract documentation varaibles from a comment stripped of the '# ' prefixes.
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
# Argument: function - String. Required. Function defined in `file`
# stdin: Pipe stripped comments to extract information
bashDocumentationExtract() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_bashDocumentationExtract() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Build documentation for Bash functions
#
# Given that bash is not an ideal template language, caching is mandatory.
#
# Uses a cache at `buildCacheDirectory`
# See: buildCacheDirectory
#
# Argument: --git - Merge current branch in with `docs` branch
# Argument: --commit - Commit docs to non-docs branch
# Argument: --force - Force generation, ignore cache directives
# Argument: --unlinked - Show unlinked functions
# Argument: --unlinked-update - Update unlinked document file
# Argument: --clean - Erase the cache before starting.
# Argument: --help - I need somebody
# Argument: --company companyName - Optional. Company name (uses `BUILD_COMPANY` if not set)
# Argument: --company-link companyLink - Optional. Company name (uses `BUILD_COMPANY_LINK` if not set)
# Artifact: `cacheDirectory` may be created even on non-zero exit code
# Return Code: 0 - Success
# Return Code: 1 - Issue with environment
# Return Code: 2 - Argument error
documentationBuild() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationBuild() {
  hookRunOptional documentation-error "$@" || :
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# List unlinked functions in documentation index
documentationUnlinked() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationUnlinked() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get an internal template name
documentationTemplate() {
  [ "${1-}" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
  local source="${BASH_SOURCE[0]%.sh}"
  local template="$source/__${1-}.md"

  [ -f "$template" ] || returnArgument "No template \"${1-}\" at $template" || return $?
  printf "%s\n" "$template"
}
_documentationTemplate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
documentationBuildEnvironment() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationBuildEnvironment() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Get the cache directory for the documentation
# Argument: suffix - String. Optional. Directory suffix - created if does not exist.
documentationBuildCache() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  local code
  code=$(catchReturn "$handler" buildEnvironmentGet "APPLICATION_CODE") || return $?
  catchReturn "$handler" buildCacheDirectory ".documentation/${code-default}/${1-}" || return $?
}
_documentationBuildCache() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Map template files using our identical functionality
# Usage: {fn} templatePath repairPath
documentationTemplateUpdate() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationTemplateUpdate() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Convert a template file to a documentation file using templates
#
# Usage: {fn} [ --env-file envFile ] cacheDirectory documentTemplate functionTemplate templateFile targetFile
# Argument: --env-file envFile - Optional. File. One (or more) environment files used to map `documentTemplate` prior to scanning, as defaults prior to each function generation, and after file generation.
# Argument: cacheDirectory - Required. Cache directory where the indexes live.
# Argument: sourceFile - Required. The document template containing functions to define
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
# See: __documentationIndexLookup
# See: __documentationTemplateCompile
# See: documentationIndexIndex
# Return Code: 0 - If success
# Return Code: 1 - Issue with file generation
# Return Code: 2 - Argument error
# Requires: catchEnvironment timingStart throwArgument usageArgumentFile usageArgumentDirectory usageArgumentFileDirectory
# Requires: basename decorate statusMessage fileTemporaryName rm grep cut source mapTokens returnClean
# Requires: mapEnvironment shaPipe printf
documentationTemplateCompile() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationTemplateCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Usage: {fn} cacheDirectory documentDirectory functionTemplate targetDirectory
# Argument: --filter filterArgs ... --  - Arguments. Optional. Passed to `find` and allows filtering list.
# Argument: --force - Flag. Optional. Force generation of files.
# Argument: --verbose - Flag. Optional. Output more messages.
# Argument: --env-file envFile - Optional. File. One (or more) environment files used during map of `functionTemplate`
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
# Return Code: 0 - If success
# Return Code: 1 - Any template file failed to generate for any reason
# Return Code: 2 - Argument error
#
documentationTemplateDirectoryCompile() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationTemplateDirectoryCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
# Argument: --env-file envFile - Optional. File. One (or more) environment files used during map of `functionTemplate`
# Argument: functionName - Required. The function name to document.
# Argument: functionTemplate - Required. The template for individual functions.
# Usage: {fn} [ --env-file envFile ] cacheDirectory functionName functionTemplate
documentationTemplateFunctionCompile() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationTemplateFunctionCompile() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Parses input stream and generates an argument documentation list
# Input is in the format with "{argument}{delimiter}{description}{newline}" and generates a list of arguments (optionally decorated) color-coded based
# on whether the word "require" appears in the description.
# INTERNAL: This is solely used internally but should be accessible globally as it is used here and in `usage`
# handler: __documentationFormatArguments delimiter
# Argument: delimiter - Required. String. The character to separate name value pairs in the input
__documentationFormatArguments() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  [ $# -le 3 ] || throwArgument "$handler" "Requires 3 or fewer arguments" || return $?

  local separatorChar="${1-" "}" optionalDecoration="${2-blue}" requiredDecoration="${3-bold-magenta}"

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
      __description=$(lowercase "${lineTokens[*]-}")
      # Looks for `Required.` in the description
      if [ "${__description%*required.*}" = "$__description" ]; then
        __value="[ $__value ]"
        [ -z "$optionalDecoration" ] || __value="$(decorate "$optionalDecoration" "$__value")"
      else
        [ -z "$requiredDecoration" ] || __value="$(decorate "$requiredDecoration" "$__value")"
      fi
      printf " %s" "$__value"
    fi
    if $lastLine; then
      break
    fi
  done
}
___documentationFormatArguments() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Generate the documentation index (e.g. functions defined in the documentation)
# Argument: cacheDirectory - Required. Cache directory where the index will be created.
# Argument: documentationSource ... - OneOrMore. Documentation source path to find tokens and their definitions.
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Return Code: 0 - If success
# Return Code: 1 - Issue with file generation
# Return Code: 2 - Argument error
documentationIndexDocumentation() {
  __documentationLoader "_${FUNCNAME[0]}" "__${FUNCNAME[0]}" "$@"
}
_documentationIndexDocumentation() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Finds one ore more function definition and outputs the file or files in which a
# function definition is found. Searches solely `.sh` files. (Bash or sh scripts)
#
# Note this function succeeds if it finds all occurrences of each function, but
# may output partial results with a failure.
#
# Usage: __bashDocumentation_FindFunctionDefinitions directory fnName0 [ fnName1... ]
# Argument: `directory` - The directory to search
# Argument: `fnName0` - A function to find the file in which it is defined
# Argument: `fnName1...` - Additional functions are found are output as well
# Return Code: 0 - if one or more function definitions are found
# Return Code: 1 - if no function definitions are found
# Example:     __bashDocumentation_FindFunctionDefinitions . __bashDocumentation_FindFunctionDefinitions
# Example:     ./bin/build/tools/autodoc.sh
# Platform: `stat` is not cross-platform
# Summary: Find where a function is defined in a directory of shell scripts
#
__bashDocumentation_FindFunctionDefinitions() {
  local handler="_${FUNCNAME[0]}"

  local directory

  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0
  directory=$(usageArgumentDirectory "$handler" "directory" "${1-}") && shift || return $?

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
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
