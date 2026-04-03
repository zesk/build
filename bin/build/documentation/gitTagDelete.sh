#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-03
# shellcheck disable=SC2034
argument="--help - Flag. Optional. Display this help."$'\n'"tag - The tag to delete locally and at origin"$'\n'""
base="git.sh"
description="Delete git tag locally and at origin"$'\n'""
file="bin/build/tools/git.sh"
fn="gitTagDelete"
foundNames=([0]="argument" [1]="return_code")
rawComment="Delete git tag locally and at origin"$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Argument: tag - The tag to delete locally and at origin"$'\n'"Return Code: argument - Any stage fails will result in this exit code. Partial deletion may occur."$'\n'""$'\n'""
return_code="argument - Any stage fails will result in this exit code. Partial deletion may occur."$'\n'""
sourceFile="bin/build/tools/git.sh"
sourceHash="39d6230492936d0e156da4e32557793909dfa40b"
summary="Delete git tag locally and at origin"
summaryComputed="true"
usage="gitTagDelete [ --help ] [ tag ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mgitTagDelete'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m '$'\e''[[(blue)]m[ tag ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--help  '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]mtag     '$'\e''[[(value)]mThe tag to delete locally and at origin'$'\e''[[(reset)]m'$'\n'''$'\n''Delete git tag locally and at origin'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]margument'$'\e''[[(reset)]m - Any stage fails will result in this exit code. Partial deletion may occur.'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: gitTagDelete [ --help ] [ tag ]'$'\n'''$'\n''    --help  Flag. Optional. Display this help.'$'\n''    tag     The tag to delete locally and at origin'$'\n'''$'\n''Delete git tag locally and at origin'$'\n'''$'\n''Return codes:'$'\n''- argument - Any stage fails will result in this exit code. Partial deletion may occur.'$'\n'''
