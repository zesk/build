#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="binary - String. Required. Binary which will exist in PATH after \`group\` is installed if it does not exist."$'\n'"group - String. Required. Package group."$'\n'""
base="package.sh"
description="Install a package group to have a binary installed"$'\n'"Any unrecognized groups are installed using the name as-is."$'\n'""
file="bin/build/tools/package.sh"
fn="packageGroupWhich"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/package.sh"
sourceModified="1769063211"
summary="Install a package group to have a binary installed"
usage="packageGroupWhich binary group"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mpackageGroupWhich[0m [38;2;255;255;0m[35;48;2;0;0;0mbinary[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mgroup[0m[0m

    [31mbinary  [1;97mString. Required. Binary which will exist in PATH after [38;2;0;255;0;48;2;0;0;0mgroup[0m is installed if it does not exist.[0m
    [31mgroup   [1;97mString. Required. Package group.[0m

Install a package group to have a binary installed
Any unrecognized groups are installed using the name as-is.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: packageGroupWhich binary group

    binary  String. Required. Binary which will exist in PATH after group is installed if it does not exist.
    group   String. Required. Package group.

Install a package group to have a binary installed
Any unrecognized groups are installed using the name as-is.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
