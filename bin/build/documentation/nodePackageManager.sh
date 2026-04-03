#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="action - String. Optional. Action to perform: install run update uninstall"$'\n'"... - Arguments. Required. Passed to the node package manager. Required. when action is provided."$'\n'""
base="node.sh"
description="Run an action using the current node package manager"$'\n'"Provides an abstraction to libraries to support any node package manager."$'\n'"Optionally will output the current node package manager when no arguments are passed."$'\n'""
file="bin/build/tools/node.sh"
fn="nodePackageManager"
foundNames=([0]="argument" [1]="no_argument")
no_argument="Outputs the current node package manager code name"$'\n'""
rawComment="Run an action using the current node package manager"$'\n'"Provides an abstraction to libraries to support any node package manager."$'\n'"Optionally will output the current node package manager when no arguments are passed."$'\n'"Argument: action - String. Optional. Action to perform: install run update uninstall"$'\n'"Argument: ... - Arguments. Required. Passed to the node package manager. Required. when action is provided."$'\n'"No-Argument: Outputs the current node package manager code name"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/node.sh"
sourceHash="f8eb21c84bef13ff53bace1996227ce45f26a91d"
summary="Run an action using the current node package manager"
summaryComputed="true"
usage="nodePackageManager [ action ] ..."
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mnodePackageManager'$'\e''[0m '$'\e''[[(blue)]m[ action ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m...'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]maction  '$'\e''[[(value)]mString. Optional. Action to perform: install run update uninstall'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m...     '$'\e''[[(value)]mArguments. Required. Passed to the node package manager. Required. when action is provided.'$'\e''[[(reset)]m'$'\n'''$'\n''Run an action using the current node package manager'$'\n''Provides an abstraction to libraries to support any node package manager.'$'\n''Optionally will output the current node package manager when no arguments are passed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: nodePackageManager [ action ] ...'$'\n'''$'\n''    action  String. Optional. Action to perform: install run update uninstall'$'\n''    ...     Arguments. Required. Passed to the node package manager. Required. when action is provided.'$'\n'''$'\n''Run an action using the current node package manager'$'\n''Provides an abstraction to libraries to support any node package manager.'$'\n''Optionally will output the current node package manager when no arguments are passed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
