## `isBashBuiltin`

> Is a token a bash builtin?

### Usage

    isBashBuiltin builtin

Useful for introspection or validation - checks if a token is a bash built-in (e.g. `cd`) vs. a binary on the system (`/bin/cd`).
Implementation taken directly from the Bash man page.

### Arguments

- `builtin` - String. Required. String to check if it's a bash builtin.

### Return codes

- `0` - Yes, this string is a bash builtin command.
- `1` - No, this is not a bash builtin command

