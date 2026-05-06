#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML \`property\` tags."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="junit.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Open tag for \`testcase\` - Test case"$'\n'""$'\n'"- \`name=testCase1\`"$'\n'"- \`classname=Tests.Registration\`"$'\n'"- \`assertions=2\`"$'\n'"- \`time=2.436\`"$'\n'"- \`file=tests/registration.code\`"$'\n'"- \`line=24\`"$'\n'""$'\n'""
descriptionLineCount="9"
example="    <testcase name=\"testCase1\" classname=\"Tests.Registration\" assertions=\"2\""$'\n'"        time=\"2.436\" file=\"tests/registration.code\" line=\"24\"/>"$'\n'""
file="bin/build/tools/junit.sh"
fn="junitTestCaseOpen"
fnMarker="junittestcaseopen"
foundNames=([0]="example" [1]="argument")
line="221"
rawComment="Open tag for \`testcase\` - Test case"$'\n'"Example:     <testcase name=\"testCase1\" classname=\"Tests.Registration\" assertions=\"2\""$'\n'"Example:         time=\"2.436\" file=\"tests/registration.code\" line=\"24\"/>"$'\n'"- \`name=testCase1\`"$'\n'"- \`classname=Tests.Registration\`"$'\n'"- \`assertions=2\`"$'\n'"- \`time=2.436\`"$'\n'"- \`file=tests/registration.code\`"$'\n'"- \`line=24\`"$'\n'"Argument: nameValue ... - Optional. String. A list of name value pairs (unquoted) to output as XML \`property\` tags."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="b434c2cb872c8920849edb82446bed7ed134f6d2"
sourceLine="221"
summary="Open tag for \`testcase\` - Test case"
summaryComputed="true"
time=""
usage="junitTestCaseOpen [ nameValue ... ] [ --help ]"
