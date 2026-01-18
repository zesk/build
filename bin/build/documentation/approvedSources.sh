#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--debug - Flag. Optional. Show a lot of information about the approved cache."$'\n'"--no-delete - Flag. Optional. Do not delete stale approval files."$'\n'"--delete - Flag. Optional. Delete stale approval files."$'\n'""
base="interactive.sh"
description="List approved Bash script sources which can be loaded automatically by project hooks."$'\n'""$'\n'"Approved sources are stored in a cache structure at \`\$XDG_STATE_HOME/.interactiveApproved\`."$'\n'"Stale files are ones which no longer are associated with a file's current fingerprint."$'\n'""
environment="XDG_STATE_HOME"$'\n'""
file="bin/build/tools/interactive.sh"
fn="approvedSources"
foundNames=([0]="argument" [1]="environment" [2]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="XDG_STATE_HOME.sh"$'\n'""
source="bin/build/tools/interactive.sh"
sourceModified="1768721469"
summary="List approved Bash script sources which can be loaded automatically"
usage="approvedSources [ --debug ] [ --no-delete ] [ --delete ]"
