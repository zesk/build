#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directory - Directory. Required. Test if file directory exists (file does not have to exist)"$'\n'""
base="directory.sh"
description="Does the file's directory exist?"$'\n'""$'\n'""
file="bin/build/tools/directory.sh"
fn="fileDirectoryExists"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1768756695"
summary="Does the file's directory exist?"
usage="fileDirectoryExists directory"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mfileDirectoryExists[0m [38;2;255;255;0m[35;48;2;0;0;0mdirectory[0m[0m

    [31mdirectory  [1;97mDirectory. Required. Test if file directory exists (file does not have to exist)[0m

Does the file'\''s directory exist?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: fileDirectoryExists directory

    directory  Directory. Required. Test if file directory exists (file does not have to exist)

Does the file'\''s directory exist?

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
