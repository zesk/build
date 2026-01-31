#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="path.sh"
description="Modify the PATH environment variable to add a path."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --first - Flag. Optional. Place any paths after this flag first in the list"$'\n'"Argument: --last - Flag. Optional. Place any paths after this flag last in the list. Default."$'\n'"Argument: path - the path to be added to the \`PATH\` environment"$'\n'""
file="bin/build/tools/path.sh"
foundNames=()
rawComment="Modify the PATH environment variable to add a path."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --first - Flag. Optional. Place any paths after this flag first in the list"$'\n'"Argument: --last - Flag. Optional. Place any paths after this flag last in the list. Default."$'\n'"Argument: path - the path to be added to the \`PATH\` environment"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/path.sh"
sourceHash="8a081a9a1154d0671a3f695f37287f54f605e380"
summary="Modify the PATH environment variable to add a path."
usage="pathConfigure"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpathConfigure'$'\e''[0m'$'\n'''$'\n''Modify the PATH environment variable to add a path.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --first - Flag. Optional. Place any paths after this flag first in the list'$'\n''Argument: --last - Flag. Optional. Place any paths after this flag last in the list. Default.'$'\n''Argument: path - the path to be added to the '$'\e''[[(code)]mPATH'$'\e''[[(reset)]m environment'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pathConfigure'$'\n'''$'\n''Modify the PATH environment variable to add a path.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: --first - Flag. Optional. Place any paths after this flag first in the list'$'\n''Argument: --last - Flag. Optional. Place any paths after this flag last in the list. Default.'$'\n''Argument: path - the path to be added to the PATH environment'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.638
