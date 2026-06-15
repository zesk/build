### `bashRecursionDebug`

> Recursion detection

#### Usage

    bashRecursionDebug [ --end ]

Place this in code where you suspect an infinite loop occurs.
It will fail upon a second call; to reset call with `--end`
When called twice, fails on the second invocation and dumps a call stack to stderr.

> Location: `bin/build/tools/debug.sh`

#### Arguments

- `--end` - Flag. Optional. Stop testing for recursion.

#### Return codes

- `91` - Recursion failure. Exits, actually after sleeping for 99 seconds.

#### Environment

- __BUILD_RECURSION

#### Requires

- [`printf`]({rel}/guide/builtin.md#printf)
- [`unset`]({rel}/guide/builtin.md#unset)
- [`export`]({rel}/guide/builtin.md#export)
- [debuggingStack]({rel}tools/dump.md#debuggingstack) - Dump the function and include stacks and the current environment ([source](https://github.com/zesk/build/blob/main/bin/build/tools/dump.sh#L18))[`exit`]({rel}/guide/builtin.md#exit)

