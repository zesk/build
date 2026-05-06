#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="none"
base="junit.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Full properties output. Properties are output depending on content containing a newline or not."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/junit.sh"
fn="junitProperties"
fnMarker="junitproperties"
foundNames=([0]="_example")
line="106"
rawComment="Full properties output. Properties are output depending on content containing a newline or not."$'\n'" Example:     <properties>"$'\n'" Example:         <property name=\"version\" value=\"1.774\"/>"$'\n'" Example:         <property name=\"commit\" value=\"ef7bebf\"/>"$'\n'" Example:         <property name=\"browser\" value=\"Google Chrome\"/>"$'\n'" Example:         <property name=\"ci\" value=\"https://github.com/actions/runs/1234\"/>"$'\n'" Example:         <property name=\"config\">"$'\n'" Example:             Config line #1"$'\n'" Example:             Config line #2"$'\n'" Example:             Config line #3"$'\n'" Example:         </property>"$'\n'" Example:     </properties>"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/junit.sh"
sourceHash="b434c2cb872c8920849edb82446bed7ed134f6d2"
sourceLine="106"
summary="Full properties output. Properties are output depending on content containing"
summaryComputed="true"
usage="junitProperties"
