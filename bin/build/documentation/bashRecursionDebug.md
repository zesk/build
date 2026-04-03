## `bashRecursionDebug`

> Place this in code where you suspect an infinite loop

### Usage

    bashRecursionDebug [ --end ]

Place this in code where you suspect an infinite loop occurs
It will fail upon a second call; to reset call with `--end`
When called twice, fails on the second invocation and dumps a call stack to stderr.

### Arguments

- `--end` - Flag. Optional. Stop testing for recursion.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- __BUILD_RECURSION

### Requires

printf unset  export debuggingStack exit

