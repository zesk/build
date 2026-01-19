#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/bash.sh"
argument="libraryRelativePath - RelativeFile. Required. Path of file to find from the home directory. Must also be executable."$'\n'"startDirectory - Directory. Optional. Place to start searching. Uses \`pwd\` if not specified."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="bash.sh"
description="This function searches for a library located at the current path and searches upwards until it is found."$'\n'"A simple example is \`bin/build/tools.sh\` for this library which will generally give you an application root if this library"$'\n'"is properly installed. You can use this for any application to find a library's home directory."$'\n'""$'\n'"Note that the \`libraryRelativePath\` given must be both executable and a file."$'\n'""$'\n'""
example="    libFound=\$(bashLibraryHome \"bin/watcher/server.py\")"$'\n'""
file="bin/build/tools/bash.sh"
fn="bashLibraryHome"
foundNames=([0]="summary" [1]="argument" [2]="stdout" [3]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/bash.sh"
sourceModified="1768776883"
stdout="Parent path where \`libraryRelativePath\` exists"$'\n'""
summary="Output the home for a library in the parent path"$'\n'""
usage="bashLibraryHome libraryRelativePath [ startDirectory ] [ --help ]"
