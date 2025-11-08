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
\.*+?^\\\.\*\+\\\?
\"quotes\"^\\"quotes\\"
Added `zesk\Doctrine\Module::dsnFromMixed`^Added `zesk\\Doctrine\\Module::dsnFromMixed`
EOF
}

testQuoteGrepPattern() {
  local handler="returnMessage"

  local temp
  temp=$(fileTemporaryName "$handler") || return $?

  local text expected
  while IFS='^' read -r text expected; do
    assertEquals --display "quoteGrepPattern \"$text\"" "$expected" "$(quoteGrepPattern "$text")" || return $?
    printf "%s\n" "$text" >"$temp"
    assertExitCode 0 grep -q -e "$(quoteGrepPattern "$text")" <"$temp" || returnUndo $? dumpPipe grepFile <"$temp" || returnUndo $? rm -f "$temp" || return $?
  done < <(__dataQuoteGrepPattern)

  catchEnvironment "$handler" rm -rf "$temp" || return $?
}
