#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="path - String. Optional. Path to check."$'\n'""
base="directory.sh"
description="Is a path an absolute path?"$'\n'""
exitCode="0"
file="bin/build/tools/directory.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Is a path an absolute path?"$'\n'"Argument: path - String. Optional. Path to check."$'\n'"Return Code: 0 - if all paths passed in are absolute paths (begin with \`/\`)."$'\n'"Return Code: 1 - one ore more paths are not absolute paths"$'\n'""$'\n'""
return_code="0 - if all paths passed in are absolute paths (begin with \`/\`)."$'\n'"1 - one ore more paths are not absolute paths"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1769063211"
summary="Is a path an absolute path?"
usage="pathIsAbsolute [ path ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[label]mUsage'$'\e''[0m: '$'\e''[[info]mpathIsAbsolute'$'\e''[0m '$'\e''[[blue]m[ path ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[blue]mpath  '$'\e''[[value]mString. Optional. Path to check.'$'\e''[[reset]m'$'\n'''$'\n''Is a path an absolute path?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[code]m0'$'\e''[[reset]m - if all paths passed in are absolute paths (begin with '$'\e''[[code]m/'$'\e''[[reset]m).'$'\n''- '$'\e''[[code]m1'$'\e''[[reset]m - one ore more paths are not absolute paths'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: pathIsAbsolute [ path ]'$'\n'''$'\n''    path  String. Optional. Path to check.'$'\n'''$'\n''Is a path an absolute path?'$'\n'''$'\n''Return codes:'$'\n''- 0 - if all paths passed in are absolute paths (begin with /).'$'\n''- 1 - one ore more paths are not absolute paths'$'\n'''
