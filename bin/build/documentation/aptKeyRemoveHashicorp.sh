#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="terraform.sh"
description="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'""
file="bin/build/tools/terraform.sh"
fn="aptKeyRemoveHashicorp"
foundNames=([0]="argument" [1]="return_code")
rawComment="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - All good to install terraform"$'\n'""$'\n'""
return_code="1 - if environment is awry"$'\n'"0 - All good to install terraform"$'\n'""
sourceFile="bin/build/tools/terraform.sh"
sourceHash="3c2857a89f3ea63f9954ca35089a6ed0053d74da"
summary="Add keys to enable apt to download terraform directly from"
summaryComputed="true"
usage="aptKeyRemoveHashicorp [ --help ]"
# shellcheck disable=SC2016
helpConsole=''
# shellcheck disable=SC2016
helpPlain=''
