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
# Depends: colors.sh text.sh prefixLines
#
# Docs: o ./docs/_templates/tools/documentation.md
# Test: o ./test/tools/documentation-tests.sh

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

# Usage: usageDocument functionDefinitionFile functionName exitCode [ ... ]
# Argument: functionDefinitionFile - Required. The file in which the function is defined. If you don't know, use `bashFindFunctionFiles` or `bashFindFunctionFile`.
# Argument: functionName - Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
#
# Generates console usage output for a script using documentation tools parsed from the comment of the function identified.
#
# Simplifies documentation and has it in one place for shell and online.
#
usageDocument() {
  local functionDefinitionFile functionName exitCode variablesFile

  functionDefinitionFile="$1"
  shift || return "$errorArgument"
  functionName="$1"
  shift || return "$errorArgument"
  exitCode="${1-0}"
  shift || :

  variablesFile=$(mktemp)
  if ! bashExtractDocumentation "$functionDefinitionFile" "$functionName" >"$variablesFile"; then
    if ! rm "$variablesFile"; then
      consoleError "Unable to delete temporary file $variablesFile while extracting \"$functionName\" from \"$functionDefinitionFile\"" 1>&2
      return $errorEnvironment
    fi
    consoleError "Unable to extract \"$functionName\" from \"$functionDefinitionFile\"" 1>&2
    return $errorArgument
  fi
  (
    set -a
    description=""
    argument=""

    # shellcheck source=/dev/null
    source "$variablesFile"

    usageTemplate "$fn" "$(printf %s "$argument" | sed 's/ - /^/1')" "^" "$(printf "%s" "$description" | simpleMarkdownToConsole)" "$exitCode" "$@"
  )
  return "$exitCode"
}

