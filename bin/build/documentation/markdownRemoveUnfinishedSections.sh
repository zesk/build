#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-17
# shellcheck disable=SC2034
applicationFile="bin/build/tools/markdown.sh"
argument="None"$'\n'""
base="markdown.sh"
depends="read printf"$'\n'""
description="Given a file containing Markdown, remove header and any section which has a variable still"$'\n'""$'\n'"This EXPLICITLY ignores variables with a colon to work with \`{SEE:other}\` syntax"$'\n'""$'\n'"This operates as a filter on a file. A section is any group of contiguous lines beginning with a line"$'\n'"which starts with a \`#\` character and then continuing to but not including the next line which starts with a \`#\`"$'\n'"character or the end of file; which corresponds roughly to headings in Markdown."$'\n'""$'\n'"If a section contains an unused variable in the form \`{variable}\`, the entire section is removed from the output."$'\n'""$'\n'"This can be used to remove sections which have variables or values which are optional."$'\n'""$'\n'"If you need a section to always be displayed; provide default values or blank values for the variables in those sections"$'\n'"to prevent removal."$'\n'""$'\n'"Return Code: 0"$'\n'""$'\n'""
environment="None"$'\n'""
example="    markdownRemoveUnfinishedSections < inputFile > outputFile"$'\n'"    map.sh < \$templateFile | markdownRemoveUnfinishedSections"$'\n'""
file="bin/build/tools/markdown.sh"
fn="markdownRemoveUnfinishedSections"
foundNames=([0]="argument" [1]="depends" [2]="environment" [3]="example")
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
source="bin/build/tools/markdown.sh"
sourceModified="1768683825"
summary="Given a file containing Markdown, remove header and any section"
usage="markdownRemoveUnfinishedSections [ None ]"
