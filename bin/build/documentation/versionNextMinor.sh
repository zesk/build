#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/version.sh"
argument="lastVersion - String. Required. Version to calculate the next minor version."$'\n'""
base="version.sh"
description="Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1"$'\n'""
file="bin/build/tools/version.sh"
fn="versionNextMinor"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/version.sh"
sourceModified="1768759818"
summary="Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1"
usage="versionNextMinor lastVersion"
