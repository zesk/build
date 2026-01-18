#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/path.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--first - Flag. Optional. Place any paths after this flag first in the list"$'\n'"--last - Flag. Optional. Place any paths after this flag last in the list. Default."$'\n'"path - the path to be added to the \`PATH\` environment"$'\n'""
base="path.sh"
description="Modify the PATH environment variable to add a path."$'\n'""
file="bin/build/tools/path.sh"
fn="pathConfigure"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/path.sh"
sourceModified="1768759497"
summary="Modify the PATH environment variable to add a path."
usage="pathConfigure [ --help ] [ --first ] [ --last ] [ path ]"
