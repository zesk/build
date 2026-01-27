#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-27
# shellcheck disable=SC2034
applicationFile="bin/build/tools/usage.sh"
argument="usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"binary - Required. Binary which must have a \`which\` path."$'\n'""
base="usage.sh"
description="Requires the binaries to be found via \`which\`"$'\n'"Runs \`handler\` on failure"$'\n'""
file="bin/build/tools/usage.sh"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
rawComment="Summary: Check that one or more binaries are installed"$'\n'"Argument: usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"Argument: binary - Required. Binary which must have a \`which\` path."$'\n'"Return Code: 1 - If any \`binary\` is not available within the current path"$'\n'"Requires the binaries to be found via \`which\`"$'\n'"Runs \`handler\` on failure"$'\n'""$'\n'""
return_code="1 - If any \`binary\` is not available within the current path"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceModified="1769216318"
summary="Check that one or more binaries are installed"$'\n'""
usage="usageRequireBinary usageFunction binary"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]musageRequireBinary'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]musageFunction'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mbinary'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]musageFunction  '$'\e''[[(value)]mRequired. '$'\e''[[(code)]mbash'$'\e''[[(reset)]m function already defined to output handler'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mbinary         '$'\e''[[(value)]mRequired. Binary which must have a '$'\e''[[(code)]mwhich'$'\e''[[(reset)]m path.'$'\e''[[(reset)]m'$'\n'''$'\n''Requires the binaries to be found via '$'\e''[[(code)]mwhich'$'\e''[[(reset)]m'$'\n''Runs '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m on failure'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - If any '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m is not available within the current path'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: usageRequireBinary usageFunction binary'$'\n'''$'\n''    usageFunction  Required. bash function already defined to output handler'$'\n''    binary         Required. Binary which must have a which path.'$'\n'''$'\n''Requires the binaries to be found via which'$'\n''Runs handler on failure'$'\n'''$'\n''Return codes:'$'\n''- 1 - If any binary is not available within the current path'$'\n'''
# elapsed 0.508
