#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--diff - Flag. Optional. Show differences between new and old files if changed.\n--url - URL. Optional. A remote URL to download the installation script.\n--url-function - Callable. Optional. Fetch the remote URL where the installation script is found.\n--source - File. Required. The local copy of the `--bin` file.\n--local - Flag. Optional. Use local copy `--bin` instead of downloaded version.\n--bin - String. Required. Name of the installer file.\npath - Directory. Optional. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.\napplicationHome - Directory. Optional. Path to the application home directory. Default is current directory.\n--help - Flag. Optional. Display this help.\n'
base="build.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Installs an installer the first time in a new project, and modifies it to work in the application path.\n\n'
descriptionLineCount="2"
file="bin/build/tools/build.sh"
fn="installInstallBinary"
fnMarker="installinstallbinary"
foundNames=([0]="argument")
line="32"
rawComment=$'Installs an installer the first time in a new project, and modifies it to work in the application path.\nArgument: --diff - Flag. Optional. Show differences between new and old files if changed.\nArgument: --url - URL. Optional. A remote URL to download the installation script.\nArgument: --url-function - Callable. Optional. Fetch the remote URL where the installation script is found.\nArgument: --source - File. Required. The local copy of the `--bin` file.\nArgument: --local - Flag. Optional. Use local copy `--bin` instead of downloaded version.\nArgument: --bin - String. Required. Name of the installer file.\nArgument: path - Directory. Optional. Path to install the binary. Default is `bin`. If ends with `.sh` will name the binary this name.\nArgument: applicationHome - Directory. Optional. Path to the application home directory. Default is current directory.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/build.sh"
sourceHash="50c41962b5ba48f0c8436d5b843a0620d876d061"
sourceLine="32"
summary="Installs an installer the first time in a new project,"
summaryComputed="true"
usage="installInstallBinary [ --diff ] [ --url ] [ --url-function ] --source [ --local ] --bin [ path ] [ applicationHome ] [ --help ]"