#
# Usage: {fn} cacheDirectory documentTemplate functionTemplate templateFile targetFile
# Argument: cacheDirectory - Required. Cache directory where the indexes live.
# Argument: documentTemplate - Required. The document template containing functions to define
# Argument: templateFile - Required. Function template file to generate documentation for functions
# Argument: targetFile - Required. Target file to generate
# Summary: Convert a template into documentation for Bash functions
# Convert a template which contains bash functions into full-fledged documentation.
#
# The process:
#
# 1. `documentTemplate` is scanned for tokens which are assumed to represent Bash functions
# 1. `functionTemplate` is used to generate the documentation for each function
# 1. Functions are looked up in `sourceCodeDirectory` and
# 1. Template used to generate documentation and compiled to `targetFile`
#
# If the `cacheDirectory` is supplied, it's used to store values and hashes of the various files to avoid having
# to regenerate each time.
#
# See: documentFunctionTemplateDirectory
# Exit Code: 0 - If success
# Exit Code: 1 - Issue with file generation
# Exit Code: 2 - Argument error
#
documentFunctionsWithTemplate() {
  local start documentTemplate functionTemplate targetFile cacheDirectory checkFiles forceFlag

  local targetDirectory settingsFile
  local base
  local error
  local documentTokensFile

  cacheDirectory=
  documentTemplate=
  functionTemplate=
  targetFile=
  forceFlag=
  while [ $# -gt 0 ]; do
    case "$1" in
      --force)
        forceFlag=1
        ;;
      *)
        if [ -z "$cacheDirectory" ]; then
          cacheDirectory=$1
          cacheDirectory=${cacheDirectory%%/}
        elif [ -z "$documentTemplate" ]; then
          documentTemplate=$1
        elif [ -z "$functionTemplate" ]; then
          functionTemplate=$1
        elif [ -z "$targetFile" ]; then
          targetFile=$1
        else
          consoleError "${FUNCNAME[0]} [ --force ] cacheDirectory documentTemplate functionTemplate targetFile - unknown argument" 1>&2
          return "$errorArgument"
        fi
        ;;
    esac
    shift || return $errorArgument
  done

  if ! start=$(beginTiming); then
    consoleError "${FUNCNAME[0]} - beginTiming failed" 1>&2
    return $errorEnvironment
  fi

  # Validate arguments
  if [ -z "$cacheDirectory" ]; then
    consoleError "cacheDirectory is required" 1>&2
    return "$errorArgument"
  fi
  if [ -z "$documentTemplate" ]; then
    consoleError "documentTemplate is required" 1>&2
    return "$errorArgument"
  fi
  if [ -z "$functionTemplate" ]; then
    consoleError "functionTemplate is required" 1>&2
    return "$errorArgument"
  fi
  if [ -z "$targetFile" ]; then
    consoleError "targetFile is required" 1>&2
    return "$errorArgument"
  fi

  if [ ! -d "$cacheDirectory" ]; then
    consoleError "$cacheDirectory was specified but is not a directory" 1>&2
    return "$errorArgument"
  fi
  if [ ! -f "$documentTemplate" ]; then
    consoleError "Source file $documentTemplate is not a directory" 1>&2
    return "$errorArgument"
  fi
  if [ ! -f "$functionTemplate" ]; then
    consoleError "$functionTemplate is not a template file" 1>&2
    return "$errorArgument"
  fi
  if [ ! -d "$(dirname "$targetFile")" ]; then
    consoleError "$targetFile directory does not exist" 1>&2
    return "$errorArgument"
  fi

  # echo cacheDirectory="$cacheDirectory"
  # echo documentTemplate="$documentTemplate"
  # echo functionTemplate="$functionTemplate"
  # echo targetFile="$targetFile"

  base="$(basename "$targetFile")"
  base="${base%%.md}"
  statusMessage consoleInfo "Generating $base ..."

  documentTokensFile=$(mktemp)

  listTokens <"$documentTemplate" >"$documentTokensFile"
  #
  # Look at source file for each function
  #
  checkFiles=("$functionTemplate" "$documentTemplate")
  while read -r token; do
    if ! settingsFile=$(documentationFunctionLookup --source "$cacheDirectory" "$token"); then
      continue
    fi
    checkFiles+=("$settingsFile")
  done <"$documentTokensFile"

  if test $forceFlag || ! isNewestFile "$targetFile" "${checkFiles[@]+${checkFiles[@]}}"; then
    (
      # subshell to hide environment tokens
      set -a
      while read -r token; do
        if ! settingsFile=$(documentationFunctionLookup "$cacheDirectory" "$token"); then
          error="Unable to find \"$token\" (using index \"$cacheDirectory\")"
          consoleError "$error" 1>&2
          declare "$token"="$error"
          continue
        fi
        statusMessage consoleInfo "Generating $base ... $(consoleValue "[$token]") ..."
        export "${token?}"
        declare "$token"="$(bashDocumentationTemplate "$settingsFile" "$functionTemplate")"
      done <"$documentTokensFile"
      if [ $(($(wc -l <"$documentTokensFile") + 0)) -eq 0 ]; then
        if [ ! -f "$targetFile" ] || ! diff -q "$documentTemplate" "$targetFile" >/dev/null; then
          printf "%s -> %s %s" "$(consoleWarning "$documentTemplate")" "$(consoleSuccess "$targetFile")" "$(consoleError "(no tokens found)")"
          cp "$documentTemplate" "$targetFile"
        fi
      else
        statusMessage consoleSuccess "Writing $targetFile using $templateFile ..."
        mapEnvironment <"$templateFile" >"$targetFile"
      fi
      clearLine
      rm "$documentTokensFile"
    )
  fi
  statusMessage consoleSuccess "$(reportTiming "$start" Generated "$targetFile" in)"
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
# See: documentFunctionsWithTemplate
# Exit Code: 0 - If success
# Exit Code: 1 - Any template file failed to generate for any reason
# Exit Code: 2 - Argument error
#
documentFunctionTemplateDirectory() {
  local start templateDirectory functionTemplate targetDirectory cacheDirectory forceFlag=()
  local base targetFile
  local documentTokensFile

  while [ $# -gt 0 ]; do
    case "$1" in
      --force)
        forceFlag=(--force)
        shift
        break
        ;;
      *)
        break
        ;;
    esac
    shift
  done

  start=$(beginTiming)
  cacheDirectory="$1"
  shift || return $errorArgument
  templateDirectory="${1%%/}"
  shift || return $errorArgument
  functionTemplate="$1"
  shift || return $errorArgument
  targetDirectory="${1%%/}"

  if [ ! -d "$cacheDirectory" ]; then
    consoleError "$cacheDirectory was specified but is not a directory" 1>&2
    return "$errorArgument"
  fi
  if [ ! -d "$templateDirectory" ]; then
    consoleError "$templateDirectory is not a directory" 1>&2
    return "$errorArgument"
  fi
  if [ ! -f "$functionTemplate" ]; then
    consoleError "$functionTemplate is not a template file" 1>&2
    return "$errorArgument"
  fi
  if [ ! -d "$targetDirectory" ]; then
    consoleError "$targetDirectory is not a directory" 1>&2
    return "$errorArgument"
  fi

  exitCode=0
  fileCount=0
  for templateFile in "$templateDirectory/"*.md; do
    base="$(basename "$templateFile")"
    targetFile="$targetDirectory/$base"
    if ! documentFunctionsWithTemplate "${forceFlag[@]+${forceFlag[@]}}" "$cacheDirectory" "$templateFile" "$functionTemplate" "$targetFile"; then
      consoleError "Failed to generate $targetFile" 1>&2
      exitCode=$errorEnvironment
    fi
    fileCount=$((fileCount + 1))
  done
  clearLine
  reportTiming "$start" "Completed generation of $fileCount $(plural $fileCount file files) in $(consoleInfo "$targetDirectory") "
  return $exitCode
}

