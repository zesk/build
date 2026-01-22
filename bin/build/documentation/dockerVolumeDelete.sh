#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker.sh"
argument="name - String. Required. Volume name to delete."$'\n'""
base="docker.sh"
description="Delete a docker volume"$'\n'""
file="bin/build/tools/docker.sh"
fn="dockerVolumeDelete"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceModified="1768759328"
summary="Delete a docker volume"
usage="dockerVolumeDelete name"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdockerVolumeDelete[0m [38;2;255;255;0m[35;48;2;0;0;0mname[0m[0m

    [31mname  [1;97mString. Required. Volume name to delete.[0m

Delete a docker volume

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dockerVolumeDelete name

    name  String. Required. Volume name to delete.

Delete a docker volume

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
