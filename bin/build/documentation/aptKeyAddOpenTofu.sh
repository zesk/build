#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n'
base="tofu.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Add keys to enable apt to download tofu directly from opentofu.org\n\n'
descriptionLineCount="2"
file="bin/build/tools/tofu.sh"
fn="aptKeyAddOpenTofu"
fnMarker="aptkeyaddopentofu"
foundNames=([0]="argument" [1]="return_code" [2]="see")
line="19"
rawComment=$'Add keys to enable apt to download tofu directly from opentofu.org\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 1 - if environment is awry\nReturn Code: 0 - All good to install terraform\nSee: aptKeyRemoveOpenTofu\n\n'
return_code=$'1 - if environment is awry\n0 - All good to install terraform\n'
see=$'aptKeyRemoveOpenTofu\n'
sourceFile="bin/build/tools/tofu.sh"
sourceHash="12ae1e9d643df30f925d83b9f55dc8448329fef7"
sourceLine="19"
summary="Add keys to enable apt to download tofu directly from"
summaryComputed="true"
usage="aptKeyAddOpenTofu [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]maptKeyAddOpenTofu'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Add keys to enable apt to download tofu directly from opentofu.org'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if environment is awry'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - All good to install terraform'
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyAddOpenTofu [ --help ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n'''$'\n''Add keys to enable apt to download tofu directly from opentofu.org'$'\n'''$'\n''Return codes:'$'\n''- 1 - if environment is awry'$'\n''- 0 - All good to install terraform'
documentationPath="documentation/source/tools/tofu.md"
