#!/usr/bin/env bash
#
# Formatting functions for sections
#
# Copyright: Copyright &copy; 2026 Market Acumen, Inc.
#

#
# Format Return Code: blocks as a list
#
_documentationTemplateFormatter_return_code() {
  textTrimBoth | markdownFormatList
}

#
# Format requires: creates links to other functions in documentation.
#
_documentationTemplateFormatter_requires() {
  local eof=false && while ! $eof; do
    local tokens=() && IFS=" " read -d $'\n' -r -a tokens || eof=true
    [ "${#tokens[@]}" -eq 0 ] || local token && for token in "${tokens[@]}"; do
      if isFunction "$token"; then
        local f="_documentationTemplateFormatter_builtin"
        if isBashBuiltin "$token" && isFunction "$f"; then
          "$f" <<<"$token"
        else
          printf -- "{SEE:%s}\n" "$token"
        fi
      else
        printf -- "%s\n" "$token"
      fi
    done
  done | decorate wrap "- " ""
}

#
# Format see blocks as tokens
#
_documentationTemplateFormatter_see() {
  local eof=false && while ! $eof; do
    local tokens=() && IFS=" " read -d $'\n' -r -a tokens || eof=true
    [ "${#tokens[@]}" -eq 0 ] || printf "%s\n" "${tokens[@]}" | decorate wrap "{SEE:" "}" | markdownFormatList
  done
}

#
# Format usage blocks (indents as a code block)
#
_documentationTemplateFormatter_usage() {
  decorate wrap "    "
}

# Formats BUILD_DEBUG settings
#
# BUILD_DEBUG: #### Subsection
# BUILD_DEBUG:
# BUILD_DEBUG: token - description ...
# BUILD_DEBUG: token2 - description2 ...
# BUILD_DEBUG:
_documentationTemplateFormatter_build_debug() {
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
_documentationTemplateFormatter_environment() {
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
# _documentationTemplateFormatter_exampleFormat() {
#     markdownFormatList
# }
#_documentationTemplateFormatter_output() {
#  decorate wrap "    "
#}

#
# Format argument blocks (does markdownFormatList)
#
_documentationTemplateFormatter_argument() {
  markdownFormatList
}

#
# Format depends blocks (indents as a code block)
#
_documentationTemplateFormatter_depends() {
  decorate wrap "    "
}

#
# Format see block
#
_documentationTemplateFormatter_see2() {
  local seeItem seeItems
  while IFS=" " read -r -a seeItems; do
    for seeItem in "${seeItems[@]+${seeItems[@]}}"; do
      seeItem="$(textTrim "$seeItem")"
      if [ -n "$seeItem" ]; then
        printf "{SEE:%s}\n" "$seeItem"
      fi
    done
  done
}
