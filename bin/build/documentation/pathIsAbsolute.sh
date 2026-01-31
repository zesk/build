#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="directory.sh"
description="Is a path an absolute path?"$'\n'"Argument: path - String. Optional. Path to check."$'\n'"Return Code: 0 - if all paths passed in are absolute paths (begin with \`/\`)."$'\n'"Return Code: 1 - one ore more paths are not absolute paths"$'\n'""
file="bin/build/tools/directory.sh"
foundNames=()
rawComment="Is a path an absolute path?"$'\n'"Argument: path - String. Optional. Path to check."$'\n'"Return Code: 0 - if all paths passed in are absolute paths (begin with \`/\`)."$'\n'"Return Code: 1 - one ore more paths are not absolute paths"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="48944c2d998ec4950146d3ca4b1eba7cb335709c"
summary="Is a path an absolute path?"
usage="pathIsAbsolute"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpathIsAbsolute'$'\e''[0m'$'\n'''$'\n''Is a path an absolute path?'$'\n''Argument: path - String. Optional. Path to check.'$'\n''Return Code: 0 - if all paths passed in are absolute paths (begin with '$'\e''[[(code)]m/'$'\e''[[(reset)]m).'$'\n''Return Code: 1 - one ore more paths are not absolute paths'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pathIsAbsolute'$'\n'''$'\n''Is a path an absolute path?'$'\n''Argument: path - String. Optional. Path to check.'$'\n''Return Code: 0 - if all paths passed in are absolute paths (begin with /).'$'\n''Return Code: 1 - one ore more paths are not absolute paths'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.829
