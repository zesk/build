#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'target - File. Required. File to update.\nversion - String. Required. Version to place at the top of the file.\n'
base="deprecated-tools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Take a deprecated.txt file and add a comment with the current version number to the top\n\n'
descriptionLineCount="2"
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedFilePrependVersion"
fnMarker="deprecatedfileprependversion"
foundNames=([0]="argument")
line="12"
rawComment=$'Take a deprecated.txt file and add a comment with the current version number to the top\nArgument: target - File. Required. File to update.\nArgument: version - String. Required. Version to place at the top of the file.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="c58292dcfad3a5d9edce856e942a3610ee71cd20"
sourceLine="12"
summary="Take a deprecated.txt file and add a comment with the"
summaryComputed="true"
usage="deprecatedFilePrependVersion target version"
