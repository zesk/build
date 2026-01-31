#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-31
# shellcheck disable=SC2034
argument="none"
base="junit.sh"
description="Full properties output. Properties are output depending on content containing a newline or not."$'\n'""
file="bin/build/tools/junit.sh"
foundNames=([0]="_example")
rawComment="Full properties output. Properties are output depending on content containing a newline or not."$'\n'" Example:     <properties>"$'\n'" Example:         <property name=\"version\" value=\"1.774\"/>"$'\n'" Example:         <property name=\"commit\" value=\"ef7bebf\"/>"$'\n'" Example:         <property name=\"browser\" value=\"Google Chrome\"/>"$'\n'" Example:         <property name=\"ci\" value=\"https://github.com/actions/runs/1234\"/>"$'\n'" Example:         <property name=\"config\">"$'\n'" Example:             Config line #1"$'\n'" Example:             Config line #2"$'\n'" Example:             Config line #3"$'\n'" Example:         </property>"$'\n'" Example:     </properties>"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="99328da6c6125bd51b64fe5c2c945dbdee764a06"
summary="Full properties output. Properties are output depending on content containing"
summaryComputed="true"
usage="junitProperties"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mjunitProperties'$'\e''[0m'$'\n'''$'\n''Full properties output. Properties are output depending on content containing a newline or not.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'$'\n'''
# shellcheck disable=SC2016
helpPlain='Usage: junitProperties'$'\n'''$'\n''Full properties output. Properties are output depending on content containing a newline or not.'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'$'\n'''
# elapsed 0.629
