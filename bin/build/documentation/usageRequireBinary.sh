#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="usage.sh"
description="Summary: Check that one or more binaries are installed"$'\n'"Argument: usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"Argument: binary - Required. Binary which must have a \`which\` path."$'\n'"Return Code: 1 - If any \`binary\` is not available within the current path"$'\n'"Requires the binaries to be found via \`which\`"$'\n'"Runs \`handler\` on failure"$'\n'""
file="bin/build/tools/usage.sh"
foundNames=()
rawComment="Summary: Check that one or more binaries are installed"$'\n'"Argument: usageFunction - Required. \`bash\` function already defined to output handler"$'\n'"Argument: binary - Required. Binary which must have a \`which\` path."$'\n'"Return Code: 1 - If any \`binary\` is not available within the current path"$'\n'"Requires the binaries to be found via \`which\`"$'\n'"Runs \`handler\` on failure"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/usage.sh"
sourceHash="ac3427c7ff1c70c560bb4ac0c164fb1f45f71bc5"
summary="Summary: Check that one or more binaries are installed"
usage="usageRequireBinary"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]musageRequireBinary'$'\e''[0m'$'\n'''$'\n''Summary: Check that one or more binaries are installed'$'\n''Argument: usageFunction - Required. '$'\e''[[(code)]mbash'$'\e''[[(reset)]m function already defined to output handler'$'\n''Argument: binary - Required. Binary which must have a '$'\e''[[(code)]mwhich'$'\e''[[(reset)]m path.'$'\n''Return Code: 1 - If any '$'\e''[[(code)]mbinary'$'\e''[[(reset)]m is not available within the current path'$'\n''Requires the binaries to be found via '$'\e''[[(code)]mwhich'$'\e''[[(reset)]m'$'\n''Runs '$'\e''[[(code)]mhandler'$'\e''[[(reset)]m on failure'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: usageRequireBinary'$'\n'''$'\n''Summary: Check that one or more binaries are installed'$'\n''Argument: usageFunction - Required. bash function already defined to output handler'$'\n''Argument: binary - Required. Binary which must have a which path.'$'\n''Return Code: 1 - If any binary is not available within the current path'$'\n''Requires the binaries to be found via which'$'\n''Runs handler on failure'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.463
