#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'testValue - Boolean. Required. Test value\ntrueChoice - EmptyString. Optional. Value to output when testValue is `true`\nfalseChoice - EmptyString. Optional. Value to output when testValue is `false`\n'
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Boolean selector\n\n'
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="booleanChoose"
fnMarker="booleanchoose"
foundNames=([0]="requires" [1]="argument")
line="87"
rawComment=$'Boolean selector\nRequires: isBoolean returnArgument printf\nArgument: testValue - Boolean. Required. Test value\nArgument: trueChoice - EmptyString. Optional. Value to output when testValue is `true`\nArgument: falseChoice - EmptyString. Optional. Value to output when testValue is `false`\n\n'
requires=$'isBoolean returnArgument printf\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="b337d9a2723e3b8170f5c84602d17b2e17ac26ec"
sourceLine="87"
summary="Boolean selector"
summaryComputed="true"
usage="booleanChoose testValue [ trueChoice ] [ falseChoice ]"
