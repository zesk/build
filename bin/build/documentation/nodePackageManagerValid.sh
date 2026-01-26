#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-25
# shellcheck disable=SC2034
applicationFile="bin/build/tools/node.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"managerName - String. Required. The node package manager name to check."$'\n'""
base="node.sh"
description="Is the passed node package manager name valid?"$'\n'"Without arguments, shows the valid package manager names."$'\n'""
file="bin/build/tools/node.sh"
foundNames=([0]="argument" [1]="return_code" [2]="valid_names_are")
rawComment="Is the passed node package manager name valid?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: managerName - String. Required. The node package manager name to check."$'\n'"Without arguments, shows the valid package manager names."$'\n'"Return Code: 0 - Yes, it's a valid package manager name."$'\n'"Return Code: 1 - No, it's not a valid package manager name."$'\n'"Valid names are: npm yarn"$'\n'""$'\n'""
return_code="0 - Yes, it's a valid package manager name."$'\n'"1 - No, it's not a valid package manager name."$'\n'""
sourceFile="bin/build/tools/node.sh"
sourceModified="1769184734"
summary="Is the passed node package manager name valid?"
usage="nodePackageManagerValid [ --help ] managerName"
valid_names_are="npm yarn"$'\n'""
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnodePackageManagerValid'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mmanagerName'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help       '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mmanagerName  '$'\e''[[(value)]mString. Required. The node package manager name to check.'$'\e''[[(reset)]m'$'\n'''$'\n''Is the passed node package manager name valid?'$'\n''Without arguments, shows the valid package manager names.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Yes, it'\''s a valid package manager name.'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - No, it'\''s not a valid package manager name.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: nodePackageManagerValid [ --help ] managerName'$'\n'''$'\n''    --help       Flag. Optional. Display this help.'$'\n''    managerName  String. Required. The node package manager name to check.'$'\n'''$'\n''Is the passed node package manager name valid?'$'\n''Without arguments, shows the valid package manager names.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Yes, it'\''s a valid package manager name.'$'\n''- 1 - No, it'\''s not a valid package manager name.'$'\n'''
# elapsed 0.571
