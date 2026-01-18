#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/apt.sh"
argument="--title keyTitle - String. Optional. Title of the key."$'\n'"--name keyName - String. Required. Name of the key used to generate file names."$'\n'"--url remoteUrl - URL. Required. Remote URL of gpg key."$'\n'"--help - Flag. Optional.Display this help."$'\n'""
base="apt.sh"
description="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'""$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key is installed AOK"$'\n'""$'\n'""
file="bin/build/tools/apt.sh"
fn="aptKeyAdd"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/apt.sh"
sourceModified="1768695708"
summary="Add keys to enable apt to download terraform directly from"
usage="aptKeyAdd [ --title keyTitle ] --name keyName --url remoteUrl [ --help ]"
