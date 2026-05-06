#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--ignore grepPattern - String. Directory. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"--temporary temporaryPath - Directory. Optional. Use this as a temporary directory instead of the default."$'\n'"--cache cacheDirectory - Directory. Optional. Directory used to cache information between calls; if supplied for similar calls saves time in subsequent calls."$'\n'"--overhead - Flag. Optional. Report on timing used by this function."$'\n'"--path path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"callable - Callable. Optional. Program to run and watch directory before and after."$'\n'"--help - Flag. Optional. Display this help."$'\n'"--handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""
base="debug.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Run a command and ensure files are not modified"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/debug.sh"
fn="housekeeper"
fnMarker="housekeeper"
foundNames=([0]="argument")
line="397"
rawComment="Run a command and ensure files are not modified"$'\n'"Argument: --ignore grepPattern - String. Directory. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: --temporary temporaryPath - Directory. Optional. Use this as a temporary directory instead of the default."$'\n'"Argument: --cache cacheDirectory - Directory. Optional. Directory used to cache information between calls; if supplied for similar calls saves time in subsequent calls."$'\n'"Argument: --overhead - Flag. Optional. Report on timing used by this function."$'\n'"Argument: --path path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: callable - Callable. Optional. Program to run and watch directory before and after."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: --handler handler - Function. Optional. Use this error handler instead of the default error handler."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="20094ded2fe440d8caa5368a60b92d19047e793c"
sourceLine="397"
summary="Run a command and ensure files are not modified"
summaryComputed="true"
usage="housekeeper [ --ignore grepPattern ] [ --temporary temporaryPath ] [ --cache cacheDirectory ] [ --overhead ] [ --path path ] [ path ] [ callable ] [ --help ] [ --handler handler ]"
