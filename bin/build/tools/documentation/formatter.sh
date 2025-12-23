#!/usr/bin/env bash
#
# Formatting functions for sections
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#

#
# Format code blocks (does markdownFormatList)
#
_bashDocumentationFormatter_return_code() {
  markdownFormatList
}

#
# Format see blocks as tokens
#
_bashDocumentationFormatter_see() {
  local tokens eof=false
  while ! $eof; do
    IFS=" " read -d $'\n' -r -a tokens || eof=true
    [ "${#tokens[@]}" -eq 0 ] || printf "%s\n" "${tokens[@]}" | decorate wrap "{SEE:" "}" | markdownFormatList
  done
}

#
# Format usage blocks (indents as a code block)
#
_bashDocumentationFormatter_usage() {
  decorate wrap "    "
}

# Formats BUILD_DEBUG settings
#
# BUILD_DEBUG: #### Subsection
# BUILD_DEBUG:
# BUILD_DEBUG: token - description ...
# BUILD_DEBUG: token2 - description2 ...
# BUILD_DEBUG:
_bashDocumentationFormatter_build_debug() {
  local items=() eof=false blank=false
  while ! $eof; do
    IFS=' ' read -r -d $'\n' -a items || eof=true
    if [ ${#items[@]} -eq 0 ]; then
      if ! $blank; then
        printf -- "\n"
        blank=true
      fi
      continue
    fi
    blank=false
    set -- "${items[@]}"
    local item="$1" && shift
    if [ "${1-}" = "-" ]; then
      printf -- "- \`%s\` %s\n" "$item" "$*"
    else
      printf -- "%s\n" "$1 $*"
    fi
  done
}

#
# Format environment blocks
# Converts environment variables which appear first on a line to SEE clauses
# Once a non-token is found, rest of the line is output normally
# Blank lines are preserved but only one sequentially
_bashDocumentationFormatter_environment() {
  local items=() eof=false blank=false
  while ! $eof; do
    IFS=' ' read -r -d $'\n' -a items || eof=true
    if [ ${#items[@]} -eq 0 ]; then
      if ! $blank; then
        printf -- "\n"
        blank=true
      fi
      continue
    fi
    blank=false
    local item ii=() valid=true
    for item in "${items[@]}"; do
      if $valid && environmentVariableNameValid "$item" && muzzle buildEnvironmentFiles "$item" 2>&1; then
        ii+=("{SEE:$item.sh}")
      else
        valid=false
        ii+=("$item")
      fi
    done
    if [ "${#ii[@]}" -gt 0 ]; then
      printf -- "%s %s\n" "-" "${ii[*]}"
    fi
  done
}

# #
# # Format example blocks (indents as a code block)
# #
# _bashDocumentationFormatter_exampleFormat() {
#     markdownFormatList
# }
#_bashDocumentationFormatter_output() {
#  decorate wrap "    "
#}

#
# Format argument blocks (does markdownFormatList)
#
_bashDocumentationFormatter_argument() {
  markdownFormatList
}

#
# Format depends blocks (indents as a code block)
#
_bashDocumentationFormatter_depends() {
  decorate wrap "    "
}

#
# Format see block
#
_bashDocumentationFormatter_see2() {
  local seeItem seeItems
  while IFS=" " read -r -a seeItems; do
    for seeItem in "${seeItems[@]+${seeItems[@]}}"; do
      seeItem="$(trimSpace "$seeItem")"
      if [ -n "$seeItem" ]; then
        printf "{SEE:%s}\n" "$seeItem"
      fi
    done
  done
}
