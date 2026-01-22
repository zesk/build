#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/version.sh"
argument="lastVersion - String. Required. Version to calculate the next minor version."$'\n'""
base="version.sh"
description="Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1"$'\n'""
file="bin/build/tools/version.sh"
fn="versionNextMinor"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/version.sh"
sourceModified="1768759818"
summary="Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1"
usage="versionNextMinor lastVersion"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mversionNextMinor[0m [38;2;255;255;0m[35;48;2;0;0;0mlastVersion[0m[0m

    [31mlastVersion  [1;97mString. Required. Version to calculate the next minor version.[0m

Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: versionNextMinor lastVersion

    lastVersion  String. Required. Version to calculate the next minor version.

Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
