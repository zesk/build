#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directory - Directory. Required. Directory to change to prior to running command."$'\n'"command - Callable. Required. Thing to do in this directory."$'\n'"... - Arguments. Optional. Arguments to \`command\`."$'\n'""
base="directory.sh"
description="Run a command after changing directory to it and then returning to the previous directory afterwards."$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryChange"
foundNames=""
requires="pushd popd"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1769063211"
summary="Run a command after changing directory to it and then"
usage="directoryChange directory command [ ... ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdirectoryChange[0m [38;2;255;255;0m[35;48;2;0;0;0mdirectory[0m[0m [38;2;255;255;0m[35;48;2;0;0;0mcommand[0m[0m [94m[ ... ][0m

    [31mdirectory  [1;97mDirectory. Required. Directory to change to prior to running command.[0m
    [31mcommand    [1;97mCallable. Required. Thing to do in this directory.[0m
    [94m...        [1;97mArguments. Optional. Arguments to [38;2;0;255;0;48;2;0;0;0mcommand[0m.[0m

Run a command after changing directory to it and then returning to the previous directory afterwards.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: directoryChange directory command [ ... ]

    directory  Directory. Required. Directory to change to prior to running command.
    command    Callable. Required. Thing to do in this directory.
    ...        Arguments. Optional. Arguments to command.

Run a command after changing directory to it and then returning to the previous directory afterwards.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
