#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="--end - Flag. Optional. End themeless mode."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="theme.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Converts decoration style to a mode where the theme can be applied later to text which is formatted."$'\n'"All decorate calls made after this call will output with special codes not to be displayed to the user."$'\n'""$'\n'""
descriptionLineCount="3"
environment="__BUILD_DECORATE"$'\n'""
file="bin/build/tools/decorate/theme.sh"
fn="decorateThemelessMode"
fnMarker="decoratethemelessmode"
foundNames=([0]="argument" [1]="environment" [2]="see")
line="13"
rawComment="Converts decoration style to a mode where the theme can be applied later to text which is formatted."$'\n'"All decorate calls made after this call will output with special codes not to be displayed to the user."$'\n'"Argument: --end - Flag. Optional. End themeless mode."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Environment: __BUILD_DECORATE"$'\n'"See: decorateThemed"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="decorateThemed"$'\n'""
sourceFile="bin/build/tools/decorate/theme.sh"
sourceHash="675e7307ac7289de1fc74a9c743b6b2ca22a3547"
sourceLine="13"
summary="Converts decoration style to a mode where the theme can"
summaryComputed="true"
usage="decorateThemelessMode [ --end ] [ --help ]"
