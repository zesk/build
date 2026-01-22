#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/prompt-modules.sh"
argument="--source source - File. Required. Source file to source upon change."$'\n'"--name name - String. Optional. The name to call this when changes occur."$'\n'"--path path - Directory. Required. OneOrMore. A directory to scan for changes in \`.sh\` files"$'\n'"--file file - File. Required. OneOrMore. A file to watch.å"$'\n'"--stop - Flag. Optional. Stop watching changes and remove all watches."$'\n'"--show - Flag. Optional. Show watched settings and exit."$'\n'"source - File. Optional. If supplied directly on the command line, sets the source."$'\n'"path|file ... - DirectoryOrFile. Optional. If \`source\` supplied, then any other command line argument is treated as a path to scan for changes."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="prompt-modules.sh"
build_debug="reloadChanges - prompt module will show debugging information"$'\n'"reloadChangesProfile - prompt module will show profiling information"$'\n'""
description="Watch or more directories for changes in a file extension and reload a source file if any changes occur."$'\n'""
file="bin/build/tools/prompt-modules.sh"
fn="reloadChanges"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/prompt-modules.sh"
sourceModified="1768721469"
summary="Watch or more directories for changes in a file extension"
usage="reloadChanges --source source [ --name name ] --path path --file file [ --stop ] [ --show ] [ source ] [ path|file ... ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mreloadChanges[0m [38;2;255;255;0m[35;48;2;0;0;0m--source source[0m[0m [94m[ --name name ][0m [38;2;255;255;0m[35;48;2;0;0;0m--path path[0m[0m [38;2;255;255;0m[35;48;2;0;0;0m--file file[0m[0m [94m[ --stop ][0m [94m[ --show ][0m [94m[ source ][0m [94m[ path|file ... ][0m [94m[ --help ][0m

    [31m--source source  [1;97mFile. Required. Source file to source upon change.[0m
    [94m--name name      [1;97mString. Optional. The name to call this when changes occur.[0m
    [31m--path path      [1;97mDirectory. Required. OneOrMore. A directory to scan for changes in [38;2;0;255;0;48;2;0;0;0m.sh[0m files[0m
    [31m--file file      [1;97mFile. Required. OneOrMore. A file to watch.å[0m
    [94m--stop           [1;97mFlag. Optional. Stop watching changes and remove all watches.[0m
    [94m--show           [1;97mFlag. Optional. Show watched settings and exit.[0m
    [94msource           [1;97mFile. Optional. If supplied directly on the command line, sets the source.[0m
    [94mpath|file ...    [1;97mDirectoryOrFile. Optional. If [38;2;0;255;0;48;2;0;0;0msource[0m supplied, then any other command line argument is treated as a path to scan for changes.[0m
    [94m--help           [1;97mFlag. Optional. Display this help.[0m

Watch or more directories for changes in a file extension and reload a source file if any changes occur.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

[38;2;0;255;0;48;2;0;0;0mBUILD_DEBUG[0m settings:
- reloadChanges - prompt module will show debugging information
- reloadChangesProfile - prompt module will show profiling information
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: reloadChanges --source source [ --name name ] --path path --file file [ --stop ] [ --show ] [ source ] [ path|file ... ] [ --help ]

    --source source  File. Required. Source file to source upon change.
    --name name      String. Optional. The name to call this when changes occur.
    --path path      Directory. Required. OneOrMore. A directory to scan for changes in .sh files
    --file file      File. Required. OneOrMore. A file to watch.å
    --stop           Flag. Optional. Stop watching changes and remove all watches.
    --show           Flag. Optional. Show watched settings and exit.
    source           File. Optional. If supplied directly on the command line, sets the source.
    path|file ...    DirectoryOrFile. Optional. If source supplied, then any other command line argument is treated as a path to scan for changes.
    --help           Flag. Optional. Display this help.

Watch or more directories for changes in a file extension and reload a source file if any changes occur.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

BUILD_DEBUG settings:
- reloadChanges - prompt module will show debugging information
- reloadChangesProfile - prompt module will show profiling information
- 
'
