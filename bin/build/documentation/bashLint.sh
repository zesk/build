#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
    # Hey
applicationFile="bin/build/tools/lint.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"--fix - Flag. Optional.Fix files when possible."$'\n'"script - File. Optional. Shell script to validate"$'\n'"verbose - Flag. Optional. Be verbose."$'\n'"script - File. Optional. Shell script to validate"$'\n'""
base="lint.sh"
description="Run \`shellcheck\` and \`bash -n\` on a set of bash files."$'\n'""$'\n'"This can be run on any directory tree to test scripts in any application."$'\n'""$'\n'"Shell comments must not be immediately after a function end, e.g. this is invalid:"$'\n'""$'\n'"    myFunc() {"$'\n'"    }"$'\n'"    # Hey"$'\n'""$'\n'"Side-effect: shellcheck is installed"$'\n'"Side-effect: Status written to stdout, errors written to stderr"$'\n'"Return Code: 0 - All found files pass \`shellcheck\` and \`bash -n\` and shell comment syntax"$'\n'"Return Code: 1 - One or more files did not pass"$'\n'""
example="    bashLint goo.sh"$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLint"
foundNames=([0]="example" [1]="argument" [2]="output")
output="This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/lint.sh"
sourceModified="1768695708"
summary="Run \`shellcheck\` and \`bash -n\` on a set of bash"
usage="bashLint [ --help ] [ --fix ] [ script ] [ verbose ] [ script ]"
