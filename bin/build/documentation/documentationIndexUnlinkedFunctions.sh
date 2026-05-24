#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'indexPath - Directory. Required. Index path.\n--help - Flag. Optional. Display this help.\n'
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'List functions without documentation pages.\n\n'
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationIndexUnlinkedFunctions"
fnMarker="documentationindexunlinkedfunctions"
foundNames=([0]="argument")
line="405"
rawComment=$'List functions without documentation pages.\nArgument: indexPath - Directory. Required. Index path.\nArgument: --help - Flag. Optional. Display this help.\n\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/documentation.sh"
sourceHash="fa382137d00499e888f4c9bf0ffc9e1256277eb1"
sourceLine="405"
summary="List functions without documentation pages."
summaryComputed="true"
usage="documentationIndexUnlinkedFunctions indexPath [ --help ]"
