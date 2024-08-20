# Common Argument Handling

This is a work in progress and not yet ready for release.

## Sample usage

To handle a possible `--help` ending the arguments early:

    # Argument: --help - Optional. Flag. This help.
    # Argument: --json - Optional. Flag. Output in JSON.
    # Argument: fileName - Required. FileDirectory. File to generate.
    myMagic() {
        local json fileName
        stateFile=$(_arguments "$bin/../bin/build/tools/text.sh" "$_mapEnvironmentGenerateSedFile" "$@") || return "$(_argumentReturn $?)"
        # shellcheck source=/dev/null
        source "$stateFile"
        # fileName set to a valid file, json is set to true or false
        # ...
    }

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `_arguments` - Generic argument parsing using Bash comments.

Generic argument parsing using Bash comments.

Argument formatting (in comments) is as follows:


`...` token means one or more arguments may be passed.

`argumentType` is one of:

- File FileDirectory Directory LoadEnvironmentFile RealDirectory
- EmptyString String
- Boolean PositiveInteger Integer UnsignedInteger Number
- Executable Callable Function
- URL

And uses the associated `usageArgument` function for validation.
Output is a temporary `stateFile` on line 1

- Location: `bin/build/tools/argument.sh`

#### Arguments

- `this` - Required. Function. Function to collect arguments for. Assume usage function is "_$this".
- `source` - Required. File. File of the function to collect the specification.
- `arguments` - Optional. String. One or more arguments to parse.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `_argumentReturn` - Handle `exit` -> 0

Handle `exit` -> 0

- Location: `bin/build/tools/argument.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
