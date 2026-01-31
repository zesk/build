#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="path - String. Optional. Path to check."$'\n'""
base="directory.sh"
description="Is a path an absolute path?"$'\n'""
file="bin/build/tools/directory.sh"
foundNames=([0]="argument" [1]="return_code")
rawComment="Is a path an absolute path?"$'\n'"Argument: path - String. Optional. Path to check."$'\n'"Return Code: 0 - if all paths passed in are absolute paths (begin with \`/\`)."$'\n'"Return Code: 1 - one ore more paths are not absolute paths"$'\n'""$'\n'""
return_code="0 - if all paths passed in are absolute paths (begin with \`/\`)."$'\n'"1 - one ore more paths are not absolute paths"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="48944c2d998ec4950146d3ca4b1eba7cb335709c"
summary="Is a path an absolute path?"
summaryComputed="true"
usage="pathIsAbsolute [ path ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mpathIsAbsolute'$'\e''[0m '$'\e''[[(blue)]m[ path ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mpath  '$'\e''[[(value)]mString. Optional. Path to check.'$'\e''[[(reset)]m'$'\n'''$'\n''Is a path an absolute path?'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - if all paths passed in are absolute paths (begin with '$'\e''[[(code)]m/'$'\e''[[(reset)]m).'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - one ore more paths are not absolute paths'$'\n'''
# shellcheck disable=SC2016
helpPlain='[[(label)]mUsage: [[(info)]mpathIsAbsolute [[(blue)]m[ path ]'$'\n'''$'\n''    [[(blue)]mpath  [[(value)]mString. Optional. Path to check.[[(reset)]m'$'\n'''$'\n''Is a path an absolute path?'$'\n'''$'\n''Return codes:'$'\n''- [[(code)]m0[[(reset)]m - if all paths passed in are absolute paths (begin with [[(code)]m/[[(reset)]m).'$'\n''- [[(code)]m1[[(reset)]m - one ore more paths are not absolute paths'$'\n'''
# elapsed 2.946
