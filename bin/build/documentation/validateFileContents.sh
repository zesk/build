#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-18
# shellcheck disable=SC2034
applicationFile="bin/build/tools/lint.sh"
argument="file ... - File. Required. A item to look for matches in. Use \`-\` to read file list from \`stdin\`."$'\n'"-- - Required. Separates files from text"$'\n'"text ... - Required. Text which must exist in each item"$'\n'""
base="lint.sh"
description="Search for item extensions and ensure that text is found in each item."$'\n'""$'\n'"This can be run on any directory tree to test files in any application."$'\n'""$'\n'"By default, any directory which begins with a dot \`.\` will be ignored."$'\n'""$'\n'"Side-effect: Errors written to stderr, status written to stdout"$'\n'"Return Code: 0 - All found files contain all text string or strings"$'\n'"Return Code: 1 - One or more files does not contain all text string or strings"$'\n'"Return Code: 2 - Arguments error (missing extension or text)"$'\n'""$'\n'""
example="    validateFileContents foo.sh my.sh -- \"Copyright 2024\" \"Company, LLC\""$'\n'""
file="bin/build/tools/lint.sh"
fn="validateFileContents"
foundNames=([0]="example" [1]="argument" [2]="summary")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/lint.sh"
sourceModified="1768759461"
summary="Check files for the existence of a string or strings"$'\n'""
usage="validateFileContents file ... -- text ..."
