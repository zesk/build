#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="--diff - Flag. Optional.Show differences between new and old files if changed."$'\n'"--url - URL. Optional.A remote URL to download the installation script."$'\n'"--url-function - Callable. Optional.Fetch the remote URL where the installation script is found."$'\n'"--source - File. Required. The local copy of the \`--bin\` file."$'\n'"--local - Flag. Optional.Use local copy \`--bin\` instead of downloaded version."$'\n'"--bin - String. Required. Name of the installer file."$'\n'"path - Directory. Optional.Path to install the binary. Default is \`bin\`. If ends with \`.sh\` will name the binary this name."$'\n'"applicationHome - Directory. Optional.Path to the application home directory. Default is current directory."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="build.sh"
description="Installs an installer the first time in a new project, and modifies it to work in the application path."$'\n'""
file="bin/build/tools/build.sh"
fn="installInstallBinary"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/build.sh"
sourceModified="1768695708"
summary="Installs an installer the first time in a new project,"
usage="installInstallBinary [ --diff ] [ --url ] [ --url-function ] --source [ --local ] --bin [ path ] [ applicationHome ] [ --help ]"
