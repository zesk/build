#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"soundFile ... - File. Required. Sound file(s) to install in user library."$'\n'"--create - Flag. Optional. Create sound directory if it does not exist."$'\n'""
base="darwin.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install a sound file for notifications"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/darwin.sh"
fn="darwinSoundInstall"
fnMarker="darwinsoundinstall"
foundNames=([0]="argument")
line="56"
rawComment="Install a sound file for notifications"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: soundFile ... - File. Required. Sound file(s) to install in user library."$'\n'"Argument: --create - Flag. Optional. Create sound directory if it does not exist."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/darwin.sh"
sourceHash="ec705e085d0b6db06177741d264497efd1aa9f27"
sourceLine="56"
summary="Install a sound file for notifications"
summaryComputed="true"
usage="darwinSoundInstall [ --help ] soundFile ... [ --create ]"
