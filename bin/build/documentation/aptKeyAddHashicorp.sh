#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="terraform.sh"
description="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - All good to install terraform"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/terraform.sh"
foundNames=()
rawComment="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - All good to install terraform"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/terraform.sh"
sourceHash="3c2857a89f3ea63f9954ca35089a6ed0053d74da"
summary="Add keys to enable apt to download terraform directly from"
usage="aptKeyAddHashicorp"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]maptKeyAddHashicorp'$'\e''[0m'$'\n'''$'\n''Add keys to enable apt to download terraform directly from hashicorp.com'$'\n''Return Code: 1 - if environment is awry'$'\n''Return Code: 0 - All good to install terraform'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyAddHashicorp'$'\n'''$'\n''Add keys to enable apt to download terraform directly from hashicorp.com'$'\n''Return Code: 1 - if environment is awry'$'\n''Return Code: 0 - All good to install terraform'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.436
