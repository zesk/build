#!/usr/bin/env bash
#
# documentation.sh
#
# Tools to help with documentation of shell scripts. Very simple mechanism to extract
# documentation from code. Note that bash makes a terrible template engine, but
# having no language dependencies outweighs the negatives.
#
# Copyright: Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh text.sh prefixLines
#

# IDENTICAL errorEnvironment 1
errorEnvironment=1

# IDENTICAL errorArgument 1
errorArgument=2

# Usage: usageDocument functionDefinitionFile functionName exitCode [ ... ]
# Argument: functionDefinitionFile - Required. The file in which the function is defined. If you don't know, use `bashFindFunctionFiles` or `bashFindFunctionFile`.
# Argument: functionName - Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regarldess.
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
# Usage: documentFunctionsWithTemplate sourceCodeDirectory documentTemplate functionTemplate targetFile [ cacheDirectory ]
# Argument: sourceCodeDirectory - Required. The directory where the source code lives
# Argument: documentTemplate - Required. The document template containing functions to define
# Argument: templateFile - Required. Function template file to generate documentation for functions
# Argument: targetFile - Required. Target file to generate
# Argument: cacheDirectory - Optional. If supplied, cache to reduce work when files remain unchanged.
# Short Description: Convert a template into documentation for Bash functions
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
    local start sourceCodeDirectory documentTemplate functionTemplate targetFile cacheDirectory

    local optionForce targetDirectory cacheFile tokenLookupCacheFile
    local sourceShellScript sourceShellScriptChecksum reason base checksumPrefix checksum
    local generatedChecksum error
    local documentTokensFile shaCache

    start=$(beginTiming)
    optionForce=
    while [ $# -gt 0 ]; do
        case $1 in
        --force)
            optionForce=1
            ;;
        *)
            break
            ;;
        esac
        shift
    done

    sourceCodeDirectory=${1-}
    shift || return $errorArgument
    documentTemplate="${1-}"
    shift || return $errorArgument
    functionTemplate="${1-}"
    shift || return $errorArgument
    targetFile="${1-}"
    shift || return $errorArgument
    cacheDirectory="${1-}"

    if [ ! -d "$sourceCodeDirectory" ]; then
        consoleError "Source code directory \"$sourceCodeDirectory\" is not a directory" 1>&2
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
        consoleError "$targetFile diretory does not exist" 1>&2
        return "$errorArgument"
    fi
    shaCache=""
    if [ -n "$cacheDirectory" ]; then
        if [ ! -d "$cacheDirectory" ]; then
            consoleError "$cacheDirectory was specified but is not a directory" 1>&2
            return "$errorArgument"
        fi
        cacheDirectory=${cacheDirectory%%/}
        shaCache="$cacheDirectory/cachedShaPipe"
        requireDirectory "$shaCache"
    fi
    # echo sourceCodeDirectory="$sourceCodeDirectory"
    # echo documentTemplate="$documentTemplate"
    # echo targetFile="$targetFile"
    # echo functionTemplate="$functionTemplate"
    # echo cacheDirectory="$cacheDirectory"

    templatePrefix="$(printf %s "$sourceCodeDirectory" | shaPipe | cut -b -8)"
    checksumPrefix="$(cachedShaPipe "$shaCache" "$functionTemplate")"

    reason=""
    base="$(basename "$targetFile")"
    base="${base%%.md}"
    statusMessage consoleInfo "Generating $base ..."

    # subshell to hide environment tokens
    (
        documentTokensFile=$(mktemp)
        listTokens <"$documentTemplate" >"$documentTokensFile"
        set -a
        allCached=1
        while read -r token; do
            sourceShellScript=
            sourceShellScriptChecksum=
            if [ -n "$cacheDirectory" ]; then
                tokenLookupCacheFile="$cacheDirectory/$templatePrefix/tokens/$token"
                requireFileDirectory "$tokenLookupCacheFile"
                if [ -f "$tokenLookupCacheFile" ]; then
                    sourceShellScript="$(head -n 1 "$tokenLookupCacheFile")"
                    if [ ! -f "$sourceShellScript" ]; then
                        sourceShellScript=
                        rm "$tokenLookupCacheFile"
                    else
                        sourceShellScriptChecksum="$(cachedShaPipe "$shaCache" "$sourceShellScript")"
                        if [ "$sourceShellScriptChecksum" != "$(tail -n 1 "$tokenLookupCacheFile")" ]; then
                            statusMessage consoleWarning "$sourceShellScript changed, searching for $token again"
                            sourceShellScript=
                            rm "$tokenLookupCacheFile"
                        fi
                    fi
                fi
            fi
            if [ -z "$sourceShellScript" ]; then
                sourceShellScript=$(bashFindFunctionFile "$sourceCodeDirectory" "$token")
            fi
            if [ ! -f "$sourceShellScript" ]; then
                error="Unable to find \"$token\" (from \"$documentTemplate\") in \"$sourceCodeDirectory\""
                consoleError "$error" 1>&2
                declare "$token"="$error"
                continue
            fi
            if [ -n "$cacheDirectory" ]; then
                if [ -z "$sourceShellScriptChecksum" ]; then
                    sourceShellScriptChecksum=$(cachedShaPipe "$shaCache" "$sourceShellScript")
                fi
                printf "%s\n%s" "$sourceShellScript" "$sourceShellScriptChecksum" >"$tokenLookupCacheFile"
                checksum="$checksumPrefix-"
                documentChecksum="$(cachedShaPipe "$shaCache" "$documentTemplate")"
                documentChecksum="${documentChecksum:0:8}"
                checksumFile="$cacheDirectory/$templatePrefix/$documentChecksum/$token.checksum"
                cacheFile="$cacheDirectory/$templatePrefix/$documentChecksum/$token.cache"
                requireFileDirectory "$checksumFile"
                if [ -f "$checksumFile" ] && [ -f "$cacheFile" ]; then
                    generatedChecksum=$(cat "$checksumFile")
                    if [ "$generatedChecksum" = "$checksum" ]; then
                        if test "$optionForce"; then
                            statusMessage consoleWarning "Force generating $templateFile ..."
                        else
                            export "${token?}"
                            declare "$token"="$(cat "$cacheFile")"
                            statusMessage consoleInfo "Generating $base ... $(consoleValue "[$token]") ... (using cache)"
                            continue
                        fi
                        reason="(forced)"
                    else
                        reason="(Checksum changed)"
                    fi
                else
                    reason="(Need first time processing)"
                fi
            fi

            statusMessage consoleInfo "Generating $base ... $(consoleValue "[$token]") ... $reason"
            export "${token?}"
            declare "$token"="$(bashDocumentFunction "$sourceShellScript" "$token" "$functionTemplate")"
            allCached=

            if [ -n "$cacheDirectory" ]; then
                printf %s "${!token}" >"$cacheFile"
                printf %s "$checksum" >"$checksumFile"
                statusMessage consoleSuccess "Saved $targetFile checksum $checksum ..."
            fi
        done <"$documentTokensFile"
        if [ $(($(wc -l <"$documentTokensFile") + 0)) -eq 0 ]; then
            if [ ! -f "$targetFile" ] || ! diff -q "$documentTemplate" "$targetFile" >/dev/null; then
                printf "%s -> %s %s" "$(consoleWarning "$documentTemplate")" "$(consoleSuccess "$targetFile")" "$(consoleError "(no tokens found)")"
                cp "$documentTemplate" "$targetFile"
            fi
        elif test "$allCached" && [ -f "$targetFile" ]; then
            statusMessage consoleInfo "$targetFile remains unchanged ..."
        else
            statusMessage consoleSuccess "Writing $targetFile using $templateFile ..."
            ./bin/build/map.sh <"$templateFile" >"$targetFile"
        fi
        clearLine
        rm "$documentTokensFile"
    )
    statusMessage consoleSuccess "$(reportTiming "$start" Generated "$targetFile" in)"
}

