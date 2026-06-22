#!/usr/bin/env bash
# IDENTICAL zeskBuildTestHeader 5
#
# markdown-tests.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.
#
# markdown tests
#

__markdownToConsoleTest() {
  cat <<'EOF'
# Heading 1

Intro.

## Heading 2

Section.

### Heading 3

Details.

#### Heading 4

Depth.

##### Heading 5

Deeper.

EOF
}

testMarkdownHeadingsToConsole() {
  local handler="returnMessage"

  local match=(
    "\"Heading 1\""
    "Heading 2"
    "Heading 3"
    "\"Heading 4\""
    "Heading 5"
    "Deeper"
    "Details"
    "Section"
    "Intro"
  )
  local noMatch=(
    "\"Heading 2\""
    "\"Heading 3\""
    "\"Heading 5\""
    "#"
  )
  local temp && temp=$(fileTemporaryName "$handler") || return $?

  markdownHeadingsToConsole --headings "quote:red:blue:quote:info:quote" < <(__markdownToConsoleTest) >"$temp"
  assertFileContains "$temp" "${match[@]}" || return $?
  assertFileDoesNotContain "$temp" "${noMatch[@]}" || return $?
  returnClean 0 "$temp" || return $?
}

_assertMarkdownFormatList() {
  assertEquals "$1" "$(printf %s "$2" | markdownFormatList)" "markdownFormatList \"$2\" !== \"$1\"" || return $?
}

testMarkdownFormatList() {
  # shellcheck disable=SC2016
  _assertMarkdownFormatList '- $(dude) - Hello' 'dude - Hello' || return $?
  # shellcheck disable=SC2016
  _assertMarkdownFormatList '- $(--extension extension) - A description of extension' '--extension extension - A description of extension' || return $?
  # shellcheck disable=SC2016
  _assertMarkdownFormatList '- $(expected) - Expected string' '- $(expected) - Expected string' || return $?

  _assertMarkdownFormatList '- Hello' '- Hello' || return $?
  _assertMarkdownFormatList '- Hello' 'Hello' || return $?
  # shellcheck disable=SC2016
  _assertMarkdownFormatList '- $(--arg1) - Argument One' '--arg1 - Argument One' || return $?
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
