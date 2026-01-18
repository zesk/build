#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/decorate.sh"
argument="style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration"$'\n'"text ... - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for \`style\`."$'\n'""
base="decorate.sh"
description="Singular decoration function"$'\n'"You can extend this function by writing a your own extension \`__decorationExtensionCustom\` is called for \`decorate custom\`."$'\n'""
environment="__BUILD_DECORATE - String. Cached color lookup."$'\n'"BUILD_COLORS - Boolean. Colors enabled (\`true\` or \`false\`)."$'\n'""
file="bin/build/tools/decorate.sh"
fn="decorate"
foundNames=([0]="argument" [1]="stdout" [2]="environment" [3]="requires")
requires="isFunction returnArgument awk catchEnvironment usageDocument executeInputSupport __help"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/decorate.sh"
sourceModified="1768721469"
stdout="Decorated text"$'\n'""
summary="Singular decoration function"
usage="decorate style [ text ... ]"