# Usage: documentFunctionsWithTemplate sourceCodeDirectory documentDirectory functionTemplate targetDiretory [ cacheDirectory ]
# Argument: sourceCodeDirectory - Required. The directory where the source code lives
# Argument: documentDirectory - Required. Directory containing documentation templates
# Argument: templateFile - Required. Function template file to generate documentation for functions
# Argument: targetDiretory - Required. Directory to create generated documentation
# Argument: cacheDirectory - Optional. If supplied, cache to reduce work when files remain unchanged.
# Short Description: Convert a directory of templates into documentation for Bash functions
# Convert a directory of templates for bash functions into full-fledged documentation.
#
# The process:
#
# 1. `documentDirectory` is scanned for files which look like `*.md`
# 1. `documentFunctionsWithTemplate` is called for each one
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
    local sourceCodeDirectory templateDirectory functionTemplate targetDirectory cacheDirectory
    local extraOptions cacheFile
    local sourceShellScript reason base targetFile checksum
    local generatedChecksum documentTokensFile

    extraOptions=()
    while [ $# -gt 0 ]; do
        case $1 in
        --force)
            extraOptions=(--force)
            ;;
        *)
            break
            ;;
        esac
        shift
    done

    sourceCodeDirectory="$1"
    shift || return $errorArgument
    templateDirectory="${1%%/}"
    shift || return $errorArgument
    functionTemplate="$1"
    shift || return $errorArgument
    targetDirectory="${1%%/}"
    shift || return $errorArgument
    cacheDirectory="${1%%/-}"

    if [ ! -d "$sourceCodeDirectory" ]; then
        consoleError "Source code directory \"$sourceCodeDirectory\" is not a directory" 1>&2
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
    if [ -n "$cacheDirectory" ]; then
        if [ ! -d "$cacheDirectory" ]; then
            consoleError "$cacheDirectory was specified but is not a directory" 1>&2
            return "$errorArgument"
        fi
    fi

    exitCode=0
    for templateFile in "$templateDirectory/"*.md; do
        base="$(basename "$templateFile")"
        targetFile="$targetDirectory/$base"
        if ! documentFunctionsWithTemplate "${extraOptions[@]+${extraOptions[@]}}" "$sourceCodeDirectory" "$templateFile" "$functionTemplate" "$targetFile" "$cacheDirectory"; then
            consoleError "Failed to generate $targetFile" 1>&2
            exitCode=$errorEnvironment
        fi
    done
    return $exitCode
}

