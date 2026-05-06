#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="apk.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is this an Alpine system and is apk installed?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/apk.sh"
fn="apkIsInstalled"
fnMarker="apkisinstalled"
foundNames=([0]="argument" [1]="return_code")
line="16"
rawComment="Is this an Alpine system and is apk installed?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 0 - System is an alpine system and apk is installed"$'\n'"Return Code: 1 - System is not an alpine system or apk is not installed"$'\n'""$'\n'""
return_code="0 - System is an alpine system and apk is installed"$'\n'"1 - System is not an alpine system or apk is not installed"$'\n'""
sourceFile="bin/build/tools/apk.sh"
sourceHash="5bdc3f7dc0004f26659cab9392460974cb8a949b"
sourceLine="16"
summary="Is this an Alpine system and is apk installed?"
summaryComputed="true"
usage="apkIsInstalled [ --help ]"
