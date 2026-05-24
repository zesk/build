#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-24
# shellcheck disable=SC2034
argument=$'style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration\ntext ... - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for `style`.\n'
base="core.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Singular decoration function\nYou can extend this function by writing a your own extension `__decorationExtensionCustom` is called for `decorate custom`.\n\n'
descriptionLineCount="3"
environment=$'__BUILD_DECORATE - String. Cached color lookup.\nBUILD_COLORS - Boolean. Colors enabled (`true` or `false`).\n'
file="bin/build/tools/decorate/core.sh"
fn="decorate"
fnMarker="decorate"
foundNames=([0]="argument" [1]="stdout" [2]="environment" [3]="requires")
line="89"
rawComment=$'Singular decoration function\nArgument: style - String. Required. One of: reset underline no-underline bold no-bold black black-contrast blue cyan green magenta orange red white yellow code info notice success warning error subtle label value decoration\nArgument: text ... - String. Optional. Text to output. If not supplied, outputs a code to change the style to the new style. May contain arguments for `style`.\nYou can extend this function by writing a your own extension `__decorationExtensionCustom` is called for `decorate custom`.\nstdout: Decorated text\nEnvironment: __BUILD_DECORATE - String. Cached color lookup.\nEnvironment: BUILD_COLORS - Boolean. Colors enabled (`true` or `false`).\nRequires: isFunction catchArgument catchReturn awk\nRequires: bashDocumentation helpArgument\nRequires: _decorateInitialize __decorateStyle __decorate executeInputSupport\n\n'
requires=$'isFunction catchArgument catchReturn awk\nbashDocumentation helpArgument\n_decorateInitialize __decorateStyle __decorate executeInputSupport\n'
return_code=$'0 - Success\n1 - Environment error\n2 - Argument error\n'
sourceFile="bin/build/tools/decorate/core.sh"
sourceHash="e4cbe4eab5673d871026d759c95b8accc63d09fa"
sourceLine="89"
stdout=$'Decorated text\n'
summary="Singular decoration function"
summaryComputed="true"
usage="decorate style [ text ... ]"
