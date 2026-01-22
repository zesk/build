#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--fix - Flag. Optional. Fix files when possible."$'\n'"script - File. Optional. Shell script to validate"$'\n'"verbose - Flag. Optional. Be verbose."$'\n'"script - File. Optional. Shell script to validate"$'\n'""
base="lint.sh"
description="Run \`shellcheck\` and \`bash -n\` on a set of bash files."$'\n'""$'\n'"This can be run on any directory tree to test scripts in any application."$'\n'""$'\n'"Shell comments must not be immediately after a function end, e.g. this is invalid:"$'\n'""$'\n'"    myFunc() {"$'\n'"    }"$'\n'"    # Hey"$'\n'""$'\n'"Side-effect: shellcheck is installed"$'\n'"Side-effect: Status written to stdout, errors written to stderr"$'\n'"Return Code: 0 - All found files pass \`shellcheck\` and \`bash -n\` and shell comment syntax"$'\n'"Return Code: 1 - One or more files did not pass"$'\n'""
example="    bashLint goo.sh"$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLint"
output="This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceModified="1768759461"
summary="Run \`shellcheck\` and \`bash -n\` on a set of bash"
usage="bashLint [ --help ] [ --fix ] [ script ] [ verbose ] [ script ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashLint[0m [94m[ --help ][0m [94m[ --fix ][0m [94m[ script ][0m [94m[ verbose ][0m [94m[ script ][0m

    [94m--help   [1;97mFlag. Optional. Display this help.[0m
    [94m--fix    [1;97mFlag. Optional. Fix files when possible.[0m
    [94mscript   [1;97mFile. Optional. Shell script to validate[0m
    [94mverbose  [1;97mFlag. Optional. Be verbose.[0m
    [94mscript   [1;97mFile. Optional. Shell script to validate[0m

Run [38;2;0;255;0;48;2;0;0;0mshellcheck[0m and [38;2;0;255;0;48;2;0;0;0mbash -n[0m on a set of bash files.

This can be run on any directory tree to test scripts in any application.

Shell comments must not be immediately after a function end, e.g. this is invalid:

    myFunc() {
    }
    # Hey

Side-effect: shellcheck is installed
Side-effect: Status written to stdout, errors written to stderr
Return Code: 0 - All found files pass [38;2;0;255;0;48;2;0;0;0mshellcheck[0m and [38;2;0;255;0;48;2;0;0;0mbash -n[0m and shell comment syntax
Return Code: 1 - One or more files did not pass

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    bashLint goo.sh
'
# shellcheck disable=SC2016
helpPlain='Usage: bashLint [ --help ] [ --fix ] [ script ] [ verbose ] [ script ]

    --help   Flag. Optional. Display this help.
    --fix    Flag. Optional. Fix files when possible.
    script   File. Optional. Shell script to validate
    verbose  Flag. Optional. Be verbose.
    script   File. Optional. Shell script to validate

Run shellcheck and bash -n on a set of bash files.

This can be run on any directory tree to test scripts in any application.

Shell comments must not be immediately after a function end, e.g. this is invalid:

    myFunc() {
    }
    # Hey

Side-effect: shellcheck is installed
Side-effect: Status written to stdout, errors written to stderr
Return Code: 0 - All found files pass shellcheck and bash -n and shell comment syntax
Return Code: 1 - One or more files did not pass

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Example:
    bashLint goo.sh
'
