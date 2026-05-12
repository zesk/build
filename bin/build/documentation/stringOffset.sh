#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'needle - String. Required.\nhaystack - String. Required.\n'
base="text.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Outputs the integer offset of `needle` if found as substring in `haystack`\nIf `haystack` is not found, -1 is output\n\n'
descriptionLineCount="3"
file="bin/build/tools/text.sh"
fn="stringOffset"
fnMarker="stringoffset"
foundNames=([0]="argument" [1]="stdout")
line="1067"
rawComment=$'Outputs the integer offset of `needle` if found as substring in `haystack`\nIf `haystack` is not found, -1 is output\nArgument: needle - String. Required.\nArgument: haystack - String. Required.\nstdout: `Integer`. The offset at which the `needle` was found in `haystack`. Outputs -1 if not found.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/text.sh"
sourceHash="91ca86fbe4b525bcb3ac16ba8f966d90f969a4c2"
sourceLine="1067"
stdout=$'`Integer`. The offset at which the `needle` was found in `haystack`. Outputs -1 if not found.\n'
summary="Outputs the integer offset of \`needle\` if found as substring"
summaryComputed="true"
usage="stringOffset needle haystack"
