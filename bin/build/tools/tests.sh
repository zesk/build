#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh text.sh apt.sh
#

errorEnvironment=1
errorArgument=2
#
# testShellScripts
#
# Requires shellcheck so should be later in the testing process to have a cleaner build
# This can be run on any directory tree to test scripts in any application.
#
# Side-effect: shellcheck is installed
#
testShellScripts() {
    local thisYear
    thisYear=$(date +%Y)
    validateShellScripts
    validateFileContents sh -- "Copyright &copy; $thisYear"
}

#
# validateShellScripts
#
# Requires shellcheck so should be later in the testing process to have a cleaner build
# This can be run on any directory tree to test scripts in any application.
#
# Usage: validateShellScripts
# Example: if validateShellScripts; then git commit -m "saving things" -a; fi
# Argument: No arguments.
# Side-effect: shellcheck is installed
# Side-effect: Status written to stdout, errors written to stderr
# Environment: This operates in the current working directory
# Short Description: Check files for the existence of a string
# Exit Code: 0 - All found files pass `shellcheck` and `bash -n`
# Exit Code: 1 - One or more files did not pass
#
validateShellScripts() {
    local failedReasons thisYear f foundFiles
    consoleInfo "Checking all shellcheck and bash -n"
    ./bin/build/install/apt.sh shellcheck
    whichApt shellcheck shellcheck

    thisYear=$(date +%Y)
    failedReasons=()
    foundFiles=$(mktemp)
    find . -name '*.sh' ! -path '*/.*' -print0 >"$foundFiles"
    while IFS= read -r -d '' f; do
        clearLine
        consoleInfo -n "Checking $f"
        if ! bash -n "$f" >/dev/null; then
            failedReasons+=("bash -n $f failed")
        fi
        if ! shellcheck "$f" >/dev/null; then
            failedReasons+=("shellcheck $f failed")
        fi
    done <"$foundFiles"
    rm "$foundFiles"
    clearLine

    if [ "${#failedReasons[@]}" -gt 0 ]; then
        consoleError "The following scripts failed:" 1>&2
        for f in "${failedReasons[@]}"; do
            echo "    $(consoleMagenta -n "$f")$(consoleInfo -n ", ")" 1>&2
        done
        consoleError "done." 1>&2
        return $errorEnvironment
    else
        consoleSuccess "All scripts passed"
    fi
}

#
# Search for file extensions and ensure that text is found in each file.
#
# This can be run on any directory tree to test files in any application.
#
# By default, any directory which begins with a dot `.` will be ignored.
#
# Usage: validateFileContents extension0 [ extension1 ... ] -- text0 [ text1 ... ]
# Example: validateFileContents sh php js -- 'Widgets LLC' 'Copyright &copy; 2023'
# Argument: `extension0` - Required - the extension to search for (`*.extension`)
# Argument: `--` - Required. Separates extensions from text
# Argument: `text0` - Required. Text which must exist in each file with the extension given.
# Side-effect: Errors written to stderr, status written to stdout
# Environment: This operates in the current working directory
# Short Description: Check files for the existence of a string
# Exit Code: 0 - All found files contain all text strings
# Exit Code: 1 - One or more files does not contain all text strings
# Exit Code: 2 - Arguments error (missing extension or text)
#
validateFileContents() {
    local failedReasons f foundFiles extensions=() textMatches

    while [ $# -gt 0 ]; do
        if [ "$1" == "--" ]; then
            shift
            break
        fi
        extensions+=("-name" "*.$1" "-o")
        shift
    done
    unset 'extensions['$((${#extensions[@]} - 1))']'

    textMatches=("$@")
    if [ "${#extensions[@]}" -eq 0 ]; then
        consoleError "No extension arguments" 1>&2
        return $errorArgument
    fi
    if [ "${#textMatches[@]}" -eq 0 ]; then
        consoleError "No text match arguments" 1>&2
        return $errorArgument
    fi

    failedReasons=()
    total=0
    foundFiles=$(mktemp)
    find . "${extensions[@]}" ! -path '*/.*' -print0 >"$foundFiles"
    while IFS= read -r -d '' f; do
        clearLine
        consoleInfo -n "Checking $f"
        total=$((total + 1))
        for t in "${textMatches[@]}"; do
            if ! grep -q "$t" "$f"; then
                failedReasons+=("$f missing \"$t\"")
            fi
        done
    done <"$foundFiles"
    clearLine
    consoleInfo "Checked $total $(plural $total file files) for ${#textMatches[@]} $(plural ${#textMatches[@]} phrase phrases)"
    rm "$foundFiles"

    if [ "${#failedReasons[@]}" -gt 0 ]; then
        consoleError "The following scripts failed:" 1>&2
        for f in "${failedReasons[@]}"; do
            echo "    $(consoleMagenta -n "$f")$(consoleInfo -n ", ")" 1>&2
        done
        consoleError "done." 1>&2
        return $errorEnvironment
    else
        consoleSuccess "All scripts passed"
    fi
}
