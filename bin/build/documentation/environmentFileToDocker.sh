#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/convert.sh"
argument="envFile ... - File. Required. One or more files to convert."$'\n'""
base="convert.sh"
description="Takes any environment file and makes it docker-compatible"$'\n'""$'\n'"Outputs the compatible env to stdout"$'\n'""$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileToDocker"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment/convert.sh"
sourceModified="1768695708"
summary="Takes any environment file and makes it docker-compatible"
usage="environmentFileToDocker envFile ..."
