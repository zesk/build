#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--verbose - Flag. Optional. Verbose mode."$'\n'"--fix - Flag. Optional. Fix errors when possible."$'\n'"--interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"--exec binary - Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"--delay - Integer. Optional. Delay between checks in interactive mode."$'\n'"findArgs - Additional find arguments for .sh files (or exclude directories)."$'\n'""
base="lint.sh"
description="Run \`bashLint\` on a set of bash files."$'\n'""
environment="This operates in the current working directory"$'\n'""
example="    if bashLintFiles; then git commit -m \"saving things\" -a; fi"$'\n'""
file="bin/build/tools/lint.sh"
fn="bashLintFiles"
foundNames=([0]="example" [1]="argument" [2]="side_effect" [3]="environment" [4]="summary" [5]="return_code" [6]="output")
output="This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""
rawComment="Run \`bashLint\` on a set of bash files."$'\n'"Example:     if bashLintFiles; then git commit -m \"saving things\" -a; fi"$'\n'"Argument: --verbose - Flag. Optional. Verbose mode."$'\n'"Argument: --fix - Flag. Optional. Fix errors when possible."$'\n'"Argument: --interactive - Flag. Optional. Interactive mode on fixing errors."$'\n'"Argument: --exec binary - Run binary with files as an argument for any failed files. Only works if you pass in item names."$'\n'"Argument: --delay - Integer. Optional. Delay between checks in interactive mode."$'\n'"Argument: findArgs - Additional find arguments for .sh files (or exclude directories)."$'\n'"Side-effect: Status written to stdout, errors written to stderr"$'\n'"Environment: This operates in the current working directory"$'\n'"Summary: Check files for the existence of a string"$'\n'"Return Code: 0 - All found files pass \`shellcheck\` and \`bash -n\`"$'\n'"Return Code: 1 - One or more files did not pass"$'\n'"Output: This outputs \`statusMessage\`s to \`stdout\` and errors to \`stderr\`."$'\n'""$'\n'""
return_code="0 - All found files pass \`shellcheck\` and \`bash -n\`"$'\n'"1 - One or more files did not pass"$'\n'""
side_effect="Status written to stdout, errors written to stderr"$'\n'""
sourceFile="bin/build/tools/lint.sh"
sourceHash="dcca834eb93c0078aad6d23ff607ce464551064b"
summary="Check files for the existence of a string"$'\n'""
usage="bashLintFiles [ --verbose ] [ --fix ] [ --interactive ] [ --exec binary ] [ --delay ] [ findArgs ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
