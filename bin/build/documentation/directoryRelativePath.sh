#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directory - String. A path to convert."$'\n'""
base="directory.sh"
description="Given a path to a file, compute the path back up to the top in reverse (../..)"$'\n'"If path is blank, outputs \`.\`."$'\n'""$'\n'"Essentially converts the slash \`/\` to a \`..\`, so convert your source appropriately."$'\n'""$'\n'"     directoryRelativePath \"/\" -> \"..\""$'\n'"     directoryRelativePath \"/a/b/c\" -> ../../.."$'\n'""$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryRelativePath"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/directory.sh"
sourceModified="1768756695"
stdout="Relative paths, one per line"$'\n'""
summary="Given a path to a file, compute the path back"
usage="directoryRelativePath [ directory ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdirectoryRelativePath[0m [94m[ directory ][0m

    [94mdirectory  [1;97mString. A path to convert.[0m

Given a path to a file, compute the path back up to the top in reverse (../..)
If path is blank, outputs [38;2;0;255;0;48;2;0;0;0m.[0m

Essentially converts the slash [38;2;0;255;0;48;2;0;0;0m/[0m to a [38;2;0;255;0;48;2;0;0;0m..[0m, so convert your source appropriately.

     directoryRelativePath "/" -> ".."
     directoryRelativePath "/a/b/c" -> ../../..

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Relative paths, one per line
'
# shellcheck disable=SC2016
helpPlain='Usage: directoryRelativePath [ directory ]

    directory  String. A path to convert.

Given a path to a file, compute the path back up to the top in reverse (../..)
If path is blank, outputs .

Essentially converts the slash / to a .., so convert your source appropriately.

     directoryRelativePath "/" -> ".."
     directoryRelativePath "/a/b/c" -> ../../..

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
Relative paths, one per line
'
