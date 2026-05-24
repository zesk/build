#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nmanagerName - String. Required. The node package manager name to check.\n'
base="node.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Is the passed node package manager name valid?\nWithout arguments, shows the valid package manager names.\n\n'
descriptionLineCount="3"
file="bin/build/tools/node.sh"
fn="nodePackageManagerValid"
fnMarker="nodepackagemanagervalid"
foundNames=([0]="argument" [1]="return_code" [2]="valid_names_are")
line="211"
rawComment=$'Is the passed node package manager name valid?\nArgument: --help - Flag. Optional. Display this help.\nArgument: managerName - String. Required. The node package manager name to check.\nWithout arguments, shows the valid package manager names.\nReturn Code: 0 - Yes, it\'s a valid package manager name.\nReturn Code: 1 - No, it\'s not a valid package manager name.\nValid names are: npm yarn\n\n'
return_code=$'0 - Yes, it\'s a valid package manager name.\n1 - No, it\'s not a valid package manager name.\n'
sourceFile="bin/build/tools/node.sh"
sourceHash="8132e556929eccd9f09b20255ecdb3ce3b714a1e"
sourceLine="211"
summary="Is the passed node package manager name valid?"
summaryComputed="true"
usage="nodePackageManagerValid [ --help ] managerName"
valid_names_are=$'npm yarn\n'
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnodePackageManagerValid'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mmanagerName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mmanagerName  '$'\e''[[(value)]mString. Required. The node package manager name to check.'$'\e''[[(reset)]m'$'\n'''$'\n''Is the passed node package manager name valid?'$'\n''Without arguments, shows the valid package manager names.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Yes, it'\''s a valid package manager name.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No, it'\''s not a valid package manager name.'
# shellcheck disable=SC2016
helpPlain='Usage: nodePackageManagerValid [ --help ] managerName'$'\n'''$'\n''    --help       Flag. Optional. Display this help.'$'\n''    managerName  String. Required. The node package manager name to check.'$'\n'''$'\n''Is the passed node package manager name valid?'$'\n''Without arguments, shows the valid package manager names.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes, it'\''s a valid package manager name.'$'\n''- 1 - No, it'\''s not a valid package manager name.'
documentationPath="documentation/source/tools/node.md"