#
# Document a function and generate a function template (markdown). To custom format any
# of the fields in this, write functions in the form `_bashDocumentFunction_${name}Format` such that
# name matches the variable name (lowercase alphanumeric characters and underscores).
#
# Filter functions should modify the input/output pipe; an example can be found in {file} by looking at
# sample functions `_bashDocumentFunction_exit_codeFormat`.
#
# Usage: bashDocumentFunction file function template
# Argument: file - Required. File in which the function is defined
# Argument: function - Required. The function name which is defined in `file`
# Argument: template - Required. A markdown template to use to map values. Postprocessed with `removeUnfinishedSections`
# Exit code: 0 - Success
# Exit code: 1 - Template file not found
# Short description: Simple bash function documentation
#
bashDocumentFunction() {
    local file=$1 fn=$2 template=$3 target
    if [ ! -f "$template" ]; then
        consoleError "Template $template not found" 1>&2
        return 1
    fi
    envFile=$(mktemp)
    target=$(mktemp)
    printf "%s\n" "#!/usr/bin/env bash" >>"$envFile"
    printf "%s\n" "set -eou pipefail" >>"$envFile"
    # set -u does not work with read which returns 1 on EOF
    if ! bashExtractDocumentation "$file" "$fn" >>"$envFile"; then
        __dumpNameValue "error" "$fn was not found" >>"$envFile"
    fi
    (
        set -eo pipefail
        chmod +x "$envFile"
        if ! "$envFile"; then
            consoleError "Failed"
            prefixLines "$(consoleCode)" <"$envFile"
            return $errorEnvironment
        fi

        set -a
        # shellcheck source=/dev/null
        source "$envFile"
        set +a

        environmentVariables >"$envFile"
        while read -r envVar; do
            formatter="_bashDocumentFunction_${envVar}Format"
            if [ "$(type -t "$formatter")" = "function" ]; then
                declare "$envVar"="$(printf "%s\n" "${!envVar}" | "$formatter")"
            fi
        done <"$envFile"
        ./bin/build/map.sh <"$template" | grep -v '# shellcheck' >"$target"
    )
    removeUnfinishedSections <"$target"
    rm "$target"
    rm "$envFile"
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
    printf "%s\nthen\n    export '%s'\nfi\n" "EOF" "$varName"
}
# This basically just does `a=${b}` in the output
#
# Short Description: Assign one value to another in bash
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
# - `short_description` - Defaults to first ten words of `description`
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
# Short Description: Generate a set of name/value pairs to document bash functions
# Usage: bashExtractDocumentation directory function
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
        if ! inArray "short_description" "${foundNames[@]+${foundNames[@]}}"; then
            __dumpNameValue "short_description" "$(trimWords 10 "${desc[0]}")"
        fi
    elif inArray "short_description" "${foundNames[@]+${foundNames[@]}}"; then
        __dumpAliasedValue description short_description
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
# Usage: bashFindFunctionFiles dirctory fnName0 [ fnName1... ]
# Argument: `directory` - The directory to search
# Argument: `fnName0` - A function to find the file in which it is defined
# Argument: `fnName1...` - Additional functions are found are output as well
# Exit Code: 0 - if one or more function definitions are found
# Exit Code: 1 - if no function definitions are found
# Environment: Generates a temporary file which is removed
# Example: bashFindFunctionFiles . bashFindFunctionFiles
# Example: ./bin/build/tools/autodoc.sh
# Platform: `stat` is not cross-platform
# Short Description: Find where a function is defined in a directory of shell scripts
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
# Usage: bashFindFunctionFile dirctory fn
# Argument: `directory` - The directory to search
# Argument: `fn` - A function to find the file in which it is defined
# Exit Code: 0 - if one or more function definitions are found
# Exit Code: 1 - if no function definitions are found
# Environment: Generates a temporary file which is removed
# Example: bashFindFunctionFile . usage
# Short Description: Find single location where a function is defined in a directory of shell scripts
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
# Example: map.sh < $templateFile | removeUnfinishedSections
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
        if [ "$line" != "$(printf "%s" "$line" | sed 's/{[^}]*}//g')" ]; then
            foundVar=1
        fi
        section+=("$line")
    done
    if ! test $foundVar; then
        printf '%s\n' "${section[@]}"
    fi
}

