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
    local failedReasons thisYear f quietLog=$1 shFiles
    {
        boxedHeading "Checking all shellcheck and bash -n"
        ./bin/build/install/apt.sh shellcheck
        whichApt shellcheck shellcheck
    } >>"$quietLog"

    thisYear=$(date +%Y)
    failedReasons=()
    shFiles=$(mktemp)
    find . -name '*.sh' ! -path '*/.*' -print0 >"$shFiles"
    while IFS= read -r -d '' f; do
        consoleInfo "Checking $f" >>"$quietLog"
        if ! bash -n "$f"; then
            failedReasons+=("bash -n $f failed")
        fi
        if ! shellcheck "$f" >>"$quietLog"; then
            failedReasons+=("shellcheck $f failed")
        fi
        if ! grep -q "Copyright &copy; $thisYear" "$f"; then
            failedReasons+=("$f missing copyright")
        fi
    done <"$shFiles"
    rm "$shFiles"

    if [ "${#failedReasons[@]}" -gt 0 ]; then
        consoleError "The following scripts failed:" >>"$quietLog"
        for f in "${failedReasons[@]}"; do
            echo "    $(consoleMagenta -n "$f")$(consoleInfo -n ", ")" >>"$quietLog"
        done
        consoleError "done."
        return $errorEnvironment
    else
        consoleSuccess "All scripts passed" >>"$quietLog"
    fi
}
