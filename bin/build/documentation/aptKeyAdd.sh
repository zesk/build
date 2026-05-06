#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--title keyTitle - String. Optional. Title of the key."$'\n'"--name keyName - String. Required. Name of the key used to generate file names."$'\n'"--url remoteUrl - URL. Required. Remote URL of gpg key."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="apt.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/apt.sh"
fn="aptKeyAdd"
fnMarker="aptkeyadd"
foundNames=([0]="argument" [1]="return_code")
line="77"
rawComment="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'"Argument: --title keyTitle - String. Optional. Title of the key."$'\n'"Argument: --name keyName - String. Required. Name of the key used to generate file names."$'\n'"Argument: --url remoteUrl - URL. Required. Remote URL of gpg key."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key is installed AOK"$'\n'""$'\n'""
return_code="1 - if environment is awry"$'\n'"0 - Apt key is installed AOK"$'\n'""
sourceFile="bin/build/tools/apt.sh"
sourceHash="88cf0bf4880cbbb00ac4ecc16ac7dac0654df552"
sourceLine="77"
summary="Add keys to enable apt to download terraform directly from"
summaryComputed="true"
usage="aptKeyAdd [ --title keyTitle ] --name keyName --url remoteUrl [ --help ]"
