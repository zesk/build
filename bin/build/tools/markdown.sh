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
  local handler="_${FUNCNAME[0]}"

  local direction=1

  # _IDENTICAL_ argumentNonBlankLoopHandler 6
  local __saved=("$@") __count=$#
  while [ $# -gt 0 ]; do
    local argument="$1" __index=$((__count - $# + 1))
    # __IDENTICAL__ __checkBlankArgumentHandler 1
    [ -n "$argument" ] || throwArgument "$handler" "blank #$__index/$__count ($(decorate each quote -- "${__saved[@]}"))" || return $?
    case "$argument" in
    # _IDENTICAL_ helpHandler 1
    --help) "$handler" 0 && return $? || return $? ;;
    *)
      # _IDENTICAL_ argumentUnknownHandler 1
      throwArgument "$handler" "unknown #$__index/$__count \"$argument\" ($(decorate each code -- "${__saved[@]}"))" || return $?
      ;;
    esac
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
  # __IDENTICAL__ usageDocument 1
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
# Return Code: 0
# Environment: None
# Example:     map.sh < $templateFile | markdown_removeUnfinishedSections
#
markdown_removeUnfinishedSections() {
  local line section=() foundVar=false blankContent=true
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
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
_markdown_removeUnfinishedSections() {
  true || markdown_removeUnfinishedSections --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#
# Simple function to make list-like things more list-like in Markdown
#
# 1. remove leading "dash space" if it exists (`- `)
# 2. Semantically, if the phrase matches `[word]+[space][dash][space]`. backtick quote the `[word]`, otherwise skip
# 3. Prefix each line with a "dash space" (`- `)
# stdin: reads input from stdin
# stdout: formatted markdown list
markdown_FormatList() {
  [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return "$(convertValue $? 1 0)"
  local wordClass='[-.`_A-Za-z0-9[:space:]]' spaceClass='[[:space:]]'
  # shellcheck disable=SC2016
  sed \
    -e "s/^- //1" \
    -e "s/\`\($wordClass*\)\`${spaceClass}-${spaceClass}/\1 - /1" \
    -e "s/\($wordClass*\)${spaceClass}-${spaceClass}/- \`\1\` - /1" \
    -e "s/^\([^-]\)/- \1/1"
}
_markdown_FormatList() {
  true || markdown_FormatList --help
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}
