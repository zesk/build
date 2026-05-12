#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
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
rawComment=$'Installs `install-bin-build.sh` the first time in a new project, and modifies it to work in the application path.\nArgument: --help - Flag. Optional. This help.\nArgument: --diff - Flag. Optional. Show differences between new and old files if changed.\nArgument: --local - Flag. Optional. Use local copy of `install-bin-build.sh` instead of downloaded version.\nArgument: path - Directory. Optional. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.\nArgument: applicationHome - Directory. Optional. Path to the application home directory. Default is current directory.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="48"
summary="Installs \`install-bin-build.sh\` the first time in a new project, and"
summaryComputed="true"
usage="installInstallBuild [ --help ] [ --diff ] [ --local ] [ path ] [ applicationHome ] [ --help ]"
