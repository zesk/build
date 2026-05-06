#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="pathSegment - String. Optional. Add these path segments to the HOME directory returned. Does not create them."$'\n'""
base="user.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="The current user HOME (must exist)"$'\n'"No directories *should* be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory."$'\n'""$'\n'""
descriptionLineCount="3"
file="bin/build/tools/user.sh"
fn="userHome"
fnMarker="userhome"
foundNames=([0]="argument" [1]="return_code")
line="14"
rawComment="The current user HOME (must exist)"$'\n'"Argument: pathSegment - String. Optional. Add these path segments to the HOME directory returned. Does not create them."$'\n'"No directories *should* be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory."$'\n'"Return Code: 1 - Issue with \`buildEnvironmentGet HOME\` or \$HOME is not a directory (say, it's a file)"$'\n'"Return Code: 0 - Home directory exists."$'\n'""$'\n'""
return_code="1 - Issue with \`buildEnvironmentGet HOME\` or \$HOME is not a directory (say, it's a file)"$'\n'"0 - Home directory exists."$'\n'""
sourceFile="bin/build/tools/user.sh"
sourceHash="748c273a0fe671ed2423893475bacc1706b94267"
sourceLine="14"
summary="The current user HOME (must exist)"
summaryComputed="true"
usage="userHome [ pathSegment ]"
