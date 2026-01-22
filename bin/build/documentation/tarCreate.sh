#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/tar.sh"
argument="target - The tar.gz file to create"$'\n'"files - A list of files to include in the tar file"$'\n'""
base="tar.sh"
description="Platform agnostic tar cfz which ignores owner and attributes"$'\n'""$'\n'"\`tar\` command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (\`.tgz\` or \`.tar.gz\`) with user and group set to 0 and no extended attributes attached to the files."$'\n'"Short description: Platform agnostic tar create which keeps user and group as user 0"$'\n'""$'\n'""
file="bin/build/tools/tar.sh"
fn="tarCreate"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/tar.sh"
sourceModified="1769063211"
summary="Platform agnostic tar cfz which ignores owner and attributes"
usage="tarCreate [ target ] [ files ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mtarCreate[0m [94m[ target ][0m [94m[ files ][0m

    [94mtarget  [1;97mThe tar.gz file to create[0m
    [94mfiles   [1;97mA list of files to include in the tar file[0m

Platform agnostic tar cfz which ignores owner and attributes

[38;2;0;255;0;48;2;0;0;0mtar[0m command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file ([38;2;0;255;0;48;2;0;0;0m.tgz[0m or [38;2;0;255;0;48;2;0;0;0m.tar.gz[0m) with user and group set to 0 and no extended attributes attached to the files.
Short description: Platform agnostic tar create which keeps user and group as user 0

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: tarCreate [ target ] [ files ]

    target  The tar.gz file to create
    files   A list of files to include in the tar file

Platform agnostic tar cfz which ignores owner and attributes

tar command is not cross-platform so this differentiates between the GNU and BSD command line arguments without needing to know what operating system you are on. Creates a gz-compressed tar file (.tgz or .tar.gz) with user and group set to 0 and no extended attributes attached to the files.
Short description: Platform agnostic tar create which keeps user and group as user 0

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
