#!/usr/bin/env bash
#
# quote-tests.sh
#
# Copyright &copy; 2025 Market Acumen, Inc.
#

testQuoteSedPattern() {
  local value mappedValue
  # TODO
  # assertEquals "\\\\n" "$(quoteSedPattern $'\n')" || return $?
  assertEquals "\\[" "$(quoteSedPattern "[")" || return $?
  assertEquals "\\]" "$(quoteSedPattern "]")" || return $?
  # shellcheck disable=SC1003
  assertEquals '\\' "$(quoteSedPattern '\')" || return $?
  assertEquals "\\/" "$(quoteSedPattern "/")" || return $?
  # Fails in code somewhere
  value="$(__testQuoteSedPatternData)"

  mappedValue="$(name="$value" mapEnvironment <<<"{name}")"
  assertEquals "$mappedValue" "$value" || return $?
}

__testQuoteSedPatternData() {
  cat <<'EOF'
  __                  _   _
 / _|_   _ _ __   ___| |_(_) ___  _ __  ___
| |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
|  _| |_| | | | | (__| |_| | (_) | | | \__ \
|_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
EOF
}

testQuoteSedReplacement() {
  local value mappedValue
  assertEquals "\\&" "$(quoteSedReplacement "&")" || return $?
  # shellcheck disable=SC1003
  assertEquals '\\' "$(quoteSedReplacement '\')" || return $?
  # shellcheck disable=SC1003
  assertEquals '\\' "$(quoteSedReplacement '\' '~')" || return $?
  assertEquals "\\/" "$(quoteSedReplacement "/")" || return $?
  assertEquals "/" "$(quoteSedReplacement "/" "~")" || return $?
  # Fails in code somewhere
  value="$(__testQuoteSedPatternData)"

  mappedValue="$(printf %s "{name}" | name=$value mapEnvironment)"
  assertEquals "$mappedValue" "$value" || return $?
}

