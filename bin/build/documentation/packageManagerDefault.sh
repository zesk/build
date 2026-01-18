#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/package.sh"
argument="none"
base="package.sh"
description="Determine the default package manager on this platform."$'\n'"Output is one of:"$'\n'"- apk apt brew port"$'\n'""
file="bin/build/tools/package.sh"
fn="packageManagerDefault"
foundNames=([0]="see")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
see="platform"$'\n'""
source="bin/build/tools/package.sh"
sourceModified="1768721470"
summary="Determine the default package manager on this platform."
usage="packageManagerDefault"
