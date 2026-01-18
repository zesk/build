#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/node.sh"
argument="--help - Flag. Optional.Display this help."$'\n'"managerName - String. Required. The node package manager name to check."$'\n'""
base="node.sh"
description="Is the passed node package manager name valid?"$'\n'"Without arguments, shows the valid package manager names."$'\n'"Return Code: 0 - Yes, it's a valid package manager name."$'\n'"Return Code: 1 - No, it's not a valid package manager name."$'\n'"Valid names are: npm yarn"$'\n'""
file="bin/build/tools/node.sh"
fn="nodePackageManagerValid"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/node.sh"
sourceModified="1768695708"
summary="Is the passed node package manager name valid?"
usage="nodePackageManagerValid [ --help ] managerName"
