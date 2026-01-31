#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="node.sh"
description="Is the passed node package manager name valid?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: managerName - String. Required. The node package manager name to check."$'\n'"Without arguments, shows the valid package manager names."$'\n'"Return Code: 0 - Yes, it's a valid package manager name."$'\n'"Return Code: 1 - No, it's not a valid package manager name."$'\n'"Valid names are: npm yarn"$'\n'""
file="bin/build/tools/node.sh"
foundNames=()
rawComment="Is the passed node package manager name valid?"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: managerName - String. Required. The node package manager name to check."$'\n'"Without arguments, shows the valid package manager names."$'\n'"Return Code: 0 - Yes, it's a valid package manager name."$'\n'"Return Code: 1 - No, it's not a valid package manager name."$'\n'"Valid names are: npm yarn"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/node.sh"
sourceHash="d67b7944b65b43f66e8e5cae6d4e545d0148cc56"
summary="Is the passed node package manager name valid?"
usage="nodePackageManagerValid"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnodePackageManagerValid'$'\e''[0m'$'\n'''$'\n''Is the passed node package manager name valid?'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: managerName - String. Required. The node package manager name to check.'$'\n''Without arguments, shows the valid package manager names.'$'\n''Return Code: 0 - Yes, it'\''s a valid package manager name.'$'\n''Return Code: 1 - No, it'\''s not a valid package manager name.'$'\n''Valid names are: npm yarn'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: nodePackageManagerValid'$'\n'''$'\n''Is the passed node package manager name valid?'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Argument: managerName - String. Required. The node package manager name to check.'$'\n''Without arguments, shows the valid package manager names.'$'\n''Return Code: 0 - Yes, it'\''s a valid package manager name.'$'\n''Return Code: 1 - No, it'\''s not a valid package manager name.'$'\n''Valid names are: npm yarn'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.534
