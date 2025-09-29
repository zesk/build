#!/usr/bin/env bash
#
# quote-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testEscapeSingleQuotes() {
  assertEquals "Ralph \"Dude\" Brown" "$(escapeSingleQuotes "Ralph \"Dude\" Brown")" || return $?
  # shellcheck disable=SC1003
  assertEquals 'Dude\'"'"'s place' "$(escapeSingleQuotes "Dude's place")" || return $?
}
testEscapeDoubleQuotes() {
  assertEquals "Ralph \\\"Dude\\\" Brown" "$(escapeDoubleQuotes "Ralph \"Dude\" Brown")" || return $?

  assertEquals "Dude's place" "$(escapeDoubleQuotes "Dude's place")" || return $?
}

__testUnquoteData() {
  cat <<'EOF'
' 'Hello' Hello
' 'Hello 'Hello
' Hello' Hello'
" "Hello" Hello
" "Hello "Hello
" Hello" Hello"
" "12345"""67890" 12345"""67890
boo booLoveboo Love
EOF
}

testUnquote() {
  __testUnquoteData | while read -r quote quoted unquoted; do
    assertEquals "$(unquote "$quote" "$quoted")" "$unquoted" --message "unquote \"$quote\" \"$quoted\"" || return $?
  done
}

__dataQuoteGrepPattern() {
  cat <<'EOF'
# This is a quote (hello)^# This is a quote (hello)
This | or | that.^This \| or \| that\.
[Bob]^\[Bob\]
\.*+?^\\.*+?
\"quotes\"^\\"quotes\\"
EOF
}

testQuoteGrepPattern() {
  local handler="_return"

  local temp
  temp=$(fileTemporaryName "$handler") || return $?

  local text expected
  while IFS='^' read -r text expected; do
    assertEquals "$expected" "$(quoteGrepPattern "$text")" || return $?
    printf "%s\n" "$text" >"$temp"
    assertExitCode 0 grep -q -e "$(quoteGrepPattern "$text")" <"$temp" || return $?
  done < <(__dataQuoteGrepPattern)

  __catchEnvironment "$handler" rm -rf "$temp" || return $?
}
