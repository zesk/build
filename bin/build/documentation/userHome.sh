#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/user.sh"
argument="pathSegment - String. Optional. Add these path segments to the HOME directory returned. Does not create them."$'\n'""
base="user.sh"
description="The current user HOME (must exist)"$'\n'"No directories *should* be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory."$'\n'"Return Code: 1 - Issue with \`buildEnvironmentGet HOME\` or \$HOME is not a directory (say, it's a file)"$'\n'"Return Code: 0 - Home directory exists."$'\n'""
file="bin/build/tools/user.sh"
fn="userHome"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/user.sh"
sourceModified="1768246145"
summary="The current user HOME (must exist)"
usage="userHome [ pathSegment ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255muserHome[0m [94m[ pathSegment ][0m

    [94mpathSegment  [1;97mString. Optional. Add these path segments to the HOME directory returned. Does not create them.[0m

The current user HOME (must exist)
No directories [36mshould[0m be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory.
Return Code: 1 - Issue with [38;2;0;255;0;48;2;0;0;0mbuildEnvironmentGet HOME[0m or $HOME is not a directory (say, it'\''s a file)
Return Code: 0 - Home directory exists.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: userHome [ pathSegment ]

    pathSegment  String. Optional. Add these path segments to the HOME directory returned. Does not create them.

The current user HOME (must exist)
No directories should be created by calling this, nor should any assumptions be made about the ability to read or write files in this directory.
Return Code: 1 - Issue with buildEnvironmentGet HOME or $HOME is not a directory (say, it'\''s a file)
Return Code: 0 - Home directory exists.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
