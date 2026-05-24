#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--clean - Flag. Optional. Erase the cache before starting.\n--template templateDirectory - Directory. Required. Location of additional documentation template files to generate documentation.\n--source sourceDirectory - Directory. Required. Location of documentation source markdown.\n--target targetDirectory - Directory. Required. Location of documentation build target.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Must faster than `documentationBuild` and intended to replace it.\n\nUses cached files at `BUILD_DOCUMENTATION_PATH`, assumes documentation cache structure:\n\n- `$docHome/functionName.md` - Markdown documentation\n- `$docHome/SEE/functionName.md` - Markdown documentation for `{SEE:functionName}`\n- `$docHome/functionName.sh` - `functionName` settings\n- `$docHome/env/environmentName.md` - Markdown documentation for `environmentName` environment variable\n- `$docHome/env/environmentName.sh` - `environmentName` environment variable settings\n- `$docHome/env/more/environmentName.md` - Additional Markdown documentation for `environmentName` environment variable\n- `$docHome/SEE/environmentName.md` - See link to `environmentName`\n\n'
descriptionLineCount="12"
file="bin/build/tools/documentation.sh"
fn="documentationMake"
fnMarker="documentationmake"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="92"
rawComment=$'Summary: Make documentation for Bash functions\nMust faster than `documentationBuild` and intended to replace it.\nUses cached files at `BUILD_DOCUMENTATION_PATH`, assumes documentation cache structure:\n- `$docHome/functionName.md` - Markdown documentation\n- `$docHome/SEE/functionName.md` - Markdown documentation for `{SEE:functionName}`\n- `$docHome/functionName.sh` - `functionName` settings\n- `$docHome/env/environmentName.md` - Markdown documentation for `environmentName` environment variable\n- `$docHome/env/environmentName.sh` - `environmentName` environment variable settings\n- `$docHome/env/more/environmentName.md` - Additional Markdown documentation for `environmentName` environment variable\n- `$docHome/SEE/environmentName.md` - See link to `environmentName`\nArgument: --clean - Flag. Optional. Erase the cache before starting.\nArgument: --template templateDirectory - Directory. Required. Location of additional documentation template files to generate documentation.\nArgument: --source sourceDirectory - Directory. Required. Location of documentation source markdown.\nArgument: --target targetDirectory - Directory. Required. Location of documentation build target.\nArgument: --help - Flag. Optional. Display this help.\nReturn Code: 0 - Success\nReturn Code: 1 - Issue with environment\nReturn Code: 2 - Argument error\n\n'
return_code=$'0 - Success\n1 - Issue with environment\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="fa382137d00499e888f4c9bf0ffc9e1256277eb1"
sourceLine="92"
summary="Make documentation for Bash functions"
summaryComputed=""
usage="documentationMake [ --clean ] --template templateDirectory --source sourceDirectory --target targetDirectory [ --help ]"
