#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/apt.sh"
argument="keyName - String. Required. One or more key names to remove."$'\n'"--skip - Flag. Optional.a Do not do \`apt-get update\` afterwards to update the database."$'\n'"--help -  Flag. Optional.Display this help."$'\n'""
base="apt.sh"
description="Remove apt keys"$'\n'""$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key was removed AOK"$'\n'""$'\n'""
file="bin/build/tools/apt.sh"
fn="aptKeyRemove"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/apt.sh"
sourceModified="1768683999"
summary="Remove apt keys"
usage="aptKeyRemove keyName [ --skip ] [ --help ]"
