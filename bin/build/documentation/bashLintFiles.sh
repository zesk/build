#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="--verbose - Flag. Optional. Verbose mode."$'\n'"--fix - Flag. Optional. Fix errors when possible."$'\n'"--interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"--exec binary - Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay - Integer. Optional. Delay between checks in interactive mode."$'\n'"findArgs - Additional find arguments for .sh files (or exclude directories)."$'\n'""
base="lint.sh"
description="Run \`bashLint\` on a set of bash files."$'\n'""$'\n'"Side-effect: shellcheck is installed"$'\n'"Side-effect: Status written to stdout, errors written to stderr"$'\n'"Return Code: 0 - All found files pass \`shellcheck\` and \`bash -n\`"$'\n'"Return Code: 1 - One or more files did not pass"$'\n'""
environment="This operates in the current working directory"$'\n'""
example="    if bashLintFiles; then git commit -m \"saving things\" -a; fi"$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLintFiles"
foundNames=""
output="This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceModified="1768759461"
summary="Check files for the existence of a string"$'\n'""
usage="bashLintFiles [ --verbose ] [ --fix ] [ --interactive ] [ --exec binary ] [ --delay ] [ findArgs ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashLintFiles[0m [94m[ --verbose ][0m [94m[ --fix ][0m [94m[ --interactive ][0m [94m[ --exec binary ][0m [94m[ --delay ][0m [94m[ findArgs ][0m

    [94m--verbose      [1;97mFlag. Optional. Verbose mode.[0m
    [94m--fix          [1;97mFlag. Optional. Fix errors when possible.[0m
    [94m--interactive  [1;97mFlag. Optional. Interactive mode on fixing errors.[0m
    [94m--exec binary  [1;97mRun binary with files as an argument for any failed files. Only works if you pass in item names.[0m
    [94m--delay        [1;97mInteger. Optional. Delay between checks in interactive mode.[0m
    [94mfindArgs       [1;97mAdditional find arguments for .sh files (or exclude directories).[0m

Run [38;2;0;255;0;48;2;0;0;0mbashLint[0m on a set of bash files.

Side-effect: shellcheck is installed
Side-effect: Status written to stdout, errors written to stderr
Return Code: 0 - All found files pass [38;2;0;255;0;48;2;0;0;0mshellcheck[0m and [38;2;0;255;0;48;2;0;0;0mbash -n[0m
Return Code: 1 - One or more files did not pass

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- This operates in the current working directory
- 

Example:
    if bashLintFiles; then git commit -m "saving things" -a; fi
'
# shellcheck disable=SC2016
helpPlain='Usage: bashLintFiles [ --verbose ] [ --fix ] [ --interactive ] [ --exec binary ] [ --delay ] [ findArgs ]

    --verbose      Flag. Optional. Verbose mode.
    --fix          Flag. Optional. Fix errors when possible.
    --interactive  Flag. Optional. Interactive mode on fixing errors.
    --exec binary  Run binary with files as an argument for any failed files. Only works if you pass in item names.
    --delay        Integer. Optional. Delay between checks in interactive mode.
    findArgs       Additional find arguments for .sh files (or exclude directories).

Run bashLint on a set of bash files.

Side-effect: shellcheck is installed
Side-effect: Status written to stdout, errors written to stderr
Return Code: 0 - All found files pass shellcheck and bash -n
Return Code: 1 - One or more files did not pass

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- This operates in the current working directory
- 

Example:
    if bashLintFiles; then git commit -m "saving things" -a; fi
'