#
# Simple function to make list-like things more list-like in Markdown
#
# 1. remove leading "dash space" if it exists (`- `)
# 2. Semantically, if the phrase matches `[word]+[space][dash][space]`. backtick quote the `[word]`, otherwise skip
# 3. Prefix each line with a "dash space" (`- `)
#
markdownListify() {
    local wordClass='[-.`_A-Za-z0-9[:space:]]' spaceClass='[[:space:]]'
    # shellcheck disable=SC2016
    sed \
        -e "s/^- //1" \
        -e "s/\`\($wordClass*\)\`${spaceClass}-${spaceClass}/\1 - /1" \
        -e "s/\($wordClass*\)${spaceClass}-${spaceClass}/- \`\1\` - /1" \
        -e "s/^\([^-]\)/- \1/1"
}

#
# Format code blocks (does markdownListify)
#
_bashDocumentFunction_exit_codeFormat() {
    markdownListify
}

#
# Format usage blocks (indents as a code block)
#
_bashDocumentFunction_usageFormat() {
    prefixLines "    "
}

#
# Format example blocks (indents as a code block)
#
_bashDocumentFunction_exampleFormat() {
    prefixLines "    "
}

#
# Format argument blocks (does markdownListify)
#
_bashDocumentFunction_argumentFormat() {
    markdownListify
}

#
# Format depends blocks (indents as a code block)
#
_bashDocumentFunction_dependsFormat() {
    prefixLines "    "
}
