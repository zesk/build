# Sugar Extensions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## Usage Sugar

See [Sugar Core](_sugar.md) first.

This groupings of functions are related to a `usage` function to handle errors:

- `__usage code usageFunction command ...` - Run `command ...`, and if it fails invoke `usageFunction` with `code` and command arguments.
- `__usageEnvironment usageFunction command ...` - Run `command ...` and if it fails invoke `usageFunction` with an environment error.
- `__usageArgument usageFunction command ...` - Run `command ...` and if it fails invoke `usageFunction` with an argument error.
- `__failEnvironment usageFunction message ...` - Run `usageFunction` with an environment error and `message ...` arguments.
- `__failArgument usageFunction message ...` - Run `usageFunction` with an argument error and `message ...` arguments.

## Usage Sugar References

{__usage}
{__usageEnvironment}
{__usageArgument}
{__failEnvironment}
{__failArgument}

## Deprecated Logging

{_deprecated}

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
