#!/usr/bin/env bash
#
# documentation.sh
#
# Tools to help with documentation of shell scripts. Very simple mechanism to extract
# documentation from code. Note that bash makes a terrible template engine, but
# having no language dependencies outweighs the negatives.
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#
# Docs: o ./documentation/source/tools/markdown.md
# Test: o ./test/tools/markdown-tests.sh

# Add an indent to all markdown headings
markdownIndentHeading() {
  local usage="_${FUNCNAME[0]}"

  local direction=1

  # _IDENTICAL_ argument-case-header 5
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    [ -n "$argument" ] || __throwArgument "$usage" "blank #$__index/$__count ($(decorate each quote "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ --help 4
    --help)
      "$usage" 0
      return $?
      ;;
    *)
      # _IDENTICAL_ argumentUnknown 1
      __throwArgument "$usage" "unknown #$__index/$__count \"$argument\" ($(decorate each code "${__saved[@]}"))" || return $?
      ;;
    esac
    # _IDENTICAL_ argument-esac-shift 1
    shift
  done

  local line append

  append=$(repeat "$direction" "#")
  while IFS="" read -r line; do
    if [ "${line:0:1}" = "#" ]; then
      printf "%s\n" "$append$line"
    else
      printf "%s\n" "$line"
    fi
  done
}
_markdownIndentHeading() {
  # _IDENTICAL_ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

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
  local line section=() foundVar=false blankContent=true
  while IFS='' read -r line; do
    if [ "${line:0:1}" = "#" ]; then
      if ! $foundVar && ! $blankContent; then
        printf '%s\n' "${section[@]+${section[@]}}"
      fi
      foundVar=false
      blankContent=true
      if isMappable "$line"; then
        foundVar=true
      fi
      section=("$line")
    else
      temp="$(trimSpace "$line")"
      if [ -n "$temp" ]; then
        if isMappable "$temp"; then
          foundVar=true
        fi
        blankContent=false
      fi
      section+=("$line")
    fi
  done
  if ! $foundVar && ! $blankContent; then
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
