#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. \`# {identical}}\`) (may specify more than one)"$'\n'"token - String. Required. The token to repair."$'\n'"source - File. Required. The token file source. First occurrence is used."$'\n'"destination - File. Required. The token file to repair. Can be same as \`source\`."$'\n'"--stdout - Flag. Optional. Output changed file to \`stdout\`"$'\n'""
base="identical.sh"
description="Repair an identical \`token\` in \`destination\` from \`source\`"$'\n'""
file="bin/build/tools/identical.sh"
fn="identicalRepair"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceModified="1768845777"
summary="Repair an identical \`token\` in \`destination\` from \`source\`"
usage="identicalRepair --prefix prefix token source destination [ --stdout ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255midenticalRepair[0m [38;2;255;255;0m[35;48;2;0;0;0m--prefix prefix[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mtoken[0m[0m [38;2;255;255;0m[35;48;2;0;0;0msource[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mdestination[0m[0m [94m[ --stdout ][0m

    [31m--prefix prefix  [1;97mRequired. A text prefix to search for to identify identical sections (e.g. [38;2;0;255;0;48;2;0;0;0m# IDENTICAL}[0m) (may specify more than one)[0m
    [31mtoken            [1;97mString. Required. The token to repair.[0m
    [31msource           [1;97mFile. Required. The token file source. First occurrence is used.[0m
    [31mdestination      [1;97mFile. Required. The token file to repair. Can be same as [38;2;0;255;0;48;2;0;0;0msource[0m.[0m
    [94m--stdout         [1;97mFlag. Optional. Output changed file to [38;2;0;255;0;48;2;0;0;0mstdout[0m[0m

Repair an identical [38;2;0;255;0;48;2;0;0;0mtoken[0m in [38;2;0;255;0;48;2;0;0;0mdestination[0m from [38;2;0;255;0;48;2;0;0;0msource[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: identicalRepair --prefix prefix token source destination [ --stdout ]

    --prefix prefix  Required. A text prefix to search for to identify identical sections (e.g. # IDENTICAL}) (may specify more than one)
    token            String. Required. The token to repair.
    source           File. Required. The token file source. First occurrence is used.
    destination      File. Required. The token file to repair. Can be same as source.
    --stdout         Flag. Optional. Output changed file to stdout

Repair an identical token in destination from source

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
