#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--debug - Flag. Optional. Show a lot of information about the approved cache."$'\n'"--no-delete - Flag. Optional. Do not delete stale approval files."$'\n'"--delete - Flag. Optional. Delete stale approval files."$'\n'""
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List approved Bash script sources which can be loaded automatically by project hooks."$'\n'""$'\n'"Approved sources are stored in a cache structure at \`\$XDG_STATE_HOME/.interactiveApproved\`."$'\n'"Stale files are ones which no longer are associated with a file's current fingerprint."$'\n'""$'\n'""
descriptionLineCount="5"
environment="XDG_STATE_HOME"$'\n'""
file="bin/build/tools/interactive.sh"
fn="approvedSources"
fnMarker="approvedsources"
foundNames=([0]="argument" [1]="environment" [2]="see")
line="110"
rawComment="List approved Bash script sources which can be loaded automatically by project hooks."$'\n'"Argument: --debug - Flag. Optional. Show a lot of information about the approved cache."$'\n'"Argument: --no-delete - Flag. Optional. Do not delete stale approval files."$'\n'"Argument: --delete - Flag. Optional. Delete stale approval files."$'\n'"Approved sources are stored in a cache structure at \`\$XDG_STATE_HOME/.interactiveApproved\`."$'\n'"Stale files are ones which no longer are associated with a file's current fingerprint."$'\n'"Environment: XDG_STATE_HOME"$'\n'"See: XDG_STATE_HOME.sh"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="XDG_STATE_HOME.sh"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="378aca49779b1c4a5f70a0c419c2a078d3e0d369"
sourceLine="110"
summary="List approved Bash script sources which can be loaded automatically"
summaryComputed="true"
usage="approvedSources [ --debug ] [ --no-delete ] [ --delete ]"
