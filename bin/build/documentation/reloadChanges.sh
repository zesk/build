#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt-modules.sh"
argument="--source source - File. Required. Source file to source upon change."$'\n'"--name name - String. Optional. The name to call this when changes occur."$'\n'"--path path - Directory. Required. OneOrMore. A directory to scan for changes in \`.sh\` files"$'\n'"--file file - File. Required. OneOrMore. A file to watch.å"$'\n'"--stop - Flag. Optional. Stop watching changes and remove all watches."$'\n'"--show - Flag. Optional. Show watched settings and exit."$'\n'"source - File. Optional. If supplied directly on the command line, sets the source."$'\n'"path|file ... - DirectoryOrFile. Optional. If \`source\` supplied, then any other command line argument is treated as a path to scan for changes."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="prompt-modules.sh"
build_debug="reloadChanges - prompt module will show debugging information"$'\n'"reloadChangesProfile - prompt module will show profiling information"$'\n'""
description="Watch or more directories for changes in a file extension and reload a source file if any changes occur."$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="reloadChanges"
foundNames=([0]="argument" [1]="build_debug")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/prompt-modules.sh"
sourceModified="1768721469"
summary="Watch or more directories for changes in a file extension"
usage="reloadChanges --source source [ --name name ] --path path --file file [ --stop ] [ --show ] [ source ] [ path|file ... ] [ --help ]"
