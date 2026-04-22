#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-04-22
# shellcheck disable=SC2034
argument="--title keyTitle - String. Optional. Title of the key."$'\n'"--name keyName - String. Required. Name of the key used to generate file names."$'\n'"--url remoteUrl - URL. Required. Remote URL of gpg key."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="apt.sh"
description="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'""
file="bin/build/tools/apt.sh"
fn="aptKeyAdd"
foundNames=([0]="argument" [1]="return_code")
line="77"
lowerFn="aptkeyadd"
rawComment="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'"Argument: --title keyTitle - String. Optional. Title of the key."$'\n'"Argument: --name keyName - String. Required. Name of the key used to generate file names."$'\n'"Argument: --url remoteUrl - URL. Required. Remote URL of gpg key."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key is installed AOK"$'\n'""$'\n'""
return_code="1 - if environment is awry"$'\n'"0 - Apt key is installed AOK"$'\n'""
sourceFile="bin/build/tools/apt.sh"
sourceHash="88cf0bf4880cbbb00ac4ecc16ac7dac0654df552"
sourceLine="77"
summary="Add keys to enable apt to download terraform directly from"
summaryComputed="true"
usage="aptKeyAdd [ --title keyTitle ] --name keyName --url remoteUrl [ --help ]"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]maptKeyAdd'$'\e''[0m '$'\e''[[(blue)]m[ --title keyTitle ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--name keyName'$'\e''[0m'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]m--url remoteUrl'$'\e''[0m'$'\e''[0m '$'\e''[[(blue)]m[ --help ]'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]m--title keyTitle  '$'\e''[[(value)]mString. Optional. Title of the key.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--name keyName    '$'\e''[[(value)]mString. Required. Name of the key used to generate file names.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]m--url remoteUrl   '$'\e''[[(value)]mURL. Required. Remote URL of gpg key.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(blue)]m--help            '$'\e''[[(value)]mFlag. Optional. Display this help.'$'\e''[[(reset)]m'$'\n'''$'\n''Add keys to enable apt to download terraform directly from hashicorp.com'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - if environment is awry'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Apt key is installed AOK'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyAdd [ --title keyTitle ] --name keyName --url remoteUrl [ --help ]'$'\n'''$'\n''    --title keyTitle  String. Optional. Title of the key.'$'\n''    --name keyName    String. Required. Name of the key used to generate file names.'$'\n''    --url remoteUrl   URL. Required. Remote URL of gpg key.'$'\n''    --help            Flag. Optional. Display this help.'$'\n'''$'\n''Add keys to enable apt to download terraform directly from hashicorp.com'$'\n'''$'\n''Return codes:'$'\n''- 1 - if environment is awry'$'\n''- 0 - Apt key is installed AOK'$'\n'''
documentationPath="documentation/source/tools/apt.md"
