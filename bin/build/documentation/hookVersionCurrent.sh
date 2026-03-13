#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-03-12
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"--application application - Directory. Optional. Application home directory."$'\n'""
base="hooks.sh"
description="Application current version"$'\n'"Extracts the version from the repository"$'\n'""
file="bin/build/tools/hooks.sh"
fn="hookVersionCurrent"
foundNames=([0]="argument")
rawComment="Application current version"$'\n'"Extracts the version from the repository"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --application application - Directory. Optional. Application home directory."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/hooks.sh"
sourceHash="7d315e46c46ffd9aaf307c9d42c19a2fe3f7dfd0"
summary="Application current version"
summaryComputed="true"
usage="hookVersionCurrent [ --help ] [ --application application ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhookVersionCurrent'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --application application ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--application application  '$'\e''[[(value)]mDirectory. Optional. Application home directory.'$'\e''[[(reset)]m'$'\n'''$'\n''Application current version'$'\n''Extracts the version from the repository'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: hookVersionCurrent [ --help ] [ --application application ]'$'\n'''$'\n''    --help                     Flag. Optional. Display this help.'$'\n''    --application application  Directory. Optional. Application home directory.'$'\n'''$'\n''Application current version'$'\n''Extracts the version from the repository'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
