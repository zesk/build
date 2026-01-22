#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="libraryRelativePath - RelativeFile. Required. Path of file to find from the home directory. Must also be executable."$'\n'"startDirectory - Directory. Optional. Place to start searching. Uses \`pwd\` if not specified."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="This function searches for a library located at the current path and searches upwards until it is found."$'\n'"A simple example is \`bin/build/tools.sh\` for this library which will generally give you an application root if this library"$'\n'"is properly installed. You can use this for any application to find a library's home directory."$'\n'""$'\n'"Note that the \`libraryRelativePath\` given must be both executable and a file."$'\n'""$'\n'""
example="    libFound=\$(bashLibraryHome \"bin/watcher/server.py\")"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashLibraryHome"
foundNames=""
libFound=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/bash.sh"
sourceModified="1769063211"
stdout="Parent path where \`libraryRelativePath\` exists"$'\n'""
summary="Output the home for a library in the parent path"$'\n'""
usage="bashLibraryHome libraryRelativePath [ startDirectory ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mbashLibraryHome[0m [38;2;255;255;0m[35;48;2;0;0;0mlibraryRelativePath[0m[0m [94m[ startDirectory ][0m [94m[ --help ][0m

    [31mlibraryRelativePath  [1;97mRelativeFile. Required. Path of file to find from the home directory. Must also be executable.[0m
    [94mstartDirectory       [1;97mDirectory. Optional. Place to start searching. Uses [38;2;0;255;0;48;2;0;0;0mpwd[0m if not specified.[0m
    [94m--help               [1;97mFlag. Optional. Display this help.[0m

This function searches for a library located at the current path and searches upwards until it is found.
A simple example is [38;2;0;255;0;48;2;0;0;0mbin/build/tools.sh[0m for this library which will generally give you an application root if this library
is properly installed. You can use this for any application to find a library'\''s home directory.

Note that the [38;2;0;255;0;48;2;0;0;0mlibraryRelativePath[0m given must be both executable and a file.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to [38;2;0;255;0;48;2;0;0;0mstdout[0m:
Parent path where [38;2;0;255;0;48;2;0;0;0mlibraryRelativePath[0m exists

Example:
    libFound=$(bashLibraryHome "bin/watcher/server.py")
'
# shellcheck disable=SC2016
helpPlain='Usage: bashLibraryHome libraryRelativePath [ startDirectory ] [ --help ]

    libraryRelativePath  RelativeFile. Required. Path of file to find from the home directory. Must also be executable.
    startDirectory       Directory. Optional. Place to start searching. Uses pwd if not specified.
    --help               Flag. Optional. Display this help.

This function searches for a library located at the current path and searches upwards until it is found.
A simple example is bin/build/tools.sh for this library which will generally give you an application root if this library
is properly installed. You can use this for any application to find a library'\''s home directory.

Note that the libraryRelativePath given must be both executable and a file.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Writes to stdout:
Parent path where libraryRelativePath exists

Example:
    libFound=$(bashLibraryHome "bin/watcher/server.py")
'
