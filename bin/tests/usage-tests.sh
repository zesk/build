#!/usr/bin/env bash
#
# Copyright &copy; 2023 Mbrket Acumen, Inc.
#
# Depends: assert.sh usage.sh
#
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
