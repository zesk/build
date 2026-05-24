#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.\n--extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.\n--next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts.\nhookName0 - one or more hook names which must exist\n'
base="hook.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Does a hook exist in the local project?\n\nCheck if one or more hook exists. All hooks must exist to succeed.\n\n'
descriptionLineCount="4"
environment=$'BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG\n'
file="bin/build/tools/hook.sh"
fn="hookExists"
fnMarker="hookexists"
foundNames=([0]="summary" [1]="argument" [2]="return_code" [3]="test" [4]="environment")
line="229"
rawComment=$'Does a hook exist in the local project?\nCheck if one or more hook exists. All hooks must exist to succeed.\nSummary: Determine if a hook exists\nArgument: --application applicationHome - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.\nArgument: --extensions extensionList - ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to `BUILD_HOOK_EXTENSIONS`.\nArgument: --next scriptName - File. Optional. Locate the script found *after* the named script, if any. Allows easy chaining of scripts.\nArgument: hookName0 - one or more hook names which must exist\nReturn Code: 0 - If all hooks exist\nTest: testHookSystem\nEnvironment: BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG\n\n'
return_code=$'0 - If all hooks exist\n'
sourceFile="bin/build/tools/hook.sh"
sourceHash="d73ad55665973abb9a6ef49bd10909b83e0cc3a0"
sourceLine="229"
summary="Determine if a hook exists"
summaryComputed=""
test=$'testHookSystem\n'
usage="hookExists [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] [ hookName0 ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mhookExists'$'\e''[0m '$'\e''[[(blue)]m[ --application applicationHome ]'$'\e''[0m '$'\e''[[(blue)]m[ --extensions extensionList ]'$'\e''[0m '$'\e''[[(blue)]m[ --next scriptName ]'$'\e''[0m '$'\e''[[(blue)]m[ hookName0 ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--application applicationHome  '$'\e''[[(value)]mPath. Optional. Directory of alternate application home. Can be specified more than once to change state.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--extensions extensionList     '$'\e''[[(value)]mColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to '$'\e''[[(code)]mBUILD_HOOK_EXTENSIONS'$'\e''[[(reset)]m.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--next scriptName              '$'\e''[[(value)]mFile. Optional. Locate the script found '$'\e''[[(cyan)]mafter'$'\e''[[(reset)]m the named script, if any. Allows easy chaining of scripts.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mhookName0                      '$'\e''[[(value)]mone or more hook names which must exist'$'\e''[[(reset)]m'$'\n'''$'\n''Does a hook exist in the local project?'$'\n'''$'\n''Check if one or more hook exists. All hooks must exist to succeed.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - If all hooks exist'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG'
# shellcheck disable=SC2016
helpPlain='Usage: hookExists [ --application applicationHome ] [ --extensions extensionList ] [ --next scriptName ] [ hookName0 ]'$'\n'''$'\n''    --application applicationHome  Path. Optional. Directory of alternate application home. Can be specified more than once to change state.'$'\n''    --extensions extensionList     ColonDelimitedList. Optional. List of extensions to search, in order for matching files in each hook directory. Defaults to BUILD_HOOK_EXTENSIONS.'$'\n''    --next scriptName              File. Optional. Locate the script found after the named script, if any. Allows easy chaining of scripts.'$'\n''    hookName0                      one or more hook names which must exist'$'\n'''$'\n''Does a hook exist in the local project?'$'\n'''$'\n''Check if one or more hook exists. All hooks must exist to succeed.'$'\n'''$'\n''Return codes:'$'\n''- 0 - If all hooks exist'$'\n'''$'\n''Environment variables:'$'\n''- BUILD_HOOK_EXTENSIONS BUILD_HOOK_DIRS BUILD_DEBUG'
documentationPath="documentation/source/tools/hook.md"
