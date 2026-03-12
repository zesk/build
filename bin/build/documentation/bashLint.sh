#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--fix - Flag. Optional. Fix files when possible."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"script - File. Optional. Shell script to validate"$'\n'""
base="lint.sh"
description="Run \`shellcheck\` and \`bash -n\` on a set of bash files."$'\n'"This can be run on any directory tree to test scripts in any application."$'\n'"Shell comments must not be immediately after a function end, e.g. this is invalid:"$'\n'"    myFunc() {"$'\n'"    }"$'\n'"    # Hey"$'\n'""
example="    bashLint goo.sh"$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLint"
foundNames=([0]="summary" [1]="see" [2]="example" [3]="argument" [4]="side_effect" [5]="return_code" [6]="output")
output="This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""
rawComment="Summary: Check bash files for common errors"$'\n'"See: shellcheck"$'\n'"See: bashSanitize"$'\n'"Run \`shellcheck\` and \`bash -n\` on a set of bash files."$'\n'"This can be run on any directory tree to test scripts in any application."$'\n'"Shell comments must not be immediately after a function end, e.g. this is invalid:"$'\n'"    myFunc() {"$'\n'"    }"$'\n'"    # Hey"$'\n'"Example:     bashLint goo.sh"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --fix - Flag. Optional. Fix files when possible."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: script - File. Optional. Shell script to validate"$'\n'"Side-effect: Status written to stdout, errors written to stderr"$'\n'"Return Code: 0 - All found files pass \`shellcheck\` and \`bash -n\` and shell comment syntax"$'\n'"Return Code: 1 - One or more files did not pass"$'\n'"Output: This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""$'\n'""
return_code="0 - All found files pass \`shellcheck\` and \`bash -n\` and shell comment syntax"$'\n'"1 - One or more files did not pass"$'\n'""
see="shellcheck"$'\n'"bashSanitize"$'\n'""
side_effect="Status written to stdout, errors written to stderr"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceHash="dcca834eb93c0078aad6d23ff607ce464551064b"
summary="Check bash files for common errors"$'\n'""
usage="bashLint [ --help ] [ --fix ] [ --verbose ] [ script ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
