#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/text.sh"
argument="none"
base="text.sh"
depends="sha1sum, /dev/random"$'\n'""
description="Outputs 40 random hexadecimal characters, lowercase."$'\n'""
example="    testPassword=\"\$(randomString)\""$'\n'""
file="bin/build/tools/text.sh"
fn="randomString"
foundNames=([0]="depends" [1]="example" [2]="output" [3]="stdout")
output="cf7861b50054e8c680a9552917b43ec2b9edae2b"$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/text.sh"
sourceModified="1768686587"
stdout="\`String\`. A random hexadecimal string."$'\n'""
summary="Outputs 40 random hexadecimal characters, lowercase."
usage="randomString"
