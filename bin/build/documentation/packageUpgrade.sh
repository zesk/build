#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--verbose - Flag. Optional. Display progress to the terminal."$'\n'"--manager packageManager - String. Optional. Package manager to use. (apk, apt, brew)"$'\n'"--force - Flag. Optional. Force even if it was updated recently."$'\n'""
base="package.sh"
description="Upgrade packages lists and sources"$'\n'""
file="bin/build/tools/package.sh"
fn="packageUpgrade"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Upgrade packages lists and sources"
usage="packageUpgrade [ --help ] [ --verbose ] [ --manager packageManager ] [ --force ]"
