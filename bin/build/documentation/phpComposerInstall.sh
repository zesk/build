#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-06-04
# shellcheck disable=SC2034
argument="none"
base="php-composer.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Install composer for PHP"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/php-composer.sh"
fn="phpComposerInstall"
fnMarker="phpcomposerinstall"
foundNames=()
line="102"
rawComment="Install composer for PHP"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/php-composer.sh"
sourceHash="bd1432d86d4869b148826e34d41c5e80b7226e3b"
sourceLine="102"
summary="Install composer for PHP"
summaryComputed="true"
usage="phpComposerInstall"
# shellcheck disable=SC2016
helpConsole=''$'\e''[[(label)]mUsage'$'\e''[0m: '$'\e''[[(info)]mphpComposerInstall'$'\e''[0m'$'\n'''$'\n''Install composer for PHP'$'\n'''$'\n''Return codes:'$'\n''- '$'\e''[[(code)]m0'$'\e''[[(reset)]m - Success'$'\n''- '$'\e''[[(code)]m1'$'\e''[[(reset)]m - Environment error'$'\n''- '$'\e''[[(code)]m2'$'\e''[[(reset)]m - Argument error'
# shellcheck disable=SC2016
helpPlain='Usage: phpComposerInstall'$'\n'''$'\n''Install composer for PHP'$'\n'''$'\n''Return codes:'$'\n''- 0 - Success'$'\n''- 1 - Environment error'$'\n''- 2 - Argument error'
documentationPath="documentation/source/tools/php.md"
