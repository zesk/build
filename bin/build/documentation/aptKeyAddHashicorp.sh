#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="terraform.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Add keys to enable apt to download terraform directly from hashicorp.com\n\n'
descriptionLineCount="2"
file="bin/build/tools/terraform.sh"
fn="aptKeyAddHashicorp"
fnMarker="aptkeyaddhashicorp"
foundNames=([0]="return_code" [1]="argument")
line="16"
original="aptKeyAddHashicorp"
rawComment=$'Add keys to enable apt to download terraform directly from hashicorp.com\nReturn Code: 1 - if environment is awry\nReturn Code: 0 - All good to install terraform\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'1 - if environment is awry\n0 - All good to install terraform\n'
sourceFile="bin/build/tools/terraform.sh"
sourceHash="a4f8e3a7c7ca38d2b31358ac40b4ce3eafce0d6f"
sourceLine="16"
summary="Add keys to enable apt to download terraform directly from"
summaryComputed="true"
usage="aptKeyAddHashicorp [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]maptKeyAddHashicorp'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Add keys to enable apt to download terraform directly from hashicorp.com'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if environment is awry'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All good to install terraform'
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyAddHashicorp [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Add keys to enable apt to download terraform directly from hashicorp.com'$'\n'''$'\n''Return codes:'$'\n''- 1 - if environment is awry'$'\n''- 0 - All good to install terraform'
documentationPath="documentation/source/tools/terraform.md"
