#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--application application - Directory. Optional. Application home directory.\n'
base="hooks.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get the application\'s current version.\n\nWrapper for the hook `version-current`.\n\nExtracts the version from the repository\n\n'
descriptionLineCount="6"
file="bin/build/tools/hooks.sh"
fn="hookVersionCurrent"
fnMarker="hookversioncurrent"
foundNames=([0]="summary" [1]="argument")
line="93"
rawComment=$'Summary: Application current version\nGet the application\'s current version.\nWrapper for the hook `version-current`.\nExtracts the version from the repository\nArgument: --help - Flag. Optional. Display this help.\nArgument: --application application - Directory. Optional. Application home directory.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/hooks.sh"
sourceHash="10965a6a7738505d4ec864bc27c451621f1536bd"
sourceLine="93"
summary="Application current version"
summaryComputed=""
usage="hookVersionCurrent [ --help ] [ --application application ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhookVersionCurrent'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --application application ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--application application  '$'\e''[[(value)]mDirectory. Optional. Application home directory.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the application'\''s current version.'$'\n'''$'\n''Wrapper for the hook '$'\e''[[(code)]mversion-current'$'\e''[[(reset)]m.'$'\n'''$'\n''Extracts the version from the repository'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: hookVersionCurrent [ --help ] [ --application application ]'$'\n'''$'\n''    --help                     Flag. Optional. Display this help.'$'\n''    --application application  Directory. Optional. Application home directory.'$'\n'''$'\n''Get the application'\''s current version.'$'\n'''$'\n''Wrapper for the hook version-current.'$'\n'''$'\n''Extracts the version from the repository'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/hooks.md"
