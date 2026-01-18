#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/python.sh"
argument="--bin binary - Executable. Optional. Binary for \`pip\`."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'"--help - Flag. Optional. Display this help."$'\n'"... - Arguments. Optional. Arguments passed to \`pip\`"$'\n'""
base="python.sh"
description="Run pip whether it is installed as a module or as a binary"$'\n'""
file="bin/build/tools/python.sh"
fn="pipWrapper"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/python.sh"
sourceModified="1768721469"
summary="Run pip whether it is installed as a module or"
usage="pipWrapper [ --bin binary ] [ --handler handler ] [ --help ] [ ... ]"
