#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-21
# shellcheck disable=SC2034
argument="environmentName - String. Optional. Map this value only. If not specified, all environment variables are mapped."$'\n'"--prefix - String. Optional. Prefix character for tokens, defaults to \`{\`."$'\n'"--suffix - String. Optional. Suffix character for tokens, defaults to \`}\`."$'\n'"--help - Flag. Optional. Display this help."$'\n'""
base="map.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Map tokens in the input stream based on environment values with the same names."$'\n'"Converts tokens in the form \`{ENVIRONMENT_VARIABLE}\` to the associated value."$'\n'"Undefined values are not converted."$'\n'"Uses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination."$'\n'""$'\n'""
descriptionLineCount="5"
example="    printf %s \"{NAME}, {PLACE}.\\n\" | NAME=Hello PLACE=world mapEnvironment NAME PLACE"$'\n'""
file="bin/build/tools/map.sh"
fn="mapEnvironmentSed"
fnMarker="mapenvironmentsed"
foundNames=([0]="summary" [1]="todo" [2]="see" [3]="argument" [4]="example" [5]="requires")
line="323"
rawComment="Summary: Convert tokens in files to environment variable values"$'\n'"Map tokens in the input stream based on environment values with the same names."$'\n'"Converts tokens in the form \`{ENVIRONMENT_VARIABLE}\` to the associated value."$'\n'"Undefined values are not converted."$'\n'"Uses environment variables passed as arguments or entire exported environment variables are used and mapped to the destination."$'\n'"TODO: Do this like \`mapValue\`"$'\n'"See: mapValue"$'\n'"Argument: environmentName - String. Optional. Map this value only. If not specified, all environment variables are mapped."$'\n'"Argument: --prefix - String. Optional. Prefix character for tokens, defaults to \`{\`."$'\n'"Argument: --suffix - String. Optional. Suffix character for tokens, defaults to \`}\`."$'\n'"Argument: --help - Flag. Optional. Display this help."$'\n'"Example:     printf %s \"{NAME}, {PLACE}.\\n\" | NAME=Hello PLACE=world mapEnvironment NAME PLACE"$'\n'"Requires: throwArgument read environmentVariables decorate sed cat rm throwEnvironment catchEnvironment returnClean"$'\n'"Requires: validate fileTemporaryName"$'\n'""$'\n'""
requires="throwArgument read environmentVariables decorate sed cat rm throwEnvironment catchEnvironment returnClean"$'\n'"validate fileTemporaryName"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="mapValue"$'\n'""
sourceFile="bin/build/tools/map.sh"
sourceHash="28c85a1a2f0604d47009077a23130a3172acf6bf"
sourceLine="323"
summary="Convert tokens in files to environment variable values"
summaryComputed=""
todo="Do this like \`mapValue\`"$'\n'""
usage="mapEnvironmentSed [ environmentName ] [ --prefix ] [ --suffix ] [ --help ]"
