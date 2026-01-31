#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="user.sh"
description="Argument: index - PositiveInteger. Required. Index (1-based) of field to select."$'\n'"Argument: user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"Argument: database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'"Summary: Quick user database look up"$'\n'"Look user up, output a single user database record."$'\n'"stdout: String. Associated record with \`index\` and \`user\`."$'\n'"File: /etc/passwd"$'\n'"Requires: grep cut returnMessage printf /etc/passwd whoami"$'\n'""
file="bin/build/tools/user.sh"
foundNames=()
rawComment="Argument: index - PositiveInteger. Required. Index (1-based) of field to select."$'\n'"Argument: user - String. Optional. User name to look up. Uses \`whoami\` if not supplied."$'\n'"Argument: database - File. Optional. User name database file to examine. Uses \`/etc/passwd\` if not supplied."$'\n'"Summary: Quick user database look up"$'\n'"Look user up, output a single user database record."$'\n'"stdout: String. Associated record with \`index\` and \`user\`."$'\n'"File: /etc/passwd"$'\n'"Requires: grep cut returnMessage printf /etc/passwd whoami"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/user.sh"
sourceHash="3e129c267173e6702926193e8e7d4f847f1f0619"
summary="Argument: index - PositiveInteger. Required. Index (1-based) of field to"
usage="userRecord"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]muserRecord'$'\e''[0m'$'\n'''$'\n''Argument: index - PositiveInteger. Required. Index (1-based) of field to select.'$'\n''Argument: user - String. Optional. User name to look up. Uses '$'\e''[[(code)]mwhoami'$'\e''[[(reset)]m if not supplied.'$'\n''Argument: database - File. Optional. User name database file to examine. Uses '$'\e''[[(code)]m/etc/passwd'$'\e''[[(reset)]m if not supplied.'$'\n''Summary: Quick user database look up'$'\n''Look user up, output a single user database record.'$'\n''stdout: String. Associated record with '$'\e''[[(code)]mindex'$'\e''[[(reset)]m and '$'\e''[[(code)]muser'$'\e''[[(reset)]m.'$'\n''File: /etc/passwd'$'\n''Requires: grep cut returnMessage printf /etc/passwd whoami'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: userRecord'$'\n'''$'\n''Argument: index - PositiveInteger. Required. Index (1-based) of field to select.'$'\n''Argument: user - String. Optional. User name to look up. Uses whoami if not supplied.'$'\n''Argument: database - File. Optional. User name database file to examine. Uses /etc/passwd if not supplied.'$'\n''Summary: Quick user database look up'$'\n''Look user up, output a single user database record.'$'\n''stdout: String. Associated record with index and user.'$'\n''File: /etc/passwd'$'\n''Requires: grep cut returnMessage printf /etc/passwd whoami'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.47
