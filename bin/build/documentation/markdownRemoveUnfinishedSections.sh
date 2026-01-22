#!/usr/bin/env bash
# Copyright &copy; 2026 Market Acumen, Inc.
# Generated on 2026-01-22
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
return_code="0 - Success"$'\n'"1 - Environment error"$'\n'"2 - Argument error"$'\n'""
sourceFile="bin/build/tools/markdown.sh"
sourceModified="1768721469"
summary="Given a file containing Markdown, remove header and any section"
usage="markdownRemoveUnfinishedSections [ None ]"
# shellcheck disable=SC2016
helpConsole='[92mUsage[0m: [38;2;170;170;255mmarkdownRemoveUnfinishedSections[0m [94m[ None ][0m

    [94mNone  [1;97mNone[0m

Given a file containing Markdown, remove header and any section which has a variable still

This EXPLICITLY ignores variables with a colon to work with [38;2;0;255;0;48;2;0;0;0m{SEE:other}[0m syntax

This operates as a filter on a file. A section is any group of contiguous lines beginning with a line
which starts with a [38;2;0;255;0;48;2;0;0;0m#[0m character and then continuing to but not including the next line which starts with a [38;2;0;255;0;48;2;0;0;0m#[0m
character or the end of file; which corresponds roughly to headings in Markdown.

If a section contains an unused variable in the form [38;2;0;255;0;48;2;0;0;0m{variable}[0m, the entire section is removed from the output.

This can be used to remove sections which have variables or values which are optional.

If you need a section to always be displayed; provide default values or blank values for the variables in those sections
to prevent removal.

Return Code: 0

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- None
- 

Example:
    markdownRemoveUnfinishedSections < inputFile > outputFile
    map.sh < $templateFile | markdownRemoveUnfinishedSections
'
# shellcheck disable=SC2016
helpPlain='Usage: markdownRemoveUnfinishedSections [ None ]

    None  None

Given a file containing Markdown, remove header and any section which has a variable still

This EXPLICITLY ignores variables with a colon to work with {SEE:other} syntax

This operates as a filter on a file. A section is any group of contiguous lines beginning with a line
which starts with a # character and then continuing to but not including the next line which starts with a #
character or the end of file; which corresponds roughly to headings in Markdown.

If a section contains an unused variable in the form {variable}, the entire section is removed from the output.

This can be used to remove sections which have variables or values which are optional.

If you need a section to always be displayed; provide default values or blank values for the variables in those sections
to prevent removal.

Return Code: 0

Return codes:
- 0 - Success
- 1 - Environment error
- 2 - Argument error
- 

Environment variables:
- None
- 

Example:
    markdownRemoveUnfinishedSections < inputFile > outputFile
    map.sh < $templateFile | markdownRemoveUnfinishedSections
'
