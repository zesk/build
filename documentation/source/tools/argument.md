# Argument Tools

<!-- TEMPLATE toolHeader 2 -->
[🛠️ Tools ](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

{helpArgument}

## Common argument handling

This is a work in progress and not yet ready for release.

To handle a possible `--help` ending the arguments early:

    # Argument: --help - Optional. Flag. This help.
    # Argument: --json - Optional. Flag. Output in JSON.
    # Argument: fileName - Required. FileDirectory. File to generate.
    myMagic() {
        local json fileName
        stateFile=$(_arguments "${BASH_SOURCE[0]}" "${FUNCNAME[0]}" "$@") || return "$(_argumentReturn $?)"
        # shellcheck source=/dev/null
        source "$stateFile"
        # fileName set to a valid file, json is set to true or false
        # ...
    }

{_arguments}

{_argumentReturn}

<!-- TEMPLATE toolFooter 3 -->
<hr />

[🛠️ Tools ](./index.md) &middot; [⬅ Top ](../index.md)
