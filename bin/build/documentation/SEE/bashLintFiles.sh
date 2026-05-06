#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--verbose - Flag. Optional. Verbose mode."$'\n'"--fix - Flag. Optional. Fix errors when possible."$'\n'"--interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"--exec binary - Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay - Integer. Optional. Delay between checks in interactive mode."$'\n'"findArgs - Additional find arguments for .sh files (or exclude directories)."$'\n'""
base="lint.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run \`bashLint\` on a set of bash files."$'\n'""$'\n'""
descriptionLineCount="2"
environment="This operates in the current working directory"$'\n'""
example="    if bashLintFiles; then git commit -m \"saving things\" -a; fi"$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLintFiles"
fnMarker="bashlintfiles"
foundNames=([0]="example" [1]="argument" [2]="side_effect" [3]="environment" [4]="summary" [5]="return_code" [6]="output")
line="105"
output="This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""
rawComment="Run \`bashLint\` on a set of bash files."$'\n'"Example:     if bashLintFiles; then git commit -m \"saving things\" -a; fi"$'\n'"Argument: --verbose - Flag. Optional. Verbose mode."$'\n'"Argument: --fix - Flag. Optional. Fix errors when possible."$'\n'"Argument: --interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"Argument: --exec binary - Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"Argument: --delay - Integer. Optional. Delay between checks in interactive mode."$'\n'"Argument: findArgs - Additional find arguments for .sh files (or exclude directories)."$'\n'"Side-effect: Status written to stdout, errors written to stderr"$'\n'"Environment: This operates in the current working directory"$'\n'"Summary: Check files for the existence of a string"$'\n'"Return Code: 0 - All found files pass \`shellcheck\` and \`bash -n\`"$'\n'"Return Code: 1 - One or more files did not pass"$'\n'"Output: This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""$'\n'""
return_code="0 - All found files pass \`shellcheck\` and \`bash -n\`"$'\n'"1 - One or more files did not pass"$'\n'""
side_effect="Status written to stdout, errors written to stderr"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceHash="7b9146e89f6f2739b967d2534b52727bad65199c"
sourceLine="105"
summary="Check files for the existence of a string"
summaryComputed=""
usage="bashLintFiles [ --verbose ] [ --fix ] [ --interactive ] [ --exec binary ] [ --delay ] [ findArgs ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashLintFiles'$'\e''[0m '$'\e''[[(blue)]m[ --verbose ]'$'\e''[0m '$'\e''[[(blue)]m[ --fix ]'$'\e''[0m '$'\e''[[(blue)]m[ --interactive ]'$'\e''[0m '$'\e''[[(blue)]m[ --exec binary ]'$'\e''[0m '$'\e''[[(blue)]m[ --delay ]'$'\e''[0m '$'\e''[[(blue)]m[ findArgs ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--verbose      '$'\e''[[(value)]mFlag. Optional. Verbose mode.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--fix          '$'\e''[[(value)]mFlag. Optional. Fix errors when possible.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--interactive  '$'\e''[[(value)]mFlag. Optional. Interactive mode on fixing errors.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--exec binary  '$'\e''[[(value)]mRun binary with files as an argument for any failed files. Only works if you pass in item names.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--delay        '$'\e''[[(value)]mInteger. Optional. Delay between checks in interactive mode.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mfindArgs       '$'\e''[[(value)]mAdditional find arguments for .sh files (or exclude directories).'$'\e''[[(reset)]m'$'\n'''$'\n''Run '$'\e''[[(code)]mbashLint'$'\e''[[(reset)]m on a set of bash files.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All found files pass '$'\e''[[(code)]mshellcheck'$'\e''[[(reset)]m and '$'\e''[[(code)]mbash -n'$'\e''[[(reset)]m'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - One or more files did not pass'$'\n'''$'\n''Environment variables:'$'\n''- This operates in the current working directory'$'\n'''$'\n''Example:'$'\n''    if bashLintFiles; then git commit -m "saving things" -a; fi'
# shellcheck disable=SC2016
helpPlain='Usage: bashLintFiles [ --verbose ] [ --fix ] [ --interactive ] [ --exec binary ] [ --delay ] [ findArgs ]'$'\n'''$'\n''    --verbose      Flag. Optional. Verbose mode.'$'\n''    --fix          Flag. Optional. Fix errors when possible.'$'\n''    --interactive  Flag. Optional. Interactive mode on fixing errors.'$'\n''    --exec binary  Run binary with files as an argument for any failed files. Only works if you pass in item names.'$'\n''    --delay        Integer. Optional. Delay between checks in interactive mode.'$'\n''    findArgs       Additional find arguments for .sh files (or exclude directories).'$'\n'''$'\n''Run bashLint on a set of bash files.'$'\n'''$'\n''Return codes:'$'\n''- 0 - All found files pass shellcheck and bash -n'$'\n''- 1 - One or more files did not pass'$'\n'''$'\n''Environment variables:'$'\n''- This operates in the current working directory'$'\n'''$'\n''Example:'$'\n''    if bashLintFiles; then git commit -m "saving things" -a; fi'
documentationPath="documentation/source/tools/lint.md"
