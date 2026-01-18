#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/directory.sh"
argument="directory - String. A path to convert."$'\n'""
base="directory.sh"
BASH_LINENO=([0]="129" [1]="963" [2]="226" [3]="237" [4]="82" [5]="65" [6]="75" [7]="22" [8]="54" [9]="129" [10]="115" [11]="65" [12]="75" [13]="16" [14]="37" [15]="303" [16]="51" [17]="129" [18]="37" [19]="357" [20]="142" [21]="115" [22]="150" [23]="154" [24]="0")
description="Given a path to a file, compute the path back up to the top in reverse (../..)"$'\n'"If path is blank, outputs \`.\`."$'\n'""$'\n'"Essentially converts the slash \`/\` to a \`..\`, so convert your source appropriately."$'\n'""$'\n'"     directoryRelativePath \"/\" -> \"..\""$'\n'"     directoryRelativePath \"/a/b/c\" -> ../../.."$'\n'""$'\n'""
file="bin/build/tools/directory.sh"
fn="directoryRelativePath"
foundNames=([0]="argument" [1]="stdout")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/directory.sh"
sourceModified="1768756695"
stdout="Relative paths, one per line"$'\n'""
summary="Given a path to a file, compute the path back"
usage="directoryRelativePath [ directory ]"
