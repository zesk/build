#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-20
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nalias - String. Required. Alias to generate.\npath - UserDirectory. Required. Project path relative to user home (or absolute)\nname - String. Optional. Project name to use\n'
base="bash.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'This creates an alias for a project:\n- `g-alias` - Change directory to this project (temporary)\n- `G-alias` - Change directory and set application home to this project (survives logout)\n\n'
descriptionLineCount="4"
file="bin/build/tools/bash.sh"
fn="bashApplicationAlias"
fnMarker="bashapplicationalias"
foundNames=([0]="summary" [1]="stdout" [2]="argument")
line="711"
original="bashApplicationAlias"
rawComment=$'Summary: Create alias for project\nThis creates an alias for a project:\n- `g-alias` - Change directory to this project (temporary)\n- `G-alias` - Change directory and set application home to this project (survives logout)\nstdout: ConsoleText\nArgument: --help - Flag. Optional. Display this help.\nArgument: alias - String. Required. Alias to generate.\nArgument: path - UserDirectory. Required. Project path relative to user home (or absolute)\nArgument: name - String. Optional. Project name to use\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/bash.sh"
sourceHash="9822477a1f3a6f53599f6f26b9aa3886ba4c5595"
sourceLine="711"
stdout=$'ConsoleText\n'
summary="Create alias for project"
summaryComputed=""
usage="bashApplicationAlias [ --help ] alias path [ name ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mbashApplicationAlias'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]malias'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mpath'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ name ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]malias   '$'\e''[[(value)]mString. Required. Alias to generate.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mpath    '$'\e''[[(value)]mUserDirectory. Required. Project path relative to user home (or absolute)'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mname    '$'\e''[[(value)]mString. Optional. Project name to use'$'\e''[[(reset)]m'$'\n'''$'\n''This creates an alias for a project:'$'\n''- '$'\e''[[(code)]mg-alias'$'\e''[[(reset)]m - Change directory to this project (temporary)'$'\n''- '$'\e''[[(code)]mG-alias'$'\e''[[(reset)]m - Change directory and set application home to this project (survives logout)'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''$'\n''Writes to '$'\e''[[(code)]mstdout'$'\e''[[(reset)]m:'$'\n''ConsoleText'
# shellcheck disable=SC2016
helpPlain='Usage: bashApplicationAlias [ --help ] alias path [ name ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    alias   String. Required. Alias to generate.'$'\n''    path    UserDirectory. Required. Project path relative to user home (or absolute)'$'\n''    name    String. Optional. Project name to use'$'\n'''$'\n''This creates an alias for a project:'$'\n''- g-alias - Change directory to this project (temporary)'$'\n''- G-alias - Change directory and set application home to this project (survives logout)'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''$'\n''Writes to stdout:'$'\n''ConsoleText'
documentationPath=""
