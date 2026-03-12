#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="keyName - String. Required. One or more key names to remove."$'\n'"--skip - Flag. Optional. a Do not do \`apt-get update\` afterwards to update the database."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="apt.sh"
description="Remove apt keys"$'\n'""
file="bin/build/tools/apt.sh"
fn="aptKeyRemove"
foundNames=([0]="argument" [1]="return_code")
rawComment="Remove apt keys"$'\n'"Argument: keyName - String. Required. One or more key names to remove."$'\n'"Argument: --skip - Flag. Optional. a Do not do \`apt-get update\` afterwards to update the database."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key was removed AOK"$'\n'""$'\n'""
return_code="1 - if environment is awry"$'\n'"0 - Apt key was removed AOK"$'\n'""
sourceFile="bin/build/tools/apt.sh"
sourceHash="4984b9c9b6822f2422dcb890964923b29cf63287"
summary="Remove apt keys"
summaryComputed="true"
usage="aptKeyRemove keyName [ --skip ] [ --help ]"
