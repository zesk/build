#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/apk.sh"
argument="--help -  Flag. Optional.Display this help."$'\n'""
base="apk.sh"
description="Is this an Alpine system and is apk installed?"$'\n'"Return Code: 0 - System is an alpine system and apk is installed"$'\n'"Return Code: 1 - System is not an alpine system or apk is not installed"$'\n'""
file="bin/build/tools/apk.sh"
fn="apkIsInstalled"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/apk.sh"
sourceModified="1768683825"
summary="Is this an Alpine system and is apk installed?"
usage="apkIsInstalled [ --help ]"
