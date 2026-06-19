#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--debug - Flag. Optional. Show a lot of information about the approved cache.\n--no-delete - Flag. Optional. Do not delete stale approval files.\n--delete - Flag. Optional. Delete stale approval files.\n'
base="interactive.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List approved Bash script sources which can be loaded automatically by project hooks.\n\nApproved sources are stored in a cache structure at `$XDG_STATE_HOME/.interactiveApproved`.\nStale files are ones which no longer are associated with a file\'s current fingerprint.\n\n'
descriptionLineCount="5"
environment=$'XDG_STATE_HOME\n'
file="bin/build/tools/interactive.sh"
fn="approvedSources"
fnMarker="approvedsources"
foundNames=([0]="argument" [1]="environment")
line="108"
rawComment=$'List approved Bash script sources which can be loaded automatically by project hooks.\nArgument: --debug - Flag. Optional. Show a lot of information about the approved cache.\nArgument: --no-delete - Flag. Optional. Do not delete stale approval files.\nArgument: --delete - Flag. Optional. Delete stale approval files.\nApproved sources are stored in a cache structure at `$XDG_STATE_HOME/.interactiveApproved`.\nStale files are ones which no longer are associated with a file\'s current fingerprint.\nEnvironment: XDG_STATE_HOME\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/interactive.sh"
sourceHash="f4796c0b7d055e906c15497340e62fd7c9cdd8ad"
sourceLine="108"
summary="List approved Bash script sources which can be loaded automatically"
summaryComputed="true"
usage="approvedSources [ --debug ] [ --no-delete ] [ --delete ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mapprovedSources'$'\e''[0m '$'\e''[[(blue)]m[ --debug ]'$'\e''[0m '$'\e''[[(blue)]m[ --no-delete ]'$'\e''[0m '$'\e''[[(blue)]m[ --delete ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--debug      '$'\e''[[(value)]mFlag. Optional. Show a lot of information about the approved cache.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--no-delete  '$'\e''[[(value)]mFlag. Optional. Do not delete stale approval files.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--delete     '$'\e''[[(value)]mFlag. Optional. Delete stale approval files.'$'\e''[[(reset)]m'$'\n'''$'\n''List approved Bash script sources which can be loaded automatically by project hooks.'$'\n'''$'\n''Approved sources are stored in a cache structure at '$'\e''[[(code)]m$XDG_STATE_HOME/.interactiveApproved'$'\e''[[(reset)]m.'$'\n''Stale files are ones which no longer are associated with a file'\''s current fingerprint.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDG_STATE_HOME'
# shellcheck disable=SC2016
helpPlain='Usage: approvedSources [ --debug ] [ --no-delete ] [ --delete ]'$'\n'''$'\n''    --debug      Flag. Optional. Show a lot of information about the approved cache.'$'\n''    --no-delete  Flag. Optional. Do not delete stale approval files.'$'\n''    --delete     Flag. Optional. Delete stale approval files.'$'\n'''$'\n''List approved Bash script sources which can be loaded automatically by project hooks.'$'\n'''$'\n''Approved sources are stored in a cache structure at $XDG_STATE_HOME/.interactiveApproved.'$'\n''Stale files are ones which no longer are associated with a file'\''s current fingerprint.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Environment variables:'$'\n''- XDG_STATE_HOME'
documentationPath="documentation/source/tools/approve.md"
