#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="vendor.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Open a file in a shell using the program we are using. Supports VSCode and PHPStorm."$'\n'""$'\n'""
descriptionLineCount="2"
environment="EDITOR - Used as a default editor (first)"$'\n'"VISUAL - Used as another default editor (last)"$'\n'""
file="bin/build/tools/vendor.sh"
fn="contextOpen"
fnMarker="contextopen"
foundNames=([0]="environment" [1]="argument")
line="76"
rawComment="Open a file in a shell using the program we are using. Supports VSCode and PHPStorm."$'\n'"Environment: EDITOR - Used as a default editor (first)"$'\n'"Environment: VISUAL - Used as another default editor (last)"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/vendor.sh"
sourceHash="6a1c6758472ed8ae9048cda1a9a026cbbe718421"
sourceLine="76"
summary="Open a file in a shell using the program we"
summaryComputed="true"
usage="contextOpen [ --help ]"
