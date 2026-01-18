#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/environment/convert.sh"
argument="filename - Docker environment file to check for common issues"$'\n'""
base="convert.sh"
description="Ensure an environment file is compatible with non-quoted docker environment files"$'\n'"Return Code: 1 - if errors occur"$'\n'"Return Code: 0 - if file is valid"$'\n'""$'\n'""
file="bin/build/tools/environment/convert.sh"
fn="environmentFileIsDocker"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/environment/convert.sh"
sourceModified="1768695708"
summary="Ensure an environment file is compatible with non-quoted docker environment"
usage="environmentFileIsDocker [ filename ]"
