#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="identical.sh"
description="Repair an identical \`token\` in \`destination\` from \`source\`"$'\n'"Argument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. \`# {identical}}\`) (may specify more than one)"$'\n'"Argument: token - String. Required. The token to repair."$'\n'"Argument: source - File. Required. The token file source. First occurrence is used."$'\n'"Argument: destination - File. Required. The token file to repair. Can be same as \`source\`."$'\n'"Argument: --stdout - Flag. Optional. Output changed file to \`stdout\`"$'\n'""
file="bin/build/tools/identical.sh"
foundNames=()
rawComment="Repair an identical \`token\` in \`destination\` from \`source\`"$'\n'"Argument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. \`# {identical}}\`) (may specify more than one)"$'\n'"Argument: token - String. Required. The token to repair."$'\n'"Argument: source - File. Required. The token file source. First occurrence is used."$'\n'"Argument: destination - File. Required. The token file to repair. Can be same as \`source\`."$'\n'"Argument: --stdout - Flag. Optional. Output changed file to \`stdout\`"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/identical.sh"
sourceHash="3d17e0e52d21bf0984ad94f99e9132c29a6aaed3"
summary="Repair an identical \`token\` in \`destination\` from \`source\`"
usage="identicalRepair"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]midenticalRepair'$'\e''[0m'$'\n'''$'\n''Repair an identical '$'\e''[[(code)]mtoken'$'\e''[[(reset)]m in '$'\e''[[(code)]mdestination'$'\e''[[(reset)]m from '$'\e''[[(code)]msource'$'\e''[[(reset)]m'$'\n''Argument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. '$'\e''[[(code)]m# IDENTICAL}'$'\e''[[(reset)]m) (may specify more than one)'$'\n''Argument: token - String. Required. The token to repair.'$'\n''Argument: source - File. Required. The token file source. First occurrence is used.'$'\n''Argument: destination - File. Required. The token file to repair. Can be same as '$'\e''[[(code)]msource'$'\e''[[(reset)]m.'$'\n''Argument: --stdout - Flag. Optional. Output changed file to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: identicalRepair'$'\n'''$'\n''Repair an identical token in destination from source'$'\n''Argument: --prefix prefix - Required. A text prefix to search for to identify identical sections (e.g. # IDENTICAL}) (may specify more than one)'$'\n''Argument: token - String. Required. The token to repair.'$'\n''Argument: source - File. Required. The token file source. First occurrence is used.'$'\n''Argument: destination - File. Required. The token file to repair. Can be same as source.'$'\n''Argument: --stdout - Flag. Optional. Output changed file to stdout'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.472
