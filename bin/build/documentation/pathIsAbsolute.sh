#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="path - String. Optional. Path to check."$'\n'""
base="directory.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Is a path an absolute path?"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/directory.sh"
fn="pathIsAbsolute"
fnMarker="pathisabsolute"
foundNames=([0]="argument" [1]="return_code")
line="14"
rawComment="Is a path an absolute path?"$'\n'"Argument: path - String. Optional. Path to check."$'\n'"Return Code: 0 - if all paths passed in are absolute paths (begin with \`/\`)."$'\n'"Return Code: 1 - one ore more paths are not absolute paths"$'\n'""$'\n'""
return_code="0 - if all paths passed in are absolute paths (begin with \`/\`)."$'\n'"1 - one ore more paths are not absolute paths"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceHash="da838a55948477df4605f58aff4c29b4f13319f7"
sourceLine="14"
summary="Is a path an absolute path?"
summaryComputed="true"
usage="pathIsAbsolute [ path ]"
