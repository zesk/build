#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="docker.sh"
description="Are we inside a docker container right now?"$'\n'"Return Code: 0 - Yes"$'\n'"Return Code: 1 - No"$'\n'"TODO: This changed 2023 ..."$'\n'"Checked: 2025-07-09"$'\n'"TODO: Write a test to check this date every oh, say, 3 months"$'\n'""
file="bin/build/tools/docker.sh"
foundNames=()
rawComment="Are we inside a docker container right now?"$'\n'"Return Code: 0 - Yes"$'\n'"Return Code: 1 - No"$'\n'"TODO: This changed 2023 ..."$'\n'"Checked: 2025-07-09"$'\n'"TODO: Write a test to check this date every oh, say, 3 months"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceHash="6bbede2d76586a17b4acfaba444cdd98daaaf3b2"
summary="Are we inside a docker container right now?"
usage="dockerInside"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdockerInside'$'\e''[0m'$'\n'''$'\n''Are we inside a docker container right now?'$'\n''Return Code: 0 - Yes'$'\n''Return Code: 1 - No'$'\n''TODO: This changed 2023 ...'$'\n''Checked: 2025-07-09'$'\n''TODO: Write a test to check this date every oh, say, 3 months'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: dockerInside'$'\n'''$'\n''Are we inside a docker container right now?'$'\n''Return Code: 0 - Yes'$'\n''Return Code: 1 - No'$'\n''TODO: This changed 2023 ...'$'\n''Checked: 2025-07-09'$'\n''TODO: Write a test to check this date every oh, say, 3 months'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.458
