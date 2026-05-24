#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--verbose - Flag. Optional. Use more words or phrases than absolutely essential.\n--dry-run - Flag. Optional. Do not do any thing, just say what would be done.\n--git - Flag. Remove from git.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Remove a function from the documentation cache\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationFunctionRemove"
fnMarker="documentationfunctionremove"
foundNames=([0]="argument" [1]="stdin")
line="487"
rawComment=$'Remove a function from the documentation cache\nArgument: --verbose - Flag. Optional. Use more words or phrases than absolutely essential.\nArgument: --dry-run - Flag. Optional. Do not do any thing, just say what would be done.\nArgument: --git - Flag. Remove from git.\nstdin: functionName - File with function names one per line.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="fa382137d00499e888f4c9bf0ffc9e1256277eb1"
sourceLine="487"
stdin=$'functionName - File with function names one per line.\n'
summary="Remove a function from the documentation cache"
summaryComputed="true"
usage="documentationFunctionRemove [ --verbose ] [ --dry-run ] [ --git ]"
