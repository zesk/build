#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--debug - Flag. Optional. Show a lot of information about the approved cache."$'\n'"--no-delete - Flag. Optional. Do not delete stale approval files."$'\n'"--delete - Flag. Optional. Delete stale approval files."$'\n'""
base="interactive.sh"
description="List approved Bash script sources which can be loaded automatically by project hooks."$'\n'"Approved sources are stored in a cache structure at \`\$XDG_STATE_HOME/.interactiveApproved\`."$'\n'"Stale files are ones which no longer are associated with a file's current fingerprint."$'\n'""
environment="XDG_STATE_HOME"$'\n'""
file="bin/build/tools/interactive.sh"
fn="approvedSources"
foundNames=([0]="argument" [1]="environment" [2]="see")
rawComment="List approved Bash script sources which can be loaded automatically by project hooks."$'\n'"Argument: --debug - Flag. Optional. Show a lot of information about the approved cache."$'\n'"Argument: --no-delete - Flag. Optional. Do not delete stale approval files."$'\n'"Argument: --delete - Flag. Optional. Delete stale approval files."$'\n'"Approved sources are stored in a cache structure at \`\$XDG_STATE_HOME/.interactiveApproved\`."$'\n'"Stale files are ones which no longer are associated with a file's current fingerprint."$'\n'"Environment: XDG_STATE_HOME"$'\n'"See: XDG_STATE_HOME.sh"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="XDG_STATE_HOME.sh"$'\n'""
sourceFile="bin/build/tools/interactive.sh"
sourceHash="94de87862bd88558374367c517da7467bcaf93f9"
summary="List approved Bash script sources which can be loaded automatically"
summaryComputed="true"
usage="approvedSources [ --debug ] [ --no-delete ] [ --delete ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mapprovedSources'$'\e''[0m '$'\e''[[(blue)]m[ --debug ]'$'\e''[0m '$'\e''[[(blue)]m[ --no-delete ]'$'\e''[0m '$'\e''[[(blue)]m[ --delete ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--debug      '$'\e''[[(value)]mFlag. Optional. Show a lot of information about the approved cache.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--no-delete  '$'\e''[[(value)]mFlag. Optional. Do not delete stale approval files.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--delete     '$'\e''[[(value)]mFlag. Optional. Delete stale approval files.'$'\e''[[(reset)]m'$'\n'''$'\n''List approved Bash script sources which can be loaded automatically by project hooks.'$'\n''Approved sources are stored in a cache structure at '$'\e''[[(code)]m$XDG_STATE_HOME/.interactiveApproved'$'\e''[[(reset)]m.'$'\n''Stale files are ones which no longer are associated with a file'\''s current fingerprint.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDG_STATE_HOME'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: approvedSources [ --debug ] [ --no-delete ] [ --delete ]'$'\n'''$'\n''    --debug      Flag. Optional. Show a lot of information about the approved cache.'$'\n''    --no-delete  Flag. Optional. Do not delete stale approval files.'$'\n''    --delete     Flag. Optional. Delete stale approval files.'$'\n'''$'\n''List approved Bash script sources which can be loaded automatically by project hooks.'$'\n''Approved sources are stored in a cache structure at $XDG_STATE_HOME/.interactiveApproved.'$'\n''Stale files are ones which no longer are associated with a file'\''s current fingerprint.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDG_STATE_HOME'$'\n'''
