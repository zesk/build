#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="--verbose - Flag. Optional. Verbose mode."$'\n'"--fix - Flag. Optional. Fix errors when possible."$'\n'"--interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"--exec binary - Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay - Integer. Optional. Delay between checks in interactive mode."$'\n'"findArgs - Additional find arguments for .sh files (or exclude directories)."$'\n'""
base="lint.sh"
BASH_LINENO=([0]="129" [1]="963" [2]="226" [3]="237" [4]="82" [5]="65" [6]="75" [7]="22" [8]="54" [9]="129" [10]="115" [11]="65" [12]="75" [13]="16" [14]="37" [15]="185" [16]="51" [17]="129" [18]="37" [19]="357" [20]="142" [21]="115" [22]="150" [23]="154" [24]="0")
description="Run \`bashLint\` on a set of bash files."$'\n'""$'\n'"Side-effect: shellcheck is installed"$'\n'"Side-effect: Status written to stdout, errors written to stderr"$'\n'"Return Code: 0 - All found files pass \`shellcheck\` and \`bash -n\`"$'\n'"Return Code: 1 - One or more files did not pass"$'\n'""
environment="This operates in the current working directory"$'\n'""
example="    if bashLintFiles; then git commit -m \"saving things\" -a; fi"$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLintFiles"
foundNames=([0]="example" [1]="argument" [2]="environment" [3]="summary" [4]="output")
output="This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/lint.sh"
sourceModified="1768756695"
summary="Check files for the existence of a string"$'\n'""
usage="bashLintFiles [ --verbose ] [ --fix ] [ --interactive ] [ --exec binary ] [ --delay ] [ findArgs ]"
