#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-22
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. This help.\n--diff - Flag. Optional. Show differences between new and old files if changed.\n--local - Flag. Optional. Use local copy of `install-bin-build.sh` instead of downloaded version.\npath - Directory. Optional. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.\napplicationHome - Directory. Optional. Path to the application home directory. Default is current directory.\n--help - Flag. Optional. Display this help.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.\n\n'
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="installInstallBuild"
fnMarker="installinstallbuild"
foundNames=([0]="argument")
line="48"
original="installInstallBuild"
rawComment=$'Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.\nArgument: --help - Flag. Optional. This help.\nArgument: --diff - Flag. Optional. Show differences between new and old files if changed.\nArgument: --local - Flag. Optional. Use local copy of `install-bin-build.sh` instead of downloaded version.\nArgument: path - Directory. Optional. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.\nArgument: applicationHome - Directory. Optional. Path to the application home directory. Default is current directory.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="ad79bf309643a1d00bc767734ea751c19746a277"
sourceLine="48"
summary="Installs \`install-bin-build.sh\` the first time in a new project, and"
summaryComputed="true"
usage="installInstallBuild [ --help ] [ --diff ] [ --local ] [ path ] [ applicationHome ] [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]minstallInstallBuild'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --diff ]'$'\e''[0m '$'\e''[[(blue)]m[ --local ]'$'\e''[0m '$'\e''[[(blue)]m[ path ]'$'\e''[0m '$'\e''[[(blue)]m[ applicationHome ]'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help           '$'\e''[[(value)]mFlag. Optional. This help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--diff           '$'\e''[[(value)]mFlag. Optional. Show differences between new and old files if changed.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--local          '$'\e''[[(value)]mFlag. Optional. Use local copy of '$'\e''[[(code)]minstall-bin-build.sh'$'\e''[[(reset)]m instead of downloaded version.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mpath             '$'\e''[[(value)]mDirectory. Optional. Path to install the binary. Default is '$'\e''[[(code)]mbin'$'\e''[[(reset)]m. If ends with '$'\e''[[(code)]m.sh'$'\e''[[(reset)]m will name the binary this name.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mapplicationHome  '$'\e''[[(value)]mDirectory. Optional. Path to the application home directory. Default is current directory.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help           '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Installs '$'\e''[[(code)]minstall-bin-build.sh'$'\e''[[(reset)]m the first time in a new project, and modifies it to work in the application path.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: installInstallBuild [ --help ] [ --diff ] [ --local ] [ path ] [ applicationHome ] [ --help ]'$'\n'''$'\n''    --help           Flag. Optional. This help.'$'\n''    --diff           Flag. Optional. Show differences between new and old files if changed.'$'\n''    --local          Flag. Optional. Use local copy of install-bin-build.sh instead of downloaded version.'$'\n''    path             Directory. Optional. Path to install the binary. Default is bin. If ends with .sh will name the binary this name.'$'\n''    applicationHome  Directory. Optional. Path to the application home directory. Default is current directory.'$'\n''    --help           Flag. Optional. Display this help.'$'\n'''$'\n''Installs install-bin-build.sh the first time in a new project, and modifies it to work in the application path.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/build.md"
