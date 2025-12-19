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

#
# Format environment blocks (indents as a code block)
#
_bashDocumentationFormatter_environment() {
  local items eof=false
  while ! $eof; do
    IFS=' ' read -r -d $'\n' -a items || eof=true
    [ ${#items} -gt 0 ] || continue
    local item ii=() valid=true
    for item in "${items[@]}"; do
      if $valid && environmentVariableNameValid "$item" && muzzle buildEnvironmentFiles "$item" 2>&1; then
        printf -- "%s {SEE:%s.sh}\n" "-" "$item"
      else
        valid=false
        ii+=("$item")
      fi
    done
    if [ "${#ii[@]}" -gt 0 ]; then
      printf -- "%s\n" "${ii[*]}"
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
