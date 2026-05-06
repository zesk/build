#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration"$'\n'"text ... - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for \`style\`."$'\n'""
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Singular decoration function"$'\n'"You can extend this function by writing a your own extension \`__decorationExtensionCustom\` is called for \`decorate custom\`."$'\n'""$'\n'""
descriptionLineCount="3"
environment="__BUILD_DECORATE - String. Cached color lookup."$'\n'"BUILD_COLORS - Boolean. Colors enabled (\`true\` or \`false\`)."$'\n'""
file="bin/build/tools/decorate/core.sh"
fn="decorate"
fnMarker="decorate"
foundNames=([0]="argument" [1]="stdout" [2]="environment" [3]="requires")
line="89"
rawComment="Singular decoration function"$'\n'"Argument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration"$'\n'"Argument: text ... - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for \`style\`."$'\n'"You can extend this function by writing a your own extension \`__decorationExtensionCustom\` is called for \`decorate custom\`."$'\n'"stdout: Decorated text"$'\n'"Environment: __BUILD_DECORATE - String. Cached color lookup."$'\n'"Environment: BUILD_COLORS - Boolean. Colors enabled (\`true\` or \`false\`)."$'\n'"Requires: isFunction catchArgument catchReturn awk"$'\n'"Requires: bashDocumentation helpArgument"$'\n'"Requires: _decorateInitialize __decorateStyle __decorate executeInputSupport"$'\n'""$'\n'""
requires="isFunction catchArgument catchReturn awk"$'\n'"bashDocumentation helpArgument"$'\n'"_decorateInitialize __decorateStyle __decorate executeInputSupport"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="4288b1b5dd74b1f4240bb03c3728be0a51c51aa6"
sourceLine="89"
stdout="Decorated text"$'\n'""
summary="Singular decoration function"
summaryComputed="true"
usage="decorate style [ text ... ]"
