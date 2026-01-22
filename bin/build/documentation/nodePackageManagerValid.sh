#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/node.sh"
argument="--help - Flag. Optional. Display this help."$'\n'"managerName - String. Required. The node package manager name to check."$'\n'""
base="node.sh"
description="Is the passed node package manager name valid?"$'\n'"Without arguments, shows the valid package manager names."$'\n'"Return Code: 0 - Yes, it's a valid package manager name."$'\n'"Return Code: 1 - No, it's not a valid package manager name."$'\n'"Valid names are: npm yarn"$'\n'""
file="bin/build/tools/node.sh"
fn="nodePackageManagerValid"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/node.sh"
sourceModified="1768759493"
summary="Is the passed node package manager name valid?"
usage="nodePackageManagerValid [ --help ] managerName"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mnodePackageManagerValid[0m [94m[ --help ][0m [38;2;255;255;0m[35;48;2;0;0;0mmanagerName[0m[0m

    [94m--help       [1;97mFlag. Optional. Display this help.[0m
    [31mmanagerName  [1;97mString. Required. The node package manager name to check.[0m

Is the passed node package manager name valid?
Without arguments, shows the valid package manager names.
Return Code: 0 - Yes, it'\''s a valid package manager name.
Return Code: 1 - No, it'\''s not a valid package manager name.
Valid names are: npm yarn

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: nodePackageManagerValid [ --help ] managerName

    --help       Flag. Optional. Display this help.
    managerName  String. Required. The node package manager name to check.

Is the passed node package manager name valid?
Without arguments, shows the valid package manager names.
Return Code: 0 - Yes, it'\''s a valid package manager name.
Return Code: 1 - No, it'\''s not a valid package manager name.
Valid names are: npm yarn

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
