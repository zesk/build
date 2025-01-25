# Sugar Extensions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Usage Sugar

See [Sugar Core](_sugar.md) first.

This groupings of functions are related to a `usage` function to handle errors:

- `__usage code usageFunction command ...` - Run `command ...`, and if it fails invoke `usageFunction` with `code` and command arguments.
- `__catchEnvironment usageFunction command ...` - Run `command ...` and if it fails invoke `usageFunction` with an environment error.
- `__catchArgument usageFunction command ...` - Run `command ...` and if it fails invoke `usageFunction` with an argument error.
- `__throwEnvironment usageFunction message ...` - Run `usageFunction` with an environment error and `message ...` arguments.
- `__throwArgument usageFunction message ...` - Run `usageFunction` with an argument error and `message ...` arguments.

## Usage Sugar References

{__execute}
{__usage}
{__catchEnvironment}
{__catchEnvironmentQuiet}
{__catchArgument}
{__throwEnvironment}
{__throwArgument}
{_undo}
{muzzle}

## Deprecated Logging

{_deprecated}
