#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="colors.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Converts backticks, bold and italic to console colors."
descriptionLineCount=""
file="bin/build/tools/colors.sh"
fn="markdownToConsole"
fnMarker="markdowntoconsole"
foundNames=([0]="summary" [1]="stdin" [2]="stdout" [3]="argument")
line="473"
rawComment=$'Summary: Converts backticks, bold and italic to console colors.\nstdin: Markdown\nstdout: decorated console output\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/colors.sh"
sourceHash="e1522f7f8cb27e1039a3dfb5f2378236eaf38df0"
sourceLine="473"
stdin=$'Markdown\n'
stdout=$'decorated console output\n'
summary="Converts backticks, bold and italic to console colors."
summaryComputed=""
usage="markdownToConsole [ --help ]"