#
# Document a function and generate a function template (markdown)
#
# Usage: bashDocumentFunction file function template
# Argument: file - Required. File in which the function is defined
# Argument: function - Required. The function name which is defined in `file`
# Argument: template - Required. A markdown template to use to map values. Post-processed with `removeUnfinishedSections`
# Exit code: 0 - Success
# Exit code: 1 - Template file not found
# Short description: Simple bash function documentation
# Deprecated: 2023-01-18
# See: bashDocumentationTemplate
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
  if ! bashExtractDocumentation "$file" "$fn" >>"$envFile"; then
    __dumpNameValue "error" "$fn was not found" >>"$envFile"
  fi
  bashDocumentationTemplate "$envFile" "$template"
  exitCode=$?
  rm "$envFile" || :
  return $exitCode
}

# See: bashDocumentFunction
# Document a function and generate a function template (markdown). To custom format any
# of the fields in this, write functions in the form `_bashDocumentFormatter_${name}Format` such that
# name matches the variable name (lowercase alphanumeric characters and underscores).
#
# Filter functions should modify the input/output pipe; an example can be found in `{file}` by looking at
# sample function `_bashDocumentFormatter_exit_code`.
#
# See: _bashDocumentFormatter_exit_code
# Usage: {fn} settingsFile template
# Argument: settingsFile - Required. Cached documentation settings.
# Argument: template - Required. A markdown template to use to map values. Post-processed with `removeUnfinishedSections`
# Exit code: 0 - Success
# Exit code: 1 - Template file not found
# Short description: Simple bash function documentation
#
bashDocumentationTemplate() {
  local envFile=$1 template=$2
  if [ ! -f "$envFile" ]; then
    consoleError "Settings file $envFile not found" 1>&2
    return $errorArgument
  fi
  if [ ! -f "$template" ]; then
    consoleError "Template $template not found" 1>&2
    return $errorArgument
  fi
  if ! (
    # subshell this does not affect anything except these commands
    set -eou pipefail
    set -a
    # shellcheck source=/dev/null
    if ! source "$envFile"; then
      set +a
      consoleError "$envFile Failed"
      prefixLines "$(consoleCode)" <"$envFile"
      return $errorEnvironment
    fi
    set +a
    while read -r envVar; do
      formatter="_bashDocumentFormatter_${envVar}"
      if [ "$(type -t "$formatter")" = "function" ]; then
        declare "$envVar"="$(printf "%s\n" "${!envVar}" | "$formatter")"
      fi
    done < <(environmentVariables)
    if ! mapEnvironment <"$template" | grep -v '# shellcheck' | removeUnfinishedSections; then
      return $?
    fi
  ); then
    consoleError "Template $template not found" 1>&2
    return $errorEnvironment
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
# Argument: `prefix` - Literal string value to prefix each argument with
# Argument: `name` - Shell value to output
# Argument: `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner
#
__dumpNameValuePrefix() {
  local prefix=$1 varName=$2
  printf "if ! read -r -d '' '%s' <<'%s'\n" "$varName" "EOF" # Single quote means no interpolation
  shift
  shift
  while [ $# -gt 0 ]; do
    printf "%s%s\n" "$prefix" "$(escapeSingleQuotes "$1")"
    shift
  done
  printf "%s\n""then\n    export '%s'\nfi\n" "EOF" "$varName"
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
# Uses `bashFindFunctionFiles` to locate bash function, then
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
# Depends: colors.sh text.sh prefixLines
#
bashExtractDocumentation() {
  local maxLines=1000 definitionFile=$1 fn=$2 definitionFile
  local line name value desc tempDoc foundNames
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
# Usage: bashFindFunctionFiles directory fnName0 [ fnName1... ]
# Argument: `directory` - The directory to search
# Argument: `fnName0` - A function to find the file in which it is defined
# Argument: `fnName1...` - Additional functions are found are output as well
# Exit Code: 0 - if one or more function definitions are found
# Exit Code: 1 - if no function definitions are found
# Environment: Generates a temporary file which is removed
# Example:     bashFindFunctionFiles . bashFindFunctionFiles
# Example:     ./bin/build/tools/autodoc.sh
# Platform: `stat` is not cross-platform
# Summary: Find where a function is defined in a directory of shell scripts
#
bashFindFunctionFiles() {
  local directory="${1%%/}"
  local functionPattern fn linesOutput phraseCount

  shift
  phraseCount=${#@}
  foundOne=$(mktemp)
  while [ "$#" -gt 0 ]; do
    fn=$1
    functionPattern="^$fn\(\) \{|^# $fn documentation"
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
# Usage: bashFindFunctionFile directory fn
# Argument: `directory` - The directory to search
# Argument: `fn` - A function to find the file in which it is defined
# Exit Code: 0 - if one or more function definitions are found
# Exit Code: 1 - if no function definitions are found
# Environment: Generates a temporary file which is removed
# Example:     bashFindFunctionFile . usage
# Summary: Find single location where a function is defined in a directory of shell scripts
#
bashFindFunctionFile() {
  local definitionFiles directory="${1%%/}" fn="$2"

  if [ ! -d "$directory" ]; then
    consoleError "$directory is not a directory" 1>&2
    return $errorArgument
  fi
  if [ -z "$fn" ]; then
    consoleError "Need a function to find is not a directory" 1>&2
    return $errorArgument
  fi
  definitionFiles=$(mktemp)
  if ! bashFindFunctionFiles "$directory" "$fn" >"$definitionFiles"; then
    rm "$definitionFiles"
    consoleError "$fn not found in $directory" 1>&2
    return 1
  fi
  definitionFile="$(head -1 "$definitionFiles")"
  rm "$definitionFiles"
  if [ -z "$definitionFile" ]; then
    consoleError "No files found for $fn in $directory" 1>&2
    return 1
  fi
  printf %s "$definitionFile"
}

#
# Given a file containing Markdown, remove header and any section which has a variable still
#
# This EXPLICITLY ignores variables with a colon to work with `{SEE:other}` syntax
#
# This operates as a filter on a file. A section is any group of contiguous lines beginning with a line
# which starts with a `#` character and then continuing to but not including the next line which starts with a `#`
# character or the end of file; which corresponds roughly to headings in Markdown.
#
# If a section contains an unused variable in the form `{variable}`, the entire section is removed from the output.
#
# This can be used to remove sections which have variables or values which are optional.
#
# If you need a section to always be displayed; provide default values or blank values for the variables in those sections
# to prevent removal.
#
# Usage: removeUnfinishedSections < inputFile > outputFile
# Argument: None
# Depends: read printf
# Exit Code: 0
# Environment: None
# Example:     map.sh < $templateFile | removeUnfinishedSections
#
removeUnfinishedSections() {
  local section=() foundVar=
  while IFS= read -r line; do
    if [ "${line:0:1}" = "#" ]; then
      if ! test "$foundVar"; then
        printf '%s\n' "${section[@]+${section[@]}}"
      fi
      section=()
      foundVar=
    fi
    if [ "$line" != "$(printf "%s" "$line" | sed 's/{[^:}]*}//g')" ]; then
      foundVar=1
    fi
    section+=("$line")
  done
  if ! test $foundVar; then
    printf '%s\n' "${section[@]+${section[@]}}"
  fi
}

#
# Simple function to make list-like things more list-like in Markdown
#
# 1. remove leading "dash space" if it exists (`- `)
# 2. Semantically, if the phrase matches `[word]+[space][dash][space]`. backtick quote the `[word]`, otherwise skip
# 3. Prefix each line with a "dash space" (`- `)
#
markdownFormatList() {
  local wordClass='[-.`_A-Za-z0-9[:space:]]' spaceClass='[[:space:]]'
  # shellcheck disable=SC2016
  sed \
    -e "s/^- //1" \
    -e "s/\`\($wordClass*\)\`${spaceClass}-${spaceClass}/\1 - /1" \
    -e "s/\($wordClass*\)${spaceClass}-${spaceClass}/- \`\1\` - /1" \
    -e "s/^\([^-]\)/- \1/1"
}

#
# Format code blocks (does markdownFormatList)
#
_bashDocumentFormatter_exit_code() {
  markdownFormatList
}

#
# Format usage blocks (indents as a code block)
#
_bashDocumentFormatter_usage() {
  prefixLines "    "
}

# #
# # Format example blocks (indents as a code block)
# #
# _bashDocumentFormatter_exampleFormat() {
#     markdownFormatList
# }
_bashDocumentFormatter_output() {
  prefixLines "    "
}

#
# Format argument blocks (does markdownFormatList)
#
_bashDocumentFormatter_argument() {
  markdownFormatList
}

#
# Format depends blocks (indents as a code block)
#
_bashDocumentFormatter_depends() {
  prefixLines "    "
}

#
# Format see block
#
_bashDocumentFormatter_see() {
  local seeItems=()
  while IFS=" " read -r -a seeItems; do
    printf "{SEE:%s}\n" "${seeItems[@]+${seeItems[@]}}"
  done || :
}
