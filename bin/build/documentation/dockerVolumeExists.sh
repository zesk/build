#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker.sh"
argument="name - String. Required."$'\n'""
base="docker.sh"
description="Does a docker volume exist with name?"$'\n'""
file="bin/build/tools/docker.sh"
fn="dockerVolumeExists"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceModified="1769063211"
summary="Does a docker volume exist with name?"
usage="dockerVolumeExists name"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdockerVolumeExists[0m [38;2;255;255;0m[35;48;2;0;0;0mname[0m[0m

    [31mname  [1;97mString. Required.[0m

Does a docker volume exist with name?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dockerVolumeExists name

    name  String. Required.

Does a docker volume exist with name?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
