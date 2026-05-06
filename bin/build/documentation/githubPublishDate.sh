#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="ownerRepository - String. Github \`owner/repository\` string"$'\n'""
base="github.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Output the publish date for the latest release of ownerRepository"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/github.sh"
fn="githubPublishDate"
fnMarker="githubpublishdate"
foundNames=([0]="argument")
line="107"
rawComment="Output the publish date for the latest release of ownerRepository"$'\n'"Argument: ownerRepository - String. Github \`owner/repository\` string"$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceHash="20111d4ebf3d141c00e6ffadada721a727fc8da2"
sourceLine="107"
summary="Output the publish date for the latest release of ownerRepository"
summaryComputed="true"
usage="githubPublishDate [ ownerRepository ]"
