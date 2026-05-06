#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-05-03
# shellcheck disable=SC2034
argument="url - URL. Required. URL to parse."$'\n'""
base="github.sh"
derivations=([0]="return_code" [1]="fn" [2]="lowerFn" [3]="fnMarker" [4]="argument" [5]="usage")
description="Parse a GitHub URL and return the owner and project name"$'\n'""$'\n'""
descriptionLineCount="2"
file="bin/build/tools/github.sh"
fn="githubURLParse"
fnMarker="githuburlparse"
foundNames=([0]="argument")
line="64"
rawComment="Parse a GitHub URL and return the owner and project name"$'\n'"Argument: url - URL. Required. URL to parse."$'\n'""$'\n'""
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/github.sh"
sourceHash="20111d4ebf3d141c00e6ffadada721a727fc8da2"
sourceLine="64"
summary="Parse a GitHub URL and return the owner and project"
summaryComputed="true"
usage="githubURLParse url"
