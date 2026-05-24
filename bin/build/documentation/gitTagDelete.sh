#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\ntag - The tag to delete locally and at origin\n'
base="git.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Delete git tag locally and at origin\n\n'
descriptionLineCount="2"
file="bin/build/tools/git.sh"
fn="gitTagDelete"
fnMarker="gittagdelete"
foundNames=([0]="argument" [1]="return_code")
line="87"
rawComment=$'Delete git tag locally and at origin\nArgument: --help - Flag. Optional. Display this help.\nArgument: tag - The tag to delete locally and at origin\nReturn Code: argument - Any stage fails will result in this exit code. Partial deletion may occur.\n\n'
return_code=$'argument - Any stage fails will result in this exit code. Partial deletion may occur.\n'
sourceFile="bin/build/tools/git.sh"
sourceHash="72d910edfadc6d7f0d48966788e271372c6d5c66"
sourceLine="87"
summary="Delete git tag locally and at origin"
summaryComputed="true"
usage="gitTagDelete [ --help ] [ tag ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitTagDelete'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ tag ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtag     '$'\e''[[(value)]mThe tag to delete locally and at origin'$'\e''[[(reset)]m'$'\n'''$'\n''Delete git tag locally and at origin'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]margument'$'\e''[[(reset)]m - Any stage fails will result in this exit code. Partial deletion may occur.'
# shellcheck disable=SC2016
helpPlain='Usage: gitTagDelete [ --help ] [ tag ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    tag     The tag to delete locally and at origin'$'\n'''$'\n''Delete git tag locally and at origin'$'\n'''$'\n''Return codes:'$'\n''- argument - Any stage fails will result in this exit code. Partial deletion may occur.'
documentationPath="documentation/source/tools/git.md"
