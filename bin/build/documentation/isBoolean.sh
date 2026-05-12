#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'--help - Flag. Optional. Display this help.\nvalue - String. Optional. Value to check if it is a boolean.\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Boolean test\nIf you want "true-ish" use `isTrue`.\nReturns 0 if `value` is boolean `false` oHar `true`.\nIs this a boolean? (`true` or `false`)\n\n'
descriptionLineCount="5"
file="bin/build/tools/_sugar.sh"
fn="isBoolean"
fnMarker="isboolean"
foundNames=([0]="return_code" [1]="see" [2]="argument" [3]="requires")
line="78"
rawComment=$'Boolean test\nIf you want "true-ish" use `isTrue`.\nReturns 0 if `value` is boolean `false` oHar `true`.\nIs this a boolean? (`true` or `false`)\nReturn Code: 0 - if value is a boolean\nReturn Code: 1 - if value is not a boolean\nSee: isTrue booleanParse\nArgument: --help - Flag. Optional. Display this help.\nArgument: value - String. Optional. Value to check if it is a boolean.\nRequires: bashDocumentation\n\n'
requires=$'bashDocumentation\n'
return_code=$'0 - if value is a boolean\n1 - if value is not a boolean\n'
see=$'isTrue booleanParse\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="78"
summary="Boolean test"
summaryComputed="true"
usage="isBoolean [ --help ] [ value ]"
