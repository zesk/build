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

#
# Document a function and generate a function template (markdown). To custom format any
# of the fields in this, write functions in the form `_bashDocumentFunction_${name}Format` such that
# name matches the variable name (lowercase alphanumeric characters and underscores).
#
# Filter functions should modify the input/output pipe; an example can be found in {file} by looking at
# sample functions `_bashDocumentFunction_exit_codeFormat`.
#
#
#
# Usage: bashDocumentFunction directory function template
# Argument: `directory` - Directory to search for function definition
# Argument: `function` - The function definition to search for and to map to the template
# Argument: `template` - A markdown template to use to map values. Postprocessed with `removeUnfinishedSections`
# Exit code: 1 - Template file not found
# Exit code: 0 - Success
# Short description: Simple bash function documentation
#
bashDocumentFunction() {
    local directory=$1 fn=$2 template=$3 target
    if [ ! -f "$template" ]; then
        consoleError "Template $template not found" 1>&2
        return 1
    fi
    envFile=$(mktemp)
    printf "%s\n" "#!/usr/bin/env bash" >>"$envFile"
    printf "%s\n" "set -eou pipefail" >>"$envFile"
    # set -u does not work with read which returns 1 on EOF
    if ! bashFindFunctionDocumentation "$directory" "$fn" >>"$envFile"; then
        __dumpNameValue "error" "$fn was not found" >>"$envFile"
    fi
    target=$(mktemp)
    (
        set -eo pipefail
        set -a
        # consoleError "$envFile" 1>&2
        chmod +x "$envFile"
        if ! "$envFile"; then
            consoleError "Failed"
            prefixLines "$(consoleCode)" <"$envFile"
            return 1
        fi
        # shellcheck source=/dev/null
        source "$envFile"
        environmentVariables >"$envFile"
        while read -r envVar; do
            formatter="_bashDocumentFunction_${envVar}Format"
            if [ "$(type -t "$formatter")" = "function" ]; then
                declare "$envVar"="$(printf "%s\n" "${!envVar}" | "$formatter")"
            fi
        done <"$envFile"
        ./bin/build/map.sh <"$template" >"$target"
        set +a
    )
    removeUnfinishedSections <"$target"
    rm "$target"
}

