#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'""
base="rsync.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install \`rsync\`."$'\n'""$'\n'"\`rsync\` is a tool which easily keeps file directories synchronized between"$'\n'"file systems, remote systems, and locations."$'\n'""$'\n'""
descriptionLineCount="5"
file="bin/build/tools/rsync.sh"
fn="rsyncInstall"
fnMarker="rsyncinstall"
foundNames=([0]="argument")
line="16"
rawComment="Install \`rsync\`."$'\n'"\`rsync\` is a tool which easily keeps file directories synchronized between"$'\n'"file systems, remote systems, and locations."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/rsync.sh"
sourceHash="a8fa7ffd4ddfee272bfeb6c90adeeab9f2cb2867"
sourceLine="16"
summary="Install \`rsync\`."
summaryComputed="true"
usage="rsyncInstall [ --help ]"
