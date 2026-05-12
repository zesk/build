#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-11
# shellcheck disable=SC2034
argument=$'usageFunction - Required. `bash` function already defined to output handler\nbinary - Required. Binary which must have a `which` path.\n'
base="usage.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description=$'Requires the binaries to be found via `which`\n\nRuns `handler` on failure\n\n'
descriptionLineCount="4"
file="bin/build/tools/usage.sh"
fn="executableRequire"
fnMarker="executablerequire"
foundNames=([0]="summary" [1]="argument" [2]="return_code")
line="232"
rawComment=$'Summary: Check that one or more binaries are installed\nArgument: usageFunction - Required. `bash` function already defined to output handler\nArgument: binary - Required. Binary which must have a `which` path.\nReturn Code: 1 - If any `binary` is not available within the current path\nRequires the binaries to be found via `which`\nRuns `handler` on failure\n\n'
return_code=$'1 - If any `binary` is not available within the current path\n'
sourceFile="bin/build/tools/usage.sh"
sourceHash="3291d7e64ccb36a84b9d6875ccfaa2cae11670fd"
sourceLine="232"
summary="Check that one or more binaries are installed"
summaryComputed=""
usage="executableRequire usageFunction binary"
