#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="--help - Flag. Optional. This help."$'\n'"--diff - Flag. Optional. Show differences between new and old files if changed."$'\n'"--local - Flag. Optional. Use local copy of \`install-bin-build.sh\` instead of downloaded version."$'\n'"path - Directory. Optional. Path to install the binary. Default is \`bin\`. If ends with \`.sh\` will name the binary this name."$'\n'"applicationHome - Directory. Optional. Path to the application home directory. Default is current directory."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Installs \`install-bin-build.sh\` the first time in a new project, and modifies it to work in the application path."$'\n'""
file="bin/build/tools/build.sh"
fn="installInstallBuild"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1768843054"
summary="Installs \`install-bin-build.sh\` the first time in a new project, and"
usage="installInstallBuild [ --help ] [ --diff ] [ --local ] [ path ] [ applicationHome ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255minstallInstallBuild[0m [94m[ --help ][0m [94m[ --diff ][0m [94m[ --local ][0m [94m[ path ][0m [94m[ applicationHome ][0m [94m[ --help ][0m

    [94m--help           [1;97mFlag. Optional. This help.[0m
    [94m--diff           [1;97mFlag. Optional. Show differences between new and old files if changed.[0m
    [94m--local          [1;97mFlag. Optional. Use local copy of [38;2;0;255;0;48;2;0;0;0minstall-bin-build.sh[0m instead of downloaded version.[0m
    [94mpath             [1;97mDirectory. Optional. Path to install the binary. Default is [38;2;0;255;0;48;2;0;0;0mbin[0m. If ends with [38;2;0;255;0;48;2;0;0;0m.sh[0m will name the binary this name.[0m
    [94mapplicationHome  [1;97mDirectory. Optional. Path to the application home directory. Default is current directory.[0m
    [94m--help           [1;97mFlag. Optional. Display this help.[0m

Installs [38;2;0;255;0;48;2;0;0;0minstall-bin-build.sh[0m the first time in a new project, and modifies it to work in the application path.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: installInstallBuild [ --help ] [ --diff ] [ --local ] [ path ] [ applicationHome ] [ --help ]

    --help           Flag. Optional. This help.
    --diff           Flag. Optional. Show differences between new and old files if changed.
    --local          Flag. Optional. Use local copy of install-bin-build.sh instead of downloaded version.
    path             Directory. Optional. Path to install the binary. Default is bin. If ends with .sh will name the binary this name.
    applicationHome  Directory. Optional. Path to the application home directory. Default is current directory.
    --help           Flag. Optional. Display this help.

Installs install-bin-build.sh the first time in a new project, and modifies it to work in the application path.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
