#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--fix - Flag. Optional. Fix files when possible."$'\n'"--verbose - Flag. Optional. Be verbose."$'\n'"script - File. Optional. Shell script to validate"$'\n'""
base="lint.sh"
description="Run \`shellcheck\` and \`bash -n\` on a set of bash files."$'\n'"This can be run on any directory tree to test scripts in any application."$'\n'"Shell comments must not be immediately after a function end, e.g. this is invalid:"$'\n'"    myFunc() {"$'\n'"    }"$'\n'"    # Hey"$'\n'""
example="    bashLint goo.sh"$'\n'""
file="bin/build/tools/lint.sh"
foundNames=([0]="example" [1]="argument" [2]="side_effect" [3]="return_code" [4]="output")
output="This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""
rawComment="Run \`shellcheck\` and \`bash -n\` on a set of bash files."$'\n'"This can be run on any directory tree to test scripts in any application."$'\n'"Shell comments must not be immediately after a function end, e.g. this is invalid:"$'\n'"    myFunc() {"$'\n'"    }"$'\n'"    # Hey"$'\n'"Example:     bashLint goo.sh"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --fix - Flag. Optional. Fix files when possible."$'\n'"Argument: --verbose - Flag. Optional. Be verbose."$'\n'"Argument: script - File. Optional. Shell script to validate"$'\n'"Side-effect: shellcheck is installed"$'\n'"Side-effect: Status written to stdout, errors written to stderr"$'\n'"Return Code: 0 - All found files pass \`shellcheck\` and \`bash -n\` and shell comment syntax"$'\n'"Return Code: 1 - One or more files did not pass"$'\n'"Output: This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""$'\n'""
return_code="0 - All found files pass \`shellcheck\` and \`bash -n\` and shell comment syntax"$'\n'"1 - One or more files did not pass"$'\n'""
side_effect="shellcheck is installed"$'\n'"Status written to stdout, errors written to stderr"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceHash="1117fb23c3a75ca6a646bab1404a8f455c97fb49"
summary="Run \`shellcheck\` and \`bash -n\` on a set of bash"
summaryComputed="true"
usage="bashLint [ --help ] [ --fix ] [ --verbose ] [ script ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashLint'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --fix ]'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ script ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--fix      '$'\e''[[(value)]mFlag. Optional. Fix files when possible.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--verbose  '$'\e''[[(value)]mFlag. Optional. Be verbose.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mscript     '$'\e''[[(value)]mFile. Optional. Shell script to validate'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mshellcheck'$'\e''[[(reset)]m and '$'\e''[[(code)]mbash -n'$'\e''[[(reset)]m on a set of bash files.'$'\n''This can be run on any directory tree to test scripts in any application.'$'\n''Shell comments must not be immediately after a function end, e.g. this is invalid:'$'\n''    myFunc() {'$'\n''    }'$'\n''    # Hey'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All found files pass '$'\e''[[(code)]mshellcheck'$'\e''[[(reset)]m and '$'\e''[[(code)]mbash -n'$'\e''[[(reset)]m and shell comment syntax'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more files did not pass'$'\n'''$'\n''Example:'$'\n''    bashLint goo.sh'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mbashLint [[(blue)]m[ --help ] [[(blue)]m[ --fix ] [[(blue)]m[ --verbose ] [[(blue)]m[ script ]'$'\n'''$'\n''    [[(blue)]m--help     [[(value)]mFlag. Optional. Display this help.'$'\n''    [[(blue)]m--fix      [[(value)]mFlag. Optional. Fix files when possible.'$'\n''    [[(blue)]m--verbose  [[(value)]mFlag. Optional. Be verbose.'$'\n''    [[(blue)]mscript     [[(value)]mFile. Optional. Shell script to validate'$'\n'''$'\n''Run shellcheck and bash -n on a set of bash files.'$'\n''This can be run on any directory tree to test scripts in any application.'$'\n''Shell comments must not be immediately after a function end, e.g. this is invalid:'$'\n''    myFunc() {'$'\n''    }'$'\n''    # Hey'$'\n'''$'\n''Return codes:'$'\n''- 0 - All found files pass shellcheck and bash -n and shell comment syntax'$'\n''- 1 - One or more files did not pass'$'\n'''$'\n''Example:'$'\n''    bashLint goo.sh'$'\n'''
# elapsed 3.766
