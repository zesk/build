#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Output the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.\n\n'
descriptionLineCount="2"
environment=$'- `COLUMNS` - May be defined after calling this\n- `LINES` - May be defined after calling this\n'
example=$'    textRepeat $(consoleColumns)\n'
file="bin/build/tools/colors.sh"
fn="consoleColumns"
fnMarker="consolecolumns"
foundNames=([0]="summary" [1]="stdout" [2]="argument" [3]="see" [4]="example" [5]="environment" [6]="side_effect")
line="407"
rawComment=$'Summary: Column count in current console\nOutput the number of columns in the terminal. Default is 80 if not able to be determined from `TERM`.\nstdout: Integer\nArgument: --help - Flag. Optional. Display this help.\nSee: stty\nExample:     textRepeat $(consoleColumns)\nEnvironment: - `COLUMNS` - May be defined after calling this\nEnvironment: - `LINES` - May be defined after calling this\nSide Effect: MAY define two environment variables\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
see=$'stty\n'
side_effect=$'MAY define two environment variables\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="407"
stdout=$'Integer\n'
summary="Column count in current console"
summaryComputed=""
usage="consoleColumns [ --help ]"
