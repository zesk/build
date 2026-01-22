#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/build.sh"
argument="--diff - Flag. Optional. Show differences between new and old files if changed."$'\n'"--url - URL. Optional. A remote URL to download the installation script."$'\n'"--url-function - Callable. Optional. Fetch the remote URL where the installation script is found."$'\n'"--source - File. Required. The local copy of the \`--bin\` file."$'\n'"--local - Flag. Optional. Use local copy \`--bin\` instead of downloaded version."$'\n'"--bin - String. Required. Name of the installer file."$'\n'"path - Directory. Optional. Path to install the binary. Default is \`bin\`. If ends with \`.sh\` will name the binary this name."$'\n'"applicationHome - Directory. Optional. Path to the application home directory. Default is current directory."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="build.sh"
description="Installs an installer the first time in a new project, and modifies it to work in the application path."$'\n'""
file="bin/build/tools/build.sh"
fn="installInstallBinary"
foundNames=""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/build.sh"
sourceModified="1769063211"
summary="Installs an installer the first time in a new project,"
usage="installInstallBinary [ --diff ] [ --url ] [ --url-function ] --source [ --local ] --bin [ path ] [ applicationHome ] [ --help ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255minstallInstallBinary[0m [94m[ --diff ][0m [94m[ --url ][0m [94m[ --url-function ][0m [38;2;255;255;0m[35;48;2;0;0;0m--source[0m[0m [94m[ --local ][0m [38;2;255;255;0m[35;48;2;0;0;0m--bin[0m[0m [94m[ path ][0m [94m[ applicationHome ][0m [94m[ --help ][0m

    [94m--diff           [1;97mFlag. Optional. Show differences between new and old files if changed.[0m
    [94m--url            [1;97mURL. Optional. A remote URL to download the installation script.[0m
    [94m--url-function   [1;97mCallable. Optional. Fetch the remote URL where the installation script is found.[0m
    [31m--source         [1;97mFile. Required. The local copy of the [38;2;0;255;0;48;2;0;0;0m--bin[0m file.[0m
    [94m--local          [1;97mFlag. Optional. Use local copy [38;2;0;255;0;48;2;0;0;0m--bin[0m instead of downloaded version.[0m
    [31m--bin            [1;97mString. Required. Name of the installer file.[0m
    [94mpath             [1;97mDirectory. Optional. Path to install the binary. Default is [38;2;0;255;0;48;2;0;0;0mbin[0m. If ends with [38;2;0;255;0;48;2;0;0;0m.sh[0m will name the binary this name.[0m
    [94mapplicationHome  [1;97mDirectory. Optional. Path to the application home directory. Default is current directory.[0m
    [94m--help           [1;97mFlag. Optional. Display this help.[0m

Installs an installer the first time in a new project, and modifies it to work in the application path.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: installInstallBinary [ --diff ] [ --url ] [ --url-function ] --source [ --local ] --bin [ path ] [ applicationHome ] [ --help ]

    --diff           Flag. Optional. Show differences between new and old files if changed.
    --url            URL. Optional. A remote URL to download the installation script.
    --url-function   Callable. Optional. Fetch the remote URL where the installation script is found.
    --source         File. Required. The local copy of the --bin file.
    --local          Flag. Optional. Use local copy --bin instead of downloaded version.
    --bin            String. Required. Name of the installer file.
    path             Directory. Optional. Path to install the binary. Default is bin. If ends with .sh will name the binary this name.
    applicationHome  Directory. Optional. Path to the application home directory. Default is current directory.
    --help           Flag. Optional. Display this help.

Installs an installer the first time in a new project, and modifies it to work in the application path.

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
