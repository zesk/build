#!/usr/bin/env bash
#
# Formatting functions for sections
#
# Copyright: Copyright &copy; 2025 Market Acumen, Inc.
#

#
# Format code blocks (does markdown_FormatList)
#
_bashDocumentationFormatter_return_code() {
  markdown_FormatList
}

#
# Format usage blocks (indents as a code block)
#
_bashDocumentationFormatter_usage() {
  decorate wrap "    "
}

# #
# # Format example blocks (indents as a code block)
# #
# _bashDocumentationFormatter_exampleFormat() {
#     markdown_FormatList
# }
_bashDocumentationFormatter_output() {
  decorate wrap "    "
}

#
# Format argument blocks (does markdown_FormatList)
#
_bashDocumentationFormatter_argument() {
  markdown_FormatList
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
_bashDocumentationFormatter_see() {
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
