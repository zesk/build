#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="apt.sh"
description="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'"Argument: --title keyTitle - String. Optional. Title of the key."$'\n'"Argument: --name keyName - String. Required. Name of the key used to generate file names."$'\n'"Argument: --url remoteUrl - URL. Required. Remote URL of gpg key."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key is installed AOK"$'\n'""
file="bin/build/tools/apt.sh"
foundNames=()
rawComment="Add keys to enable apt to download terraform directly from hashicorp.com"$'\n'"Argument: --title keyTitle - String. Optional. Title of the key."$'\n'"Argument: --name keyName - String. Required. Name of the key used to generate file names."$'\n'"Argument: --url remoteUrl - URL. Required. Remote URL of gpg key."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Return Code: 1 - if environment is awry"$'\n'"Return Code: 0 - Apt key is installed AOK"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/apt.sh"
sourceHash="4984b9c9b6822f2422dcb890964923b29cf63287"
summary="Add keys to enable apt to download terraform directly from"
usage="aptKeyAdd"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]maptKeyAdd'$'\e''[0m'$'\n'''$'\n''Add keys to enable apt to download terraform directly from hashicorp.com'$'\n''Argument: --title keyTitle - String. Optional. Title of the key.'$'\n''Argument: --name keyName - String. Required. Name of the key used to generate file names.'$'\n''Argument: --url remoteUrl - URL. Required. Remote URL of gpg key.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 1 - if environment is awry'$'\n''Return Code: 0 - Apt key is installed AOK'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: aptKeyAdd'$'\n'''$'\n''Add keys to enable apt to download terraform directly from hashicorp.com'$'\n''Argument: --title keyTitle - String. Optional. Title of the key.'$'\n''Argument: --name keyName - String. Required. Name of the key used to generate file names.'$'\n''Argument: --url remoteUrl - URL. Required. Remote URL of gpg key.'$'\n''Argument: --help - Flag. Optional. Display this help.'$'\n''Return Code: 1 - if environment is awry'$'\n''Return Code: 0 - Apt key is installed AOK'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.472
