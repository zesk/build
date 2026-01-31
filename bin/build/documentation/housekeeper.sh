#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="debug.sh"
description="Run a command and ensure files are not modified"$'\n'"Argument: --ignore grepPattern - String. Directory. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: --path path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: callable - Callable. Optional. Program to run and watch directory before and after."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""
file="bin/build/tools/debug.sh"
foundNames=()
rawComment="Run a command and ensure files are not modified"$'\n'"Argument: --ignore grepPattern - String. Directory. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: --path path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory."$'\n'"Argument: callable - Callable. Optional. Program to run and watch directory before and after."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/debug.sh"
sourceHash="3e4ac7234593313eddb63a76e2aa170841269b82"
summary="Run a command and ensure files are not modified"
usage="housekeeper"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhousekeeper'$'\e''[0m'$'\n'''$'\n''Run a command and ensure files are not modified'$'\n''Argument: --ignore grepPattern - String. Directory. One or more directories to watch. If no directories are supplied uses current working directory.'$'\n''Argument: --path path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory.'$'\n''Argument: path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory.'$'\n''Argument: callable - Callable. Optional. Program to run and watch directory before and after.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: housekeeper'$'\n'''$'\n''Run a command and ensure files are not modified'$'\n''Argument: --ignore grepPattern - String. Directory. One or more directories to watch. If no directories are supplied uses current working directory.'$'\n''Argument: --path path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory.'$'\n''Argument: path - Directory. Optional. One or more directories to watch. If no directories are supplied uses current working directory.'$'\n''Argument: callable - Callable. Optional. Program to run and watch directory before and after.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.504
