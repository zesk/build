#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-24
# shellcheck disable=SC2034
applicationFile="bin/build/tools/identical.sh"
argument="--prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. \`# {identical}}\`) (may specify more than one)"$'\n'"token - String. Required. The token to repair."$'\n'"source - File. Required. The token file source. First occurrence is used."$'\n'"destination - File. Required. The token file to repair. Can be same as \`source\`."$'\n'"--stdout - Flag. Optional. Output changed file to \`stdout\`"$'\n'""
base="identical.sh"
description="Repair an identical \`token\` in \`destination\` from \`source\`"$'\n'""
exitCode="0"
file="bin/build/tools/identical.sh"
foundNames=([0]="argument")
rawComment="Repair an identical \`token\` in \`destination\` from \`source\`"$'\n'"Argument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. \`# {identical}}\`) (may specify more than one)"$'\n'"Argument: token - String. Required. The token to repair."$'\n'"Argument: source - File. Required. The token file source. First occurrence is used."$'\n'"Argument: destination - File. Required. The token file to repair. Can be same as \`source\`."$'\n'"Argument: --stdout - Flag. Optional. Output changed file to \`stdout\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceModified="1769063211"
summary="Repair an identical \`token\` in \`destination\` from \`source\`"
usage="identicalRepair --prefix prefix token source destination [ --stdout ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]midenticalRepair'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]m--prefix prefix'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mtoken'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]msource'$'\e''[0m'$'\e''[0m '$'\e''[[bold]m'$'\e''[[magenta]mdestination'$'\e''[0m'$'\e''[0m '$'\e''[[blue]m[ --stdout ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[red]m--prefix prefix  '$'\e''[[value]mRequired. A text prefix to search for to identify identical sections (e.g. '$'\e''[[code]m# IDENTICAL}'$'\e''[[reset]m) (may specify more than one)'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mtoken            '$'\e''[[value]mString. Required. The token to repair.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]msource           '$'\e''[[value]mFile. Required. The token file source. First occurrence is used.'$'\e''[[reset]m'$'\n''    '$'\e''[[red]mdestination      '$'\e''[[value]mFile. Required. The token file to repair. Can be same as '$'\e''[[code]msource'$'\e''[[reset]m.'$'\e''[[reset]m'$'\n''    '$'\e''[[blue]m--stdout         '$'\e''[[value]mFlag. Optional. Output changed file to '$'\e''[[code]mstdout'$'\e''[[reset]m'$'\e''[[reset]m'$'\n'''$'\n''Repair an identical '$'\e''[[code]mtoken'$'\e''[[reset]m in '$'\e''[[code]mdestination'$'\e''[[reset]m from '$'\e''[[code]msource'$'\e''[[reset]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - Success'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - Environment error'$'\n''- '$'\e''[[code]m2'$'\e''[[reset]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: identicalRepair --prefix prefix token source destination [ --stdout ]'$'\n'''$'\n''    --prefix prefix  Required. A text prefix to search for to identify identical sections (e.g. # IDENTICAL}) (may specify more than one)'$'\n''    token            String. Required. The token to repair.'$'\n''    source           File. Required. The token file source. First occurrence is used.'$'\n''    destination      File. Required. The token file to repair. Can be same as source.'$'\n''    --stdout         Flag. Optional. Output changed file to stdout'$'\n'''$'\n''Repair an identical token in destination from source'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
