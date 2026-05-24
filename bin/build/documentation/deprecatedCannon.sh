#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--path cannonPath - Directory. Optional. Run textCannon operation starting in this directory.\nfindArgumentFunction - Function. Required. Find arguments (for `find`) for cannon.\nsearch - String. Required. String to search for\nreplace - EmptyString. Required. Replacement string.\nextraCannonArguments - Arguments. Optional. Any additional arguments are passed to `cannon`.\n'
base="deprecated-tools.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'No documentation for `deprecatedCannon`.\n'
descriptionLineCount=""
file="bin/build/tools/deprecated-tools.sh"
fn="deprecatedCannon"
fnMarker="deprecatedcannon"
foundNames=([0]="argument")
line="290"
rawComment=$'Argument: --path cannonPath - Directory. Optional. Run textCannon operation starting in this directory.\nArgument: findArgumentFunction - Function. Required. Find arguments (for `find`) for cannon.\nArgument: search - String. Required. String to search for\nArgument: replace - EmptyString. Required. Replacement string.\nArgument: extraCannonArguments - Arguments. Optional. Any additional arguments are passed to `cannon`.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/deprecated-tools.sh"
sourceHash="c58292dcfad3a5d9edce856e942a3610ee71cd20"
sourceLine="290"
summary="undocumented"
summaryComputed=""
usage="deprecatedCannon [ --path cannonPath ] findArgumentFunction search replace [ extraCannonArguments ]"
