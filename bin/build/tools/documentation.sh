#!/usr/bin/env bash
#
# documentation.sh
#
# Tools to help with documentation of shell scripts. Very simple mechanism to extract
# documentation from code. Note that bash makes a terrible template engine, but
# having no language dependencies outweighs the negatives.
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#
# Depends: colors.sh text.sh wrapLines usage.sh
#
# Docs: o ./docs/_templates/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

# Usage: usageDocument functionDefinitionFile functionName exitCode [ ... ]
# Argument: functionDefinitionFile - Required. The file in which the function is defined. If you don't know, use `bashDocumentation_FindFunctionDefinitions` or `bashDocumentation_FindFunctionDefinition`.
# Argument: functionName - Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
#
# Generates console usage output for a script using documentation tools parsed from the comment of the function identified.
#
# Simplifies documentation and has it in one place for shell and online.
#
usageDocument() {
  local functionDefinitionFile functionName exitCode variablesFile
  local usage="_${FUNCNAME[0]}"

  [ $# -ge 2 ] || __failArgument "$usage" "Expected 2 arguments, got $#:$(printf -- " \"%s\"" "$@")" || return $?

  functionDefinitionFile="$1"
  functionName="$2"
  exitCode="${3-NONE}"
  shift 3 || :

  [ -f "$functionDefinitionFile" ] || __failArgument "$usage" "functionDefinitionFile $functionDefinitionFile not found" || return $?
  [ -n "$functionName" ] || __failArgument "$usage" "functionName is blank" || return $?
  if [ "$exitCode" = "NONE" ]; then
    consoleError "NO EXIT CODE" 1>&2
    exitCode=1
  fi
  __usageArgument "$usage" isInteger "$exitCode" || _argument "$(debuggingStack)" || return $?
  variablesFile=$(mktemp)
  if ! bashDocumentation_Extract "$functionDefinitionFile" "$functionName" >"$variablesFile"; then
    if ! rm "$variablesFile"; then
      _environment "Unable to delete temporary file $variablesFile while extracting \"$functionName\" from \"$functionDefinitionFile\"" || return $?
    fi
    __failArgument "$usage" "Unable to extract \"$functionName\" from \"$functionDefinitionFile\"" || return $?
  fi
  (
    set -a
    description=""
    argument=""

    # shellcheck source=/dev/null
    source "$variablesFile"
    [ $exitCode -eq 0 ] || exec 1>&2
    usageTemplate "$fn" "$(printf "%s\n" "$argument" | sed 's/ - /^/1')" "^" "$(printf "%s" "$description" | mapEnvironment | simpleMarkdownToConsole)" "$exitCode" "$@"
  )
  return "$exitCode"
}
_usageDocument() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

# Summary: Convert a template file to a documentation file using templates
#
# Usage: {fn} [ --env envFile ] cacheDirectory documentTemplate functionTemplate templateFile targetFile
# Argument: cacheDirectory - Required. Cache directory where the indexes live.
# Argument: --env envFile - Optional. File. One (or more) environment files used to map `documentTemplate` prior to scanning, as defaults prior to each function generation, and after file generation.
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
#
documentationTemplateCompile() {
  local usage argument
  local start documentTemplate mappedDocumentTemplate functionTemplate targetFile cacheDirectory checkFiles forceFlag

  local targetDirectory settingsFile
  local base
  local envFiles envFile
  local error tokenName
  local documentTokensFile
  local envChecksum envChecksumCache
  local compiledTemplateCache

  usage="_${FUNCNAME[0]}"

  cacheDirectory=
  documentTemplate=
  functionTemplate=
  targetFile=
  forceFlag=
  envFiles=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --env)
        shift || __failArgument "$usage" "missing $argument argument" || return $?
        envFile=$(usageArgumentFile "$usage" "envFile" "$1") || return $?
        envFiles+=("$envFile")
        ;;
      --force)
        forceFlag=1
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
          __failArgument "$usage" "Unknown argument" || return $?
        fi
        ;;
    esac
    shift || :
  done

  start=$(beginTiming) || __failArgument "$usage" beginTiming || return $?

  # Validate arguments
  cacheDirectory=$(usageArgumentDirectory "$usage" cacheDirectory "$cacheDirectory") || return $?
  documentTemplate="$(usageArgumentFile "$usage" documentTemplate "$documentTemplate")" || return $?
  functionTemplate="$(usageArgumentFile "$usage" functionTemplate "$functionTemplate")" || return $?
  targetFile="$(usageArgumentFileDirectory "$usage" targetFile "$targetFile")" || return $?

  # echo cacheDirectory="$cacheDirectory"
  # echo documentTemplate="$documentTemplate"
  # echo functionTemplate="$functionTemplate"
  # echo targetFile="$targetFile"

  base="$(basename "$targetFile")" || __failArgument "$usage" basename "$targetFile" || return $?
  base="${base%%.md}"
  statusMessage consoleInfo "Generating $base ..."

  documentTokensFile=$(mktemp)
  mappedDocumentTemplate=$(mktemp)
  if ! envChecksum=$(
    set -a
    title="$(grep -E '^# ' -m 1 <"$targetFile" | cut -c 3-)"
    title="${title:-notitle}"
    for envFile in "${envFiles[@]+${envFiles[@]}}"; do
      # shellcheck source=/dev/null
      . "$envFile"
    done
    mapEnvironment <"$documentTemplate" >"$mappedDocumentTemplate"
    if [ ${#envFiles[@]} -gt 0 ]; then
      shaPipe "${envFiles[@]}" | shaPipe
    else
      printf %s 'no-environment'
    fi
  ); then
    __failEnvironment "$usage" "listTokens failed" || return $?
  fi
  if ! listTokens <"$mappedDocumentTemplate" >"$documentTokensFile"; then
    __failEnvironment "$usage" "listTokens failed" || return $?
  fi
  #
  # Look at source file for each function
  #
  if ! envChecksumCache=$(requireDirectory "$cacheDirectory/envChecksum"); then
    __failEnvironment "$usage" "create $cacheDirectory/envChecksum failed" || return $?
  fi
  envChecksumCache="$envChecksumCache/$envChecksum"
  if [ ! -f "$envChecksumCache" ]; then
    touch "$envChecksumCache"
  fi
  if ! compiledTemplateCache=$(requireDirectory "$cacheDirectory/compiledTemplateCache"); then
    __failEnvironment "$usage" "create $cacheDirectory/envChecksum failed" || return $?
  fi
  # Environment change will affect this template
  # Function template change will affect this template
  checkFiles=("$envChecksumCache" "$functionTemplate")
  while read -r tokenName; do
    if ! settingsFile=$(documentationIndex_Lookup --source "$cacheDirectory" "$tokenName"); then
      continue
    fi
    # Source file of any token in the documentTemplate change will affect this template
    checkFiles+=("$settingsFile")
  done <"$documentTokensFile"

  # As well, document template change will affect this template
  if test $forceFlag || ! isNewestFile "$targetFile" "${checkFiles[@]}" "$documentTemplate"; then
    (
      # subshell to hide environment tokens
      set -a
      for envFile in "${envFiles[@]+${envFiles[@]}}"; do
        # shellcheck source=/dev/null
        . "$envFile" || __failEnvironment "$usage" "source $envFile failed" || return $?
      done
      while read -r tokenName; do
        if ! settingsFile=$(documentationIndex_Lookup "$cacheDirectory" "$tokenName"); then
          error="Unable to find \"$tokenName\" (using index \"$cacheDirectory\")"
          consoleError "$error" 1>&2
          if [ "${tokenName#* }${tokenName#*@}" = "${tokenName}${tokenName}" ]; then
            declare "$tokenName"="$error"
          fi
          continue
        fi
        # echo "Checking TEMPLATE files isNewestFile" "$compiledTemplateCache/$tokenName" "$settingsFile" "${checkFiles[@]}"
        if test $forceFlag || [ ! -f "$compiledTemplateCache/$tokenName" ] || ! isNewestFile "$compiledTemplateCache/$tokenName" "$settingsFile" "${checkFiles[@]}"; then
          statusMessage consoleInfo "Generating $base ... $(consoleValue "[$tokenName]") ..."
          export "${tokenName?}"
          if ! _bashDocumentation_Template "$settingsFile" "$functionTemplate" >"$compiledTemplateCache/$tokenName"; then
            mv "$compiledTemplateCache/$tokenName" "$compiledTemplateCache/$tokenName.failed"
            # shellcheck disable=SC2140
            declare "$tokenName"="ExitCode _bashDocumentation_Template $tokenName $settingsFile $functionTemplate: $?"
          else
            declare "$tokenName"="$(cat "$compiledTemplateCache/$tokenName")"
          fi
        else
          statusMessage consoleInfo "Using cached $base ... $(consoleValue "[$tokenName]") ..."
          declare "$tokenName"="$(cat "$compiledTemplateCache/$tokenName")"
        fi
      done <"$documentTokensFile"
      if [ $(($(wc -l <"$documentTokensFile") + 0)) -eq 0 ]; then
        if [ ! -f "$targetFile" ] || ! diff -q "$mappedDocumentTemplate" "$targetFile" >/dev/null; then
          printf "%s (mapped) -> %s %s" "$(consoleWarning "$documentTemplate")" "$(consoleSuccess "$targetFile")" "$(consoleError "(no tokens found)")"
          cp "$mappedDocumentTemplate" "$targetFile"
        fi
      else
        statusMessage consoleSuccess "Writing $targetFile using $documentTemplate (mapped) ..."
        mapEnvironment <"$mappedDocumentTemplate" >"$targetFile"
      fi
      clearLine
      touch "$envChecksumCache"
      set +a
    )
  fi
  rm -f "$documentTokensFile" || :
  rm -f "$mappedDocumentTemplate" || :
  statusMessage consoleInfo "$(reportTiming "$start" Generated "$targetFile" in)"
}
_documentationTemplateCompileUsage() {
  usageDocument "${BASH_SOURCE[0]}" "documentationTemplateCompile" "$@"
}

# Usage: {fn} cacheDirectory documentDirectory functionTemplate targetDirectory
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
  local usage argument
  local start templateDirectory functionTemplate targetDirectory cacheDirectory passArgs
  local base targetFile
  local documentTokensFile

  usage="_${FUNCNAME[0]}"
  cacheDirectory=
  templateDirectory=
  functionTemplate=
  targetDirectory=
  passArgs=()
  while [ $# -gt 0 ]; do
    argument="$1"
    [ -n "$argument" ] || __failArgument "$usage" "blank argument" || return $?
    case "$argument" in
      --force)
        passArgs+=("$argument")
        ;;
      --env)
        passArgs+=("$argument")
        shift || __failArgument "$usage" "missing $argument argument" || return $?
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
          __failArgument "$usage" "unknown argument $(consoleValue "$argument")" || return $?
        fi
        ;;
    esac
    shift || __failArgument "$usage" "shift after $argument failed" || return $?
  done

  start=$(beginTiming) || __failEnvironment "$usage" beginTiming || return $?
  cacheDirectory=$(usageArgumentDirectory "$usage" "cacheDirectory" "$cacheDirectory") || return $?
  templateDirectory=$(usageArgumentDirectory "$usage" "templateDirectory" "$templateDirectory") || return $?
  functionTemplate=$(usageArgumentFile "$usage" "functionTemplate" "$functionTemplate") || return $?
  targetDirectory=$(usageArgumentDirectory "$usage" "targetDirectory" "$targetDirectory") || return $?

  exitCode=0
  fileCount=0
  for templateFile in "$templateDirectory/"*.md; do
    base="$(basename "$templateFile")" || __failEnvironment "$usage" "basename $templateFile" || return $?
    targetFile="$targetDirectory/$base"
    if ! documentationTemplateCompile "${passArgs[@]+${passArgs[@]}}" "$cacheDirectory" "$templateFile" "$functionTemplate" "$targetFile"; then
      consoleError "Failed to generate $targetFile" 1>&2
      exitCode=1
    fi
    fileCount=$((fileCount + 1))
  done
  clearLine || :
  reportTiming "$start" "Completed generation of $fileCount $(plural $fileCount file files) in $(consoleInfo "$targetDirectory") "
  return $exitCode
}
_documentationTemplateDirectoryCompile() {
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Document a function and generate a function template (markdown)
#
# Usage: bashDocumentFunction file function template
# Argument: file - Required. File in which the function is defined
# Argument: function - Required. The function name which is defined in `file`
# Argument: template - Required. A markdown template to use to map values. Post-processed with `markdown_removeUnfinishedSections`
# Exit code: 0 - Success
# Exit code: 1 - Template file not found
# Short description: Simple bash function documentation
# Deprecated: 2023-01-18
# See: _bashDocumentation_Template
# See: bashDocumentFunction
# See: repeat
#
bashDocumentFunction() {
  local envFile file=$1 fn=$2 template=$3
  if [ ! -f "$template" ]; then
    consoleError "Template $template not found" 1>&2
    return 1
  fi
  envFile=$(mktemp)
  printf "%s\n" "#!/usr/bin/env bash" >>"$envFile"
  printf "%s\n" "set -eou pipefail" >>"$envFile"
  if ! bashDocumentation_Extract "$file" "$fn" >>"$envFile"; then
    __dumpNameValue "error" "$fn was not found" >>"$envFile"
  fi
  _bashDocumentation_Template "$envFile" "$template"
  exitCode=$?
  rm "$envFile" || :
  return $exitCode
}

# See: bashDocumentFunction
# Document a function and generate a function template (markdown). To custom format any
# of the fields in this, write functions in the form `_bashDocumentationFormatter_${name}Format` such that
# name matches the variable name (lowercase alphanumeric characters and underscores).
#
# Filter functions should modify the input/output pipe; an example can be found in `{file}` by looking at
# sample function `_bashDocumentationFormatter_exit_code`.
#
# See: _bashDocumentationFormatter_exit_code
# Usage: {fn} settingsFile template
# Argument: settingsFile - Required. Cached documentation settings.
# Argument: template - Required. A markdown template to use to map values. Post-processed with `markdown_removeUnfinishedSections`
# Exit code: 0 - Success
# Exit code: 1 - Template file not found
# Short description: Simple bash function documentation
#
_bashDocumentation_Template() {
  local envFile=$1 template=$2
  [ -f "$envFile" ] || _argument "Settings file $envFile not found" || return $?
  [ -f "$template" ] || _argument "Template $template not found" || return $?
  if ! (
    # subshell this does not affect anything except these commands
    set -eou pipefail
    set -a
    # shellcheck source=/dev/null
    if ! source "$envFile"; then
      set +a
      wrapLines "$(consoleCode)" "$(consoleReset)" <"$envFile"
      _environment "$envFile Failed" || return $?
    fi
    set +a
    while read -r envVar; do
      formatter="_bashDocumentationFormatter_${envVar}"
      if [ "$(type -t "$formatter")" = "function" ]; then
        declare "$envVar"="$(printf "%s\n" "${!envVar}" | "$formatter")"
      fi
    done < <(environmentVariables)
    mapEnvironment <"$template" | grep -E -v '^shellcheck|# shellcheck' | markdown_removeUnfinishedSections || return $?
  ); then
    _environment "Template $template not found" || return $?
  fi
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
# Usage: __dumpNameValuePrefix prefix name [ value0 value1 ... ]
# Argument: `prefix` - Literal string value to prefix each text line with
# Argument: `name` - Shell value to output
# Argument: `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner
#
__dumpNameValuePrefix() {
  local prefix=$1 varName=$2
  printf "export '%s'; " "$varName"
  printf "IFS='' read -r -d '' '%s' <<'%s' || :\n" "$varName" "EOF" # Single quote means no interpolation
  shift
  shift
  while [ $# -gt 0 ]; do
    printf "%s%s\n" "$prefix" "$1"
    shift
  done
  printf "%s\n" "EOF"
}

# This basically just does `a=${b}` in the output
#
# Summary: Assign one value to another in bash
# Usage: __dumpAliasedValue variable alias
# Argument: `variable` - shell variable to set
# Argument: `alias` - The shell variable to assign to `variable`
#
__dumpAliasedValue() {
  printf 'export "%s"="%s%s%s"\n' "$1" '$\{' "$2" '}'
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
  local maxLines=1000 definitionFile=$1 fn=$2 definitionFile
  local line name value desc tempDoc foundNames docMap lastName values
  local base

  if [ ! -f "$definitionFile" ]; then
    consoleError "$definitionFile is not a file" 1>&2
    return 2
  fi
  if [ -z "$fn" ]; then
    consoleError "function name is blank" 1>&2
    return 2
  fi
  base="$(basename "$definitionFile")"
  tempDoc=$(mktemp)
  docMap=$(mktemp)

  __dumpNameValue "file" "$definitionFile" | tee -a "$docMap"
  __dumpNameValue "base" "$base" | tee -a "$docMap"
  __dumpNameValue "fn" "$fn" >>"$docMap" # just docMap

  #
  # Search for our function and then capture all of the lines BEFORE it
  # which have a `#` character and then stop capture at the next blank line
  #
  grep -m 1 -B $maxLines "$fn() {" "$definitionFile" |
    reverseFileLines | grep -B $maxLines -m 1 -E '^\s*$' |
    reverseFileLines | grep -E '^#' | cut -c 3- >"$tempDoc"
  desc=()
  lastName=
  values=()
  foundNames=()
  while IFS= read -r line; do
    name="${line%%:*}"
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
      elif ! inArray "$name" "${foundNames[@]+${foundNames[@]}}"; then
        foundNames+=("$name")
      fi
      if [ -n "$lastName" ] && [ "$lastName" != "$name" ]; then
        __dumpNameValue "$lastName" "${values[@]}" | tee -a "$docMap"
        values=()
      fi
      if inArray "$name" fn; then
        value=$(mapValue "$docMap" "$value")
      fi
      values+=("$value")
      lastName="$name"
    fi
  done <"$tempDoc"
  printf "%s %s\n" "# Found Names:" "$(printf "%s " "${foundNames[@]+${foundNames[@]}}")"
  if [ "${#values[@]}" -gt 0 ]; then
    __dumpNameValue "$lastName" "${values[@]}" | tee -a "$docMap"
  fi
  if [ "${#desc[@]}" -gt 0 ]; then
    __dumpNameValue "description" "${desc[@]}"
    printf "%s %s\n" "# Found Names:" "$(printf "%s " "${foundNames[@]+${foundNames[@]}}")"
    if ! inArray "summary" "${foundNames[@]+${foundNames[@]}}"; then
      __dumpNameValue "summary" "$(trimWords 10 "${desc[0]}")"
    fi
  elif inArray "summary" "${foundNames[@]+${foundNames[@]}}"; then
    __dumpAliasedValue description summary
  fi
  if ! inArray "exit_code" "${foundNames[@]+${foundNames[@]}}"; then
    __dumpNameValue "exit_code" '0 - Always succeeds'
  fi
  if ! inArray "fn" "${foundNames[@]+${foundNames[@]}}"; then
    __dumpNameValue "fn" "$fn"
  fi
  echo "# DocMap: $docMap"
  #
  # Defaults no longer needed
  #
  # if ! inArray "local_cache" "${foundNames[@]+${foundNames[@]}}"; then
  #     __dumpNameValue "local_cache" 'None'
  # fi
  # if ! inArray "reviewed" "${foundNames[@]+${foundNames[@]}}"; then
  #     __dumpNameValue "reviewed" 'Never'
  # fi
  # if ! inArray "environment" "${foundNames[@]+${foundNames[@]}}"; then
  #     __dumpNameValue "environment" 'No environment dependencies or modifications.'
  # fi
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
    find "$directory" -type f -name '*.sh' ! -path '*/.*' | while read -r f; do
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
  wrapLines "    " ""
}

# #
# # Format example blocks (indents as a code block)
# #
# _bashDocumentationFormatter_exampleFormat() {
#     markdown_FormatList
# }
_bashDocumentationFormatter_output() {
  wrapLines "    " ""
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
  wrapLines "    " ""
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
