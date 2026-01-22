#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
# shellcheck disable=SC2034
applicationFile="bin/build/tools/docker.sh"
argument="none"
base="docker.sh"
description="Fetch the default platform for docker"$'\n'"Outputs one of: \`linux/arm64\`, \`linux/mips64\`, \`linux/amd64\`"$'\n'""
file="bin/build/tools/docker.sh"
fn="dockerPlatformDefault"
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/docker.sh"
sourceModified="1768759328"
summary="Fetch the default platform for docker"
usage="dockerPlatformDefault"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mdockerPlatformDefault[0m

Fetch the default platform for docker
Outputs one of: [38;2;0;255;0;48;2;0;0;0mlinux/arm64[0m, [38;2;0;255;0;48;2;0;0;0mlinux/mips64[0m, [38;2;0;255;0;48;2;0;0;0mlinux/amd64[0m

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
# shellcheck disable=SC2016
helpPlain='Usage: dockerPlatformDefault

Fetch the default platform for docker
Outputs one of: linux/arm64, linux/mips64, linux/amd64

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 
'
