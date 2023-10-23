#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: colors.sh text.sh apt.sh
#

errorEnvironment=1
#
# testShellScripts
#
# Requires shellcheck so should be later in the testing process to have a cleaner build
# This can be run on any directory tree to test scripts in any application.
#
# Side-effect: shellcheck is installed
#
testShellScripts() {
    local failedReasons thisYear f shFiles
    boxedHeading "Checking all shellcheck and bash -n"
    ./bin/build/install/apt.sh shellcheck
    whichApt shellcheck shellcheck

    thisYear=$(date +%Y)
    failedReasons=()
    shFiles=$(mktemp)
    find . -name '*.sh' ! -path '*/.*' -print0 >"$shFiles"
    while IFS= read -r -d '' f; do
        consoleInfo "Checking $f"
        if ! bash -n "$f" >/dev/null; then
            failedReasons+=("bash -n $f failed")
        fi
        if ! shellcheck "$f" >/dev/null; then
            failedReasons+=("shellcheck $f failed")
        fi
        if ! grep -q "Copyright &copy; $thisYear" "$f"; then
            failedReasons+=("$f missing copyright")
        fi
    done <"$shFiles"
    rm "$shFiles"

    if [ "${#failedReasons[@]}" -gt 0 ]; then
        consoleError "The following scripts failed:"
        for f in "${failedReasons[@]}"; do
            echo "    $(consoleMagenta -n "$f")$(consoleInfo -n ", ")"
        done
        consoleError "done."
        return $errorEnvironment
    else
        consoleSuccess "All scripts passed"
    fi
}
