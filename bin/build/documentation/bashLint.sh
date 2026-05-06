#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--fix - Flag. Optional. Fix files when possible."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"script - File. Optional. Shell script to validate"$'\n'""
base="lint.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run \`shellcheck\` and \`bash -n\` on a set of bash files."$'\n'""$'\n'"This can be run on any directory tree to test scripts in any application."$'\n'""$'\n'"Shell comments must not be immediately after a function end, e.g. this is invalid:"$'\n'""$'\n'"    myFunc() {"$'\n'"    }"$'\n'"    # Hey"$'\n'""$'\n'""
descriptionLineCount="10"
example="    bashLint goo.sh"$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLint"
fnMarker="bashlint"
foundNames=([0]="summary" [1]="see" [2]="example" [3]="argument" [4]="side_effect" [5]="return_code" [6]="output")
line="33"
output="This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""
rawComment="Summary: Check bash files for common errors"$'\n'"See: shellcheck"$'\n'"See: bashSanitize"$'\n'"Run \`shellcheck\` and \`bash -n\` on a set of bash files."$'\n'"This can be run on any directory tree to test scripts in any application."$'\n'"Shell comments must not be immediately after a function end, e.g. this is invalid:"$'\n'"    myFunc() {"$'\n'"    }"$'\n'"    # Hey"$'\n'"Example:     bashLint goo.sh"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --fix - Flag. Optional. Fix files when possible."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: script - File. Optional. Shell script to validate"$'\n'"Side-effect: Status written to stdout, errors written to stderr"$'\n'"Return Code: 0 - All found files pass \`shellcheck\` and \`bash -n\` and shell comment syntax"$'\n'"Return Code: 1 - One or more files did not pass"$'\n'"Output: This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""$'\n'""
return_code="0 - All found files pass \`shellcheck\` and \`bash -n\` and shell comment syntax"$'\n'"1 - One or more files did not pass"$'\n'""
see="shellcheck"$'\n'"bashSanitize"$'\n'""
side_effect="Status written to stdout, errors written to stderr"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceHash="7b9146e89f6f2739b967d2534b52727bad65199c"
sourceLine="33"
summary="Check bash files for common errors"
summaryComputed=""
usage="bashLint [ --help ] [ --fix ] [ --verbose ] [ script ]"
