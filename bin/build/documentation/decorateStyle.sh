#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'style - String. Required. The style to fetch or replace.\nnewFormat - String. Optional. The new style formatting options as a string in the form `escapeCodes label`\n'
base="style.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'When `newFormat` is blank, retrieves the format style.\nOtherwise sets the new style.\n\n'
descriptionLineCount="3"
file="bin/build/tools/decorate/style.sh"
fn="decorateStyle"
fnMarker="decoratestyle"
foundNames=([0]="summary" [1]="argument")
line="11"
rawComment=$'Summary: Get or modify a decoration style\nWhen `newFormat` is blank, retrieves the format style.\nOtherwise sets the new style.\nArgument: style - String. Required. The style to fetch or replace.\nArgument: newFormat - String. Optional. The new style formatting options as a string in the form `escapeCodes label`\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/style.sh"
sourceHash="7e1bc39ef7ab83d3d3fc659a5a00cd2280aa7413"
sourceLine="11"
summary="Get or modify a decoration style"
summaryComputed=""
usage="decorateStyle style [ newFormat ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mdecorateStyle'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mstyle'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ newFormat ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(red)]mstyle      '$'\e''[[(value)]mString. Required. The style to fetch or replace.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mnewFormat  '$'\e''[[(value)]mString. Optional. The new style formatting options as a string in the form '$'\e''[[(code)]mescapeCodes label'$'\e''[[(reset)]m'$'\e''[[(reset)]m'$'\n'''$'\n''When '$'\e''[[(code)]mnewFormat'$'\e''[[(reset)]m is blank, retrieves the format style.'$'\n''Otherwise sets the new style.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: decorateStyle style [ newFormat ]'$'\n'''$'\n''    style      String. Required. The style to fetch or replace.'$'\n''    newFormat  String. Optional. The new style formatting options as a string in the form escapeCodes label'$'\n'''$'\n''When newFormat is blank, retrieves the format style.'$'\n''Otherwise sets the new style.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/decorate.md"
