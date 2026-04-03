# Oddities

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

Things which seem odd, explained.

## Weird false `--help` invocations which are never called

Talking about these:

    _isDarwin() {
        true || isDarwin --help
        # __IDENTICAL__ bashDocumentation 1
        bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

The `--help` line always evaluates to `true` and the second half of the statement NEVER runs. Why?

The code linter in our development environment will flag these as never being called with parameters in a script (which
is likely true) but the function itself actually implements argument handling; and so the the Bash shell checking script
thinks it's error [SC2120](https://www.shellcheck.net/wiki/SC2120), "foo references arguments, but none are ever
passed". Adding this adds a call to the function and eliminates the error. 

<!-- TEMPLATE guideFooter 3 -->
<hr />

[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
