#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="group - String. Required. Currently allowed: \"python\""$'\n'""
base="package.sh"
description="Install a package group"$'\n'"Any unrecognized groups are installed using the name as-is."$'\n'""
file="bin/build/tools/package.sh"
fn="packageGroupInstall"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/package.sh"
summary="Install a package group"
usage="packageGroupInstall group"
