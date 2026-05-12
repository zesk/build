#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nvalue - String. A value.\nfrom - String. When value matches `from`, instead print `to`\nto - String. The value to print when `from` matches `value`\n... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'map a value from one value to another given from-to pairs\n\nPrints the mapped value to stdout\n\n'
descriptionLineCount="4"
file="bin/build/tools/_sugar.sh"
fn="convertValue"
fnMarker="convertvalue"
foundNames=([0]="argument")
line="160"
rawComment=$'map a value from one value to another given from-to pairs\nPrints the mapped value to stdout\nArgument: --help - Flag. Optional. Display this help.\nArgument: value - String. A value.\nArgument: from - String. When value matches `from`, instead print `to`\nArgument: to - String. The value to print when `from` matches `value`\nArgument: ... - String. Optional. Additional from-to pairs can be passed, first matching value is used, all values will be examined if none match\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="160"
summary="map a value from one value to another given from-to"
summaryComputed="true"
usage="convertValue [ --help ] [ value ] [ from ] [ to ] [ ... ]"
