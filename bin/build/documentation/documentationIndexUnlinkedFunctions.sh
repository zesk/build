#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="indexPath - Directory. Required. Index path."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="documentation.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="List functions without documentation pages."$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/documentation.sh"
fn="documentationIndexUnlinkedFunctions"
fnMarker="documentationindexunlinkedfunctions"
foundNames=([0]="argument")
line="405"
rawComment="List functions without documentation pages."$'\n'"Argument: indexPath - Directory. Required. Index path."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/documentation.sh"
sourceHash="7487e1e4be50d4eb634f007bfd41adda45ab6d68"
sourceLine="405"
summary="List functions without documentation pages."
summaryComputed="true"
usage="documentationIndexUnlinkedFunctions indexPath [ --help ]"
