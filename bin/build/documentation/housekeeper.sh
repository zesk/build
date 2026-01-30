#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-30
# shellcheck disable=SC2034
argument="--ignore grepPattern - String. Directory. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"--path path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"callable - Callable. Optional. Program to run and watch directory before and after."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="debug.sh"
description="Run a command and ensure files are not modified"$'\n'""
file="bin/build/tools/debug.sh"
foundNames=([0]="argument")
rawComment="Run a command and ensure files are not modified"$'\n'"Argument: --ignore grepPattern - String. Directory. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: --path path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: callable - Callable. Optional. Program to run and watch directory before and after."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="f288b9b3b91991d05bd6676a6b9ef73b9e0296b8"
summary="Run a command and ensure files are not modified"
usage="housekeeper [ --ignore grepPattern ] [ --path path ] [ path ] [ callable ] [ --help ]"
