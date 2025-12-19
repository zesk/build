#!/usr/bin/env bash
#
# markdown-tests.sh
#
# markdown tests
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

_assertMarkdownFormatList() {
  assertEquals "$1" "$(printf %s "$2" | markdownFormatList)" "markdownFormatList \"$2\" !== \"$1\"" || return $?
}
testMarkdownFormatList() {
  # shellcheck disable=SC2016
  _assertMarkdownFormatList '- `dude` - Hello' 'dude - Hello' || return $?
  # shellcheck disable=SC2016
  _assertMarkdownFormatList '- `--extension extension` - A description of extension' '--extension extension - A description of extension' || return $?
  # shellcheck disable=SC2016
  _assertMarkdownFormatList '- `expected` - Expected string' '- `expected` - Expected string' || return $?

  _assertMarkdownFormatList '- Hello' '- Hello' || return $?
  _assertMarkdownFormatList '- Hello' 'Hello' || return $?
  # shellcheck disable=SC2016
  _assertMarkdownFormatList '- `--arg1` - Argument One' '--arg1 - Argument One' || return $?
}

testMarkdownRemoveSections() {
  assertEquals "$(__dataMarkdownRemoveSections | markdownRemoveUnfinishedSections)" "$(__dataMarkdownRemoveSectionsExpected)" || return $?
}

__dataMarkdownRemoveSections() {
  cat <<'EOF'
# ABC

Hello

# DEF

World

# EFG

{token}

## Foo {token}

Content
EOF
}

__dataMarkdownRemoveSectionsExpected() {
  cat <<'EOF'
# ABC

Hello

# DEF

World

EOF
}
