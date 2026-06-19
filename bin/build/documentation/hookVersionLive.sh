#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-19
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\n--application application - Directory. Optional. Application home directory.\n'
base="hooks.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Get the application\'s deployed (e.g. live and published) version.\n\nWrapper for the hook `version-live`.\n\n'
descriptionLineCount="4"
file="bin/build/tools/hooks.sh"
fn="hookVersionLive"
fnMarker="hookversionlive"
foundNames=([0]="summary" [1]="argument")
line="108"
rawComment=$'Summary: Application deployed version\nGet the application\'s deployed (e.g. live and published) version.\nWrapper for the hook `version-live`.\nArgument: --help - Flag. Optional. Display this help.\nArgument: --application application - Directory. Optional. Application home directory.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/hooks.sh"
sourceHash="10965a6a7738505d4ec864bc27c451621f1536bd"
sourceLine="108"
summary="Application deployed version"
summaryComputed=""
usage="hookVersionLive [ --help ] [ --application application ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhookVersionLive'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ --application application ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help                     '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--application application  '$'\e''[[(value)]mDirectory. Optional. Application home directory.'$'\e''[[(reset)]m'$'\n'''$'\n''Get the application'\''s deployed (e.g. live and published) version.'$'\n'''$'\n''Wrapper for the hook '$'\e''[[(code)]mversion-live'$'\e''[[(reset)]m.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: hookVersionLive [ --help ] [ --application application ]'$'\n'''$'\n''    --help                     Flag. Optional. Display this help.'$'\n''    --application application  Directory. Optional. Application home directory.'$'\n'''$'\n''Get the application'\''s deployed (e.g. live and published) version.'$'\n'''$'\n''Wrapper for the hook version-live.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/hooks.md"
