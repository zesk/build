# Usage Functions

## `usageGenerator` - Colorize usage arguments for output

Usage:

    usageGenerator nSpaces separatorChar labelPrefix valuePrefix < formatFile

Generates name/value pairs with the `labelPrefix` as `consoleLabel` and `valuePrefix` as `consoleValue`

- `nSpaces` - The maximum length of the label length for text formatting. Use `maximumLineLength` to compute if needed
- `separatorChar` - The character used to separate name and value in the input stream. Typically it's a space, but you can use an alternate character if your arguments need to be divided differently.
- `labelPrefix` - is a text string used to colorize the label, you can pass in `"$(consoleGreen)"` for example
- `valuePrefix` - is a text string used to colorize the value

## `usageEnvironment` - Check that environment values are set and non-blank

Usage:

    usageEnvironment env0 env1 env2 ...

If a value is not defined and non-blank, calls `usage` with exit code 1 and an error.

Example:

    usageEnvironment SMTP_URL DSN

## `usageWhich` - Check that binary executables are available via `which`

Usage:

    usageWhich binary0 binary1 binary2 ...

If a binary can not be located using `which`, calls `usage` with exit code 1 and an error.

Example:

    usageWhich git shellcheck md5sum

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)