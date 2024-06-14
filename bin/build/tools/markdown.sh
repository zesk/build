#!/usr/bin/env bash
#
# documentation.sh
#
# Tools to help with documentation of shell scripts. Very simple mechanism to extract
# documentation from code. Note that bash makes a terrible template engine, but
# having no language dependencies outweighs the negatives.
#
# Copyright: Copyright &copy; 2024 Market Acumen, Inc.
#
# Docs: o ./docs/_templates/tools/markdown.md
# Test: o ./test/tools/markdown-tests.sh

#
# Given a file containing Markdown, remove header and any section which has a variable still
#
# This EXPLICITLY ignores variables with a colon to work with `{SEE:other}` syntax
#
# This operates as a filter on a file. A section is any group of contiguous lines beginning with a line
# which starts with a `#` character and then continuing to but not including the next line which starts with a `#`
# character or the end of file; which corresponds roughly to headings in Markdown.
#
# If a section contains an unused variable in the form `{variable}`, the entire section is removed from the output.
#
# This can be used to remove sections which have variables or values which are optional.
#
# If you need a section to always be displayed; provide default values or blank values for the variables in those sections
# to prevent removal.
#
# Usage: markdown_removeUnfinishedSections < inputFile > outputFile
# Argument: None
# Depends: read printf
# Exit Code: 0
# Environment: None
# Example:     map.sh < $templateFile | markdown_removeUnfinishedSections
#
markdown_removeUnfinishedSections() {
  local section=() foundVar=
  while IFS= read -r line; do
    if [ "${line:0:1}" = "#" ]; then
      if ! test "$foundVar"; then
        printf '%s\n' "${section[@]+${section[@]}}"
      fi
      section=()
      foundVar=
    fi
    if [ "$line" != "$(printf "%s" "$line" | sed 's/{[^:}]*}//g')" ]; then
      foundVar=1
    fi
    section+=("$line")
  done
  if ! test $foundVar; then
    printf '%s\n' "${section[@]+${section[@]}}"
  fi
}

#
# Simple function to make list-like things more list-like in Markdown
#
# 1. remove leading "dash space" if it exists (`- `)
# 2. Semantically, if the phrase matches `[word]+[space][dash][space]`. backtick quote the `[word]`, otherwise skip
# 3. Prefix each line with a "dash space" (`- `)
#
markdown_FormatList() {
  local wordClass='[-.`_A-Za-z0-9[:space:]]' spaceClass='[[:space:]]'
  # shellcheck disable=SC2016
  sed \
    -e "s/^- //1" \
    -e "s/\`\($wordClass*\)\`${spaceClass}-${spaceClass}/\1 - /1" \
    -e "s/\($wordClass*\)${spaceClass}-${spaceClass}/- \`\1\` - /1" \
    -e "s/^\([^-]\)/- \1/1"
}
