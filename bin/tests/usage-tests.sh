#!/usr/bin/env bash
#
# Copyright &copy; 2023 Market Acumen, Inc.
#
# Depends: assert.sh usage.sh
#
declare -a tests
tests+=(usageTests)

usageTests() {
    local results

    results=$(mktemp)
    cat <<EOF | usageArguments " " "" "" >"$results"
--name value is required
--value name
EOF

    assertEquals " --name [ --value ]" "$(cat "$results")"

    cat <<EOF | usageGenerator >/dev/null
    --name value
    --value name
EOF

    # usageMain usageTests 1 2 3 4 2>/dev/null || :
}

tests+=(testUsageArguments)
testUsageArguments() {
    local value testIndex=0

    IFS= read -r -d '' value <<'EOF' || :
--test^Optional thing.
variable^OptionalTHing
third^Required thing
EOF

    printf "VALUE=%s\n=====\n" "$value"

    printf "ARGS: %s\n=====\n" "$(printf %s "$value" | usageArguments "^")"
    assertContains "test" "$(printf "%s" "$value" | usageArguments "^")" "test # $testIndex" || return $?
    testIndex=$((testIndex + 1))
    assertContains "variable" "$(printf "%s" "$value" | usageArguments "^")" "test # $testIndex" || return $?
    testIndex=$((testIndex + 1))

    value="$(printf "%s\n%s\n" "--test^Optional thing." "variable^Another optional thing. newline at end")"
    printf "ARGS: %s\n=====\n" "$(printf %s "$value" | usageArguments "^")"
    assertContains "test" "$(printf "%s" "$value" | usageArguments "^")" "test # $testIndex" || return $?
    testIndex=$((testIndex + 1))
    assertContains "variable" "$(printf "%s" "$value" | usageArguments "^")" "test # $testIndex" || return $?
    testIndex=$((testIndex + 1))

    value="$(printf "%s\n%s" "--test^Optional thing." "variable^Another optional thing.")"
    printf "ARGS: %s\n=====\n" "$(printf %s "$value" | usageArguments "^")"
    assertContains "test" "$(printf "%s" "$value" | usageArguments "^")" "test # $testIndex" || return $?
    testIndex=$((testIndex + 1))
    assertContains "variable" "$(printf "%s" "$value" | usageArguments "^")" "test # $testIndex" || return $?
    testIndex=$((testIndex + 1))
}
