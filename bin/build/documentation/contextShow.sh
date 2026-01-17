#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/vendor.sh"
argument="none"
base="vendor.sh"
description="Show the current editor being used as a text string"$'\n'"Return Code: 1 - If no editor or running program can be determined"$'\n'""
environment="EDITOR - Used as a default editor (first)"$'\n'"VISUAL - Used as another default editor (last)"$'\n'""
file="bin/build/tools/vendor.sh"
fn="contextShow"
foundNames=([0]="environment")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/vendor.sh"
sourceModified="1768683751"
summary="Show the current editor being used as a text string"
usage="contextShow"
