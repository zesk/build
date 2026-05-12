#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'templatePath - Directory. Required. Path to the templates to repair.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Map template files using our identical functionality\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationIdenticalRepair"
fnMarker="documentationidenticalrepair"
foundNames=([0]="argument")
line="223"
rawComment=$'Map template files using our identical functionality\nArgument: templatePath - Directory. Required. Path to the templates to repair.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="0134555ea1c32d02fdc40fd9058827a280501390"
sourceLine="223"
summary="Map template files using our identical functionality"
summaryComputed="true"
usage="documentationIdenticalRepair templatePath [ --help ]"
