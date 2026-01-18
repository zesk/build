#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="--help - Flag. Optional.This help."$'\n'"--diff - Flag. Optional.Show differences between new and old files if changed."$'\n'"--local - Flag. Optional.Use local copy of \`install-bin-build.sh\` instead of downloaded version."$'\n'"path - Directory. Optional.Path to install the binary. Default is \`bin\`. If ends with \`.sh\` will name the binary this name."$'\n'"applicationHome - Directory. Optional.Path to the application home directory. Default is current directory."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="build.sh"
description="Installs \`install-bin-build.sh\` the first time in a new project, and modifies it to work in the application path."$'\n'""
file="bin/build/tools/build.sh"
fn="installInstallBuild"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/build.sh"
sourceModified="1768695708"
summary="Installs \`install-bin-build.sh\` the first time in a new project, and"
usage="installInstallBuild [ --help ] [ --diff ] [ --local ] [ path ] [ applicationHome ] [ --help ]"