#
# Usage: __dumpNameValue name [ value0 value1 ... ]
# Argument: `name` - Shell value to
#
__dumpNameValue() {
    local varName=$1
    printf "if ! read -r -d '' '%s' <<'%s'\n" "$varName" "EOF" # Single quote means no interpolation
    shift
    while [ $# -gt 0 ]; do
        printf "%s\n" "$(escapeSingleQuotes "$1")"
        shift
    done
    printf "%s\nthen\n    export '%s'\nfi\n" "EOF" "$varName"
}

#
# Uses `bashFindFunctionDefinition` to locate bash function, then
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
# Usage: bashFindFunctionDocumentation directory function
# Argument: `directory` - Directory
# Argument: `function` - Function to find definition for
# Depends: colors.sh text.sh prefixLines
#
bashFindFunctionDocumentation() {
    local maxLines=1000 directory=$1 fn=$2 definitionFiles foundCount definitionFile
    local line name value desc tempDoc foundNames

    if [ ! -d "$directory" ]; then
        consoleError "$directory is not a directory" 1>&2
        return 2
    fi
    if [ -z "$fn" ]; then
        consoleError "function name is blank" 1>&2
        return 2
    fi
    definitionFiles=$(mktemp)
    if ! bashFindFunctionDefinition "$directory" "$fn" >"$definitionFiles"; then
        cat "$definitionFiles"
        rm "$definitionFiles"
        consoleError "$fn not found in $directory" 1>&2
        return 1
    fi
    foundCount=$(wc -l <"$definitionFiles")
    if [ "$foundCount" -gt 1 ]; then
        consoleError "$fn found in $foundCount $(plural "$foundCount" file files):" 1>&2
        prefixLines "    $(consoleCode)" <"$definitionFiles"
        rm "$definitionFiles"
        return 1
    fi
    definitionFile="$(head -1 $definitionFiles)"
    rm "$definitionFiles"
    if [ -z "$definitionFile" ]; then
        consoleError "No files found for $fn in $directory" 1>&2
        return 1
    fi
    tempDoc=$(mktemp)
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
            desc+=("${line##:}") # strip starting colon (end colon STAYS)
        else
            value="${line#*:}"
            value="${value# }"
            name="$(lowercase "$(printf '%s' "$name" | sed 's/[^A-Za-z0-9]/_/g')")"
            if ! inArray "$name" "${foundNames[@]+${foundNames[@]}}"; then
                foundNames+=("$name")
            fi
            if [ -n "$lastName" ] && [ "$lastName" != "$name" ]; then
                __dumpNameValue "$lastName" "${values[@]}"
                values=()
            fi
            values+=("$value")
            lastName="$name"
        fi
    done <"$tempDoc"
    if [ "${#values[@]}" -gt 0 ]; then
        __dumpNameValue "$lastName" "${values[@]}"
    fi
    if [ "${#desc[@]}" -gt 0 ]; then
        __dumpNameValue "description" "${desc[@]}"
        if ! inArray "short_description" "${foundNames[@]+}"; then
            __dumpNameValue "short_description" "$(trimWords 10 "${desc[@]}")"
        fi
    fi
    __dumpNameValue "fn" "$fn"
    __dumpNameValue "file" "$definitionFile"
    __dumpNameValue "base" "$(basename "$definitionFile")"
    if ! inArray "exit_code" "${foundNames[@]+}"; then
        __dumpNameValue "exit_code" '0 - Always succeeds'
    fi
    if ! inArray "local_cache" "${foundNames[@]+}"; then
        __dumpNameValue "local_cache" 'None'
    fi
    if ! inArray "reviewed" "${foundNames[@]+}"; then
        __dumpNameValue "reviewed" 'Never'
    fi
    if ! inArray "environment" "${foundNames[@]+}"; then
        __dumpNameValue "environment" 'No environment dependencies or modifications.'
    fi
}

#
# Finds a function definition and outputs the file in which it is found
# Searches solely `.sh` files. (Bash or sh scripts)
#
# Note this function succeeds if it finds all occurrences of each function, but
# may output partial results with a failure.
#
# Usage: bashFindFunctionDefinition fnName0 [ fnName1... ]
# Argument: `fnName0` - A function to find the file in which it is defined
# Argument: `fnName1...` - Additional functions are found are output as well
# Exit Code: 0 - if one or more function definitions are found
# Exit Code: 1 - if no function definitions are found
# Environment: Generates a temporary file which is removed
# Example: bashFindFunctionDefinition bashFindFunctionDefinition
# Example: ./bin/build/tools/autodoc.sh
# Platform: `stat` is not cross-platform
# Short Description: Find where a function is defined in a directory of shell scripts
#
bashFindFunctionDefinition() {
    local directory=$1 fn linesOutput phraseCount

    shift
    phraseCount=${#@}
    foundOne=$(mktemp)
    while [ "$#" -gt 0 ]; do
        fn=$1
        find "$directory" -type f -name '*.sh' ! -path '*/.*' | while read -r f; do
            if grep -q "$fn() {" "$f"; then
                printf "%s\n" "$f"
            fi
        done
        shift
    done | tee "$foundOne"
    linesOutput=$(wc -l <"$foundOne")
    [ "$phraseCount" -eq "$linesOutput" ]
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
            if ! test $foundVar; then
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

_bashDocumentFunction_exit_codeFormat() {
    sed 's/\([0-9][0-9]*\)[[:space:]]*-[[:space:]]*/- \`\1\` - /g'
}

_bashDocumentFunction_usageFormat() {
    prefixLines "    "
}

_bashDocumentFunction_exampleFormat() {
    prefixLines "    "
}

_bashDocumentFunction_argumentFormat() {
    # shellcheck disable=SC2016
    sed 's/\([a-z][A-Z][0-9]*\)[[:space:]]*-[[:space:]]*/- \`\1\` - /g'
}

_bashDocumentFunction_dependsFormat() {
    prefixLines "    "
}
