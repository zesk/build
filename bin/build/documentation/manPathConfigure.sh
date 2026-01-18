#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/manpath.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"--first - Flag. Optional. Place any paths after this flag first in the list"$'\n'"--last - Flag. Optional. Place any paths after this flag last in the list. Default."$'\n'"path - the path to be added to the \`MANPATH\` environment"$'\n'""
base="manpath.sh"
description="Modify the MANPATH environment variable to add a path."$'\n'""$'\n'""
file="bin/build/tools/manpath.sh"
fn="manPathConfigure"
foundNames=([0]="see" [1]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="manPathRemove"$'\n'""
source="bin/build/tools/manpath.sh"
sourceModified="1768759481"
summary="Modify the MANPATH environment variable to add a path."
usage="manPathConfigure [ --help ] [ --first ] [ --last ] [ path ]"
