#!/usr/bin/env bash
#
# markdown-tests.sh
#
# markdown tests
#
# Copyright &copy; 2024 Market Acumen, Inc.
#

assertMarkdownFormatList() {
  assertEquals "$1" "$(printf %s "$2" | markdown_FormatList)" "markdown_FormatList \"$2\" !== \"$1\"" || return $?
}
testMarkdownFormatList() {
  # shellcheck disable=SC2016
  assertMarkdownFormatList '- `dude` - Hello' 'dude - Hello' || return $?
  # shellcheck disable=SC2016
  assertMarkdownFormatList '- `--extension extension` - A description of extension' '--extension extension - A description of extension' || return $?
  # shellcheck disable=SC2016
  assertMarkdownFormatList '- `expected` - Expected string' '- `expected` - Expected string' || return $?

  assertMarkdownFormatList '- Hello' '- Hello' || return $?
  assertMarkdownFormatList '- Hello' 'Hello' || return $?
  # shellcheck disable=SC2016
  assertMarkdownFormatList '- `--arg1` - Argument One' '--arg1 - Argument One' || return $?
}

testMarkdownRemoveSections() {
  assertEquals --line "$LINENO" "$(__dataMarkdownRemoveSections | markdown_removeUnfinishedSections)" "$(__dataMarkdownRemoveSectionsExpected)" || return $?
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
