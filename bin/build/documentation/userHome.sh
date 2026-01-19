#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/user.sh"
argument="pathSegment - String. Optional. Add these path segments to the HOME directory returned. Does not create them."$'\n'""
base="user.sh"
description="The current user HOME (must exist)"$'\n'"No directories *should* be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory."$'\n'"Return Code: 1 - Issue with \`buildEnvironmentGet HOME\` or \$HOME is not a directory (say, it's a file)"$'\n'"Return Code: 0 - Home directory exists."$'\n'""
file="bin/build/tools/user.sh"
fn="userHome"
foundNames=([0]="argument")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/user.sh"
sourceModified="1768246145"
summary="The current user HOME (must exist)"
usage="userHome [ pathSegment ]"
