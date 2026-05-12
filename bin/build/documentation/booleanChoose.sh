#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-12
# shellcheck disable=SC2034
argument="testValue - Boolean. Required. Test value"$'\n'"trueChoice - EmptyString. Optional. Value to output when testValue is \`true\`"$'\n'"falseChoice - EmptyString. Optional. Value to output when testValue is \`false\`"$'\n'""
base="_sugar.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Boolean selector"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/_sugar.sh"
fn="booleanChoose"
fnMarker="booleanchoose"
foundNames=([0]="requires" [1]="argument")
line="88"
rawComment="Boolean selector"$'\n'"Requires: isBoolean returnArgument printf"$'\n'"Argument: testValue - Boolean. Required. Test value"$'\n'"Argument: trueChoice - EmptyString. Optional. Value to output when testValue is \`true\`"$'\n'"Argument: falseChoice - EmptyString. Optional. Value to output when testValue is \`false\`"$'\n'""$'\n'""
requires="isBoolean returnArgument printf"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/_sugar.sh"
sourceHash="f483140af62e442b07342b869da4ea17b676a4e1"
sourceLine="88"
summary="Boolean selector"
summaryComputed="true"
usage="booleanChoose testValue [ trueChoice ] [ falseChoice ]"
