#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/interactive.sh"
argument="--debug - Flag. Optional. Show a lot of information about the approved cache."$'\n'"--no-delete - Flag. Optional. Do not delete stale approval files."$'\n'"--delete - Flag. Optional. Delete stale approval files."$'\n'""
base="interactive.sh"
description="List approved Bash script sources which can be loaded automatically by project hooks."$'\n'""$'\n'"Approved sources are stored in a cache structure at \`\$XDG_STATE_HOME/.interactiveApproved\`."$'\n'"Stale files are ones which no longer are associated with a file's current fingerprint."$'\n'""
environment="XDG_STATE_HOME"$'\n'""
file="bin/build/tools/interactive.sh"
fn="approvedSources"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="XDG_STATE_HOME.sh"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceModified="1768759374"
summary="List approved Bash script sources which can be loaded automatically"
usage="approvedSources [ --debug ] [ --no-delete ] [ --delete ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mapprovedSources[0m [94m[ --debug ][0m [94m[ --no-delete ][0m [94m[ --delete ][0m

    [94m--debug      [1;97mFlag. Optional. Show a lot of information about the approved cache.[0m
    [94m--no-delete  [1;97mFlag. Optional. Do not delete stale approval files.[0m
    [94m--delete     [1;97mFlag. Optional. Delete stale approval files.[0m

List approved Bash script sources which can be loaded automatically by project hooks.

Approved sources are stored in a cache structure at [38;2;0;255;0;48;2;0;0;0m$XDG_STATE_HOME/.interactiveApproved[0m.
Stale files are ones which no longer are associated with a file'\''s current fingerprint.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- XDG_STATE_HOME
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: approvedSources [ --debug ] [ --no-delete ] [ --delete ]

    --debug      Flag. Optional. Show a lot of information about the approved cache.
    --no-delete  Flag. Optional. Do not delete stale approval files.
    --delete     Flag. Optional. Delete stale approval files.

List approved Bash script sources which can be loaded automatically by project hooks.

Approved sources are stored in a cache structure at $XDG_STATE_HOME/.interactiveApproved.
Stale files are ones which no longer are associated with a file'\''s current fingerprint.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- XDG_STATE_HOME
- 
'
