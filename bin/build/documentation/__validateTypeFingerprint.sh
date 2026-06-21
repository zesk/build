#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-21
# shellcheck disable=SC2034
argument=$'name - Use `-` for the default hook, or pass in a hook name to use to calculate the fingerprint.\nfingerprintSpec - String. Required. The value used is the stored fingerprint path in the application JSON file. Specify `hookName:jsonPath` to specify a custom hook name for the value.\n'
base="fingerprint.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Validates an application fingerprint\nDefault hook is `application-fingerprint`.\nExample usage:\n\n    case "$argument" in\n    ...\n    --fingerprint) fingerprint=$(validate "$handler" Fingerprint "name" "hookName:jsonPath") || return "$(convertValue $? 120 0)" ;;\n    ...\n    esac\n\n    [ -z "$fingerprint" ] || fingerprint --cached "$fingerprint" --verbose\n\nThis function returns the exit return code when fingerprint matches; the calling function should return immediately with a successful exit code.\n\n'
descriptionLineCount="14"
file="bin/build/tools/fingerprint.sh"
fn="validate \"\$handler\" Fingerprint name \"fingerprintSpec\""
fnMarker="__validatetypefingerprint"
foundNames=([0]="argument" [1]="fn" [2]="return_code")
line="108"
original="__validateTypeFingerprint"
rawComment=$'Validates an application fingerprint\nArgument: name - Use `-` for the default hook, or pass in a hook name to use to calculate the fingerprint.\nArgument: fingerprintSpec - String. Required. The value used is the stored fingerprint path in the application JSON file. Specify `hookName:jsonPath` to specify a custom hook name for the value.\nDefault hook is `application-fingerprint`.\nfn: validate "$handler" Fingerprint name "fingerprintSpec"\nExample usage:\n    case "$argument" in\n    ...\n    --fingerprint) fingerprint=$(validate "$handler" Fingerprint "name" "hookName:jsonPath") || return "$(convertValue $? 120 0)" ;;\n    ...\n    esac\n    [ -z "$fingerprint" ] || fingerprint --cached "$fingerprint" --verbose\nReturn Code: 120 - Calling function should exit\nThis function returns the exit return code when fingerprint matches; the calling function should return immediately with a successful exit code.\n\n'
return_code=$'120 - Calling function should exit\n'
sourceFile="bin/build/tools/fingerprint.sh"
sourceHash="09bfb4855f1d7e37c0a2ca04a3551d8859472826"
sourceLine="108"
summary="Validates an application fingerprint"
summaryComputed="true"
usage="validate \"\$handler\" Fingerprint name \"fingerprintSpec\" [ name ] fingerprintSpec"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mvalidate "$handler" Fingerprint name "fingerprintSpec"'$'\e''[0m '$'\e''[[(blue)]m[ name ]'$'\e''[0m '$'\e''[[(bold)]m'$'\e''[[(magenta)]mfingerprintSpec'$'\e''[0m'$'\e''[0m'$'\n'''$'\n''    '$'\e''[[(blue)]mname             '$'\e''[[(value)]mUse '$'\e''[[(code)]m-'$'\e''[[(reset)]m for the default hook, or pass in a hook name to use to calculate the fingerprint.'$'\e''[[(reset)]m'$'\n''    '$'\e''[[(red)]mfingerprintSpec  '$'\e''[[(value)]mString. Required. The value used is the stored fingerprint path in the application JSON file. Specify '$'\e''[[(code)]mhookName:jsonPath'$'\e''[[(reset)]m to specify a custom hook name for the value.'$'\e''[[(reset)]m'$'\n'''$'\n''Validates an application fingerprint'$'\n''Default hook is '$'\e''[[(code)]mapplication-fingerprint'$'\e''[[(reset)]m.'$'\n''Example usage:'$'\n'''$'\n''    case "$argument" in'$'\n''    ...'$'\n''    --fingerprint) fingerprint=$(validate "$handler" Fingerprint "name" "hookName:jsonPath") || return "$(convertValue $? 120 0)" ;;'$'\n''    ...'$'\n''    esac'$'\n'''$'\n''    [ -z "$fingerprint" ] || fingerprint --cached "$fingerprint" --verbose'$'\n'''$'\n''This function returns the exit return code when fingerprint matches; the calling function should return immediately with a successful exit code.'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m120'$'\e''[[(reset)]m - Calling function should exit'
# shellcheck disable=SC2016
helpPlain='Usage: validate "$handler" Fingerprint name "fingerprintSpec" [ name ] fingerprintSpec'$'\n'''$'\n''    name             Use - for the default hook, or pass in a hook name to use to calculate the fingerprint.'$'\n''    fingerprintSpec  String. Required. The value used is the stored fingerprint path in the application JSON file. Specify hookName:jsonPath to specify a custom hook name for the value.'$'\n'''$'\n''Validates an application fingerprint'$'\n''Default hook is application-fingerprint.'$'\n''Example usage:'$'\n'''$'\n''    case "$argument" in'$'\n''    ...'$'\n''    --fingerprint) fingerprint=$(validate "$handler" Fingerprint "name" "hookName:jsonPath") || return "$(convertValue $? 120 0)" ;;'$'\n''    ...'$'\n''    esac'$'\n'''$'\n''    [ -z "$fingerprint" ] || fingerprint --cached "$fingerprint" --verbose'$'\n'''$'\n''This function returns the exit return code when fingerprint matches; the calling function should return immediately with a successful exit code.'$'\n'''$'\n''Return codes:'$'\n''- 120 - Calling function should exit'
documentationPath="documentation/source/tools/fingerprint.md"
